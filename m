Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D791C11AAF2
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfLKMcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:32:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55090 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbfLKMb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=krexXFAWafcSDWP7nl53PyLhwjx3LAnf0o/FpsyPrGc=; b=Mzf9cK+2CmiAS4VMfcObJYmTHI
        AxATk9mhf/VYv6YQbPqClbGHnPHwPiWDg76zUcgOoadRhn31LVxj9DQxfILmwLoIzH1So/ebZA+uL
        j7pszd4ugX+U5PK3UnJAzcPnAtTLT+v8CPAlzHNSIqrzfG10MMGYBd+jkXUOOiLQIWTxDVaz6nrui
        uqRgZPI0gzkpmVKsX9/1Zu2L8Ty+qeBnvWTATNzlkw993CiP61OrFyw270zfhFbcbdw+EsAHOX2jJ
        310kxZij0cDqU5GDH4JAT224CKhq6jj5itwSamZfEHWRiPqnYVPyw8E6/4TISpLpRAA77V5Vv0k14
        RhlPw++w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0003sk-9J; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CB2E306060;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3287320137CB1; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122955.997638865@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:19 +0100
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
Subject: [PATCH 06/17] asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
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
 arch/powerpc/Kconfig      |    2 +-
 include/asm-generic/tlb.h |    9 ++++++---
 mm/mmu_gather.c           |    4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -400,7 +400,7 @@ config MMU_GATHER_NO_TABLE_INVALIDATE
 	bool
 	depends on MMU_GATHER_RCU_TABLE_FREE
 
-config HAVE_MMU_GATHER_PAGE_SIZE
+config MMU_GATHER_PAGE_SIZE
 	bool
 
 config MMU_GATHER_NO_RANGE
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -224,7 +224,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if SMP
 	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
-	select HAVE_MMU_GATHER_PAGE_SIZE
+	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -121,11 +121,14 @@
  *
  * Additionally there are a few opt-in features:
  *
- *  HAVE_MMU_GATHER_PAGE_SIZE
+ *  MMU_GATHER_PAGE_SIZE
  *
  *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
+ *  This might be useful if your architecture has size specific TLB
+ *  invalidation instructions.
+ *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
@@ -271,7 +274,7 @@ struct mmu_gather {
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
 #endif
@@ -422,7 +425,7 @@ static inline void tlb_remove_page(struc
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	if (tlb->page_size && tlb->page_size != page_size) {
 		if (!tlb->fullmm && !tlb->need_flush_all)
 			tlb_flush_mmu(tlb);
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -69,7 +69,7 @@ bool __tlb_remove_page_size(struct mmu_g
 
 	VM_BUG_ON(!tlb->end);
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);
 #endif
 
@@ -223,7 +223,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
 


