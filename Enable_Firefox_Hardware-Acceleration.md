# Firefox Hardware Acceleration Guide

**Lenovo ThinkPad T490 · Hackintosh macOS · Intel UHD 620 (spoofed as UHD 630)**

---

## Background

By default, Firefox on macOS does not reliably enable hardware video decode via Apple's VideoToolbox, even when the iGPU is fully capable. On the T490, this means YouTube falls back to software (CPU) decoding, causing high CPU usage and heat during playback.

The UHD 620 supports hardware H264 decode via VideoToolbox, but not VP9, AV1, or HEVC. YouTube preferentially serves VP9 in most browsers, so the fix requires two things: forcing Firefox to use VideoToolbox, and forcing YouTube to serve H264.

---

## Step 1: `about:config` Flags

Open `about:config` in Firefox and set the following flags. Double-click a boolean to toggle it. Restart Firefox fully after making changes.

| Flag | Value |
|------|-------|
| `media.hardware-video-decoding.enabled` | `true` |
| `media.hardware-video-decoding.force-enabled` | `true` |
| `media.webrtc.hw.h264.enabled` | `true` |
| `layers.acceleration.force-enabled` | `true` |

> Full restart required — close all Firefox windows, don't just reload the tab.

---

## Step 2: Install `enhanced-h264ify` Extension

Install the [**enhanced-h264ify**](https://addons.mozilla.org/en-US/firefox/addon/enhanced-h264ify/) extension and block the following codecs in its settings:

- **VP9**
- **AV1**
- **VP8** (recommended)

Leave **H264** *unblocked*. This forces YouTube to serve H264, which is the only codec with hardware decode support on UHD 620.

---

## Step 3: Verify

**Hardware decode active:** Go to `about:support` → Media section. H264 should show "Supported" under both Software and Hardware Decoding columns.

**YouTube serving H264:** Right-click a YouTube video → Stats for nerds → Codec should show `avc1.xxxxxx`. If it shows `vp09` or `av01`, check the extension settings.

---

## UHD 620 Codec Support

| Codec | HW Decode | YouTube Default | Action |
|-------|-----------|-----------------|--------|
| H264 (avc1) | ✅ | With h264ify | Use this |
| VP9 | ❌ | ✅ Yes | Block via h264ify |
| AV1 | ❌ | Some videos | Block via h264ify |
| HEVC | ❌ | ❌ No | N/A |

This is a hardware limitation — not a Hackintosh or driver issue.

---

## Troubleshooting

**H264 still shows software-only in about:support** — confirm all four flags are `true` and do a full Firefox restart. Also check that WhateverGreen and Lilu kexts are up to date.

**YouTube still showing vp09/av01** — open the extension popup and confirm it's enabled for youtube.com. Check that VP9 and AV1 are checked for blocking.

**CPU still high** — if Firefox Web Content process exceeds ~15% CPU during 1080p playback, something isn't working. Safari is a reliable fallback with no configuration needed.
