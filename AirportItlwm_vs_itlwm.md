## AirportItlwm vs. itlwm WiFi kext
Although the Intel AC-9560 Card is compatible with both kexts (use either one or the other), there are Pros and Cons to both of them (check the [**FAQs**](https://openintelwireless.github.io/itlwm/FAQ.html#features) for other differences):

- **AirportItlwm**: (used in macOS Sonoma/Sequoia, requires root patching in Sequoa)
	- **Pro**: Can be used during macOS Setup/Recovery which is not possible with `itlwm.kext`
	- **Pro**: Supports Location Services and "Find My Mac"
	- **Pro**: Connects faster to Wi-Fi Hotspots than `itlwm.kext`
	- **Con**: Doesn't perform as well as `itlwm.kext`
	- **Con**: Can't connect to hidden WiFi Networks
	- **Con**: Requires the correct kext per macOS version, so running multiple version of macOS requires multiple versions of this kext controlled via `MinKernel` and `MaxKernel` settings
	- **Con**: iMessage and FaceTime don't work when using AirportItlwm (&rarr; See [Issue 14](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/14))

- **itlwm.kext** (used in macOS Tahoe)
	- **Pro**: `itlwm.kext` works across _multiple_ versions of macOS
	- **Pro**: Loading webpages feels a lot quicker than with `AirportItlwm` 
	- **Pro**: Can connect to hidden WiFi Networks
	- **Pro**: Does work with iMessage and FaceTime
	- **Con**: Requires [**HeliPort**](https://github.com/diepeterpan/HeliPort/releases) app to connect to Wi-Fi hotspots, so it can't be used during macOS Setup/Recovery
	- **Con**: Doesn't support Location Services

- Pre-compiled WiFi kexts for other versions of macOS can be found in the [Additional Files](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/Intel_AC-9650/itlwm) section! You will need them if you want to run older versions of macOS!

> [!NOTE]
> 
> My config uses `AirportItlwm` by default since it allows accessing the internet during macOS installation (unlike `itlwm.kext`, which requires an additional app to do so). Currently, `AirportItlwm` kexts for macOS Sonoma and Sequoia are included, while macOS Tahoe requires `itlwm.kext`.
> 
> If you want to use `itlwm`, disable `AirportItlwm` (all variants), enable `itlwm` and adjust the `MinKernel` setting to match the Kernel version of macOS (currently: 24.0.0 = macOS Sequoia). Next, download the [**HeliPort**](https://github.com/OpenIntelWireless/HeliPort) app, run it and add it to "Login Items" (in System Settings), so that it starts automatically with macOS.