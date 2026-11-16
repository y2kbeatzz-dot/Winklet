import AppKit
import SwiftUI
import Combine
import CoreImage
import AVFoundation
import UserNotifications

// Winklet — a local-only, transparent macOS desktop companion.
// The two star reference images are user-supplied. Nothing is sent over the network.

final class BuddyPreferences: ObservableObject {
    private let d = UserDefaults.standard
    @Published var buddyName: String = UserDefaults.standard.string(forKey: "buddyName") ?? "Winklet" { didSet { store() } }
    @Published var pronouns: String = UserDefaults.standard.string(forKey: "pronouns") ?? "They / Them" { didSet { store() } }
    @Published var hue: Double = (UserDefaults.standard.object(forKey: "hue") as? Double) ?? 0 { didSet { store() } }
    @Published var irisHue: Double = (UserDefaults.standard.object(forKey: "irisHue") as? Double) ?? 237 { didSet { store() } }
    @Published var size: Double = (UserDefaults.standard.object(forKey: "buddySize") as? Double) ?? 305 { didSet { store() } }
    @Published var opacity: Double = (UserDefaults.standard.object(forKey: "opacity") as? Double) ?? 1 { didSet { store() } }
    @Published var eyeStyle: String = UserDefaults.standard.string(forKey: "eyeStyle") ?? "Classic" { didSet { store() } }
    @Published var differentEyeStyles: Bool = UserDefaults.standard.bool(forKey: "differentEyeStyles") { didSet { store() } }
    @Published var leftEyeStyle: String = UserDefaults.standard.string(forKey: "leftEyeStyle") ?? "Classic" { didSet { store() } }
    @Published var rightEyeStyle: String = UserDefaults.standard.string(forKey: "rightEyeStyle") ?? "Wink" { didSet { store() } }
    @Published var eyeSize: Double = (UserDefaults.standard.object(forKey: "eyeSize") as? Double) ?? 1.0 { didSet { store() } }
    @Published var pupilSize: Double = (UserDefaults.standard.object(forKey: "pupilSize") as? Double) ?? 1.0 { didSet { store() } }
    @Published var eyeSpacing: Double = (UserDefaults.standard.object(forKey: "eyeSpacing") as? Double) ?? 1.0 { didSet { store() } }
    @Published var eyeOffsetX: Double = (UserDefaults.standard.object(forKey: "eyeOffsetX") as? Double) ?? 0 { didSet { store() } }
    @Published var eyeOffsetY: Double = (UserDefaults.standard.object(forKey: "eyeOffsetY") as? Double) ?? 0 { didSet { store() } }
    @Published var eyeGloss: Bool = (UserDefaults.standard.object(forKey: "eyeGloss") as? Bool) ?? true { didSet { store() } }
    @Published var autoReactiveEyes: Bool = (UserDefaults.standard.object(forKey: "autoReactiveEyes") as? Bool) ?? true { didSet { store() } }
    @Published var musicEyeStyle: String = UserDefaults.standard.string(forKey: "musicEyeStyle") ?? "Star" { didSet { store() } }
    @Published var chargingEyeStyle: String = UserDefaults.standard.string(forKey: "chargingEyeStyle") ?? "Happy" { didSet { store() } }
    @Published var lowBatteryEyeStyle: String = UserDefaults.standard.string(forKey: "lowBatteryEyeStyle") ?? "X_X" { didSet { store() } }
    @Published var idleEyeStyle: String = UserDefaults.standard.string(forKey: "idleEyeStyle") ?? "Sleepy" { didSet { store() } }
    @Published var glow: Bool = (UserDefaults.standard.object(forKey: "glow") as? Bool) ?? true { didSet { store() } }
    @Published var floatAnimation: Bool = (UserDefaults.standard.object(forKey: "floatAnimation") as? Bool) ?? true { didSet { store() } }
    @Published var gazeTracking: Bool = (UserDefaults.standard.object(forKey: "gazeTracking") as? Bool) ?? true { didSet { store() } }
    @Published var alwaysOnTop: Bool = (UserDefaults.standard.object(forKey: "alwaysOnTop") as? Bool) ?? false { didSet { store() } }
    @Published var allSpaces: Bool = (UserDefaults.standard.object(forKey: "allSpaces") as? Bool) ?? true { didSet { store() } }
    @Published var fullscreenOverlay: Bool = (UserDefaults.standard.object(forKey: "fullscreenOverlay") as? Bool) ?? false { didSet { store() } }
    @Published var clickThrough: Bool = (UserDefaults.standard.object(forKey: "clickThrough") as? Bool) ?? false { didSet { store() } }
    @Published var followCursor: Bool = (UserDefaults.standard.object(forKey: "followCursor") as? Bool) ?? false { didSet { store() } }
    @Published var clickReactions: Bool = (UserDefaults.standard.object(forKey: "clickReactions") as? Bool) ?? true { didSet { store() } }
    @Published var appReactions: Bool = (UserDefaults.standard.object(forKey: "appReactions") as? Bool) ?? true { didSet { store() } }
    @Published var typingReactions: Bool = (UserDefaults.standard.object(forKey: "typingReactions") as? Bool) ?? false { didSet { store() } }
    @Published var idleSleep: Bool = (UserDefaults.standard.object(forKey: "idleSleep") as? Bool) ?? true { didSet { store() } }
    @Published var batteryReactions: Bool = (UserDefaults.standard.object(forKey: "batteryReactions") as? Bool) ?? true { didSet { store() } }
    @Published var batteryLowLevel: Double = (UserDefaults.standard.object(forKey: "batteryLowLevel") as? Double) ?? 20 { didSet { store() } }
    @Published var batteryNotify: Bool = (UserDefaults.standard.object(forKey: "batteryNotify") as? Bool) ?? false { didSet { store() } }
    @Published var batteryConnectionReactions: Bool = (UserDefaults.standard.object(forKey: "batteryConnectionReactions") as? Bool) ?? true { didSet { store() } }
    @Published var batteryPercentBubbles: Bool = (UserDefaults.standard.object(forKey: "batteryPercentBubbles") as? Bool) ?? true { didSet { store() } }
    @Published var musicReactions: Bool = (UserDefaults.standard.object(forKey: "musicReactions") as? Bool) ?? true { didSet { store() } }
    @Published var musicApple: Bool = (UserDefaults.standard.object(forKey: "musicApple") as? Bool) ?? true { didSet { store() } }
    @Published var musicSpotify: Bool = (UserDefaults.standard.object(forKey: "musicSpotify") as? Bool) ?? true { didSet { store() } }
    @Published var musicDance: Bool = (UserDefaults.standard.object(forKey: "musicDance") as? Bool) ?? true { didSet { store() } }
    @Published var danceStyle: String = UserDefaults.standard.string(forKey: "danceStyle") ?? "Bop" { didSet { store() } }
    @Published var danceIntensity: Double = (UserDefaults.standard.object(forKey: "danceIntensity") as? Double) ?? 0.8 { didSet { store() } }
    @Published var showSongTitles: Bool = (UserDefaults.standard.object(forKey: "showSongTitles") as? Bool) ?? true { didSet { store() } }
    @Published var showNowPlayingCard: Bool = (UserDefaults.standard.object(forKey: "showNowPlayingCard") as? Bool) ?? true { didSet { store() } }
    @Published var upsideDown: Bool = (UserDefaults.standard.object(forKey: "upsideDown") as? Bool) ?? false { didSet { store() } }
    @Published var soundEffects: Bool = (UserDefaults.standard.object(forKey: "soundEffects") as? Bool) ?? false { didSet { store() } }
    @Published var microphoneReactions: Bool = (UserDefaults.standard.object(forKey: "microphoneReactions") as? Bool) ?? false { didSet { store() } }
    @Published var soundSensitivity: Double = (UserDefaults.standard.object(forKey: "soundSensitivity") as? Double) ?? 0.55 { didSet { store() } }
    @Published var saturation: Double = (UserDefaults.standard.object(forKey: "saturation") as? Double) ?? 1.0 { didSet { store() } }
    @Published var brightness: Double = (UserDefaults.standard.object(forKey: "brightness") as? Double) ?? 0.0 { didSet { store() } }
    @Published var motionStrength: Double = (UserDefaults.standard.object(forKey: "motionStrength") as? Double) ?? 1.0 { didSet { store() } }
    @Published var blinkInterval: Double = (UserDefaults.standard.object(forKey: "blinkInterval") as? Double) ?? 4.0 { didSet { store() } }
    @Published var clickChance: Double = (UserDefaults.standard.object(forKey: "clickChance") as? Double) ?? 0.45 { didSet { store() } }
    @Published var speechBubbles: Bool = (UserDefaults.standard.object(forKey: "speechBubbles") as? Bool) ?? true { didSet { store() } }
    @Published var napMode: Bool = (UserDefaults.standard.object(forKey: "napMode") as? Bool) ?? false { didSet { store() } }
    @Published var snapToEdges: Bool = (UserDefaults.standard.object(forKey: "snapToEdges") as? Bool) ?? false { didSet { store() } }
    @Published var showDockIcon: Bool = (UserDefaults.standard.object(forKey: "showDockIcon") as? Bool) ?? false { didSet { store() } }
    @Published var startAtLogin: Bool = (UserDefaults.standard.object(forKey: "startAtLogin") as? Bool) ?? false { didSet { store() } }

