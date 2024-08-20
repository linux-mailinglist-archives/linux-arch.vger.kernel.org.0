Return-Path: <linux-arch+bounces-6392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC6958DF3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 20:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2351C21AE1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C3D1C4609;
	Tue, 20 Aug 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NwcpOedu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F21C3F1A
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178336; cv=none; b=BmCa4X2NCTGGj6yY3spFzV5P5h7XFGhNfix6jbo9gFXhZb59Xwv0iBaoUvBYK8qajuVQMwm1SwElW6QRsk9eYqTJesMevJ9tQEzvUTDWDg9+/YRUBIZSs1uYtiXSYvquAXRO7L9JlXjT5oJ8rv59q6VQw+mjx2G9Sb3InOpqS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178336; c=relaxed/simple;
	bh=RYPhYKet/y4eF3WxxWxL3s24b9wbnEh7rG7jHTrAVlA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMe0k8MBLlWyrsOk6WrCR7r/Zf0pqcEcLIjt+qu93KSZaNvhwah7Oy1svgWq6/fo/YtVCU2XjSXX02nUqbn+0QF6ZM9eC/uKgODEVsa8/VtFu4DuFvQENV3WD4IiC8oV611TpauXaIYhJhX5S3y5O80DUh0HGbYiEpIfcSFpkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NwcpOedu; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a7a975fb47eso664761566b.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724178332; x=1724783132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzB+pVm4vidLwC7IhpAgP8goZjSzlYTi2C47Cf22oE8=;
        b=NwcpOedu/k5U6Zd3tQ1+HX1+pKAM7KED9P9cXd7X5r6FA8S264huwLKogD2zc0Dort
         ZZttgqmgJcetg+ScTsUG9sGcUp4fXknqpF8x8F4kT6u3MV7nwSSSFmcwc9KjFc71yQ0+
         2MvMvxyoj+wCorT+MqstQHh2J5QqJJemaoHN5IUTp1IzwvVj4NIPxQNSNlosFclVeRDj
         ABdXSCVmz+1Ig2MvkovycyPOrg/+vVdQg2Rgt5rl0uD5xccVHjybYcxXRAtAXKYqRo/v
         zgJijZMaddrh8K8o4Y9DM0dPiMNAkci+iE2wVg3JFe0m3HKj25ZPYq+QH0U0lY1eH+FT
         bhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178332; x=1724783132;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzB+pVm4vidLwC7IhpAgP8goZjSzlYTi2C47Cf22oE8=;
        b=qI3o5lfs4q0O8y7GxfZ+e7nLnMb/XJs4rcWhg0+wcQFfNVOxqQ1Cpbj4qd+MJn80AO
         l6ceux5rLIQev00XJwEybuO5zoZJ6t+sf8cPo7wSDx26m6gwfG8UqOZVkVrY258REadW
         1/rwYKICHYFZAbSOHumTYKWi6/NBuQSplpImVPsqjgbWB9e5SNOuoMrrd7KP/ncNXAFT
         J+pZdSdYlVvpb11E6aGTTZoC6nwHAifwBQGil9vIqcCtSPLvnO9P+mGZpJP9KMF67kA9
         Jrw6GCccfa2tgaiC0T3bXHbURpM0E4i4v8rL30+pTES2BNbVi9A5exwaNAy6KrTEIQPq
         LOvg==
X-Forwarded-Encrypted: i=1; AJvYcCVE+k/nFwfsMgMas9f2WwDLed7bgf8qAjtovm7DC9JNSTFyp/0Ar8mCpGuA0oCwLrU48r7HCtSuvGLl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd1xTN2VxYIyXgCTr3xOaVfWvcf4Q/KCme4yTlLn1OKIJxjGD
	uriqm5gZOWt4tcpGCz6x75oAUp0seQ42f0qGAl3g8znNxugUCF0k9ZQ7MYfarhc=
X-Google-Smtp-Source: AGHT+IG1zerY3WZqBBj0fKqRcI0KxUASN52ZzNxukv/UVKdcU3SIfQByHNmYhpZbSqxGa74FoAWAfQ==
X-Received: by 2002:a17:907:f769:b0:a7d:a080:baa with SMTP id a640c23a62f3a-a83929516e5mr1176804066b.34.1724178332067;
        Tue, 20 Aug 2024 11:25:32 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6777sm801629166b.10.2024.08.20.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 11:25:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 20 Aug 2024 20:25:36 +0200
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
Message-ID: <ZsTfoC3aKLdmFPCL@apocalypse>
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
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-baritone-delegate-5711f7a0bc76@spud>

