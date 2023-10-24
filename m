Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA107D532F
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjJXNvK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjJXNuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:50:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202EB118
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so60190077b3.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155277; x=1698760077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqQmkpquk/zEN/BrXUtfRL7OAs/mhY9q/VQlYA3NCSg=;
        b=PC+YSAAB05pP8/DGW01idGH1Sx+pmaGfrQBVOAsb9RDuNajRuxrICqon1lOUz95r0Z
         0bhCjYlXi8XxTKH5HBQXC5FIV6f7eAnescJlmzESVtYMSpddQZn4sdhYwxSblsTfRJ9g
         s2YOPi4PayceyUZiVRmRxE6eEB5w6ddHzxn9GT42kFWO5DRAy+o9EKcqFPHF8aFnuhS6
         ct14v1THJgKpZ9Sf0TkLE0I2dXATAW8amhXbBD/HAbZHsAjn6IMC9HQWM+1cryjWufeV
         vqh6eBGMXjgFdA2W+0P9Pxq8dE3n0vZGGtolZv2DzT/NzLHbTMPPFVsIf1cOgMCj7+T5
         TeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155277; x=1698760077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqQmkpquk/zEN/BrXUtfRL7OAs/mhY9q/VQlYA3NCSg=;
        b=YPfLyarCONPADTsmnpfXtHPMUv6lmW1nmrqlFdRRZjrFNtBflA7fLjK5qhK8t+JJPu
         QngcCIR0zWw3OoKS5oaM4LL0EfxvOOxQIDSnMw7GOr6vyl1nWPu+EWU/T7nwGoIzSgJR
         FbaK5R+wmM/SDG/wsbvpT7zaLkBzn4oYXMM0X0BiBHqEvCugpKvKymu6XwiwS2RILXE5
         GHR+iXOoJZDyBC8ooHZwl9GL3/4bSTmwPCCVdKcoqFO0Zt09kCJ7H6v/iV7hP1LYke/0
         4OMFXoT5ESGobF/luMM7wqvqKMVg9GVklml96TnL17DutQhEkZyl2pXDldI0KKJZZaXQ
         ofYw==
X-Gm-Message-State: AOJu0Yz5iVGb+iUwOrjSyecsfNHFlrSIEvupmBR5gGjavCHO+UIS3WLD
        XIjh9zALhUyZLwHKXTygCL+anjckTfw=
X-Google-Smtp-Source: AGHT+IH6wvOVzrOaaGyY1/e57eYHLfTZ/5bwoybFh+Q+IMjNK5yyYqtlQtnc2beg11hZB/FoRq4QkUDgnBs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a81:4853:0:b0:5a8:3f07:ddd6 with SMTP id
 v80-20020a814853000000b005a83f07ddd6mr266393ywa.6.1698155277184; Tue, 24 Oct
 2023 06:47:57 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:31 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-35-surenb@google.com>
Subject: [PATCH v2 34/39] rhashtable: Plumb through alloc tag
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

From: Kent Overstreet <kent.overstreet@linux.dev>

This gives better memory allocation profiling results; rhashtable
allocations will be accounted to the code that initialized the
rhashtable.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/rhashtable-types.h | 11 +++++--
 lib/rhashtable.c                 | 52 +++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 57467cbf4c5b..aac2984c2ef0 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_RHASHTABLE_TYPES_H
 #define _LINUX_RHASHTABLE_TYPES_H
 
+#include <linux/alloc_tag.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
@@ -88,6 +89,9 @@ struct rhashtable {
 	struct mutex                    mutex;
 	spinlock_t			lock;
 	atomic_t			nelems;
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	struct alloc_tag		*alloc_tag;
+#endif
 };
 
 /**
@@ -127,9 +131,12 @@ struct rhashtable_iter {
 	bool end_of_table;
 };
 
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params);
-int rhltable_init(struct rhltable *hlt,
+#define rhashtable_init(...)	alloc_hooks(rhashtable_init_noprof(__VA_ARGS__))
+
+int rhltable_init_noprof(struct rhltable *hlt,
 		  const struct rhashtable_params *params);
+#define rhltable_init(...)	alloc_hooks(rhltable_init_noprof(__VA_ARGS__))
 
 #endif /* _LINUX_RHASHTABLE_TYPES_H */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..b62116f332b8 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -63,6 +63,27 @@ EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #define ASSERT_RHT_MUTEX(HT)
 #endif
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline void rhashtable_alloc_tag_init(struct rhashtable *ht)
+{
+	ht->alloc_tag = current->alloc_tag;
+}
+
+static inline struct alloc_tag *rhashtable_alloc_tag_save(struct rhashtable *ht)
+{
+	return alloc_tag_save(ht->alloc_tag);
+}
+
+static inline void rhashtable_alloc_tag_restore(struct rhashtable *ht, struct alloc_tag *old)
+{
+	alloc_tag_restore(ht->alloc_tag, old);
+}
+#else
+#define rhashtable_alloc_tag_init(ht)
+static inline struct alloc_tag *rhashtable_alloc_tag_save(struct rhashtable *ht) { return NULL; }
+#define rhashtable_alloc_tag_restore(ht, old)
+#endif
+
 static inline union nested_table *nested_table_top(
 	const struct bucket_table *tbl)
 {
@@ -130,7 +151,7 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 	if (ntbl)
 		return ntbl;
 
-	ntbl = kzalloc(PAGE_SIZE, GFP_ATOMIC);
+	ntbl = kmalloc_noprof(PAGE_SIZE, GFP_ATOMIC|__GFP_ZERO);
 
 	if (ntbl && leaf) {
 		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0]); i++)
