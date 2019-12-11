Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963AE11AAE0
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfLKMbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfLKMbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EAd4sniYvQfVFa7iAd7B3Jx5jzSbOy6mN0wfPQQPFoA=; b=jDRKoJ/SUad35TrcNy3bpq3pYH
        G2Li0tKMTO5RKQEokjs6Kt5t3F4sEI8aW20OunEnMRuBkdooU9uC1XhpMds6k9iSYha6xCF6EdSpk
        GiYm7n+WLSb7vhnB2tsxfToJZ28TGmHbPdUtPp0LCV/YElfkzhjWOmrDMH45SS4cLqnMhWXOrr7No
        IxaISBT8TTbFppEQrfPiM85BEzqj8uSU/qjaPaQhjq0JRts/D1tgg8o0o+Gy9dFXcimcjWTCVmP7a
        iAWI8Q2RWrvZ0rTdT7aYnJ44sHlwijTP5AJydoumdsWroeisevxXzV/2gOt52vlaS2apwXEfVcsr9
        arHuMVJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if18z-0001PM-TU; Wed, 11 Dec 2019 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98CCD30604B;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E4AA20137CB0; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122955.940455408@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:18 +0100
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
Subject: [PATCH 05/17] asm-generic/tlb: Rename HAVE_RCU_TABLE_NO_INVALIDATE
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
 arch/Kconfig              |    3 ++-
 arch/powerpc/Kconfig      |    2 +-
 arch/sparc/Kconfig        |    2 +-
 include/asm-generic/tlb.h |    2 +-
 mm/mmu_gather.c           |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
 
-config HAVE_RCU_TABLE_NO_INVALIDATE
+config MMU_GATHER_NO_TABLE_INVALIDATE
 	bool
+	depends on MMU_GATHER_RCU_TABLE_FREE
 
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -65,7 +65,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_NO_TABLE_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -137,7 +137,7 @@
  *  When used, an architecture is expected to provide __tlb_remove_table()
  *  which does the actual freeing of these pages.
  *
- *  HAVE_RCU_TABLE_NO_INVALIDATE
+ *  MMU_GATHER_NO_TABLE_INVALIDATE
  *
  *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
  *  freeing the page-table pages. This can be avoided if you use
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -102,7 +102,7 @@ bool __tlb_remove_page_size(struct mmu_g
  */
 static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 {
-#ifndef CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE
+#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
 	/*
 	 * Invalidate page-table caches used by hardware walkers. Then we still
 	 * need to RCU-sched wait while freeing the pages because software


