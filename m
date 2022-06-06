Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2C53EB72
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiFFQDC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiFFQDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:03:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6951050036
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 09:02:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19394D6E;
        Mon,  6 Jun 2022 09:02:58 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBE53F73B;
        Mon,  6 Jun 2022 09:02:55 -0700 (PDT)
Message-ID: <1a8cc7af-87ac-b0e7-7fb9-d11a5eebef55@arm.com>
Date:   Mon, 6 Jun 2022 17:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Content-Language: en-GB
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, mark.rutland@arm.com, hch@lst.de,
        vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
References: <20220606152150.GA31568@willie-the-truck>
 <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-06 16:35, Russell King (Oracle) wrote:
> On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
>>    (1) What if the DMA transfer doesn't write to every byte in the buffer?
> 
> The data that is in RAM gets pulled into the cache and is visible to
> the CPU - but if DMA doesn't write to every byte in the buffer, isn't
> that a DMA failure? Should a buffer that suffers DMA failure be passed
> to the user?

No, partial DMA writes can sometimes effectively be expected behaviour, 
see the whole SWIOTLB CVE fiasco for the most recent discussion on that:

https://lore.kernel.org/lkml/1812355.tdWV9SEqCh@natalenko.name/

>>    (2) What if the buffer has a virtual alias in userspace (e.g. because
>>        the kernel has GUP'd the buffer?
> 
> Then userspace needs to avoid writing to cachelines that overlap the
> buffer to avoid destroying the action of the DMA. It shouldn't be doing
> this anyway (what happens if userspace writes to the same location that
> is being DMA'd to... who wins?)
> 
> However, you're right that invalidating in this case could expose data
> that userspace shouldn't see, and I'd suggest in this case that DMA
> buffers should be cleaned in this circumstance before they're exposed
> to userspace - so userspace only ever gets to see the data that was
> there at the point they're mapped, or is subsequently written to
> afterwards by DMA.
> 
> I don't think there's anything to be worried about if the invalidation
> reveals stale data provided the stale data is not older than the data
> that was there on first mapping.

Indeed as above that may actually be required. I think cleaning the 
caches on dma_map_* is the most correct thing to do.

Robin.

>> Finally, on arm(64), the DMA mapping code tries to deal with buffers
>> that are not cacheline aligned by issuing clean-and-invalidate
>> operations for the overlapping portions at each end of the buffer. I
>> don't think this makes a tonne of sense, as inevitably one of the
>> writers (either the CPU or the DMA) is going to win and somebody is
>> going to run into silent data loss. Having the caller receive
>> DMA_MAPPING_ERROR in this case would probably be better.
> 
> Sadly unavoidable - people really like passing unaligned buffers to the
> DMA API, sometimes those buffers contain information that needs to be
> preserved. I really wish it wasn't that way, because it would make life
> a lot better, but it's what we've had to deal with over the years with
> the likes of the SCSI subsystem (and e.g. it's sense buffer that was
> embedded non-cacheline aligned into other structures that had to be
> DMA'd to.)
> 
