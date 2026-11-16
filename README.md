# ✦ Winklet

**An expressive little star buddy for macOS.** Customize the eyes and color, keep it over your windows (if you want), watch it dance to music, and let it remind you when your battery needs charging.

[![macOS beta build](https://github.com/y2kbeatzz-dot/Winklet/actions/workflows/macos-build.yml/badge.svg)](https://github.com/y2kbeatzz-dot/Winklet/actions/workflows/macos-build.yml)

## Download

**[Download Winklet v1.4 beta for macOS (.dmg)](https://github.com/y2kbeatzz-dot/Winklet/releases/download/v1.4.0-beta.1/Winklet-v1.4.0-beta.1-macOS-universal.dmg)**

[All releases](https://github.com/y2kbeatzz-dot/Winklet/releases) · [Release notes](https://github.com/y2kbeatzz-dot/Winklet/releases/tag/v1.4.0-beta.1) · [Build status](https://github.com/y2kbeatzz-dot/Winklet/actions)

Compatible with Apple Silicon and Intel Macs running macOS 13 or newer. The GitHub Actions build has passed. The application is in **beta**, is **ad-hoc signed (not notarized)**, and still needs real-device testing. Open the DMG and drag Winklet into Applications. macOS may require approval in **System Settings → Privacy & Security**.

## Features

- **Eye Studio:** 16 eye styles, independent left and right styles, color, pupil size, gaze following, blinking, and mood reactions
- **Music:** Apple Music / Spotify track-change and play/pause reactions; selectable dancing; full title, artist, and album
- **Power:** plugged-in / unplugged reactions, battery percentage, adjustable low-battery threshold, optional notification alerts
- **Appearance:** hue shift, saturation, brightness, glow, opacity, scale, name
- **Desktop:** optional Always on Top, click-through, all-Spaces overlay, floating, snapping, launch at login
- **Privacy:** on-device preferences, no account, optional microphone and input monitoring permissions

## Website

The **[Winklet launch website](https://y2kbeatzz-dot.github.io/Winklet/)** is deployed on GitHub Pages from the [gh-pages branch](https://github.com/y2kbeatzz-dot/Winklet/tree/gh-pages). Its source lives in [docs/index.html](docs/index.html), with a successful [Pages deployment run](https://github.com/y2kbeatzz-dot/Winklet/actions/runs/43839283269).

## Building from source

On a Mac with Xcode Command Line Tools, clone the repository, then run **Build-and-Install.command**. It generates original art and icons using [scripts/generate-art.swift](scripts/generate-art.swift), compiles the native AppKit/SwiftUI app with the entrypoint fix, signs locally, creates a DMG, and installs Winklet.

Automated release builds produce a **universal DMG** for Apple Silicon and Intel, attaching it and its SHA-256 checksum to the beta release.

## Independent artwork

Winklet is not affiliated with Creature Company or lilguy.net. Public builds use original programmatically generated character artwork, **not third-party product photographs**.

## Privacy and permissions

Music reactions obtain track metadata from running Apple Music or Spotify with optional macOS Automation permission. Microphone mode is opt-in and measures sound volume. Typing reactions are opt-in and do not store keystrokes. No telemetry or recordings are sent to external servers.

## Beta feedback

Please [report bugs here](https://github.com/y2kbeatzz-dot/Winklet/issues). Include macOS version, Apple Silicon or Intel, and error logs.

**License:** No open-source license has been granted. Public source visibility does not imply permission to redistribute or relicense the software.
