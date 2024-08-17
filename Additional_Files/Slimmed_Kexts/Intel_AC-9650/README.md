# How to compile a slimmed `itlwm` and `IntelBluetoothFirmware` kexts

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
- Next, download MacKernelSDK into the "itlwm-master" folder: `git clone https://github.com/acidanthera/MacKernelSDK` 
- Delete unnecessary firmware files except the one required for the AC-9560 by entering: `find itlwm/firmware/ -type f ! -name 'iwm-9000-*' -delete`

### Prepare the `IntelBluetoothFirmware` source code
- Download [IntelBluetoothFirmware](https://github.com/OpenIntelWireless/IntelBluetoothFirmware) source code (click on "Code" and select "Download zip")
- Unzip the file – "IntelBluetoothFirmware-master" folder will be created
- Run Terminal
- Enter: `cd ~/Downloads/IntelBluetoothFirmware-master`
- Next, download MacKernelSDK into the "IntelBluetoothFirmware-master" folder: `git clone https://github.com/acidanthera/MacKernelSDK`
- Leave the Terminal window open for later use
- Download the DEBUG version of Lilu, extract it and place the kext in the IntelBluetoothFirmware-master folder
- In Finder, navigate to `~/Downloads//IntelBluetoothFirmware-master/IntelBluetoothFirmware/fw`
- In the `fw` folder delete all firmware files _except_ these two: `ibt-17-16-1.ddc` and `ibt-17-16-1.sfi`
- If present, also delete `FwBinary.cpp` from /IntelBluetoothFirmware-MASTER/IntelBluetoothFirmware

## Compiling the kexts

### Compiling `AirportItlwm` and `Itlwm`
Enter the following commands (the lines without `#`) in Terminal and execute them one by one to build itlwm as well as AirportItlwm kexts for all versions of macOS:

```
# navigate to the itlwm folder (if it is not your working directory already)
cd ~/Downloads/itlwm-master

# remove generated firmware
rm include/FwBinary.cpp

# generate firmware
xcodebuild -project itlwm.xcodeproj -target fw_gen -configuration Release -sdk macosx

# building the kexts
 xcodebuild -alltargets -configuration Release
```

The build process will begin and take about 2 minutes. Once compiling is completed, the kexts will be located at `~/Downloads/itlwm-master/itlwm/build/Release`:

![kexts](https://github.com/user-attachments/assets/719630a7-54db-4c3e-b214-770dd24302a3)

### Compiling `InteBluetothFirmware`

Enter the following commands (the lines without `#`) in Terminal and execute them one by one to build the IntelBluetoothFirmware kext:

```
# Navigate to the IntelBluetoothFirmware folder (if it is not your working directory already)
cd ~/Downloads/IntelBluetoothFirmware-master

# build the kext
xcodebuild -alltargets -configuration Release
```
The compiled kexts will be located under `~/Downloads/IntelBluetoothFirmwar-master/build/Release`:

![itlbtfw](https://github.com/user-attachments/assets/c9be468e-11fa-475e-9fb8-c7d7b3a348e2)

## Testing
- Copy the newly compiled kexts to `EFI/OC/Kexts`, replacing the existing ones
- Reboot
- Check if WiFi and Bluetooth are working.

> [!IMPORTANT]
> 
> - itlw.kext requires the [Heliport](https://github.com/OpenIntelWireless/HeliPort) app to connect to Wi-Fi Hotspots
> - If you are having issues with the slimmed itlwm.kext, use the pre-cpmpiled version from the OpenIntelWireless repo!
