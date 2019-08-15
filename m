Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA08EDA7
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfHOOFT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 10:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732211AbfHOOFT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 10:05:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171BD20644;
        Thu, 15 Aug 2019 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565877918;
        bh=lOyzTACCHACUENr3Alx4Ml7IiaPxhwyXrxfcBKWNBJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtMKB3MHNCBeXVQklF3aBuT4nPDLyDVWODXEgp48SJZXXqW5ovAbc9FVn+3tX8FKE
         pR1oRIblVReZKrtntkhiaZUu9/e7AjwFuaI4yblInt8eTNK1NW/ZB7XjP4YTtW5VlW
         eNlY1nowm+mCe1y3E25iAZAab2798Rbm62UuKYmw=
Date:   Thu, 15 Aug 2019 16:05:16 +0200
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
Message-ID: <20190815140516.GB7174@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
 <20190811080520.21712-7-hch@lst.de>
 <20190815130325.GB17065@kroah.com>
 <20190815133812.GF12036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815133812.GF12036@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 03:38:12PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 03:03:25PM +0200, Greg Kroah-Hartman wrote:
> > > --- a/include/linux/platform_device.h
> > > +++ b/include/linux/platform_device.h
> > > @@ -24,6 +24,7 @@ struct platform_device {
> > >  	int		id;
> > >  	bool		id_auto;
> > >  	struct device	dev;
> > > +	u64		dma_mask;
> > 
> > Why is the dma_mask in 'struct device' which is part of this structure,
> > not sufficient here?  Shouldn't the "platform" be setting that up
> > correctly already in the "archdata" type callback?
> 
> Becaus the dma_mask in struct device is a pointer that needs to point
> to something, and this is the best space we can allocate for 'something'.
> m68k and powerpc currently do something roughly equivalent at the moment,
> while everyone else just has horrible, horrible hacks.  As mentioned in
> the changelog the intent of this patch is that we treat platform devices
> like any other bus, where the bus allocates the space for the dma_mask.
> The long term plan is to eventually kill that weird pointer indirection
> that doesn't help anyone, but for that we need to sort out the basics
> first.

Ah, missed that, sorry.  Ok, no objection from me.  Might as well respin
this series and I can queue it up after 5.3-rc5 is out (which will have
your first 2 patches in it.)

thanks,

greg k-h
