Return-Path: <linux-arch+bounces-6558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B595D387
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CC1C23938
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F618E059;
	Fri, 23 Aug 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H+2PSxoC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AF18CC15
	for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430717; cv=none; b=Y75jXvMyRySWMVDJ0HBhzDuqlbZ+iZ2rPbJp/4AoIs3pUwNdzO0TkOmx52sh3CHJNBr1kdQ3+gwVedl/wkEx+GKy1LHUB7jIQL+XLUP5JX/R9MBrOEBVsQ7oXwaeoWumUIHG7w5v9wrvci6Uf2JyP4gQ9QSBTciWhTPnIhJhcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430717; c=relaxed/simple;
	bh=F6DrVBqmr8DZ7/qOT985RFRfip+ZlTTG7uWTZ30JuhY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anVB4A3ayHsbwL8+Ad195GMH/qUvr75dJg2spHXItTW3H/KeH3Xave9QHATtOgLAaaxNjRxSS695mFjxhzUhg+tQWeYpw1eTd+bdDHRdM+HLbMnZo8DB9kvLdLr6xuDviTwQKKSDNCSu0UWD7iD/8ttxOSZMbzsx2IY/v4bZUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H+2PSxoC; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso2587509a12.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724430711; x=1725035511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZaGyMHt/Y75dEv/4xjnO+Th51UKr4la400Nkts6FuE=;
        b=H+2PSxoCplMqFimtYzJ3Lxa/ExF6KZHQEMoMjdCAFdDmv1SBdEwrGIAILJtSUUCVQ0
         GNUoiD/JRekA9t9ntFaQZSp0rtCr52/8dRNygo5Bt5MpEVxc8xsUxm7YwWU8jA/WMziB
         MjlVceZEOFY13BGEogOVpYgGAD3HbLpv80mN8/UpIvgIs+Lwf+ByN4fKuMxrQwxTA2D1
         uCc+Xbv08vzOvMTP9imIvjnBc5m9eJE0ELqoO6El7JYpzNLTaXU611BqZGFY49JDOfpV
         6/p3/CuCjvNKWGXwQtuXq3d9rCobWxOU8ADCX+Jp6T+MU+1kyCTYth1OyLj3NScrX6Vh
         2NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430711; x=1725035511;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZaGyMHt/Y75dEv/4xjnO+Th51UKr4la400Nkts6FuE=;
        b=KETMoNvTWxTn7KrhVNTK5xtSf1865ZfYMDFyAdmHAVVkk8NCNjp/2eEDaG19JEwduC
         d9PGsNQ1i3FZ1wk7mQgHvQrWmLt+Ef81ZK/6QSKoYZ/BFX5xHZ7MH93YYdeU7zMhgATC
         CpuBalrqmFKHx1EDIJ3jxQkbyoY28kBLy5n8qSgLN5+zGNCfTdH6jyHIwk6EEqfGDhTP
         sZ/WcVTK87xXqP2243F82m/JOM2RxR/b95+5b+cDZz1ep46mZyXSjqyEZIXbzlMdeZTt
         hhtMjZX9NCU//yHEV7nwvOv78Xg8rfMiT1A4xk9ts+H6HlVOmK2C8GAAAe3n1QD7EZt3
         cZLg==
X-Forwarded-Encrypted: i=1; AJvYcCU/CLqvW/LnGZBkIPFQ+Fi9kL2Y+EwtRg6Pasv4Gfp9Y/O+MCg0IBXCCMBuND/MqiDW6IuO68sUx4LB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PX6suN6GoNqqJFGK1joFzmnt4+1xXV1t1RcpGNgqjkIMvxKe
	gluuG4JVoQ1tfA6XPNzyFOcTrKpIqVHfkr0KmoKnyMIQn0YmHkPhmy3VA/n9gkY=
X-Google-Smtp-Source: AGHT+IFBtzXsEdrt771hD3ebM3CWatKP6Y2IMI1S39d3WBOdGKb6/FwUn3n8mhJy59kZRavNaKp06w==
X-Received: by 2002:a17:907:1c2a:b0:a86:8e3d:86e2 with SMTP id a640c23a62f3a-a86a518ef4fmr189485966b.11.1724430710516;
        Fri, 23 Aug 2024 09:31:50 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48aac4sm276582266b.185.2024.08.23.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:31:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 23 Aug 2024 18:31:56 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Zsi5fNftL21vqJ3w@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <98c570cb-c2ca-4816-9ca4-94033f7fb3fb@gmx.net>
 <ZshZ6yAmyFoiF5qu@apocalypse>
 <015a0dd9-7a13-45b7-971a-19775a6bdd04@gmx.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015a0dd9-7a13-45b7-971a-19775a6bdd04@gmx.net>

