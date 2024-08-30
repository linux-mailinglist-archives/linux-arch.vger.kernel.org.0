Return-Path: <linux-arch+bounces-6844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C8965F67
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 12:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90091C22DB4
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147C18EFD3;
	Fri, 30 Aug 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K1iU6M/I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F418E355
	for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014339; cv=none; b=qhfPqhC2cVYIcmUJxQehLcTOFBPY/ZJhQmieeXOAVYc6wUHXmBDpe5uvCzqrAPusqqBtgLktYolV5fuLkgDjqvbVq7fGP+ZvgZNcbCgdzWLHwiWZ76Esb/AM4aM5MyfkV17bE00jzvdJJmE88oEK/tTx9Y5aBLBNY/LCS3xskHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014339; c=relaxed/simple;
	bh=4G2JQeTl20rKQb1UIC8sygdnIRevvH3GCEN6TIr/r3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQQ1S5WFDkGMVHTrigp4IL7WQz9xEWQD46lFclLV9C6B7FP5MW5VTSC6WrFbji/lRfsDUNl5TjqaGbdAJBI0cByqd5Rdfbcwcg7r+/pQyPxQ3RjiPtxL2lFDuUkMy6DAfN1mpWV3roG6D5QpJ3FGN0URKbH4AYAkJlRI7JJjrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K1iU6M/I; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso190438566b.2
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2024 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725014335; x=1725619135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Au08vB5OeNxHqyShPMASavhrXq4vVsx5hzYBAmcP4=;
        b=K1iU6M/I9+FzAxbZpsKnXAIvO3tBvl1i9x2TDGmPqowTJ8Vb/VbOQmTZ69MErb8ehy
         by0KMbos4bIwAWnk4Cip4VHhToTxegmbae3na3DiN2GSPxqWrGOOlvIPC13KS2eooJRo
         UEDVBUDuxW1Vdfxpu+q4941qHndwQn9QrhJx/CCrEHfA31qTtrSrboCJHdy2dZJeqEDD
         +o8k5FDm0+lq0JCY8mprZobZBvaJHYzAAZYyridv8O1KvF7XNl5a8PUjHXWSb1VV/Boi
         YMJB55hIoLjbdSMxLgb6X+nls04GLhuJx0db/PsS1m10rQEAHsBOdCQurA9feM0VA07x
         3Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014335; x=1725619135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Au08vB5OeNxHqyShPMASavhrXq4vVsx5hzYBAmcP4=;
        b=j8J+d8hRi/WGEbArsNjt2mQNfDH6URGiuT8oV65LCR8QFr++RURZQfhmFU8BhNSZR1
         nL3Am/+LREKXJnKTk7yAQ9qFohdYReJjdVxy4h47Hf547O02eHnNl5AdiBM2WrcA2ff1
         jZIEQ3Ci9LG69TQToAW8+sHeQ6cpXXhVzbMMiqGtWYdQXVosuis9sA2LkmiloQtMhabf
         HSHPdhJ9q1xYqC/OCSQrxN4ejLLVoweU9VrtHaPJbxbtP2Ta0MN3QCeFUb4NLiaFFFXq
         x12ibjxOV2j4Gkn42OKkAulNFJWVHpS82gGdauPVNoyL519ySgnpZvfVSqh/kZlchdYB
         4MSg==
X-Forwarded-Encrypted: i=1; AJvYcCUbOIImbnEzBbKtz8iRh5tKpJtjPJo+U6rDRDIqOd60EmYZlQTQzBgN694gx8/4j/BNeZ9ek08Fmjz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+58tTJkfR3mNshuUADgPJJtsefZY0F4lAmm2x6j4MN1a9a8I
	SnAt4ivcbs8JhwCgRyGKV9Crl+84g2tWraCj2joEs5aO1lMfqcg+BkXutxNPV4U=
X-Google-Smtp-Source: AGHT+IGFX+JpOuBNkuiqWpwqqojLsjyd0c1q3uUvAXvmTXay18Cll/dJEuA1ST8QE4ynzxsCiSRyHw==
X-Received: by 2002:a17:907:e8d:b0:a86:6e5e:620d with SMTP id a640c23a62f3a-a897f84d602mr429881266b.27.1725014334494;
        Fri, 30 Aug 2024 03:38:54 -0700 (PDT)
Received: from localhost (host-80-182-198-72.retail.telecomitalia.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892220e5sm197540666b.195.2024.08.30.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:38:54 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 30 Aug 2024 12:39:00 +0200
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
Subject: Re: [PATCH 07/11] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
Message-ID: <ZtGhRAnd0a_TFPEj@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <eb39a5f3cefff2a1240a18a255dac090af16f223.1724159867.git.andrea.porta@suse.com>
 <l4xijmtxz5i5kkkd5tt25ls33drnnhxp26r42lab5ev343e4zh@ctknkjzbpwqz>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l4xijmtxz5i5kkkd5tt25ls33drnnhxp26r42lab5ev343e4zh@ctknkjzbpwqz>

Hi Krzysztof,

On 10:45 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:09PM +0200, Andrea della Porta wrote:
> > The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
> > Add minimum support for the gpio only portion. The driver is in
> > pinctrl folder since upcoming patches will add the pinmux/pinctrl
> > support where the gpio part can be seen as an addition.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  MAINTAINERS                   |   1 +
> >  drivers/pinctrl/Kconfig       |  10 +
> >  drivers/pinctrl/Makefile      |   1 +
> >  drivers/pinctrl/pinctrl-rp1.c | 719 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 731 insertions(+)
> >  create mode 100644 drivers/pinctrl/pinctrl-rp1.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4ce7b049d67e..67f460c36ea1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19122,6 +19122,7 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
> >  F:	drivers/clk/clk-rp1.c
> > +F:	drivers/pinctrl/pinctrl-rp1.c
> >  F:	include/dt-bindings/clock/rp1.h
> >  F:	include/dt-bindings/misc/rp1.h
> >  
> > diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> > index 7e4f93a3bc7a..18bb1a8bd102 100644
> > --- a/drivers/pinctrl/Kconfig
> > +++ b/drivers/pinctrl/Kconfig
> > @@ -565,6 +565,16 @@ config PINCTRL_MLXBF3
> >  	  each pin. This driver can also be built as a module called
> >  	  pinctrl-mlxbf3.
> >  
> > +config PINCTRL_RP1
> > +	bool "Pinctrl driver for RP1"
> > +	select PINMUX
> > +	select PINCONF
> > +	select GENERIC_PINCONF
> > +	select GPIOLIB_IRQCHIP
> > +	help
> > +	  Enable the gpio and pinctrl/mux  driver for RaspberryPi RP1
> > +	  multi function device. 
> > +
> >  source "drivers/pinctrl/actions/Kconfig"
> >  source "drivers/pinctrl/aspeed/Kconfig"
> >  source "drivers/pinctrl/bcm/Kconfig"
> > diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> > index cc809669405a..f1ca23b563f6 100644
> > --- a/drivers/pinctrl/Makefile
> > +++ b/drivers/pinctrl/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
> >  obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
> >  obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
> >  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
> > +obj-$(CONFIG_PINCTRL_RP1)       += pinctrl-rp1.o
> >  obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
> >  obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
> >  obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
> > diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
> > new file mode 100644
> > index 000000000000..c035d2014505
> > --- /dev/null
> > +++ b/drivers/pinctrl/pinctrl-rp1.c
> > @@ -0,0 +1,719 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Raspberry Pi RP1 GPIO unit
> > + *
> > + * Copyright (C) 2023 Raspberry Pi Ltd.
> > + *
> > + * This driver is inspired by:
> > + * pinctrl-bcm2835.c, please see original file for copyright information
> > + */
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/bitops.h>
> > +#include <linux/bug.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdesc.h>
> > +#include <linux/init.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> 
> Half of these headers are not used. Drop them.

Ack.

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

