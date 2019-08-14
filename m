Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF48D767
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNPtT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 11:49:19 -0400
Received: from foss.arm.com ([217.140.110.172]:56360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHNPtT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 11:49:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B2328;
        Wed, 14 Aug 2019 08:49:17 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A26C3F694;
        Wed, 14 Aug 2019 08:49:14 -0700 (PDT)
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>,
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
References: <20190811080520.21712-1-hch@lst.de>
 <20190811080520.21712-7-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fbea6e6d-7721-b51d-0501-582e8446e9c9@arm.com>
Date:   Wed, 14 Aug 2019 16:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190811080520.21712-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/08/2019 09:05, Christoph Hellwig wrote:
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize

s/object/device/

> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.

This would be a good point to also get rid of the long-standing bodge in 
platform_device_register_full().

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/base/platform.c         | 15 +++++++++++++--
>   include/linux/platform_device.h |  1 +
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index ec974ba9c0c4..b216fcb0a8af 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -264,6 +264,17 @@ struct platform_object {
>   	char name[];
>   };
>   
> +static void setup_pdev_archdata(struct platform_device *pdev)

Bikeshed: painting the generic DMA API properties as "archdata" feels a 
bit off-target :/

> +{
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dma_mask)
> +		pdev->dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dma_mask;
> +	arch_setup_pdev_archdata(pdev);

AFAICS m68k's implementation of that arch hook becomes entirely 
redundant after this change, so may as well go. That would just leave 
powerpc's actual archdata, which at a glance looks like it could 
probably be cleaned up with not *too* much trouble.

Robin.

> +};
> +
>   /**
>    * platform_device_put - destroy a platform device
>    * @pdev: platform device to free
> @@ -310,7 +321,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>   		pa->pdev.id = id;
>   		device_initialize(&pa->pdev.dev);
>   		pa->pdev.dev.release = platform_device_release;
> -		arch_setup_pdev_archdata(&pa->pdev);
> +		setup_pdev_archdata(&pa->pdev);
>   	}
>   
>   	return pa ? &pa->pdev : NULL;
> @@ -512,7 +523,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>   int platform_device_register(struct platform_device *pdev)
>   {
>   	device_initialize(&pdev->dev);
> -	arch_setup_pdev_archdata(pdev);
> +	setup_pdev_archdata(pdev);
>   	return platform_device_add(pdev);
>   }
>   EXPORT_SYMBOL_GPL(platform_device_register);
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 9bc36b589827..a2abde2aef25 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -24,6 +24,7 @@ struct platform_device {
>   	int		id;
>   	bool		id_auto;
>   	struct device	dev;
> +	u64		dma_mask;
>   	u32		num_resources;
>   	struct resource	*resource;
>   
> 
