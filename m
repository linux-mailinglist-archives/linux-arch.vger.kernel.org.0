Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF57D5301
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJXNuU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjJXNtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:49:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333471FDC
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7aa161b2fso57976627b3.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155255; x=1698760055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgU+pcxUdPHIak08TaAB2rSrJMdjgr1bUXnQB/iAGbQ=;
        b=CCkWMNmNuPPJ60JDCw60uY4UR73UY7F292bfvoWwoyqURv110AZL1LPNGSD3dYqZuO
         UFaXCprbj+MrPVG3BRN/h0kj6n+VeXRTwkfDrLvKtiHNfx1Yd8gWhCRe5VLKDOk/872h
         +GdyxKVwxOPh63LWsqT5zLXVBJUd0CZK8XYFl10JdJgjWeg5xh9vYoKPvkt4Gzl5+rqE
         f+0kXw0aBhwv767uIoP2889B3pK4tj1R0piVHajM+pAVev1W+O9Oy8QWNAmjypzdBdOF
         8/ZfnciBlyYDxMJ12Nb5hcsi6mUFn3kTMALht7EXMQ4P+FXNd0xqA5WyLHt7cPL/KdTB
         Xj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155255; x=1698760055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgU+pcxUdPHIak08TaAB2rSrJMdjgr1bUXnQB/iAGbQ=;
        b=iJ7OpjFN4+b/tqewAFb9dc2Vl3Cflct0fd4JPJRxWmqYpIdGtdT2rpHPO62lkrcqV0
         0cXgRXRxcGEzL5rFkQQmA2dpObz3XRDyOM3aAY3ktA7ERf1oAoB6Ji46DSlNn2crfmK/
         npmaFAfVW/uruQFTE0zYREUvdbcu+GDDicxzGHQj4DiNrphdJEPVHfRo4qGefugtX3/Y
         JzqFDvpiwJQvKeQErw5fCPeGGyohQdpey3K2v17sM4idyZmUsBekKF92HLiPAfro4Div
         YAj4YPlWP+VU8gV3dwbyItTSQJtSVkGTDbCezuzXR38Lt1S4YApsKSAJUcLIYu+UofW7
         Up/w==
X-Gm-Message-State: AOJu0YyzAQYLOCz9PVh9ZdOKpHt5VeWpK8OU9+wnA1ZjIBnz/lA40Yay
        0pFHc7b7GwZkkipUvptXfh3uhVD1Ssc=
X-Google-Smtp-Source: AGHT+IH99U95XbIJleJRvWe1tdmgTc3A/ryOVVoVSn5UdR3NB6RxslzPIkyuREwn+3gBRv/mIBt+xGxQfKM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a81:a157:0:b0:5a8:d81f:f5e7 with SMTP id
 y84-20020a81a157000000b005a8d81ff5e7mr260833ywg.8.1698155255155; Tue, 24 Oct
 2023 06:47:35 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:21 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-25-surenb@google.com>
Subject: [PATCH v2 24/39] mm/slab: enable slab allocation tagging for kmalloc
 and friends
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, surenb@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
and deallocations done by these functions.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/fortify-string.h |   5 +-
 include/linux/slab.h           | 173 ++++++++++++++++-----------------
 include/linux/string.h         |   4 +-
 mm/slab.c                      |  18 ++--
 mm/slab_common.c               |  38 ++++----
 mm/slub.c                      |  19 ++--
 mm/util.c                      |  20 ++--
 7 files changed, 137 insertions(+), 140 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index da51a83b2829..11319e7634a4 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -752,9 +752,9 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	return __real_memchr_inv(p, c, size);
 }
 
-extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup)
+extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup_noprof)
 								    __realloc_size(2);
-__FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup_noprof(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	const size_t p_size = __struct_size(p);
 
@@ -764,6 +764,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 		fortify_panic(__func__);
 	return __real_kmemdup(p, size, gfp);
 }
+#define kmemdup(...)	alloc_hooks(kmemdup_noprof(__VA_ARGS__))
 
 /**
  * strcpy - Copy a string into another string buffer
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11ef3d364b2b..0543e0f76c60 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -230,7 +230,9 @@ int kmem_cache_shrink(struct kmem_cache *s);
 /*
  * Common kmalloc functions provided by all allocators
  */
