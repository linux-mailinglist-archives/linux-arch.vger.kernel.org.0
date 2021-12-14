Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19844747AB
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhLNQWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhLNQWj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:39 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C5C061574
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:38 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 30-20020a508e5e000000b003f02e458b17so17467863edx.17
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l+xyVLYgnwfnFRoJMzTKh10TTGj06mIlcmxJ5/UGlBQ=;
        b=QooFOWp2lk3/dKVKqOC7MDgcKwTO9DGY48nPfSpN6VPUKJEZ0SbsY1PzLSGm0HOGyh
         A0v+L3T0XhHrYN84dELB+dSr61gJdgPYVpYRMz7zu8WU3qXKDQzRIi0NL2e8SVfMvc8p
         c14YgIf/6oMVYfqCfWyzQ5jBFZ4txHdG+dSpPpw3+/pgqTcFFQEo1WS7Igeun3EJI3B/
         JO6EPKjSnDb2mm6geVtm1W5m058MaTfx2hfyOSP6BjwFa/8xWrVisENezxQfB1oZssEC
         FSfyawA8GY+PgsVbf/6u8Vw6m/CqLTjPwLCN+lvMtHUr0RIO9cq3e1mEylRB0+I899xL
         RoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l+xyVLYgnwfnFRoJMzTKh10TTGj06mIlcmxJ5/UGlBQ=;
        b=EcWWXjipwygmsc8V+Cl8Joa1d6N7p1PaXBKeheLeMqmXEd+TRUl4N4WmJdbm25bc4T
         AiWTaToHINA42n2Lk/QHce5KNpubRDROM2JpukF8kChAeYy2iGwLsvWCAEWQjjad70wj
         l4rm3uKETKmMGZCjWqan7JGwvQ4AJkV62Z8LOjTl2jlWNPO3ywDxYL99DwlnQMMfVMTX
         baQe2QCdcfvA3x2j1wdCFOnyHj/afDxvCob9pc3L4mTFmt5LfN3rsXQ0kiAZEXgYtfuD
         2sGAHuar9l73RAbQuAzRd+YnQ2wbWGjsXCLrJ35e1xkZdn24LQ6A3H8XvBN1B5SSk8jF
         gFYQ==
X-Gm-Message-State: AOAM531z8dTRHfr2R3mh26iYSfzfT7b9WtCxCR7RP+3CS5FJYMHnHjll
        qFZIU4jiVfgFPpqK3tKRadZPT1dlDGo=
X-Google-Smtp-Source: ABdhPJztDlcuNNiWUlHLDRp2NxbkZc1rACcRnXIrugF8C58vuD1abHGLk1hNOWIpStZ9q4sY8JIsWSVOIBI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:906:d975:: with SMTP id
 rp21mr6647872ejb.756.1639498956586; Tue, 14 Dec 2021 08:22:36 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:23 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-17-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 16/43] kmsan: mm: call KMSAN hooks from SLUB code
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

In order to report uninitialized memory coming from heap allocations
KMSAN has to poison them unless they're created with __GFP_ZERO.

It's handy that we need KMSAN hooks in the places where
init_on_alloc/init_on_free initialization is performed.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I6954b386c5c5d7f99f48bb6cbcc74b75136ce86e
---
 mm/slab.h |  1 +
 mm/slub.c | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 56ad7eea3ddfb..6175a74047b47 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -521,6 +521,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 			memset(p[i], 0, s->object_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
+		kmsan_slab_alloc(s, p[i], flags);
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
diff --git a/mm/slub.c b/mm/slub.c
index abe7db581d686..5a63486e52531 100644
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
@@ -346,10 +347,13 @@ static inline void *freelist_dereference(const struct kmem_cache *s,
 			    (unsigned long)ptr_addr);
 }
 
+/*
+ * See the comment to get_freepointer_safe().
+ */
 static inline void *get_freepointer(struct kmem_cache *s, void *object)
 {
 	object = kasan_reset_tag(object);
-	return freelist_dereference(s, object + s->offset);
+	return kmsan_init(freelist_dereference(s, object + s->offset));
 }
 
 static void prefetch_freepointer(const struct kmem_cache *s, void *object)
@@ -357,18 +361,28 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 	prefetchw(object + s->offset);
 }
 
+/*
+ * When running under KMSAN, get_freepointer_safe() may return an uninitialized
+ * pointer value in the case the current thread loses the race for the next
+ * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
+ * slab_alloc_node() will fail, so the uninitialized value won't be used, but
+ * KMSAN will still check all arguments of cmpxchg because of imperfect
+ * handling of inline assembly.
+ * To work around this problem, use kmsan_init() to force initialize the
+ * return value of get_freepointer_safe().
+ */
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
 {
 	unsigned long freepointer_addr;
 	void *p;
 
 	if (!debug_pagealloc_enabled_static())
-		return get_freepointer(s, object);
+		return kmsan_init(get_freepointer(s, object));
 
 	object = kasan_reset_tag(object);
 	freepointer_addr = (unsigned long)object + s->offset;
 	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
-	return freelist_ptr(s, p, freepointer_addr);
+	return kmsan_init(freelist_ptr(s, p, freepointer_addr));
 }
 
 static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
@@ -1678,6 +1692,7 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
+	kmsan_kmalloc_large(ptr, size, flags);
 	return ptr;
 }
 
@@ -1685,12 +1700,14 @@ static __always_inline void kfree_hook(void *x)
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
 
@@ -3729,6 +3746,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 */
 	slab_post_alloc_hook(s, objcg, flags, size, p,
 				slab_want_init_on_alloc(flags, s));
+
 	return i;
 error:
 	slub_put_cpu_ptr(s->cpu_slab);
@@ -5905,6 +5923,7 @@ static char *create_unique_id(struct kmem_cache *s)
 	p += sprintf(p, "%07u", s->size);
 
 	BUG_ON(p > name + ID_STR_LENGTH - 1);
+	kmsan_unpoison_memory(name, p - name);
 	return name;
 }
 
@@ -6006,6 +6025,7 @@ static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
 	al->name = name;
 	al->next = alias_list;
 	alias_list = al;
+	kmsan_unpoison_memory(al, sizeof(struct saved_alias));
 	return 0;
 }
 
-- 
2.34.1.173.g76aa8bc2d0-goog

