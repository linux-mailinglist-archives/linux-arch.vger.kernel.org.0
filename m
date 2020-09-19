Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C00270C79
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgISJuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgISJuG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 05:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBAC0613CE;
        Sat, 19 Sep 2020 02:50:05 -0700 (PDT)
Message-Id: <20200919092616.099540708@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600509004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IcUxuUmus/f19+tlbDAQzIY8NDWwhudbcDxOlve7wKI=;
        b=Njr7XG5hp9UFvUHM96wzxKViZT79w292jsQ9O/My5xFWWJTDsWsQja4X9EjwiFibHaM9jp
        j2W065lxQMJ2T7Wn2BknAumkEJUNAbSDIR3LrpOaifZoo7R0Cpm7dgWv7484ksC3JDZnuw
        61Xhv8Ad3azGEIhQm9GipiCMoP0J5vczyfbodCFa3N7qzPWfV0rn3YQsNoyQccSRmJP6ai
        Fa+HWj0ZmkFb7rk58GvZhOIQA9ui8kGrj2c/WJ7x25lbaB5SomX61+6dSNAKHbtKBDxAwu
        YG4p0Syl4PQipkermmMkzwU8B5UV4pkMKPELHACIrN3SAuEGDLpMFkzFCKBtaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600509004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IcUxuUmus/f19+tlbDAQzIY8NDWwhudbcDxOlve7wKI=;
        b=qPOy+PT6ydmRTcfF44tLEQ9ukobKx1lOxMfGCcZVyNptKRDYoanG0X4dK3VKG4hZlguqNU
        9oNaVjrvicJP8xDw==
Date:   Sat, 19 Sep 2020 11:17:54 +0200
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
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [patch RFC 03/15] x86/mm/highmem: Use generic kmap atomic implementation
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Convert X86 to the generic kmap atomic implementation.

Make the iomap_atomic() naming convention consistent while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig               |    3 +-
 arch/x86/include/asm/fixmap.h  |    1 
 arch/x86/include/asm/highmem.h |   12 ++++++--
 arch/x86/include/asm/iomap.h   |   17 ++++++-----
 arch/x86/mm/highmem_32.c       |   59 -----------------------------------------
 arch/x86/mm/init_32.c          |   15 ----------
 arch/x86/mm/iomap_32.c         |   58 ++--------------------------------------
 include/linux/io-mapping.h     |    2 -
 8 files changed, 25 insertions(+), 142 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,10 +14,11 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
+	select KMAP_ATOMIC_GENERIC
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
-	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -151,7 +151,6 @@ extern void reserve_top_address(unsigned
 
 extern int fixmaps_set;
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -58,11 +58,17 @@ extern unsigned long highstart_pfn, high
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-void *kmap_atomic_pfn(unsigned long pfn);
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
-
 #define flush_cache_kmaps()	do { } while (0)
 
+#define	arch_kmap_temp_post_map(vaddr, pteval)		\
+	arch_flush_lazy_mmu_mode()
+
+#define	arch_kmap_temp_post_unmap(vaddr)		\
+	do {						\
+		flush_tlb_one_kernel((vaddr));		\
+		arch_flush_lazy_mmu_mode();		\
+	} while (0)
+
 extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
 					unsigned long end_pfn);
 
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -9,19 +9,20 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
 
-void
-iounmap_atomic(void __iomem *kvaddr);
+static inline void iounmap_atomic(void __iomem *vaddr)
+{
+	kunmap_atomic_indexed((void __force *)vaddr);
+	preempt_enable();
+}
 
-int
-iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
+int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
-void
-iomap_free(resource_size_t base, unsigned long size);
+void iomap_free(resource_size_t base, unsigned long size);
 
 #endif /* _ASM_X86_IOMAP_H */
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -4,65 +4,6 @@
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic_prot_pfn(pfn, kmap_prot);
-}
-EXPORT_SYMBOL_GPL(kmap_atomic_pfn);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-		arch_flush_lazy_mmu_mode();
-	}
-#ifdef CONFIG_DEBUG_HIGHMEM
-	else {
-		BUG_ON(vaddr < PAGE_OFFSET);
-		BUG_ON(vaddr >= (unsigned long)high_memory);
-	}
-#endif
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
 void __init set_highmem_pages_init(void)
 {
 	struct zone *zone;
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,19 +394,6 @@ kernel_physical_mapping_init(unsigned lo
 	return last_map_addr;
 }
 
-pte_t *kmap_pte;
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/*
-	 * Cache the first kmap pte:
-	 */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -712,8 +699,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	kmap_init();
-
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,28 +44,7 @@ void iomap_free(resource_size_t base, un
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-
-/*
- * Map 'pfn' using protections 'prot'
- */
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -81,36 +60,7 @@ iomap_atomic_prot_pfn(unsigned long pfn,
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
-}
-EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
-
-void
-iounmap_atomic(void __iomem *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-	}
-
-	pagefault_enable();
-	preempt_enable();
+	preempt_disable();
+	return (void __force __iomem *)kmap_atomic_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iounmap_atomic);
+EXPORT_SYMBOL_GPL(iomap_atomic_pfn_prot);
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,7 @@ io_mapping_map_atomic_wc(struct io_mappi
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
+	return iomap_atomic_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void

