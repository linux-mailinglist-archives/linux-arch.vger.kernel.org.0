Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AA3DE9F2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhHCJrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Aug 2021 05:47:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3568 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhHCJrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Aug 2021 05:47:35 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gf95F2Bw9z6DJr6;
        Tue,  3 Aug 2021 17:47:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 11:47:23 +0200
Received: from [10.47.27.165] (10.47.27.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 10:47:22 +0100
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
Date:   Tue, 3 Aug 2021 10:46:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.165]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/07/2021 11:06, Arnd Bergmann wrote:
> On Sat, Jul 3, 2021 at 2:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> The version we got here makes it no longer crash the kernel, but
>> I see your point that the runtime warning is still wrong. I'll have
>> a look at what it would take to guard all inb/outb callers with a
>> Kconfig conditional, and will report back after that.
> 
> I created a preliminary patch and got it to cleanly build on my randconfig box,
> here is what that involved:
> 
> - added 89 Kconfig dependencies on HAS_IOPORT for PC-style devices
>    that are not on a PCI card.
> - added 188 Kconfig dependencies on LEGACY_PCI for PCI drivers that
>    require port I/O. The idea is to have that control drivers for both pre-PCIe
>    devices and and PCIe devices that require long-deprecated features like
>    I/O resources, but possibly other features as well.
> - The ACPI subsystem needs access to I/O ports, so that also gets a
>    dependency.
> - CONFIG_INDIRECT_PIO requires HAS_IOPORT
> -  /dev/ioport needs an #ifdef around it
> - several graphics drivers need workarounds instead of a 'depends on'
>    because they are used in virtual machines: vgaconsole, bochs, qxl,
>    cirrus. They work with or without port I/O
> - A usb-uhci rework to split pci from non-pci support
> - Minor workarounds for optional I/O port usage in libata, ipmi, tpm,
>    dmi-firmware, altera-stapl, parport, vga
> - lots of #ifdefs in 8250
> - some drivers/pci/ quirks are #ifdef'd
> - drivers using ioport_map()/pci_iomap() to access ports could be
>    kept working when I/O ports are memory mapped
> 
> I tested the patch on a 5.13-rc4 snapshot that already has other
> patches applied as a baseline for randconfig testing, so it doesn't
> apply as-is.
> 
> Linus, if you like this approach, then I can work on splitting it up into
> meaningful patches and submit it for a future release. I think the
> CONFIG_LEGACY_PCI option has value on its own, but the others
> do introduce some churn.
> 
> Full patch (120KB): https://pastebin.com/yaFSmAuY
> 

Hi Arnd,

I am not sure if anything is happening here.

Anyway, one thing I mentioned earlier was that we could solve the 
problem of drivers accessing unmapped IO ports and crashing systems on 
archs which define PCI_IOBASE by building them under some "native port 
IO support" flag.

One example of such a driver was F71805F sensor. You put that under 
HAS_IOPORT, which would be available for all archs, I think. But I could 
not see where config LEGACY_PCI is introduced. Could we further refine 
that config to not build for such archs as arm64?

BTW, I think that the PPC dependency was added there to stop building 
for power for that same reason, so hopefully we get rid of that.

Thanks,
John

> diffstat:
>   drivers/accessibility/speakup/Kconfig        |   1 +
>   drivers/acpi/Kconfig                         |   1 +
>   drivers/ata/Kconfig                          |  34 ++++++++++-----------
>   drivers/ata/ata_generic.c                    |   3 +-
>   drivers/ata/libata-sff.c                     |   2 ++
>   drivers/bus/Kconfig                          |   2 +-
>   drivers/char/Kconfig                         |   3 +-
>   drivers/char/ipmi/Makefile                   |  11 +++----
>   drivers/char/ipmi/ipmi_si_intf.c             |   3 +-
>   drivers/char/ipmi/ipmi_si_pci.c              |   3 ++
>   drivers/char/mem.c                           |   6 +++-
>   drivers/char/tpm/Kconfig                     |   1 +
>   drivers/char/tpm/tpm_infineon.c              |  14 ++++++---
>   drivers/char/tpm/tpm_tis_core.c              |  19 +++++-------
>   drivers/comedi/Kconfig                       |  53
> +++++++++++++++++++++++++++++++++
>   drivers/firmware/dmi-sysfs.c                 |   4 +++
>   drivers/gpio/Kconfig                         |   2 +-
>   drivers/gpu/drm/bochs/Kconfig                |   1 +
>   drivers/gpu/drm/bochs/bochs_hw.c             |  24 ++++++++-------
>   drivers/gpu/drm/qxl/Kconfig                  |   1 +
>   drivers/gpu/drm/tiny/cirrus.c                |   2 ++
>   drivers/hwmon/Kconfig                        |  23 +++++++++++++--
>   drivers/i2c/busses/Kconfig                   |  31 ++++++++++---------
>   drivers/ide/Kconfig                          |   1 +
>   drivers/iio/adc/Kconfig                      |   2 +-
>   drivers/input/gameport/Kconfig               |   6 ++--
>   drivers/input/serio/Kconfig                  |   2 ++
>   drivers/input/touchscreen/Kconfig            |   1 +
>   drivers/isdn/hardware/mISDN/Kconfig          |  14 ++++-----
>   drivers/leds/Kconfig                         |   2 +-
>   drivers/media/cec/platform/Kconfig           |   2 +-
>   drivers/media/pci/dm1105/Kconfig             |   2 +-
>   drivers/media/radio/Kconfig                  |  15 +++++++++-
>   drivers/media/rc/Kconfig                     |   9 +++++-
>   drivers/message/fusion/Kconfig               |   8 ++---
>   drivers/misc/altera-stapl/Makefile           |   3 +-
>   drivers/misc/altera-stapl/altera.c           |   6 +++-
>   drivers/net/Kconfig                          |   2 +-
>   drivers/net/arcnet/Kconfig                   |   2 +-
>   drivers/net/can/cc770/Kconfig                |   1 +
>   drivers/net/can/sja1000/Kconfig              |   1 +
>   drivers/net/ethernet/8390/Kconfig            |   2 +-
>   drivers/net/ethernet/amd/Kconfig             |   2 +-
>   drivers/net/ethernet/intel/Kconfig           |   4 +--
>   drivers/net/ethernet/sis/Kconfig             |   6 ++--
>   driv

