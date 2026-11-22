// T490 JHL6240: minimal equivalent of the successful v2 USB classification.
// NEXP is existing firmware capability/policy, NOT a negotiated ownership grant.
// Publish capability early; leave OEM _OSC and actual permission handling intact.
// Protect native onboard USB with an AML Integer Zero (OSNumber), not Data.
// Existing nodes only; no logger, counters, reset/power/Notify or hardware writes.
DefinitionBlock ("", "SSDT", 2, "T490  ", "TBCLASS ", 3)
{
    External (\_SB.PCI0.RP05.PXSX, DeviceObj)
    External (\_SB.PCI0.RP05.PXSX.TBDU, DeviceObj)
    External (\_SB.PCI0.RP05.PXSX.TBDU._ADR, IntObj)
    External (\NEXP, FieldUnitObj)

    If (_OSI ("Darwin"))
    {
        // Install both properties together only for the existing local USB route.
        If (CondRefOf (\_SB.PCI0.RP05.PXSX.TBDU._ADR))
        {
            If (\_SB.PCI0.RP05.PXSX.TBDU._ADR == 0x00020000)
            {
                Scope (\_SB.PCI0.RP05.PXSX)
                {
                    Method (_DSM, 4, Serialized)
                    {
                        If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                        {
                            If (Arg2 == Zero) { Return (Buffer (One) { 0x03 }) }
                            If (Arg2 == One)
                            {
                                If (\NEXP)
                                {
                                    Return (Package (2) { "PCI-Thunderbolt", One })
                                }
                                Return (Package (0) {})
                            }
                        }
                        Return (Buffer (One) { 0x00 })
                    }
                }
                Scope (\_SB.PCI0.RP05.PXSX.TBDU)
                {
                    Method (_DSM, 4, Serialized)
                    {
                        If (Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b"))
                        {
                            If (Arg2 == Zero) { Return (Buffer (One) { 0x03 }) }
                            If (Arg2 == One)
                            {
                                Return (Package (2) { "PCIHotplugCapable", Zero })
                            }
                        }
                        Return (Buffer (One) { 0x00 })
                    }
                }
            }
        }
    }
}
