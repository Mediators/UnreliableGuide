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

### 2.1 Installation:
Obviously the installation for different Amigas varies widely, because of their different form factors. Specific information for various models can be found below, but the general steps are:

 * Remove any existing Zorro busboards
 * Install the Mediator bridge card into the Mediator busboard
 * Install the combined Mediator boards into the Amiga
 * Before installing any PCI cards, ensure the Amiga still boots (hold both mouse buttons to enter the Early Boot Menu, check for two entries in the *Expansion Board Diagnostic* section, with a Manufacturer ID of 2206.
 * Install a graphics card
 * Install Mediator drivers
 * Ensure graphics card works
 * Install other PCI cards

#### 2.1.1 4000Di

  * Remove the A4000 top cover
  * Remove the hard disk cage
  * Remove the metal crossbar above the Zorro daughterboard
  * Hold the top corners of the Zorro daughterboard and remove it from the motherboard
  * *NOTE:* At least one user has found that the Mediator's bridge board may touch some of the jumpers on the motherboard (specifically, J500, J501, J502, J213 J852 on a Rev B motherboard. Rev D boards only have some of these jumpers). It seems sensible to insulate these jumpers in some way, to prevent them shorting a MACH chip (electrical tape should suffice)
  * Place the Mediator board on a flat surface with the PCI/Zorro slots facing upwards
  * Align the Mediator bridge board with the PCI/Zorro slots nearest the bottom of the card (labelled "MEDIATOR PCI 4000 SLOT")
  * Hold the bridge board along its top edge and push it firmly, but gently, into the slots
   * *NOTE:* It is a good idea to try and insert the card into both slots at the same time. It's easier to push one corner in first, but this is more likely to leave the card incorrectly aligned, which will make the system unstable
  * Align the Mediator board with the daughterboard slot on the motherboard
  * Hold the Mediator board along its top edge and push it firmly, but gently, into the motherboard slot
   * *NOTE:* As above, try to insert the card in one movement, rather than starting with one corner.

## 3. Software:
Along with the hardware, Elbox also produces software and drivers for Mediators and the PCI cards they are compatible with. This is supplied with the Mediator and is called the *Mediator Multimedia CD*.

*NOTE:* It's quite common for the CD supplied by Elbox to be significantly out of date, so always check [their website](http://www.elbox.com/downloads_mediator.html) for a driver pack update (*MM_CD_UP*). However, even these update packs do not always contain the most recently available drivers/libraries. The same download page also lists individual updates that have been released (e.g. pci.library) and the dates. Ensure you have the latest versions of everything.
