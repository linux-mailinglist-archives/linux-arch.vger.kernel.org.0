Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B05A2A9F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiHZPKr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiHZPKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:10:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E3FDDABB
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dbe61eed8so29848157b3.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=jx2yh37l5SDq2Q8QSIum21pACdE/sm5g4yjUaLUM63Q=;
        b=YwocNvFxNg+yRyYunyC8K2i0xvtr8YUlMRSXD4KB07qL6OVAVJoi69FVpTqeb6vo98
         HNk/rkY+3aMZsuK1uxh+Akq9TcZkV7+UoG9UsOjRo11a/ebkyHu3Zk6ZybTqbnEICNl6
         fVKoim3Gbw01E9ari0gpTSeEb1JS1RrQj9AECprq43H/JBol2bhhdu4xkoVyjXPE9+Ze
         8ecJmXHBW0h1jwcuB7WCNu3ewzYMljdqqcbJK9oNsyWlgppHytBzzquDRDlGLBrz1LbR
         1srEjiZAt2vaWQ/YMD9BNRcRUdlTr4PzP3ErRactmJa3ktJHlpH5z9Y33Q29N2lW/xGz
         lxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jx2yh37l5SDq2Q8QSIum21pACdE/sm5g4yjUaLUM63Q=;
        b=0pDwOewl+fX8+AIxU3DtTklW87p83puQDuSxsPuz++05wc+kbpfN7ERpQzYqk1q/Ru
         gNv5ruJYizBNB1rtNOMipI4NBetRMc+t8VZxF1sDGVi2ZHB+xwdSHRH81jpFGDIvPUx2
         UGRvc/69jV/qkOMFgB7b1ciY0bpy2/dgmFPLznLaCnKt22fAThm2CqgAZTTvAJizgAL4
         kGVlA3J5/OA0koQLkm01jFW7t0+GGDeyw1khG28iDdBbVIjZCo7qFPujqavY5EfBcVUw
         Mv1dN+mOYqAJPOEkcv8nPUdrpNuP2bf4+Ry1uEbxIwt1xASH1aRCPLX9Jwag3oD+yC5E
         Yvow==
X-Gm-Message-State: ACgBeo0n91Akvvo3cPVXMfKXysltrTzJM12hJ3TkhpMCYli+iCH8pdFR
        JT3XELwMKFUPUPF/4mzYm3FttlpMOWI=
X-Google-Smtp-Source: AA6agR603nVbq19tqyU4+Jy5vddr/H1MZ8Z1v7IqPxKbCCNuQvmAeaYyVDn51ytxXs9PxCixOvP5yDsDceQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a81:710a:0:b0:33d:c742:4a20 with SMTP id
 m10-20020a81710a000000b0033dc7424a20mr69884ywc.343.1661526534913; Fri, 26 Aug
 2022 08:08:54 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:38 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-16-glider@google.com>
Subject: [PATCH v5 15/44] mm: kmsan: call KMSAN hooks from SLUB code
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to report uninitialized memory coming from heap allocations
KMSAN has to poison them unless they're created with __GFP_ZERO.

It's handy that we need KMSAN hooks in the places where
init_on_alloc/init_on_free initialization is performed.

In addition, we apply __no_kmsan_checks to get_freepointer_safe() to
suppress reports when accessing freelist pointers that reside in freed
objects.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 -- move the implementation of SLUB hooks here

v4:
 -- change sizeof(type) to sizeof(*ptr)
 -- swap mm: and kmsan: in the subject
 -- get rid of kmsan_init(), replace it with __no_kmsan_checks

v5:
 -- do not export KMSAN hooks that are not called from modules
 -- drop an unnecessary whitespace change

Link: https://linux-review.googlesource.com/id/I6954b386c5c5d7f99f48bb6cbcc74b75136ce86e
---
 include/linux/kmsan.h | 57 ++++++++++++++++++++++++++++++++
 mm/kmsan/hooks.c      | 76 +++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h             |  1 +
 mm/slub.c             | 17 ++++++++++
 4 files changed, 151 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 699fe4f5b3bee..fd76cea338878 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 struct page;
+struct kmem_cache;
 
 #ifdef CONFIG_KMSAN
 
@@ -72,6 +73,44 @@ void kmsan_free_page(struct page *page, unsigned int order);
  */
 void kmsan_copy_page_meta(struct page *dst, struct page *src);
 
+/**
+ * kmsan_slab_alloc() - Notify KMSAN about a slab allocation.
+ * @s:      slab cache the object belongs to.
+ * @object: object pointer.
+ * @flags:  GFP flags passed to the allocator.
+ *
+ * Depending on cache flags and GFP flags, KMSAN sets up the metadata of the
+ * newly created object, marking it as initialized or uninitialized.
+ */
+void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+
+/**
+ * kmsan_slab_free() - Notify KMSAN about a slab deallocation.
+ * @s:      slab cache the object belongs to.
+ * @object: object pointer.
+ *
+ * KMSAN marks the freed object as uninitialized.
+ */
+void kmsan_slab_free(struct kmem_cache *s, void *object);
+
+/**
+ * kmsan_kmalloc_large() - Notify KMSAN about a large slab allocation.
+ * @ptr:   object pointer.
+ * @size:  object size.
+ * @flags: GFP flags passed to the allocator.
+ *
+ * Similar to kmsan_slab_alloc(), but for large allocations.
+ */
+void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+
+/**
+ * kmsan_kfree_large() - Notify KMSAN about a large slab deallocation.
+ * @ptr: object pointer.
+ *
+ * Similar to kmsan_slab_free(), but for large allocations.
+ */
+void kmsan_kfree_large(const void *ptr);
+
 /**
  * kmsan_map_kernel_range_noflush() - Notify KMSAN about a vmap.
  * @start:	start of vmapped range.
@@ -138,6 +177,24 @@ static inline void kmsan_copy_page_meta(struct page *dst, struct page *src)
 {
 }
 
+static inline void kmsan_slab_alloc(struct kmem_cache *s, void *object,
+				    gfp_t flags)
+{
+}
+
+static inline void kmsan_slab_free(struct kmem_cache *s, void *object)
+{
+}
+
+static inline void kmsan_kmalloc_large(const void *ptr, size_t size,
+				       gfp_t flags)
+{
+}
+
+static inline void kmsan_kfree_large(const void *ptr)
+{
+}
+
 static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
 						  unsigned long end,
 						  pgprot_t prot,
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 2624b4ea3d8ef..519a7a1dcb4aa 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -26,6 +26,82 @@
  * skipping effects of functions like memset() inside instrumented code.
  */
 
