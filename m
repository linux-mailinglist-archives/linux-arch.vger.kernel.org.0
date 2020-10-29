Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921E629F85B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJ2Wdo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgJ2Wcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 18:32:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D42EC0613DA;
        Thu, 29 Oct 2020 15:32:31 -0700 (PDT)
Message-Id: <20201029222652.302358281@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604010749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qNblSYL+PvuzH63KJpcNLXY4ezwTF2j8DGcTkrl8CzE=;
        b=g9uiGxDoZ7ZXpoa9KyavVFr3VQOQLQAN2KG3UnrWl5U4ft/lDRKXlvz1G/HC+P0RYnIr2u
        rLXQGvLJr8ZVI3ZifAxNUwCB514Po3gS1iNsND2GQWvusrIddMmopCK0alQCaYQifsn16g
        BRxC0oP5qPfihqhqNGjX863PAV7yZ6KXqwav+qxwxlPhZWhbB8Oi6TqqQZlHdTKtg9zsEg
        or74Sk/qyESnME+pdt+Wdpg+e75KkOwyHi+YG0F1U3Ugt2daySrmBDKSfswsZr/qCtFW9u
        p3NtqN7J6GpwvvdV6iGSAQgGl5DD0x2YC9tsRsnYDFdeVQizXTI8Zyaf3ny72w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604010749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qNblSYL+PvuzH63KJpcNLXY4ezwTF2j8DGcTkrl8CzE=;
        b=luMtij7pyzuhRYRe4DwSHukATlmykltgP/ZHYRb8RL2JeQG6QeudIS3wZ/jzIUh0L95Z5o
        c6mGwkQdF0Dg0tAA==
Date:   Thu, 29 Oct 2020 23:18:23 +0100
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
        linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
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
Subject: [patch V2 17/18] mm/highmem: Provide kmap_local*
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the kmap atomic index is stored in task struct provide a
preemptible variant. On context switch the maps of an outgoing task are
removed and the map of the incoming task are restored. That's obviously
slow, but highmem is slow anyway.

The kmap_local.*() functions can be invoked from both preemptible and
atomic context. kmap local sections disable migration to keep the resulting
virtual mapping address correct, but disable neither pagefaults nor
preemption.

A wholesale conversion of kmap_atomic to be fully preemptible is not
possible because some of the usage sites might rely on the preemption
disable for serialization or on the implicit pagefault disable. Needs to be
done on a case by case basis.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Make it more consistent and add commentry
---
 include/linux/highmem.h |  115 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 15 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,17 +86,56 @@ static inline void kunmap(struct page *p
 }
 
 /*
- * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
- * no global lock is needed and because the kmap code must perform a global TLB
- * invalidation when the kmap pool wraps.
- *
- * However when holding an atomic kmap it is not legal to sleep, so atomic
- * kmaps are appropriate for short, tight code paths only.
- *
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
+ * For highmem systems it is required to temporarily map pages
+ * which reside in the portion of memory which is not covered
+ * by the permanent kernel mapping.
+ *
+ * This comes in three flavors:
+ *
+ * 1) kmap/kunmap:
+ *
+ *    An interface to acquire longer term mappings with no restrictions
+ *    on preemption and migration. This comes with an overhead as the
+ *    mapping space is restricted and protected by a global lock. It
+ *    also requires global TLB invalidation when the kmap pool wraps.
+ *
+ *    kmap() might block when the mapping space is fully utilized until a
+ *    slot becomes available. Only callable from preemptible thread
+ *    context.
+ *
+ * 2) kmap_local.*()/kunmap_local.*()
+ *
+ *    An interface to acquire short term mappings. Can be invoked from any
+ *    context including interrupts. The mapping is per thread, CPU local
+ *    and not globaly visible. It can only be used in the context which
+ *    acquried the mapping. Nesting kmap_local.*() and kmap_atomic.*()
+ *    mappings is allowed to a certain extent (up to KMAP_TYPE_NR).
+ *
+ *    Nested kmap_local.*() and kunmap_local.*() invocations have to be
+ *    strictly ordered because the map implementation is stack based.
+ *
+ *    kmap_local.*() disables migration, but keeps preemption enabled. It's
+ *    valid to take pagefaults in a kmap_local region unless the context in
+ *    which the local kmap is acquired does not allow it for other reasons.
+ *
+ *    If a task holding local kmaps is preempted, the maps are removed on
+ *    context switch and restored when the task comes back on the CPU. As
+ *    the maps are strictly CPU local it is guaranteed that the task stays
+ *    on the CPU and the CPU cannot be unplugged until the local kmaps are
+ *    released.
+ *
+ * 3) kmap_atomic.*()/kunmap_atomic.*()
+ *
+ *    Based on the same mechanism as kmap local. Atomic kmap disables
+ *    preemption and pagefaults. Only use if absolutely required, use
+ *    the corresponding kmap_local variant if possible.
+ *
+ * Local and atomic kmaps are faster than kmap/kunmap, but impose
+ * restrictions. Only use them when required.
+ *
+ * For !HIGHMEM enabled systems the kmap flavours are not doing any mapping
+ * operation and kmap() won't sleep, but the kmap local and atomic variants
+ * still disable migration resp. pagefaults and preemption.
  */
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
@@ -122,6 +161,28 @@ static inline void __kunmap_atomic(void
 	kunmap_local_indexed(addr);
 }
 
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	migrate_disable();
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	migrate_disable();
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
+}
+
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 extern atomic_long_t _totalhigh_pages;
@@ -201,10 +262,27 @@ static inline void *kmap_atomic_pfn(unsi
 
 static inline void __kunmap_atomic(void *addr)
 {
-	/*
-	 * Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
-	 * handles re-enabling faults and preemption
-	 */
+	__kunmap_local(addr);
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	migrate_disable();
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
+{
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
@@ -226,6 +304,13 @@ do {								\
 	preempt_enable();					\
 } while (0)
 
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+	migrate_enable();					\
+} while (0)
+
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)