Hi Stefan,

On 12:23 Fri 23 Aug     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 23.08.24 um 11:44 schrieb Andrea della Porta:
> > Hi Stefan,
> > 
> > On 18:20 Wed 21 Aug     , Stefan Wahren wrote:
> > > Hi Andrea,
> > > 
> > > Am 20.08.24 um 16:36 schrieb Andrea della Porta:
> > > > The RaspberryPi RP1 is ia PCI multi function device containing
> > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > and others.
> > > sorry, i cannot provide you a code review, but just some comments. multi
> > > function device suggests "mfd" subsystem or at least "soc" . I won't
> > > recommend misc driver here.
> > It's true that RP1 can be called an MFD but the reason for not placing
> > it in mfd subsystem are twofold:
> > 
> > - these discussions are quite clear about this matter: please see [1]
> >    and [2]
> > - the current driver use no mfd API at all
> > 
> > This RP1 driver is not currently addressing any aspect of ARM core in the
> > SoC so I would say it should not stay in drivers/soc / either, as also
> > condifirmed by [2] again and [3] (note that Microchip LAN966x is a very
> > close fit to what we have here on RP1).
> thanks i was aware of these discussions. A pointer to them or at least a
> short statement in the cover letter would be great.

Sure, consider it done.

> > 
> > > > Implement a bare minimum driver to operate the RP1, leveraging
> > > > actual OF based driver implementations for the on-borad peripherals
> > > > by loading a devicetree overlay during driver probe.
> > > Can you please explain why this should be a DT overlay? The RP1 is
> > > assembled on the Raspberry Pi 5 PCB. DT overlays are typically for loose
> > > connections like displays or HATs. I think a DTSI just for the RP1 would
> > > fit better and is easier to read.
> > The dtsi solution you proposed is the one adopted downstream. It has its
> > benefits of course, but there's more.
> > With the overlay approach we can achieve more generic and agnostic approach
> > to managing this chipset, being that it is a PCI endpoint and could be
> > possibly be reused in other hw implementations. I believe a similar
> > reasoning could be applied to Bootlin's Microchip LAN966x patchset as
> > well, and they also choose to approach the dtb overlay.
> Could please add this point in the commit message. Doesn't introduce

Ack.

> (maintainence) issues in case U-Boot needs a RP1 driver, too?

Good point. Right now u-boot does not support RP1 nor PCIe (which is a
prerequisite for RP1 to work) on Rpi5 and I'm quite sure that it will be
so in the near future. Of course I cannot guarantee this will be the case
far away in time.

Since u-boot is lacking support for RP1 we cannot really produce some test
results to check the compatibility versus kernel dtb overlay but we can
speculate a little bit about it. AFAIK u-boot would probably place the rp1
node directly under its pcie@12000 node in DT while the dtb overlay will use
dynamically created PCI endpoint node (dev@0) as parent for rp1 node.

I would say it should work out of the box, the only minor drawback here should
be the redundant rp1 node left from u-boot. And maybe some added checks to
make sure the driver will be loaded only once from the dtb overlay and not
from the u-boot node, but this change is locally to the RP1 linux driver code
so it should not impact u-boot in any way.  I'm inclined to consider the last
one a minor issue. 
Please do keep in mind that, of course, this is just brainstorming and I cannot
give 100% guarantee about that.

