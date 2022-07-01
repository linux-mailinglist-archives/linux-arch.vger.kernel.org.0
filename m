Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F94563558
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGAOZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiGAOYg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:24:36 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662BD3EAB3
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:55 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso1847462edx.19
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zch90Kb1PH444z16gANLEx2ctA8AD9SJjapQIjqFsi4=;
        b=pnk7oQtFARPFwXoB7UQH8a+lShrkN/dZfogG5GgCvhFXsN88RluWz+ZjGnD7oYUdIw
         cSAA2elsGgUBj0N1M87IT0lO+gzJw5NsZk0pUoabL84U06CrW3epHcEoxKZDoTfe1LxE
         IC2iQFQHw18iRFcs9AhivljPkYhG9+EsemtgcZvDv+4iPrTkYcJTPWF5Qp1gEXnao22F
         WuPHtwwaA30+tR4AmC6g+PR+HpqAoB04SL8qGnjhJHcUOE6O9aYUG1Gt0rxanbg58DoW
         CIOkkK5G42M6r1U3xVSfIsqfE42vyc9QnRfxKZmDfDHpDwCFuzIcbOQxQHcD5gp/n6gE
         jbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zch90Kb1PH444z16gANLEx2ctA8AD9SJjapQIjqFsi4=;
        b=5O5ZdFmPWowo+y8ip8cMkadZ0CA+f8MZKWirpkygF9Mo/mLKZPJVeIrDKO5qreJ6/d
         mRT1t4EWOYpwgEebSYeXS5gCdVaqJdCqBfLabxoJ39cN2yN9e5azdRuxK8IzxVFR6Gra
         0kafZhOr0Kc9Y8R7wgL5Y+feUqglk/gYbOh5GENmPuIyPI+abBwCSzppa4MILxW+26Gw
         YOF7A96pm2oAHuGFyO79SRRqH1jw7iGNHXV2aKZi9KSG+4sy/TyjGARBkMNEIQ8xsUM0
         0okkk0x1opyElbaumnunhYGJmPRDD+xnalCcg2I/B+N76CluTP9aDliwiyW8eny5b3Mm
         HWNQ==
X-Gm-Message-State: AJIora8V57D7L4cyDxEMWMnNYHMhdbN5ExuHzBfmgj8B2woUhykOUWxS
        XrYYKLe46+X9S4aggUeLhVuT6p7CNkU=
X-Google-Smtp-Source: AGRyM1sz81cWisEJq9r2TpHBDU5N+Ew2N2b9W2QTXS0gGFF23C1Ujb2ac0Cgjhi/K2VMxzuq9KL7J9yxvPI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:907:3f1d:b0:726:c927:769b with SMTP id
 hq29-20020a1709073f1d00b00726c927769bmr14568479ejc.754.1656685434644; Fri, 01
 Jul 2022 07:23:54 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:39 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-15-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 14/45] mm: kmsan: maintain KMSAN metadata for page operations
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Insert KMSAN hooks that make the necessary bookkeeping changes:
 - poison page shadow and origins in alloc_pages()/free_page();
 - clear page shadow and origins in clear_page(), copy_user_highpage();
 - copy page metadata in copy_highpage(), wp_page_copy();
 - handle vmap()/vunmap()/iounmap();

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- move page metadata hooks implementation here
 -- remove call to kmsan_memblock_free_pages()

v3:
 -- use PAGE_SHIFT in kmsan_ioremap_page_range()

v4:
 -- change sizeof(type) to sizeof(*ptr)
 -- replace occurrences of |var| with @var
 -- swap mm: and kmsan: in the subject
 -- drop __no_sanitize_memory from clear_page()

