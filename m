Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE92F1E2485
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEZOww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 10:52:52 -0400
Received: from foss.arm.com ([217.140.110.172]:51792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgEZOwv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 10:52:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D055F30E;
        Tue, 26 May 2020 07:52:50 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BE253F7C3;
        Tue, 26 May 2020 07:52:47 -0700 (PDT)
Date:   Tue, 26 May 2020 15:52:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Message-ID: <20200526145244.GG17051@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-6-yezhenyu2@huawei.com>
 <20200522154254.GD26492@gaia>
 <ddba6d98-29b5-0748-ba74-ec022f509270@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddba6d98-29b5-0748-ba74-ec022f509270@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 25, 2020 at 03:19:42PM +0800, Zhenyu Ye wrote:
> On 2020/5/22 23:42, Catalin Marinas wrote:
> > On Thu, Apr 23, 2020 at 09:56:55PM +0800, Zhenyu Ye wrote:
> >> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> >> index 3d7c01e76efc..3eff199d3507 100644
> >> --- a/mm/pgtable-generic.c
> >> +++ b/mm/pgtable-generic.c
> >> @@ -101,6 +101,28 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
> >>  
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>  
> >> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >> +
> >> +#define FLUSH_Pxx_TLB_RANGE(_pxx)					\
> >> +void flush_##_pxx##_tlb_range(struct vm_area_struct *vma,		\
> >> +			      unsigned long addr, unsigned long end)	\
> >> +{									\
> >> +		struct mmu_gather tlb;					\
> >> +									\
> >> +		tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);		\
> >> +		tlb_start_vma(&tlb, vma);				\
> >> +		tlb_flush_##_pxx##_range(&tlb, addr, end - addr);	\
> >> +		tlb_end_vma(&tlb, vma);					\
> >> +		tlb_finish_mmu(&tlb, addr, end);			\
> >> +}
> > 
> > I may have confused myself (flush_p??_tlb_* vs. tlb_flush_p??_*) but do
> > actually need this whole tlb_gather thing here? IIUC (by grep'ing),
> > flush_p?d_tlb_range() is only called on huge pages, so we should know
> > the level already.
> 
> tlb_flush_##_pxx##_range() is used to set tlb->cleared_*,
> flush_##_pxx##_tlb_range() will actually flush the TLB entry.
> 
> In arch64, tlb_flush_p?d_range() is defined as:
> 
> 	#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> 	#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)

Currently, flush_p??_tlb_range() are generic and defined as above. I
think in the generic code they can remain an alias for
flush_tlb_range().

On arm64, we can redefine them as:

#define flush_pte_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 3)
#define flush_pmd_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 2)
#define flush_pud_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 1)
#define flush_p4d_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 0)

(unless the compiler optimises away all the mmu_gather stuff in your
macro above but they don't look trivial to me)

Also, I don't see the new flush_pte_* and flush_p4d_* macros used
anywhere and I don't think they are needed. The pte equivalent is
flush_tlb_page() (we need to make sure it's not used on a pmd in the
hugetlb context).

> So even if we know the level here, we can not pass the value to tlbi
> instructions (flush_tlb_range() is a common kernel interface and retro-fit it
> needs lots of changes), according to Peter's suggestion, I finally decide to
> pass the value of TTL by the tlb_gather_* frame.[1]

My comment was about the generic implementation using mmu_gather as you
are proposing. We don't need to change the flush_tlb_range() interface,
nor do we need to rewrite flush_p??_tlb_range().

-- 
Catalin
