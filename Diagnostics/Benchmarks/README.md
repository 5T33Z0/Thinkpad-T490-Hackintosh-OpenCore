# Benchmark Test Results

## Test Evironment

**CPU**: Intel Core i5 8265U (Quad Core)<br>
**iGPU**: Intel UHD 620 (spoofed as UHD 630)<br>
**Tool**: Geekbench 5.5.1<br>
**Thermal Paste**: Arctic Cooling MX7

## CPU Results

Test # |macOS | Kexts | Power<br>Profile | Single-Core <br>Score| Multi-Core <br>Score
:-----:|------|-----------|:-------:|:------------:|:--------------------:
[1](https://browser.geekbench.com/v5/cpu/24821299)| 15.8.3 | **ReYogaSMC**: On<br> **CPUFriend**: On | Performance | 1027 | 3349
[2](https://browser.geekbench.com/v5/cpu/24821327)| 15.8.3 | **ReYogaSMC**: On<br> **CPUFriend**: On | Balanced | 1018 | 2444
[3](https://browser.geekbench.com/v5/cpu/24821350)| 15.8.3| **ReYogaSMC**: On<br> **CPUFriend**: On | Quiet | 1023 | 2043

## iGPU Results

**Used Power Profile**: Performance

Setup # | Parameters | Freq. (GHz) | OpenCL<br>Scrore | Metal<br>Score 
:------:|----------|:-----------:|:----------------:|:--------------:
1 | `igfxfw`| 1,10 | [4826](https://browser.geekbench.com/v5/compute/6969452) | [4628](https://browser.geekbench.com/v5/compute/6969453)
2 | `rps-control` | 1,10 | [4887](https://browser.geekbench.com/v5/compute/6969454) | [4675](https://browser.geekbench.com/v5/compute/6969455)
