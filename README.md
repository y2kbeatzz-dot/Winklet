# ⭐ Winklet — macOS desktop buddy

Winklet is a customizable floating star companion for macOS. **Current status: beta source upload pending.**

## Features
- 16 customizable eye styles, separate left/right eyes, automatic reactions and cursor tracking
- Apple Music and Spotify status reactions with readable full song information
- Plug/unplug reactions, battery percentage and configurable low-battery warnings
- Hue shifting, glow, size, movement, opacity, and a custom app icon
- Optional always-on-top, click-through and launch-at-login behavior

## Source upload
The owner is preparing the source with original replacement character artwork. This public repository currently contains documentation and CI configuration; **it is not yet a complete buildable checkout**.

The source upload package includes `Publish-to-GitHub.command`, which copies the source, resources, and installer to this repository after authenticating with GitHub CLI on macOS. When the upload has finished, the macOS build workflow will compile the project and (if successful) attach a beta DMG under **Actions → macOS build check**.

## Install (after source is uploaded)
Download the repository ZIP, unzip it, and double-click `Build-and-Install.command` on macOS 13+ with Xcode Command Line Tools installed. It creates a locally ad-hoc-signed app and DMG. This is **not notarized** by Apple.

## Privacy
Preferences stay on-device. Music metadata uses locally running players, with optional macOS Automation permission. Microphone reactions and input monitoring are optional.

## Art and rights
This is independent of Creature Company and lilguy.net. Product photographs from early private prototypes must not be included in a public release without appropriate rights. The planned public source package uses original programmatically drawn star sprites instead.

No open-source license has been selected. Public visibility alone does not grant redistribution rights.

## Release status
Beta preview; macOS runtime tests and a successful CI build are still required before publishing a stable release.
