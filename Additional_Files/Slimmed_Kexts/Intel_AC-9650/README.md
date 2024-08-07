# How to compile a slimmed version of `itlwm.kext` and `IntelBluetoothFirmware`

The size of the Intel Wireless kext can be reduced drastically by about factor 10 (1.6 MB instead of 16) by deleting all the unnecessary firmwares for other Wi-Fi cards except the one for the Intel AC-9560 that comes stock with the Lenovo T490. Same applies to `IntelBluetoothfirmware`

## Preparations

### Install Xcode
- Download the correct version of [**Xcode**](https://xcodereleases.com/?scope=release) for your system. 
- Move the Xcode app to the "Programs" folder – otherwise compiling might fail.

### Prepare the `itlwm` source code
- Download [**itlwm**](https://github.com/OpenIntelWireless/itlwm) source code (click on "Code" and select "Download zip")
- Unzip the file – "itlwm-master" folder will be created
- Run Terminal
- Enter `cd ~/Downloads/itlwm-master`
- Next, enter `git clone https://github.com/acidanthera/MacKernelSDK` to download MacKernelSDK into the "itlwm-master" folder
- Leave the Terminal window open for later use
- Download the DEBUG version of Lilu, extract it and place the kext in the itlwm-master folder
- In Finder, navigate to `~/Downloads/itlwm-master/itlwm/firmware`
- Delete every file except `iwm-9000-46`

### Prepare the `IntelBluetoothFirmware` source code
- Download [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware) source code (click on "Code" and select "Download zip")
- Unzip the file – "IntelBluetoothFirmware-master" folder will be created
- Run Terminal
- Enter: `cd ~/Downloads/IntelBluetoothFirmware-master`
- Next, enter `git clone https://github.com/acidanthera/MacKernelSDK` to download MacKernelSDK into the "IntelBluetoothFirmware-master" folder
- Leave the Terminal window open for later use
- Download the DEBUG version of Lilu, extract it and place the kext in the IntelBluetoothFirmware-master folder
- In Finder, navigate to `~/Downloads//IntelBluetoothFirmware-master/IntelBluetoothFirmware/fw`
- In the `fw` folder delete all the firmware files except two: `ibt-17-16-1.ddc` and `ibt-17-16-1.sfi`
- If present, also delete `FwBinary.cpp` from /IntelBluetoothFirmware-MASTER/IntelBluetoothFirmware

## Compiling the kexts

### Compiling `AirportItlwm` and `Itlwm`
Enter the following commands (the lines without `#`) in Terminal and execute them one by one to build itlwm as well as AirportItlwm kexts for all versions of macOS:

```
# remove generated firmware
rm include/FwBinary.cpp

# generate firmware
xcodebuild -project itlwm.xcodeproj -target fw_gen -configuration Release -sdk macosx

# building the kexts
 xcodebuild -alltargets -configuration Release
```

Once compiling is completed the kexts will be located at `~/Downloads/itlwm-master/itlwm/build/Release`:<br>![kexts](https://github.com/user-attachments/assets/719630a7-54db-4c3e-b214-770dd24302a3)

### Compiling `InteBluetothFirmware`

- Run Terminal 
- Enter: `cd ~/Downloads/IntelBluetoothFirmware-master`
- Next, enter ` xcodebuild -alltargets -configuration Release`to compile the kexts
- The finished kexts will be located under `~/Downloads/IntelBluetoothFirmwar-master/build/Release`:<br>![itlbtfw](https://github.com/user-attachments/assets/c9be468e-11fa-475e-9fb8-c7d7b3a348e2)

## Testing
- Copy the kext to `EFI/OC/Kexts`, replacing the existing one 
- Reboot
- Check if the kext works. 

> [!IMPORTANT]
> 
> - itlw.kext requires the [Heliport](https://github.com/OpenIntelWireless/HeliPort) app to connect to Wi-Fi Hotspots
> - If you are having issues with the slimmed itlwm.kext, use the pre-cpmpiled version from the OpenIntelWireless repo!
