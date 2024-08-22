Return-Path: <linux-arch+bounces-6510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88B95B1C4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405EE1F22EFE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47709179970;
	Thu, 22 Aug 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DW+82SUT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B616F0CA
	for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319350; cv=none; b=QxMv9SzJyY1QonQ7Mdszh7gq6bJfy3FXzMJxHzjV3QG45niC3Rc05bEoaGPdNUWZZhU5PQ6G7gMgVbdKlngSSEIZ4EhWllpYD8wJCicL2UxB5mo2FZnangZAItCnTqDXEgd2Vi9Xzm0Vcza+S+yniLvcivZZmhFHo75mcbp4xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319350; c=relaxed/simple;
	bh=Yt0SGBdvkoQALbkyTLGjUsIfe+e/jGTFEfTctg8D1mQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOnZiYmbV7LoLNiXgyj1vWB9RBn4/8UmCdqXVbNSyQLB07y/lfhI60/Xt5kUj++mtMiecedtCmsZWupUxdlRYrkv554yJi5K2UHoy3innzjXVvbCwCgJf/x+G8MuGitdm2c4xQ26GcJIYPUx3QOWuYNJfuZnAt1ETxyz5qMGcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DW+82SUT; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a7aa086b077so70920466b.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724319346; x=1724924146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5as64V3nQXJvuAvKv0T+XO2CQeSqsYWKkMYHqmyR0EU=;
        b=DW+82SUTh0cCpgBUqBkw1ax3sFYCut/Pfm/3UCEO675HxYn022XQSMC88UhZ9UTbYN
         WP2SfYdp0ayLVFIR85I6U5KIK0rKf6SpyyOoAgPtlIE/ylWaO8akVD/3yk3M321Wj3TH
         Ydkz0qohGwVkEu5tGevvxSko4ABoZ0tVdbSGxvD15bCzsPU4yauHf7xvNOxwXprS782c
         zGkaAERzJIF/pTNQzAIRTEQWMU+CsfxXGwe4lye2nLPzwjKUKUmRcNUh9UExSC/uswQ6
         arRg82mbrhTsAWK9MShnd9zCQE/G5iXBIhkd39/eCytrjbqapDA8h1rqZ8GihVnW8eft
         l8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319346; x=1724924146;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5as64V3nQXJvuAvKv0T+XO2CQeSqsYWKkMYHqmyR0EU=;
        b=YhnFVdgWglafZhxgsHvKqKmGmVRWNz1BVf4OmRtttD19fflzf2knP4OdP4cIOD+P+h
         p8SRHvYbCcxHjL05HO0jYYOeV8L+/BDa0Ml8V0M+b3CAWZhHYLmGojYMFOgburz4jVoV
         JNhgNBiI2yG+03plxYT/+KiZpU9VjBobUxfFyMm0sCxNpQJUwVo4WO+coWh/Dm5N1fsC
         00mQ6xYhLHmwDMyBlzl13hm/E43o/o7BovCo9gLP45ZC1I1uaycksBadL2LovFBqoihQ
         HLdAlV99uaZTknsU2dB+msmX3be+/wHbRStcYgNAdIHyIpPcvwSUlDGajt0B4d44to1P
         wIaA==
X-Forwarded-Encrypted: i=1; AJvYcCUoRPAO4M8hAcaicJyl1H3hZSJK8jdKYZ3Civl5n543qC66V28Sz11qwHiLioE6EwLLW7CrMQ2R1HjC@vger.kernel.org
X-Gm-Message-State: AOJu0YyN938ZtdAO3vMI0/qtph7cU4nwsAftOCg6mWzWpu/tWY4fONBJ
	m3Joug8y2NVm9W2AbX51phzltDvAYD9NQeMsf/e4x4JxPUnoyn90OwPgUAn72h4=
X-Google-Smtp-Source: AGHT+IFOY/EtR8WQw5iC60MgtfJT6RPxhSE4K08Yn6ESgwiAUbm+IoOrlNo+vVu7HeKvVsEjzl1GNA==
X-Received: by 2002:a17:906:d26a:b0:a77:e48d:bae with SMTP id a640c23a62f3a-a866f3615cbmr397450866b.28.1724319345495;
        Thu, 22 Aug 2024 02:35:45 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a5903sm91837266b.78.2024.08.22.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:35:45 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 22 Aug 2024 11:35:51 +0200
