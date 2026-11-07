# AirportItlwm vs. itlwm

The Intel Wireless-AC 9560 in the ThinkPad T490 is compatible with both `AirportItlwm.kext` and `itlwm.kext`. However, the two drivers integrate with macOS differently and have different advantages and limitations.

**Recommendation:** Use `AirportItlwm.kext` from [laobamac/itlwm](https://github.com/laobamac/itlwm) for macOS Sequoia and Tahoe. These builds provide native Wi-Fi integration without requiring OCLP root patches for Wi-Fi.

## Comparison 

| Feature | `AirportItlwm.kext` | `itlwm.kext` |
|---|---|---|
| **macOS integration** | Native AirPort interface | Ethernet-style interface in traditional builds |
| **Wi-Fi management** | Integrated into macOS System Settings and the menu bar | Requires [HeliPort](https://github.com/joshcalvert47/HeliPort) with traditional builds |
| **macOS Setup / Recovery** | Pro: Can provide Wi-Fi during Setup and in supported Recovery environments | Con: Traditional builds require HeliPort, which is unavailable during Setup |
| **Location Services** | Pro: Supports native Wi-Fi integration; actual location features depend on macOS and configuration | Con: Traditional builds lack native AirPort integration |
| **Hidden networks** | Compatibility depends on the driver build; verify before relying on hidden SSIDs | Pro: Supported by traditional builds |
| **Performance** | Performance and stability depend on the adapter, macOS version and build | Pro: The traditional driver has historically offered good performance and stability |
| **Connection management** | Pro: Uses native macOS Wi-Fi controls | Pro: HeliPort offers a separate interface for managing connections |
| **macOS compatibility** | Con: Requires a build matching the macOS version | Pro: Traditional builds can support multiple macOS versions, subject to compatibility |
| **Multiple macOS versions** | Con: Requires separate builds and appropriate `MinKernel` / `MaxKernel` settings | Pro: A compatible traditional build may cover multiple macOS versions |
| **iMessage / FaceTime** | Not inherently broken by this driver | Not inherently broken by this driver |
| **Wi-Fi 6 (802.11ax)** | Disabled by default in the documented Sequoia/Tahoe builds; can be enabled on supported adapters with `itlwm_he=1` | Depends on the driver build and adapter |
| **AirDrop / AWDL** | Not supported reliably by the documented Sequoia/Tahoe builds | Do not assume support; verify the specific build |

## Configuration in This Repository

My EFI uses `AirportItlwm.kext` by default.

| macOS version | Recommended driver |
|---|---|
| **Sonoma** | `AirportItlwm_Sonoma.kext` |
| **Sequoia** | `AirportItlwm_Sequoia.kext` build from laobamac/itlwm |
| **Tahoe** | `AirportItlwm_Tahoe.kext` build from laobamac/itlwm |

The slimmed-down kexts included in this repository are tailored to the Intel Wireless-AC 9560. Precompiled builds for older macOS versions are available in the [Additional Files](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Kexts/Slimmed_Kexts/Intel_AC-9650) section.

### Important configuration notes

- **Never load both drivers simultaneously.** Disable `itlwm.kext` when using `AirportItlwm.kext`, and vice versa.
- **Match the driver to macOS.** Sequoia and Tahoe require separate builds. When sharing an EFI between macOS versions, use `MinKernel` and `MaxKernel` to ensure that only the appropriate kext loads.
- **No modern Wi-Fi patches are required** with compatible Sequoia/Tahoe builds from laobamac/itlwm. The old workaround using `IOSkywalk.kext`, `IO80211FamilyLegacy.kext`, and a `com.apple.iokit.IOSkywalkFamily` block as well as root patching with OSCLP is no longer needed for this configuration.
- **AppleVTD is supported** by compatible builds. The BIOS, OpenCore quirks and device configuration must also be appropriate for your system.

## Using itlwm.kext Instead

If you prefer the traditional `itlwm.kext` driver and HeliPort:

1. Disable all enabled `AirportItlwm` variants in `config.plist`.
2. Enable `itlwm.kext` and configure its kernel-version settings for your installed macOS version.
3. Install [HeliPort](https://github.com/joshcalvert47/HeliPort).
4. Launch HeliPort and add it to Login Items if you want it to start automatically.
5. Connect to Wi-Fi through HeliPort.

## Legacy Method: AirportItlwm with OCLP Root Patches

The older workaround for Sequoia involved blocking `com.apple.iokit.IOSkywalkFamily`, injecting legacy Wi-Fi components, and applying OCLP root patches to restore compatibility with an  `AirportItlwm` build for macOS Ventura.

This method is **no longer required** when using compatible Sequoia/Tahoe builds from [laobamac/itlwm](https://github.com/laobamac/itlwm). It is retained here for users maintaining legacy configurations.

