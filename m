Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D3270C7E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgISJua (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgISJuM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 05:50:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0AC0613CE;
        Sat, 19 Sep 2020 02:50:12 -0700 (PDT)
Message-Id: <20200919092616.639345384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600509010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=l6UaD+dzOnnTICZKZqhj1RzFfIiirpVtGOULH7No/gI=;
        b=uE/cx/XrCkHRif0a8B/w0YwDHTFwWo03DlSB7Y+loKY8xMmLrHOwc8lpWUZbqY8QApMA/g
        sajhDKXTCP5FGncBXxctNRnl24aPkXZ5mv6xZo09Vm65NwvEPuEKm4NDcrFjm7NB7Xa5rL
        zLEnYLoAoiyvMOCaPzqFZF6tElKTJcVZW7CuQoeaoTHUXkP4aGYvq3FQAmpkOCBkhmSWvq
        IG0ndfdvEjaQLn5Ju2RKkWSDGRuzWFI6CkmEbdALZYxEo8CkRTP9sK54SFr+pnSrrJ8Gkd
        16VmQoNyueVyGeLZSsaOk2wsU8WpIK+uORXYGRVbugHbjD4igNrb9PYU9pU6IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600509010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=l6UaD+dzOnnTICZKZqhj1RzFfIiirpVtGOULH7No/gI=;
        b=fAWa6oS2xwanh/X+hPgArDKmCI7Jk7grG3LDqIrJ5eHdpm+qaq2QoU3UJXACE7I1r07ARu
        5m000yHhlPwxwMDA==
Date:   Sat, 19 Sep 2020 11:17:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [patch RFC 08/15] mips/mm/highmem: Switch to generic kmap atomic
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
Note: Completely untested
---
 arch/mips/Kconfig               |    1 
 arch/mips/include/asm/highmem.h |    4 +-
 arch/mips/mm/highmem.c          |   77 ----------------------------------------
 arch/mips/mm/init.c             |    3 -
 4 files changed, 3 insertions(+), 82 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2654,6 +2654,7 @@ config MIPS_CRC_SUPPORT
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
+	select KMAP_ATOMIC_GENERIC
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -48,11 +48,11 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
-extern void kmap_init(void);
+#define arch_kmap_temp_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
+#define arch_kmap_temp_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 
 #endif /* __KERNEL__ */
 
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,8 +8,6 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -17,78 +15,3 @@ void kmap_flush_tlb(unsigned long addr)
 	flush_tlb_one(addr);
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_one((unsigned long)vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
-
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_one(vaddr);
-	}
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -402,9 +402,6 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif

