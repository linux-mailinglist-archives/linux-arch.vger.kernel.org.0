Return-Path: <linux-arch+bounces-6398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A7959791
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B5C2817E2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE01ACDF6;
	Wed, 21 Aug 2024 08:38:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E61A2874;
	Wed, 21 Aug 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229531; cv=none; b=WvDa9kJV1j2o9AhXWiZp40Az/IrEfaasr/sO90L9nL4jyH66OCiFW+j23B3Nb/L2OYJhS2l2QOzZfsRM9TxVm36wm38myUHPDqyFRa2oeo1kVvCFKjte0vS7jYwnew6TxgfCLplSYdfY+W4JkNuHFCkZhcHKjX04PMZGZ35A/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229531; c=relaxed/simple;
	bh=5P/c/jaSjzeI/MhOgIKhlzzyIqWq3b0zhScQFwa+lio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+H88AScGJLrBkPSqG21fnuvj0VYIm/qetHL0Lk6Zx3ErEbD6diRNiEavRP5XcivQr0NASELpJWgXICDZuk0+Qy+IYAWRch+5W46qpf7ApFjBi5FJE9W9N4GUhHVL2n2G4RKay0N8oIUr1iZ/+6UXZULd00DbVsCd6lNApCruD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37182eee02dso307589f8f.1;
        Wed, 21 Aug 2024 01:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229528; x=1724834328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA4cbeI3jpf2hMQGC2S0v8mEm6wI1ZVlkyXbFIyoQFE=;
        b=OQLT005mCtUT5Dpk9xaUvblzBsthzCqADXjQX0IZHR6uPcKIOWpsMuOrWoCnGsBE2H
         UzPC8PUEZkn3fVLx7zKP+qUQAV5W9snIdw/SoA7ggBZaaPFKgD1SwQqrQAJ0FHCComdX
         l/Dw+g2V993Nw0zyESAeTJB+vXPLJ9E860WbE8UNrWfiy70eYbBBUmtCFFdjwXgNb67Z
         lS5swVfV1VpRUIDOXpV9xW4LehoUYvsmjOdbDpctoPLaokS3yyg3tadoqge1TyYau0Xy
         j1O7Pl4o1CmXgPlCQl7SA/bM3cHh9y6rbCiBsDWcJ/+ItPBnWqkiHASkNfqRRIbAXRM6
         EFBA==
X-Forwarded-Encrypted: i=1; AJvYcCU3J3X1U+ondWMnG2ElSau/4zZPr1I/2PiHUQ9k4D0iBRHVLnJeXVqa/UCngUO0vimkdmNDcr3uri7c@vger.kernel.org, AJvYcCV3+G63DlmDbL/hLVv5gTnONe8+vkfe+xZ+N0F713/8xENn1NePsZ0g3Db6CFN7VWRptg0Ux0Gkek81@vger.kernel.org, AJvYcCWA0WJP/1Eefn57pyGnC4Mmq+nBhega9UzS1yNihjKqZZ6HpTy9oSUE2cJ/6+xV05Le8RURPheze/bihQ==@vger.kernel.org, AJvYcCWtRNxGI5eBr9O9wlO9l/PBEQd5bDQ4XnsRlJapNLzvL+WHIi38BYRAnzVvLyIY8lH4uFInaGFLYkVx3Xfw@vger.kernel.org, AJvYcCXClIQn+G/m8KDvXj7bW731UKX4JHGQNIVJqjDS73s1YJbFHZMubr0C12ZWz3UGKFzfu1EgPCU8GLnZ@vger.kernel.org, AJvYcCXVGb+vGygdZTcvvQDk4KiLSq4O07jDamJAm1Ph39CUSGC8A1HdvEYtbLscv1xeJh0DkyDkO5MY2k6D6Q==@vger.kernel.org, AJvYcCXolWJoENTDZqFREa3o0yjxoeNXRgl5dG2Mmjdn2C7GakGyTqE7gDuxuhvHjpNn0Z5PNnL9awq6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbevy9ABiGVnnhutvkAftQ1vQGE9MfO5L0JDAg3WWpsEsDYESp
	j+4yGIPOUQHru3rtfTsZ4UwAdErfJL2ktAUofgZE/drrwo9e8CKO