Hi Conor,

On 17:19 Tue 20 Aug     , Conor Dooley wrote:
> On Tue, Aug 20, 2024 at 04:36:03PM +0200, Andrea della Porta wrote:
> > Add device tree bindings for the clock generator found in RP1 multi
> > function device, and relative entries in MAINTAINERS file.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../clock/raspberrypi,rp1-clocks.yaml         | 87 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  include/dt-bindings/clock/rp1.h               | 56 ++++++++++++
> >  3 files changed, 149 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> >  create mode 100644 include/dt-bindings/clock/rp1.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > new file mode 100644
> > index 000000000000..b27db86d0572
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi RP1 clock generator
> > +
> > +maintainers:
> > +  - Andrea della Porta <andrea.porta@suse.com>
> > +
> > +description: |
> > +  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
> > +  VIDEO), and each PLL output can be programmed though dividers to generate
> > +  the clocks to drive the sub-peripherals embedded inside the chipset.
> > +
> > +  Link to datasheet:
> > +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: raspberrypi,rp1-clocks
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    description:
> > +      The index in the assigned-clocks is mapped to the output clock as per
> > +      definitions in dt-bindings/clock/rp1.h.
> > +    const: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rp1.h>
> > +
> > +    rp1 {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        rp1_clocks: clocks@18000 {
> 
> The unit address does not match the reg property. I'm surprised that
> dtc doesn't complain about that.

Agreed. I'll update the address with the reg value in the next release

> 
> > +            compatible = "raspberrypi,rp1-clocks";
> > +            reg = <0xc0 0x40018000 0x0 0x10038>;
> 
> This is a rather oddly specific size. It leads me to wonder if this
> region is inside some sort of syscon area?

From downstream source code and RP1 datasheet it seems that the last addressable
register is at 0xc040028014 while the range exposed through teh devicetree ends
up at 0xc040028038, so it seems more of a little safe margin. I wouldn't say it
is a syscon area since those register are quite specific for video clock
generation and not to be intended to be shared among different peripherals.
Anyway, the next register aperture is at 0xc040030000 so I would say we can 
extend the clock mapped register like the following:

reg = <0xc0 0x40018000 0x0 0x18000>;

if you think it is more readable.

> 
> > +            #clock-cells = <1>;
> > +            clocks = <&clk_xosc>;
> > +
> > +            assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,

> FWIW, I don't think any of these assigned clocks are helpful for the
> example. That said, why do you need to configure all of these assigned
> clocks via devicetree when this node is the provider of them?

Not sure to understand what you mean here, the example is there just to
show how to compile the dt node, maybe you're referring to the fact that
the consumer should setup the clock freq? Consider that the rp1-clocks
is coupled to the peripherals contained in the same RP1 chip so there is
not much point in letting the peripherals set the clock to their leisure.

> 
> > +                              <&rp1_clocks RP1_PLL_AUDIO_CORE>,
> > +                              /* RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI drivers */
> 
> Comments like this also do not seem relevant to the binding.

Agreed, will drop in the next release.

> 
> 
> Cheers,
> Conor.
>

Many thanks,
Andrea
 
> 
> > +                              <&rp1_clocks RP1_PLL_SYS>,
> > +                              <&rp1_clocks RP1_PLL_SYS_SEC>,
> > +                              <&rp1_clocks RP1_PLL_AUDIO>,
> > +                              <&rp1_clocks RP1_PLL_AUDIO_SEC>,
> > +                              <&rp1_clocks RP1_CLK_SYS>,
> > +                              <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
> > +                              /* RP1_CLK_SLOW_SYS is used for the frequency counter (FC0) */
> > +                              <&rp1_clocks RP1_CLK_SLOW_SYS>,
> > +                              <&rp1_clocks RP1_CLK_SDIO_TIMER>,
> > +                              <&rp1_clocks RP1_CLK_SDIO_ALT_SRC>,
> > +                              <&rp1_clocks RP1_CLK_ETH_TSU>;
> > +
> > +            assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
> > +                                   <1536000000>, // RP1_PLL_AUDIO_CORE
> > +                                   <200000000>,  // RP1_PLL_SYS
> > +                                   <125000000>,  // RP1_PLL_SYS_SEC
> > +                                   <61440000>,   // RP1_PLL_AUDIO
> > +                                   <192000000>,  // RP1_PLL_AUDIO_SEC
> > +                                   <200000000>,  // RP1_CLK_SYS
> > +                                   <100000000>,  // RP1_PLL_SYS_PRI_PH
> > +                                   /* Must match the XOSC frequency */
> > +                                   <50000000>, // RP1_CLK_SLOW_SYS
> > +                                   <1000000>, // RP1_CLK_SDIO_TIMER
> > +                                   <200000000>, // RP1_CLK_SDIO_ALT_SRC
> > +                                   <50000000>; // RP1_CLK_ETH_TSU
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42decde38320..6e7db9bce278 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19116,6 +19116,12 @@ F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
> >  F:	drivers/media/platform/raspberrypi/pisp_be/
> >  F:	include/uapi/linux/media/raspberrypi/
> >  
> > +RASPBERRY PI RP1 PCI DRIVER
> > +M:	Andrea della Porta <andrea.porta@suse.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	include/dt-bindings/clock/rp1.h
> > +
> >  RC-CORE / LIRC FRAMEWORK
> >  M:	Sean Young <sean@mess.org>
> >  L:	linux-media@vger.kernel.org
> > diff --git a/include/dt-bindings/clock/rp1.h b/include/dt-bindings/clock/rp1.h
> > new file mode 100644
> > index 000000000000..1ed67b8a5229
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/rp1.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > +/*
> > + * Copyright (C) 2021 Raspberry Pi Ltd.
> > + */
> > +
> > +#define RP1_PLL_SYS_CORE		0
> > +#define RP1_PLL_AUDIO_CORE		1
> > +#define RP1_PLL_VIDEO_CORE		2
> > +
> > +#define RP1_PLL_SYS			3
> > +#define RP1_PLL_AUDIO			4
> > +#define RP1_PLL_VIDEO			5
> > +
> > +#define RP1_PLL_SYS_PRI_PH		6
> > +#define RP1_PLL_SYS_SEC_PH		7
> > +#define RP1_PLL_AUDIO_PRI_PH		8
> > +
> > +#define RP1_PLL_SYS_SEC			9
> > +#define RP1_PLL_AUDIO_SEC		10
> > +#define RP1_PLL_VIDEO_SEC		11
> > +
> > +#define RP1_CLK_SYS			12
> > +#define RP1_CLK_SLOW_SYS		13
> > +#define RP1_CLK_DMA			14
> > +#define RP1_CLK_UART			15
> > +#define RP1_CLK_ETH			16
> > +#define RP1_CLK_PWM0			17
> > +#define RP1_CLK_PWM1			18
> > +#define RP1_CLK_AUDIO_IN		19
> > +#define RP1_CLK_AUDIO_OUT		20
> > +#define RP1_CLK_I2S			21
> > +#define RP1_CLK_MIPI0_CFG		22
> > +#define RP1_CLK_MIPI1_CFG		23
> > +#define RP1_CLK_PCIE_AUX		24
> > +#define RP1_CLK_USBH0_MICROFRAME	25
> > +#define RP1_CLK_USBH1_MICROFRAME	26
> > +#define RP1_CLK_USBH0_SUSPEND		27
> > +#define RP1_CLK_USBH1_SUSPEND		28
> > +#define RP1_CLK_ETH_TSU			29
> > +#define RP1_CLK_ADC			30
> > +#define RP1_CLK_SDIO_TIMER		31
> > +#define RP1_CLK_SDIO_ALT_SRC		32
> > +#define RP1_CLK_GP0			33
> > +#define RP1_CLK_GP1			34
> > +#define RP1_CLK_GP2			35
> > +#define RP1_CLK_GP3			36
> > +#define RP1_CLK_GP4			37
> > +#define RP1_CLK_GP5			38
> > +#define RP1_CLK_VEC			39
> > +#define RP1_CLK_DPI			40
> > +#define RP1_CLK_MIPI0_DPI		41
> > +#define RP1_CLK_MIPI1_DPI		42
> > +
> > +/* Extra PLL output channels - RP1B0 only */
> > +#define RP1_PLL_VIDEO_PRI_PH		43
> > +#define RP1_PLL_AUDIO_TERN		44
> > -- 
> > 2.35.3
> > 



