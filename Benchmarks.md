# Geekbench 6 Test Results

## CPU

- **OpenCore**: 0.9.4
- **OS**: macOS Monterey 12.6.7 (21G708)
- **SecureBootModel**: `j132` (MBP 15,2), `j213` (MBP 15,4)

SMBIOS | YogaSMC <br> Profile | CPU <br>Friend | Score <br> Single-/ (Multi-Core)
-------|:--------------------:|:--------------:|:-----------:
**MBP15,2**| Balance | ON | [**1331 (3375)**](https://browser.geekbench.com/v6/cpu/1613207)
**MBP15,2**| Performance | ON |[**1342 (3849)**](https://browser.geekbench.com/v6/cpu/1613332)
**MBP15,4**| Balance | ON | [**1345 (3358)**](https://browser.geekbench.com/v6/cpu/1613517)
**MBP15,4**|Performance[^1] | ON | [**1345 (3295)**](https://browser.geekbench.com/v6/cpu/1613599)

[^1]: It seems that YogaSMC didn't work correctly during tests with this setting. Because when I looked into the preferences afterwards, the performance slider was unavailable and `DYTCRevision` said `Unsupported` whereas in previous tests using MBP15,2 it said `LAP` (for Laptop, I guess). After a restart with MBP15,4 it said `Standard`. So `MBO15,2` is the SMBIOS of choice.

- **OpenCore**: 0.9.6
- **Geekbench**: 6.2.1
- **OS**: macOS Sonoma 14.1 b3 (23B5067a)
- **SecureBootModel**: `j132` (MBP 15,2)

SMBIOS | YogaSMC <br> Profile | CPU <br>Friend | Score <br> Single-/ (Multi-Core)
-------|:--------------------:|:--------------:|:-----------:
**MBP15,2**| Balance | ON | [**1317 (3334)**](https://browser.geekbench.com/v6/cpu/3081247)

## iGPU

- **iGPU**: Intel Graphics UHD 620 (spoofed as Intel Iris Plus 655)
- **SMBIOS**: MBP15,2
- **OS**: macOS Ventura 13.4 (22F66)

Flags | YogaSMC <br> Profile | CPU <br>Friend | OpenCL Score | Metal Score  
:----------------:|:--------------------:|:--------------:|:------------:|:---------:
none|Balance|ON||[5648](https://browser.geekbench.com/v6/compute/572838)
`igfxfw=2` | Balance | ON ||[5829](https://browser.geekbench.com/v6/compute/572751)
`rps-control`|Balance|ON|[**4229**](https://browser.geekbench.com/v6/compute/574487)|[**5895**](https://browser.geekbench.com/v6/compute/574463)