To: Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH 01/11] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <ZscGdxgoNJrifSgk@apocalypse>
Mail-Followup-To: Conor Dooley <conor@kernel.org>,
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
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <8d7dd7ca5da41f2a96e3ef4e2e3f29fd0d71906a.1724159867.git.andrea.porta@suse.com>
 <20240820-baritone-delegate-5711f7a0bc76@spud>
 <ZsTfoC3aKLdmFPCL@apocalypse>
 <20240821-exception-nearby-5adeaaf0178b@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821-exception-nearby-5adeaaf0178b@spud>

Hi Conor,

On 12:46 Wed 21 Aug     , Conor Dooley wrote:
> On Tue, Aug 20, 2024 at 08:25:36PM +0200, Andrea della Porta wrote:
> > Hi Conor,
> > 
> > On 17:19 Tue 20 Aug     , Conor Dooley wrote:
> > > On Tue, Aug 20, 2024 at 04:36:03PM +0200, Andrea della Porta wrote:
> > > > Add device tree bindings for the clock generator found in RP1 multi
> > > > function device, and relative entries in MAINTAINERS file.
> > > > 
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > ---
> > > >  .../clock/raspberrypi,rp1-clocks.yaml         | 87 +++++++++++++++++++
> > > >  MAINTAINERS                                   |  6 ++
> > > >  include/dt-bindings/clock/rp1.h               | 56 ++++++++++++
> > > >  3 files changed, 149 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > >  create mode 100644 include/dt-bindings/clock/rp1.h
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > > new file mode 100644
> > > > index 000000000000..b27db86d0572
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > > @@ -0,0 +1,87 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RaspberryPi RP1 clock generator
> > > > +
> > > > +maintainers:
> > > > +  - Andrea della Porta <andrea.porta@suse.com>
> > > > +
> > > > +description: |
> > > > +  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
> > > > +  VIDEO), and each PLL output can be programmed though dividers to generate
> > > > +  the clocks to drive the sub-peripherals embedded inside the chipset.
> > > > +
> > > > +  Link to datasheet:
> > > > +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: raspberrypi,rp1-clocks
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  '#clock-cells':
> > > > +    description:
> > > > +      The index in the assigned-clocks is mapped to the output clock as per
> > > > +      definitions in dt-bindings/clock/rp1.h.
> > > > +    const: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - '#clock-cells'
> > > > +  - clocks
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/rp1.h>
> > > > +
> > > > +    rp1 {
> > > > +        #address-cells = <2>;
> > > > +        #size-cells = <2>;
> > > > +
> > > > +        rp1_clocks: clocks@18000 {
> > > 
> > > The unit address does not match the reg property. I'm surprised that
> > > dtc doesn't complain about that.
> > 
> > Agreed. I'll update the address with the reg value in the next release
> > 
> > > 
> > > > +            compatible = "raspberrypi,rp1-clocks";
> > > > +            reg = <0xc0 0x40018000 0x0 0x10038>;
> > > 
> > > This is a rather oddly specific size. It leads me to wonder if this
> > > region is inside some sort of syscon area?
> > 
> > >From downstream source code and RP1 datasheet it seems that the last addressable
> > register is at 0xc040028014 while the range exposed through teh devicetree ends
> > up at 0xc040028038, so it seems more of a little safe margin. I wouldn't say it
> > is a syscon area since those register are quite specific for video clock
> > generation and not to be intended to be shared among different peripherals.
> > Anyway, the next register aperture is at 0xc040030000 so I would say we can 
> > extend the clock mapped register like the following:
> > 
> > reg = <0xc0 0x40018000 0x0 0x18000>;
> > 
> > if you think it is more readable.
> 
> I don't care

Ack.

> > > > +            #clock-cells = <1>;
> > > > +            clocks = <&clk_xosc>;
> > > > +
> > > > +            assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
> > 
> > > FWIW, I don't think any of these assigned clocks are helpful for the
> > > example. That said, why do you need to configure all of these assigned
> > > clocks via devicetree when this node is the provider of them?
> > 
> > Not sure to understand what you mean here, the example is there just to
> > show how to compile the dt node, maybe you're referring to the fact that
> > the consumer should setup the clock freq?
> 
> I suppose, yeah. I don't think a particular configuration is relevant
> for the example binding, but simultaneously don't get why you are
> assigning the rate for clocks used by audio devices or ethernet in the
> clock provider node.
>

Honestly I don't have a strong preference here, I can manage to do some tests
moving the clock rate settings inside the consumer nodes but I kinda like
the curernt idea of a centralized node where clocks are setup beforehand.
In RP1 the clock generator and peripherals such as ethernet are all on-board
and cannot be rewired in any other way so the devices are not standalone
consumer in their own right (such it would be an ethernet chip wired to an
external CPU). But of course this is debatable, on the other hand the current
approach of provider/consumer is of course very clean. I'm just wondering
wthether you think I should take action on this or we can leave it as it is.
Please see also below.

> > Consider that the rp1-clocks
> > is coupled to the peripherals contained in the same RP1 chip so there is
> > not much point in letting the peripherals set the clock to their leisure.
> 
> How is that any different to the many other SoCs in the kernel?

In fact, it isn't. Please take a look at:
 
arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
arch/arm/boot/dts/ti/omap/omap44xx-clocks.dtsi
arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
arch/arm/boot/dts/nxp/imx/imx7d-zii-rpu2.dts

and probably many others... they use the same approach, so I assumed it is at
least reasonable to assign the clock rate this way.


Many thanks,
Andrea

> 
> > > > +                              <&rp1_clocks RP1_PLL_AUDIO_CORE>,
> > > > +                              /* RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI drivers */
> > > 
> > > Comments like this also do not seem relevant to the binding.
> > 
> > Agreed, will drop in the next release.
> > 
> > > 
> > > 
> > > Cheers,
> > > Conor.
> > >
> > 
> > Many thanks,
> > Andrea
> >  
> > > 
> > > > +                              <&rp1_clocks RP1_PLL_SYS>,
> > > > +                              <&rp1_clocks RP1_PLL_SYS_SEC>,
> > > > +                              <&rp1_clocks RP1_PLL_AUDIO>,
> > > > +                              <&rp1_clocks RP1_PLL_AUDIO_SEC>,
> > > > +                              <&rp1_clocks RP1_CLK_SYS>,
> > > > +                              <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
> > > > +                              /* RP1_CLK_SLOW_SYS is used for the frequency counter (FC0) */
> > > > +                              <&rp1_clocks RP1_CLK_SLOW_SYS>,
> > > > +                              <&rp1_clocks RP1_CLK_SDIO_TIMER>,
> > > > +                              <&rp1_clocks RP1_CLK_SDIO_ALT_SRC>,
> > > > +                              <&rp1_clocks RP1_CLK_ETH_TSU>;
> > > > +
> > > > +            assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
> > > > +                                   <1536000000>, // RP1_PLL_AUDIO_CORE
> > > > +                                   <200000000>,  // RP1_PLL_SYS
> > > > +                                   <125000000>,  // RP1_PLL_SYS_SEC
> > > > +                                   <61440000>,   // RP1_PLL_AUDIO
> > > > +                                   <192000000>,  // RP1_PLL_AUDIO_SEC
> > > > +                                   <200000000>,  // RP1_CLK_SYS
> > > > +                                   <100000000>,  // RP1_PLL_SYS_PRI_PH
> > > > +                                   /* Must match the XOSC frequency */
> > > > +                                   <50000000>, // RP1_CLK_SLOW_SYS
> > > > +                                   <1000000>, // RP1_CLK_SDIO_TIMER
> > > > +                                   <200000000>, // RP1_CLK_SDIO_ALT_SRC
> > > > +                                   <50000000>; // RP1_CLK_ETH_TSU
> > > > +        };
> > > > +    };
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 42decde38320..6e7db9bce278 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -19116,6 +19116,12 @@ F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
> > > >  F:	drivers/media/platform/raspberrypi/pisp_be/
> > > >  F:	include/uapi/linux/media/raspberrypi/
> > > >  
> > > > +RASPBERRY PI RP1 PCI DRIVER
> > > > +M:	Andrea della Porta <andrea.porta@suse.com>
> > > > +S:	Maintained
> > > > +F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > > +F:	include/dt-bindings/clock/rp1.h
> > > > +
> > > >  RC-CORE / LIRC FRAMEWORK
> > > >  M:	Sean Young <sean@mess.org>
> > > >  L:	linux-media@vger.kernel.org
> > > > diff --git a/include/dt-bindings/clock/rp1.h b/include/dt-bindings/clock/rp1.h
> > > > new file mode 100644
> > > > index 000000000000..1ed67b8a5229
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/clock/rp1.h
> > > > @@ -0,0 +1,56 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > > > +/*
> > > > + * Copyright (C) 2021 Raspberry Pi Ltd.
> > > > + */
> > > > +
> > > > +#define RP1_PLL_SYS_CORE		0
> > > > +#define RP1_PLL_AUDIO_CORE		1
> > > > +#define RP1_PLL_VIDEO_CORE		2
> > > > +
> > > > +#define RP1_PLL_SYS			3
> > > > +#define RP1_PLL_AUDIO			4
> > > > +#define RP1_PLL_VIDEO			5
> > > > +
> > > > +#define RP1_PLL_SYS_PRI_PH		6
> > > > +#define RP1_PLL_SYS_SEC_PH		7
> > > > +#define RP1_PLL_AUDIO_PRI_PH		8
> > > > +
> > > > +#define RP1_PLL_SYS_SEC			9
> > > > +#define RP1_PLL_AUDIO_SEC		10
> > > > +#define RP1_PLL_VIDEO_SEC		11
> > > > +
> > > > +#define RP1_CLK_SYS			12
> > > > +#define RP1_CLK_SLOW_SYS		13
> > > > +#define RP1_CLK_DMA			14
> > > > +#define RP1_CLK_UART			15
> > > > +#define RP1_CLK_ETH			16
> > > > +#define RP1_CLK_PWM0			17
> > > > +#define RP1_CLK_PWM1			18
> > > > +#define RP1_CLK_AUDIO_IN		19
> > > > +#define RP1_CLK_AUDIO_OUT		20
> > > > +#define RP1_CLK_I2S			21
> > > > +#define RP1_CLK_MIPI0_CFG		22
> > > > +#define RP1_CLK_MIPI1_CFG		23
> > > > +#define RP1_CLK_PCIE_AUX		24
> > > > +#define RP1_CLK_USBH0_MICROFRAME	25
> > > > +#define RP1_CLK_USBH1_MICROFRAME	26
> > > > +#define RP1_CLK_USBH0_SUSPEND		27
> > > > +#define RP1_CLK_USBH1_SUSPEND		28
> > > > +#define RP1_CLK_ETH_TSU			29
> > > > +#define RP1_CLK_ADC			30
> > > > +#define RP1_CLK_SDIO_TIMER		31
> > > > +#define RP1_CLK_SDIO_ALT_SRC		32
> > > > +#define RP1_CLK_GP0			33
> > > > +#define RP1_CLK_GP1			34
> > > > +#define RP1_CLK_GP2			35
> > > > +#define RP1_CLK_GP3			36
> > > > +#define RP1_CLK_GP4			37
> > > > +#define RP1_CLK_GP5			38
> > > > +#define RP1_CLK_VEC			39
> > > > +#define RP1_CLK_DPI			40
> > > > +#define RP1_CLK_MIPI0_DPI		41
> > > > +#define RP1_CLK_MIPI1_DPI		42
> > > > +
> > > > +/* Extra PLL output channels - RP1B0 only */
> > > > +#define RP1_PLL_VIDEO_PRI_PH		43
> > > > +#define RP1_PLL_AUDIO_TERN		44
> > > > -- 
> > > > 2.35.3
> > > > 
> > 
> > 