Link: https://linux-review.googlesource.com/id/I6d4f53a0e7eab46fa29f0348f3095d9f2e326850
---
 arch/x86/include/asm/page_64.h |  12 ++++
 arch/x86/mm/ioremap.c          |   3 +
 include/linux/highmem.h        |   3 +
 include/linux/kmsan.h          | 123 +++++++++++++++++++++++++++++++++
 mm/internal.h                  |   6 ++
 mm/kmsan/hooks.c               |  87 +++++++++++++++++++++++
 mm/kmsan/shadow.c              | 114 ++++++++++++++++++++++++++++++
 mm/memory.c                    |   2 +
 mm/page_alloc.c                |  11 +++
 mm/vmalloc.c                   |  20 +++++-
 10 files changed, 379 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index baa70451b8df5..227dd33eb4efb 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -45,14 +45,26 @@ void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
 
+/* This is an assembly header, avoid including too much of kmsan.h */
+#ifdef CONFIG_KMSAN
+void kmsan_unpoison_memory(const void *addr, size_t size);
+#endif
 static inline void clear_page(void *page)
 {
+#ifdef CONFIG_KMSAN
+	/* alternative_call_2() changes @page. */
+	void *page_copy = page;
+#endif
 	alternative_call_2(clear_page_orig,
 			   clear_page_rep, X86_FEATURE_REP_GOOD,
 			   clear_page_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
 			   "0" (page)
 			   : "cc", "memory", "rax", "rcx");
+#ifdef CONFIG_KMSAN
+	/* Clear KMSAN shadow for the pages that have it. */
+	kmsan_unpoison_memory(page_copy, PAGE_SIZE);
+#endif
 }
 
 void copy_page(void *to, void *from);
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 1ad0228f8ceb9..78c5bc654cff5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
+#include <linux/kmsan.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -479,6 +480,8 @@ void iounmap(volatile void __iomem *addr)
 		return;
 	}
 
+	kmsan_iounmap_page_range((unsigned long)addr,
+		(unsigned long)addr + get_vm_area_size(p));
 	memtype_free(p->phys_addr, p->phys_addr + get_vm_area_size(p));
 
 	/* Finally remove it */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330c..ae82c5aefb018 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/cacheflush.h>
+#include <linux/kmsan.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
@@ -302,6 +303,7 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 	vfrom = kmap_local_page(from);
 	vto = kmap_local_page(to);
 	copy_user_page(vto, vfrom, vaddr, to);
+	kmsan_unpoison_memory(page_address(to), PAGE_SIZE);
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 }
@@ -317,6 +319,7 @@ static inline void copy_highpage(struct page *to, struct page *from)
 	vfrom = kmap_local_page(from);
 	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
+	kmsan_copy_page_meta(to, from);
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 }
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 99e48c6b049d9..699fe4f5b3bee 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -41,6 +41,129 @@ struct kmsan_ctx {
 	bool allow_reporting;
 };
 
