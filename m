Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763398ECE3
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfHONcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 09:32:13 -0400
Received: from verein.lst.de ([213.95.11.211]:46747 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbfHONcM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:32:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA62D68BFE; Thu, 15 Aug 2019 15:32:04 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:32:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>,
        Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Geoff Levand <geoff@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-usb@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
        iommu@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>, Bin Liu <b-liu@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
Message-ID: <20190815133204.GD12036@lst.de>
References: <20190811080520.21712-1-hch@lst.de> <20190811080520.21712-7-hch@lst.de> <fbea6e6d-7721-b51d-0501-582e8446e9c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbea6e6d-7721-b51d-0501-582e8446e9c9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 14, 2019 at 04:49:13PM +0100, Robin Murphy wrote:
>> because we have to support platform_device structures that are
>> statically allocated.
>
> This would be a good point to also get rid of the long-standing bodge in 
> platform_device_register_full().

platform_device_register_full looks odd to start with, especially
as the coumentation is rather lacking..

>>   +static void setup_pdev_archdata(struct platform_device *pdev)
>
> Bikeshed: painting the generic DMA API properties as "archdata" feels a bit 
> off-target :/
>
>> +{
>> +	if (!pdev->dev.coherent_dma_mask)
>> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +	if (!pdev->dma_mask)
>> +		pdev->dma_mask = DMA_BIT_MASK(32);
>> +	if (!pdev->dev.dma_mask)
>> +		pdev->dev.dma_mask = &pdev->dma_mask;
>> +	arch_setup_pdev_archdata(pdev);
>
> AFAICS m68k's implementation of that arch hook becomes entirely redundant 
> after this change, so may as well go. That would just leave powerpc's 
> actual archdata, which at a glance looks like it could probably be cleaned 
> up with not *too* much trouble.

Actually I think we can just kill both off.  At the point archdata
is indeed entirely misnamed.