-void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __realloc_size(2);
+void * __must_check krealloc_noprof(const void *objp, size_t new_size, gfp_t flags) __realloc_size(2);
+#define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
+
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
@@ -491,7 +493,10 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 
-void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
+#include <linux/alloc_tag.h>
+
+void *__kmalloc_noprof(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
+#define __kmalloc(...)				alloc_hooks(__kmalloc_noprof(__VA_ARGS__))
 
 /**
  * kmem_cache_alloc - Allocate an object
@@ -503,9 +508,13 @@ void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_siz
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags) __assume_slab_alignment __malloc;
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			   gfp_t gfpflags) __assume_slab_alignment __malloc;
+void *kmem_cache_alloc_noprof(struct kmem_cache *cachep, gfp_t flags) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc(...)			alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
+
+void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
+			    gfp_t gfpflags) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc_lru(...)		alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
+
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
@@ -516,29 +525,40 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
  * Note that interrupts must be enabled when calling these functions.
  */
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
+
+int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
+#define kmem_cache_alloc_bulk(...)		alloc_hooks(kmem_cache_alloc_bulk_noprof(__VA_ARGS__))
 
 static __always_inline void kfree_bulk(size_t size, void **p)
 {
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
+void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
 							 __alloc_size(1);
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
-									 __malloc;
+#define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
 
-void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
+void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
+									  __malloc;
+#define kmem_cache_alloc_node(...)		alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
+
+void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
 		    __assume_kmalloc_alignment __alloc_size(3);
 
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-			 int node, size_t size) __assume_kmalloc_alignment
+void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
+		int node, size_t size) __assume_kmalloc_alignment
 						__alloc_size(4);
-void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+#define kmalloc_trace(...)			alloc_hooks(kmalloc_trace_noprof(__VA_ARGS__))
+
+#define kmalloc_node_trace(...)			alloc_hooks(kmalloc_node_trace_noprof(__VA_ARGS__))
+
+void *kmalloc_large_noprof(size_t size, gfp_t flags) __assume_page_alignment
 					      __alloc_size(1);
+#define kmalloc_large(...)			alloc_hooks(kmalloc_large_noprof(__VA_ARGS__))
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_alignment
+void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node) __assume_page_alignment
 							     __alloc_size(1);
+#define kmalloc_large_node(...)			alloc_hooks(kmalloc_large_node_noprof(__VA_ARGS__))
 
 /**
  * kmalloc - allocate kernel memory
@@ -594,37 +614,39 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
-static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large(size, flags);
+			return kmalloc_large_noprof(size, flags);
 
 		index = kmalloc_index(size);
-		return kmalloc_trace(
+		return kmalloc_trace_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
-	return __kmalloc(size, flags);
+	return __kmalloc_noprof(size, flags);
 }
+#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
-static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_node(size, flags, node);
+			return kmalloc_large_node_noprof(size, flags, node);
 
 		index = kmalloc_index(size);
-		return kmalloc_node_trace(
+		return kmalloc_node_trace_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node(size, flags, node);
+	return __kmalloc_node_noprof(size, flags, node);
 }
+#define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
 /**
  * kmalloc_array - allocate memory for an array.
@@ -632,16 +654,17 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1, 2) void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
-		return kmalloc(bytes, flags);
-	return __kmalloc(bytes, flags);
+		return kmalloc_noprof(bytes, flags);
+	return kmalloc_noprof(bytes, flags);
 }
+#define kmalloc_array(...)			alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
 
 /**
  * krealloc_array - reallocate memory for an array.
@@ -650,18 +673,19 @@ static inline __alloc_size(1, 2) void *kmalloc_array(size_t n, size_t size, gfp_
  * @new_size: new size of a single member of the array
  * @flags: the type of memory to allocate (see kmalloc)
  */
-static inline __realloc_size(2, 3) void * __must_check krealloc_array(void *p,
-								      size_t new_n,
-								      size_t new_size,
-								      gfp_t flags)
+static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
+								       size_t new_n,
+								       size_t new_size,
+								       gfp_t flags)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
 		return NULL;
 
-	return krealloc(p, bytes, flags);
+	return krealloc_noprof(p, bytes, flags);
 }
+#define krealloc_array(...)			alloc_hooks(krealloc_array_noprof(__VA_ARGS__))
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
@@ -669,16 +693,11 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array(void *p,
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flags)
-{
-	return kmalloc_array(n, size, flags | __GFP_ZERO);
-}
+#define kcalloc(_n, _size, _flags)		kmalloc_array(_n, _size, (_flags) | __GFP_ZERO)
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
 				  unsigned long caller) __alloc_size(1);
-#define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
-				    _RET_IP_)
+#define kmalloc_node_track_caller(...)		alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
 
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
@@ -688,11 +707,9 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
  * allocator where we care about the real place the memory allocation
  * request comes from.
  */
-#define kmalloc_track_caller(size, flags) \
-	__kmalloc_node_track_caller(size, flags, \
-				    NUMA_NO_NODE, _RET_IP_)
+#define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
 
