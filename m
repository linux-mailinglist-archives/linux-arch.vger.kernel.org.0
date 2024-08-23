Return-Path: <linux-arch+bounces-6552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFC95CA67
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 12:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7762832CE
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE01581E5;
	Fri, 23 Aug 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fyXmXgAB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917613AA3F;
	Fri, 23 Aug 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408629; cv=none; b=AZWAxqUsotinFrwR7HMeGXhLtDWPuguUX4XEI/gjA3RdnQC4eS5/2xwIMt8sZQRRhf6z1WnOkQXsSAQrNuy9Y7qHxN66bMimCONqSZsEZVGP2YjL4se7sGxaKAKWWIJgWwQuXLo7N3adyfAl/WTMp9yh0RmdaOGEVw9lJfaQ/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408629; c=relaxed/simple;
	bh=5w0PuAf2dn+tyeHO5aWFHVFpSW8XfutqJEA69g9uqdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lSD5/in0yzUHGBoYYfOM/RzOs8sAeS/cfXlZTT8ITmcZKwS5m3eosIVrv+iDe26YSRT0IkhjcX34yDHRezcchvVHsxYoljsOIVvsI1EMtSQ7J+hKZg1y4bIdDzeRxWONnsJQO2vuZRYfMpa4HhwxMQO3p5XBbHwz1IOfvfYjyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fyXmXgAB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724408592; x=1725013392; i=wahrenst@gmx.net;
	bh=oIqtFp6Ae6TJ9QLXtvERW/6PR6LExiVmN9pDVUvAEz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fyXmXgABcnMvOyVxfzX2SjCailLb3/UF0bm05ANMFDSwdaB6qPlEoE7ruPHuWp1e
	 zVmJ4R3ddss2jx5g4tlEQYLkqcQ7c1QCYAyDLYxnS4HgvP0+GcxtwFLTnffG1OcUS
	 VmFnbydYZIf0b+kOZ06vUaa6MjNSQEWOKQ0iYHlurWYp5mg+usRnWQQisgJdR8q+z
	 6mPTawGV/1E22PpWA7eVR61B9W+W7ltsUGuGIFMzEry3qxFvKG2CCJCUEOCywHcGn
	 IxrybYoilVb5jvzveld+dVpKCWXoPDWUp6V6GFEr7cHw0+X5HYpyP4YYPdW5ktoa5
	 vdbRT2b/uxFHKejWJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1sTeUL2oRS-00JOWa; Fri, 23
 Aug 2024 12:23:11 +0200
Message-ID: <015a0dd9-7a13-45b7-971a-19775a6bdd04@gmx.net>
Date: Fri, 23 Aug 2024 12:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <98c570cb-c2ca-4816-9ca4-94033f7fb3fb@gmx.net> <ZshZ6yAmyFoiF5qu@apocalypse>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZshZ6yAmyFoiF5qu@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXUuOY/TM0ugscRQoAdiK8sxMBwrqmfjC9t2Lu8KjCCI1nit/4f
 S5AKf2AZcmT0mQ2eEpsex8Do5aEVMDViYj+M/Z1LWkw++OCtw4Qbi83zSwJxq3ecLTGlb2I
 C2C1LH7bHZt7EMNVJFuYPpoW/kL9XCuzQdAIRkrrIOpheFn0gUlXHF/1uxMAVO2fEwDPaPn
 dvBgAESmdSuXRCHD67QpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FNtuci7freo=;EhUAmBhEQMhnhHQSvbFdcKOI46o
 rd3gHkc9m4Aykz3PvhW0/4GRy319YUKbqt0Kn07n6jLfwrE380csipSuslKBOP7mI/ZIj/3Tk
 mt1UMdmtPjRtnPAhkoBSH5npB+chR3fGG9U3qfvv0UQt6rZMoUWrFwDQcI77Qs7+ZO9Dr5q5Z
 dVW3fIX1NzQrDzKZqGxwpr5tOougJWW5/OddNIVRbuyBE4rCamekuEVNBxZRq0xyfsIX0C3Kf
 /TLhkF+2E6g3mqFV73v7TxUraSeqsmD6JQsKPJ5B+vie2aCmqIwX5hiSOcClNpWK2wQDLkBQw
 IFZKd5H+s/TRm4oE1L2aF++q4rs8KySJvTCpDhrACo/pwq9qg8aMzseRAE8KMICNetfbrz6Ba
 ioqzZFLdPDDVXhDrWWKGkBVOvJli4mRIVabH2/WYwiln163JThh9tm+VJ0DIsWkMc3n98QjpR
 saXxAGUPG2joDIhMJfdkgdqwn2ZnBpUmgHTqpCFU+6JTvvHDjGxO40jPJxLwqFM1Uw+wGIsLH
 2PuHiFiPLSBbIJzIfki6v7BbhrJXU00rqdlBaBzuCJMC1m0cIWZQKb1sQDipRXyqS8QbCOldj
 yKNBYFUpLOXK4jMDuCKECkEVBbf20AD0KPvw0PlN7PgtYDLA0rfm1V/JvKjw6VlzqOp2lNJeo
 XaXS2ZN/taqBh0ZpODV2+aHGRbhP9ECukkr6WO2oHP3iZRCcFdpzB2EMsrNG4jmbhpE12pVI7
 5qdwQJ9XkVGjGJrfPFBpa8jbLI91uVAWWYg9ju24vUJbDu5aR+F6Z3m7TP5sGa8aEDWNNx7bA
 MpoQ3JVHHusKFXXC6qtUV2H8UOhPYLeRq5jM+akIgFBEM=

