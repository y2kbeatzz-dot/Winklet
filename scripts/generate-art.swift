import AppKit

// Original vector-style character art for public Winklet builds.
// Generated locally during macOS CI: no third-party product photographs.
let output = CommandLine.arguments.dropFirst().first ?? "Resources"
try FileManager.default.createDirectory(atPath: output, withIntermediateDirectories: true)

func ellipse(_ rect: NSRect, color: NSColor, border: NSColor? = nil, line: CGFloat = 0) {
    let path = NSBezierPath(ovalIn: rect)
    color.setFill()
    path.fill()
    if let border = border { border.setStroke(); path.lineWidth = line; path.stroke() }
}
func rounded(_ rect: NSRect, radius: CGFloat, color: NSColor) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    color.setFill()
    path.fill()
}
func star(center: NSPoint, outer: CGFloat, inner: CGFloat) -> NSBezierPath {
    let p = NSBezierPath()
    for i in 0..<10 {
        let a = CGFloat.pi * (0.5 + CGFloat(i) / 5)
        let r = (i % 2 == 0) ? outer : inner
        let v = NSPoint(x: center.x + cos(a) * r, y: center.y + sin(a) * r)
        if i == 0 { p.move(to: v) } else { p.line(to: v) }
    }
    p.close()
    p.lineJoinStyle = .round
    return p
}
func label(_ value: String, in rect: NSRect, size: CGFloat, color: NSColor = .white) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let attrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: size, weight: .bold),
        .foregroundColor: color,
        .paragraphStyle: paragraph
    ]
    (value as NSString).draw(in: rect, withAttributes: attrs)
}
func paintedStar(back: Bool) {
    let p = star(center: NSPoint(x: 512, y: 495), outer: 440, inner: 226)
    let shadow = NSShadow()
    shadow.shadowColor = NSColor(calibratedRed: 0.51, green: 0.26, blue: 0.03, alpha: 0.55)
    shadow.shadowBlurRadius = 29
    shadow.shadowOffset = NSSize(width: 0, height: -16)
    NSGraphicsContext.saveGraphicsState()
    shadow.set()
    NSGradient(starting: NSColor(calibratedRed: 1, green: 0.92, blue: 0.33, alpha: 1),
               ending: NSColor(calibratedRed: 0.92, green: 0.59, blue: 0.04, alpha: 1))!
        .draw(in: p, angle: 75)
    NSGraphicsContext.restoreGraphicsState()
    NSColor(calibratedRed: 0.56, green: 0.35, blue: 0.04, alpha: 0.8).setStroke()
    p.lineWidth = 12
    p.stroke()
    NSColor.white.withAlphaComponent(0.28).setStroke()
    p.lineWidth = 6
    p.stroke()

    ellipse(NSRect(x: 378, y: 835, width: 267, height: 106),
            color: .clear, border: .black, line: 23)
    ellipse(NSRect(x: 378, y: 835, width: 267, height: 106),
            color: .clear, border: NSColor(calibratedWhite: 0.88, alpha: 1), line: 15)
    ellipse(NSRect(x: 392, y: 843, width: 240, height: 92),
            color: .clear, border: NSColor(calibratedWhite: 0.36, alpha: 1), line: 4)

    if back {
        ellipse(NSRect(x: 288, y: 302, width: 450, height: 410),
                color: NSColor(calibratedRed: 0.95, green: 0.68, blue: 0.11, alpha: 1),
                border: NSColor(calibratedRed: 0.68, green: 0.43, blue: 0.04, alpha: 1), line: 16)
        label("WINKLET", in: NSRect(x: 320, y: 500, width: 386, height: 52), size: 56,
              color: NSColor(calibratedRed: 0.2, green: 0.13, blue: 0.26, alpha: 1))
        label("✦   YOUR LITTLE STAR   ✦", in: NSRect(x: 315, y: 441, width: 397, height: 40),
              size: 25, color: NSColor(calibratedRed: 0.3, green: 0.2, blue: 0.29, alpha: 1))
        ellipse(NSRect(x: 480, y: 342, width: 64, height: 64),
                color: NSColor(calibratedRed: 0.21, green: 0.18, blue: 0.27, alpha: 1))
    } else {
        ellipse(NSRect(x: 318, y: 342, width: 345, height: 299),
                color: NSColor(calibratedRed: 0.09, green: 0.07, blue: 0.14, alpha: 1),
                border: NSColor(calibratedWhite: 0.38, alpha: 1), line: 12)
        ellipse(NSRect(x: 368, y: 418, width: 128, height: 146), color: .white)
        ellipse(NSRect(x: 500, y: 415, width: 127, height: 145), color: .white)
        ellipse(NSRect(x: 428, y: 455, width: 53, height: 54),
                color: NSColor(calibratedRed: 0.23, green: 0.32, blue: 1, alpha: 1))
        ellipse(NSRect(x: 556, y: 455, width: 51, height: 52),
                color: NSColor(calibratedRed: 0.23, green: 0.32, blue: 1, alpha: 1))
        ellipse(NSRect(x: 195, y: 575, width: 62, height: 62),
                color: NSColor(calibratedWhite: 0.08, alpha: 1),
                border: NSColor(calibratedWhite: 0.48, alpha: 1), line: 9)
    }
}
func save(_ name: String, size: CGFloat, render: () -> Void) throws {
    let image = NSImage(size: NSSize(width: size, height: size))
    image.lockFocus()
    NSColor.clear.setFill()
    NSRect(x: 0, y: 0, width: size, height: size).fill()
    render()
    image.unlockFocus()
    guard let data = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: data),
          let png = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "WinkletAssets", code: 1)
    }
    try png.write(to: URL(fileURLWithPath: output).appendingPathComponent(name))
}
try save("StarFront.png", size: 1024) { paintedStar(back: false) }
try save("StarBack.png", size: 1024) { paintedStar(back: true) }
try save("WinkletIcon.png", size: 1024) {
    rounded(NSRect(x: 8, y: 8, width: 1008, height: 1008), radius: 236,
            color: NSColor(calibratedRed: 0.19, green: 0.11, blue: 0.40, alpha: 1))
    NSGraphicsContext.saveGraphicsState()
    let t = AffineTransform(translationByX: 85, byY: 95)
    var transform = t
    transform.scale(0.84)
    NSAffineTransform(transform: transform).concat()
    paintedStar(back: false)
    NSGraphicsContext.restoreGraphicsState()
}
try save("MenuIcon.png", size: 1024) { paintedStar(back: false) }
print("Generated original Winklet artwork in \(output)")