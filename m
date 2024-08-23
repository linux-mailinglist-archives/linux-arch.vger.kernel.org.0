Return-Path: <linux-arch+bounces-6551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C29995CA63
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ACB1C243BA
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FA185B69;
	Fri, 23 Aug 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dSAVNjjj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030817ADFB
	for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408495; cv=none; b=KY0S601+GGJoRwozKeK0CDGnLEn/B3zD+1CpTeKPXe+TPHiwz3r87vzuaReqeDSYAt+0b5arlalrxaJNvXoUdj35YzHZzRlbgYXqFpc/bFU6UXEclpYOpseXasIFFOrXg45ZC+PLZuICBkQKB35trDWlINYfw+Fa08UwiMEttWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408495; c=relaxed/simple;
	bh=wDw2GrU+mZYcRmTdJ3qd7qyGbvFGP3vTu6hsDr93i3s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2mx6BUUCPWkDFUjXr9k58A6Kl1kZDqzIu9pizVKQ5j89FK4oStOt5gzzQBMO5eWG4f23t8uPJS9RFnvqyaqGi8T+pz1Z3tGYOu5JIMB/pVlXFa0G4StSw0BpSBxTJlHB4Y/hQY6LYCerjncsuco3q7Qt0QFlVTN78cpeCxi4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dSAVNjjj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8657900fc1so284852566b.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724408490; x=1725013290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy9tQ1TYcZbcuxiuWon4EXX8Ukt9Xc78KSZT2kpFAzw=;
        b=dSAVNjjj9V9KUVn2jvCxZfZAt/LqYbO24HHYYHwNhsE7z7K3sfXjgiuiTSSBvUsQxE
         jMe/3gyvIZWsn3QwqhqLQ0QxC6UQDb/HyYyYYd7RMXeC4GX+gWPGScTvXujcS+N46yE7
         bexwmWVwKj2A5JlpOdhPLuX8uxrn22D8rhm4N+mrQ1LYWs6jLeaEII5N7o+rkGqPX7Nh
         dWI37kup0B8XPBmSMb+hqFj233pyC8QnZP2KE2lhbcDg5aDWjiTir+2TVmmSM+EGqC92
         hZPYfrE4sO8UEFg7llX5mezmQXiND1uN4853HvqIMYHy/Zh/QlVMaKaJrZSNauZHDA2V
         aufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408490; x=1725013290;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy9tQ1TYcZbcuxiuWon4EXX8Ukt9Xc78KSZT2kpFAzw=;
        b=jB7BwSbkJJcrGd5r3fOuHBy7PtWKezXF/rue5Qqvy3Femk29vBlFyN5IOdnB0x0d0N
         DQZocJNfoBZNFNtZh8Tn/dlKjnJnAJlyxg+1M+9NcMV+Oi2b7jwrVIrKMTI2/Nx3z5rC
         iFcyVcm7Sh30H15TxhrBBBROqiMf614y0qMbCM4yxQ5+0wZZTyeF1oUmSl/6DkHX6RJa
         WFP0OreSZB9HqI/DgsBLm+yEds5OTkHhQo+413TcNQNSTSUvaQY20AY194bBEO6jm1xE
         kndpQ17L8efQDToFOPvXVdPfSOl8WCbraI8aso3qNqsCbMtcoN1cs1E0A00umJ+FWxDU
         m8qg==
X-Forwarded-Encrypted: i=1; AJvYcCV6tBbMdrNXteGCNMpIbmsY5RwSEuHde5Zq9iDRc6RMQs7MAFOWB3tvKNJxg+dj+IEV0q3kaQPS7ntN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WsQbmBxvIm1DF9nYdK2ruJI6X0keZB9V8p5DPUZ6aEjBfuNW
	mUPeTlk6zW5rfVDcThSiBoNwX4sySHSdUSkjoq+P3h6nPvppBYLLwEZeitC505U=
X-Google-Smtp-Source: AGHT+IEsqzlf61vWm+813vG7vMkMePBztenb+9XkV5XyCVO9mztSFfT2RcUPMSZK6WV+NNZgP3DJpQ==
X-Received: by 2002:a17:907:7e95:b0:a86:94e2:2a47 with SMTP id a640c23a62f3a-a86a51b24b5mr152679166b.15.1724408490036;
        Fri, 23 Aug 2024 03:21:30 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436322sm240714966b.117.2024.08.23.03.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:21:29 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 23 Aug 2024 12:21:36 +0200
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZshisKww97hhGh-Y@apocalypse>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
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
References: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
 <20240821165541.GA254124@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821165541.GA254124@bhelgaas>

