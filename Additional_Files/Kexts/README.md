# Kexts

- **Slimmed kexts** for the Lenovo T490 that only contain code/firmware needed for the components present in this system to dramatically reduce the EFI folder to about a third of the original size (about 20 instead of 60 MB):
	- **AppleALC**: 86 kb, instead of 2.2 mb ([**DL**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Kexts/Slimmed_Kexts/AppleALC))
	- **Airportitlwm** and **itlwm**: each 1.5 mb, instead of 16 mb ([**DL**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Kexts/Slimmed_Kexts/Intel_AC-9650/itlwm/2.4.0))
	- **IntelBluetoothFirmware**: 558, kb instead of 7 mb ([**DL**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Kexts/Slimmed_Kexts/Intel_AC-9650/IntelBluetoothfirmware/2.5.0))
- **YogaSMC**: updated version of **YogaSMC** compatible with macOS Tahoe based on the fork by [jozews123](https://github.com/jozews321/YogaSMC) 

## Guides

- [**Compiling slimmed AppleALC kext**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/AppleALC/For_Compiling#compiling-slimmed-applealc-kext)
- [**Compiling slimmed Airportitlm/itlwm and Intel Bluetooth kexts**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/Intel_AC-9650#how-to-compile-a-slimmed-version-of-itlwmkext-and-intelbluetoothfirmware)