ers/net/ethernet/ti/Kconfig              |   4 +--
>   drivers/net/ethernet/via/Kconfig             |   5 ++--
>   drivers/net/fddi/Kconfig                     |   4 +--
>   drivers/net/hamradio/Kconfig                 |   6 ++--
>   drivers/net/wan/Kconfig                      |   2 +-
>   drivers/net/wireless/atmel/Kconfig           |   4 +--
>   drivers/net/wireless/intersil/hostap/Kconfig |   4 +--
>   drivers/parport/Kconfig                      |   2 +-
>   drivers/pci/pci-sysfs.c                      |  16 ++++++++++
>   drivers/pci/quirks.c                         |   2 ++
>   drivers/pcmcia/Kconfig                       |   2 +-
>   drivers/platform/chrome/Kconfig              |   1 +
>   drivers/platform/chrome/wilco_ec/Kconfig     |   1 +
>   drivers/pnp/isapnp/Kconfig                   |   2 +-
>   drivers/power/reset/Kconfig                  |   1 +
>   drivers/rtc/Kconfig                          |   4 ++-
>   drivers/scsi/Kconfig                         |  21 ++++++-------
>   drivers/scsi/aic7xxx/Kconfig.aic79xx         |   2 +-
>   drivers/scsi/aic7xxx/Kconfig.aic7xxx         |   2 +-
>   drivers/scsi/aic94xx/Kconfig                 |   2 +-
>   drivers/scsi/megaraid/Kconfig.megaraid       |   2 +-
>   drivers/scsi/mvsas/Kconfig                   |   2 +-
>   drivers/scsi/qla2xxx/Kconfig                 |   2 +-
>   drivers/spi/Kconfig                          |   1 +
>   drivers/staging/kpc2000/Kconfig              |   2 +-
>   drivers/staging/sm750fb/Kconfig              |   2 +-
>   drivers/staging/vt6655/Kconfig               |   2 +-
>   drivers/tty/Kconfig                          |   2 +-
>   drivers/tty/serial/8250/8250_early.c         |   4 +++
>   drivers/tty/serial/8250/8250_pci.c           |  19 ++++++++++--
>   drivers/tty/serial/8250/8250_port.c          |  22 ++++++++++++--
>   drivers/tty/serial/8250/Kconfig              |   1 +
>   drivers/tty/serial/Kconfig                   |   2 +-
>   drivers/usb/core/hcd-pci.c                   |   4 +--
>   drivers/usb/host/Kconfig                     |   4 +--
>   drivers/usb/host/pci-quirks.c                | 128
> +++++++++++++++++++++++++++++++++++++++++--------------------------------------
>   drivers/usb/host/pci-quirks.h                |  33 ++++++++++++++++-----
>   drivers/usb/host/uhci-hcd.c                  |   2 +-
>   drivers/usb/host/uhci-hcd.h                  |  77
> +++++++++++++++++++++++++++++++----------------
>   drivers/video/console/Kconfig                |   4 ++-
>   drivers/video/fbdev/Kconfig                  |  24 +++++++--------
>   drivers/watchdog/Kconfig                     |   6 ++--
>   include/asm-generic/io.h                     |   6 ++++
>   include/linux/gameport.h                     |   9 ++++--
>   include/linux/parport.h                      |   2 +-
>   include/video/vga.h                          |   8 +++++
>   lib/Kconfig                                  |   4 +++
>   lib/Kconfig.kgdb                             |   1 +
>   sound/drivers/Kconfig                        |   3 ++
>   sound/isa/Kconfig                            |   1 +
>   sound/pci/Kconfig                            |  44 ++++++++++++++++++++++-----
>   96 files changed, 575 insertions(+), 272 deletions(-)
> 

