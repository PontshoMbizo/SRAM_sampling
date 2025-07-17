# Setting up the DE10-Lite FPGA DevBoard

#### Downloading MAX10 specific tools

- make a [terasic](https://www.terasic.com.tw/en/) account 
- download the [CD-ROM](https://download.terasic.com/downloads/cd-rom/de10-lite/)
- the CD-ROM contains schematics and datasheets of components on the DevBoard
#### Installing Intel Quartus Prime Lite Edition

- [Intel Quartus Prime Lite Edition Downloads](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/download.html)
- Choose the **Lite Edition**, which supports the **MAX 10 FPGA** on the DE10-Lite.
- on installation, select:
  - **Quartus Lite Software**
  - **MAX 10 device support files**
  - and install in default location: (`C:\intelFPGA_lite\XX.X\`) where `XX.X` is the version you downloaded
#### Installing the USB-Blaster driver

The next step is to install the USB driver; The **DE10-Lite** uses a **USB-Blaster** to program the FPGA via USB.

- Plug in the DE10-Lite board
- open the device manager; you should see “Unknown Device” or “USB-Blaster”
- to install the driver:
	1. Right-click > **Update Driver**
	2. Choose **Browse my computer for drivers**
	3. Navigate to: `C:\intelFPGA_lite\XX.X\quartus\drivers\usb-blaster`
	4. Select the folder and and click install.
#### Selecting the Hardware

- Open **Quartus Prime Lite**
- Go to **Tools > Programmer**
- Select **USB-Blaster**  under hardware setup.
#### Starting a Project

Intel does a better Job explaining this part 😅
[here's the link](https://www.intel.com/content/www/us/en/developer/articles/training/program-fpga-device/terasic.html) 
just keep in mind, the device is: **10M50DAF484C7G**, **MAX 10** family, **MAX10 DE** version