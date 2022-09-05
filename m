Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1E5AD2C6
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiIEM1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIEM0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:26:43 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3954CBA
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:39 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id q32-20020a05640224a000b004462f105fa9so5687242eda.4
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Ovg29tOGV0MBaJSgEZI8XqfnbTwhQ8WU6IE7DIFXMYM=;
        b=eCahA6YlWLTGTTi1hCmUOqkoxHsfRWbwrk0khGEmEwE26GludLvpbkp+iNxED27up+
         QeoMCrkZxrN14gO34aHeRK2qqitcfAIctM6kl9eLc9WwGK06RWETZUv60vbfv+iSZG3E
         DFWFLeSBqNnNChbHXHtgrkYP2H5OdFH632JiYUZ1QUZX5C6JlcKbkts6+kHDZaEROFwH
         x+OorqG1kZSqsSdN1WiXZ2L7CUPb13+wg6h8z8YE4H7g7OH1vea0FWKlqN4Mmgwznvou
         NOfI+cIToxZacDt0S41MmHfjdmJSSCOp4vW3YAqX9P02uLfG4/gvX6e4nmD/mlgB97UF
         8+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ovg29tOGV0MBaJSgEZI8XqfnbTwhQ8WU6IE7DIFXMYM=;
        b=xHQckIebo0OiPNsQUpwsUCOL4vUy02NbIeEqi90IcHI5X0TFp4o0s3XtUuoHCEvMFU
         Qe7CBXpQck9nZLRSYFIGwh/zvAI1HqXYdRA0PAmY9dHa77eeTcCydKdkL7sSH95U5Zs/
         21IVf4GWF0PPI+COyVFHNodPAg2zMQrLsS7WwPuogR/aWaZbid68wJ3gp2ngPN8oURJL
         u4i6u0oC5dCPrmOAUvPkTV99SK05L4qjn7rj29vOveTx2GX6yfc145olbLUlZILjvJrC
         KGfs4mX4J0TTB327kF3oEsF0jOQQ05Xi9XsoQlt+FMTY2FFPZ2JBwLluBM3BH6QBfN5W
         FLmA==
X-Gm-Message-State: ACgBeo1J/PMflroetbctw3x0G6bnoCU6W/GuEXKNoEa0koErgKz0fDk6
        w2D12xF2vZTbdcQtalJARVU5NlawxBQ=
X-Google-Smtp-Source: AA6agR6Z/3bvzyUl9jV0ldouDXOG58iDLniTuGjiPLY9l/OIDayJnLlasjvB+pKoDXMbo05eXSrEfkpQ63E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:c002:b0:73d:d96c:c632 with SMTP id
 ss2-20020a170907c00200b0073dd96cc632mr33992978ejc.543.1662380738625; Mon, 05
 Sep 2022 05:25:38 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:23 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-16-glider@google.com>
Subject: [PATCH v6 15/44] mm: kmsan: call KMSAN hooks from SLUB code
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
index b36bf3db835ee..5c4e0079054e6 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 struct page;
+struct kmem_cache;
 
 #ifdef CONFIG_KMSAN
 
@@ -48,6 +49,44 @@ void kmsan_free_page(struct page *page, unsigned int order);
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
@@ -114,6 +153,24 @@ static inline void kmsan_copy_page_meta(struct page *dst, struct page *src)
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
index 040111bb9f6a3..000703c563a4d 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -27,6 +27,82 @@
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
2.37.2.789.g6183377224-goog

