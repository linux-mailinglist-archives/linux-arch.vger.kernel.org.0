Return-Path: <linux-arch+bounces-6401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C79597E3
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F7E1C21101
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C71BDA92;
	Wed, 21 Aug 2024 08:45:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1E1A7AD3;
	Wed, 21 Aug 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229910; cv=none; b=AFN8xyMi1gAK6iTED0ys3iYCL5VwOT//AUFVJM8m1AYGLjpjpL1BvVjaUqiFdDV7yvkgiSR33VokpIXXmK+bFlfeXqECm2vZLpttjyyILErpL4bUqVcK67af6Wr21x9HlJSoHcZiUDrAAG+b3uwJNTB14ykcFLhpbzpBdSTXP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229910; c=relaxed/simple;
	bh=qRHRsbmRDvbIyXABIKEaaMk2OJDVFBz9OKDrgIfMiu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3biBuTbnIJ9HOTWy7PEz/7zZyMc3AEluwi87dIMqj8dFkUUHy0cxYTjCLMju+Gcp8DIStXjRm511xtNX+uz2Bm6j9CjHs/gaa0DCby15R2hBPoRBA2ZaDHrmM89O9AnbOdQgDZEJXpHPMsNplRSpK+UaKCl/MtpkCeBlupFrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b015572cso3204713f8f.1;
        Wed, 21 Aug 2024 01:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229907; x=1724834707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vebzIfVKrkPnVYzJ3Le9GL91uwlzLYfp0d5U/T68YJ8=;
        b=J9CA4uoE/YT9/AZxTlnI+pmt2zYPS3W1dhDlINf+KxB0RBWgNFInfHqHkX1ZS2BLSS
         9ztY65Fr7S4lydew2zKtcnQvdTEka7VuPEfzNGnVLHb3+1FrjzsiRFasa2cxKSDFt4/6
         YCPrw0SmDNTc6nhTcxmaMZqKzDBQYQ/E3eczAz7brbw85tWTvMroswFpVy7fTaBtR8Fg
         6QL8LJpMqXPhV4AlGSMM4eztCDGFz9M3YlxiH7YGtyWUvfJQa7srZu8gFNH4PMEfUw0V
         K3Ylz2BQO7XxoIYddwB9vNpD5rVF+odfPJg7cecmCRYSOrH63eVBFjy7q3WpZ1/3+DNZ
         eRSw==
X-Forwarded-Encrypted: i=1; AJvYcCUAI3BFNf3uGHGFfqJ9EmO64X33kUghtBRHFvgjbA+AkdR95tW53cZ3nFWKzR2iEJCNcT33VEufYF5crw==@vger.kernel.org, AJvYcCUxsGkNP/TuaEITT3adrnMw/cXHyp22dQRNiSyf1HHVnMLg+GEhEYuCQ/l8AeoQ5APDNsedTo22yE+o8g==@vger.kernel.org, AJvYcCVHydiGf0JifPRQ9kpawhDbuHskil+7wCnlKlFcVbVspIpXOhCXm9ML3xBTKPCEEx9ezG0AQOcJ5HRx@vger.kernel.org, AJvYcCXM9huIo4KQInkJg9ZyxY/xIUz3Z2tt070ns8NEABsaEcw5hfn3oFa2+o5dP70bE2oLuSy81ImpkyCV@vger.kernel.org, AJvYcCXQa4Hgr8T84YFM4vfN3i6UT+Pc5flDCrczSstt7qsNsPQd+SqNOx5cXXf1t2GebNvK/5NcVpGFnfv2@vger.kernel.org, AJvYcCXQx8tBiI/UHvMoD5BkvK8H/P+R9o0t0y/x+kiFhyCtNkLM9IUGlX/Ht8ZApt6mC8IrlkIVfCEjbX2m5lWn@vger.kernel.org, AJvYcCXeXBZbI//vmDntaBBKLMDlROIJWdGZyTvJGye+1AdHJGrBkVD2xOhbOUE3M0ESTUdG1/lWWedZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqlnZbctpPZM9cbIg1GIaMH4xRdQEGenNc7Zb4J6QGlZj6atwT
	LDDrl/OsGF6ruIxwOiDIvuAeMnkYpapiX60VnCI6XEbizEjFHCNj
X-Google-Smtp-Source: AGHT+IHKaaVpmQDW4zkcKLIQEKPER5kx2Q85aw0jAdWSxY/jqDtMu5zXmXnjno2J10fTqpaZgDn8NQ==
X-Received: by 2002:a5d:5f56:0:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-372fd57f1eamr1516016f8f.6.1724229907231;
        Wed, 21 Aug 2024 01:45:07 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abed90ef7sm17385485e9.9.2024.08.21.01.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:45:06 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:45:03 +0200
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
Subject: Re: [PATCH 07/11] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <l4xijmtxz5i5kkkd5tt25ls33drnnhxp26r42lab5ev343e4zh@ctknkjzbpwqz>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:09PM +0200, Andrea della Porta wrote:
> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> Add minimum support for the gpio only portion. The driver is in
> pinctrl folder since upcoming patches will add the pinmux/pinctrl
> support where the gpio part can be seen as an addition.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/pinctrl/Kconfig       |  10 +
>  drivers/pinctrl/Makefile      |   1 +
>  drivers/pinctrl/pinctrl-rp1.c | 719 ++++++++++++++++++++++++++++++++++
>  4 files changed, 731 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-rp1.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ce7b049d67e..67f460c36ea1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19122,6 +19122,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	drivers/clk/clk-rp1.c
> +F:	drivers/pinctrl/pinctrl-rp1.c
>  F:	include/dt-bindings/clock/rp1.h
>  F:	include/dt-bindings/misc/rp1.h
>  
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 7e4f93a3bc7a..18bb1a8bd102 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -565,6 +565,16 @@ config PINCTRL_MLXBF3
>  	  each pin. This driver can also be built as a module called
>  	  pinctrl-mlxbf3.
>  
> +config PINCTRL_RP1
> +	bool "Pinctrl driver for RP1"
> +	select PINMUX
> +	select PINCONF
> +	select GENERIC_PINCONF
> +	select GPIOLIB_IRQCHIP
> +	help
> +	  Enable the gpio and pinctrl/mux  driver for RaspberryPi RP1
> +	  multi function device. 
> +
>  source "drivers/pinctrl/actions/Kconfig"
>  source "drivers/pinctrl/aspeed/Kconfig"
>  source "drivers/pinctrl/bcm/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index cc809669405a..f1ca23b563f6 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
>  obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
>  obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
>  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
> +obj-$(CONFIG_PINCTRL_RP1)       += pinctrl-rp1.o
>  obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
>  obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
>  obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
> diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> new file mode 100644
> index 000000000000..c035d2014505
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-rp1.c
> @@ -0,0 +1,719 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Raspberry Pi RP1 GPIO unit
> + *
> + * Copyright (C) 2023 Raspberry Pi Ltd.
> + *
> + * This driver is inspired by:
> + * pinctrl-bcm2835.c, please see original file for copyright information
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/init.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>

Half of these headers are not used. Drop them.

Best regards,
Krzysztof