@@ -157,7 +178,7 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 
 	size = sizeof(*tbl) + sizeof(tbl->buckets[0]);
 
-	tbl = kzalloc(size, gfp);
+	tbl = kmalloc_noprof(size, gfp|__GFP_ZERO);
 	if (!tbl)
 		return NULL;
 
@@ -180,8 +201,10 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	size_t size;
 	int i;
 	static struct lock_class_key __key;
+	struct alloc_tag * __maybe_unused old = rhashtable_alloc_tag_save(ht);
 
-	tbl = kvzalloc(struct_size(tbl, buckets, nbuckets), gfp);
+	tbl = kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
+				   gfp|__GFP_ZERO, NUMA_NO_NODE);
 
 	size = nbuckets;
 
@@ -190,6 +213,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 		nbuckets = 0;
 	}
 
+	rhashtable_alloc_tag_restore(ht, old);
+
 	if (tbl == NULL)
 		return NULL;
 
@@ -975,7 +1000,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
 }
 
 /**
- * rhashtable_init - initialize a new hash table
+ * rhashtable_init_noprof - initialize a new hash table
  * @ht:		hash table to be initialized
  * @params:	configuration parameters
  *
@@ -1016,7 +1041,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.obj_hashfn = my_hash_fn,
  * };
  */
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params)
 {
 	struct bucket_table *tbl;
@@ -1031,6 +1056,8 @@ int rhashtable_init(struct rhashtable *ht,
 	spin_lock_init(&ht->lock);
 	memcpy(&ht->p, params, sizeof(*params));
 
+	rhashtable_alloc_tag_init(ht);
+
 	if (params->min_size)
 		ht->p.min_size = roundup_pow_of_two(params->min_size);
 
@@ -1076,26 +1103,26 @@ int rhashtable_init(struct rhashtable *ht,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rhashtable_init);
+EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
 
 /**
- * rhltable_init - initialize a new hash list table
+ * rhltable_init_noprof - initialize a new hash list table
  * @hlt:	hash list table to be initialized
  * @params:	configuration parameters
  *
  * Initializes a new hash list table.
  *
- * See documentation for rhashtable_init.
+ * See documentation for rhashtable_init_noprof.
  */
-int rhltable_init(struct rhltable *hlt, const struct rhashtable_params *params)
+int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
 {
 	int err;
 
-	err = rhashtable_init(&hlt->ht, params);
+	err = rhashtable_init_noprof(&hlt->ht, params);
 	hlt->ht.rhlist = true;
 	return err;
 }
-EXPORT_SYMBOL_GPL(rhltable_init);
+EXPORT_SYMBOL_GPL(rhltable_init_noprof);
 
 static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
 				void (*free_fn)(void *ptr, void *arg),
@@ -1222,6 +1249,7 @@ struct rhash_lock_head __rcu **rht_bucket_nested_insert(
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	union nested_table *ntbl;
+	struct alloc_tag * __maybe_unused old = rhashtable_alloc_tag_save(ht);
 
 	ntbl = nested_table_top(tbl);
 	hash >>= tbl->nest;
@@ -1236,6 +1264,8 @@ struct rhash_lock_head __rcu **rht_bucket_nested_insert(
 					  size <= (1 << shift));
 	}
 
+	rhashtable_alloc_tag_restore(ht, old);
+
 	if (!ntbl)
 		return NULL;
 
-- 
2.42.0.758.gaed0368e0e-goog

