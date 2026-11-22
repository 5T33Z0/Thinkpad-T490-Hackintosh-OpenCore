// T490: preserve the tested functional first-child removability hint.
// Read the OEM _OSC result only; never request or force native ownership.
// No logger, counters, resets, notifications, power calls or hardware writes.
DefinitionBlock ("", "SSDT", 2, "T490  ", "RP05HP  ", 3)
{
    External (\_SB.PCI0.RP05.PXSX, DeviceObj)
    External (\OSCC, FieldUnitObj)

    If (_OSI ("Darwin"))
    {
        Scope (\_SB.PCI0.RP05.PXSX)
        {
            Method (_RMV, 0, NotSerialized)
            {
                Return (\OSCC & One)
            }
        }
    }
}
