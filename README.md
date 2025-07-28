# 🧠 MAX10 SRAM Data Capture Interface

A Verilog-based system for **non-invasively reading data** from a legacy **SRAM chip (M48T35)** used in submarine control systems, then sending that data over **I²C** to an external device. Built on the **MAX10 (DE10-Lite) FPGA** platform.


## 🚧 Problem Overview

A control system on a submarine loads boot and configuration data from a non-volatile SRAM (M48T35). The SRAM is battery-backed — if the internal battery dies, all critical data is lost.

The SRAM only makes valid data available for **~10 ns**, approximately **70 ns after** the `E_n` (Chip Enable) and `G_n` (Output Enable) signals are asserted. Data must be captured within this narrow window


## 🎯 Goal

- ✅ Monitor SRAM control lines (`E_n`, `G_n`) in real time
- ✅ Precisely capture data + address during the valid 10 ns window
- ✅ Avoid loading or interfering with the SRAM or its ASIC controller


## ⚙️ System Architecture

### 🔩 High-Level Design

| Component         | Role                                                                  |
|-------------------|-----------------------------------------------------------------------|
| **PLL Block**     | Generates a 200MHz clock from 50MHz input                          	|
| **Counter Module**| Produces a 5ns-resolution counter to time the 70ns delay				|
| **FSM**           | Monitors `E_n` and `G_n`, triggers capture at precise timing          |
| **Register Bank** | Captures 8-bit `DATA` and 15-bit `ADDR` lines                         |

## 🛠️ Hardware Interface

- **SRAM operates at 5V** logic; DE10-Lite GPIOs are 3.3V-tolerant.
- I used **8-bit bus buffers** to safely interface the FPGA with the SRAM, preventing reverse current or contention.


---

## 🔬 Simulations

Simulation files are provided under `firmware/simulations/src`. They verify:

- Correct timing delay and edge detection
- Successful data/address latching at 70ns

Use **ModelSim** or **QuestaSim** to run the testbenches.


