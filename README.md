# ⭐ Winklet

**A tiny, expressive desktop companion for macOS.**

Winklet floats on your desktop, reacts to what you're doing, and lets you customize its look and personality.

> **Preview / beta:** Winklet's macOS compilation and runtime behavior have not yet been fully verified. Please do not treat pre-release artifacts as notarized, signed releases.

## Features

- **Eye Studio:** 16 eye styles, independent left/right eyes, eye size and spacing, cursor gaze and automatic moods
- **Music:** Apple Music and Spotify play/pause and track-change reactions, three dance modes, full title / artist / album card
- **Power:** charging/unplugged reactions, configurable low-battery warnings and optional macOS notifications
- **Appearance:** hue shift, brightness, saturation, size, glow, opacity, blink rate and movement
- **Desktop controls:** optional always-on-top, click-through, multiple Spaces, edge snapping, Dock icon and launch at login
- **Local-first:** preferences remain on your Mac; no analytics service or account required

## macOS requirements

macOS 13 or later and Xcode Command Line Tools (or full Xcode) to compile locally.

## Install from source

Once the source bundle has been uploaded:

1. Download the latest source ZIP from this repository.
2. Unzip and open `Build-and-Install.command`.
3. Open Winklet using its menu-bar star and choose **Customize Winklet…**.
4. Grant Automation permission only if you want Apple Music or Spotify metadata.

The script produces a local app and DMG. Builds are ad-hoc signed, **not notarized**.

## Art / attribution

This is an independent fan-style desktop companion, not affiliated with Creature Company or lilguy.net. Some early private prototypes used user-supplied images of a third-party physical product. **Those product photos are not licensed for public redistribution and should not be added to the public repo without permission.** Use original or appropriately licensed character artwork for public builds.

## Privacy

- No network telemetry or analytics.
- Music metadata is obtained from locally running player applications with macOS Automation permission.
- Optional microphone reactions use sound levels rather than recording speech.
- Typing activity is optional; Winklet does not need to store keystrokes.

## Status

The repository is being prepared for a first **beta** build. A downloadable release will follow only after a successful macOS build, and stable release status requires testing on a real Mac.

## Legal

No open-source license has been selected yet. Public access to this repository does not automatically grant rights to reuse or distribute its contents.
