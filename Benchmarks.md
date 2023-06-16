# Geekbench 6 Test Results

## CPU

- **OpenCore**: 0.9.4
- **OS**: macOS Monterey 12.6.7 (21G708)
- **SecureBootModel**: `j132` (MBP 15,2), `j213` (MBP 15,4)

SMBIOS | YogaSMC <br> Setting | CPU <br>Friend | Single-Core | Multi-Core  
-------|:--------------------:|:--------------:|:-----------:|:---------:
[**MacBookPro15,2**](https://browser.geekbench.com/v6/cpu/1613207)| Balance | ON | 1331 | 3375
[**MacBookPro15,2**](https://browser.geekbench.com/v6/cpu/1613332)| Performance | ON |1342|3849
[**MacBookPro15,4**](https://browser.geekbench.com/v6/cpu/1613517)| Balance | ON | 1345 |3358
[**MacBookPro15,4**](https://browser.geekbench.com/v6/cpu/1613599) |Performance[^1] | ON | 1345 | 3295

[^1]: It seems that YogaSMC didn't work correctly during tests with this setting. Because when I looked into the preferences afterwards, the performance slider was unavailable and `DYTCRevision` said `Unsupported` whereas in previous tests using MBP15,2 it said `LAP` (for Laptop, I guess). After a restart with MBP15,4 it said `Standard`. So `MBO15,2` is the SMBIOS of choice.