-static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
+static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
 							  int node)
 {
 	size_t bytes;
@@ -700,75 +717,51 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size,
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
-		return kmalloc_node(bytes, flags, node);
-	return __kmalloc_node(bytes, flags, node);
+		return kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node_noprof(bytes, flags, node);
 }
+#define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
-static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
-{
-	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
-}
+#define kcalloc_node(_n, _size, _flags, _node)	kmalloc_array_node(_n, _size, (_flags) | __GFP_ZERO, _node)
 
 /*
  * Shortcuts
  */
-static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
-{
-	return kmem_cache_alloc(k, flags | __GFP_ZERO);
-}
+#define kmem_cache_zalloc(_k, _flags)		kmem_cache_alloc(_k, (_flags)|__GFP_ZERO)
 
 /**
  * kzalloc - allocate memory. The memory is set to zero.
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
+static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 {
-	return kmalloc(size, flags | __GFP_ZERO);
+	return kmalloc_noprof(size, flags | __GFP_ZERO);
 }
+#define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
+#define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-/**
- * kzalloc_node - allocate zeroed memory from a particular memory node.
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate (see kmalloc).
- * @node: memory node from which to allocate
- */
-static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int node)
-{
-	return kmalloc_node(size, flags | __GFP_ZERO, node);
-}
+extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_size(1);
+#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node) __alloc_size(1);
-static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc_node(size, flags, NUMA_NO_NODE);
-}
-static inline __alloc_size(1) void *kvzalloc_node(size_t size, gfp_t flags, int node)
-{
-	return kvmalloc_node(size, flags | __GFP_ZERO, node);
-}
-static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc(size, flags | __GFP_ZERO);
-}
+#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
+#define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
 
-static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
+#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
 
-	return kvmalloc(bytes, flags);
-}
+#define kvmalloc_array(_n, _size, _flags)						\
+({											\
+	size_t _bytes;									\
+											\
+	!check_mul_overflow(_n, _size, &_bytes) ? kvmalloc(_bytes, _flags) : NULL;	\
+})
 
-static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)
-{
-	return kvmalloc_array(n, size, flags | __GFP_ZERO);
-}
+#define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__GFP_ZERO)
 
-extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
+#define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
+
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..9516258d8117 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -176,7 +176,9 @@ extern void kfree_const(const void *x);
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
+extern void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
+#define kmemdup(...)	alloc_hooks(kmemdup_noprof(__VA_ARGS__))
+
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
diff --git a/mm/slab.c b/mm/slab.c
index 18923f5f05b5..f75519fa89b9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3429,18 +3429,18 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 	return ret;
 }
 
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+void *kmem_cache_alloc_noprof(struct kmem_cache *cachep, gfp_t flags)
 {
 	return __kmem_cache_alloc_lru(cachep, NULL, flags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(kmem_cache_alloc_noprof);
 
-void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
+void *kmem_cache_alloc_lru_noprof(struct kmem_cache *cachep, struct list_lru *lru,
 			   gfp_t flags)
 {
 	return __kmem_cache_alloc_lru(cachep, lru, flags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
+EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
 static __always_inline void
 cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
@@ -3452,8 +3452,8 @@ cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
 		p[i] = cache_alloc_debugcheck_after(s, flags, p[i], caller);
 }
 
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
-			  void **p)
+int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
+				 void **p)
 {
 	struct obj_cgroup *objcg = NULL;
 	unsigned long irqflags;
@@ -3491,7 +3491,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_bulk);
+EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
@@ -3506,7 +3506,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node_noprof(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
@@ -3514,7 +3514,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
 void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 			     int nodeid, size_t orig_size,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 446f406d2703..8ef5e47ff6a7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1077,24 +1077,24 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 	return ret;
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	return __do_kmalloc_node(size, flags, node, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc_node);
+EXPORT_SYMBOL(__kmalloc_node_noprof);
 
-void *__kmalloc(size_t size, gfp_t flags)
+void *__kmalloc_noprof(size_t size, gfp_t flags)
 {
 	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc);
+EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
-				  int node, unsigned long caller)
+void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
+				       int node, unsigned long caller)
 {
 	return __do_kmalloc_node(size, flags, node, caller);
 }
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
+EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
 
 /**
  * kfree - free previously allocated memory
@@ -1161,7 +1161,7 @@ size_t __ksize(const void *object)
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 
-void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
 					    size, _RET_IP_);
@@ -1171,9 +1171,9 @@ void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_trace);
+EXPORT_SYMBOL(kmalloc_trace_noprof);
 
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
 			 int node, size_t size)
 {
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
@@ -1183,7 +1183,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_node_trace);
+EXPORT_SYMBOL(kmalloc_node_trace_noprof);
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
 {
@@ -1213,7 +1213,7 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 		flags = kmalloc_fix_flags(flags);
 
 	flags |= __GFP_COMP;
-	page = alloc_pages_node(node, flags, order);
+	page = alloc_pages_node_noprof(node, flags, order);
 	if (page) {
 		ptr = page_address(page);
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
@@ -1228,7 +1228,7 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
-void *kmalloc_large(size_t size, gfp_t flags)
+void *kmalloc_large_noprof(size_t size, gfp_t flags)
 {
 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
@@ -1236,9 +1236,9 @@ void *kmalloc_large(size_t size, gfp_t flags)
 		      flags, NUMA_NO_NODE);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large);
+EXPORT_SYMBOL(kmalloc_large_noprof);
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 {
 	void *ret = __kmalloc_large_node(size, flags, node);
 
@@ -1246,7 +1246,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 		      flags, node);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_node);
+EXPORT_SYMBOL(kmalloc_large_node_noprof);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
@@ -1460,7 +1460,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 		return (void *)p;
 	}
 
-	ret = kmalloc_track_caller(new_size, flags);
+	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
@@ -1484,7 +1484,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
  *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
-void *krealloc(const void *p, size_t new_size, gfp_t flags)
+void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
 
@@ -1499,7 +1499,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 
 	return ret;
 }
-EXPORT_SYMBOL(krealloc);
+EXPORT_SYMBOL(krealloc_noprof);
 
 /**
  * kfree_sensitive - Clear sensitive information in memory before freeing
diff --git a/mm/slub.c b/mm/slub.c
index d16643492320..f5e07d8802e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3497,18 +3497,18 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 	return ret;
 }
 
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+void *kmem_cache_alloc_noprof(struct kmem_cache *s, gfp_t gfpflags)
 {
 	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(kmem_cache_alloc_noprof);
 
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
 	return __kmem_cache_alloc_lru(s, lru, gfpflags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
+EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
@@ -3518,7 +3518,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			       caller, orig_size);
 }
 
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
+void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
@@ -3526,7 +3526,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
@@ -3802,6 +3802,7 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 				      unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
+	alloc_tagging_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
@@ -4032,8 +4033,8 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 #endif /* CONFIG_SLUB_TINY */
 
 /* Note that interrupts must be enabled when calling this function. */
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
-			  void **p)
+int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
+		                 void **p)
 {
 	int i;
 	struct obj_cgroup *objcg = NULL;
@@ -4057,7 +4058,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			slab_want_init_on_alloc(flags, s), s->object_size);
 	return i;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_bulk);
+EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 8cbbfd3a3d59..27ed6a5ac31a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -115,7 +115,7 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
 EXPORT_SYMBOL(kstrndup);
 
 /**
- * kmemdup - duplicate region of memory
+ * kmemdup_noprof - duplicate region of memory
  *
  * @src: memory region to duplicate
  * @len: memory region length
@@ -124,16 +124,16 @@ EXPORT_SYMBOL(kstrndup);
  * Return: newly allocated copy of @src or %NULL in case of error,
  * result is physically contiguous. Use kfree() to free.
  */
-void *kmemdup(const void *src, size_t len, gfp_t gfp)
+void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, gfp);
+	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
 	if (p)
 		memcpy(p, src, len);
 	return p;
 }
-EXPORT_SYMBOL(kmemdup);
+EXPORT_SYMBOL(kmemdup_noprof);
 
 /**
  * kvmemdup - duplicate region of memory
@@ -567,7 +567,7 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 EXPORT_SYMBOL(vm_mmap);
 
 /**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * kvmalloc_node_noprof - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
@@ -582,7 +582,7 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node(size_t size, gfp_t flags, int node)
+void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -604,7 +604,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node(size, kmalloc_flags, node);
+	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -633,7 +633,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(kvmalloc_node);
+EXPORT_SYMBOL(kvmalloc_node_noprof);
 
 /**
  * kvfree() - Free memory.
@@ -672,7 +672,7 @@ void kvfree_sensitive(const void *addr, size_t len)
 }
 EXPORT_SYMBOL(kvfree_sensitive);
 
-void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 {
 	void *newp;
 
@@ -685,7 +685,7 @@ void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 	kvfree(p);
 	return newp;
 }
-EXPORT_SYMBOL(kvrealloc);
+EXPORT_SYMBOL(kvrealloc_noprof);
 
 /**
  * __vmalloc_array - allocate memory for a virtually contiguous array.
-- 
2.42.0.758.gaed0368e0e-goog

