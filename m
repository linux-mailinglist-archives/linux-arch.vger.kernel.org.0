Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8399A16B361
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 22:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBXV5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 16:57:01 -0500
Received: from verein.lst.de ([213.95.11.211]:40500 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBXV5B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 16:57:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9FFA68B05; Mon, 24 Feb 2020 22:56:57 +0100 (CET)
Date:   Mon, 24 Feb 2020 22:56:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dma-direct: provide a arch_dma_clear_uncached hook
Message-ID: <20200224215657.GA12618@lst.de>
References: <20200224194446.690816-1-hch@lst.de> <20200224194446.690816-5-hch@lst.de> <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 01:53:28PM -0800, Ira Weiny wrote:
> > +	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> > +		arch_dma_clear_uncached(cpu_addr, size);
> 
> Isn't using arch_dma_clear_uncached() before patch 5 going to break
> bisectability?

Only if ARCH_HAS_DMA_CLEAR_UNCACHED is selected by anything, which
only happens in patch 5.
