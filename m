Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B71C19995B
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgCaPO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 11:14:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48556 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgCaPO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Mar 2020 11:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gs4vlKPZRmw6qFabLUGpmw6ZvJFAEDHERKrZ05UnbXI=; b=cI8UDinCIjHhBUM7gNxhf5vRms
        cDTicfYolmv/c0bZH8cGFnbQRbx17eFa0uts3MeYMg9QaY+nyYLCsW+WQUkxLA/ayUbd6WOPzWMQf
        VgdjmBCX6+RsOkeO9WnEN3FadbthWqUYQG01MUHCkmM0V/gwFjBYzCk29WoWajEFtkYVVFLiploTP
        yM2PheLqf6TCyZ6iLm1KpwtLTH2gSCjCp1t2B0c+bw4vlkjLDQwjJi2v0EAL5kY/iw0n+OZV8+OP1
        xWxGV7fHID/P/ZTXaO5QZeO/rrz9YmBWTY6EFaKc88NPDQpC6J/h3QH/6hd4Kw5kXUHg482qcP3tE
        e0Eo5trw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIa7-0005Kb-Q4; Tue, 31 Mar 2020 15:13:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B907B30477A;
        Tue, 31 Mar 2020 17:13:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 714FD29D71B7B; Tue, 31 Mar 2020 17:13:31 +0200 (CEST)
Date:   Tue, 31 Mar 2020 17:13:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com, corbet@lwn.net,
        vgupta@synopsys.com, tony.luck@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
Message-ID: <20200331151331.GS20730@hirez.programming.kicks-ass.net>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331142927.1237-5-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 31, 2020 at 10:29:23PM +0800, Zhenyu Ye wrote:
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..32d4661e5a56 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1160,10 +1160,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>   * invalidate the entire TLB which is not desitable.
>   * e.g. see arch/arc: flush_pmd_tlb_range
>   */
> -#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> +#define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
>  #define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>  #else
> -#define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
> +#define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
>  #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
>  #endif
>  #endif
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 3d7c01e76efc..96c9cf77bfb5 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -109,8 +109,14 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
>  	int changed = !pmd_same(*pmdp, entry);
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  	if (changed) {
> +		struct mmu_gather tlb;
> +		unsigned long tlb_start = address;
> +		unsigned long tlb_end = address + HPAGE_PMD_SIZE;
>  		set_pmd_at(vma->vm_mm, address, pmdp, entry);
> -		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
> +		tlb.cleared_pmds = 1;
> +		flush_pmd_tlb_range(&tlb, vma, tlb_start, tlb_end);
> +		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
>  	}
>  	return changed;
>  }

This is madness. Please, carefully consider what you just wrote and what
it will do in the generic case.

Instead of trying to retro-fit flush_*tlb_range() to take an mmu_gather
parameter, please replace them out-right.

