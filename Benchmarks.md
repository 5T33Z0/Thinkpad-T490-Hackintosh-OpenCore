# Benchmark Test Results

## Test Evironment

**macOS**: 14.7.7 (23H709)<br>
**CPU**: Intel Core i5 8265U (Quad Core)<br>
**iGPU**: Intel UHD 620 (spoofed as UHD 630)<br>
**Tool**: Geekbench 5.5.1

## CPU Results

Test # | Parameters | Single-Core <br>Score| Multicore <br>Score
:-----:|------------|:--------------------:|:--------------------:
[1](https://browser.geekbench.com/v5/cpu/23665259) |<ul><li>YogaSMC **OFF** <li> CPUFriend: **OFF** |1017|3252
[2](https://browser.geekbench.com/v5/cpu/23665246) |<ul><li>YogaSMC **OFF** <li> CPUFriend: **ON** | 1016 | 3330

## iGPU Results

Setup # | Parameters | Freq. (GHZ) | OpenCL<br>Scrore | Metal<br>Score 
:-----:|-------------|:-----------:|:----------------:|:--------------:
1 | <ul><li>CPUFriend: **OFF** <li>[GUC FW](https://github.com/5T33Z0/OC-Little-Translated/blob/main/Content/11_Graphics/iGPU/GUC_Firmware.md): **ON**| 1,10| [4927](https://browser.geekbench.com/v5/compute/6878344) | [4660](https://browser.geekbench.com/v5/compute/6878345)
2 | <ul><li> CPUFriend: **OFF** <li>[RPS Control](https://github.com/5T33Z0/OC-Little-Translated/blob/main/Content/11_Graphics/iGPU/RPS-Control.md): **ON** | 110 | [**4930**](https://browser.geekbench.com/v5/compute/6878349) |[4700](https://browser.geekbench.com/v5/compute/6878350)
3 | CPUFriend: **OFF** | 1,10 | [4559](https://browser.geekbench.com/v5/compute/6878351) | [4418](https://browser.geekbench.com/v5/compute/6878352)
4 | <ul><li>CPUFriend: **ON** <li>GUC FW: **ON** | 1,10| [4858](https://browser.geekbench.com/v5/compute/6878353) | [4620](https://browser.geekbench.com/v5/compute/6878354)
5 | <ul><li>CPUFriend: **ON** <li>RPS-Control: **ON** | 1,10 | [4841](https://browser.geekbench.com/v5/compute/6878355) | [**4718**](https://browser.geekbench.com/v5/compute/6878356)
6 | CPUFriend: **ON** | 1,10 | [4684](https://browser.geekbench.com/v5/compute/6878361)| [4411](https://browser.geekbench.com/v5/compute/6878363)