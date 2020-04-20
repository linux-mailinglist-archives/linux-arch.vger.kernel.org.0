Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEB1B08E4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Apr 2020 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDTMJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726585AbgDTMJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 08:09:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E1C061A0C;
        Mon, 20 Apr 2020 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/w/fdWIc8B/K5nT4P8/UgmLyZd29J0YqIbnVwjY21s=; b=p+JxAa3U1CC19AXNdu/BH6UKzT
        1q7bSOFDOCwo2MSYzmwDrR1nxzUJ5iaeaejdk8ebifXLpcWvIdj84wAekYtOu08W2zqTbLG5O0ycX
        U7cxXLa9eJLcwQG+48ymcIeWndR1kYb87XpKV4dUHK1Bw44WQSItD4SmKo89ou6lE4CVTb5vcfRjj
        vF1WtzxZRJyLQzPjGc00Ihbqfme0GHO3+ickvSm5IXmN7WccTA9LMCUpMeCIihzuhh3fIEnDByvk/
        7oo8jr/DPu6lmDLfJkk2lVyqt0YaQJezJYsVwocQZKg6J1+sHf5Y4ewPqSViS7luzhz/HFm0H7gmz
        MKNPdI6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQVEl-0006YO-Da; Mon, 20 Apr 2020 12:09:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 840AE3010BC;
        Mon, 20 Apr 2020 14:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 492392B8DAF90; Mon, 20 Apr 2020 14:09:16 +0200 (CEST)
Date:   Mon, 20 Apr 2020 14:09:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v1 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Message-ID: <20200420120916.GE20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-6-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-6-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 05:00:47PM +0800, Zhenyu Ye wrote:
> This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
> code, which are expressed through the mmu_gather APIs.  These
> interface set tlb->cleared_* and finally call tlb_flush(), so we
> can do the tlb invalidation according to the information in
> struct mmu_gather.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  include/asm-generic/pgtable.h | 12 +++++++--
>  mm/pgtable-generic.c          | 50 +++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..2bedeee94131 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1160,11 +1160,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>   * invalidate the entire TLB which is not desitable.
>   * e.g. see arch/arc: flush_pmd_tlb_range
>   */
> -#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> -#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> +extern void flush_pte_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_pmd_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_pud_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
> +extern void flush_p4d_tlb_range(struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end);
>  #else
> +#define flush_pte_tlb_range(vma, addr, end)	BUILD_BUG()
>  #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
>  #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
> +#define flush_p4d_tlb_range(vma, addr, end)	BUILD_BUG()
>  #endif
>  #endif

Ideally you'd make __HAVE_ARCH_FLUSH_PMD_TLB_RANGE go away. Power
certainly doesnt need it with the below.

> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 3d7c01e76efc..0f5414a4a2ec 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -101,6 +101,56 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  
> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> +void flush_pte_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pte_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_pmd_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pmd_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_pud_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_pud_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +
> +void flush_p4d_tlb_range(struct vm_area_struct *vma,
> +			 unsigned long addr, unsigned long end)
> +{
> +	struct mmu_gather tlb;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> +	tlb_start_vma(&tlb, vma);
> +	tlb_set_p4d_range(&tlb, addr, end - addr);
> +	tlb_end_vma(&tlb, vma);
> +	tlb_finish_mmu(&tlb, addr, end);
> +}
> +#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */

You're nowhere near lazy enough:

#define FLUSH_Pxx_TLB_RANGE(_pxx) \
void flush_##_pxx##_tlb_range(struct vm_area_struct *vma, \
			      unsigned long addr, unsigned long end) \
{ \
	struct mmu_gather tlb; \
	\
	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end); \
	tlb_start_vma(&tlb, vma); \
	tlb_flush_##_pxx##_range(&tlb, addr, end-addr); \
	tlb_end_vma(&tlb, vma); \
	tlb_finish_mmu(&tlb, addr, end); \
}

FLUSH_Pxx_TLB_RANGE(pte)
FLUSH_Pxx_TLB_RANGE(pmd)
FLUSH_Pxx_TLB_RANGE(pud)
FLUSH_Pxx_TLB_RANGE(p4d)