+void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
+{
+	if (unlikely(object == NULL))
+		return;
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	/*
+	 * There's a ctor or this is an RCU cache - do nothing. The memory
+	 * status hasn't changed since last use.
+	 */
+	if (s->ctor || (s->flags & SLAB_TYPESAFE_BY_RCU))
+		return;
+
+	kmsan_enter_runtime();
+	if (flags & __GFP_ZERO)
+		kmsan_internal_unpoison_memory(object, s->object_size,
+					       KMSAN_POISON_CHECK);
+	else
+		kmsan_internal_poison_memory(object, s->object_size, flags,
+					     KMSAN_POISON_CHECK);
+	kmsan_leave_runtime();
+}
+
+void kmsan_slab_free(struct kmem_cache *s, void *object)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	/* RCU slabs could be legally used after free within the RCU period */
+	if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
+		return;
+	/*
+	 * If there's a constructor, freed memory must remain in the same state
+	 * until the next allocation. We cannot save its state to detect
+	 * use-after-free bugs, instead we just keep it unpoisoned.
+	 */
+	if (s->ctor)
+		return;
+	kmsan_enter_runtime();
+	kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
+				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
+	kmsan_leave_runtime();
+}
+
+void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+{
+	if (unlikely(ptr == NULL))
+		return;
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	if (flags & __GFP_ZERO)
+		kmsan_internal_unpoison_memory((void *)ptr, size,
+					       /*checked*/ true);
+	else
+		kmsan_internal_poison_memory((void *)ptr, size, flags,
+					     KMSAN_POISON_CHECK);
+	kmsan_leave_runtime();
+}
+
+void kmsan_kfree_large(const void *ptr)
+{
+	struct page *page;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	page = virt_to_head_page((void *)ptr);
+	KMSAN_WARN_ON(ptr != page_address(page));
+	kmsan_internal_poison_memory((void *)ptr,
+				     PAGE_SIZE << compound_order(page),
+				     GFP_KERNEL,
+				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
+	kmsan_leave_runtime();
+}
+
 static unsigned long vmalloc_shadow(unsigned long addr)
 {
 	return (unsigned long)kmsan_get_metadata((void *)addr,
diff --git a/mm/slab.h b/mm/slab.h
index 4ec82bec15ecd..9d0afd2985df7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -729,6 +729,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 			memset(p[i], 0, s->object_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
+		kmsan_slab_alloc(s, p[i], flags);
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f52..2c323d83d0526 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -22,6 +22,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kasan.h>
+#include <linux/kmsan.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/mempolicy.h>
@@ -359,6 +360,17 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 	prefetchw(object + s->offset);
 }
 
+/*
+ * When running under KMSAN, get_freepointer_safe() may return an uninitialized
+ * pointer value in the case the current thread loses the race for the next
+ * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
+ * slab_alloc_node() will fail, so the uninitialized value won't be used, but
+ * KMSAN will still check all arguments of cmpxchg because of imperfect
+ * handling of inline assembly.
+ * To work around this problem, we apply __no_kmsan_checks to ensure that
+ * get_freepointer_safe() returns initialized memory.
+ */
+__no_kmsan_checks
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
 {
 	unsigned long freepointer_addr;
@@ -1709,6 +1721,7 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
+	kmsan_kmalloc_large(ptr, size, flags);
 	return ptr;
 }
 
@@ -1716,12 +1729,14 @@ static __always_inline void kfree_hook(void *x)
 {
 	kmemleak_free(x);
 	kasan_kfree_large(x);
+	kmsan_kfree_large(x);
 }
 
 static __always_inline bool slab_free_hook(struct kmem_cache *s,
 						void *x, bool init)
 {
 	kmemleak_free_recursive(x, s->flags);
+	kmsan_slab_free(s, x);
 
 	debug_check_no_locks_freed(x, s->object_size);
 
@@ -5915,6 +5930,7 @@ static char *create_unique_id(struct kmem_cache *s)
 	p += sprintf(p, "%07u", s->size);
 
 	BUG_ON(p > name + ID_STR_LENGTH - 1);
+	kmsan_unpoison_memory(name, p - name);
 	return name;
 }
 
@@ -6016,6 +6032,7 @@ static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
 	al->name = name;
 	al->next = alias_list;
 	alias_list = al;
+	kmsan_unpoison_memory(al, sizeof(*al));
 	return 0;
 }
 
-- 
2.37.2.672.g94769d06f0-goog