> > Plus, a solution that can (althoguh proabbly in teh long run) cope
> > with both DT or ACPI based system has been kindly requested, plase see [4]
> > for details.
> > IMHO the approach proposed from RH et al. of using dtbo for this 'special'
> > kind of drivers makes a lot of sense (see [5]).
> > 
> > > > The peripherals are accessed by mapping MMIO registers starting
> > > > from PCI BAR1 region.
> > > > As a minimum driver, the peripherals will not be added to the
> > > > dtbo here, but in following patches.
> > > > 
> > > > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > ---
> > > >    MAINTAINERS                           |   2 +
> > > >    arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
> > > >    drivers/misc/Kconfig                  |   1 +
> > > >    drivers/misc/Makefile                 |   1 +
> > > >    drivers/misc/rp1/Kconfig              |  20 ++
> > > >    drivers/misc/rp1/Makefile             |   3 +
> > > >    drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
> > > >    drivers/misc/rp1/rp1-pci.dtso         |   8 +
> > > >    drivers/pci/quirks.c                  |   1 +
> > > >    include/linux/pci_ids.h               |   3 +
> > > >    10 files changed, 524 insertions(+)
> > > >    create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
> > > >    create mode 100644 drivers/misc/rp1/Kconfig
> > > >    create mode 100644 drivers/misc/rp1/Makefile
> > > >    create mode 100644 drivers/misc/rp1/rp1-pci.c
> > > >    create mode 100644 drivers/misc/rp1/rp1-pci.dtso
> > > > 
> > > ...
> > > > +
> > > > +				rp1_clocks: clocks@c040018000 {
> > > > +					compatible = "raspberrypi,rp1-clocks";
> > > > +					#clock-cells = <1>;
> > > > +					reg = <0xc0 0x40018000 0x0 0x10038>;
> > > > +					clocks = <&clk_xosc>;
> > > > +					clock-names = "xosc";
> > > > +
> > > > +					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
> > > > +							  <&rp1_clocks RP1_PLL_AUDIO_CORE>,
> > > > +							  // RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI drivers
> > > > +							  <&rp1_clocks RP1_PLL_SYS>,
> > > > +							  <&rp1_clocks RP1_PLL_SYS_SEC>,
> > > > +							  <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
> > > > +							  <&rp1_clocks RP1_CLK_ETH_TSU>;
> > > > +
> > > > +					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
> > > > +							       <1536000000>, // RP1_PLL_AUDIO_CORE
> > > > +							       <200000000>,  // RP1_PLL_SYS
> > > > +							       <125000000>,  // RP1_PLL_SYS_SEC
> > > > +							       <100000000>,  // RP1_PLL_SYS_PRI_PH
> > > > +							       <50000000>;   // RP1_CLK_ETH_TSU
> > > > +				};
> > > > +
> > > > +				rp1_gpio: pinctrl@c0400d0000 {
> > > > +					reg = <0xc0 0x400d0000  0x0 0xc000>,
> > > > +					      <0xc0 0x400e0000  0x0 0xc000>,
> > > > +					      <0xc0 0x400f0000  0x0 0xc000>;
> > > > +					compatible = "raspberrypi,rp1-gpio";
> > > > +					gpio-controller;
> > > > +					#gpio-cells = <2>;
> > > > +					interrupt-controller;
> > > > +					#interrupt-cells = <2>;
> > > > +					interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
> > > > +						     <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
> > > > +						     <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
> > > > +					gpio-line-names =
> > > > +						"ID_SDA", // GPIO0
> > > > +						"ID_SCL", // GPIO1
> > > > +						"GPIO2", // GPIO2
> > > > +						"GPIO3", // GPIO3
> > > > +						"GPIO4", // GPIO4
> > > > +						"GPIO5", // GPIO5
> > > > +						"GPIO6", // GPIO6
> > > > +						"GPIO7", // GPIO7
> > > > +						"GPIO8", // GPIO8
> > > > +						"GPIO9", // GPIO9
> > > > +						"GPIO10", // GPIO10
> > > > +						"GPIO11", // GPIO11
> > > > +						"GPIO12", // GPIO12
> > > > +						"GPIO13", // GPIO13
> > > > +						"GPIO14", // GPIO14
> > > > +						"GPIO15", // GPIO15
> > > > +						"GPIO16", // GPIO16
> > > > +						"GPIO17", // GPIO17
> > > > +						"GPIO18", // GPIO18
> > > > +						"GPIO19", // GPIO19
> > > > +						"GPIO20", // GPIO20
> > > > +						"GPIO21", // GPIO21
> > > > +						"GPIO22", // GPIO22
> > > > +						"GPIO23", // GPIO23
> > > > +						"GPIO24", // GPIO24
> > > > +						"GPIO25", // GPIO25
> > > > +						"GPIO26", // GPIO26
> > > > +						"GPIO27", // GPIO27
> > > > +						"PCIE_RP1_WAKE", // GPIO28
> > > > +						"FAN_TACH", // GPIO29
> > > > +						"HOST_SDA", // GPIO30
> > > > +						"HOST_SCL", // GPIO31
> > > > +						"ETH_RST_N", // GPIO32
> > > > +						"", // GPIO33
> > > > +						"CD0_IO0_MICCLK", // GPIO34
> > > > +						"CD0_IO0_MICDAT0", // GPIO35
> > > > +						"RP1_PCIE_CLKREQ_N", // GPIO36
> > > > +						"", // GPIO37
> > > > +						"CD0_SDA", // GPIO38
> > > > +						"CD0_SCL", // GPIO39
> > > > +						"CD1_SDA", // GPIO40
> > > > +						"CD1_SCL", // GPIO41
> > > > +						"USB_VBUS_EN", // GPIO42
> > > > +						"USB_OC_N", // GPIO43
> > > > +						"RP1_STAT_LED", // GPIO44
> > > > +						"FAN_PWM", // GPIO45
> > > > +						"CD1_IO0_MICCLK", // GPIO46
> > > > +						"2712_WAKE", // GPIO47
> > > > +						"CD1_IO1_MICDAT1", // GPIO48
> > > > +						"EN_MAX_USB_CUR", // GPIO49
> > > > +						"", // GPIO50
> > > > +						"", // GPIO51
> > > > +						"", // GPIO52
> > > > +						""; // GPIO53
> > > GPIO line names are board specific, so this should go to the Raspberry
> > > Pi 5 file.
> > Could we instead just name them with generic GPIO'N' where N is the number
> > of the gpio? Much like many of that pins already are... in this way we
> > don't add a dependency in the board dts to the rp1_gpio node, which is not
> > even there when the main dts is parsed at boot, since the dtbo will be
> > added only on PCI enumeration of the RP1 device.
> I think we should avoid user space incompatibilities with the vendor tree.
> > Or even better: since we don't explicitly use the gpio names to address
> > them (e.g. phy-reset-gpios in rp1_eth node is addressing the ETH_RST_N
> > gpio by number), can we just get rid of the gpio-line-names property?
> > Also Bootlin's Microchip gpio node seems to avoid naming them...
> As i said above the gpio lines are for user space, honestly nobody likes
> to go to cryptic interfaces of gpiochips and gpio numbers.
>

You're right.
 
> Maybe ETH_RST_N isn't good example because this not interesting from
> user space. For example RP1_STAT_LED is a better one. Nobody can predict
> the future use cases of the RP1 and its pins. So i think we should have
> the flexibilty to specify the GPIOs on the board level for user
> friendliness.
>

Agreed.
 
> Isn't it possible to specify almost empty rp1 node with the gpio line
> names for the RPi 5 and apply the rp1 overlay on top?

Uhm, we can think of something like that, i.e. a secondary dtbo (populated
with the gpio-line-names property only) to be added after the PCI enumeration
has added the primary dtbo (i.e. the proposed rp1.dtso with gpio-line-names
dropped) into devicetree. This implies loading this second dtbo from either:

- the RP1 driver itself, since it's the one that is dynamically adding
the RP1 node. I would say this is not the cleanest way unless we provide
an elegant way to fed the customized dtbo to teh driver itself, but has
the advantage that it would surely work and has no side effects that
come to mind.

- late at boot, directly from userspace. I see 2 problems here:
1) the gpio driver is already probed by the first dtbo so we should have
   a way to just add teh gpio names to the alredy existing one. Not sure
   how to accomplish that right now.
