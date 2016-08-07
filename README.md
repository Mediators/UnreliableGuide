# The Unreliable Mediator Guide

## Version
0.2 - 2016-08-03

## Authors
 * Chris Jones <cmsj@tenshu.net> (current maintainer)

If you have a Mediator, or know about them, and either disagree with something in this guide, or have some extra information you'd like to add, please do contact us. We want this document to grow to cover as much detail about Mediators as possible!

The canonical home of the guide is: [https://mediators.github.io](https://mediators.github.io)
A nicely formatted PDF version is available from: [https://mediators.github.io/TUMG.pdf](https://mediators.github.io/TUMG.pdf)

The source of the project lives at: [https://github.com/Mediators/UnreliableGuide](https://github.com/Mediators/UnreliableGuide)

You are very welcome to file bugs there, or submit pull requests, but if you do not want to do either of those, please feel free to email the current maintainer (listed above) with your corrections/suggestions/etc. If you want to become an active author of the document, you are very welcome to join our GitHub team and work directly on the document.

There are threads on the main Amiga forums for any discussions you want to have about the guide:

 * [English Amiga Board](http://eab.abime.net/showthread.php?t=83531)
 * [Amiga.org](http://www.amiga.org/forums/showthread.php?p=811379)
 * [AmigaWorld](http://amigaworld.net/modules/newbb/viewtopic.php?topic_id=41251&start=0&post_id=785207&order=0&viewmode=thread&pid=0&forum=25#785207)

You can also discuss the guide on the [Amiga-Mediator Yahoo Group](https://groups.yahoo.com/neo/groups/Amiga-Mediator/info)

## Contributions
To write this guide, we have drawn extensively on the help and writings of other people. Specific thanks to:

 * Mech
 * grelbfarlk

## License
This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

## 1. Introduction
Created by [Elbox](http://www.elbox.com), the Mediators are a range of PCI/Zorro busboards for Amiga computers. They allow users to install industry-standard PCI cards into their Amigas.

There exist Mediators for:

 * A1200
 * A3000
 * A3000T
 * A4000
 * A4000T

Various models and revisions of Mediators have existed since their initial release in 2000/2001. The authors of this guide do not have access to every variant of Mediator, so for now the information contained here can only be assumed to be related to the following models:

 * Mediator 4000Di3 (Rev 3.0)

## 2. Hardware
A Mediator typically consists of two main parts:

 * A backplane board with slots for some combination of PCI and Zorro cards
 * A bridge board which connects to both the PCI and Zorro busses, to translate between them

The backplane board is generally very simple, it is really just a series of PCI and/or Zorro slots. The real magic of the Mediator happens on the bridge board. This board sits on both PCI and Zorro buses, and contains a series of chips (known as *MACH*) that translate between the protocols of PCI and Zorro, allowing the Amiga to communicate with the PCI cards and vice versa.

### 2.1 Supported PCI cards
There are drivers for a number of PCI cards, with most of the drivers being maintained by Elbox. Unfortunately the Driver Development Kit for writing additional drivers is not freely available, limiting the possibilities for community maintained drivers.

Elbox maintains a list of compatible cards [on their website](http://www.elbox.com/mediator_driver_guide.html)

There are also one or two additional drivers [on Aminet](http://aminet.net/search?name=mediator&path[]=driver&q_desc=OR&desc=mediator)

#### 2.1.1 Supported voltages
All Mediators support 5V PCI cards, but only some support 3.3V PCI cards. You can tell which voltages a PCI card works with, by looking at its edge connector. If it has a section cut out of the edge connector 5.6cm away from the backplate, it requires 3.3V. If it has a section cut out of the edge connector 10cm from the backplate, it requires 5V. Cards that have both sections cut out, work with either 3.3V or 5V. Some users have noticed that some PCI cards appear to be 5V compatible, but actually do require 3.3V.

It is possible to modify 5V Mediators to supply 3.3V to cards that need it, by connecting a 3.3V supply to the appropriate PCI pins on the back of the Mediator busboard.
(If you would like to document the process here, please contact us!)

It is also often possible to modify PCI cards to have their own voltage regulator (e.g. `LM1084`) to convert 5V to 3.3V on the card itself.

#### 2.1.2 IRQs
PCI cards generally need to have an IRQ allocated to them to be able to function correctly, and while sharing IRQs is possible, not all cards are happy with it. Mediator bridgeboards supply and configure 5 IRQs. While this is not normally a problem (particularly if you have fewer than 5 PCI slots on your Mediator), if you are having stability issues where usage of one card seems to affect another, check the output of `C:PCIInfo` and look for any IRQ sharing. If you do find one or more IRQs being shared, the only way to resolve stability is to re-order your PCI cards.

### 2.2 Installation
Obviously the installation for different Amigas varies widely, because of their different form factors. Specific information for various models can be found below, but the general steps are:

 * Remove any existing Zorro busboards
 * Install the Mediator bridge card into the Mediator busboard
 * Install the combined Mediator boards into the Amiga
 * Before installing any PCI cards, ensure the Amiga still boots (hold both mouse buttons to enter the Early Boot Menu, check for two entries in the *Expansion Board Diagnostic* section, with a [Manufacturer ID](http://wiki.amigaos.net/wiki/Amiga_Hardware_Manufacturer_ID_Registry) of 2206.
 * Install a graphics card
 * Install Mediator drivers
 * Ensure graphics card works
 * Install other PCI cards

**NOTE:** Some users have reported that on some Mediators, the order of PCI cards is important, particularly the placement of the graphics card. Please contact us if you know more about this.

#### 2.2.1 4000Di

  * Remove the A4000 top cover
  * Remove the hard disk cage
  * Remove the metal crossbar above the Zorro daughterboard
  * Hold the top corners of the Zorro daughterboard and remove it from the motherboard
  * **NOTE:** At least one user has found that the Mediator's bridge board may touch some of the jumpers on the motherboard (specifically, J500, J501, J502, J213 J852 on a Rev B motherboard. Rev D boards only have some of these jumpers). It seems sensible to insulate these jumpers in some way, to prevent them shorting a MACH chip (electrical tape should suffice)
  * Place the Mediator board on a flat surface with the PCI/Zorro slots facing upwards
  * Align the Mediator bridge board with the PCI/Zorro slots nearest the bottom of the card (labelled "MEDIATOR PCI 4000 SLOT")
  * Hold the bridge board along its top edge and push it firmly, but gently, into the slots
   * **NOTE:** It is a good idea to try and insert the card into both slots at the same time. It's easier to push one corner in first, but this is more likely to leave the card incorrectly aligned, which will make the system unstable
  * Align the Mediator board with the daughterboard slot on the motherboard
  * Hold the Mediator board along its top edge and push it firmly, but gently, into the motherboard slot
   * **NOTE:** As above, try to insert the card in one movement, rather than starting with one corner.

### 2.3 Configuration
In terms of hardware configuration, Mediators generally have very little that needs to be done. They have a few jumpers and that's it. However, these jumpers are generally not documented well, and vary between models.

#### 2.3.1 4000Di
This model has three jumpers:

 * **MASTER**: This is for using the Mediator with the (unreleased) Elbox SharkPPC card.
     * The jumper should always remain closed unless you have one of these mythical cards (which you almost certainly do not).
 * **WINSIZE**: This relates to how much memory space your PCI cards require. With the jumper open, the PCI memory space is 256MB. With it closed, the space is 512MB.
     * Only your graphics card is likely to present memory to the system, so you can base the decision for this jumper on the amount of RAM on your graphics card.
     * If it's less than 256MB, open this jumper. If it's 256MB or more, close this jumper.
     * **NOTE:** Some Radeon cards may require more memory space than their total RAM size, so you may need you to close this jumper (you can check by comparing the `MemSpace` values in `C:PCIInfo` output with the jumper open and closed).
 * **SWAPCONFIG**: This determines the order of memory allocation for Zorro/PCI cards.
     * The Mediator bridgeboard presents two Zorro3 devices to the Amiga, one being the PCI memory space, the other being the Mediator.
     * This jumper controls the order in which those two devices are attached to the Amiga. With the jumper open, the PCI space is second. With the jumper closed, the PCI space is first.
     * If you have a Zorro3 graphics card, or a Zorro3 card which performs DMA (e.g. A4091 or X-Surf-100) this jumper should be closed. If you don't have any relevant Zorro3 cards, the position of this jumper doesn't matter.

## 3. Software
Along with the hardware, Elbox also produces software and drivers for Mediators and the PCI cards they are compatible with. This is supplied with the Mediator and is called the *Mediator Multimedia CD* (generally known as `MMCD`). It is only relevant to AmigaOS 3.1/3.5/3.9 - 4.1 uses its own drivers.

**NOTE:** It's quite common for the CD supplied by Elbox to be significantly out of date, so always check [their website](http://www.elbox.com/downloads_mediator.html) for a driver pack update (`MM_CD_UP`). However, even these update packs do not always contain the most recently available drivers/libraries. The same download page also lists individual updates that have been released (e.g. `pci.library`) and the dates. Ensure you have the latest versions of everything.

### 3.1 Installation
The Elbox installers are not particularly neat in their choices of where to install the software/drivers. If you are feeling particularly confident, you may choose to install the various components by hand, but we would suggest that at least your first time, you may want to use the Elbox installers:

#### 3.1.1 General
 * Run the Installer from the `MMCD`
 * Run the Installer from the latest `MM_CD_UP` update, if applicable
 * Manually copy any newer drivers/libraries you found on Elbox's site, into the appropriate locations on your system

Somewhat unusually for Amiga hardware, there is no device driver for the Mediator, instead, access to the PCI cards happens through `pci.library`. Once you have installed the drivers, open a shell and run `C:PCIInfo` and you should see a listing of any PCI cards you have installed (which ideally should just be the graphics card at this point).

**NOTE:** A graphics card is generally vital to the operation of a Mediator because of the RAM it provides. PCI cards are unable to access the Amiga's memory through the Zorro bus, so the Mediator drivers reserve a portion of the graphics card's memory for DMA operations with other cards. Thus, any card you install, which uses DMA (i.e. most cards), will only operate if there is a graphics card present.

**FURTHER NOTE:** The mere presence of a graphics card is not sufficient, Picasso96 must also be installed and configured to use the appropriate driver for your PCI graphics card. You don't have to be using an RTG screenmode through the graphics card, but without it at least having an active entry in `DEVS:Monitors/` most other PCI operations will not be possible.

#### 3.1.2 Graphics card

**NOTE**: These instructions are kept intentionally simple. For Radeon/Voodoo users, there are good installation guides in the `MMCD`/`MM_CD_UP`.

 * Install Picasso96 2.1b ([from Aminet](http://aminet.net/package/driver/video/Picasso96)) and choose the `Cybervision 3D` card.
 * Once the installation is complete, open `DEVS:Monitors/`
 * Rename the `CVision3D` monitor to `Radeon` or `Voodoo` (or some other suitable name for your PCI graphics card)
 * Edit the tooltypes for the monitor
 * Change the `BOARDTYPE` value to the name of the graphics card driver (which live in `LIBS:Picasso96/`), e.g. `Radeon`

#### 3.1.3 Sound card
Assuming you ran the Elbox installer, it will have installed `AHI`, the Amiga's retargetable audio framework, several drivers, and a Mixer application. It seems as though Elbox installs AHI 4.21, but then also places some newer components on top of that install, so it may not be possible to easily recreate a known-good setup without using Elbox's installer. If you have set up AHI from scratch with a Mediator, please let us know (particularly if you have tested the latest version, 6.0).

Your sound card will require some additional configuration:

**NOTE:** AHI is exposed to applications as a series of `unit`s. Each unit can be configured to send its audio to a soundcard of your choice, with quality settings of your choosing. For this section we will assume that you only have one soundcard, you will configure all your applications to use AHI unit 0, and you want the highest possible sound quality.

 * Open `SYS:Prefs/` and run the `AHI` prefs.
 * Find the dropdown for selecting which unit to configure (usually it will say `Music Unit`)
 * In AHI, a unit is an endpoint exposed by AHI to applications. Each application which can use AHI, should let you choose which unit to use. It is up to you how the units are configured. Each one can point at a soundcard of your choice, and have quality settings of your choice
 * For the `Music Unit` and `Unit 0`:
   * Select your soundcard (e.g. `SB128` for a SoundBlaster 128 card). It will be listed several times with different options. The best choice is likely the `HiFi 16 bit stereo++` option.
   * Move the frequency slider to 44000 Hz or above (e.g. 48000 Hz)
 * Click `Save`
 * The soundcard likely defaults to zero volume when it is initialiesd, so you'll need an audio mixer application to save some sensible values and load them at startup. The Elbox installer will have created `SYS:Prefs/Mixer` for changing mixer settings, and a corresponding entry in `S:User-Startup` to load the values at boot.

**NOTE:** The Mixer app supplied by Elbox is not very high quality (Elbox themselves recommend using a third party mixer). A good alternative is [GhostMix](http://aminet.net/package/driver/audio/GhostMix). You will need to remove the Elbox mixer item in `S:User-Startup` to use a different mixer application.

**FURTHER NOTE:** GhostMix does not create the required directory for its preferences. Either run the Elbox mixer once and `Save` the settings, or manually create a directory `ENVARC:Mediator/Mixer/`

#### 3.1.4 Network card
There are Mediator drivers for two Realtek chipsets, 8029 (10Mb/s) via `MediatorNET.device` and 8139 (100Mb/s) via `FastEthernet.device`. To use one of these, you'll need a TCP/IP stack installed, such as:

 * Roadshow
 * Genesis
 * MiamiDX
 * AmiTCP

Of these, Roadshow is the newest and is often the fastest. The choice is yours, and configuring the stack is beyond the scope of this document.

There is an environment variable for `RTL-8139` devices, `ENVARC:Mediator/FastEthernet` which controls how the Ethernet link should be configured, see Section 3.2 for more information.

With a good network card in a well configured system, it should be possible to achieve roughly 1MB/s through the network interface.

#### 3.1.5 USB card

The only USB card that can currently be used in a Mediator, is Elbox's Spider card (which is actually an NEC card with modified firmware). Installation is very simple:

 * Download Poseidon 4.5 (either from [Chris Hodges (Poseidon's author) site](http://dump.platon42.de/files/) or [Individual Computers](http://wiki.icomp.de/wiki/RapidRoad#Software_download)
 * Install Poseidon
 * Copy `spider.device` to `DEVS:USBHardware`
 * In a shell run:
     * `AddUSBHardware DEVS:USBHardware/spider.device 2`
     * `AddUSBHardware DEVS:USBHardware/spider.device 0`
     * `AddUSBHardware DEVS:USBHardware/spider.device 1`

**NOTES: **

 * The Spider will appear in `PCIInfo` as three devices - one for Full Speed USB and two for Normal Speed.
 * The Poseidon installer will place a command at the very start of `S:Startup-Sequence` to load its input driver. Some users find that this causes their boot to hang, and have to comment the line out.
 * Nobody has yet been able to get USB Soundcards or Ethernet adapters to work on a Spider card, even though they should be supported by Poseidon. If you know how to make them work, please contact us!
 * The licensing situation of Poseidon is somewhat complex. The latest available version, 4.5, only contains drivers for Individual Computer's RapidRoad board. While this doesn't pose an issue for Spider users, since `spider.device` is distributed separately, there have been questions about the legality of Elbox's driver (at the very least they did not make any contributions to Poseidon's development, and are not authorised to distribute the main Poseidon archive). Some of the authors of this guide feel that the morally appropriate thing for users to do, is to purchase an item from Chris Hodges' [Amazon Wishlist](http://www.amazon.de/gp/registry/wishlist/1123KBN787GJQ) since it is not possible to pay for Poseidon.
 * Early versions of `spider.device` contained a DRM mechanism that, in certain situations, could erase your disk's MBR (i.e. partition table). This *feature* has been removed in more recent versions (do you know which version removed it?).
 * Performance of the Spider should be around 3MB/s on a reasonable quality USB flash drive. 

#### 3.1.6 TV Tuners

Please contribute to this section if you have any useful information :)

#### 3.1.7 SCSI cards

There is a [driver on Aminet](http://aminet.net/package/driver/media/aic78xx.device) that allows you to use certain Adaptec SCSI cards in the AHA-2940UW range. Depending on your card's connectors, you will be able to attach up to 14 SCSI devices to the various SCSI connectors on the card (usually 50pin internal, 68pin internal and 68pin external, of which any two can be in use at the same time).

**NOTE:** Even though these cards are capable of high speed data transfer (around 40MB/s), in a Mediator they are limited by the overheads of being moving data from the SCSI card to graphics card RAM, and from there across the Zorro3 bus to the Amiga's CPU (and vice versa). This means that SCSI devices attached to the Adaptec card will actually only operate at around 3MB/s (i.e. roughly equivalent to the A1200/A4000 internal IDE).

#### 3.1.8 Serial/Parallel cards

Please contribute to this section if you have any useful information :)

#### 3.1.9 MPEG 2 decoder cards

Drivers for these cards have never been released.

### 3.2 Configuration

#### 3.2.1 Environment Variables
There are many Mediator environment variables which can be set in `ENVARC:Mediator/`:

 * `MMU`:
     * This only applies to A1200 Mediators
     * If set to `Yes`, maps the PCI memory space into the processor's memory space.
     * Must be set to `No` if you have a BlizzardPPC and want to use PCI resources with both of its CPUs.
 * `NoCache`:
     * This only applies to A1200 Mediators with 68030/MMU processors.
     * If set to `Yes`, Mediator PCI space is not cacheable.
 * `Emulation`:
     * This only applies to A1200 Mediators with a BlizzardPPC.
     * Set to `Yes` if you are running AmigaOS 4.
 * `Warp3D`:
     * This should no longer be necessary, set to `No`.
 * `SpiderBuf`:
     * This controls how much RAM is allocated for USB card DMA buffers
     * The value is a number which will be used as a multiple of `40KB`
     * The default value is `1` (i.e. use `40KB` for DMA buffers)
     * The highest possible value is `51` (i.e. just over `2MB` of DMA buffers)
     * If you have information about the performance of different settings here, please contact us :)
 * `RadeonMem`:
     * This controls how much of a Radeon's RAM is kept for Picasso96
     * Any leftover RAM can be used for system memory (see `RadeonMemOS`)
     * **NOTE:** The highest `1MB` of Radeon RAM is always reserved for DMA with other PCI cards
 * `RadeonMemOS`:
     * If set to `Yes`, unused Radeon RAM will be added to the system memory
     * Note that even though the RAM is high performance graphics RAM, your CPU can only access it at Zorro 3 speeds (i.e. a maximum of around `14MB/s`). If your CPU accelerator card has RAM slots, they will be considerably faster than this.
 * `VoodooMem`:
     * This controls how much of a Voodoo's RAM is kept for Picasso 96
     * Any leftover RAM can be used for system memory (see `VoodooMemOS`)
     * **NOTE:** The highest `1MB` of Radeon RAM is always reserved for DMA with other PCI cards
 * `VoodooMemOS`:
     * If set to `Yes`, unused Voodoo RAM will be added to the system memory
     * Note that even though the RAM is high performance graphics RAM, your CPU can only access it at Zorro 3 speeds (i.e. a maximum of around `14MB/s`). If your CPU accelerator card has RAM slots, they will be considerably faster than this.
 * `VoodooInt`:
     * This controls the Voodoo vertical blanking interrupt
     * If set to `Yes`, interrupts are generated during VBlank, which may be required for some games
     * If set to `No`, interrupts are not generated during VBlank
 * `VirgeMem`:
     * This controls how much of an S3 Virge's RAM is kept for Picasso 96
 * `VirgeInt`:
    * This controls the S3 Virge vertical blanking interrupt
    * If set to `Yes`, interrupts are generated during VBlank, which may be required for some games
    * If set to `No`, interrupts are not generated during VBlank
 * `Buster`:
     * This applies only to A3000 and A4000 (and Tower variants)
     * You should set this to the version of Buster chip installed in your Amiga (`7`, `9` or `11`)
 * `Tuner`:
     * If you have any information about this variable, please contact us :)
 * `Background`:
     * This defines a color of background which will be replaced by TV, if you're showing TV on the background
     * Defaults to `RED=170 GREEN=170 BLUE=170` (which is the Workbench default grey)
 * `FastEthernet`:
     * This controls the Ethernet link negotiation of `RTL8139` devices. The possible values are:
         * `0` - Auto Negotiation
         * `1` - 100Mb/s Full Duplex
         * `2` - 100Mb/s Half Duplex
         * `3` - 10Mb/s Full Duplex
         * `4` - 10Mb/s Half Duplex

### 3.3 Versions

Here we attempt to collect a definitive list of Mediator software versions. If you have any `MMCD` or `MM_CD_UP` versions not included here, please contact us :)
Most of the `MM_CD_UP` archives can be downloaded from [Elbox's website](http://www.elbox.com/), and many of them are included on the latest `MMCD` CDs.

#### 3.3.1 MMCD

The earliest version of `MMCD` that the authors currently have access to, is 2.0. The driver versions on this CD are the same as those shown in `MM_CD_UP` 2.0c below.

#### 3.3.2 MM_CD_UP

**NOTE:** Bold indicates a version was updated. *N/A* indicates the file was not included.

| File                  | 2.5      | 2.4      | 2.3      | 2.2      | 2.1      | 2.0c     | 1.31     | 1.28     | 1.26 |
|-----------------------|----------|----------|----------|----------|----------|----------|----------|----------|------|
| `C/SBMixer`           | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4  |
| `C/TV`                | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4      | 1.4  |
| `fm801.audio`         | 4.14     | 4.14     | 4.14     | 4.14     | 4.14     | **4.14** | **4.12** | **4.10** | 4.5  |
| `sb128.audio`         | 4.20     | 4.20     | 4.20     | 4.20     | 4.20     | **4.20** | **4.18** | **4.16** | 4.11 |
| `FastEthernet.device` | 1.25     | 1.25     | 1.25     | 1.25     | **1.25** | **1.24** | **1.21** | **1.20** | 1.15 |
| `MediatorNET.device`  | 2.10     | 2.10     | 2.10     | 2.10     | 2.10     | **2.10** | N/A      | N/A      | N/A  |
| `mixer.library`       | 1.11     | 1.11     | 1.11     | 1.11     | 1.11     | **1.11** | 1.10     | **1.10** | 1.9  |
| `pci.library`         | 9.11     | **9.11** | **9.10** | **9.9**  | **9.7**  | **9.4**  | N/A      | N/A      | N/A  |
| `Radeon.card`         | **2.23** | **2.22** | **2.20** | **2.19** | 2.12     | **2.12** | **1.7**  | **1.0**  | N/A  |
| `Virge.card`          | 1.13     | 1.13     | 1.13     | 1.13     | **1.13** | **1.12** | N/A      | N/A      | N/A  |
| `Voodoo.card`         | **4.35** | 4.34     | **4.34** | 4.30     | 4.30     | **4.30** | **4.28** | **4.27** | 4.23 |
| `tv.library`          | 4.13     | 4.13     | 4.13     | 4.13     | 4.13     | **4.13** | **4.9**  | **4.6**  | 4.0  |
| `tv.vhi`              | 1.5      | 1.5      | 1.5      | 1.5      | 1.5      | **1.5**  | 1.4      | **1.4**  | 1.3  |

#### 3.3.3 Spider II Driver

This driver is distributed separately from `MMCD`, although `spider.device` 3.20 appeared in `MM_CD_UP` 2.0c.

The `Spider II USB 2.0` CD includes `spider.device` 3.22.

#### 3.3.4 pci.library

At the time of writing, the latest version of `pci.library` (11.0) is distribtued separately from `MM_CD_UP`, and must be downloaded directly from Elbox's website.

