# The Unreliable Mediator Guide

## Version:
0.1 - 2016-07-20

## Authors:
 * Chris Jones <cmsj@tenshu.net> (current maintainer)

If you have a Mediator, or know about them, and either disagree with something in this guide, or have some extra information you'd like to add, please do contact us. We want this document to grow to cover as much detail about Mediators as possible!

The canonical home of the guide is: https://github.com/Mediators/UnreliableGuide
You are very welcome to file bugs there, or submit pull requests, but if you do not want to do either of those, please feel free to email the current maintainer (listed above) with your corrections/suggestions/etc. If you want to become an active author of the document, you are very welcome to join our GitHub team and work directly on the document.

## Contributions:
To write this guide, we have drawn extensively on the help and writings of other people. Specific thanks to:

 * mechy
 * grelbfarlk

## License:
This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

## 1. Introduction:
Created by [Elbox](http://www.elbox.com), the Mediators are a range of PCI/Zorro busboards for Amiga computers. They allow users to install industry-standard PCI cards into their Amigas.

There exist Mediators for:

 * A1200
 * A3000
 * A3000T
 * A4000
 * A4000T

Various models and revisions of Mediators have existed since their initial release in 2000/2001. The authors of this guide do not have access to every variant of Mediator, so for now the information contained here can only be assumed to be related to the following models:

 * Mediator 4000Di3 (Rev 3.0)

## 2. Hardware:
A Mediator typically consists of two main parts:

 * A backplane board with slots for some combination of PCI and Zorro cards
 * A bridge board which connects to both the PCI and Zorro busses, to translate between them

The backplane board is generally very simple, it is really just a series of PCI and/or Zorro slots. The real magic of the Mediator happens on the bridge board. This board sits on both PCI and Zorro, and contains a series of chips (known as *MACH*) that translate between the protocols of PCI and Zorro, allowing the Amiga to communicate with the PCI cards and vice versa.

### 2.1 Supported PCI cards:

It's important to use cards which are supported. Unfortunately the list is quite small, partly because writing hardware drivers is not easy, partly because the Mediator Driver Development Kit is not publicly available.

Elbox maintains a list of compatible cards [on their website](http://www.elbox.com/mediator_driver_guide.html)

There are also one or two additional drivers [on Aminet](http://aminet.net/search?name=mediator&path[]=driver&q_desc=OR&desc=mediator)

### 2.2 Installation:
Obviously the installation for different Amigas varies widely, because of their different form factors. Specific information for various models can be found below, but the general steps are:

 * Remove any existing Zorro busboards
 * Install the Mediator bridge card into the Mediator busboard
 * Install the combined Mediator boards into the Amiga
 * Before installing any PCI cards, ensure the Amiga still boots (hold both mouse buttons to enter the Early Boot Menu, check for two entries in the *Expansion Board Diagnostic* section, with a [Manufacturer ID](http://wiki.amigaos.net/wiki/Amiga_Hardware_Manufacturer_ID_Registry) of 2206.
 * Install a graphics card
 * Install Mediator drivers
 * Ensure graphics card works
 * Install other PCI cards

*NOTE:* Some users have reported that on some Mediators, the order of PCI cards is important, particularly the placement of the graphics card. Please contact us if you know more about this.

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

### 2.3 Configuration:
In terms of hardware configuration, Mediators generally have very little that needs to be done. They have a few jumpers and that's it. However, these jumpers are generally not documented well, and vary between models.

#### 2.3.1 4000Di
This model has three jumpers:

 * **MASTER**: This is for using the Mediator with the (unreleased) Elbox SharkPPC card. The jumper should always remain closed unless you have one of these mythical cards (which you almost certainly do not).
 * **WINSIZE**: This relates to how much memory space your PCI cards require. Since the only card that's likely to present memory to the system, is your graphics card, you can base the decision for this jumper on the amount of RAM on your graphics card. If it's less than 256MB, open this jumper. If it's 256MB or more, close this jumper.
 * **SWAPCONFIG**: This determines the order of memory allocation for Zorro/PCI cards. The details here are unimportant, leave the jumper open unless you have a Zorro 3 device which does DMA (e.g. A4091 or a Zorro 3 graphics card).

## 3. Software:
Along with the hardware, Elbox also produces software and drivers for Mediators and the PCI cards they are compatible with. This is supplied with the Mediator and is called the *Mediator Multimedia CD* (generally known as *MMCD*).

**NOTE:** It's quite common for the CD supplied by Elbox to be significantly out of date, so always check [their website](http://www.elbox.com/downloads_mediator.html) for a driver pack update (*MM_CD_UP*). However, even these update packs do not always contain the most recently available drivers/libraries. The same download page also lists individual updates that have been released (e.g. pci.library) and the dates. Ensure you have the latest versions of everything.

### 3.1 Installation:
The Elbox installers are not particularly neat in their choices of where to install the software/drivers. If you are feeling particularly confident, you may choose to install the various components by hand, but we would suggest that at least your first time, you may want to use the Elbox installers:

#### 3.1.1 General:
 * Run the Installer from the MMCD
 * Run the Installer from the latest MM_CD_UP update, if applicable
 * Manually copy any newer drivers/libraries you found on Elbox's site, into the appropriate locations on your system

Somewhat unusually for Amiga hardware, there is no `mediator.device` driver, instead, access to the PCI cards happens through `pci.library`. Once you have installed the drivers, open a shell and run `C:PCIInfo` and you should see a listing of any PCI cards you have installed (which ideally should just be the graphics card at this point).

**NOTE:** A graphics card is generally vital to the operation of a Mediator because of the RAM it provides. PCI cards are unable to access the Amiga's memory through the Zorro bus, so the Mediator drivers reserve a portion of the graphics card's memory for DMA operations with other cards. Thus, any card you install, which uses DMA (i.e. most cards), will only operate if there is a graphics card present.

**FURTHER NOTE:** The mere presence of a graphics card is not sufficient, Picasso96 must also be installed and configured to use the appropriate driver for your PCI graphics card. You don't have to be using an RTG screenmode through the graphics card, but without it at least having an active entry in `DEVS:Monitors/` most other PCI operations will not be possible.

#### 3.1.2 Graphics card:

**NOTE**: These instructions are kept intentionally simple. For Radeon/Voodoo users, there are good installation guides in the MMCD/MM_CD_UP.

 * Install Picasso96 and choose the *Cybervision 3d* card.
 * Once the installation is complete, open `DEVS:Monitors/`
 * Rename the `CVision3D` monitor to `Radeon` or `Voodoo` (or some other suitable name for your PCI graphics card)
 * Edit the tooltypes for the monitor
 * Change the `BOARDTYPE` value to the name of the graphics card driver (which live in `LIBS:Picasso96/`), e.g. `Radeon`

#### 3.1.3 Sound card:

Assuming you ran the Elbox installer, it will have installed `AHI`, the Amiga's retargetable audio framework, and several drivers, and a Mixer application.

Your sound card will require some additional configuration:

*NOTE:* AHI is exposed to applications as a series of `unit`s. Each unit can be configured to send its audio to a soundcard of your choice, with quality settings of your choosing. For this section we will assume that you only have one soundcard, you will configure all your applications to use AHI unit 0, and you want the highest possible sound quality.

 * Open `SYS:Prefs/` and run the `AHI` prefs.
 * Find the dropdown for selecting which unit to configure (usually it will say `Music Unit`)
 * In AHI, a unit is an endpoint exposed by AHI to applications. Each application which can use AHI, should let you choose which unit to use. It is up to you how the units are configured. Each one can point at a soundcard of your choice, and have quality settings of your choice
 * For the `Music Unit` and `Unit 0`:
   * Select your soundcard (e.g. `SB128` for a SoundBlaster 128 card). It will be listed several times with different options. The best choice is likely the `HiFi 16 bit stereo++` option.
   * Move the frequency slider to 44000 Hz or above (e.g. 48000 Hz)
 * Click `Save`
 * The soundcard likely defaults to zero volume when it is initialiesd, so you'll need an audio mixer application to save some sensible values and load them at startup. The Elbox installer will have created `SYS:Prefs/Mixer` for changing mixer settings, and a corresponding entry in `S:User-Startup` to load the values at boot.

*NOTE:* The Mixer app supplied by Elbox is not very high quality (Elbox themselves recommend using a third party mixer). A good alternative is [GhostMix](http://aminet.net/package/driver/audio/GhostMix). You will need to remove the Elbox mixer item in `S:User-Startup` to use a different mixer application.

#### 3.1.4 Network card:

The Mediator drivers support 
