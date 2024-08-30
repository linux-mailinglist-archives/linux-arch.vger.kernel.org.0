Return-Path: <linux-arch+bounces-6843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5B965EFB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E7F28DB4A
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0617DE36;
	Fri, 30 Aug 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DWv8eRj+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96217BEC8
	for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013326; cv=none; b=L8gP6JPvYWUe/19quTx6vB6DHaeKMwvn10Q+yPFC3T/gFySI5SUr7KOaxNpdmAaHRSQKxtwzfpSDthx8mURYH/pZJgdUgozX60Ua8a2MhRLfpACUAm0c688Re+S1oT6kV5XP6nbvsgmDCiHqX0tfQrPbrAYcgfoGoglCpOddFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013326; c=relaxed/simple;
	bh=Knm3BjZduDuXk0+b8GRzUTkw+Wzl6VmhKzC2pO+Na2w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qziaJ741o+QxRDuYQLZ9hAYnrzVLvjC7/+O+knM9jG8IRmT5KTiphLSBFT6vFzOmqQOwHUSRU2eMwzTQd0xlrpTf/yyf9+0E44/FEB8eLMUelf0PtZxBAQKHmDzLIaQa9nVsI9WZYrvatnUmn3Ht7XAgx6QtpbtoBc+IQZqm+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DWv8eRj+; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so181809666b.2
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725013321; x=1725618121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbhHoJjuM1ivpiPlmTgbjVGdK8GjjUmv5pMqCU8D6Fc=;
        b=DWv8eRj+AxoZJi5aPr2u3pe0jmZN7BxCxGonnkLho70yuqz5jl9ekSHE1tRx/jB2qs
         Sa3SNra1UDpekWlca82WUfkW0uWdkyycI9njeQl8+iP7MgtZSnqAyTssMWDsLBvQ40B5
         9ADD00GxrDXdtb95aMdia5by2GB0k8AXX8rQVvv3sNgKgqteV/Q0NCZIsHo6awri1Lrz
         Yt3DHsO0S8yQVM/JCKZ02zev4sjeZv+7ZZkq7eqzZdlXC2U+k61VXnXwiREfssG85X09
         KYrjQ5YSQ2H47HRGcxEP78OIpFCa3xwUmcdiYHMyncEQdUTzNyAFjiiRaiBNe3IS3RnK
         wH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013321; x=1725618121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbhHoJjuM1ivpiPlmTgbjVGdK8GjjUmv5pMqCU8D6Fc=;
        b=HqUTvXaQ6a4RsUpV7uo4lYBPrNLgiFelaeOIN81pJ/B52GPW8zS6nLxec0WovXXV+Z
         Wfi/XUl1pt0risCt26t5WXLT+PWfiJAy/wcPPgwFgzc6ycxBtNvZlWbDumtwB8tMtRlp
         Rs0g/+E5gCpzOtngPxTNBp2t+7Oi2e8n1DOVsJoCp6/LeX8jfOBQg7VexGsTvS4bq5M4
         ddYD6VTUJ/nRLYtyjT7WSw4pTqStHT7or5JHsiYtTd1t6Be2vfAYc6V0MzRZ6dUUBsIj
         ry9rLZpyakI+1o14zEA4bGwvthV9hRzv4PzpCIz6rmBlHxw3unZt9HAuiRsYUyKtD/EA
         UnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXJK8YGDF+yUbEhddIGYqj9X78jNRs6TVmvmFM8WOmoP48P/NCvz3FyKt0DK8lVPab82lr+ZdU7rrAF@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWexy779QpwtguY/sjHEP0bwtTuVMxiWKPgYqsxqWK2gePfrp
	fwnLhpdxS5cftwKOF9AmZ0XUx2/fnLYfrLjzRLKZmYT04MHZAA7/GkrvfbMOAR4=
