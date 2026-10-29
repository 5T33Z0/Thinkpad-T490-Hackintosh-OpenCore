# Enabling ReYogaSMC in Post-Install

## Instructions

- Download the latest version (at least 2.2.0 or newer!) of the [ReYogaSMCApp](https://github.com/hoaug-tran/ReYogaSMC/releases) 
- Extact it
- Copy the `ReYogaSMC` app to Programs Folder
- Run the app and enter your admin password when prompted to grant it access to system controls, including sensor data, fan control, battery stats, etc.
- In **Overview**, select your preferred performance profile: `Quiet`, `Balanced`, or `Performance`.
- In **Cooling**, select `Custom Curves` and click **Apply**.
- Enable `Restore Fan Mode on Startup`
- Open the Options and enable Autostart

> [!IMPORTANT]
>
> **Avoid `BIOS Auto` mode under Fan Control!** 
>
> Due to a firmware bug on the ThinkPad T490, fan speed is capped at approximately 3,500 RPM, regardless of CPU load, while it can reach up to 6,700 RPM at max. This limitation can therefore lead to increased temperatures, thermal throttling, and reduced performance under sustained workloads.

## Working Fn-Hotkey Combos

Key Combo | Funtion
--- | ---
<kbd>Fn</kbd>+<kbd>F1</kbd>| Speaker Mute/Unmute
<kbd>Fn</kbd>+<kbd>F2</kbd>| Volume down
<kbd>Fn</kbd>+<kbd>F3</kbd>| Volume Up
<kbd>Fn</kbd>+<kbd>F4</kbd>| Mic Mute/Unmute 
<kbd>Fn</kbd>+<kbd>F5</kbd>| Backlight down
<kbd>Fn</kbd>+<kbd>F6</kbd>| Backlight up
<kbd>Fn</kbd>+<kbd>F7</kbd>| Opens Display Options
<kbd>Fn</kbd>+<kbd>F8</kbd>| Wifi Enable/Disable
<kbd>Fn</kbd>+<kbd>F9</kbd>| Opens System Settings
<kbd>Fn</kbd>+<kbd>F10</kbd>| Bluetooth Enable/Disable
<kbd>Fn</kbd>+<kbd>F11</kbd>| Keyboard Disable/Enable
<kbd>Fn</kbd>+<kbd>F12</kbd>| Opens ReYogaSMCNC's Settings

## Credits
- Hoaug-Tran for [**ReYogaSMC**](https://github.com/hoaug-tran/ReYogaSMC)
- Zhen-Zen for original [**YogaSMC**](https://github.com/zhen-zen/YogaSMC)
