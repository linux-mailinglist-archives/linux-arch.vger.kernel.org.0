Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD899A2E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfHVRLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 13:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389135AbfHVRLJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Aug 2019 13:11:09 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821062089E;
        Thu, 22 Aug 2019 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493868;
        bh=Eu5zYHsgZr/DzgkYZtrV8Xf3yPbZrB6F/5Aa3SVutiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgpviCCuEYOqne1wsEWgd6l+Gzkw+5xYBwggmYQtDll2PjCPqB1qmScWDXN1P/B5K
         B/RNg/icssWR6AjcDPdeqSlGGxWCAS2rl4YBtOQnalt5AVfZm3e4ze3if6d5gFRY2x
         +KvCpV/lo8jNDpZObQ1PLinLdtTKiva/GCEIEsL4=
Date:   Thu, 22 Aug 2019 10:11:08 -0700
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
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next take at setting up a dma mask by default for platform
 devices v2
Message-ID: <20190822171108.GA17471@kroah.com>
References: <20190816062435.881-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816062435.881-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 16, 2019 at 08:24:29AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is another attempt to make sure the dma_mask pointer is always
> initialized for platform devices.  Not doing so lead to lots of
> boilerplate code, and makes platform devices different from all our
> major busses like PCI where we always set up a dma_mask.  In the long
> run this should also help to eventually make dma_mask a scalar value
> instead of a pointer and remove even more cruft.
> 
> The bigger blocker for this last time was the fact that the usb
> subsystem uses the presence or lack of a dma_mask to check if the core
> should do dma mapping for the driver, which is highly unusual.  So we
> fix this first.  Note that this has some overlap with the pending
> desire to use the proper dma_mmap_coherent helper for mapping usb
> buffers.  The first two patches have already been queued up by Greg
> and are only included for completeness.

Note to everyone.  The first two patches in this series is already in
5.3-rc5.

I've applied the rest of the series to my usb-next branch (with the 6th
patch landing there later today.)  They are scheduled to be merge to
Linus in 5.4-rc1.

Christoph, thanks so much for these cleanups.

greg k-h
