Return-Path: <linux-arch+bounces-6849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B54C966360
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80703B233B9
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00919048D;
	Fri, 30 Aug 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDuS2BzV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DA18CBF8
	for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025745; cv=none; b=Y/T7F6gpAs+VHT/7J2+F4DRgdz6asDgC9fSUxr6PFioOZy2WaovW6G228fqgfiz85mGIY0HhzEE958ovceGyGxSVXqWEQ9s2zE3kwdXPUlzLVP5b5/Ag1jhkTygEXfSTRJOatDWeEM7XqoNeaXlbI6DzkTktgyhB8w1C1IQP1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025745; c=relaxed/simple;
	bh=9UIDn+zRPs2233Ey/wAks0cZbBTGHswiziDn3qxUXnM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phoG+yNjyGFPmn8hf8YyUlyfOW4Ozj6UOZNFkdC8/x214/SQgHogzZsbyQUOlpd0zbXN8EKVYx2F8laTAgXCjtv7YZEaka9UZHIyMehzi+46YuB8YZV+Q5JlgAKozkpEUkUUCvXi2DsRrUAZlRYZ+agORq5Mmqn/YEj5Ogzau/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDuS2BzV; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-534366c194fso1763535e87.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725025740; x=1725630540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3jLKDfv9G/F1hAhLjOmCz8z3HV7wHNtLsdpyhwWqPo=;
        b=PDuS2BzVfxchFZMyByYEGwyuKZRjmhIXr67oiuwxqdKame7MEY5qOATnH7IHb4aj5L
         wZqp7f/HQM0dLneKyaI59P7vc1CQkk3LrS1VkLcP1wKl2+rUYGy25E9rk//nFbjECcLU
         nBuq+WDwXFhX9xuE2pc4Mss7xDR0rkj19UTOrdDIRxugvhvpT1caR5U3IX+03n9DiSmU
         NNqX24qYfExAirqGvjVbRf7wGzi3kY5d0SLDm8v23nCoygrzGQKdPpZQJwib2qAKWTAr
         TiphpUpBag8TxY7oqY6eWNA6WCToqXe93d3MEYu6T3zzLr/fjx0oK/ATibKJHJ6Osx+P
         YrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025740; x=1725630540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3jLKDfv9G/F1hAhLjOmCz8z3HV7wHNtLsdpyhwWqPo=;
        b=ayotcNZKW89CZIOjWxdXhF+SecX5HjVhXHFlbsu1pVcq6qQ+57moIF0wl3O7W24tpN
         CO14stBdL45ur7QFzAOZNVxkAigCcdLZAcPqv0G4+WqbGEanArbgnfHE1lxC0VL+ftUm
         1ujU686kcxEc1FzKdoCqZgQaBoQNef3BqNXHFi2dcmyswYIps011hMh/5FHZpSfwxH0S
         pz+wfJZNVh8R7nk9caHtDW2yJDlenAHJZ5YSDx0KzfIfTnXJKrZ2bEQo63zIw4NWIa5C
         dE4kh+5oT275lOjSrBZ7Lt+8BhA5XRetTxNramlYp/Csts1c3MJQAVeCP2OVi0Jlrj/+
         DZzg==
X-Forwarded-Encrypted: i=1; AJvYcCVMOviKPrdeesZ2goxb0+A+AUnBsWnrYUIwVxEUS8tXitqwMKhrtjouJcqdUOwxZhADs3gJXB7Cpgau@vger.kernel.org
X-Gm-Message-State: AOJu0YxINDglHsh43TLiPNT71msg41ztu49hDShEbWPxqDLZ6bLVrOB0
	QH9rD4Qg9uB3vCPBI9n0/qX/elWrLHAVsMM25AKuRzfWneT3Up0SYy/9n7cg258=
X-Google-Smtp-Source: AGHT+IGg9M4Rtabw2zg4qqU8iskz42/lxuttsuGGIjXpiaV4rVUp+9fovEZeeF3bRXArRqzbS0RuVw==
X-Received: by 2002:a05:6512:3b8c:b0:52f:159:2dc5 with SMTP id 2adb3069b0e04-53546ba9fd4mr1622050e87.42.1725025739816;
        Fri, 30 Aug 2024 06:48:59 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb072sm217505266b.28.2024.08.30.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:48:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 30 Aug 2024 15:49:04 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <ZtHN0B8VEGZFXs95@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>

Hi Krzysztof,