+/**
+ * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
+ * @page:  struct page pointer returned by alloc_pages().
+ * @order: order of allocated struct page.
+ * @flags: GFP flags used by alloc_pages()
+ *
+ * KMSAN marks 1<<@order pages starting at @page as uninitialized, unless
+ * @flags contain __GFP_ZERO.
+ */
+void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags);
+
+/**
+ * kmsan_free_page() - Notify KMSAN about a free_pages() call.
+ * @page:  struct page pointer passed to free_pages().
+ * @order: order of deallocated struct page.
+ *
+ * KMSAN marks freed memory as uninitialized.
+ */
+void kmsan_free_page(struct page *page, unsigned int order);
+
+/**
+ * kmsan_copy_page_meta() - Copy KMSAN metadata between two pages.
+ * @dst: destination page.
+ * @src: source page.
+ *
+ * KMSAN copies the contents of metadata pages for @src into the metadata pages
+ * for @dst. If @dst has no associated metadata pages, nothing happens.
+ * If @src has no associated metadata pages, @dst metadata pages are unpoisoned.
+ */
+void kmsan_copy_page_meta(struct page *dst, struct page *src);
+
+/**
+ * kmsan_map_kernel_range_noflush() - Notify KMSAN about a vmap.
+ * @start:	start of vmapped range.
+ * @end:	end of vmapped range.
+ * @prot:	page protection flags used for vmap.
+ * @pages:	array of pages.
+ * @page_shift:	page_shift passed to vmap_range_noflush().
+ *
+ * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
+ * vmalloc metadata address range.
+ */
+void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				    pgprot_t prot, struct page **pages,
+				    unsigned int page_shift);
+
+/**
+ * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
+ * @start: start of vunmapped range.
+ * @end:   end of vunmapped range.
+ *
+ * KMSAN unmaps the contiguous metadata ranges created by
+ * kmsan_map_kernel_range_noflush().
+ */
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
+
+/**
+ * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
+ * @addr:	range start.
+ * @end:	range end.
+ * @phys_addr:	physical range start.
+ * @prot:	page protection flags used for ioremap_page_range().
+ * @page_shift:	page_shift argument passed to vmap_range_noflush().
+ *
+ * KMSAN creates new metadata pages for the physical pages mapped into the
+ * virtual memory.
+ */
+void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
+			      phys_addr_t phys_addr, pgprot_t prot,
+			      unsigned int page_shift);
+
+/**
+ * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
+ * @start: range start.
+ * @end:   range end.
+ *
+ * KMSAN unmaps the metadata pages for the given range and, unlike for
+ * vunmap_page_range(), also deallocates them.
+ */
+void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
+
+#else
+
+static inline int kmsan_alloc_page(struct page *page, unsigned int order,
+				   gfp_t flags)
+{
+	return 0;
+}
+
+static inline void kmsan_free_page(struct page *page, unsigned int order)
+{
+}
+
+static inline void kmsan_copy_page_meta(struct page *dst, struct page *src)
+{
+}
+
+static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
+						  unsigned long end,
+						  pgprot_t prot,
+						  struct page **pages,
+						  unsigned int page_shift)
+{
+}
+
+static inline void kmsan_vunmap_range_noflush(unsigned long start,
+					      unsigned long end)
+{
+}
+
+static inline void kmsan_ioremap_page_range(unsigned long start,
+					    unsigned long end,
+					    phys_addr_t phys_addr,
+					    pgprot_t prot,
+					    unsigned int page_shift)
+{
+}
+
+static inline void kmsan_iounmap_page_range(unsigned long start,
+					    unsigned long end)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/internal.h b/mm/internal.h
index c0f8fbe0445b5..dccdba2ac4ecf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -847,8 +847,14 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 }
 #endif
 
+int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+			       pgprot_t prot, struct page **pages,
+			       unsigned int page_shift);
+
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
+void __vunmap_range_noflush(unsigned long start, unsigned long end);
+
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 4ac62fa67a02a..070756be70e3a 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -26,6 +26,93 @@
  * skipping effects of functions like memset() inside instrumented code.
  */
 
