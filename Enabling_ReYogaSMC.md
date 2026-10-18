# Enabling ReYogaSMC in Post-Install

## Status
- Working: Keyboard Shortcuts
- Not working: "Device" and  "Cooling and Power" features are not available yet. Needs further investigation

## Instructions

- Download the [ReYogaSMC.zip](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/raw/refs/heads/main/Additional_Files/Kexts/ReYogaSMC/ReYogaSMC_2.1.1.zip) from my repo
- Extact it
- Copy the `ReYogaSMCNC` app to Programs and run it
- Open ReYogaSMC Settins: In the Menu Bar, click in the `L'` icon and select `Settings…` 
- In the "Keyboard" tab, enable `Map Legion shortcut kexs to macOS action` &rarr; This opens the Accessibilty Options in System Settings.
- Allow ReYogaSMCNC to control the computer so the keyboard shortcuts work
- Add YogaSMC as a login Item via System Settings (via App doesn't work)

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
<kbd>Fn</kbd>+<kbd>F9</kbd>| System Setting (Sequoia), in Taho it only opens ReYogaSMCNC's Settings
<kbd>Fn</kbd>+<kbd>F10</kbd>| :warning: Don't use, it crashes the ReYogaSMCNC app!
<kbd>Fn</kbd>+<kbd>F11</kbd>| Keyboard Disable/Enable
<kbd>Fn</kbd>+<kbd>F12</kbd>| Opens ReYogaSMCNC's Settings

## Credits
- Hoaug-Tran for [ReYogaSMC](https://github.com/hoaug-tran/ReYogaSMC)
- Zhen-Zen for original [YogaSMC](https://github.com/zhen-zen/YogaSMC)
