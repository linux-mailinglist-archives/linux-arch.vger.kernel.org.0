Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93F8EE67
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfHOOkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 10:40:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58126 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730084AbfHOOj7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Aug 2019 10:39:59 -0400
Received: (qmail 2273 invoked by uid 2102); 15 Aug 2019 10:39:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Aug 2019 10:39:58 -0400
Date:   Thu, 15 Aug 2019 10:39:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Christoph Hellwig <hch@lst.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
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
        Bin Liu <b-liu@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <iommu@lists.linux-foundation.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: next take at setting up a dma mask by default for platform
 devices
In-Reply-To: <20190815132531.GA12036@lst.de>
Message-ID: <Pine.LNX.4.44L0.1908151039260.1664-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 15 Aug 2019, Christoph Hellwig wrote:

> On Thu, Aug 15, 2019 at 03:23:18PM +0200, Greg Kroah-Hartman wrote:
> > I've taken the first 2 patches for 5.3-final.  Given that patch 3 needs
> > to be fixed, I'll wait for a respin of these before considering them.
> 
> I have a respun version ready, but I'd really like to hear some
> comments from usb developers about the approach before spamming
> everyone again..

I didn't see any problems with your approach at first glance; it looked 
like a good idea.

Alan Stern

