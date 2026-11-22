# Optional T490 Alpine Ridge native Thunderbolt classification

**Experimental, opt-in hardware-support recipe. No default EFI, USB map or configuration is changed.** See [proposal #90](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/90).

The two small SSDTs were tested on a ThinkPad T490 with **Alpine Ridge LP/JHL6240**, Sonoma **14.8.5 / 23J423**, and an **OWC TB5DOCK11P**. They address missing native Thunderbolt classification metadata in that configuration, not Thunderbolt firmware or an Apple-driver binary defect.

**Adding these tables alone to the current upstream release has not been hardware-tested.** The successful configuration also retained the existing Sonoma PCI-enumeration patch and corrected its older USBMap for firmware-described CR01 HS02/SS02. Their individual causal contributions were not isolated. Current upstream uses `SSDT-XHUB`, so this recipe does not transplant that USBMap or change `SSDT-XHUB`.

[OWC's manual](https://eshop.macsales.com/manuals/owc-thunderbolt-5-dock-support-manual) specifies macOS 15+ for this dock on Intel/Thunderbolt 3. These Sonoma observations do not establish official support.

## Mechanism

### `SSDT-TBCLASS`

On Darwin, when the existing `\_SB.PCI0.RP05.PXSX.TBDU._ADR` is `0x00020000`, install the paired properties on existing nodes:

- `RP05.PXSX`: `PCI-Thunderbolt = 1` when OEM `NEXP` is nonzero.
- `RP05.PXSX.TBDU`: `PCIHotplugCapable = 0`, as an **AML Integer**, not a data buffer, to exclude the onboard USB bridge from ordinary tunnel-hotplug treatment.

`NEXP` is firmware capability/policy, **not an ownership grant**. The metadata must be available at the early property query; waiting for the later `OSCC` negotiation result in that query previously withheld the marker, with no subsequent re-query. OEM `_OSC` remains untouched: the table does not request or force ownership.

[Apple IOPCIFamily 617.100.7](https://github.com/apple-oss-distributions/IOPCIFamily/tree/IOPCIFamily-617.100.7) distinguishes generic and native Thunderbolt hotplug classes. Generic propagation can clear downstream link-interrupt handling; the qualified tunnel path preserves the relevant behavior. This explains the classification mechanism, not every IRQ, firmware state or physical D-state.

### `SSDT-RP05HP`

On Darwin, add `_RMV` to the first ACPI child, `RP05.PXSX`, returning `OSCC & 1`. This reads the OEM negotiation result without acquiring ownership. A later sibling's existing removability method is not the first-child hint used here.

Neither table adds devices, operation regions, loggers, counters, reset/power calls, notifications or hardware writes. The topology guard in TBCLASS does **not** make arbitrary firmware layouts safe: RP05HP still requires its declared PXSX/OSCC objects, and both tables require collision checks.

## Compatibility checks before opting in

Check the target machine's own firmware and active injected tables, not just its T490 model name:

1. The actual controller matches the tested Alpine Ridge LP topology (tested NHI `8086:15bf`, local USB `8086:15c1`). Do not assume a README's controller label establishes hardware identity.
2. Existing `\_SB.PCI0.RP05.PXSX` and `TBDU` have the expected path and local `_ADR = 0x00020000`.
3. OEM `\OSCC` and `\NEXP` exist with the expected semantics; neither is manufactured or rewritten by these tables.
4. No active table already defines `PXSX._RMV`, `PXSX._DSM` or `PXSX.TBDU._DSM`. Do not load competing methods or combine blindly with other Thunderbolt SSDTs, including optional T480 reset/power recipes.
5. Review the current USB mapping separately. Do not enable two conflicting mapping implementations or assume the old HS02/SS02 correction applies directly to `SSDT-XHUB`.
6. Retain the existing `Fix PCI bus enumeration (Sonoma+)` patch for the tested setup; do not add a duplicate patch or infer that this recipe removes that prerequisite.

Static inspection of upstream commit `75b4c29423040b933c72ed95bccdb25b92edde06` and release **OC_109.10** found the same enabled Sonoma PCI patch, a separate `SSDT-XHUB` USB map, and no competing definitions at those three method paths in the released enabled SSDTs. The published firmware snapshot contains the required fields and conditional TBDU topology. This is a bounded static review, not proof of another machine's firmware values, full firmware compatibility or a current-release hardware test.

An offline namespace comparison loaded the published firmware snapshot and enabled release SSDTs with the four configured DSDT renames, initialization methods disabled and explicitly simulated NVS values. Adding this pair produced the expected two `_DSM` methods and one `_RMV`, with **no new diagnostics** versus the baseline. The baseline's unresolved `HS14` and zero-length `IO_D`/`IO_P` diagnostics remained; they were not silently fixed. This userspace simulation does not measure actual ownership grants or validate the USB map on hardware.

## Optional integration and recovery

`ACPI-Add.plist` is only an **example fragment**, with **both entries disabled**. It is not a bootable config and must not replace a complete `config.plist` or its existing `ACPI/Add` array.

After the checks above, on a backed-up test EFI:

1. Copy only `SSDT-RP05HP.aml` and `SSDT-TBCLASS.aml` into `OC/ACPI`.
2. Append the fragment's two entries to your own `ACPI/Add` array, preserving all existing entries and order. Enable the two new entries together only for a deliberate test after confirming prerequisites.
3. Preserve your own SMBIOS, NVRAM, security, Wi-Fi, battery policy and boot settings. Keep existing mappings unless separately reviewed; no USBMap replacement is included here.
4. Validate the complete resulting config with the validator matching your OpenCore build, verify referenced files, and keep a verified recovery USB. Do not reboot from an incomplete update.
5. To revert, disable the two new entries in the test EFI and restore its verified backup if necessary. No NVRAM reset is prescribed.

No whole-EFI copy, Microsoft/BOOT replacement, Windows boot, firmware flash, BIOS/security change or NVRAM reset is part of this recipe. No runtime hotplug or reboot command is automated.

## Build

Build outside the EFI and this source directory:

```sh
mkdir -p /tmp/t490-alpine-ridge-build
iasl -p /tmp/t490-alpine-ridge-build/SSDT-RP05HP SSDT-RP05HP.dsl
iasl -p /tmp/t490-alpine-ridge-build/SSDT-TBCLASS SSDT-TBCLASS.dsl
```

Run these commands from this folder. With ACPICA **20260408**, compilation has zero errors/warnings. TBCLASS has expected conditional-method remarks: 2184 twice and 2095 once. The included AMLs are the minimal, non-diagnostic tables used in the successful configuration:

| Table | Bytes | SHA-256 (ACPICA 20260408) |
| --- | ---: | --- |
| SSDT-RP05HP.aml | 120 | `e7f88299da2b3819b5a777dc8095dfe2d96eba47cd09ed9809ccc1e77ca99e94` |
| SSDT-TBCLASS.aml | 420 | `fa37566263739c6364eaecc503c89f2cf03e0b1abf3ec04f4c771d000989c7af` |

Compiler-version changes can alter table header bytes. Inspect semantics, length and checksum rather than assuming every compiler produces identical hashes. Never copy offline test fixtures into an EFI.

## Verification evidence and limits

The captured generic-classification baseline lost the dock USB branch after a host reconnect and did not recover it, although stale PCI registry objects persisted. A diagnostic build and a separate minimal build each passed one controlled reconnect. In the minimal run:

- No ACPIDebug, tracing or observation counters were active.
- All eight dock USB identities disappeared and returned through the remote PCI USB controller `8086:5787`, with newly registered controller/driver/device objects, eight stable consecutive samples and no capture errors.
- Native classification was observed as follows:

| Node | Hotplug type / property |
| --- | --- |
| RP05 | `0x32` |
| PXSX upstream | `0x31`, `PCI-Thunderbolt` present |
| First NHI branch | `0x01` |
| Dock-facing bridge | `0x30`, `IOPCITunnelLinkChange` present |
| Local TBDU USB bridge | `0x02`, `PCIHotplugCapable` is Integer 0 |

The same minimal bundle subsequently passed an internal macOS boot with the test USB absent. No additional reconnect was performed after that boot. A diagnostic boot directly measured `OSCC = 5`; that is historical, not a fresh direct ownership measurement for the minimal/internal builds.

Offline checks covered non-Darwin behavior, unsupported DSM requests, missing/wrong topology, NEXP 0/1/2 with OSCC 0/1/4/5, repeated calls, Integer-zero output and no writes to the simulated fields. Offline namespace checks are not live firmware execution or runtime hotplug proof.

These two controlled reconnect successes are not certification of repeated cold boots, repeated hotplug, sleep/wake, displays, LAN, VM passthrough, throughput, all T490 variants or other macOS versions. The remote route is not proof of ordinary PCH USB fallback. Sanitized evidence and the original tested sources are linked from [issue #90](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/90); no private dumps or machine identifiers are required by this contribution.