2) not sure whether how to prepare the dtbo, it should probably have an
   empty target-path since the dt parent tree is created dynamically and
   can be different for each system.

This could be also helpful to customize things like the phy, that is
external to teh ethernet MAC.
I need to do some investigation, but would be helpful if you or others
have some preference/objection on the two approaches above.

> > 
> > > > +				};
> > > > +			};
> > > > +		};
> > > > +	};
> > > > +};
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > index 41c3d2821a78..02405209e6c4 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -618,4 +618,5 @@ source "drivers/misc/uacce/Kconfig"
> > > >    source "drivers/misc/pvpanic/Kconfig"
> > > >    source "drivers/misc/mchp_pci1xxxx/Kconfig"
> > > >    source "drivers/misc/keba/Kconfig"
> > > > +source "drivers/misc/rp1/Kconfig"
> > > >    endmenu
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > index c2f990862d2b..84bfa866fbee 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -71,3 +71,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
> > > >    obj-$(CONFIG_NSM)		+= nsm.o
> > > >    obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
> > > >    obj-y				+= keba/
> > > > +obj-$(CONFIG_MISC_RP1)		+= rp1/
> > > > diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
> > > > new file mode 100644
> > > > index 000000000000..050417ee09ae
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rp1/Kconfig
> > > > @@ -0,0 +1,20 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +#
> > > > +# RaspberryPi RP1 misc device
> > > > +#
> > > > +
> > > > +config MISC_RP1
> > > > +        tristate "RaspberryPi RP1 PCIe support"
> > > > +        depends on PCI && PCI_QUIRKS
> > > > +        select OF
> > > > +        select OF_OVERLAY
> > > > +        select IRQ_DOMAIN
> > > > +        select PCI_DYNAMIC_OF_NODES
> > > > +        help
> > > > +          Support for the RP1 peripheral chip found on Raspberry Pi 5 board.
> > > > +          This device supports several sub-devices including e.g. Ethernet controller,
> > > > +          USB controller, I2C, SPI and UART.
> > > > +          The driver is responsible for enabling the DT node once the PCIe endpoint
> > > > +          has been configured, and handling interrupts.
> > > > +          This driver uses an overlay to load other drivers to support for RP1
> > > > +          internal sub-devices.
> > > > diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> > > > new file mode 100644
> > > > index 000000000000..e83854b4ed2c
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rp1/Makefile
> > > > @@ -0,0 +1,3 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +rp1-pci-objs			:= rp1-pci.o rp1-pci.dtbo.o
> > > > +obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
> > > > diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
> > > > new file mode 100644
> > > > index 000000000000..a6093ba7e19a
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rp1/rp1-pci.c
> > > > @@ -0,0 +1,333 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2018-22 Raspberry Pi Ltd.
> > > > + * All rights reserved.
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clkdev.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/irqchip/chained_irq.h>
> > > > +#include <linux/irqdomain.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/msi.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/reset.h>
> > > > +
> > > > +#include <dt-bindings/misc/rp1.h>
> > > > +
> > > > +#define RP1_B0_CHIP_ID		0x10001927
> > > > +#define RP1_C0_CHIP_ID		0x20001927
> > > > +
> > > > +#define RP1_PLATFORM_ASIC	BIT(1)
> > > > +#define RP1_PLATFORM_FPGA	BIT(0)
> > > > +
> > > > +#define RP1_DRIVER_NAME		"rp1"
> > > > +
> > > > +#define RP1_ACTUAL_IRQS		RP1_INT_END
> > > > +#define RP1_IRQS		RP1_ACTUAL_IRQS
> > > > +#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
> > > > +
> > > > +#define RP1_SYSCLK_RATE		200000000
> > > > +#define RP1_SYSCLK_FPGA_RATE	60000000
> > > > +
> > > > +enum {
> > > > +	SYSINFO_CHIP_ID_OFFSET	= 0,
> > > > +	SYSINFO_PLATFORM_OFFSET	= 4,
> > > > +};
> > > > +
> > > > +#define REG_SET			0x800
> > > > +#define REG_CLR			0xc00
> > > > +
> > > > +/* MSIX CFG registers start at 0x8 */
> > > > +#define MSIX_CFG(x) (0x8 + (4 * (x)))
> > > > +
> > > > +#define MSIX_CFG_IACK_EN        BIT(3)
> > > > +#define MSIX_CFG_IACK           BIT(2)
> > > > +#define MSIX_CFG_TEST           BIT(1)
> > > > +#define MSIX_CFG_ENABLE         BIT(0)
> > > > +
> > > > +#define INTSTATL		0x108
> > > > +#define INTSTATH		0x10c
> > > > +
> > > > +extern char __dtbo_rp1_pci_begin[];
> > > > +extern char __dtbo_rp1_pci_end[];
> > > > +
> > > > +struct rp1_dev {
> > > > +	struct pci_dev *pdev;
> > > > +	struct device *dev;
> > > > +	struct clk *sys_clk;
> > > > +	struct irq_domain *domain;
> > > > +	struct irq_data *pcie_irqds[64];
> > > > +	void __iomem *bar1;
> > > > +	int ovcs_id;
> > > > +	bool level_triggered_irq[RP1_ACTUAL_IRQS];
> > > > +};
> > > > +
> > > > +
> > > ...
> > > > +
> > > > +static const struct pci_device_id dev_id_table[] = {
> > > > +	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0), },
> > > > +	{ 0, }
> > > > +};
> > > > +
> > > > +static struct pci_driver rp1_driver = {
> > > > +	.name		= RP1_DRIVER_NAME,
> > > > +	.id_table	= dev_id_table,
> > > > +	.probe		= rp1_probe,
> > > > +	.remove		= rp1_remove,
> > > > +};
> > > > +
> > > > +module_pci_driver(rp1_driver);
> > > > +
> > > > +MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
> > > Module author & Copyright doesn't seem to match with this patch author.
> > > Please clarify/fix
> > My intention here is that, even if the code has been heavily modified by me,
> > the core original code is still there so I just wanted to tribute it to the
> > original author.
> > I'll synchronize this with RaspberryPi guys and coem up with a unified solution.
> That would be nice to mention in the commit message and add your copyright.

Ack.

> > Just in case: would multiple MODULE_AUTHOR entries (one with my name and one
> > with original authors name) be accepetd?
> Sure

Many thanks,

Andrea

> 
> Best regards
> > 
> > Many thanks,
> > Andrea
> > 
> > References:
> > 
> > - [1]: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> > - [2]: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
> > - [3]: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
> > - [4]: https://lore.kernel.org/all/ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net/
> > - [5]: https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
> 

