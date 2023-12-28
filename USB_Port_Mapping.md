# USB Port Mapping

## `SSDT-PORTS.aml`

Listed below, you find the USB ports defined in the `SSDT-PORTS.aml` table.

Port  | Type   | On/Off
------|:------:|:------:
HS 01 | USB 2.0| Off
HS 02 | USB 2.0| Off
HS 03 | USB 2.0 <br> right port| **On**
HS 04 | USB 2.0 <br> left port | **On**
HS 05 | USB 2.0| Off
HS 06 | USB 2.0| Off
HS 07 | USB 2.0| **On**
HS 08 | Webcam <br> USB 2.0, internal| **On**
HS 09 | USB 2.0| Off
HS 10 | Bluetooth <br> USB 2.0, internal| **On**
SS 01 | USB 3.0| **On**
SS 02 | USB 3.0| **On**
SS 03 | USB 3.0| **On**
SS 04 | USB 3.0| **On**
SS 05 | USB 3.0| **On**
SS 06 | USB 3.0| **On**

To enable/disable a port and/or change the port type, you need to adjust the return values for `GUPC` within each port entry's `UPC` Method:

```asl
Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
{
	Return (GUPC (0xFF, 0xFF)) // 1st packet = port on/off, 2nd packet = port type
}
```

In this example, the port is enabled (`0xFF`) and the port type is USB 2.0, interla (`0xFF`). To disable a port, set the first packet to `0x00`.

The following values for USB port types are possible:

| Value  | Port Type |       
| :----: | ----------|
|**`0X00`**| USB Type `A` |
|**`0x01`**| USB `Mini-AB` |
|**`0x02`**| USB Smart Card |
|**`0x03`**| USB 3 Standard Type `A` |
|**`0x04`**| USB 3 Standard Type `B` |
|**`0x05`**| USB 3 `Micro-B` |
|**`0x06`**| USB 3 `Micro-AB` |
|**`0x07`**| USB 3 `Power-B` |
|**`0x08`**| USB Type `C` (USB 2 only) |
|**`0x09`**| USB Type `C` (with Switch) | 
|**`0x0A`**| USB Type `C` (w/o Switch) | 
|**`0xFF`**| Internal USB 2 port|

The most connector types nowadays are:

| Value    | Port Type |       
|:--------: | ----------|
|**`0X00`**| USB 2, Type `A` |
|**`0x03`**| USB 3, Type `A` |
|**`0x09`**| USB Type `C` (with Switch) | 
|**`0x0A`**| USB Type `C` (w/o Switch) | 
|**`0xFF`**| Internal USB 2 port (for Bluetooth connectors)|
