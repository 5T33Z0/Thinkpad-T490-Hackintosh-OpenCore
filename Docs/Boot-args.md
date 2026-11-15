# Used Boot-args

Argument | Kext | Effect
---------|------|---------
`unfairgva`=4 | Whatevergreen | Spoofs iMacPro1,1 (Mac-7BA5B2D9E42DDD94) board identifier via the hwgva-id IORegistry property so that Apple Music (Music.app / fairplayd) can play FairPlay DRM-protected audio.
`rtcfx_exclude=80-AB,B0-B4` | RTCMemoryFixup | Prevents writes to specified RTC memory regions to avoid conflicts with macOS AppleRTC and system firmware to prevent crashes or unexpected reboots during hibernation recovery (Mode 25).
`-rtsfbeta` | RealtekCardReader | To load the kext on macOS 13+
`-reytrace` <br> `-reynolap` <br> `-reynostp`| ReYogaSMC | `-reytrace`: Logs entry/return for WMI calls, VPC refresh groups and telemetry, plus initialization boundaries.<br> `-reynolap`: automatically clears Lap Mode (CQL) whenever it gets activated, preventing the CPU power limit from being stuck at around 14W <br> `-reynostp`: automatically clears Skin Temperature Protection (STP) whenever it gets activated, preventing the CPU from being throttled down to 600 MHz

## About using `unfairgva=4` on Intel iGPUs

Although `unfairgva=4` is primarily intended for AMD GPUs, it is also used on Intel iGPU systems to enable FairPlay DRM playback in Apple Music and Apple TV by spoofing the `iMacPro1,1` board identifier through WhateverGreen's `hwgva-id` property.

However, this workaround introduces compatibility issues with Apple's media stack and browser sandboxing, potentially breaking hardware video decoding in Safari and Firefox (VP9/HEVC).

**VPXFixup** addresses these issues without requiring users to abandon the `unfairgva=4` workaround.

For technical details, affected processes, and supported configurations, see the [VPXFixup repository](https://github.com/5T33Z0/VPXFixup).
