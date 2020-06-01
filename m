Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8491EA32B
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAL4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 07:56:52 -0400
Received: from foss.arm.com ([217.140.110.172]:37388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFAL4w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 07:56:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BDFE55D;
        Mon,  1 Jun 2020 04:56:51 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291A23F52E;
        Mon,  1 Jun 2020 04:56:48 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:56:45 +0100
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
Message-ID: <20200601115644.GA23419@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-6-yezhenyu2@huawei.com>
 <20200522154254.GD26492@gaia>
 <ddba6d98-29b5-0748-ba74-ec022f509270@huawei.com>
 <20200526145244.GG17051@gaia>
 <0c6f79e4-f29a-d373-2e43-c4f87cf78b49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6f79e4-f29a-d373-2e43-c4f87cf78b49@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Zhenyu,

On Sat, May 30, 2020 at 06:24:21PM +0800, Zhenyu Ye wrote:
> On 2020/5/26 22:52, Catalin Marinas wrote:
> > On Mon, May 25, 2020 at 03:19:42PM +0800, Zhenyu Ye wrote:
> >> tlb_flush_##_pxx##_range() is used to set tlb->cleared_*,
> >> flush_##_pxx##_tlb_range() will actually flush the TLB entry.
> >>
> >> In arch64, tlb_flush_p?d_range() is defined as:
> >>
> >> 	#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> >> 	#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> > 
> > Currently, flush_p??_tlb_range() are generic and defined as above. I
> > think in the generic code they can remain an alias for
> > flush_tlb_range().
> > 
> > On arm64, we can redefine them as:
> > 
> > #define flush_pte_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 3)
> > #define flush_pmd_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 2)
> > #define flush_pud_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 1)
> > #define flush_p4d_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 0)
> > 
> > (unless the compiler optimises away all the mmu_gather stuff in your
> > macro above but they don't look trivial to me)
> 
> I changed generic code before considering that other structures may also
> use this feature, such as Power9. And Peter may want to replace all
> flush_tlb_range() by tlb_flush() in the future, see [1] for details.
> 
> If only enable this feature on aarch64, your codes are better.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200402163849.GM20713@hirez.programming.kicks-ass.net/

But we change the semantics slightly if we implement these as
mmu_gather. For example, tlb_end_vma() -> tlb_flush_mmu_tlbonly() ends
up calling mmu_notifier_invalidate_range() which it didn't before. I
think we end up invoking the notifier unnecessarily in some cases (see
the comment in __split_huge_pmd()) or we end up calling the notifier
twice (e.g. pmdp_huge_clear_flush_notify()).

> > Also, I don't see the new flush_pte_* and flush_p4d_* macros used
> > anywhere and I don't think they are needed. The pte equivalent is
> > flush_tlb_page() (we need to make sure it's not used on a pmd in the
> > hugetlb context).
> 
> flush_tlb_page() is used to flush only one page.  If we add the
> flush_pte_tlb_range(), then we can use it to flush a range of pages in
> the future.

If we know flush_tlb_page() is only called on a small page, could we add
TTL information here as well?

> But flush_pte_* and flush_p4d_* macros are really not used anywhere. I
> will remove them in next version of series, and add them if someone
> needs.

I think it makes sense.

-- 
Catalin