X-Google-Smtp-Source: AGHT+IG6h20DnLXz5pVmLY+VL5ElH7DvF3660DEdHG1R9705g8TgluohDRSc1GHgGAsNQAfRzZM/2A==
X-Received: by 2002:a17:907:3f9b:b0:a86:b080:9bd4 with SMTP id a640c23a62f3a-a897fa74e2cmr469691666b.48.1725013320323;
        Fri, 30 Aug 2024 03:22:00 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900e746sm199701866b.52.2024.08.30.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:21:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 30 Aug 2024 12:22:06 +0200
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
Subject: Re: [PATCH 02/11] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <ZtGdTjZPYtm3EGM0@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <82d57814075ed1bc76bf17bde124c5c83925ac59.1724159867.git.andrea.porta@suse.com>
 <5zlaxts46utk66k2n2uxeqr6umppfasnqoxhwdzah44hcmyfnp@euwjda6zk5rh>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5zlaxts46utk66k2n2uxeqr6umppfasnqoxhwdzah44hcmyfnp@euwjda6zk5rh>

Hi Krzysztof,

On 10:42 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:04PM +0200, Andrea della Porta wrote:
> > Add device tree bindings for the gpio/pin/mux controller that is part of
> > the RP1 multi function device, and relative entries in MAINTAINERS file.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 177 +++++++++++++
> >  MAINTAINERS                                   |   2 +
> >  include/dt-bindings/misc/rp1.h                | 235 ++++++++++++++++++
> >  3 files changed, 414 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  create mode 100644 include/dt-bindings/misc/rp1.h
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > new file mode 100644
> > index 000000000000..7011fa258363
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> > @@ -0,0 +1,177 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> > +
> > +maintainers:
> > +  - Andrea della Porta <andrea.porta@suse.com>
> > +
> > +description:
> > +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> > +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> > +  as an interrupt controller for those gpios.
> > +
> > +  Each pin configuration node lists the pin(s) to which it applies, and one or
> > +  more of the mux function to select on those pin(s), and their configuration.
> > +  The pin configuration and multiplexing supports the generic bindings.
> > +  For details on each properties (including the meaning of "pin configuration node"),
> > +  you can refer to ./pinctrl-bindings.txt.
> > +
> > +properties:
> > +  compatible:
> > +    const: raspberrypi,rp1-gpio
> > +
> > +  reg:
> > +    minItems: 3
> 
> You can drop minItems.

Ack.

> 
> > +    maxItems: 3
> > +    description: One reg specifier for each one of the 3 pin banks.
> > +
> > +  '#gpio-cells':
> > +    description: The first cell is the pin number and the second cell is used
> > +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> > +  gpio-ranges:
> > +    maxItems: 1
> > +
> > +  gpio-line-names:
> > +    maxItems: 54
> > +
> > +  interrupts:
> > +    minItems: 3
> 
> Ditto

Ack.