    private func store() {
        let values: [String: Any] = [
            "buddyName": buddyName, "pronouns": pronouns, "hue": hue, "irisHue": irisHue,
            "buddySize": size, "opacity": opacity, "eyeStyle": eyeStyle, "glow": glow,
            "differentEyeStyles": differentEyeStyles, "leftEyeStyle": leftEyeStyle,
            "rightEyeStyle": rightEyeStyle, "eyeSize": eyeSize, "pupilSize": pupilSize,
            "eyeSpacing": eyeSpacing, "eyeOffsetX": eyeOffsetX, "eyeOffsetY": eyeOffsetY,
            "eyeGloss": eyeGloss, "autoReactiveEyes": autoReactiveEyes,
            "musicEyeStyle": musicEyeStyle, "chargingEyeStyle": chargingEyeStyle,
            "lowBatteryEyeStyle": lowBatteryEyeStyle, "idleEyeStyle": idleEyeStyle,
            "floatAnimation": floatAnimation, "gazeTracking": gazeTracking, "alwaysOnTop": alwaysOnTop,
            "allSpaces": allSpaces, "fullscreenOverlay": fullscreenOverlay, "clickThrough": clickThrough,
            "followCursor": followCursor, "clickReactions": clickReactions, "appReactions": appReactions,
            "typingReactions": typingReactions, "idleSleep": idleSleep,
            "batteryReactions": batteryReactions, "batteryLowLevel": batteryLowLevel,
            "batteryNotify": batteryNotify,
            "batteryConnectionReactions": batteryConnectionReactions,
            "batteryPercentBubbles": batteryPercentBubbles,
            "musicReactions": musicReactions,
            "musicApple": musicApple, "musicSpotify": musicSpotify,
            "musicDance": musicDance, "danceStyle": danceStyle,
            "danceIntensity": danceIntensity, "showSongTitles": showSongTitles,
            "showNowPlayingCard": showNowPlayingCard,
            "upsideDown": upsideDown,
            "soundEffects": soundEffects, "startAtLogin": startAtLogin,
            "microphoneReactions": microphoneReactions, "soundSensitivity": soundSensitivity,
            "saturation": saturation, "brightness": brightness, "motionStrength": motionStrength,
            "blinkInterval": blinkInterval, "clickChance": clickChance, "speechBubbles": speechBubbles,
            "napMode": napMode, "snapToEdges": snapToEdges, "showDockIcon": showDockIcon
        ]
        for (key, value) in values { d.set(value, forKey: key) }
    }

    func resetLook() {
        hue = 0; irisHue = 237; size = 305; opacity = 1; eyeStyle = "Classic"
        differentEyeStyles = false; leftEyeStyle = "Classic"; rightEyeStyle = "Wink"
        eyeSize = 1; pupilSize = 1; eyeSpacing = 1; eyeOffsetX = 0; eyeOffsetY = 0
        eyeGloss = true; autoReactiveEyes = true
        musicEyeStyle = "Star"; chargingEyeStyle = "Happy"
        lowBatteryEyeStyle = "X_X"; idleEyeStyle = "Sleepy"
        glow = true; floatAnimation = true; saturation = 1; brightness = 0; motionStrength = 1; blinkInterval = 4
    }
}

enum EyeStyle: String, CaseIterable, Identifiable {
    case classic = "Classic", wide = "Wide", tiny = "Tiny", pixel = "Pixel"
    case sleepy = "Sleepy", happy = "Happy", heart = "Heart", star = "Star"
    case spiral = "Spiral", wink = "Wink", dazed = "X_X", bigCute = "Big Cute"
    case focused = "Focused", anime = "Anime", alien = "Alien", rainbow = "Rainbow"
    var id: String { rawValue }
    static func from(_ raw: String) -> EyeStyle { EyeStyle(rawValue: raw) ?? .classic }
}

final class NowPlayingModel: ObservableObject {
    @Published var title = ""
    @Published var artist = ""
    @Published var album = ""
    @Published var source = ""
    @Published var playing = false
}

// A separate wide card keeps the *entire* song title, artist, and album readable.
// No 19-character cutoff, no automatic ellipses; extra-long text can scroll.
struct NowPlayingCard: View {
    @ObservedObject var model: NowPlayingModel
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "music.note")
                    Text(model.source.isEmpty ? "NOW PLAYING" : "NOW PLAYING · \(model.source)")
                    Spacer(minLength: 4)
                    Image(systemName: "waveform")
                }
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                Text(model.title.isEmpty ? "Unknown song" : model.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                if !model.artist.isEmpty {
                    Text(model.artist)
                        .font(.system(size: 14, weight: .medium))
                        .fixedSize(horizontal: false, vertical: true)
                }
                if !model.album.isEmpty {
                    Text(model.album)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .frame(width: 410)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(.white.opacity(0.20)))
        .padding(3)
    }
}

enum BuddyMood {
    case normal, happy, surprise, curious, sleepy, typing, music, charging, lowBattery
}

final class BuddyPanel: NSPanel {
    override var canBecomeKey: Bool { false }
    override var canBecomeMain: Bool { false }
}

final class BuddyView: NSView {
    let prefs: BuddyPreferences
    weak var controller: BuddyAppDelegate?
    private let ciContext = CIContext(options: [.useSoftwareRenderer: false])
    private var front: NSImage?
    private var back: NSImage?
    private var lastHue: Double = .infinity
    private var lastSaturation: Double = .infinity
    private var lastBrightness: Double = .infinity
    private var startPoint: NSPoint = .zero
    private var windowStart: NSPoint = .zero
    private var dragged = false
    private var nextBlink = Date.timeIntervalSinceReferenceDate + 2.0
    private var blinkEnd = 0.0
    var lastActivity = Date.timeIntervalSinceReferenceDate
    private var moodEnd = 0.0
    private(set) var mood: BuddyMood = .normal
    private var backUntil = 0.0
    private var reactionText = ""
    private var reactionUntil = 0.0
    var gazeX: CGFloat = 0
    var gazeY: CGFloat = 0
    var isMusicPlaying = false
    var musicSource = ""
    var batteryIsLow = false
    private var musicTitle = ""

    // Native AppKit views use a bottom-left origin. The image is painted upright
    // in that coordinate system; we flip only the vector FACE coordinates below.
    // Previously this entire view was flipped, which inverted the CI-generated image.
    override var isFlipped: Bool { false }
    override var acceptsFirstResponder: Bool { true }

    init(prefs: BuddyPreferences) {
        self.prefs = prefs
        super.init(frame: NSRect(x: 0, y: 0, width: 305, height: 305))
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor
        refreshImages()
    }

    required init?(coder: NSCoder) { fatalError("Programmatic view only") }

    func refreshImages() {
        if front == nil || abs(lastHue - prefs.hue) > 0.05 ||
            abs(lastSaturation - prefs.saturation) > 0.005 ||
            abs(lastBrightness - prefs.brightness) > 0.005 {
            front = hueImage(named: "StarFront", degrees: prefs.hue)
            back = hueImage(named: "StarBack", degrees: prefs.hue)
            lastHue = prefs.hue
            lastSaturation = prefs.saturation
            lastBrightness = prefs.brightness
        }
        needsDisplay = true
    }

    private func hueImage(named name: String, degrees: Double) -> NSImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "png"),
              let input = CIImage(contentsOf: url),
              let filter = CIFilter(name: "CIHueAdjust") else {
            return NSImage(named: NSImage.Name(name))
        }
        filter.setValue(input, forKey: kCIInputImageKey)
        filter.setValue(degrees * .pi / 180.0, forKey: kCIInputAngleKey)
        guard let shifted = filter.outputImage,
              let colorFilter = CIFilter(name: "CIColorControls") else { return NSImage(contentsOf: url) }
        colorFilter.setValue(shifted, forKey: kCIInputImageKey)
        colorFilter.setValue(prefs.saturation, forKey: kCIInputSaturationKey)
        colorFilter.setValue(prefs.brightness, forKey: kCIInputBrightnessKey)
        guard let output = colorFilter.outputImage,
              let cgImage = ciContext.createCGImage(output, from: input.extent) else { return NSImage(contentsOf: url) }
        return NSImage(cgImage: cgImage, size: NSSize(width: 1024, height: 1024))
    }

    func react(_ newMood: BuddyMood, bubble: String = "", seconds: Double = 1.4) {
        if prefs.napMode && newMood != .lowBattery { needsDisplay = true; return }
        let now = Date.timeIntervalSinceReferenceDate
        mood = newMood
        moodEnd = now + seconds
        lastActivity = now
        if !bubble.isEmpty && prefs.speechBubbles { reactionText = bubble; reactionUntil = now + min(6.0, seconds + 0.4) }
        if prefs.soundEffects && (newMood == .happy || newMood == .surprise) {
            NSSound(named: NSSound.Name("Pop"))?.play()
        }
        needsDisplay = true
    }

    func flip() {
        backUntil = Date.timeIntervalSinceReferenceDate + 2.2
        needsDisplay = true
    }

    func setMusic(playing: Bool, title: String, source: String) {
        isMusicPlaying = playing
        musicTitle = title
        musicSource = source
        needsDisplay = true
    }

    func tick(_ now: Double) {
        if now > moodEnd { mood = .normal }
        if now > nextBlink {
            blinkEnd = now + 0.13
            nextBlink = now + Double.random(in: 2.2...6.2) * (prefs.blinkInterval / 4.0)
        }
        needsDisplay = true
    }

    override func updateTrackingAreas() {
        for area in trackingAreas { removeTrackingArea(area) }
        let area = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        addTrackingArea(area)
        super.updateTrackingAreas()
    }

    override func mouseEntered(with event: NSEvent) { react(.curious, bubble: "?", seconds: 0.9) }
    override func mouseDown(with event: NSEvent) {
        startPoint = NSEvent.mouseLocation
        windowStart = window?.frame.origin ?? .zero
        dragged = false
    }
    override func mouseDragged(with event: NSEvent) {
        guard let window = window else { return }
        let current = NSEvent.mouseLocation
        let dx = current.x - startPoint.x
        let dy = current.y - startPoint.y
        if hypot(dx, dy) > 3 { dragged = true }
        window.setFrameOrigin(NSPoint(x: windowStart.x + dx, y: windowStart.y + dy))
        lastActivity = Date.timeIntervalSinceReferenceDate
    }
    override func mouseUp(with event: NSEvent) {
        if dragged {
            if prefs.snapToEdges { controller?.snapBuddyToEdge() }
            return
        }
        if event.clickCount >= 2 {
            flip()
        } else {
            react(.happy, bubble: ["boop!", "♥", "hi!", "✦", "yay!"].randomElement() ?? "♥")
        }
    }
    override func rightMouseDown(with event: NSEvent) { controller?.openSettings() }
    override func scrollWheel(with event: NSEvent) { react(.surprise, bubble: "whoa!", seconds: 0.8) }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        let now = Date.timeIntervalSinceReferenceDate
        let showBack = now < backUntil
        let isBlinking = now < blinkEnd
        let sleeping = prefs.idleSleep && now - lastActivity > 75 && mood == .normal
        let scale = bounds.width / 1024
        let dancing = (prefs.musicReactions && isMusicPlaying && prefs.musicDance) || mood == .music
        let activeDance = dancing && !prefs.napMode && !showBack
        let intensity = CGFloat(prefs.danceIntensity)
        let phase = CGFloat(now) * 5.3
        let danceBounce = activeDance ? abs(sin(phase)) * intensity * (prefs.danceStyle == "Party" ? 15 : 9) : 0
        let danceSway = activeDance && prefs.danceStyle != "Bop" ? sin(phase * 0.55) * intensity * 0.085 : 0
        let danceZoom = activeDance && prefs.danceStyle == "Party" ? 1 + (1 + sin(phase * 0.9)) * intensity * 0.025 : 1
        let floatOffset: CGFloat = prefs.floatAnimation ? CGFloat(sin(now * 1.7) * 3.0 * prefs.motionStrength) : 0
        let sway: CGFloat = prefs.floatAnimation ? CGFloat(sin(now * 0.8) * 0.020 * prefs.motionStrength) : 0

        ctx.saveGState()
        ctx.translateBy(x: bounds.midX, y: bounds.midY)
        if prefs.upsideDown { ctx.rotate(by: .pi) }
        ctx.rotate(by: sway + danceSway)
        ctx.scaleBy(x: danceZoom, y: danceZoom)
        ctx.translateBy(x: -bounds.midX, y: -bounds.midY + floatOffset + danceBounce)

        if prefs.glow {
            ctx.saveGState()
            let glowColor = NSColor(calibratedHue: CGFloat((50 + prefs.hue + 360).truncatingRemainder(dividingBy: 360) / 360), saturation: 0.85, brightness: 0.98, alpha: 0.15)
            ctx.setShadow(offset: .zero, blur: 22, color: glowColor.cgColor)
            ctx.setFillColor(NSColor.black.withAlphaComponent(0.012).cgColor)
            ctx.fillEllipse(in: bounds.insetBy(dx: 25 * scale, dy: 25 * scale))
            ctx.restoreGState()
        }

        // The photographs are right-side-up in a standard (unflipped) NSView.
        (showBack ? back : front)?.draw(in: bounds, from: .zero, operation: .sourceOver, fraction: 1)
        if !showBack {
            // The original face measurements are measured from the TOP of a 1024px image.
            // Only this overlay uses top-left coordinates, not the photograph itself.
            ctx.saveGState()
            ctx.translateBy(x: 0, y: bounds.height)
            ctx.scaleBy(x: 1, y: -1)
            ctx.scaleBy(x: scale, y: scale)
            drawFace(ctx: ctx, now: now, sleeping: sleeping, blinking: isBlinking)
            ctx.restoreGState()
        }
        if activeDance && !showBack {
            drawDancingNotes(in: ctx, now: now, intensity: intensity)
        }
        ctx.restoreGState()

        if now < reactionUntil && !reactionText.isEmpty && !showBack {
            drawBubble(in: ctx, text: reactionText, width: bounds.width)
        }
    }

    private func drawFace(ctx: CGContext, now: Double, sleeping: Bool, blinking: Bool) {
        // 1024px artwork coordinates, with the FACE only mapped to top-left origin.
        let face = CGRect(x: 320, y: 383, width: 345, height: 299)
        ctx.saveGState()
        ctx.addEllipse(in: face)
        ctx.clip()
        let colors = [NSColor(calibratedRed: 0.17, green: 0.17, blue: 0.20, alpha: 1).cgColor,
                      NSColor(calibratedRed: 0.035, green: 0.035, blue: 0.055, alpha: 1).cgColor] as CFArray
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1]) {
            ctx.drawLinearGradient(gradient, start: CGPoint(x: 400, y: 370), end: CGPoint(x: 560, y: 680), options: [])
        }
        ctx.restoreGState()
        ctx.setLineWidth(5)
        ctx.setStrokeColor(NSColor(calibratedWhite: 0.27, alpha: 0.75).cgColor)
        ctx.strokeEllipse(in: face.insetBy(dx: 2, dy: 2))

        let iris = NSColor(calibratedHue: CGFloat(prefs.irisHue / 360), saturation: 0.85, brightness: 1, alpha: 1)
        let automaticStyle: EyeStyle?
        if prefs.napMode { automaticStyle = .sleepy }
        else if prefs.autoReactiveEyes && (mood == .lowBattery || batteryIsLow) {
            automaticStyle = EyeStyle.from(prefs.lowBatteryEyeStyle)
        } else if prefs.autoReactiveEyes && mood == .charging {
            automaticStyle = EyeStyle.from(prefs.chargingEyeStyle)
        } else if prefs.autoReactiveEyes && (mood == .music || (prefs.musicReactions && isMusicPlaying)) {
            automaticStyle = EyeStyle.from(prefs.musicEyeStyle)
        } else if prefs.autoReactiveEyes && (sleeping || mood == .sleepy) {
            automaticStyle = EyeStyle.from(prefs.idleEyeStyle)
        } else if prefs.autoReactiveEyes && mood == .typing {
            automaticStyle = .focused
        } else if prefs.autoReactiveEyes && mood == .happy {
            automaticStyle = .bigCute
        } else if prefs.autoReactiveEyes && mood == .surprise {
            automaticStyle = .wide
        } else { automaticStyle = nil }

        let leftStyle = automaticStyle ?? EyeStyle.from(prefs.differentEyeStyles ? prefs.leftEyeStyle : prefs.eyeStyle)
        let rightStyle = automaticStyle ?? EyeStyle.from(prefs.differentEyeStyles ? prefs.rightEyeStyle : prefs.eyeStyle)
        let spacing = CGFloat((prefs.eyeSpacing - 1) * 38)
        let offsetX = CGFloat(prefs.eyeOffsetX)
        let offsetY = CGFloat(prefs.eyeOffsetY)
        let left = CGRect(x: 347 - spacing + offsetX, y: 441 + offsetY, width: 149, height: 144)
        let right = CGRect(x: 495 + spacing + offsetX, y: 467 + offsetY, width: 150, height: 136)
        drawEye(ctx: ctx, rect: left, style: leftStyle, isLeft: true, blinking: blinking, iris: iris)
        drawEye(ctx: ctx, rect: right, style: rightStyle, isLeft: false, blinking: blinking, iris: iris)

        if mood == .surprise {
            ctx.setStrokeColor(NSColor.white.withAlphaComponent(0.80).cgColor)
            ctx.setLineWidth(5)
            ctx.strokeEllipse(in: CGRect(x: 472, y: 613, width: 25, height: 27))
        }
        if mood == .charging {
            drawSymbol("⚡", rect: CGRect(x: 456, y: 602, width: 60, height: 58), fontSize: 50, color: .systemGreen)
        }
    }

    private func drawEye(ctx: CGContext, rect: CGRect, style: EyeStyle, isLeft: Bool, blinking: Bool, iris: NSColor) {
        let baseScale = CGFloat(prefs.eyeSize)
        let r = CGRect(x: rect.midX - rect.width * baseScale / 2,
                       y: rect.midY - rect.height * baseScale / 2,
                       width: rect.width * baseScale, height: rect.height * baseScale)
        // Special shapes are fully drawn in vector graphics, so they retain sharp edges at any size.
        if style == .happy || (style == .wink && isLeft) || style == .dazed || blinking {
            let c = NSColor.white
            ctx.setStrokeColor(c.cgColor)
            ctx.setLineCap(.round)
            ctx.setLineWidth(blinking ? 12 : (style == .dazed ? 13 : 16))
            if style == .dazed && !blinking {
                let size = min(r.width, r.height) * 0.62
                for sign: CGFloat in [-1, 1] {
                    ctx.move(to: CGPoint(x: r.midX - size / 2, y: r.midY + sign * size / 2))
                    ctx.addLine(to: CGPoint(x: r.midX + size / 2, y: r.midY - sign * size / 2))
                    ctx.strokePath()
                }
            } else {
                let path = CGMutablePath()
                let endY = r.midY + (style == .happy ? 9 : 0)
                path.move(to: CGPoint(x: r.minX + 15, y: endY))
                path.addQuadCurve(to: CGPoint(x: r.maxX - 15, y: endY),
                                  control: CGPoint(x: r.midX, y: endY + (style == .happy ? -57 : 8)))
                ctx.addPath(path); ctx.strokePath()
            }
            return
        }
        var eye = r
        switch style {
        case .sleepy: eye = CGRect(x: r.minX, y: r.midY - r.height * 0.25, width: r.width, height: r.height * 0.50)
        case .focused: eye = CGRect(x: r.minX, y: r.midY - r.height * 0.32, width: r.width, height: r.height * 0.64)
        case .tiny: eye = r.insetBy(dx: r.width * 0.12, dy: r.height * 0.12)
        case .wide, .bigCute: eye = r.insetBy(dx: -r.width * 0.035, dy: -r.height * 0.06)
        case .alien: eye = r.insetBy(dx: 20, dy: -3)
        default: break
        }
        let pixel = style == .pixel
        let path = pixel ? CGPath(roundedRect: eye.insetBy(dx: 7, dy: 7), cornerWidth: 9, cornerHeight: 9, transform: nil)
                         : CGPath(ellipseIn: eye, transform: nil)
        ctx.addPath(path)
        ctx.setFillColor(NSColor.white.cgColor)
        ctx.fillPath()
        ctx.saveGState(); ctx.addPath(path); ctx.clip()
        let gazeShiftX = gazeX * (style == .focused ? 17 : 25)
        let gazeShiftY = gazeY * 19
        let sizeAdjust = CGFloat(prefs.pupilSize)
        let dia: CGFloat = (style == .tiny ? 36 : (style == .bigCute ? 83 : (style == .alien ? 90 : 69))) * sizeAdjust
        let pupil = CGRect(x: eye.midX - dia / 2 + gazeShiftX, y: eye.midY - dia / 2 + gazeShiftY,
                           width: dia, height: dia)
        ctx.setFillColor(iris.cgColor)
        switch style {
        case .pixel:
            ctx.fill(pupil)
        case .heart:
            ctx.addPath(heartPath(in: pupil)); ctx.fillPath()
        case .star:
            ctx.addPath(starPath(in: pupil, points: 5)); ctx.fillPath()
        case .spiral:
            ctx.setStrokeColor(iris.cgColor); ctx.setLineWidth(max(7, dia * 0.16)); ctx.setLineCap(.round)
            let center = CGPoint(x: pupil.midX, y: pupil.midY)
            let spiral = CGMutablePath()
            for step in 0...66 {
                let t = CGFloat(step) / 66
                let a = CGFloat.pi * 5 * t
                let rad = dia * 0.43 * t
                let at = CGPoint(x: center.x + cos(a) * rad, y: center.y + sin(a) * rad)
                if step == 0 { spiral.move(to: at) } else { spiral.addLine(to: at) }
            }
            ctx.addPath(spiral); ctx.strokePath()
        case .rainbow:
            for i in (0..<5).reversed() {
                let diameter = dia * CGFloat(i + 1) / 5
                let hue = CGFloat((Double(i) / 5 + prefs.irisHue / 360).truncatingRemainder(dividingBy: 1))
                ctx.setFillColor(NSColor(calibratedHue: hue, saturation: 0.92, brightness: 1, alpha: 1).cgColor)
                ctx.fillEllipse(in: CGRect(x: pupil.midX - diameter / 2, y: pupil.midY - diameter / 2,
                                           width: diameter, height: diameter))
            }
        case .anime:
            ctx.fillEllipse(in: pupil)
            ctx.setFillColor(NSColor.black.withAlphaComponent(0.38).cgColor)
            ctx.fillEllipse(in: pupil.insetBy(dx: dia * 0.25, dy: dia * 0.25))
        case .alien:
            ctx.fillEllipse(in: pupil.insetBy(dx: dia * 0.25, dy: 0))
        default:
            ctx.fillEllipse(in: pupil)
        }
        if prefs.eyeGloss && style != .pixel && style != .spiral {
            ctx.setFillColor(NSColor.white.withAlphaComponent(style == .anime ? 0.90 : 0.32).cgColor)
            ctx.fillEllipse(in: CGRect(x: pupil.minX + dia * 0.17, y: pupil.minY + dia * 0.11,
                                       width: dia * 0.24, height: dia * 0.16))
        }
        ctx.restoreGState()
        if style == .sleepy || style == .focused {
            ctx.setStrokeColor(NSColor(calibratedWhite: 0.14, alpha: 1).cgColor)
            ctx.setLineWidth(14)
            ctx.move(to: CGPoint(x: eye.minX + 11, y: eye.minY + 12))
            ctx.addQuadCurve(to: CGPoint(x: eye.maxX - 11, y: eye.minY + 12),
                             control: CGPoint(x: eye.midX, y: eye.minY - 7))
            ctx.strokePath()
        }
    }

    private func starPath(in rect: CGRect, points: Int) -> CGPath {
        let path = CGMutablePath()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        for i in 0..<(points * 2) {
            let angle = CGFloat(i) * .pi / CGFloat(points) - .pi / 2
            let radius = min(rect.width, rect.height) * (i.isMultiple(of: 2) ? 0.48 : 0.23)
            let point = CGPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius)
            if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        path.closeSubpath()
        return path
    }

    private func heartPath(in rect: CGRect) -> CGPath {
        let p = CGMutablePath()
        let w = rect.width, h = rect.height, x = rect.minX, y = rect.minY
        p.move(to: CGPoint(x: x + w * 0.5, y: y + h * 0.92))
        p.addCurve(to: CGPoint(x: x + w * 0.05, y: y + h * 0.34),
                   control1: CGPoint(x: x + w * 0.12, y: y + h * 0.65),
                   control2: CGPoint(x: x, y: y + h * 0.60))
        p.addCurve(to: CGPoint(x: x + w * 0.5, y: y + h * 0.25),
                   control1: CGPoint(x: x + w * 0.06, y: y + h * 0.03),
                   control2: CGPoint(x: x + w * 0.36, y: y + h * 0.10))
        p.addCurve(to: CGPoint(x: x + w * 0.95, y: y + h * 0.34),
                   control1: CGPoint(x: x + w * 0.64, y: y + h * 0.10),
                   control2: CGPoint(x: x + w * 0.94, y: y + h * 0.03))
        p.addCurve(to: CGPoint(x: x + w * 0.5, y: y + h * 0.92),
                   control1: CGPoint(x: x + w, y: y + h * 0.60),
                   control2: CGPoint(x: x + w * 0.88, y: y + h * 0.65))
        p.closeSubpath()
        return p
    }

    private func drawSymbol(_ text: String, rect: CGRect, fontSize: CGFloat, color: NSColor) {
        // Compensate for the top-left face-coordinate transform when rendering glyphs.
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        let attrs: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: fontSize, weight: .heavy), .foregroundColor: color
        ]
        ctx.saveGState()
        ctx.translateBy(x: rect.minX, y: rect.maxY)
        ctx.scaleBy(x: 1, y: -1)
        (text as NSString).draw(in: CGRect(origin: .zero, size: rect.size), withAttributes: attrs)
        ctx.restoreGState()
    }

    private func drawDancingNotes(in ctx: CGContext, now: Double, intensity: CGFloat) {
        let scale = bounds.width / 305
        let colors: [NSColor] = [.systemPink, .systemCyan, .systemPurple]
        for i in 0..<3 {
            let offset = CGFloat(now * 0.8 + Double(i) * 1.5)
            let x = (i == 1 ? 235 : (i == 0 ? 48 : 165)) * scale
            let y = (198 + 20 * sin(offset + Double(i))) * scale
            let attrs: [NSAttributedString.Key: Any] = [
                .font: NSFont.boldSystemFont(ofSize: (24 + intensity * 7) * scale),
                .foregroundColor: colors[i].withAlphaComponent(0.78)
            ]
            ((i == 1 ? "♫" : "♪") as NSString).draw(at: CGPoint(x: x, y: y), withAttributes: attrs)
        }
    }

    private func drawBubble(in ctx: CGContext, text: String, width: CGFloat) {
        let teaser = text.count > 17 ? "♫ now playing" : text
        let w: CGFloat = max(66, CGFloat(teaser.count) * 12 + 27)
        let r = CGRect(x: width * 0.52, y: bounds.height - 40, width: min(w, width * 0.44), height: 34)
        ctx.saveGState()
        ctx.setFillColor(NSColor(calibratedWhite: 0.10, alpha: 0.92).cgColor)
        let rounded = CGPath(roundedRect: r, cornerWidth: 14, cornerHeight: 14, transform: nil)
        ctx.addPath(rounded); ctx.fillPath()
        ctx.restoreGState()
        let attrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 15, weight: .bold), .foregroundColor: NSColor.white]
        (teaser as NSString).draw(in: r.insetBy(dx: 7, dy: 7), withAttributes: attrs)
    }
}

