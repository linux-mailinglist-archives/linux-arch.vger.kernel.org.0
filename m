Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9416B080
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 20:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBXTpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 14:45:35 -0500
Received: from verein.lst.de ([213.95.11.211]:40011 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgBXTpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 14:45:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E85268B05; Mon, 24 Feb 2020 20:45:29 +0100 (CET)
Date:   Mon, 24 Feb 2020 20:45:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200224194528.GA10155@lst.de>
References: <20200220170139.387354-1-hch@lst.de> <20200220170139.387354-3-hch@lst.de> <20200221221447.GA7926@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221221447.GA7926@lianli.shorne-pla.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 22, 2020 at 07:14:47AM +0900, Stafford Horne wrote:
> On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> > Switch openrisc to use the dma-direct allocator and just provide the
> > hooks for setting memory uncached or cached.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Stafford Horne <shorne@gmail.com>
> 
> Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
> continuing to shrink my code base.

I just resent a new version that changes how the hooks work based on
feedback from Robin.  Everything should work as-is, but if you have
some time to retest that would be great.
