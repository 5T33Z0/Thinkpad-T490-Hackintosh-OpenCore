# How ReYogaSMC Addresses Lenovo T490 Firmware & Thermal Management Issues

I had stopped using the original [YogaSMC](https://github.com/zhen-zen/YogaSMC) because the project had not received updates for several years. Later, I came across a community fork called [ReYogaSMC](https://github.com/hoaug-tran/ReYogaSMC), which picked up where the original project had left off.

Seeing an opportunity to bring hardware support to the Lenovo ThinkPad T490, I opened [Issue #1](https://github.com/hoaug-tran/ReYogaSMC/issues/1) to request support for the device.

What started as a straightforward hardware-support request quickly turned into a much more interesting investigation.

During testing, the dev discovered several problems with the T490's firmware-level power and thermal management. CPU performance could unexpectedly drop to 600 MHz or become restricted to its base frequency under sustained workloads. The fan control also failed to utilize the fan's full RPM range when additional cooling was needed. Interestingly, similar fan-control limitations could also be observed under Windows, indicating that this wasn't exclusively a macOS issue.

The subsequent investigation, carried out together with the ReYogaSMC developer, uncovered several underlying issues involving Lenovo's Dynamic Thermal Control (DYTC), ACPI event handling, Embedded Controller (EC) communication and thermal protection mechanisms.

As the investigation progressed, the original support request evolved into a series of driver improvements and new features, including:

- Correct handling of DYTC events and thermal-state queries.
- Control over Lenovo's CQL (Lap Mode) and STP (Skin Temperature Protection) mechanisms.
- Improved CPU power-profile handling.
- Custom fan curves and corrected fan-speed control.
- Improved fan-state synchronization and restoration.

The result goes well beyond adding T490 compatibility. ReYogaSMC now provides alternative control over several firmware-level functions, addressing problems that affect the laptop's CPU performance and thermal management.

The following sections document the issues discovered, their underlying technical causes and the solutions developed along the way.

## 1. CPU Power Management & Thermal Protection

The T490 uses Lenovo's **Dynamic Thermal Control** (DYTC) interface to manage CPU power profiles and thermal protection. During testing, two separate firmware protection mechanisms were identified as causes of unexpected CPU throttling: CQL (**Lap Mode**) and STP (**Skin Temperature Protection**).

### CQL – Lap Mode

**Issue:** CPU performance could be unexpectedly restricted, particularly after movement or vibration, even when the laptop was sitting on a desk.

The T490's Lap Mode detection proved excessively sensitive. When triggered, CQL (Configurable Quality of Life) imposed a CPU power restriction of approximately 14 W. This could cause the CPU to remain at its base frequency (1.5 GHz) under sustained workloads, such as compiling projects in Xcode.

**Cause:** Lenovo's firmware activates CQL based on movement and thermal context. The detection mechanism can trigger unnecessarily, restricting CPU power even when Lap Mode is not actually needed.

**Solution:** ReYogaSMC introduced the `-reynolap` boot argument, which automatically clears the CQL state whenever Lap Mode is activated.

### STP – Skin Temperature Protection

**Issue:** Following sleep or under certain operating conditions, CPU frequency could become locked at approximately 600 MHz, resulting in severe performance degradation.

**Cause:** STP is a separate firmware-level protection mechanism designed to prevent excessive surface temperatures. During testing, CPU temperatures reached approximately 90–98 °C, causing the Embedded Controller (EC) to activate STP and severely restrict CPU performance.

Insufficient cooling from the custom fan curve contributed to this particular incident. Additionally, ReYogaSMC initially had a software bug that prevented it from correctly recognizing the active STP state. This caused power-profile readback errors and made the profile selector unavailable.

**Solution:** ReYogaSMC improved STP state detection and handling. The `-reynostp` boot argument can automatically clear STP when activated.

**Note:** CQL and STP are independent protection mechanisms and can be cleared separately. Disabling them reduces firmware-level protection, so adequate cooling and temperature monitoring are essential.

→ [ReYogaSMC – Issue #11: T490 CPU Throttling (CQL & STP)](https://github.com/hoaug-tran/ReYogaSMC/issues/11)

## 2. DYTC Event Loop & Power Profile Handling

**Issue:** Excessive `DYTC` event generation was observed during testing, potentially affecting system performance and Geekbench multicore results.

The diagnostics recorded approximately 15,460 events with code `0x6032`.

**Cause:** The T490 uses the `PSC` (Power State Control) implementation of DYTC rather than the MMC implementation found on some other Lenovo models.

The original ReYogaSMC implementation incorrectly handled thermal-state queries:

- Reading the thermal state could trigger a Lap Mode toggle.
- Each resulting SET command generated another DYTC event.
- This created a potentially endless ACPI event loop.

This was a driver-level implementation issue, not a hardware defect.

**Solution:** The developer changed thermal-state queries to be read-only and introduced a background refresh interval of two seconds, preventing unnecessary DYTC state changes and excessive event generation.

→ [ReYogaSMC – Issue #1: T490 DYTC & Fan Control](https://github.com/hoaug-tran/ReYogaSMC/issues/1)

## 3. CPU Fan Control

**Issue:** The T490's native automatic fan control does not utilize the fan's full RPM range under macOS.

During testing, the following behavior was observed:

| Fan mode | Observed speed |
|---|---:|
| BIOS Auto | ~3,500 RPM |
| Manual Level 7 | ~4,500 RPM (initial implementation) |
| Full Speed | ~6,700–7,000 RPM |

The fan itself is capable of reaching considerably higher speeds than the automatic fan-control behavior typically provides.

**Cause:** The BIOS's automatic fan-control behavior does not adequately utilize the available fan-speed range. Additionally, the initial ReYogaSMC implementation had incorrect fan-level mapping and fan-curve transition behavior.

Specific problems included:

- Manual Level 7 did not reach the same maximum speed as Full Speed.
- The custom fan curve could drop directly from Full Speed to Level 5 instead of gradually reducing fan speed.
- Fan-mode restoration and synchronization across sleep/wake and reboot required improvements.

**Solution:** ReYogaSMC introduced and refined custom fan-curve support.

**The improvements include**:

- Corrected fan-level mapping so Level 7 can reach the maximum available fan speed.
- Configurable fan curves based on CPU temperature.
- Gradual fan-speed transitions, reducing speed one level at a time with delays between steps.
- Improved fan-mode restoration and synchronization.

This allows the fan to ramp up earlier under load and utilize its full cooling capacity instead of relying exclusively on the BIOS's automatic behavior.

→ [ReYogaSMC – Issue #1: T490 Fan Control](https://github.com/hoaug-tran/ReYogaSMC/issues/1)

## 4. Current Configuration & Results

The following configuration addresses the observed CPU throttling issues:

| Boot argument | Function |
|---|---|
| `-reynolap` | Automatically clears CQL (Lap Mode) when activated |
| `-reynostp` | Automatically clears STP when activated |

Both mechanisms are handled independently by ReYogaSMC.

### Verified results

Testing on November 15, 2026, confirmed the following improvements:

- No more CPU frequency lock at 600 MHz after sleep.
- No more unexpected CPU frequency fallback to base frequency during boot or sustained workloads.
- No more performance restrictions caused by unwanted Lap Mode activation.
- CPU power profiles (Performance, Balanced and Quiet) working correctly.
- Custom fan curve adjusted to activate Full Speed earlier.
- Improved cooling under sustained CPU workloads.

### Geekbench 5 – Multicore Results

&rarr; see [Benchmarks](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Diagnostics/Benchmarks)

---

## Technical References

- [ReYogaSMC #1 – ThinkPad T490: DYTC, Fan Control & Power Management](https://github.com/hoaug-tran/ReYogaSMC/issues/1)
- [ReYogaSMC #11 – ThinkPad T490: CPU Throttling, CQL & STP](https://github.com/hoaug-tran/ReYogaSMC/issues/11)
