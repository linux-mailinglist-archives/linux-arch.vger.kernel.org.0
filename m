Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A208167FEB
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgBUORC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 09:17:02 -0500
Received: from verein.lst.de ([213.95.11.211]:55676 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgBUORC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 09:17:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36BC968BFE; Fri, 21 Feb 2020 15:16:57 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:16:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: support setting memory uncached in
 place
Message-ID: <20200221141656.GF6968@lst.de>
References: <20200220170139.387354-1-hch@lst.de> <20200220170139.387354-2-hch@lst.de> <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502fa745-ddad-f91b-52bc-52edecf8fdbc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 05:21:35PM +0000, Robin Murphy wrote:
>> @@ -196,10 +192,15 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>>     	memset(ret, 0, size);
>>   -	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
>> -	    dma_alloc_need_uncached(dev, attrs)) {
>> +	if (dma_alloc_need_uncached(dev, attrs)) {
>>   		arch_dma_prep_coherent(page, size);
>> -		ret = uncached_kernel_address(ret);
>> +
>> +		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {
>> +			if (!arch_dma_set_uncached(ret, size))
>> +				goto out_free_pages;
>> +		} else if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT)) {
>> +			ret = uncached_kernel_address(ret);
>
> Hmm, would we actually need to keep ARCH_HAS_UNCACHED_SEGMENT? If 
> arch_dma_set_uncached() returned void*/ERR_PTR instead, then it could work 
> for both cases (with arch_dma_clear_uncached() being a no-op for segments).

Yes, I think so.  I was a little worried about what to do with
cached_kernel_address() in that scheme, but it turns out with the recent
round of dma-direct cleanup that is actually entirely unused now.
