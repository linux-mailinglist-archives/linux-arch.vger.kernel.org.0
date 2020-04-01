Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4895C19AB8D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Apr 2020 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbgDAMUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Apr 2020 08:20:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbgDAMUg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2020 08:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h43kxp2WKc0wYft7FpSc0v72+8FHHE+TenKvMgFBfeU=; b=VkRyrz6EwfCDFollnuhikXn8Zt
        Si+izd5tkkpUlf8ZRvp3qh+if/KWKV1o7Lpv2teeCvRo6AS4/ex8XA8Iwwikeea4QeEI2rAvnQ70/
        dyxYFNr16SdTxTjnsJVqyT2UPO2oijT/A8QW+YVEJRP40rXGadPGBunTdOJuANsvxy6fl8grr0/JE
        BAllE99dz8kSTIzixg2TwLmhFKfTGHX27owObq5FYoiIYFJYZmXyYulYPs3gh9t//U3WhkAd8HurT
        ZZS87Xil3/j3A7f81y5FVIvFWn6Y9yEkblrIONEOZytfWbGku7swPijNwk/DlAY9mxSpe0ebwPKiW
        XSnBVtlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJcLn-0005zJ-TY; Wed, 01 Apr 2020 12:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B47C2301631;
        Wed,  1 Apr 2020 14:20:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FD8929E261CB; Wed,  1 Apr 2020 14:20:04 +0200 (CEST)
Date:   Wed, 1 Apr 2020 14:20:04 +0200
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
Message-ID: <20200401122004.GE20713@hirez.programming.kicks-ass.net>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
 <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 01, 2020 at 04:51:15PM +0800, Zhenyu Ye wrote:
> On 2020/3/31 23:13, Peter Zijlstra wrote:

> > Instead of trying to retro-fit flush_*tlb_range() to take an mmu_gather
> > parameter, please replace them out-right.
> > 
> 
> I'm sorry that I'm not sure what "replace them out-right" means.  Do you
> mean that I should define flush_*_tlb_range like this?
> 
> #define flush_pmd_tlb_range(vma, addr, end)				\
> 	do {								\
> 		struct mmu_gather tlb;					\
> 		tlb_gather_mmu(&tlb, (vma)->vm_mm, addr, end);		\
> 		tlba.cleared_pmds = 1;					\
> 		flush_tlb_range(&tlb, vma, addr, end);			\
> 		tlb_finish_mmu(&tlb, addr, end);			\
> 	} while (0)
> 

I was thinking to remove flush_*tlb_range() entirely (from generic
code).

And specifically to not use them like the above; instead extend the
mmu_gather API.

Specifically, if you wanted to express flush_pmd_tlb_range() in mmu
gather, you'd write it like:

static inline void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long addr, unsigned long end)
{
	struct mmu_gather tlb;

	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
	tlb_start_vma(&tlb, vma);
	tlb.cleared_pmds = 1;
	__tlb_adjust_range(addr, end - addr);
	tlb_end_vma(&tlb, vma);
	tlb_finish_mmu(&tlb, addr, end);
}

Except of course, that the code between start_vma and end_vma is not a
proper mmu_gather API.

So maybe add:

  tlb_flush_{pte,pmd,pud,p4d}_range()

Then we can write:

static inline void flush_XXX_tlb_range(struct vm_area_struct *vma, unsigned long addr, unsigned long end)
{
	struct mmu_gather tlb;

	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
	tlb_start_vma(&tlb, vma);
	tlb_flush_XXX_range(&tlb, addr, end - addr);
	tlb_end_vma(&tlb, vma);
	tlb_finish_mmu(&tlb, addr, end);
}

But when I look at the output of:

  git grep flush_.*tlb_range -- :^arch/

I doubt it makes sense to provide wrappers like the above.

( Also, we should probably remove the (addr, end) arguments from
tlb_finish_mmu(), Will? )

---
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f391f6b500b4..be5452a8efaa 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -511,6 +511,34 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 }
 #endif
 
+static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
+				       unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_ptes = 1;
+}
+
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+				       unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_pmds = 1;
+}
+
+static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
+				       unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_puds = 1;
+}
+
+static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
+				       unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_p4ds = 1;
+}
+
 #ifndef __tlb_remove_tlb_entry
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #endif
@@ -524,8 +552,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
  */
 #define tlb_remove_tlb_entry(tlb, ptep, address)		\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
-		tlb->cleared_ptes = 1;				\
+		tlb_flush_pte_range(tlb, address, PAGE_SIZE);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
@@ -550,8 +577,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 
 #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)			\
 	do {								\
-		__tlb_adjust_range(tlb, address, HPAGE_PMD_SIZE);	\
-		tlb->cleared_pmds = 1;					\
+		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE);	\
 		__tlb_remove_pmd_tlb_entry(tlb, pmdp, address);		\
 	} while (0)
 
@@ -565,8 +591,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 
 #define tlb_remove_pud_tlb_entry(tlb, pudp, address)			\
 	do {								\
-		__tlb_adjust_range(tlb, address, HPAGE_PUD_SIZE);	\
-		tlb->cleared_puds = 1;					\
+		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE);	\
 		__tlb_remove_pud_tlb_entry(tlb, pudp, address);		\
 	} while (0)
 