On 11:55 Wed 21 Aug     , Bjorn Helgaas wrote:
> On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> > The RaspberryPi RP1 is ia PCI multi function device containing
> 
> s/ia/a/
> 
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.
> 
> Add blank lines between paragraphs.
> 
> > Implement a bare minimum driver to operate the RP1, leveraging
> > actual OF based driver implementations for the on-borad peripherals
> 
> s/on-borad/on-board/
> 
> > by loading a devicetree overlay during driver probe.
> > The peripherals are accessed by mapping MMIO registers starting
> > from PCI BAR1 region.
> > As a minimum driver, the peripherals will not be added to the
> > dtbo here, but in following patches.
> 
> > +config MISC_RP1
> > +        tristate "RaspberryPi RP1 PCIe support"
> > +        depends on PCI && PCI_QUIRKS
> > +        select OF
> > +        select OF_OVERLAY
> > +        select IRQ_DOMAIN
> > +        select PCI_DYNAMIC_OF_NODES
> > +        help
> > +          Support for the RP1 peripheral chip found on Raspberry Pi 5 board.
> > +          This device supports several sub-devices including e.g. Ethernet controller,
> > +          USB controller, I2C, SPI and UART.
> > +          The driver is responsible for enabling the DT node once the PCIe endpoint
> > +          has been configured, and handling interrupts.
> > +          This driver uses an overlay to load other drivers to support for RP1
> > +          internal sub-devices.
> 
> s/support for/support/
> 
> Add blank lines between paragraphs.  Consider wrapping to fit in 80
> columns.  Current width of 86 seems random.
> 
> > diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> > new file mode 100644
> > index 000000000000..e83854b4ed2c
> > --- /dev/null
> > +++ b/drivers/misc/rp1/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +rp1-pci-objs			:= rp1-pci.o rp1-pci.dtbo.o
> > +obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
> > diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
> > new file mode 100644
> > index 000000000000..a6093ba7e19a
> > --- /dev/null
> > +++ b/drivers/misc/rp1/rp1-pci.c
> > @@ -0,0 +1,333 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018-22 Raspberry Pi Ltd.
> 
> s/22/24/ ?
> 
> > +#define RP1_B0_CHIP_ID		0x10001927
> > +#define RP1_C0_CHIP_ID		0x20001927
> 
> Drop; both unused.
> 
> > +#define RP1_PLATFORM_ASIC	BIT(1)
> > +#define RP1_PLATFORM_FPGA	BIT(0)
> 
> Drop; both unused.
> 
> > +#define RP1_SYSCLK_RATE		200000000
> > +#define RP1_SYSCLK_FPGA_RATE	60000000
> 
> Drop; both unused.
> 
> > +enum {
> > +	SYSINFO_CHIP_ID_OFFSET	= 0,
> > +	SYSINFO_PLATFORM_OFFSET	= 4,
> > +};
> 
> Drop; unused.
> 
> > +/* MSIX CFG registers start at 0x8 */
> 
> s/MSIX/MSI-X/
> 
> > +#define MSIX_CFG_TEST           BIT(1)
> 
> Unused.
> 
> > +#define INTSTATL		0x108
> > +#define INTSTATH		0x10c
> 
> Drop; both unused.
> 
> > +static void dump_bar(struct pci_dev *pdev, unsigned int bar)
> > +{
> > +	dev_info(&pdev->dev,
> > +		 "bar%d len 0x%llx, start 0x%llx, end 0x%llx, flags, 0x%lx\n",
> 
> %pR does most of this for you.
> 
> > +static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
> > +{
> > +	struct rp1_dev *rp1 = irqd->domain->host_data;
> > +	unsigned int hwirq = (unsigned int)irqd->hwirq;
> > +	int ret = 0;
> > +
> > +	switch (type) {
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		dev_dbg(rp1->dev, "MSIX IACK EN for irq %d\n", hwirq);
> > +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> > +		rp1->level_triggered_irq[hwirq] = true;
> > +	break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> > +		rp1->level_triggered_irq[hwirq] = false;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> 
> If you "return -EINVAL" directly here, I think you can drop "ret" and
> just "return 0" below.
> 
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> > +static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node,
> > +			 const u32 *intspec, unsigned int intsize,
> > +			 unsigned long *out_hwirq, unsigned int *out_type)
> > +{
> > +	struct rp1_dev *rp1 = d->host_data;
> > +	struct irq_data *pcie_irqd;
> > +	unsigned long hwirq;
> > +	int pcie_irq;
> > +	int ret;
> > +
> > +	ret = irq_domain_xlate_twocell(d, node, intspec, intsize,
> > +				       &hwirq, out_type);
> > +	if (!ret) {
> > +		pcie_irq = pci_irq_vector(rp1->pdev, hwirq);
> > +		pcie_irqd = irq_get_irq_data(pcie_irq);
> > +		rp1->pcie_irqds[hwirq] = pcie_irqd;
> > +		*out_hwirq = hwirq;
> > +	}
> > +
> > +	return ret;
> 
>   if (ret)
>     return ret;
> 
>   ...
>   return 0;
> 
> would make this easier to read and unindent the normal path.
> 
> > +	rp1->bar1 = pci_iomap(pdev, 1, 0);
> 
> pcim_iomap()
> 
> > +	if (!rp1->bar1) {
> > +		dev_err(&pdev->dev, "Cannot map PCI bar\n");
> 
> s/bar/BAR/
> 
> > +#define PCI_VENDOR_ID_RPI		0x1de4
> > +#define PCI_DEVICE_ID_RP1_C0		0x0001
> 
> Device ID should include "RPI" as well.

Ack to all suggestions. Fixed in the next release, thanks.

Andrea

