Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE69A56E2
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2019 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfIBNBH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Sep 2019 09:01:07 -0400
Received: from verein.lst.de ([213.95.11.211]:50055 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbfIBNBG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Sep 2019 09:01:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E88568AFE; Mon,  2 Sep 2019 15:01:02 +0200 (CEST)
Date:   Mon, 2 Sep 2019 15:01:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, will@kernel.org,
        m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
        f.fainelli@gmail.com, frowand.list@gmail.com,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
        mbrugger@suse.com, eric@anholt.net, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, wahrenst@gmx.net,
        akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190902130101.GA2051@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-2-nsaenzjulienne@suse.de> <20190826070939.GD11331@lst.de> <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de> <20190830144536.GJ36992@arrakis.emea.arm.com> <bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 30, 2019 at 07:24:25PM +0200, Nicolas Saenz Julienne wrote:
> I'll be happy to implement it that way. I agree it's a good compromise.
> 
> @Christoph, do you still want the patch where I create 'zone_dma_bits'? With a
> hardcoded ZONE_DMA it's not absolutely necessary. Though I remember you said it
> was a first step towards being able to initialize dma-direct's min_mask in
> meminit.

I do like the variable better than the current #define.  I wonder if
really want a mask or a max_zone_dma_address like variable.  So for this
series feel free to drop the patch.   I'll see if I'll pick it up
later or if we can find some way to automatically propagate that
information from the zone initialization.
