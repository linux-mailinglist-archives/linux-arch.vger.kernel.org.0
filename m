Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFB11AAF0
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfLKMcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:32:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfLKMcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FvghZFBaoqrMAEVkDDRcPbYOLQl3+Nssq3SxvKZJaQI=; b=eyYSAOGbwuKI+/tsaYEU5bznHd
        rczIvlRuyztabhFl3bCt9VDUhDf4mBhA+lY7x9tqz4PAb0skfrtoPhJTPMeiZ4XeRU53ia0VekyOO
        uAo2tqtKGg8GYJfmFe9iPytIgsf5uDNGXLsqdXk4pgOgeu+PaWVbZ6XrF9+bIxUA40EqldwR/L/Gb
        /qnN85DQU/nWxRFmoXeIpZ6vSzYHsewDDJIpLLokkREYuXmaxAYWyPBx5cLIRYgv3yoAJz/+6TlUL
        YYV/irr9dWhr4QniMt6SZQNJfFTAIx7bAWgrQ6qJF3PGPEbAwbt1uGi0X0Axl/q0HTGQr3Kh7KjY5
        mAIfyp/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0003sl-9d; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6C463066B3;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3B16F20137CB2; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.169764611@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 09/17] sh/tlb: Fix __pmd_free_tlb()
References: <20191211120713.360281197@infradead.org>
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
@@ -15,6 +15,7 @@ config SUPERH
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