X-Google-Smtp-Source: AGHT+IHXLag70+EkUrHg+KlcK65OfqLHIOBumUqGGpky9bmcM8OGLMbTFiG3PRa2CgHtrTzQlZwJdw==
X-Received: by 2002:a5d:6592:0:b0:366:595c:ca0c with SMTP id ffacd0b85a97d-372fde0fd3bmr790859f8f.24.1724229528033;
        Wed, 21 Aug 2024 01:38:48 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898b8ad6sm15074573f8f.114.2024.08.21.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:38:47 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:38:43 +0200
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
Subject: Re: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <lrv7cpbt2n7eidog5ydhrbyo5se5l2j23n7ljxvojclnhykqs2@nfeu4wpi2d76>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> The RaspberryPi RP1 is ia PCI multi function device containing
> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.
> Implement a bare minimum driver to operate the RP1, leveraging
> actual OF based driver implementations for the on-borad peripherals
> by loading a devicetree overlay during driver probe.
> The peripherals are accessed by mapping MMIO registers starting
> from PCI BAR1 region.
> As a minimum driver, the peripherals will not be added to the
> dtbo here, but in following patches.
> 
> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  MAINTAINERS                           |   2 +
>  arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++

Do not mix DTS with drivers.

These MUST be separate.

>  drivers/misc/Kconfig                  |   1 +
>  drivers/misc/Makefile                 |   1 +
>  drivers/misc/rp1/Kconfig              |  20 ++
>  drivers/misc/rp1/Makefile             |   3 +
>  drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
>  drivers/misc/rp1/rp1-pci.dtso         |   8 +
>  drivers/pci/quirks.c                  |   1 +
>  include/linux/pci_ids.h               |   3 +
>  10 files changed, 524 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
>  create mode 100644 drivers/misc/rp1/Kconfig
>  create mode 100644 drivers/misc/rp1/Makefile
>  create mode 100644 drivers/misc/rp1/rp1-pci.c
>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67f460c36ea1..1359538b76e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
>  RASPBERRY PI RP1 PCI DRIVER
>  M:	Andrea della Porta <andrea.porta@suse.com>
>  S:	Maintained
> +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	drivers/clk/clk-rp1.c
> +F:	drivers/misc/rp1/
>  F:	drivers/pinctrl/pinctrl-rp1.c
>  F:	include/dt-bindings/clock/rp1.h
>  F:	include/dt-bindings/misc/rp1.h
> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> new file mode 100644
> index 000000000000..d80178a278ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/rp1.h>
> +#include <dt-bindings/misc/rp1.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	fragment@0 {
> +		target-path="";
> +		__overlay__ {
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			rp1: rp1@0 {
> +				compatible = "simple-bus";
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +				interrupt-controller;
> +				interrupt-parent = <&rp1>;
> +				#interrupt-cells = <2>;
> +
> +				// ranges and dma-ranges must be provided by the includer
> +				ranges = <0xc0 0x40000000
> +					  0x01/*0x02000000*/ 0x00 0x00000000
> +					  0x00 0x00400000>;

Are you 100% sure you do not have here dtc W=1 warnings?

> +
> +				dma-ranges =
> +				// inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
> +					     <0x10 0x00000000
> +					      0x43000000 0x10 0x00000000
> +					      0x10 0x00000000>;
> +
> +				clk_xosc: clk_xosc {

Nope, switch to DTS coding style.

> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-output-names = "xosc";
> +					clock-frequency = <50000000>;
> +				};
> +
> +				macb_pclk: macb_pclk {
> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-output-names = "pclk";
> +					clock-frequency = <200000000>;
> +				};
> +
> +				macb_hclk: macb_hclk {
> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-output-names = "hclk";
> +					clock-frequency = <200000000>;
> +				};
> +
> +				rp1_clocks: clocks@c040018000 {

Why do you mix MMIO with non-MMIO nodes? This really does not look
correct.

> +					compatible = "raspberrypi,rp1-clocks";
> +					#clock-cells = <1>;
> +					reg = <0xc0 0x40018000 0x0 0x10038>;

Wrong order of properties - see DTS coding style.

> +					clocks = <&clk_xosc>;
> +					clock-names = "xosc";

Best regards,
Krzysztof


