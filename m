Return-Path: <linux-arch+bounces-6399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F59597C0
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6852A2833A1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954DF192D6A;
	Wed, 21 Aug 2024 08:42:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B71531E2;
	Wed, 21 Aug 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229750; cv=none; b=U9tz4TzxFB69bFLPOuDUkEAZqwzOSLnt4Xk/7tJ8jYhpqo6hvoWLhuTiE9HB0dpSO3Oe92ZyF15GQBWy2jXZ//IsW93R73Rb2J/+lqynwCiJIcFnozXEyim7wTM+0kpNVydP49it8v4awiOfo1rszZXIxc301KHgWXRWRiYRC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229750; c=relaxed/simple;
	bh=GTJLcDJElIHm1tlUkVDlTiWrHhM/DFYXqdDHfY4j/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdesQnG0hjRDvQBdXpzowpTS/HPscmAJCMM6mGY14+ztxf+Ft1Zk3ba6T+1LYso2V40Fk9Mfx77vwfWQjDY3q/wp2sP/X3V1dZFrtWp0P8sZChkCme+UyTCnmktdw9Ndi51EKHVOgAsHbv5FI32rE7tj0v6ye4MIEjUaFWhRFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so4020134f8f.1;
        Wed, 21 Aug 2024 01:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229747; x=1724834547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tl/vo8wzWrW91EXOsCzc+JW9EP+tpI4TkxXDUIWo9A=;
        b=rmu5OJGtXxFoUOkanTa+9nLAuhpX0nRYUNnak4GgIzRipi4Ego7rUgTq+KynGfsjUo
         Iyl8L7TYEAEO+jMYV4lilPOnQkiMvY2AIBSIsHJKt1qo1MFcKtuf2cV0vXwPzK0SmK3f
         OdfBmAYdU/3HT9MHIZzlOdgFms6iWgF9IrNsTVJxDSsI0lGD1GTvCSoRjIxrbwDPGLx4
         4H9x37uaEhT7laI+Sbe6N5Jr7nLxfbtm9zjcBnS3bHN7b6NpbxdcFrs37/6RIllzUdOc
         YTe4oG4hPa6BV6yni75XKqdIjqaVlg9i2ktDTxXD4G6XPQ43QH75/np3Z8gNq+f828rP
         y2WA==
X-Forwarded-Encrypted: i=1; AJvYcCU0KdBFW23X1PpYubJTpAfruZp6BNvVtuzHw901E5caSfAH5h2DmrIpgyARQCrOMDzXhrY0enZuRRLOyA==@vger.kernel.org, AJvYcCU0waFj2rcIzGgS6Hs1DXjgR18blaOAu6PUPdayK4N4lc4J6Rg/ppGu2MLMxu9O6OqzR5bjY2Ew8RA8@vger.kernel.org, AJvYcCUYUM34xM8D9uu7ycRuivSzSsRN8PuxpEx+7Wqyeg1S+meKJAkhnEKmXNMIceWqbDOQAGkMIC/Ah6DiMg==@vger.kernel.org, AJvYcCUi070e3JZoo0lp1DxY1qVWOJ4DhEI61+uB0kLkhwYojBjaZFC1QzSQG3Rd5PVIwKqAcR8zJ4RYFj+rvMm2@vger.kernel.org, AJvYcCVrvkNF35ahk0pn3WcIclbdGhNJvEGX3arAUv1NBnCjQSCafc/DBb72sfRQoKLllXWyQ+r/rztQ@vger.kernel.org, AJvYcCW8ev/bY5sVIj9Tl88Nqi/P35neu2PTp4UVECIe3re3v2dfRI2oAPF8OsPNaXPw5RnTNXlOThBX0wWQ@vger.kernel.org, AJvYcCX+vmM41/M2IRHP/5CVc6hjyMmSzsXjss+Ei0CA7PsQLtCMY0pB7JBaHopB0X/ouJ9Zj7flU9zHfMdh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4V83Lpd/QlnXUWUKJ+ka9JhxhUaOEkrA+5E1bRhOztZyLVWj4
	2G9wzoCp0u3Sv9M07U9og2Z/aFbcRIDySSJVeftaMf2VQXsvtYBX