Hi Andrea,

Am 23.08.24 um 11:44 schrieb Andrea della Porta:
> Hi Stefan,
>
> On 18:20 Wed 21 Aug     , Stefan Wahren wrote:
>> Hi Andrea,
>>
>> Am 20.08.24 um 16:36 schrieb Andrea della Porta:
>>> The RaspberryPi RP1 is ia PCI multi function device containing
>>> peripherals ranging from Ethernet to USB controller, I2C, SPI
>>> and others.
>> sorry, i cannot provide you a code review, but just some comments. mult=
i
>> function device suggests "mfd" subsystem or at least "soc" . I won't
>> recommend misc driver here.
> It's true that RP1 can be called an MFD but the reason for not placing
> it in mfd subsystem are twofold:
>
> - these discussions are quite clear about this matter: please see [1]
>    and [2]
> - the current driver use no mfd API at all
>
> This RP1 driver is not currently addressing any aspect of ARM core in th=
e
> SoC so I would say it should not stay in drivers/soc / either, as also
> condifirmed by [2] again and [3] (note that Microchip LAN966x is a very
> close fit to what we have here on RP1).
thanks i was aware of these discussions. A pointer to them or at least a
short statement in the cover letter would be great.
>
>>> Implement a bare minimum driver to operate the RP1, leveraging
>>> actual OF based driver implementations for the on-borad peripherals
>>> by loading a devicetree overlay during driver probe.
>> Can you please explain why this should be a DT overlay? The RP1 is
>> assembled on the Raspberry Pi 5 PCB. DT overlays are typically for loos=
e
>> connections like displays or HATs. I think a DTSI just for the RP1 woul=
d
>> fit better and is easier to read.
> The dtsi solution you proposed is the one adopted downstream. It has its
> benefits of course, but there's more.
> With the overlay approach we can achieve more generic and agnostic appro=
ach
> to managing this chipset, being that it is a PCI endpoint and could be
> possibly be reused in other hw implementations. I believe a similar
> reasoning could be applied to Bootlin's Microchip LAN966x patchset as
> well, and they also choose to approach the dtb overlay.
Could please add this point in the commit message. Doesn't introduce
(maintainence) issues in case U-Boot needs a RP1 driver, too?
> Plus, a solution that can (althoguh proabbly in teh long run) cope
> with both DT or ACPI based system has been kindly requested, plase see [=
4]
> for details.
> IMHO the approach proposed from RH et al. of using dtbo for this 'specia=
l'
> kind of drivers makes a lot of sense (see [5]).
>
>>> The peripherals are accessed by mapping MMIO registers starting
>>> from PCI BAR1 region.
>>> As a minimum driver, the peripherals will not be added to the
>>> dtbo here, but in following patches.
>>>
>>> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> ---
>>>    MAINTAINERS                           |   2 +
>>>    arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
>>>    drivers/misc/Kconfig                  |   1 +
>>>    drivers/misc/Makefile                 |   1 +
>>>    drivers/misc/rp1/Kconfig              |  20 ++
>>>    drivers/misc/rp1/Makefile             |   3 +
>>>    drivers/misc/rp1/rp1-pci.c            | 333 +++++++++++++++++++++++=
+++
>>>    drivers/misc/rp1/rp1-pci.dtso         |   8 +
>>>    drivers/pci/quirks.c                  |   1 +
>>>    include/linux/pci_ids.h               |   3 +
>>>    10 files changed, 524 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>>>    create mode 100644 drivers/misc/rp1/Kconfig
>>>    create mode 100644 drivers/misc/rp1/Makefile
>>>    create mode 100644 drivers/misc/rp1/rp1-pci.c
>>>    create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>>>
>> ...
>>> +
>>> +				rp1_clocks: clocks@c040018000 {
>>> +					compatible =3D "raspberrypi,rp1-clocks";
>>> +					#clock-cells =3D <1>;
>>> +					reg =3D <0xc0 0x40018000 0x0 0x10038>;
>>> +					clocks =3D <&clk_xosc>;
>>> +					clock-names =3D "xosc";
>>> +
>>> +					assigned-clocks =3D <&rp1_clocks RP1_PLL_SYS_CORE>,
>>> +							  <&rp1_clocks RP1_PLL_AUDIO_CORE>,
>>> +							  // RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DP=
I drivers
>>> +							  <&rp1_clocks RP1_PLL_SYS>,
>>> +							  <&rp1_clocks RP1_PLL_SYS_SEC>,
>>> +							  <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
>>> +							  <&rp1_clocks RP1_CLK_ETH_TSU>;
>>> +
>>> +					assigned-clock-rates =3D <1000000000>, // RP1_PLL_SYS_CORE
>>> +							       <1536000000>, // RP1_PLL_AUDIO_CORE
>>> +							       <200000000>,  // RP1_PLL_SYS
>>> +							       <125000000>,  // RP1_PLL_SYS_SEC
>>> +							       <100000000>,  // RP1_PLL_SYS_PRI_PH
>>> +							       <50000000>;   // RP1_CLK_ETH_TSU
>>> +				};
>>> +
>>> +				rp1_gpio: pinctrl@c0400d0000 {
>>> +					reg =3D <0xc0 0x400d0000  0x0 0xc000>,
>>> +					      <0xc0 0x400e0000  0x0 0xc000>,
>>> +					      <0xc0 0x400f0000  0x0 0xc000>;
>>> +					compatible =3D "raspberrypi,rp1-gpio";
>>> +					gpio-controller;
>>> +					#gpio-cells =3D <2>;
>>> +					interrupt-controller;
>>> +					#interrupt-cells =3D <2>;
>>> +					interrupts =3D <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
>>> +						     <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
>>> +						     <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
>>> +					gpio-line-names =3D
>>> +						"ID_SDA", // GPIO0
>>> +						"ID_SCL", // GPIO1
>>> +						"GPIO2", // GPIO2
>>> +						"GPIO3", // GPIO3
>>> +						"GPIO4", // GPIO4
>>> +						"GPIO5", // GPIO5
>>> +						"GPIO6", // GPIO6
>>> +						"GPIO7", // GPIO7
>>> +						"GPIO8", // GPIO8
>>> +						"GPIO9", // GPIO9
>>> +						"GPIO10", // GPIO10
>>> +						"GPIO11", // GPIO11
>>> +						"GPIO12", // GPIO12
>>> +						"GPIO13", // GPIO13
>>> +						"GPIO14", // GPIO14
>>> +						"GPIO15", // GPIO15
>>> +						"GPIO16", // GPIO16
>>> +						"GPIO17", // GPIO17
>>> +						"GPIO18", // GPIO18
>>> +						"GPIO19", // GPIO19
>>> +						"GPIO20", // GPIO20
>>> +						"GPIO21", // GPIO21
>>> +						"GPIO22", // GPIO22
>>> +						"GPIO23", // GPIO23
>>> +						"GPIO24", // GPIO24
>>> +						"GPIO25", // GPIO25
>>> +						"GPIO26", // GPIO26
>>> +						"GPIO27", // GPIO27
>>> +						"PCIE_RP1_WAKE", // GPIO28
>>> +						"FAN_TACH", // GPIO29
>>> +						"HOST_SDA", // GPIO30
>>> +						"HOST_SCL", // GPIO31
>>> +						"ETH_RST_N", // GPIO32
>>> +						"", // GPIO33
>>> +						"CD0_IO0_MICCLK", // GPIO34
>>> +						"CD0_IO0_MICDAT0", // GPIO35
>>> +						"RP1_PCIE_CLKREQ_N", // GPIO36
>>> +						"", // GPIO37
>>> +						"CD0_SDA", // GPIO38
>>> +						"CD0_SCL", // GPIO39
>>> +						"CD1_SDA", // GPIO40
>>> +						"CD1_SCL", // GPIO41
>>> +						"USB_VBUS_EN", // GPIO42
>>> +						"USB_OC_N", // GPIO43
>>> +						"RP1_STAT_LED", // GPIO44
>>> +						"FAN_PWM", // GPIO45
>>> +						"CD1_IO0_MICCLK", // GPIO46
>>> +						"2712_WAKE", // GPIO47
>>> +						"CD1_IO1_MICDAT1", // GPIO48
>>> +						"EN_MAX_USB_CUR", // GPIO49
>>> +						"", // GPIO50
>>> +						"", // GPIO51
>>> +						"", // GPIO52
>>> +						""; // GPIO53
>> GPIO line names are board specific, so this should go to the Raspberry
>> Pi 5 file.
> Could we instead just name them with generic GPIO'N' where N is the numb=
er
> of the gpio? Much like many of that pins already are... in this way we
> don't add a dependency in the board dts to the rp1_gpio node, which is n=
ot
> even there when the main dts is parsed at boot, since the dtbo will be
> added only on PCI enumeration of the RP1 device.
I think we should avoid user space incompatibilities with the vendor tree.
> Or even better: since we don't explicitly use the gpio names to address
> them (e.g. phy-reset-gpios in rp1_eth node is addressing the ETH_RST_N
> gpio by number), can we just get rid of the gpio-line-names property?
> Also Bootlin's Microchip gpio node seems to avoid naming them...
As i said above the gpio lines are for user space, honestly nobody likes
to go to cryptic interfaces of gpiochips and gpio numbers.

Maybe ETH_RST_N isn't good example because this not interesting from
user space. For example RP1_STAT_LED is a better one. Nobody can predict
the future use cases of the RP1 and its pins. So i think we should have
the flexibilty to specify the GPIOs on the board level for user
friendliness.

Isn't it possible to specify almost empty rp1 node with the gpio line
names for the RPi 5 and apply the rp1 overlay on top?
>
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index 41c3d2821a78..02405209e6c4 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -618,4 +618,5 @@ source "drivers/misc/uacce/Kconfig"
>>>    source "drivers/misc/pvpanic/Kconfig"
>>>    source "drivers/misc/mchp_pci1xxxx/Kconfig"
>>>    source "drivers/misc/keba/Kconfig"
>>> +source "drivers/misc/rp1/Kconfig"
>>>    endmenu
>>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>>> index c2f990862d2b..84bfa866fbee 100644
>>> --- a/drivers/misc/Makefile
>>> +++ b/drivers/misc/Makefile
>>> @@ -71,3 +71,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
>>>    obj-$(CONFIG_NSM)		+=3D nsm.o
>>>    obj-$(CONFIG_MARVELL_CN10K_DPI)	+=3D mrvl_cn10k_dpi.o
>>>    obj-y				+=3D keba/
>>> +obj-$(CONFIG_MISC_RP1)		+=3D rp1/
>>> diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
>>> new file mode 100644
>>> index 000000000000..050417ee09ae
>>> --- /dev/null
>>> +++ b/drivers/misc/rp1/Kconfig
>>> @@ -0,0 +1,20 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +#
>>> +# RaspberryPi RP1 misc device
>>> +#
>>> +
>>> +config MISC_RP1
>>> +        tristate "RaspberryPi RP1 PCIe support"
>>> +        depends on PCI && PCI_QUIRKS
>>> +        select OF
>>> +        select OF_OVERLAY
>>> +        select IRQ_DOMAIN
>>> +        select PCI_DYNAMIC_OF_NODES
>>> +        help
>>> +          Support for the RP1 peripheral chip found on Raspberry Pi 5=
 board.
>>> +          This device supports several sub-devices including e.g. Eth=
ernet controller,
>>> +          USB controller, I2C, SPI and UART.
>>> +          The driver is responsible for enabling the DT node once the=
 PCIe endpoint
>>> +          has been configured, and handling interrupts.
>>> +          This driver uses an overlay to load other drivers to suppor=
t for RP1
>>> +          internal sub-devices.
>>> diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
>>> new file mode 100644
>>> index 000000000000..e83854b4ed2c
>>> --- /dev/null
>>> +++ b/drivers/misc/rp1/Makefile
>>> @@ -0,0 +1,3 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +rp1-pci-objs			:=3D rp1-pci.o rp1-pci.dtbo.o
>>> +obj-$(CONFIG_MISC_RP1)		+=3D rp1-pci.o
>>> diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
>>> new file mode 100644
>>> index 000000000000..a6093ba7e19a
>>> --- /dev/null
>>> +++ b/drivers/misc/rp1/rp1-pci.c
>>> @@ -0,0 +1,333 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2018-22 Raspberry Pi Ltd.
>>> + * All rights reserved.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/clkdev.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/err.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/module.h>
>>> +#include <linux/msi.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset.h>
>>> +
>>> +#include <dt-bindings/misc/rp1.h>
>>> +
>>> +#define RP1_B0_CHIP_ID		0x10001927
>>> +#define RP1_C0_CHIP_ID		0x20001927
>>> +
>>> +#define RP1_PLATFORM_ASIC	BIT(1)
>>> +#define RP1_PLATFORM_FPGA	BIT(0)
>>> +
>>> +#define RP1_DRIVER_NAME		"rp1"
>>> +
>>> +#define RP1_ACTUAL_IRQS		RP1_INT_END
>>> +#define RP1_IRQS		RP1_ACTUAL_IRQS
>>> +#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
>>> +
>>> +#define RP1_SYSCLK_RATE		200000000
>>> +#define RP1_SYSCLK_FPGA_RATE	60000000
>>> +
>>> +enum {
>>> +	SYSINFO_CHIP_ID_OFFSET	=3D 0,
>>> +	SYSINFO_PLATFORM_OFFSET	=3D 4,
>>> +};
>>> +
>>> +#define REG_SET			0x800
>>> +#define REG_CLR			0xc00
>>> +
>>> +/* MSIX CFG registers start at 0x8 */
>>> +#define MSIX_CFG(x) (0x8 + (4 * (x)))
>>> +
>>> +#define MSIX_CFG_IACK_EN        BIT(3)
>>> +#define MSIX_CFG_IACK           BIT(2)
>>> +#define MSIX_CFG_TEST           BIT(1)
>>> +#define MSIX_CFG_ENABLE         BIT(0)
>>> +
>>> +#define INTSTATL		0x108
>>> +#define INTSTATH		0x10c
>>> +
>>> +extern char __dtbo_rp1_pci_begin[];
>>> +extern char __dtbo_rp1_pci_end[];
>>> +
>>> +struct rp1_dev {
>>> +	struct pci_dev *pdev;
>>> +	struct device *dev;
>>> +	struct clk *sys_clk;
>>> +	struct irq_domain *domain;
>>> +	struct irq_data *pcie_irqds[64];
>>> +	void __iomem *bar1;
>>> +	int ovcs_id;
>>> +	bool level_triggered_irq[RP1_ACTUAL_IRQS];
>>> +};
>>> +
>>> +
>> ...
>>> +
>>> +static const struct pci_device_id dev_id_table[] =3D {
>>> +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0), },
>>> +	{ 0, }
>>> +};
>>> +
>>> +static struct pci_driver rp1_driver =3D {
>>> +	.name		=3D RP1_DRIVER_NAME,
>>> +	.id_table	=3D dev_id_table,
>>> +	.probe		=3D rp1_probe,
>>> +	.remove		=3D rp1_remove,
>>> +};
>>> +
>>> +module_pci_driver(rp1_driver);
>>> +
>>> +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
>> Module author & Copyright doesn't seem to match with this patch author.
>> Please clarify/fix
> My intention here is that, even if the code has been heavily modified by=
 me,
> the core original code is still there so I just wanted to tribute it to =
the
> original author.
> I'll synchronize this with RaspberryPi guys and coem up with a unified s=
olution.
That would be nice to mention in the commit message and add your copyright=
.
> Just in case: would multiple MODULE_AUTHOR entries (one with my name and=
 one
> with original authors name) be accepetd?
Sure

Best regards
>
> Many thanks,
> Andrea
>
> References:
>
> - [1]: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> - [2]: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@=
app.fastmail.com/
> - [3]: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@greg=
kh/
> - [4]: https://lore.kernel.org/all/ba8cdf39-3ba3-4abc-98f5-d394d6867f95@=
gmx.net/
> - [5]: https://lpc.events/event/17/contributions/1421/attachments/1337/2=
680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf


