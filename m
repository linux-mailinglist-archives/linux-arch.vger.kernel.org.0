Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF39C9E2
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfHZHJo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 03:09:44 -0400
Received: from verein.lst.de ([213.95.11.211]:46394 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbfHZHJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 03:09:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B04E568B02; Mon, 26 Aug 2019 09:09:39 +0200 (CEST)
Date:   Mon, 26 Aug 2019 09:09:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, phill@raspberryi.org,
        f.fainelli@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190826070939.GD11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> Some architectures have platform specific DMA addressing limitations.
> This will allow for hardware description code to provide the constraints
> in a generic manner, so as for arch code to properly setup it's memory
> zones and DMA mask.

I know this just spreads the arm code, but I still kinda hate it.

MAX_DMA_ADDRESS is such an oddly defined concepts.  We have the mm
code that uses it to start allocating after the dma zones, but
I think that would better be done using a function returning
1 << max(zone_dma_bits, 32) or so.  Then we have about a handful
of drivers using it that all seem rather bogus, and one of which
I think are usable on arm64.
