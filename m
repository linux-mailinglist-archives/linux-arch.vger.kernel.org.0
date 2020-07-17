Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BF223A1D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGQLOl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGQLOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871BC08C5DB;
        Fri, 17 Jul 2020 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LJ3sw53oU99bJUNlz+ZPKQESK/v2SDXFGx5kri1RxHA=; b=mW9BkUrdORbTIfPggDbuXHG04P
        vCB4+S08tm1Ocf2AwK2fgRL5Z3xoCetQtur/ZtwHqsPjZyWzsEWXg/Ip+JJ01RKTNXQtvbRs+p4wQ
        Rtlh3rxfbsLXEdDC4EA+JGYP4+cth5V1pYwo/CUI+uhfMF/FCH+FPxsGHa0Qxv98nUlMB2O5LfeGn
        76uku3heKukpjwJsmr+QWhayyffHIapPntJuifnOtS8eftI1cLoiD8fwy79B12vBBVdWVK6nwNu9V
        c3dXF9QSaUXQEzzdrBQNbf7xX4kUygNN/Os21nFZoo+1Bzj9/2pKz1V+KcRM2zJ+FzRpvfRyHdXc7
        T+DnKayA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-0001Zm-Jw; Fri, 17 Jul 2020 11:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 144D5305DD1;
        Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF019203D4091; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.533637732@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/11] sh/tlb: Fix __pmd_free_tlb()
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SH violates the freeing order for it's PMD page directories. It's
__pmd_free_tlb() does not ensure there is a TLB invalidation between
itself and the eventualy freeing of the page.

Further complicating the situation is that SH uses non page based
allocation for it's PMDs.

Use the shiny new HAVE_TABLE_FREE option to enable a custom page table
freeer.

(SuperH uses IPI based TLB invalidation and therefore doesn't need
HAVE_RCU_TABLE_FREE for its HAVE_FAST_GUP).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sh/Kconfig               |    1 +
 arch/sh/include/asm/pgalloc.h |    3 ++-
 arch/sh/mm/pgtable.c          |    6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,6 +14,7 @@ config SUPERH
 	select HAVE_PERF_EVENTS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_FAST_GUP if MMU
+	select MMU_GATHER_TABLE_FREE if X2TLB
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_GCOV_PROFILE_ALL
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -12,7 +12,8 @@ extern void pgd_free(struct mm_struct *m
 extern void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd);
 extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
 extern void pmd_free(struct mm_struct *mm, pmd_t *pmd);
-#define __pmd_free_tlb(tlb, pmdp, addr)		pmd_free((tlb)->mm, (pmdp))
+extern void __tlb_remove_table(void *table);
+#define __pmd_free_tlb(tlb, pmdp, addr)	tlb_remove_table((tlb), (pmdp))
 #endif
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <asm/pgalloc.h>
 
 #define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
 
@@ -55,4 +56,9 @@ void pmd_free(struct mm_struct *mm, pmd_
 {
 	kmem_cache_free(pmd_cachep, pmd);
 }
+
+void __tlb_remove_table(void *table)
+{
+	pmd_free(NULL, table);
+}
 #endif /* PAGETABLE_LEVELS > 2 */


