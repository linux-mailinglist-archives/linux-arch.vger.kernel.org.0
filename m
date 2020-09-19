Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00C270C90
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgISJut (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgISJuS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 05:50:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33113C0613CE;
        Sat, 19 Sep 2020 02:50:18 -0700 (PDT)
Message-Id: <20200919092617.183860899@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600509016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T76OE0hi3eXJr7P+BXpYE0pYDTNZ2r9R3SGulCeyUuU=;
        b=2FnY2CgYWeCTW79kyvYexk7YWJ5xeg5RXZtJ9x9zc2OPN3Abm6p3LWSqAACGBBqDpxCXEK
        AmJNM9ROty5cv5zC8ZMPGQFlgo5ozfsX3aCrBpUMsRRmNlSxk2Nb7ibaVsStTHAV+q1xhw
        tyuUzA8HGEbMNGj37Qb4z+s6kZ5dVfT/fSBG8UTTSfIo/dViyeIUoDNoqWM41jUb1uRe8y
        TNuoicaGFBrepBDOjFrsE5pU2M0/QYOnyyCI8Na1YuZRUl8nzPl97OPAYFEckcN1cPy7c7
        tnTLXhL0lRIQLAXZHDTRcAsRcj8SYlsXc5v1Qks/4q2bDcL1VWyRREvxbaGmYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600509016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T76OE0hi3eXJr7P+BXpYE0pYDTNZ2r9R3SGulCeyUuU=;
        b=fMUgmEzq+EZqCAGQZdywecGad01pST+RaIL5AkSyisvyVygac32pLGfvQZhYYgbpit1xXp
        4d6YjSdh1O9XNzCw==
Date:   Sat, 19 Sep 2020 11:18:04 +0200
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
Subject: [patch RFC 13/15] mm/highmem: Remove the old kmap_atomic cruft
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/highmem.h |   65 ++----------------------------------------------
 mm/highmem.c            |   28 +++++++++++++++++---
 2 files changed, 28 insertions(+), 65 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -94,27 +94,6 @@ static inline void kunmap(struct page *p
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
-
-#ifndef CONFIG_KMAP_ATOMIC_GENERIC
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-void kunmap_atomic_high(void *kvaddr);
-
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_atomic_high_prot(page, prot);
-}
-
-static inline void __kunmap_atomic(void *vaddr)
-{
-	kunmap_atomic_high(vaddr);
-	pagefault_enable();
-}
-#else /* !CONFIG_KMAP_ATOMIC_GENERIC */
-
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
@@ -127,17 +106,14 @@ static inline void *kmap_atomic_pfn(unsi
 	return kmap_atomic_pfn_prot(pfn, kmap_prot);
 }
 
-static inline void __kunmap_atomic(void *addr)
+static inline void *kmap_atomic(struct page *page)
 {
-	kumap_atomic_indexed(addr);
+	return kmap_atomic_prot(page, kmap_prot);
 }
 
-
-#endif /* CONFIG_KMAP_ATOMIC_GENERIC */
-
-static inline void *kmap_atomic(struct page *page)
+static inline void __kunmap_atomic(void *addr)
 {
-	return kmap_atomic_prot(page, kmap_prot);
+	kumap_atomic_indexed(addr);
 }
 
 /* declarations for linux/mm/highmem.c */
@@ -233,39 +209,6 @@ static inline void __kunmap_atomic(void
 
 #endif /* CONFIG_HIGHMEM */
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-
-DECLARE_PER_CPU(int, __kmap_atomic_idx);
-
-static inline int kmap_atomic_idx_push(void)
-{
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-#endif
-	return idx;
-}
-
-static inline int kmap_atomic_idx(void)
-{
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
-}
-
-static inline void kmap_atomic_idx_pop(void)
-{
-#ifdef CONFIG_DEBUG_HIGHMEM
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
-#else
-	__this_cpu_dec(__kmap_atomic_idx);
-#endif
-}
-
-#endif
-
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
  * kunmap_atomic() should get the return value of kmap_atomic, not the page.
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -31,10 +31,6 @@
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-DEFINE_PER_CPU(int, __kmap_atomic_idx);
-#endif
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -380,6 +376,30 @@ static inline void kmap_high_unmap_tempo
 #endif /* CONFIG_HIGHMEM */
 
 #ifdef CONFIG_KMAP_ATOMIC_GENERIC
+
+static DEFINE_PER_CPU(int, __kmap_atomic_idx);
+
+static inline int kmap_atomic_idx_push(void)
+{
+	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
+
+	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	BUG_ON(idx >= KM_TYPE_NR);
+	return idx;
+}
+
+static inline int kmap_atomic_idx(void)
+{
+	return __this_cpu_read(__kmap_atomic_idx) - 1;
+}
+
+static inline void kmap_atomic_idx_pop(void)
+{
+	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
+
+	BUG_ON(idx < 0);
+}
+
 #ifndef arch_kmap_temp_post_map
 # define arch_kmap_temp_post_map(vaddr, pteval)	do { } while (0)
 #endif