+static unsigned long vmalloc_shadow(unsigned long addr)
+{
+	return (unsigned long)kmsan_get_metadata((void *)addr,
+						 KMSAN_META_SHADOW);
+}
+
+static unsigned long vmalloc_origin(unsigned long addr)
+{
+	return (unsigned long)kmsan_get_metadata((void *)addr,
+						 KMSAN_META_ORIGIN);
+}
+
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
+{
+	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
+	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+}
+EXPORT_SYMBOL(kmsan_vunmap_range_noflush);
+
+/*
+ * This function creates new shadow/origin pages for the physical pages mapped
+ * into the virtual memory. If those physical pages already had shadow/origin,
+ * those are ignored.
+ */
+void kmsan_ioremap_page_range(unsigned long start, unsigned long end,
+			      phys_addr_t phys_addr, pgprot_t prot,
+			      unsigned int page_shift)
+{
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_ZERO;
+	struct page *shadow, *origin;
+	unsigned long off = 0;
+	int i, nr;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	kmsan_enter_runtime();
+	for (i = 0; i < nr; i++, off += PAGE_SIZE) {
+		shadow = alloc_pages(gfp_mask, 1);
+		origin = alloc_pages(gfp_mask, 1);
+		__vmap_pages_range_noflush(
+			vmalloc_shadow(start + off),
+			vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
+			PAGE_SHIFT);
+		__vmap_pages_range_noflush(
+			vmalloc_origin(start + off),
+			vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
+			PAGE_SHIFT);
+	}
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_ioremap_page_range);
+
+void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
+{
+	unsigned long v_shadow, v_origin;
+	struct page *shadow, *origin;
+	int i, nr;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	kmsan_enter_runtime();
+	v_shadow = (unsigned long)vmalloc_shadow(start);
+	v_origin = (unsigned long)vmalloc_origin(start);
+	for (i = 0; i < nr; i++, v_shadow += PAGE_SIZE, v_origin += PAGE_SIZE) {
+		shadow = kmsan_vmalloc_to_page_or_null((void *)v_shadow);
+		origin = kmsan_vmalloc_to_page_or_null((void *)v_origin);
+		__vunmap_range_noflush(v_shadow, vmalloc_shadow(end));
+		__vunmap_range_noflush(v_origin, vmalloc_origin(end));
+		if (shadow)
+			__free_pages(shadow, 1);
+		if (origin)
+			__free_pages(origin, 1);
+	}
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_iounmap_page_range);
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index e5ad2972d7362..416cb85487a1a 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -145,3 +145,117 @@ void *kmsan_get_metadata(void *address, bool is_origin)
 
 	return (is_origin ? origin_ptr_for(page) : shadow_ptr_for(page)) + off;
 }
+
+void kmsan_copy_page_meta(struct page *dst, struct page *src)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	if (!dst || !page_has_metadata(dst))
+		return;
+	if (!src || !page_has_metadata(src)) {
+		kmsan_internal_unpoison_memory(page_address(dst), PAGE_SIZE,
+					       /*checked*/ false);
+		return;
+	}
+
+	kmsan_enter_runtime();
+	__memcpy(shadow_ptr_for(dst), shadow_ptr_for(src), PAGE_SIZE);
+	__memcpy(origin_ptr_for(dst), origin_ptr_for(src), PAGE_SIZE);
+	kmsan_leave_runtime();
+}
+
+void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags)
+{
+	bool initialized = (flags & __GFP_ZERO) || !kmsan_enabled;
+	struct page *shadow, *origin;
+	depot_stack_handle_t handle;
+	int pages = 1 << order;
+	int i;
+
+	if (!page)
+		return;
+
+	shadow = shadow_page_for(page);
+	origin = origin_page_for(page);
+
+	if (initialized) {
+		__memset(page_address(shadow), 0, PAGE_SIZE * pages);
+		__memset(page_address(origin), 0, PAGE_SIZE * pages);
+		return;
+	}
+
+	/* Zero pages allocated by the runtime should also be initialized. */
+	if (kmsan_in_runtime())
+		return;
+
+	__memset(page_address(shadow), -1, PAGE_SIZE * pages);
+	kmsan_enter_runtime();
+	handle = kmsan_save_stack_with_flags(flags, /*extra_bits*/ 0);
+	kmsan_leave_runtime();
+	/*
+	 * Addresses are page-aligned, pages are contiguous, so it's ok
+	 * to just fill the origin pages with @handle.
+	 */
+	for (i = 0; i < PAGE_SIZE * pages / sizeof(handle); i++)
+		((depot_stack_handle_t *)page_address(origin))[i] = handle;
+}
+
+void kmsan_free_page(struct page *page, unsigned int order)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	kmsan_internal_poison_memory(page_address(page),
+				     PAGE_SIZE << compound_order(page),
+				     GFP_KERNEL,
+				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
+	kmsan_leave_runtime();
+}
+
+void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				    pgprot_t prot, struct page **pages,
+				    unsigned int page_shift)
+{
+	unsigned long shadow_start, origin_start, shadow_end, origin_end;
+	struct page **s_pages, **o_pages;
+	int nr, i, mapped;
+
+	if (!kmsan_enabled)
+		return;
+
+	shadow_start = vmalloc_meta((void *)start, KMSAN_META_SHADOW);
+	shadow_end = vmalloc_meta((void *)end, KMSAN_META_SHADOW);
+	if (!shadow_start)
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	s_pages = kcalloc(nr, sizeof(*s_pages), GFP_KERNEL);
+	o_pages = kcalloc(nr, sizeof(*o_pages), GFP_KERNEL);
+	if (!s_pages || !o_pages)
+		goto ret;
+	for (i = 0; i < nr; i++) {
+		s_pages[i] = shadow_page_for(pages[i]);
+		o_pages[i] = origin_page_for(pages[i]);
+	}
+	prot = __pgprot(pgprot_val(prot) | _PAGE_NX);
+	prot = PAGE_KERNEL;
+
+	origin_start = vmalloc_meta((void *)start, KMSAN_META_ORIGIN);
+	origin_end = vmalloc_meta((void *)end, KMSAN_META_ORIGIN);
+	kmsan_enter_runtime();
+	mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
+					    s_pages, page_shift);
+	KMSAN_WARN_ON(mapped);
+	mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
+					    o_pages, page_shift);
+	KMSAN_WARN_ON(mapped);
+	kmsan_leave_runtime();
+	flush_tlb_kernel_range(shadow_start, shadow_end);
+	flush_tlb_kernel_range(origin_start, origin_end);
+	flush_cache_vmap(shadow_start, shadow_end);
+	flush_cache_vmap(origin_start, origin_end);
+
+ret:
+	kfree(s_pages);
+	kfree(o_pages);
+}
diff --git a/mm/memory.c b/mm/memory.c
index 7a089145cad4b..947349399e05c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -52,6 +52,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/kmsan.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/export.h>
@@ -3120,6 +3121,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			delayacct_wpcopy_end();
 			return 0;
 		}
