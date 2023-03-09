Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE76B2260
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 12:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCILOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 06:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCILN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 06:13:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 742A8E7C89;
        Thu,  9 Mar 2023 03:09:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4F04C14;
        Thu,  9 Mar 2023 03:09:49 -0800 (PST)
Received: from [10.1.27.175] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51BF3F67D;
        Thu,  9 Mar 2023 03:09:05 -0800 (PST)
Message-ID: <5e2f8747-cff8-08ac-7280-f8978cbf56a8@arm.com>
Date:   Thu, 9 Mar 2023 11:09:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/34] New page table range API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230228213738.272178-1-willy@infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28/02/2023 21:37, Matthew Wilcox (Oracle) wrote:
> This patchset changes the API used by the MM to set up page table entries.
> The four APIs are:
>     set_ptes(mm, addr, ptep, pte, nr)
>     update_mmu_cache_range(vma, addr, ptep, nr)
>     flush_dcache_folio(folio)
>     flush_icache_pages(vma, page, nr)
> 
> flush_dcache_folio() isn't technically new, but no architecture
> implemented it, so I've done that for you.  The old APIs remain around
> but are mostly implemented by calling the new interfaces.
> 
> The new APIs are based around setting up N page table entries at once.
> The N entries belong to the same PMD, the same folio and the same VMA,
> so ptep++ is a legitimate operation, and locking is taken care of for
> you.  Some architectures can do a better job of it than just a loop,
> but I have hesitated to make too deep a change to architectures I don't
> understand well.
> 
> One thing I have changed in every architecture is that PG_arch_1 is now a
> per-folio bit instead of a per-page bit.  This was something that would
> have to happen eventually, and it makes sense to do it now rather than
> iterate over every page involved in a cache flush and figure out if it
> needs to happen.
> 
> The point of all this is better performance, and Fengwei Yin has
> measured improvement on x86.  I suspect you'll see improvement on
> your architecture too.  Try the new will-it-scale test mentioned here:
> https://lore.kernel.org/linux-mm/20230206140639.538867-5-fengwei.yin@intel.com/
> You'll need to run it on an XFS filesystem and have
> CONFIG_TRANSPARENT_HUGEPAGE set.
> 
> For testing, I've only run the code on x86.  If an x86->foo compiler
> exists in Debian, I've built defconfig.  I'm relying on the buildbots
> to tell me what I missed, and people who actually have the hardware to
> tell me if it actually works.
> 
> I'd like to get this into the MM tree soon after the current merge window
> closes, so quick feedback would be appreciated.

I've boot-tested the series (with the Yin's typo fix for patch 32) on arm64 FVP
and Ampere Altra. On the Altra, I also ran page_fault4 from will-it-scale, and
see ~35% improvement from this series. So:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks,
Ryan

