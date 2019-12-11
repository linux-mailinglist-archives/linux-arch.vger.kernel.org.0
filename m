Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68F11AADD
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfLKMbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbfLKMbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kha1DNRsNJX9wg9pqNRv2AfGj3UZUSQsnrv68oCgIj0=; b=ToapP2qlFGSbItIorKP5sCoHSM
        Yv+euDU9Y7Y7yxk43M7SLRy9A4z9BFDWddAnZJWoizRRhswezDlHNRd0DolNbPDM7U0P3wcydTSBK
        oyT9bRlG5cK6Y+vkBIFxXCaaEyhxXCmVR5BPsueaEPvpHCLl2AgPxGN718ZQ0sjVaq1BQfLW3Spvu
        1TTaJFwhZsUD19UiLLA2T9O4AMWBGx+ANbTUgKVW9Z4NVm7eObFzyPIAbZx+rgC7ikj6/sMybRYJ2
        d+pXmIrAesnXvzL6vN3/VsXP5OKYhpG10XnpIwXcEfpe9diDY3ysEFw38AOvQPLYW65Pj1Sg/SNDY
        /J8spJeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if18z-0001PN-U7; Wed, 11 Dec 2019 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB13A30606A;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3478520137CAE; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.055418242@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:20 +0100
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
Subject: [PATCH 07/17] asm-generic/tlb: Rename HAVE_MMU_GATHER_NO_GATHER
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig              |    2 +-
 arch/s390/Kconfig         |    2 +-
 include/asm-generic/tlb.h |   14 ++++++++++++--
 mm/mmu_gather.c           |   10 +++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -406,7 +406,7 @@ config MMU_GATHER_PAGE_SIZE
 config MMU_GATHER_NO_RANGE
 	bool
 
-config HAVE_MMU_GATHER_NO_GATHER
+config MMU_GATHER_NO_GATHER
 	bool
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -162,7 +162,7 @@ config S390
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
-	select HAVE_MMU_GATHER_NO_GATHER
+	select MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -147,6 +147,16 @@
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
+ *
+ *  MMU_GATHER_NO_GATHER
+ *
+ *  If the option is set the mmu_gather will not track individual pages for
+ *  delayed page free anymore. A platform that enables the option needs to
+ *  provide its own implementation of the __tlb_remove_page_size() function to
+ *  free pages.
+ *
+ *  This is useful if your architecture already flushes TLB entries in the
+ *  various ptep_get_and_clear() functions.
  */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
@@ -191,7 +201,7 @@ extern void tlb_remove_table(struct mmu_
 
 #endif
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
  * to work on, then just handle a few from the on-stack structure.
@@ -266,7 +276,7 @@ struct mmu_gather {
 
 	unsigned int		batch_count;
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,7 +11,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
@@ -89,7 +89,7 @@ bool __tlb_remove_page_size(struct mmu_g
 	return false;
 }
 
-#endif /* HAVE_MMU_GATHER_NO_GATHER */
+#endif /* MMU_GATHER_NO_GATHER */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 
@@ -180,7 +180,7 @@ static void tlb_flush_mmu_free(struct mm
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_pages_flush(tlb);
 #endif
 }
@@ -211,7 +211,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 	/* Is it from 0 to ~0? */
 	tlb->fullmm     = !(start | (end+1));
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
 	tlb->local.next = NULL;
 	tlb->local.nr   = 0;
@@ -271,7 +271,7 @@ void tlb_finish_mmu(struct mmu_gather *t
 
 	tlb_flush_mmu(tlb);
 
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
 #endif
 	dec_tlb_flush_pending(tlb->mm);