X-Google-Smtp-Source: AGHT+IHbH7zbHUOGKRgGP+HXFBI28H0F3q7e4QjC6QDUb83LRbu2GeW/xYN9VTx2mpAjepeaVsBWeA==
X-Received: by 2002:adf:9788:0:b0:368:48b2:95ec with SMTP id ffacd0b85a97d-372fd57f032mr1083871f8f.1.1724229746365;
        Wed, 21 Aug 2024 01:42:26 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189897008sm15039650f8f.84.2024.08.21.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:42:25 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:42:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 02/11] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <5zlaxts46utk66k2n2uxeqr6umppfasnqoxhwdzah44hcmyfnp@euwjda6zk5rh>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <82d57814075ed1bc76bf17bde124c5c83925ac59.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82d57814075ed1bc76bf17bde124c5c83925ac59.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:04PM +0200, Andrea della Porta wrote:
> Add device tree bindings for the gpio/pin/mux controller that is part of
> the RP1 multi function device, and relative entries in MAINTAINERS file.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../pinctrl/raspberrypi,rp1-gpio.yaml         | 177 +++++++++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/misc/rp1.h                | 235 ++++++++++++++++++
>  3 files changed, 414 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  create mode 100644 include/dt-bindings/misc/rp1.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> new file mode 100644
> index 000000000000..7011fa258363
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description:
> +  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
> +  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
> +  as an interrupt controller for those gpios.
> +
> +  Each pin configuration node lists the pin(s) to which it applies, and one or
> +  more of the mux function to select on those pin(s), and their configuration.
> +  The pin configuration and multiplexing supports the generic bindings.
> +  For details on each properties (including the meaning of "pin configuration node"),
> +  you can refer to ./pinctrl-bindings.txt.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rp1-gpio
> +
> +  reg:
> +    minItems: 3

You can drop minItems.

> +    maxItems: 3
> +    description: One reg specifier for each one of the 3 pin banks.
> +
> +  '#gpio-cells':
> +    description: The first cell is the pin number and the second cell is used
> +      to specify the flags (see include/dt-bindings/gpio/gpio.h).
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +  gpio-line-names:
> +    maxItems: 54
> +
> +  interrupts:
> +    minItems: 3

Ditto