On 10:38 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> > The RaspberryPi RP1 is ia PCI multi function device containing
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.
> > Implement a bare minimum driver to operate the RP1, leveraging
> > actual OF based driver implementations for the on-borad peripherals
> > by loading a devicetree overlay during driver probe.
> > The peripherals are accessed by mapping MMIO registers starting
> > from PCI BAR1 region.
> > As a minimum driver, the peripherals will not be added to the
> > dtbo here, but in following patches.
> > 
> > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  MAINTAINERS                           |   2 +
> >  arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
> 
> Do not mix DTS with drivers.
> 
> These MUST be separate.

Separating the dtso from the driver in two different patches would mean
that the dtso patch would be ordered before the driver one. This is because
the driver embeds the dtbo binary blob inside itself, at build time. So
in order to build the driver, the dtso needs to be there also. This is not
the standard approach used with 'normal' dtb/dtbo, where the dtb patch is
ordered last wrt the driver it refers to.
Are you sure you want to proceed in this way?

> 
> >  drivers/misc/Kconfig                  |   1 +
> >  drivers/misc/Makefile                 |   1 +
> >  drivers/misc/rp1/Kconfig              |  20 ++
> >  drivers/misc/rp1/Makefile             |   3 +
> >  drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
> >  drivers/misc/rp1/rp1-pci.dtso         |   8 +
> >  drivers/pci/quirks.c                  |   1 +
> >  include/linux/pci_ids.h               |   3 +
> >  10 files changed, 524 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
> >  create mode 100644 drivers/misc/rp1/Kconfig
> >  create mode 100644 drivers/misc/rp1/Makefile
> >  create mode 100644 drivers/misc/rp1/rp1-pci.c
> >  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 67f460c36ea1..1359538b76e8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
> >  RASPBERRY PI RP1 PCI DRIVER
> >  M:	Andrea della Porta <andrea.porta@suse.com>
> >  S:	Maintained
> > +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	drivers/clk/clk-rp1.c
> > +F:	drivers/misc/rp1/
> >  F:	drivers/pinctrl/pinctrl-rp1.c
> >  F:	include/dt-bindings/clock/rp1.h
> >  F:	include/dt-bindings/misc/rp1.h
> > diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > new file mode 100644
> > index 000000000000..d80178a278ee
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > @@ -0,0 +1,152 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/clock/rp1.h>
> > +#include <dt-bindings/misc/rp1.h>
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target-path="";
> > +		__overlay__ {
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +
> > +			rp1: rp1@0 {
> > +				compatible = "simple-bus";
> > +				#address-cells = <2>;
> > +				#size-cells = <2>;
> > +				interrupt-controller;
> > +				interrupt-parent = <&rp1>;
> > +				#interrupt-cells = <2>;
> > +
> > +				// ranges and dma-ranges must be provided by the includer
> > +				ranges = <0xc0 0x40000000
> > +					  0x01/*0x02000000*/ 0x00 0x00000000
> > +					  0x00 0x00400000>;
> 
> Are you 100% sure you do not have here dtc W=1 warnings?

the W=1 warnings are:

arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property

I don't see anything related to the ranges line you mentioned.

> 
> > +
> > +				dma-ranges =
> > +				// inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
> > +					     <0x10 0x00000000
> > +					      0x43000000 0x10 0x00000000
> > +					      0x10 0x00000000>;
> > +
> > +				clk_xosc: clk_xosc {
> 
> Nope, switch to DTS coding style.

Ack.

> 
> > +					compatible = "fixed-clock";
> > +					#clock-cells = <0>;
> > +					clock-output-names = "xosc";
> > +					clock-frequency = <50000000>;
> > +				};
> > +
> > +				macb_pclk: macb_pclk {
> > +					compatible = "fixed-clock";
> > +					#clock-cells = <0>;
> > +					clock-output-names = "pclk";
> > +					clock-frequency = <200000000>;
> > +				};
> > +
> > +				macb_hclk: macb_hclk {
> > +					compatible = "fixed-clock";
> > +					#clock-cells = <0>;
> > +					clock-output-names = "hclk";
> > +					clock-frequency = <200000000>;
> > +				};
> > +
> > +				rp1_clocks: clocks@c040018000 {
> 
> Why do you mix MMIO with non-MMIO nodes? This really does not look
> correct.
>

Right. This is already under discussion here:
https://lore.kernel.org/all/ZtBzis5CzQMm8loh@apocalypse/

IIUC you proposed to instantiate the non-MMIO nodes (the three clocks) by
using CLK_OF_DECLARE.
 
> > +					compatible = "raspberrypi,rp1-clocks";
> > +					#clock-cells = <1>;
> > +					reg = <0xc0 0x40018000 0x0 0x10038>;
> 
> Wrong order of properties - see DTS coding style.

Ack.

Many thanks,
Andrea

> 
> > +					clocks = <&clk_xosc>;
> > +					clock-names = "xosc";
> 
> Best regards,
> Krzysztof
> 

