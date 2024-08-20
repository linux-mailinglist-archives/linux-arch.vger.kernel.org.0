Return-Path: <linux-arch+bounces-6382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C6958AE1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D491B236EA
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF91922E3;
	Tue, 20 Aug 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hs3bidrT"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D318EFC9;
	Tue, 20 Aug 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166861; cv=none; b=Q76dH/mz/52KHB2icfxxVP0lapQjT97WH5x07363QZrt6tbwUFV0SBS5fdP1xJJUtxqP40AcA3K7jTc8LxraA+hTrtQ2bOyhQ7Yj6j2ERwh2yTBy969cdR0E5I2+CfbE/OKr3zB67sBK3JfrV6s2l6yaxJyNgb/xVN2SkhJhTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166861; c=relaxed/simple;
	bh=HEp2O9Yg+xFVobpRrcPzfJ17tFgUBl3wrHGCOvMurYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Cia/EwPmrCFVj+7/pqRPoP5eFSjUmhLO+agMKXLAcCVzbnBpsZFSPSSqDpDWFtHeFnB25CyyI7dRXv0YDWoPjnAzZxRa++4DIiyCK9whqhyzMqtvNuxTyDxFn1wNqyMVaeMmk45hfqoEkYGUIBGnF/VTX+7AVIn2udtjXcWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hs3bidrT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mj0xb+mKKtlxydaY/lPIxOqJwc7T/yLIdICGlctTCsA=; b=hs3bidrTIdT3d9wsjsAk5IF+tP
	EhBSP23m2Zp5+ctd2b+yclSD9n2h/JqDGHeXAjvdLUnhRbi15qMm5yNb7m8b6ZCEdDQQpZD1TnIm0
	3KVPjhWYJFxfsO+eljPP2JOZVPYWTGDDYrMFFJRrPcq24qC9f4TtL8K0Ypiqj9MRIjBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgQYY-005Ew0-6K; Tue, 20 Aug 2024 17:13:58 +0200
Date: Tue, 20 Aug 2024 17:13:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
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
	Lee Jones <lee@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 10/11] net: macb: Add support for RP1's MACB variant
Message-ID: <c33fe03d-2097-4d26-b3db-8a3d6c793cd1@lunn.ch>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775000dfb3a35bc691010072942253cb022750e1.1724159867.git.andrea.porta@suse.com>

> +static unsigned int txdelay = 35;
> +module_param(txdelay, uint, 0644);

Networking does not like module parameters.

This is also unused in this patch! So i suggest you just delete it.

> +
>  /* This structure is only used for MACB on SiFive FU540 devices */
>  struct sifive_fu540_macb_mgmt {
>  	void __iomem *reg;
> @@ -334,7 +337,7 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
>  	u32 val;
>  
>  	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),
> -				  1, MACB_MDIO_TIMEOUT);
> +				  100, MACB_MDIO_TIMEOUT);
>  }
  
Please take this patch out of the series, and break it up. This is one
patch, with a good explanation why you need 1->100.

>  static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
> @@ -493,6 +496,19 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
>  	return status;
>  }
>  
> +static int macb_mdio_reset(struct mii_bus *bus)
> +{
> +	struct macb *bp = bus->priv;
> +
> +	if (bp->phy_reset_gpio) {
> +		gpiod_set_value_cansleep(bp->phy_reset_gpio, 1);
> +		msleep(bp->phy_reset_ms);
> +		gpiod_set_value_cansleep(bp->phy_reset_gpio, 0);
> +	}
> +
> +	return 0;
> +}
> +
>  static void macb_init_buffers(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> @@ -969,6 +985,7 @@ static int macb_mii_init(struct macb *bp)
>  	bp->mii_bus->write = &macb_mdio_write_c22;
>  	bp->mii_bus->read_c45 = &macb_mdio_read_c45;
>  	bp->mii_bus->write_c45 = &macb_mdio_write_c45;
> +	bp->mii_bus->reset = &macb_mdio_reset;

This is one patch.

>  	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
>  		 bp->pdev->name, bp->pdev->id);
>  	bp->mii_bus->priv = bp;
> @@ -1640,6 +1657,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
>  
>  		macb_init_rx_ring(queue);
>  		queue_writel(queue, RBQP, queue->rx_ring_dma);
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> +			macb_writel(bp, RBQPH,
> +				    upper_32_bits(queue->rx_ring_dma));
> +#endif

How does this affect a disto kernel? Do you actually need the #ifdef?
What does bp->hw_dma_cap contain when CONFIG_ARCH_DMA_ADDR_T_64BIT is
not defined?

Again, this should be a patch of its own, with a good commit message.

Interrupt coalescing should be a patch of its own, etc.

    Andrew

---
pw-bot: cr