+		kmsan_copy_page_meta(new_page, old_page);
 	}
 
 	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485c..785459251145e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -27,6 +27,7 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
+#include <linux/kmsan.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
@@ -1320,6 +1321,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	trace_mm_page_free(page, order);
+	kmsan_free_page(page, order);
 
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/*
@@ -3711,6 +3713,14 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 /*
  * Allocate a page from the given zone. Use pcplists for order-0 allocations.
  */
+
+/*
+ * Do not instrument rmqueue() with KMSAN. This function may call
+ * __msan_poison_alloca() through a call to set_pfnblock_flags_mask().
+ * If __msan_poison_alloca() attempts to allocate pages for the stack depot, it
+ * may call rmqueue() again, which will result in a deadlock.
+ */
+__no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
@@ -5446,6 +5456,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	}
 
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
+	kmsan_alloc_page(page, order, alloc_gfp);
 
 	return page;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index effd1ff6a4b41..6973d7f1ef934 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -320,6 +320,9 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
+	if (!err)
+		kmsan_ioremap_page_range(addr, end, phys_addr, prot,
+					 ioremap_max_page_shift);
 	return err;
 }
 
@@ -416,7 +419,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-void vunmap_range_noflush(unsigned long start, unsigned long end)
+void __vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 	unsigned long next;
 	pgd_t *pgd;
@@ -438,6 +441,12 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
 		arch_sync_kernel_mappings(start, end);
 }
 
+void vunmap_range_noflush(unsigned long start, unsigned long end)
+{
+	kmsan_vunmap_range_noflush(start, end);
+	__vunmap_range_noflush(start, end);
+}
+
 /**
  * vunmap_range - unmap kernel virtual addresses
  * @addr: start of the VM area to unmap
@@ -575,7 +584,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
@@ -601,6 +610,13 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 	return 0;
 }
 
+int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
+{
+	kmsan_vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+}
+
 /**
  * vmap_pages_range - map pages to a kernel virtual address
  * @addr: start of the VM area to map
-- 
2.37.0.rc0.161.g10f37bed90-goog

