Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2851175F21
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 17:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCBQFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 11:05:18 -0500
Received: from foss.arm.com ([217.140.110.172]:34664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCBQFS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC05FFEC;
        Mon,  2 Mar 2020 08:05:17 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8D23F534;
        Mon,  2 Mar 2020 08:05:13 -0800 (PST)
Subject: Re: provide in-place uncached remapping for dma-direct v2
To:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224194446.690816-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4fe14c57-78d4-6590-a4c4-14fbe061238e@arm.com>
Date:   Mon, 2 Mar 2020 16:05:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24/02/2020 7:44 pm, Christoph Hellwig wrote:
> Hi all,
> 
> this series provides support for remapping places uncached in-place in
> the generic dma-direct code, and moves openrisc over from its own
> in-place remapping scheme.  The arm64 folks also had interest in such
> a scheme to avoid problems with speculating into cache aliases.
> 
> Also all architectures that always use small page mappings for the
> kernel and have non-coherent DMA should look into enabling this
> scheme, as it is much more efficient than the vmap remapping.
> 
> Changes since v1:
>   - share the arch hook for inline remap and uncached segment support
> 

For the whole series:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I think we might ultimately want to fiddle around a bit more in 
dma_direct_alloc_pages() to give ARCH_HAS_DMA_SET_UNCACHED clear 
precedence over DMA_DIRECT_REMAP if they have to coexist, but let's land 
these patches first as a solid foundation.

Thanks,
Robin.