> +    maxItems: 3
> +    description: One interrupt specifier for each one of the 3 pin banks.
> +
> +  '#interrupt-cells':
> +    description:
> +      Specifies the Bank number (as specified in include/dt-bindings/misc/rp1.h)
> +      and Flags (as defined in (include/dt-bindings/interrupt-controller/irq.h).
> +      Possible values for the Bank number are
> +          RP1_INT_IO_BANK0
> +          RP1_INT_IO_BANK1
> +          RP1_INT_IO_BANK2
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +additionalProperties:
> +  anyOf:
> +    - type: object
> +      additionalProperties: false
> +      allOf:
> +        - $ref: pincfg-node.yaml#
> +        - $ref: pinmux-node.yaml#
> +
> +      description:
> +        Pin controller client devices use pin configuration subnodes (children
> +        and grandchildren) for desired pin configuration.
> +        Client device subnodes use below standard properties.
> +
> +      properties:
> +        pins:
> +          description:
> +            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
> +        function: true
> +        bias-disable: true
> +        bias-pull-down: true
> +        bias-pull-up: true
> +        slew-rate:
> +          description: 0 is slow slew rate, 1 is fast slew rate
> +          enum: [ 0, 1 ]
> +        drive-strength:
> +          description: 0 -> 2mA, 1 -> 4mA, 2 -> 8mA, 3 -> 12mA
> +          enum: [ 0, 1, 2, 3 ]

No, that's [ 2, 4, 8 and 12 ]

Read description of the field - it is in specific units.

> +
> +    - type: object
> +      additionalProperties:
> +        $ref: "#/additionalProperties/anyOf/0"
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - reg
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/misc/rp1.h>
> +
> +    rp1 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        rp1_gpio: pinctrl@c0400d0000 {
> +            reg = <0xc0 0x400d0000  0x0 0xc000>,
> +                  <0xc0 0x400e0000  0x0 0xc000>,
> +                  <0xc0 0x400f0000  0x0 0xc000>;
> +            compatible = "raspberrypi,rp1-gpio";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
> +            gpio-line-names =
> +                   "ID_SDA", // GPIO0
> +                   "ID_SCL", // GPIO1
> +                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
> +                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
> +                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
> +                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
> +                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
> +                   "GPIO27",
> +                   "PCIE_RP1_WAKE", // GPIO28
> +                   "FAN_TACH", // GPIO29
> +                   "HOST_SDA", // GPIO30
> +                   "HOST_SCL", // GPIO31
> +                   "ETH_RST_N", // GPIO32
> +                   "", // GPIO33
> +                   "CD0_IO0_MICCLK", // GPIO34
> +                   "CD0_IO0_MICDAT0", // GPIO35
> +                   "RP1_PCIE_CLKREQ_N", // GPIO36
> +                   "", // GPIO37
> +                   "CD0_SDA", // GPIO38
> +                   "CD0_SCL", // GPIO39
> +                   "CD1_SDA", // GPIO40
> +                   "CD1_SCL", // GPIO41
> +                   "USB_VBUS_EN", // GPIO42
> +                   "USB_OC_N", // GPIO43
> +                   "RP1_STAT_LED", // GPIO44
> +                   "FAN_PWM", // GPIO45
> +                   "CD1_IO0_MICCLK", // GPIO46
> +                   "2712_WAKE", // GPIO47
> +                   "CD1_IO1_MICDAT1", // GPIO48
> +                   "EN_MAX_USB_CUR", // GPIO49
> +                   "", // GPIO50
> +                   "", // GPIO51
> +                   "", // GPIO52
> +                   ""; // GPIO53
> +
> +            rp1_uart0_14_15: rp1_uart0_14_15 {
> +                pin_txd {
> +                    function = "uart0";
> +                    pins = "gpio14";
> +                    bias-disable;
> +                };
> +
> +                pin_rxd {
> +                    function = "uart0";
> +                    pins = "gpio15";
> +                    bias-pull-up;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7db9bce278..c5018232c251 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19120,7 +19120,9 @@ RASPBERRY PI RP1 PCI DRIVER
>  M:	Andrea della Porta <andrea.porta@suse.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> +F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	include/dt-bindings/clock/rp1.h
> +F:	include/dt-bindings/misc/rp1.h
>  
>  RC-CORE / LIRC FRAMEWORK
>  M:	Sean Young <sean@mess.org>
> diff --git a/include/dt-bindings/misc/rp1.h b/include/dt-bindings/misc/rp1.h

Filename should base on the compatible.

The same applies to clocks bindings.

> new file mode 100644
> index 000000000000..6dd5e23870c2
> --- /dev/null
> +++ b/include/dt-bindings/misc/rp1.h
> @@ -0,0 +1,235 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * This header provides constants for the PY MFD.
> + */
> +
> +#ifndef _RP1_H
> +#define _RP1_H

That's very poor header guard...

> +
> +/* Address map */
> +#define RP1_SYSINFO_BASE 0x000000
> +#define RP1_TBMAN_BASE 0x004000

Nope, addresses are not bindings. Drop entire header.


> +#define RP1_SYSCFG_BASE 0x008000
> +#define RP1_OTP_BASE 0x00c000
> +#define RP1_POWER_BASE 0x010000
> +#define RP1_RESETS_BASE 0x014000
> +#define RP1_CLOCKS_BANK_DEFAULT_BASE 0x018000
> +#define RP1_CLOCKS_BANK_VIDEO_BASE 0x01c000
> +#define RP1_PLL_SYS_BASE 0x020000
> +#define RP1_PLL_AUDIO_BASE 0x024000
> +#define RP1_PLL_VIDEO_BASE 0x028000
> +#define RP1_UART0_BASE 0x030000
> +#define RP1_UART1_BASE 0x034000
> +#define RP1_UART2_BASE 0x038000
> +#define RP1_UART3_BASE 0x03c000
> +#define RP1_UART4_BASE 0x040000
> +#define RP1_UART5_BASE 0x044000
> +#define RP1_SPI8_BASE 0x04c000
> +#define RP1_SPI0_BASE 0x050000
> +#define RP1_SPI1_BASE 0x054000
> +#define RP1_SPI2_BASE 0x058000
> +#define RP1_SPI3_BASE 0x05c000
> +#define RP1_SPI4_BASE 0x060000
> +#define RP1_SPI5_BASE 0x064000
> +#define RP1_SPI6_BASE 0x068000
> +#define RP1_SPI7_BASE 0x06c000
> +#define RP1_I2C0_BASE 0x070000
> +#define RP1_I2C1_BASE 0x074000
> +#define RP1_I2C2_BASE 0x078000
> +#define RP1_I2C3_BASE 0x07c000
> +#define RP1_I2C4_BASE 0x080000
> +#define RP1_I2C5_BASE 0x084000
> +#define RP1_I2C6_BASE 0x088000
> +#define RP1_AUDIO_IN_BASE 0x090000
> +#define RP1_AUDIO_OUT_BASE 0x094000
> +#define RP1_PWM0_BASE 0x098000
> +#define RP1_PWM1_BASE 0x09c000
> +#define RP1_I2S0_BASE 0x0a0000
> +#define RP1_I2S1_BASE 0x0a4000
> +#define RP1_I2S2_BASE 0x0a8000
> +#define RP1_TIMER_BASE 0x0ac000
> +#define RP1_SDIO0_APBS_BASE 0x0b0000
> +#define RP1_SDIO1_APBS_BASE 0x0b4000
> +#define RP1_BUSFABRIC_MONITOR_BASE 0x0c0000
> +#define RP1_BUSFABRIC_AXISHIM_BASE 0x0c4000
> +#define RP1_ADC_BASE 0x0c8000
> +#define RP1_IO_BANK0_BASE 0x0d0000
> +#define RP1_IO_BANK1_BASE 0x0d4000
> +#define RP1_IO_BANK2_BASE 0x0d8000
> +#define RP1_SYS_RIO0_BASE 0x0e0000
> +#define RP1_SYS_RIO1_BASE 0x0e4000
> +#define RP1_SYS_RIO2_BASE 0x0e8000
> +#define RP1_PADS_BANK0_BASE 0x0f0000
> +#define RP1_PADS_BANK1_BASE 0x0f4000
> +#define RP1_PADS_BANK2_BASE 0x0f8000
> +#define RP1_PADS_ETH_BASE 0x0fc000
> +#define RP1_ETH_IP_BASE 0x100000
> +#define RP1_ETH_CFG_BASE 0x104000
> +#define RP1_PCIE_APBS_BASE 0x108000
> +#define RP1_MIPI0_CSIDMA_BASE 0x110000
> +#define RP1_MIPI0_CSIHOST_BASE 0x114000
> +#define RP1_MIPI0_DSIDMA_BASE 0x118000
> +#define RP1_MIPI0_DSIHOST_BASE 0x11c000
> +#define RP1_MIPI0_MIPICFG_BASE 0x120000
> +#define RP1_MIPI0_ISP_BASE 0x124000
> +#define RP1_MIPI1_CSIDMA_BASE 0x128000
> +#define RP1_MIPI1_CSIHOST_BASE 0x12c000
> +#define RP1_MIPI1_DSIDMA_BASE 0x130000
> +#define RP1_MIPI1_DSIHOST_BASE 0x134000
> +#define RP1_MIPI1_MIPICFG_BASE 0x138000
> +#define RP1_MIPI1_ISP_BASE 0x13c000
> +#define RP1_VIDEO_OUT_CFG_BASE 0x140000
> +#define RP1_VIDEO_OUT_VEC_BASE 0x144000
> +#define RP1_VIDEO_OUT_DPI_BASE 0x148000
> +#define RP1_XOSC_BASE 0x150000
> +#define RP1_WATCHDOG_BASE 0x154000
> +#define RP1_DMA_TICK_BASE 0x158000
> +#define RP1_SDIO_CLOCKS_BASE 0x15c000
> +#define RP1_USBHOST0_APBS_BASE 0x160000
> +#define RP1_USBHOST1_APBS_BASE 0x164000
> +#define RP1_ROSC0_BASE 0x168000
> +#define RP1_ROSC1_BASE 0x16c000
> +#define RP1_VBUSCTRL_BASE 0x170000
> +#define RP1_TICKS_BASE 0x174000
> +#define RP1_PIO_APBS_BASE 0x178000
> +#define RP1_SDIO0_AHBLS_BASE 0x180000
> +#define RP1_SDIO1_AHBLS_BASE 0x184000
> +#define RP1_DMA_BASE 0x188000
> +#define RP1_RAM_BASE 0x1c0000
> +#define RP1_RAM_SIZE 0x020000
> +#define RP1_USBHOST0_AXIS_BASE 0x200000
> +#define RP1_USBHOST1_AXIS_BASE 0x300000
> +#define RP1_EXAC_BASE 0x400000
> +
> +/* Interrupts */
> +
> +#define RP1_INT_IO_BANK0 0
> +#define RP1_INT_IO_BANK1 1

Also no, interrupt numbers are not considered bindings. That's too much
churn. Otherwise, please point me to driver code using the define
(directly! that's the requirement).

Best regards,
Krzysztof


