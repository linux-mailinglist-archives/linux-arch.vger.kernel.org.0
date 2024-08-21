Return-Path: <linux-arch+bounces-6427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E695A339
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325321F22CF1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD118C01C;
	Wed, 21 Aug 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWI3DEoY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816A139597;
	Wed, 21 Aug 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259343; cv=none; b=q/kozjv73DoFoERTAtmZA3ZfkI97oQP4000lym4G0Q+q2noj30Vcq8XLBc3vEBjL8VPUGkt1f89RtvBrWJ7LV8OxvhjpeiU2uBr0Q5j46Jdy6HUugHL138t00l2xk3XuhpG2ZIwQOFJusUcZT4SFRUrdSGdp2DjRjRBW0hDQ5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259343; c=relaxed/simple;
	bh=8v5Y7+Bdr6Vrg6fg/jjVkWGIt4zD/dKPaTA7XMhn+n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DDzX0n+gBUyN6os7wqTGj43wtMx+q9CyBFXx4OkBgK+seH7L2ZPjkhqX3JYUKxfhP9MQJxrl8R0CvDnVncO1UaWuNLCdPDS0Mrl4lTElDmPJGSkPpKC+pdCZcvvDdWc1VmzehQrWqnp8t414wouWsgplg1acOO1frTk0PXKgQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWI3DEoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10041C32786;
	Wed, 21 Aug 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724259343;
	bh=8v5Y7+Bdr6Vrg6fg/jjVkWGIt4zD/dKPaTA7XMhn+n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UWI3DEoYXhlo5tEJ8+b6j2jglrtnyX7EMyzxBQALxCZIKK3Vv0INTGGsDg0AIv69+
	 dgiGf1Ndqkr6QIBOzlmEBV2saM1kC/PTaM2XyM1owiQqsS3DmG5j7ptA+pt6yZn0rT
	 bVQWFDEHzMQc/KqhtAKT+P2IYSaiwR3ritbtAxsLsU9KiSsFA479LcSG/bspzSQlnL
	 bQ23dcB92e9qtISrNTjWVChljaVmucocnYAFGkViVKxHEVMhyT8L5xb7rPvVD2RPSC
	 4Z+oJgI0Mzw41s+SeDEFxx3HsPTyi1kEsW+9eV/s4/h8WQV98g0lwy0pZxbI1dCYJg
	 9Y92grUkNfw5w==
Date: Wed, 21 Aug 2024 11:55:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <20240821165541.GA254124@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>

On Tue, Aug 20, 2024 at 04:36:10PM +0200, Andrea della Porta wrote:
> The RaspberryPi RP1 is ia PCI multi function device containing

s/ia/a/

> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.

Add blank lines between paragraphs.

> Implement a bare minimum driver to operate the RP1, leveraging
> actual OF based driver implementations for the on-borad peripherals

s/on-borad/on-board/

> by loading a devicetree overlay during driver probe.
> The peripherals are accessed by mapping MMIO registers starting
> from PCI BAR1 region.
> As a minimum driver, the peripherals will not be added to the
> dtbo here, but in following patches.

> +config MISC_RP1
> +        tristate "RaspberryPi RP1 PCIe support"
> +        depends on PCI && PCI_QUIRKS
> +        select OF
> +        select OF_OVERLAY
> +        select IRQ_DOMAIN
> +        select PCI_DYNAMIC_OF_NODES
> +        help
> +          Support for the RP1 peripheral chip found on Raspberry Pi 5 board.
> +          This device supports several sub-devices including e.g. Ethernet controller,
> +          USB controller, I2C, SPI and UART.
> +          The driver is responsible for enabling the DT node once the PCIe endpoint
> +          has been configured, and handling interrupts.
> +          This driver uses an overlay to load other drivers to support for RP1
> +          internal sub-devices.

s/support for/support/

Add blank lines between paragraphs.  Consider wrapping to fit in 80
columns.  Current width of 86 seems random.

> diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
> new file mode 100644
> index 000000000000..e83854b4ed2c
> --- /dev/null
> +++ b/drivers/misc/rp1/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +rp1-pci-objs			:= rp1-pci.o rp1-pci.dtbo.o
> +obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
> diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
> new file mode 100644
> index 000000000000..a6093ba7e19a
> --- /dev/null
> +++ b/drivers/misc/rp1/rp1-pci.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-22 Raspberry Pi Ltd.

s/22/24/ ?

> +#define RP1_B0_CHIP_ID		0x10001927
> +#define RP1_C0_CHIP_ID		0x20001927

Drop; both unused.

> +#define RP1_PLATFORM_ASIC	BIT(1)
> +#define RP1_PLATFORM_FPGA	BIT(0)

Drop; both unused.

> +#define RP1_SYSCLK_RATE		200000000
> +#define RP1_SYSCLK_FPGA_RATE	60000000

Drop; both unused.

> +enum {
> +	SYSINFO_CHIP_ID_OFFSET	= 0,
> +	SYSINFO_PLATFORM_OFFSET	= 4,
> +};

Drop; unused.

> +/* MSIX CFG registers start at 0x8 */

s/MSIX/MSI-X/

> +#define MSIX_CFG_TEST           BIT(1)

Unused.

> +#define INTSTATL		0x108
> +#define INTSTATH		0x10c

Drop; both unused.

> +static void dump_bar(struct pci_dev *pdev, unsigned int bar)
> +{
> +	dev_info(&pdev->dev,
> +		 "bar%d len 0x%llx, start 0x%llx, end 0x%llx, flags, 0x%lx\n",

%pR does most of this for you.

> +static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
> +{
> +	struct rp1_dev *rp1 = irqd->domain->host_data;
> +	unsigned int hwirq = (unsigned int)irqd->hwirq;
> +	int ret = 0;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		dev_dbg(rp1->dev, "MSIX IACK EN for irq %d\n", hwirq);
> +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] = true;
> +	break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> +		rp1->level_triggered_irq[hwirq] = false;
> +		break;
> +	default:
> +		ret = -EINVAL;

If you "return -EINVAL" directly here, I think you can drop "ret" and
just "return 0" below.

> +		break;
> +	}
> +
> +	return ret;
> +}

> +static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node,
> +			 const u32 *intspec, unsigned int intsize,
> +			 unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	struct rp1_dev *rp1 = d->host_data;
> +	struct irq_data *pcie_irqd;
> +	unsigned long hwirq;
> +	int pcie_irq;
> +	int ret;
> +
> +	ret = irq_domain_xlate_twocell(d, node, intspec, intsize,
> +				       &hwirq, out_type);
> +	if (!ret) {
> +		pcie_irq = pci_irq_vector(rp1->pdev, hwirq);
> +		pcie_irqd = irq_get_irq_data(pcie_irq);
> +		rp1->pcie_irqds[hwirq] = pcie_irqd;
> +		*out_hwirq = hwirq;
> +	}
> +
> +	return ret;

  if (ret)
    return ret;

  ...
  return 0;

would make this easier to read and unindent the normal path.

> +	rp1->bar1 = pci_iomap(pdev, 1, 0);

pcim_iomap()

> +	if (!rp1->bar1) {
> +		dev_err(&pdev->dev, "Cannot map PCI bar\n");

s/bar/BAR/

> +#define PCI_VENDOR_ID_RPI		0x1de4
> +#define PCI_DEVICE_ID_RP1_C0		0x0001

Device ID should include "RPI" as well.

