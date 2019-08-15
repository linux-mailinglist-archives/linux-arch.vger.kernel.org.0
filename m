Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44338EC48
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 15:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfHONDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 09:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732101AbfHOND3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:03:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2B2206C1;
        Thu, 15 Aug 2019 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565874207;
        bh=05FKrWR8u7yXNSzvDhK14jodYXXtJLhq05DEOB370o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwl+0uYfDOJT/3Ymv4Xv86Es37VhW5Szs/xP6ombz3PRSN6J0RcO0roRJ6TqaUrJ4
         WSmNGttTeaVHYBoDy9MKtrR1Llvej761IhslQEAv61f/O4h2cwf8/2SbbMxIjcxa/O
         n3hqpkpGHdq3IH3OCwePPEUClxHF6VmSJ+8p6W2E=
Date:   Thu, 15 Aug 2019 15:03:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olav Kongas <ok@artecdesign.ee>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
Message-ID: <20190815130325.GB17065@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
 <20190811080520.21712-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811080520.21712-7-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 11, 2019 at 10:05:20AM +0200, Christoph Hellwig wrote:
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/platform.c         | 15 +++++++++++++--
>  include/linux/platform_device.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index ec974ba9c0c4..b216fcb0a8af 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -264,6 +264,17 @@ struct platform_object {
>  	char name[];
>  };
>  
> +static void setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dma_mask)
> +		pdev->dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dma_mask;
> +	arch_setup_pdev_archdata(pdev);
> +};
> +
>  /**
>   * platform_device_put - destroy a platform device
>   * @pdev: platform device to free
> @@ -310,7 +321,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>  		pa->pdev.id = id;
>  		device_initialize(&pa->pdev.dev);
>  		pa->pdev.dev.release = platform_device_release;
> -		arch_setup_pdev_archdata(&pa->pdev);
> +		setup_pdev_archdata(&pa->pdev);
>  	}
>  
>  	return pa ? &pa->pdev : NULL;
> @@ -512,7 +523,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>  int platform_device_register(struct platform_device *pdev)
>  {
>  	device_initialize(&pdev->dev);
> -	arch_setup_pdev_archdata(pdev);
> +	setup_pdev_archdata(pdev);
>  	return platform_device_add(pdev);
>  }
>  EXPORT_SYMBOL_GPL(platform_device_register);
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 9bc36b589827..a2abde2aef25 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -24,6 +24,7 @@ struct platform_device {
>  	int		id;
>  	bool		id_auto;
>  	struct device	dev;
> +	u64		dma_mask;

Why is the dma_mask in 'struct device' which is part of this structure,
not sufficient here?  Shouldn't the "platform" be setting that up
correctly already in the "archdata" type callback?

confused,

greg k-h
