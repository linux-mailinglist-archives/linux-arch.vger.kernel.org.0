Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4FB29F81C
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJ2Wck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:32:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgJ2Wch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 18:32:37 -0400
Message-Id: <20201029222651.303553207@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604010737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+xC87ERpPXGgavrN8jcZui16Ib//VJ4ULsWIMrAKkyk=;
        b=PSYrK+quoAKuPb58/S0FnoeNP6CRhjw1d7Kkr/cGcQcczJ0wK1sIeFbZ6zYK/KgtH3/56I
        F4rLPDmccUzR4JHemPKXnpW2LmbBX7hCL9+G9N1eKrNmTEJBdDjXdUhk3HQHjWsyIGR3Iz
        euGpqLCjVUgREjljbG5/fU0oaigLQTY3SL+X3wRsKYL6mEiwWFvR+vXvSVBzdlyWn96yFo
        BuesD1ku84SWqoQISMUEbcmKiQi/PpqELOJRYtHPWm0DC6iPpSY1wVcECaLMSu7UBAu9xD
        Y9qWUHp3qI0cDYvPvn/AQhEjO3F+EGylr3KXzY7Am/mxYHtLr2lKRelmdzYE3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604010737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+xC87ERpPXGgavrN8jcZui16Ib//VJ4ULsWIMrAKkyk=;
        b=nwqkiNxkBvtPCgsAOkT1FX75guvPll1ni4sFisLZr1EA+lxBsQzL7jqFmAMBFTq9rE/ElC
        EmvA/M+1jBoKioCw==
Date:   Thu, 29 Oct 2020 23:18:13 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [patch V2 07/18] csky/mm/highmem: Switch to generic kmap atomic
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No reason having the same code in every architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org

---
 arch/csky/Kconfig               |    1 
 arch/csky/include/asm/highmem.h |    4 +-
 arch/csky/mm/highmem.c          |   75 ----------------------------------------
 3 files changed, 5 insertions(+), 75 deletions(-)

--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -286,6 +286,7 @@ config NR_CPUS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on !CPU_CK610
+	select KMAP_LOCAL
 	default y
 
 config FORCE_MAX_ZONEORDER
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -32,10 +32,12 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps() do {} while (0)
 
+#define arch_kmap_local_post_map(vaddr, pteval)	kmap_flush_tlb(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	kmap_flush_tlb(vaddr)
+
 extern void kmap_init(void);
 
 #endif /* __KERNEL__ */
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -9,8 +9,6 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -19,67 +17,7 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
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
-	flush_tlb_one((unsigned long)vaddr);
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	idx = KM_TYPE_NR*smp_processor_id() + kmap_atomic_idx();
-
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-	pte_clear(&init_mm, vaddr, kmap_pte - idx);
-	flush_tlb_one(vaddr);
-#else
-	(void) idx; /* to kill a warning */
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
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void *) vaddr;
-}
-
-static void __init kmap_pages_init(void)
+void __init kmap_init(void)
 {
 	unsigned long vaddr;
 	pgd_t *pgd;
@@ -96,14 +34,3 @@ static void __init kmap_pages_init(void)
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 }
-
-void __init kmap_init(void)
-{
-	unsigned long vaddr;
-
-	kmap_pages_init();
-
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN);
-
-	kmap_pte = pte_offset_kernel((pmd_t *)pgd_offset_k(vaddr), vaddr);
-}