struct SettingsView: View {
    @ObservedObject var p: BuddyPreferences
    let onTest: () -> Void
    let onDance: () -> Void
    let onFlip: () -> Void
    let onCenter: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "sparkles.rectangle.stack.fill")
                    .font(.system(size: 32)).foregroundStyle(.yellow)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Winklet").font(.title2.bold())
                    Text("Your little desktop companion").font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Button("Boop!", action: onTest)
                Button("Dance!", action: onDance)
                Button("Flip", action: onFlip)
            }
            TabView {
                lookTab.tabItem { Label("Appearance", systemImage: "paintpalette") }
                eyesTab.tabItem { Label("Eyes", systemImage: "eye.fill") }
                behaviorTab.tabItem { Label("Reactions", systemImage: "heart.text.square") }
                desktopTab.tabItem { Label("Desktop", systemImage: "macwindow.on.rectangle") }
                privacyTab.tabItem { Label("About", systemImage: "info.circle") }
            }
            HStack {
                Text("Drag the star anywhere • Double-click to see its back")
                    .font(.caption2).foregroundStyle(.secondary)
                Spacer()
                Button("Center buddy", action: onCenter)
            }
        }
        .padding(18)
        .frame(width: 560, height: 650)
    }

    private var lookTab: some View {
        Form {
            TextField("Buddy's name", text: $p.buddyName)
            Picker("Pronouns", selection: $p.pronouns) {
                Text("He / Him").tag("He / Him")
                Text("She / Her").tag("She / Her")
                Text("They / Them").tag("They / Them")
            }
            VStack(alignment: .leading) {
                HStack { Text("Body hue shift"); Spacer(); Text("\(Int(p.hue))°").foregroundStyle(.secondary).monospacedDigit() }
                Slider(value: $p.hue, in: -180...180, step: 1)
            }
            HStack(spacing: 7) {
                Button("Gold") { p.hue = 0 }
                Button("Rose") { p.hue = -70 }
                Button("Mint") { p.hue = 100 }
                Button("Blue") { p.hue = 175 }
                Button("Violet") { p.hue = -135 }
            }.controlSize(.small)
            VStack(alignment: .leading) {
                HStack { Text("Saturation"); Spacer(); Text("\(Int(p.saturation * 100))%").foregroundStyle(.secondary) }
                Slider(value: $p.saturation, in: 0...1.75, step: 0.05)
            }
            VStack(alignment: .leading) {
                HStack { Text("Brightness"); Spacer(); Text("\(Int(p.brightness * 100))").foregroundStyle(.secondary) }
                Slider(value: $p.brightness, in: -0.3...0.3, step: 0.02)
            }
            VStack(alignment: .leading) {
                HStack { Text("Eye color"); Spacer(); Text("\(Int(p.irisHue))°").foregroundStyle(.secondary).monospacedDigit() }
                Slider(value: $p.irisHue, in: 0...360, step: 1)
                HStack(spacing: 4) {
                    ForEach(0..<24, id: \.self) { i in
                        Rectangle().fill(Color(hue: Double(i) / 24, saturation: 0.9, brightness: 1))
                    }
                }.frame(height: 7).clipShape(Capsule())
            }
            VStack(alignment: .leading) {
                HStack { Text("Size"); Spacer(); Text("\(Int(p.size)) pt").foregroundStyle(.secondary).monospacedDigit() }
                Slider(value: $p.size, in: 160...480, step: 5)
            }
            VStack(alignment: .leading) {
                HStack { Text("Opacity"); Spacer(); Text("\(Int(p.opacity * 100))%").foregroundStyle(.secondary).monospacedDigit() }
                Slider(value: $p.opacity, in: 0.35...1, step: 0.05)
            }
            Toggle("Soft glow", isOn: $p.glow)
            Toggle("Rotate buddy 180° (orientation fallback)", isOn: $p.upsideDown)
            Toggle("Gentle floating animation", isOn: $p.floatAnimation)
            VStack(alignment: .leading) {
                Text("Motion strength")
                Slider(value: $p.motionStrength, in: 0...2, step: 0.1).disabled(!p.floatAnimation)
            }
            VStack(alignment: .leading) {
                Text("Blink interval")
                Slider(value: $p.blinkInterval, in: 1...10, step: 0.5)
            }
            HStack { Spacer(); Button("Reset appearance") { p.resetLook() } }
        }.formStyle(.grouped)
    }

    private var eyesTab: some View {
        Form {
            Text("EYE STUDIO").font(.caption.bold()).foregroundStyle(.secondary)
            Text("Choose your face! Changes are previewed immediately on Winklet. Each eye is drawn as a vector over the original visor.")
                .font(.caption).foregroundStyle(.secondary)
            Picker("Both eyes", selection: $p.eyeStyle) {
                ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
            }.disabled(p.differentEyeStyles)
            Toggle("Give left and right eyes different styles", isOn: $p.differentEyeStyles)
            if p.differentEyeStyles {
                Picker("Left eye", selection: $p.leftEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
                Picker("Right eye", selection: $p.rightEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
            }
            HStack { Text("Eye size"); Slider(value: $p.eyeSize, in: 0.62...1.20); Text("\(Int(p.eyeSize * 100))%").monospacedDigit().font(.caption) }
            HStack { Text("Pupil size"); Slider(value: $p.pupilSize, in: 0.45...1.5); Text("\(Int(p.pupilSize * 100))%").monospacedDigit().font(.caption) }
            HStack { Text("Eye spacing"); Slider(value: $p.eyeSpacing, in: 0.5...1.5); Text("\(Int(p.eyeSpacing * 100))%").monospacedDigit().font(.caption) }
            HStack { Text("Horizontal position"); Slider(value: $p.eyeOffsetX, in: -40...40, step: 1) }
            HStack { Text("Vertical position"); Slider(value: $p.eyeOffsetY, in: -35...35, step: 1) }
            Toggle("Glossy eye highlights", isOn: $p.eyeGloss)
            Divider()
            Text("AUTO-REACTIVE EYES").font(.caption.bold()).foregroundStyle(.secondary)
            Toggle("Automatically change eyes with activity", isOn: $p.autoReactiveEyes)
            if p.autoReactiveEyes {
                Picker("While music plays", selection: $p.musicEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
                Picker("When charging", selection: $p.chargingEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
                Picker("When battery is low", selection: $p.lowBatteryEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
                Picker("When sleepy or idle", selection: $p.idleEyeStyle) {
                    ForEach(EyeStyle.allCases) { style in Text(style.rawValue).tag(style.rawValue) }
                }
                Text("Typing focuses the eyes; boops make them wide. Low battery has priority until you recharge.")
                    .font(.caption).foregroundStyle(.secondary)
            }
        }.formStyle(.grouped)
    }

    private var behaviorTab: some View {
        Form {
            Toggle("Eyes follow the mouse pointer", isOn: $p.gazeTracking)
            Toggle("React to clicks around the desktop", isOn: $p.clickReactions)
            VStack(alignment: .leading) {
                Text("How often to react to clicks: \(Int(p.clickChance * 100))%")
                Slider(value: $p.clickChance, in: 0...1, step: 0.05).disabled(!p.clickReactions)
            }
            Toggle("Show little speech bubbles", isOn: $p.speechBubbles)
            Toggle("Nap mode (pause reactions and close eyes)", isOn: $p.napMode)
            Toggle("React when changing apps", isOn: $p.appReactions)
            Toggle("Sleep after 75 seconds of inactivity", isOn: $p.idleSleep)
            Divider()
            Text("POWER & BATTERY").font(.caption.bold()).foregroundStyle(.secondary)
            Toggle("React to charging and low battery", isOn: $p.batteryReactions)
            if p.batteryReactions {
                Toggle("React when plugged in or unplugged", isOn: $p.batteryConnectionReactions)
                Toggle("Include battery percentage in speech bubbles", isOn: $p.batteryPercentBubbles)
                HStack {
                    Text("Low battery warning")
                    Slider(value: $p.batteryLowLevel, in: 10...50, step: 5)
                    Text("\(Int(p.batteryLowLevel))%")
                        .font(.caption.monospacedDigit()).foregroundStyle(.secondary)
                }
                Toggle("Also show macOS notification alerts", isOn: $p.batteryNotify)
                Text("Winklet reacts to power changes, warns at your chosen battery level, and gives an extra warning at 10% when unplugged. Low-battery alerts are rate-limited. System alerts require notification permission.")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Divider()
            Text("MUSIC").font(.caption.bold()).foregroundStyle(.secondary)
            Toggle("Music reactions", isOn: $p.musicReactions)
            if p.musicReactions {
                Toggle("Detect Apple Music", isOn: $p.musicApple)
                Toggle("Detect Spotify", isOn: $p.musicSpotify)
                Toggle("Dance throughout playback", isOn: $p.musicDance)
                if p.musicDance {
                    Picker("Dance style", selection: $p.danceStyle) {
                        ForEach(["Bop", "Sway", "Party"], id: \.self) { style in
                            Text(style).tag(style)
                        }
                    }
                    HStack {
                        Text("Dance intensity")
                        Slider(value: $p.danceIntensity, in: 0.2...2, step: 0.1)
                    }
                }
                Toggle("Show FULL song details next to Winklet", isOn: $p.showNowPlayingCard)
                Toggle("Also show song name in speech bubble", isOn: $p.showSongTitles)
                Text("The wide Now Playing card wraps long titles and shows artist + album. It can be switched off independently. Dance follows playback state, not individual beats. Apple Music / Spotify may ask for Automation permission.")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Toggle("React to keyboard activity (optional permission)", isOn: $p.typingReactions)
            Toggle("React to nearby sounds (microphone)", isOn: $p.microphoneReactions)
            if p.microphoneReactions {
                VStack(alignment: .leading) {
                    Text("Sound sensitivity")
                    Slider(value: $p.soundSensitivity, in: 0.1...0.95, step: 0.05)
                }
            }
            Toggle("Play a small sound when booped", isOn: $p.soundEffects)
            Text("Typing counts activity only, not characters. Microphone mode measures volume only, not words, and requires your permission. No audio or keystrokes are recorded or sent.")
                .font(.caption).foregroundStyle(.secondary)
        }.formStyle(.grouped)
    }

    private var desktopTab: some View {
        Form {
            Toggle("Overlay other windows (Always on Top)", isOn: $p.alwaysOnTop)
            Text(p.alwaysOnTop ? "Winklet will float above ordinary app windows." : "Winklet behaves like a regular window and can stay behind other apps.")
                .font(.caption).foregroundStyle(.secondary)
            Toggle("Show on every desktop / Space", isOn: $p.allSpaces)
            Toggle("Allow overlay in full-screen Spaces", isOn: $p.fullscreenOverlay)
                .disabled(!p.alwaysOnTop)
            Toggle("Click-through (don't block windows underneath)", isOn: $p.clickThrough)
            Text("With click-through on, use the menu bar star to reopen settings or turn it off; you cannot drag the buddy while clicks pass through.")
                .font(.caption).foregroundStyle(.secondary)
            Toggle("Follow the cursor around the screen", isOn: $p.followCursor)
            Toggle("Snap to left or right edge after dragging", isOn: $p.snapToEdges)
            Toggle("Launch automatically when I log in", isOn: $p.startAtLogin)
            Toggle("Show Winklet icon in the Dock", isOn: $p.showDockIcon)
            Text("A menu bar ✦ stays available, even if Winklet is hidden or click-through is enabled.")
                .font(.caption).foregroundStyle(.secondary)
        }.formStyle(.grouped)
    }

    private var privacyTab: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Winklet — music, charging and battery companion").font(.headline)
            Text("Built with AppKit and SwiftUI. Its reactions run locally—no accounts, cloud service, or camera. Microphone reactions are optional and off by default.")
            Text("Winklet responds to pointer movements, clicks, app changes, charging or unplugging, low battery warnings, and Apple Music or Spotify playback. Optional macOS notification alerts require permission. Music dancing follows play/pause, not individual beats.")
            Text("Eye Studio: 16 eye styles, independent left/right eyes, pupil controls and adjustable automatic eye reactions for music, charging, battery and idle time.")
            Text("The Now Playing card shows full song title, artist, and album, with no 19-character cutoff. It can be disabled separately from music reactions.")
            Text("The star reference images are included with this personal build and are not being presented as an official CREATURE product.")
            Text("Tip: right-click Winklet to open settings. Double-click to flip. Use the menu bar icon to show/hide it.")
            Spacer()
        }.padding(20).frame(maxWidth: .infinity, alignment: .leading)
    }
}

final class BuddyAppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, UNUserNotificationCenterDelegate {
    let prefs = BuddyPreferences()
    var panel: BuddyPanel!
    var buddy: BuddyView!
    var statusItem: NSStatusItem!
    var settingsWindow: NSWindow?
    private let nowPlayingModel = NowPlayingModel()
    private var nowPlayingPanel: BuddyPanel?
    private var lastNowPlayingKey = ""
    private var lastNowPlayingHeight: CGFloat = 180
    private var settingsCancellable: AnyCancellable?
    private var tickTimer: Timer?
    private var batteryTimer: Timer?
    private var musicTimer: Timer?
    private var lastBatteryPercent: Int?
    private var lastACConnected: Bool?
    private var lastBatteryAlertLevel = 101
    private var lastBatteryWarningAt = 0.0
    private var lastPowerAlertEnabled = false
    private var batteryMenuItem: NSMenuItem?
    private var lastMouse: NSPoint = .zero
    private var clickMonitor: Any?
    private var typingMonitor: Any?
    private var workspaceObservers: [NSObjectProtocol] = []
    private var lastMusicPlaying = false
    private var lastMusicTrack = ""
    private var lastMusicSource = ""
    private var musicQueryRunning = false
    private var audioEngine: AVAudioEngine?
    private var microphoneRequested = false
    private var lastSoundResponse = 0.0
    private var lastPositionSaved = 0.0
    private var isHidden = false
    private var currentSize: CGFloat = 305
    private var lastLoginSetting = false
    private var lastDockIcon = false

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        UNUserNotificationCenter.current().delegate = self
        buildPanel()
        buildStatusMenu()
        lastLoginSetting = prefs.startAtLogin
        settingsCancellable = prefs.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { self?.applyPreferences() }
        }
        applyPreferences()
        installObservers()
        tickTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30.0, repeats: true) { [weak self] _ in self?.tick() }
        batteryTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in self?.checkBattery() }
        musicTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in self?.checkMusic() }
        checkBattery()
        checkMusic()
        buddy.react(.curious, bubble: "hello!", seconds: 2)
    }

    func applicationWillTerminate(_ notification: Notification) {
        tickTimer?.invalidate(); batteryTimer?.invalidate(); musicTimer?.invalidate()
        nowPlayingPanel?.orderOut(nil)
        if let m = clickMonitor { NSEvent.removeMonitor(m) }
        if let m = typingMonitor { NSEvent.removeMonitor(m) }
        for observer in workspaceObservers { NSWorkspace.shared.notificationCenter.removeObserver(observer) }
        stopMicrophone()
    }

    private func buildPanel() {
        let display = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1200, height: 800)
        let size = CGFloat(prefs.size)
        let defaultX = display.maxX - size - 36
        let defaultY = display.minY + 50
        let x = UserDefaults.standard.object(forKey: "windowX") as? Double ?? Double(defaultX)
        let y = UserDefaults.standard.object(forKey: "windowY") as? Double ?? Double(defaultY)
        panel = BuddyPanel(contentRect: NSRect(x: x, y: y, width: size, height: size),
                           styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: false)
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.hidesOnDeactivate = false
        panel.isReleasedWhenClosed = false
        buddy = BuddyView(prefs: prefs)
        buddy.controller = self
        panel.contentView = buddy
        panel.orderFrontRegardless()
        currentSize = size
    }

    private func buildStatusMenu() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            if let url = Bundle.main.url(forResource: "MenuIcon", withExtension: "png"),
               let icon = NSImage(contentsOf: url) {
                icon.size = NSSize(width: 19, height: 19)
                icon.isTemplate = false
                button.image = icon
            } else {
                button.title = "✦"
            }
            button.toolTip = "Winklet"
        }
        let menu = NSMenu(title: "Winklet")
        menu.delegate = self
        menu.addItem(NSMenuItem(title: "Customize Winklet…", action: #selector(openSettings), keyEquivalent: ","))
        menu.addItem(NSMenuItem(title: "Show / Hide Buddy", action: #selector(toggleVisibility), keyEquivalent: "b"))
        menu.addItem(NSMenuItem(title: "Toggle Always on Top", action: #selector(toggleAlwaysOnTop), keyEquivalent: "t"))
        menu.addItem(NSMenuItem(title: "Toggle Click-through", action: #selector(toggleClickThrough), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Boop Winklet", action: #selector(boopBuddy), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Flip Winklet", action: #selector(flipBuddy), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Music Reactions", action: #selector(toggleMusicReactions), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Full Now Playing Card", action: #selector(toggleNowPlayingCard), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Test Dance", action: #selector(testDance), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        let batteryItem = NSMenuItem(title: "Battery: checking…", action: #selector(showBatteryStatus), keyEquivalent: "")
        batteryMenuItem = batteryItem
        menu.addItem(batteryItem)
        menu.addItem(NSMenuItem(title: "Test Battery Reaction", action: #selector(testBatteryReaction), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Nap Mode", action: #selector(toggleNapMode), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Center on Screen", action: #selector(centerFromMenu), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Winklet", action: #selector(quitApp), keyEquivalent: "q"))
        for item in menu.items { item.target = self }
        statusItem.menu = menu
    }

    func menuNeedsUpdate(_ menu: NSMenu) {
        for item in menu.items {
            if item.title == "Toggle Always on Top" { item.state = prefs.alwaysOnTop ? .on : .off }
            if item.title == "Toggle Click-through" { item.state = prefs.clickThrough ? .on : .off }
            if item.title == "Nap Mode" { item.state = prefs.napMode ? .on : .off }
            if item.title == "Music Reactions" { item.state = prefs.musicReactions ? .on : .off }
            if item.title == "Full Now Playing Card" { item.state = prefs.showNowPlayingCard ? .on : .off }
        }
    }

    private func applyPreferences() {
        guard panel != nil else { return }
        buddy.refreshImages()
        buddy.batteryIsLow = prefs.batteryReactions && !(lastACConnected ?? true) &&
            (lastBatteryPercent ?? 101) <= Int(prefs.batteryLowLevel)
        statusItem?.button?.toolTip = "\(prefs.buddyName) — Winklet"
        panel.level = prefs.alwaysOnTop ? .floating : .normal
        var behaviors: NSWindow.CollectionBehavior = []
        if prefs.allSpaces { behaviors.insert(.canJoinAllSpaces) }
        else { behaviors.insert(.moveToActiveSpace) }
        if prefs.alwaysOnTop && prefs.fullscreenOverlay { behaviors.insert(.fullScreenAuxiliary) }
        panel.collectionBehavior = behaviors
        panel.ignoresMouseEvents = prefs.clickThrough
        panel.alphaValue = prefs.opacity
        updateNowPlayingCard()
        let newSize = CGFloat(prefs.size)
        if newSize != currentSize {
            var frame = panel.frame
            frame.size = NSSize(width: newSize, height: newSize)
            panel.setFrame(frame, display: true, animate: false)
            currentSize = newSize
        }
        panel.invalidateShadow()
        if lastDockIcon != prefs.showDockIcon {
            NSApp.setActivationPolicy(prefs.showDockIcon ? .regular : .accessory)
            lastDockIcon = prefs.showDockIcon
        }
        if lastLoginSetting != prefs.startAtLogin {
            updateLaunchAtLogin(prefs.startAtLogin)
            lastLoginSetting = prefs.startAtLogin
        }
        if prefs.batteryNotify && !lastPowerAlertEnabled {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
        }
        lastPowerAlertEnabled = prefs.batteryNotify
        updateTypingMonitor()
        updateMicrophone()
        if prefs.alwaysOnTop && !isHidden { panel.orderFrontRegardless() }
    }

    private func installObservers() {
        let nc = NSWorkspace.shared.notificationCenter
        workspaceObservers.append(nc.addObserver(forName: NSWorkspace.didActivateApplicationNotification,
                                                   object: nil, queue: .main) { [weak self] _ in
            guard let self = self, self.prefs.appReactions else { return }
            self.buddy.react(.curious, seconds: 0.9)
        })
        workspaceObservers.append(nc.addObserver(forName: NSWorkspace.didWakeNotification,
                                                   object: nil, queue: .main) { [weak self] _ in
            self?.buddy.react(.happy, bubble: "morning!", seconds: 2.0)
            self?.checkBattery()
            self?.checkMusic()
        })
        clickMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] _ in
            guard let self = self, self.prefs.clickReactions else { return }
            guard Double.random(in: 0...1) < self.prefs.clickChance else { return }
            if Double.random(in: 0...1) < 0.30 { self.buddy.react(.surprise, seconds: 0.5) }
            else { self.buddy.react(.curious, seconds: 0.5) }
        }
    }

    private func updateTypingMonitor() {
        if prefs.typingReactions && typingMonitor == nil {
            typingMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] _ in
                // The key itself is deliberately NOT inspected or retained.
                guard let self = self else { return }
                if Double.random(in: 0...1) < 0.11 { self.buddy.react(.typing, seconds: 0.55) }
                else { self.buddy.lastActivity = Date.timeIntervalSinceReferenceDate }
            }
        } else if !prefs.typingReactions, let monitor = typingMonitor {
            NSEvent.removeMonitor(monitor)
            typingMonitor = nil
        }
    }

    private func updateMicrophone() {
        if !prefs.microphoneReactions {
            stopMicrophone()
            microphoneRequested = false
            return
        }
        if audioEngine != nil || microphoneRequested { return }
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        if status == .authorized {
            startMicrophone()
        } else if status == .notDetermined {
            microphoneRequested = true
            AVCaptureDevice.requestAccess(for: .audio) { [weak self] allowed in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.microphoneRequested = false
                    if allowed && self.prefs.microphoneReactions { self.startMicrophone() }
                }
            }
        }
    }

    private func startMicrophone() {
        guard audioEngine == nil else { return }
        let engine = AVAudioEngine()
        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)
        guard format.sampleRate > 0, format.channelCount > 0 else { return }
        input.installTap(onBus: 0, bufferSize: 2048, format: format) { [weak self] buffer, _ in
            guard let self = self, let channel = buffer.floatChannelData?[0] else { return }
            let count = Int(buffer.frameLength)
            if count == 0 { return }
            var sum: Float = 0
            for i in 0..<count { sum += channel[i] * channel[i] }
            let rms = sqrt(sum / Float(count))
            let now = Date.timeIntervalSinceReferenceDate
            // At maximum sensitivity, a quiet room is enough; at minimum, a loud sound is needed.
            let threshold = Float(0.065 - self.prefs.soundSensitivity * 0.055)
            if rms > threshold && now - self.lastSoundResponse > 1.7 {
                self.lastSoundResponse = now
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, self.prefs.microphoneReactions else { return }
                    self.buddy.react(.surprise, bubble: "!", seconds: 1.0)
                }
            }
        }
        do {
            try engine.start()
            audioEngine = engine
        } catch {
            input.removeTap(onBus: 0)
        }
    }

    private func stopMicrophone() {
        guard let engine = audioEngine else { return }
        engine.inputNode.removeTap(onBus: 0)
        engine.stop()
        audioEngine = nil
    }

    private func tick() {
        guard buddy != nil, panel != nil else { return }
        let now = Date.timeIntervalSinceReferenceDate
        let mouse = NSEvent.mouseLocation
        if hypot(mouse.x - lastMouse.x, mouse.y - lastMouse.y) > 2 {
            buddy.lastActivity = now
            lastMouse = mouse
        }
        if prefs.gazeTracking {
            let center = CGPoint(x: panel.frame.midX, y: panel.frame.midY)
            let dx = mouse.x - center.x
            let dy = center.y - mouse.y
            buddy.gazeX = max(-1, min(1, dx / 250))
            buddy.gazeY = max(-1, min(1, dy / 220))
        } else { buddy.gazeX = 0; buddy.gazeY = 0 }
        if prefs.followCursor && !isHidden {
            let screen = NSScreen.screens.first(where: { $0.frame.contains(mouse) }) ?? NSScreen.main
            let visible = screen?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1200, height: 800)
            let targetX = min(max(mouse.x + 105, visible.minX), visible.maxX - panel.frame.width)
            let targetY = min(max(mouse.y - panel.frame.height * 0.65, visible.minY), visible.maxY - panel.frame.height)
            let origin = panel.frame.origin
            panel.setFrameOrigin(NSPoint(x: origin.x + (targetX - origin.x) * 0.035,
                                         y: origin.y + (targetY - origin.y) * 0.035))
        }
        if !isHidden { buddy.tick(now) }
        if nowPlayingPanel?.isVisible == true { positionNowPlayingCard() }
        if now - lastPositionSaved >= 5 {
            saveWindowPosition()
            lastPositionSaved = now
        }
    }

    private func saveWindowPosition() {
        guard panel != nil, !prefs.followCursor else { return }
        UserDefaults.standard.set(Double(panel.frame.minX), forKey: "windowX")
        UserDefaults.standard.set(Double(panel.frame.minY), forKey: "windowY")
    }

    private func checkBattery() {
        // pmset is a standard macOS command; read the real physical power source.
        // Do not infer "charging" from the substring "discharging".
        guard let raw = runProcess("/usr/bin/pmset", ["-g", "batt"]),
              let match = raw.range(of: #"\b(100|[1-9]?[0-9])%"#, options: .regularExpression),
              let level = Int(raw[match].dropLast()) else { return }
        let acConnected = raw.localizedCaseInsensitiveContains("AC Power") ||
            raw.localizedCaseInsensitiveContains("; charging;") ||
            raw.localizedCaseInsensitiveContains("; charged;")
        let previousAC = lastACConnected
        let wasLow = lastBatteryAlertLevel
        buddy.batteryIsLow = prefs.batteryReactions && !acConnected && level <= Int(prefs.batteryLowLevel)
        lastBatteryPercent = level
        lastACConnected = acConnected
        batteryMenuItem?.title = "Battery: \(level)% · \(acConnected ? "Plugged in" : "On battery")"
        guard prefs.batteryReactions else {
            lastBatteryAlertLevel = 101
            return
        }
        let levelText = prefs.batteryPercentBubbles ? " (\(level)%)" : ""
        if previousAC != nil && previousAC != acConnected && prefs.batteryConnectionReactions {
            if acConnected {
                buddy.react(.charging, bubble: "⚡ plugged in\(levelText)", seconds: 3.0)
            } else {
                buddy.react(.curious, bubble: "🔌 on battery\(levelText)", seconds: 3.0)
            }
        }
        if acConnected {
            // Once charging, re-arm warnings for the next discharge session.
            lastBatteryAlertLevel = 101
            return
        }
        let lowThreshold = Int(prefs.batteryLowLevel)
        if level > lowThreshold + 2 {
            lastBatteryAlertLevel = 101
            return
        }
        let severity = level <= 10 ? 10 : (level <= lowThreshold ? lowThreshold : 101)
        guard severity < 101 else { return }
        let now = Date.timeIntervalSinceReferenceDate
        // One warning when the threshold is crossed, then another at <=10%.
        // Re-arm only after charging or rising back over the threshold.
        guard severity < wasLow, now - lastBatteryWarningAt > 30 else { return }
        let critical = severity == 10
        let message = critical ? "⚠️ Battery critical: \(level)%!" : "⚠️ Low battery: \(level)%!"
        buddy.react(.lowBattery, bubble: critical ? "charge me! \(level)%" : "low battery \(level)%", seconds: 5)
        lastBatteryAlertLevel = severity
        lastBatteryWarningAt = now
        if prefs.batteryNotify {
            sendBatteryAlert(title: critical ? "Winklet: Battery critically low" : "Winklet: Low battery",
                             message: message)
        }
    }

    private func sendBatteryAlert(title: String, message: String) {
        guard prefs.batteryNotify else { return }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        let request = UNNotificationRequest(identifier: "winklet.power.\(UUID().uuidString)",
                                            content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    private func checkMusic() {
        guard !musicQueryRunning else { return }
        guard prefs.musicReactions else {
            receiveMusic(playing: false, track: "", artist: "", album: "", source: "")
            return
        }
        // Probe only currently running apps. Never launch a player just to fetch metadata.
        let apps = NSWorkspace.shared.runningApplications
        var candidates: [String] = []
        if prefs.musicApple && apps.contains(where: { $0.bundleIdentifier == "com.apple.Music" }) { candidates.append("Music") }
        if prefs.musicSpotify && apps.contains(where: { $0.bundleIdentifier == "com.spotify.client" }) { candidates.append("Spotify") }
        guard !candidates.isEmpty else {
            receiveMusic(playing: false, track: "", artist: "", album: "", source: "")
            return
        }
        musicQueryRunning = true
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            var playing = false, track = "", artist = "", album = "", source = ""
            for app in candidates {
                let stateScript = "tell application \"\(app)\" to get player state as string"
                let state = self.runProcess("/usr/bin/osascript", ["-e", stateScript])?
                    .trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                guard state == "playing" else { continue }
                playing = true; source = app
                // Separate fields avoid parsing commas within song names and artist names.
                // NO truncation: retain the full title, even if it contains punctuation.
                func field(_ name: String) -> String {
                    let script = "tell application \"\(app)\" to get \(name) of current track"
                    return self.runProcess("/usr/bin/osascript", ["-e", script])?
                        .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                }
                track = field("name")
                artist = field("artist")
                album = field("album")
                break
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.musicQueryRunning = false
                self.receiveMusic(playing: playing, track: track, artist: artist, album: album, source: source)
            }
        }
    }

    private func receiveMusic(playing: Bool, track: String, artist: String, album: String, source: String) {
        guard buddy != nil else { return }
        let started = playing && !lastMusicPlaying
        let changed = playing && lastMusicPlaying && (track != lastMusicTrack || source != lastMusicSource)
        let stopped = !playing && lastMusicPlaying
        buddy.setMusic(playing: playing, title: track, source: source)
        nowPlayingModel.title = track
        nowPlayingModel.artist = artist
        nowPlayingModel.album = album
        nowPlayingModel.source = source
        nowPlayingModel.playing = playing
        updateNowPlayingCard()
        if started || changed {
            // The full text goes in the separate, readable Now Playing card.
            // The mini speech bubble stays concise instead of cutting titles midway.
            let message = prefs.showSongTitles && !track.isEmpty ? "♫ " + track : (changed ? "new song ♫" : "♫ let's dance!")
            buddy.react(.music, bubble: message, seconds: 3.6)
        } else if stopped {
            buddy.react(.sleepy, bubble: "paused ♡", seconds: 1.6)
        }
        lastMusicPlaying = playing
        lastMusicTrack = track
        lastMusicSource = source
    }

    private func updateNowPlayingCard() {
        guard panel != nil else { return }
        let shouldShow = prefs.showNowPlayingCard && prefs.musicReactions && nowPlayingModel.playing && !isHidden
        guard shouldShow else { nowPlayingPanel?.orderOut(nil); return }
        if nowPlayingPanel == nil {
            let card = BuddyPanel(contentRect: NSRect(x: 0, y: 0, width: 416, height: 205),
                                  styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: false)
            card.isOpaque = false
            card.backgroundColor = .clear
            card.hasShadow = true
            card.hidesOnDeactivate = false
            card.isReleasedWhenClosed = false
            card.contentView = NSHostingView(rootView: NowPlayingCard(model: nowPlayingModel))
            nowPlayingPanel = card
        }
        guard let card = nowPlayingPanel else { return }
        card.level = prefs.alwaysOnTop ? .floating : .normal
        card.ignoresMouseEvents = prefs.clickThrough
        card.alphaValue = prefs.opacity
        var behavior: NSWindow.CollectionBehavior = []
        if prefs.allSpaces { behavior.insert(.canJoinAllSpaces) }
        else { behavior.insert(.moveToActiveSpace) }
        if prefs.alwaysOnTop && prefs.fullscreenOverlay { behavior.insert(.fullScreenAuxiliary) }
        card.collectionBehavior = behavior
        positionNowPlayingCard()
        if !card.isVisible { card.orderFrontRegardless() }
    }

    private func positionNowPlayingCard() {
        guard let card = nowPlayingPanel, let panel = panel else { return }
        let desiredWidth: CGFloat = 416
        // Measure with native font layout to give long song titles more vertical room.
        func textHeight(_ text: String, font: NSFont) -> CGFloat {
            guard !text.isEmpty else { return 0 }
            return ceil((text as NSString).boundingRect(
                with: NSSize(width: desiredWidth - 42, height: CGFloat.greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: font]).height)
        }
        let metadataKey = nowPlayingModel.title + "\u{001F}" + nowPlayingModel.artist + "\u{001F}" + nowPlayingModel.album
        if metadataKey != lastNowPlayingKey {
            let textTotal = textHeight(nowPlayingModel.title, font: .systemFont(ofSize: 18, weight: .bold)) +
                            textHeight(nowPlayingModel.artist, font: .systemFont(ofSize: 14, weight: .medium)) +
                            textHeight(nowPlayingModel.album, font: .systemFont(ofSize: 12))
            lastNowPlayingHeight = min(410, max(145, textTotal + 93))
            lastNowPlayingKey = metadataKey
        }
        let desiredHeight = lastNowPlayingHeight
        let near = NSPoint(x: panel.frame.midX, y: panel.frame.midY)
        let screen = NSScreen.screens.first(where: { $0.frame.contains(near) }) ?? NSScreen.main
        let visible = screen?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1300, height: 800)
        let sideX = panel.frame.maxX + 10
        let x = sideX + desiredWidth <= visible.maxX ? sideX :
                max(visible.minX, panel.frame.minX - desiredWidth - 10)
        let y = min(max(visible.minY, panel.frame.midY - desiredHeight / 2),
                    visible.maxY - desiredHeight)
        let adjustedHeight = min(desiredHeight, visible.height)
        let frame = NSRect(x: max(visible.minX, min(x, visible.maxX - desiredWidth)),
                           y: y, width: desiredWidth, height: adjustedHeight)
        if card.frame != frame { card.setFrame(frame, display: true) }
    }

    private func runProcess(_ executable: String, _ arguments: [String]) -> String? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executable)
        process.arguments = arguments
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = FileHandle.nullDevice
        do { try process.run() } catch { return nil }
        // Neither pmset nor osascript produces large output for these commands.
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        return process.terminationStatus == 0 ? String(data: data, encoding: .utf8) : nil
    }

    private func updateLaunchAtLogin(_ enabled: Bool) {
        let folder = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/LaunchAgents", isDirectory: true)
        let url = folder.appendingPathComponent("com.winklet.desktop.plist")
        if enabled {
            do {
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                let info: [String: Any] = ["Label": "com.winklet.desktop",
                    "ProgramArguments": ["/usr/bin/open", "-a", Bundle.main.bundleURL.path],
                    "RunAtLoad": true, "KeepAlive": false]
                let data = try PropertyListSerialization.data(fromPropertyList: info, format: .xml, options: 0)
                try data.write(to: url, options: .atomic)
            } catch {
                showError("Unable to enable launch at login: \(error.localizedDescription)")
            }
        } else {
            try? FileManager.default.removeItem(at: url)
        }
    }

    private func showError(_ description: String) {
        let alert = NSAlert(); alert.messageText = "Winklet"
        alert.informativeText = description; alert.alertStyle = .warning
        alert.runModal()
    }

    @objc func openSettings() {
        if settingsWindow == nil {
            let view = SettingsView(p: prefs,
                                    onTest: { [weak self] in self?.buddy.react(.happy, bubble: "♥", seconds: 1.5) },
                                    onDance: { [weak self] in self?.testDance() },
                                    onFlip: { [weak self] in self?.buddy.flip() },
                                    onCenter: { [weak self] in self?.centerBuddy() })
            let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 560, height: 650),
                                  styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
            window.title = "Winklet — Customize"
            window.contentView = NSHostingView(rootView: view)
            window.center()
            window.isReleasedWhenClosed = false
            settingsWindow = window
        }
        NSApp.activate(ignoringOtherApps: true)
        settingsWindow?.makeKeyAndOrderFront(nil)
    }

    private func centerBuddy() {
        let frame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1280, height: 800)
        panel.setFrameOrigin(NSPoint(x: frame.midX - panel.frame.width / 2, y: frame.midY - panel.frame.height / 2))
        saveWindowPosition()
        if isHidden { toggleVisibility() }
    }

    func snapBuddyToEdge() {
        guard panel != nil else { return }
        let center = NSPoint(x: panel.frame.midX, y: panel.frame.midY)
        let screen = NSScreen.screens.first(where: { $0.frame.contains(center) }) ?? NSScreen.main
        guard let visible = screen?.visibleFrame else { return }
        var frame = panel.frame
        let left = visible.minX + 12
        let right = visible.maxX - frame.width - 12
        frame.origin.x = abs(frame.minX - left) < abs(frame.minX - right) ? left : right
        frame.origin.y = max(visible.minY, min(frame.minY, visible.maxY - frame.height))
        panel.setFrame(frame, display: true, animate: true)
        saveWindowPosition()
    }

    @objc func centerFromMenu() { centerBuddy() }
    @objc func boopBuddy() { prefs.napMode = false; buddy.react(.happy, bubble: "boop!", seconds: 1.5) }
    @objc func toggleNapMode() { prefs.napMode.toggle(); buddy.needsDisplay = true }
    @objc func toggleMusicReactions() { prefs.musicReactions.toggle(); checkMusic() }
    @objc func toggleNowPlayingCard() { prefs.showNowPlayingCard.toggle(); updateNowPlayingCard() }
    @objc func showBatteryStatus() {
        checkBattery()
        if let percent = lastBatteryPercent, let ac = lastACConnected {
            buddy.react(ac ? .charging : .curious,
                        bubble: "\(percent)% · \(ac ? "plugged in" : "battery")", seconds: 3)
        } else {
            buddy.react(.curious, bubble: "battery unavailable", seconds: 3)
        }
    }
    @objc func testBatteryReaction() {
        buddy.react(.lowBattery, bubble: "⚠️ try charging soon!", seconds: 5)
    }
    @objc func testDance() { prefs.napMode = false; buddy.react(.music, bubble: "♫ dance!", seconds: 5.0) }

    @objc func toggleVisibility() {
        isHidden.toggle()
        if isHidden { panel.orderOut(nil); nowPlayingPanel?.orderOut(nil) }
        else { panel.orderFrontRegardless(); updateNowPlayingCard(); buddy.react(.happy, bubble: "back!", seconds: 1.3) }
    }
    @objc func toggleAlwaysOnTop() { prefs.alwaysOnTop.toggle() }
    @objc func toggleClickThrough() { prefs.clickThrough.toggle() }
    @objc func flipBuddy() { buddy.flip() }
    @objc func quitApp() { saveWindowPosition(); NSApp.terminate(nil) }
}

@main
struct WinkletMain {
    static func main() {
        let app = NSApplication.shared
        let delegate = BuddyAppDelegate()
        app.delegate = delegate
        app.setActivationPolicy(.accessory)
        app.run()
    }
}
