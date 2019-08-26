Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066FB9C9D3
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfHZHGh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 03:06:37 -0400
Received: from verein.lst.de ([213.95.11.211]:46343 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfHZHGh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 03:06:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF05868B02; Mon, 26 Aug 2019 09:06:33 +0200 (CEST)
Date:   Mon, 26 Aug 2019 09:06:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, phill@raspberryi.org,
        f.fainelli@gmail.com, will@kernel.org, eric@anholt.net,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        akpm@linux-foundation.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
 dma-direct min mask
Message-ID: <20190826070633.GB11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-11-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-11-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
>  		arm64_dma_phys_limit = max_zone_dma_phys();
> +		zone_dma_bits = ilog2((arm64_dma_phys_limit - 1) & GENMASK_ULL(31, 0)) + 1;

This adds a way too long line.  I also find the use of GENMASK_ULL
horribly obsfucating, but I know that opinion is't shared by everyone.