> 
> > +    maxItems: 3
> > +    description: One interrupt specifier for each one of the 3 pin banks.
> > +
> > +  '#interrupt-cells':
> > +    description:
> > +      Specifies the Bank number (as specified in include/dt-bindings/misc/rp1.h)
> > +      and Flags (as defined in (include/dt-bindings/interrupt-controller/irq.h).
> > +      Possible values for the Bank number are
> > +          RP1_INT_IO_BANK0
> > +          RP1_INT_IO_BANK1
> > +          RP1_INT_IO_BANK2
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +additionalProperties:
> > +  anyOf:
> > +    - type: object
> > +      additionalProperties: false
> > +      allOf:
> > +        - $ref: pincfg-node.yaml#
> > +        - $ref: pinmux-node.yaml#
> > +
> > +      description:
> > +        Pin controller client devices use pin configuration subnodes (children
> > +        and grandchildren) for desired pin configuration.
> > +        Client device subnodes use below standard properties.
> > +
> > +      properties:
> > +        pins:
> > +          description:
> > +            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
> > +        function: true
> > +        bias-disable: true
> > +        bias-pull-down: true
> > +        bias-pull-up: true
> > +        slew-rate:
> > +          description: 0 is slow slew rate, 1 is fast slew rate
> > +          enum: [ 0, 1 ]
> > +        drive-strength:
> > +          description: 0 -> 2mA, 1 -> 4mA, 2 -> 8mA, 3 -> 12mA
> > +          enum: [ 0, 1, 2, 3 ]
> 
> No, that's [ 2, 4, 8 and 12 ]
> 
> Read description of the field - it is in specific units.

Ack. Thanks, this would have been a bug, since the driver was already using
the current value instead of the positional.

> 
> > +
> > +    - type: object
> > +      additionalProperties:
> > +        $ref: "#/additionalProperties/anyOf/0"
> > +
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
> > +required:
> > +  - reg
> > +  - compatible
> > +  - "#gpio-cells"
> > +  - gpio-controller
> > +  - interrupts
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/misc/rp1.h>
> > +
> > +    rp1 {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        rp1_gpio: pinctrl@c0400d0000 {
> > +            reg = <0xc0 0x400d0000  0x0 0xc000>,
> > +                  <0xc0 0x400e0000  0x0 0xc000>,
> > +                  <0xc0 0x400f0000  0x0 0xc000>;
> > +            compatible = "raspberrypi,rp1-gpio";
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
> > +            gpio-line-names =
> > +                   "ID_SDA", // GPIO0
> > +                   "ID_SCL", // GPIO1
> > +                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
> > +                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
> > +                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
> > +                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
> > +                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
> > +                   "GPIO27",
> > +                   "PCIE_RP1_WAKE", // GPIO28
> > +                   "FAN_TACH", // GPIO29
> > +                   "HOST_SDA", // GPIO30
> > +                   "HOST_SCL", // GPIO31
> > +                   "ETH_RST_N", // GPIO32
> > +                   "", // GPIO33
> > +                   "CD0_IO0_MICCLK", // GPIO34
> > +                   "CD0_IO0_MICDAT0", // GPIO35
> > +                   "RP1_PCIE_CLKREQ_N", // GPIO36
> > +                   "", // GPIO37
> > +                   "CD0_SDA", // GPIO38
> > +                   "CD0_SCL", // GPIO39
> > +                   "CD1_SDA", // GPIO40
> > +                   "CD1_SCL", // GPIO41
> > +                   "USB_VBUS_EN", // GPIO42
> > +                   "USB_OC_N", // GPIO43
> > +                   "RP1_STAT_LED", // GPIO44
> > +                   "FAN_PWM", // GPIO45
> > +                   "CD1_IO0_MICCLK", // GPIO46
> > +                   "2712_WAKE", // GPIO47
> > +                   "CD1_IO1_MICDAT1", // GPIO48
> > +                   "EN_MAX_USB_CUR", // GPIO49
> > +                   "", // GPIO50
> > +                   "", // GPIO51
> > +                   "", // GPIO52
> > +                   ""; // GPIO53
> > +
> > +            rp1_uart0_14_15: rp1_uart0_14_15 {
> > +                pin_txd {
> > +                    function = "uart0";
> > +                    pins = "gpio14";
> > +                    bias-disable;
> > +                };
> > +
> > +                pin_rxd {
> > +                    function = "uart0";
> > +                    pins = "gpio15";
> > +                    bias-pull-up;
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6e7db9bce278..c5018232c251 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19120,7 +19120,9 @@ RASPBERRY PI RP1 PCI DRIVER
> >  M:	Andrea della Porta <andrea.porta@suse.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > +F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	include/dt-bindings/clock/rp1.h
> > +F:	include/dt-bindings/misc/rp1.h
> >  
> >  RC-CORE / LIRC FRAMEWORK
> >  M:	Sean Young <sean@mess.org>
> > diff --git a/include/dt-bindings/misc/rp1.h b/include/dt-bindings/misc/rp1.h
> 
> Filename should base on the compatible.

include/dt-bindings/misc/rp1.h is just a shared header currently included from:

- arch/arm64/boot/dts/broadcom/rp1.dtso (use RP1_INT_IO_BANKx)
- drivers/misc/rp1/rp1-pci.c		(use RP1_INT_END)
- Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml (use RP1_INT_IO_BANKx)

and the driver it is logically bound to (misc/rp1-pci.c) has no compatible, since it is a
PCI driver.
If you consider feasible to drop those interrupt defines in yaml bindings (please, see below), 
then I can just drop the entire header placing those defines inside rp1-pci.c, otherwise
we should come up with a new filename. If this is the case, I kindly ask for a suggestion.

> 
> The same applies to clocks bindings.

Ack.

> 
> > new file mode 100644
> > index 000000000000..6dd5e23870c2
> > --- /dev/null
> > +++ b/include/dt-bindings/misc/rp1.h
> > @@ -0,0 +1,235 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > +/*
> > + * This header provides constants for the PY MFD.
> > + */
> > +
> > +#ifndef _RP1_H
> > +#define _RP1_H
> 
> That's very poor header guard...

Ack.

> 
> > +
> > +/* Address map */
> > +#define RP1_SYSINFO_BASE 0x000000
> > +#define RP1_TBMAN_BASE 0x004000
> 
> Nope, addresses are not bindings. Drop entire header.

I've dropped the address part.

> 
> 
> > +#define RP1_SYSCFG_BASE 0x008000
> > +#define RP1_OTP_BASE 0x00c000
> > +#define RP1_POWER_BASE 0x010000
> > +#define RP1_RESETS_BASE 0x014000
> > +#define RP1_CLOCKS_BANK_DEFAULT_BASE 0x018000
> > +#define RP1_CLOCKS_BANK_VIDEO_BASE 0x01c000
> > +#define RP1_PLL_SYS_BASE 0x020000
> > +#define RP1_PLL_AUDIO_BASE 0x024000
> > +#define RP1_PLL_VIDEO_BASE 0x028000
> > +#define RP1_UART0_BASE 0x030000
> > +#define RP1_UART1_BASE 0x034000
> > +#define RP1_UART2_BASE 0x038000
> > +#define RP1_UART3_BASE 0x03c000
> > +#define RP1_UART4_BASE 0x040000
> > +#define RP1_UART5_BASE 0x044000
> > +#define RP1_SPI8_BASE 0x04c000
> > +#define RP1_SPI0_BASE 0x050000
> > +#define RP1_SPI1_BASE 0x054000
> > +#define RP1_SPI2_BASE 0x058000
> > +#define RP1_SPI3_BASE 0x05c000
> > +#define RP1_SPI4_BASE 0x060000
> > +#define RP1_SPI5_BASE 0x064000
> > +#define RP1_SPI6_BASE 0x068000
> > +#define RP1_SPI7_BASE 0x06c000
> > +#define RP1_I2C0_BASE 0x070000
> > +#define RP1_I2C1_BASE 0x074000
> > +#define RP1_I2C2_BASE 0x078000
> > +#define RP1_I2C3_BASE 0x07c000
> > +#define RP1_I2C4_BASE 0x080000
> > +#define RP1_I2C5_BASE 0x084000
> > +#define RP1_I2C6_BASE 0x088000
> > +#define RP1_AUDIO_IN_BASE 0x090000
> > +#define RP1_AUDIO_OUT_BASE 0x094000
> > +#define RP1_PWM0_BASE 0x098000
> > +#define RP1_PWM1_BASE 0x09c000
> > +#define RP1_I2S0_BASE 0x0a0000
> > +#define RP1_I2S1_BASE 0x0a4000
> > +#define RP1_I2S2_BASE 0x0a8000
> > +#define RP1_TIMER_BASE 0x0ac000
> > +#define RP1_SDIO0_APBS_BASE 0x0b0000
> > +#define RP1_SDIO1_APBS_BASE 0x0b4000
> > +#define RP1_BUSFABRIC_MONITOR_BASE 0x0c0000
> > +#define RP1_BUSFABRIC_AXISHIM_BASE 0x0c4000
> > +#define RP1_ADC_BASE 0x0c8000
> > +#define RP1_IO_BANK0_BASE 0x0d0000
> > +#define RP1_IO_BANK1_BASE 0x0d4000
> > +#define RP1_IO_BANK2_BASE 0x0d8000
> > +#define RP1_SYS_RIO0_BASE 0x0e0000
> > +#define RP1_SYS_RIO1_BASE 0x0e4000
> > +#define RP1_SYS_RIO2_BASE 0x0e8000
> > +#define RP1_PADS_BANK0_BASE 0x0f0000
> > +#define RP1_PADS_BANK1_BASE 0x0f4000
> > +#define RP1_PADS_BANK2_BASE 0x0f8000
> > +#define RP1_PADS_ETH_BASE 0x0fc000
> > +#define RP1_ETH_IP_BASE 0x100000
> > +#define RP1_ETH_CFG_BASE 0x104000
> > +#define RP1_PCIE_APBS_BASE 0x108000
> > +#define RP1_MIPI0_CSIDMA_BASE 0x110000
> > +#define RP1_MIPI0_CSIHOST_BASE 0x114000
> > +#define RP1_MIPI0_DSIDMA_BASE 0x118000
> > +#define RP1_MIPI0_DSIHOST_BASE 0x11c000
> > +#define RP1_MIPI0_MIPICFG_BASE 0x120000
> > +#define RP1_MIPI0_ISP_BASE 0x124000
> > +#define RP1_MIPI1_CSIDMA_BASE 0x128000
> > +#define RP1_MIPI1_CSIHOST_BASE 0x12c000
> > +#define RP1_MIPI1_DSIDMA_BASE 0x130000
> > +#define RP1_MIPI1_DSIHOST_BASE 0x134000
> > +#define RP1_MIPI1_MIPICFG_BASE 0x138000
> > +#define RP1_MIPI1_ISP_BASE 0x13c000
> > +#define RP1_VIDEO_OUT_CFG_BASE 0x140000
> > +#define RP1_VIDEO_OUT_VEC_BASE 0x144000
> > +#define RP1_VIDEO_OUT_DPI_BASE 0x148000
> > +#define RP1_XOSC_BASE 0x150000
> > +#define RP1_WATCHDOG_BASE 0x154000
> > +#define RP1_DMA_TICK_BASE 0x158000
> > +#define RP1_SDIO_CLOCKS_BASE 0x15c000
> > +#define RP1_USBHOST0_APBS_BASE 0x160000
> > +#define RP1_USBHOST1_APBS_BASE 0x164000
> > +#define RP1_ROSC0_BASE 0x168000
> > +#define RP1_ROSC1_BASE 0x16c000
> > +#define RP1_VBUSCTRL_BASE 0x170000
> > +#define RP1_TICKS_BASE 0x174000
> > +#define RP1_PIO_APBS_BASE 0x178000
> > +#define RP1_SDIO0_AHBLS_BASE 0x180000
> > +#define RP1_SDIO1_AHBLS_BASE 0x184000
> > +#define RP1_DMA_BASE 0x188000
> > +#define RP1_RAM_BASE 0x1c0000
> > +#define RP1_RAM_SIZE 0x020000
> > +#define RP1_USBHOST0_AXIS_BASE 0x200000
> > +#define RP1_USBHOST1_AXIS_BASE 0x300000
> > +#define RP1_EXAC_BASE 0x400000
> > +
> > +/* Interrupts */
> > +
> > +#define RP1_INT_IO_BANK0 0
> > +#define RP1_INT_IO_BANK1 1
> 
> Also no, interrupt numbers are not considered bindings. That's too much
> churn. Otherwise, please point me to driver code using the define
> (directly! that's the requirement).

As mentioned above, RP1_INT_END is used in rp1-pci.c. To get rid of all those
macroes from dt-binding would mean to hardcode the interrupt number in both
the binding example and in dtso, from this:

interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
             <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
             <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;

to this:

interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
	     <1 IRQ_TYPE_LEVEL_HIGH>,
             <2 IRQ_TYPE_LEVEL_HIGH>;

is this what you are proposing?

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

