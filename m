Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4418ECBA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfHONZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 09:25:37 -0400
Received: from verein.lst.de ([213.95.11.211]:46679 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfHONZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:25:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5010F68AFE; Thu, 15 Aug 2019 15:25:31 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:25:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
Subject: Re: next take at setting up a dma mask by default for platform
 devices
Message-ID: <20190815132531.GA12036@lst.de>
References: <20190811080520.21712-1-hch@lst.de> <20190815132318.GA27208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815132318.GA27208@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 03:23:18PM +0200, Greg Kroah-Hartman wrote:
> I've taken the first 2 patches for 5.3-final.  Given that patch 3 needs
> to be fixed, I'll wait for a respin of these before considering them.

I have a respun version ready, but I'd really like to hear some
comments from usb developers about the approach before spamming
everyone again..
