#!/bin/zsh
set -e
cd "$(dirname "$0")"
echo "✦ Building Winklet for macOS"
if [[ $(uname -s) != Darwin ]]; then echo "Run this on a Mac"; exit 1; fi
command -v xcrun >/dev/null || { echo "Install Xcode Command Line Tools"; exit 1; }
mkdir -p Resources build/Winklet.app/Contents/MacOS build/Winklet.app/Contents/Resources
echo "[1/5] Generating original Winklet artwork"
xcrun swift scripts/generate-art.swift Resources

echo "[2/5] Building custom application icon"
mkdir -p build/Winklet.iconset
for sz in 16 32 128 256 512; do
  xcrun sips -z "$sz" "$sz" Resources/WinkletIcon.png --out "build/Winklet.iconset/icon_$sz"x"$sz.png" >/dev/null
  dim=$((sz * 2))
  xcrun sips -z "$dim" "$dim" Resources/WinkletIcon.png --out "build/Winklet.iconset/icon_$sz"x"$sz@2x.png" >/dev/null
done
xcrun iconutil -c icns build/Winklet.iconset -o Resources/Winklet.icns

echo "[3/5] Compiling native Swift app"
SDK=$(xcrun --sdk macosx --show-sdk-path)
ARCH=$(uname -m)
xcrun swiftc -parse-as-library -swift-version 5 -O -sdk "$SDK" \
  -target "$ARCH-apple-macos13.0" \
  -framework AppKit -framework SwiftUI -framework Combine \
  -framework CoreImage -framework AVFoundation -framework UserNotifications \
  Winklet.swift -o build/Winklet.app/Contents/MacOS/Winklet \
  2>&1 | tee build/Winklet-compile.log
cp Info.plist build/Winklet.app/Contents/
cp Resources/StarFront.png Resources/StarBack.png Resources/MenuIcon.png Resources/WinkletIcon.png Resources/Winklet.icns build/Winklet.app/Contents/Resources/
xcrun codesign --force --sign - build/Winklet.app
echo "[4/5] Packaging a drag-and-drop DMG"
mkdir -p build/stage
rm -rf build/stage/Winklet.app
ditto build/Winklet.app build/stage/Winklet.app
ln -sfn /Applications build/stage/Applications
hdiutil create -quiet -volname Winklet -srcfolder build/stage -ov -format UDZO build/Winklet-macOS.dmg
echo "[5/5] Installing Winklet"
DEST=/Applications/Winklet.app
if [[ ! -w /Applications ]]; then mkdir -p ~/Applications; DEST=~/Applications/Winklet.app; fi
/usr/bin/osascript -e 'tell application id "com.winklet.desktop" to quit' >/dev/null 2>&1 || true
rm -rf "$DEST"
ditto build/Winklet.app "$DEST"
open "$DEST"
echo "✓ Installed: $DEST"
echo "✓ Installer DMG: $PWD/build/Winklet-macOS.dmg"
read -r '?Press Return to close…'