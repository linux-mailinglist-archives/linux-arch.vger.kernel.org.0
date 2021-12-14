Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADED54747AE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhLNQWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhLNQWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:36 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523CC061401
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:35 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so8124271wmb.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SHGFxV/gzg6jQ5t0gjyp2ovTzZOCQJ4LpEXLIh7BBvo=;
        b=gLqDvJvAj1s+UtVet2O47yEADN974yana8zFcjRXXUxtrkBKyBLgaZ2HAqBwJY+UcL
         hI1MbnIUZUKNrQBOdT7a48hxDTAFPFAgQ8+yJJnH6ZuS0SfKPeOzZnGLwzRFEy+icZsB
         Qw+w5kU3lfplzKHYhJo2uyWN8VCDHvEfS6rz5RS2v/UzOgeLulPvPcExx4WVOSIYK0k4
         xd36oeHrEaaXfZepx2tUz9ytnGjtCilrSqyRWeNzXQ8TMvoceZY0UeofgGM2ZUlQ16hU
         LjSd0+s8vf43ARXxZMDOaqa4S20p3RKJ1hy8wRZsJsK2M0VrZ/HJ5/IQDGJGWPlrCP5u
         t1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SHGFxV/gzg6jQ5t0gjyp2ovTzZOCQJ4LpEXLIh7BBvo=;
        b=LYSh7rwkfurQm9R8r3POAv4+J10M4FwCRBQBP3GH0W98XTQdWrQ+XmPPDCQYcoJArU
         BOOx45ZOz2hN8clwi5JFtOk3ZYu1T0ovBqcB2M84bJ6i7cc29znlvhNFG5EMDH6nPU6H
         1pgREgWRfo6zhCMyEsaKzIbWsFXP4lFEYXdVTraGnJ2MGaTg1xA1m2TW9CSSleceBFdD
         kLYTdQS3M8cIXwYppNuPWqSefdbvfcwqpu0kqF3tPoyky1AhPUsLzNtPn1/VGxPwVJUY
         cDICqD4v9CJbO3XQUE3LWrzZoa2kJVPeKKzsvEpkYVEQpJB+AOF0XuXPdkbnHTsm5cnM
         nyQw==
X-Gm-Message-State: AOAM530d4GUP7RWNVjE8v/PAZ6pyrmauI7orS0brf60R1Epty/7qQ6VH
        T0ZqrnOgObLf9UAYOTB+OQeVPXHcYK8=
X-Google-Smtp-Source: ABdhPJzy0w1gHA+9P/NuPa42yjowF48uXfrttj3XSDC2uNI+hUQVLdANIi/yKdgT316+epfJDUX1ID5jeus=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:648d:: with SMTP id o13mr6875509wri.636.1639498953968;
 Tue, 14 Dec 2021 08:22:33 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:22 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-16-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 15/43] kmsan: mm: maintain KMSAN metadata for page operations
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Link: https://linux-review.googlesource.com/id/I6d4f53a0e7eab46fa29f0348f3095d9f2e326850
---
 arch/x86/include/asm/page_64.h | 13 +++++++++++++
 arch/x86/mm/ioremap.c          |  3 +++
 include/linux/highmem.h        |  3 +++
 mm/memory.c                    |  2 ++
 mm/page_alloc.c                | 14 ++++++++++++++
 mm/vmalloc.c                   | 20 ++++++++++++++++++--
 6 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc66100c..c10547510f1f4 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -44,14 +44,27 @@ void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
 
+/* This is an assembly header, avoid including too much of kmsan.h */
+#ifdef CONFIG_KMSAN
+void kmsan_unpoison_memory(const void *addr, size_t size);
+#endif
+__no_sanitize_memory
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
index 026031b3b7829..4d0349ecc7cd7 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
+#include <linux/kmsan.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -474,6 +475,8 @@ void iounmap(volatile void __iomem *addr)
 		return;
 	}
 
+	kmsan_iounmap_page_range((unsigned long)addr,
+		(unsigned long)addr + get_vm_area_size(p));
 	memtype_free(p->phys_addr, p->phys_addr + get_vm_area_size(p));
 
 	/* Finally remove it */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 39bb9b47fa9cd..3e1898a44d7e3 100644
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
@@ -277,6 +278,7 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 	vfrom = kmap_local_page(from);
 	vto = kmap_local_page(to);
 	copy_user_page(vto, vfrom, vaddr, to);
+	kmsan_unpoison_memory(page_address(to), PAGE_SIZE);
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 }
@@ -292,6 +294,7 @@ static inline void copy_highpage(struct page *to, struct page *from)
 	vfrom = kmap_local_page(from);
 	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
+	kmsan_copy_page_meta(to, from);
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 }
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dcb..ea9e48daadb15 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -51,6 +51,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/kmsan.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/export.h>
@@ -3003,6 +3004,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				put_page(old_page);
 			return 0;
 		}
+		kmsan_copy_page_meta(new_page, old_page);
 	}
 
 	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40b..fa8029b714a81 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -26,6 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
+#include <linux/kmsan.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
@@ -1288,6 +1289,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	trace_mm_page_free(page, order);
+	kmsan_free_page(page, order);
 
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/*
@@ -1734,6 +1736,9 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 {
 	if (early_page_uninitialised(pfn))
 		return;
+	if (!kmsan_memblock_free_pages(page, order))
+		/* KMSAN will take care of these pages. */
+		return;
 	__free_pages_core(page, order);
 }
 
@@ -3663,6 +3668,14 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
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
@@ -5389,6 +5402,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	}
 
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
+	kmsan_alloc_page(page, order, alloc_gfp);
 
 	return page;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd1..333de26b3c56e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -319,6 +319,9 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
+	if (!err)
+		kmsan_ioremap_page_range(addr, end, phys_addr, prot,
+					 ioremap_max_page_shift);
 	return err;
 }
 
@@ -418,7 +421,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-void vunmap_range_noflush(unsigned long start, unsigned long end)
+void __vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 	unsigned long next;
 	pgd_t *pgd;
@@ -440,6 +443,12 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
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
@@ -574,7 +583,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
@@ -600,6 +609,13 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
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
2.34.1.173.g76aa8bc2d0-goog

