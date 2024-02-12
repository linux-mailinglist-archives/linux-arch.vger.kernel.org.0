Return-Path: <linux-arch+bounces-2207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A16852003
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDDF1B23F41
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3350A91;
	Mon, 12 Feb 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yp7VWu5f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0304F606
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773987; cv=none; b=VaGDzziwj7zMJzrAWaDG2P0T+wZmddC2es/Tnrmj0FmNJExUpXCiXtpU7kQNKPLTreZBQtOxOqu01Pe3r12qKwqRyhItFUU47bsn8LgXEufAAXXKF7t2R0WFtTZyrYYNAPcEBaPl3S5iCD0heSz2v670v7SsTxkNLO0jbq3/XPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773987; c=relaxed/simple;
	bh=uh7K/q/c4QJyzwW823bcy9QpQKT5WsQlrvqviezygek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1bF1KUGeOCEPaZzw20t2KMFTWhoDUixjqBqTxp05JX/r9azP+U92uFkFpaidu09A387pfsq+CsjQNr+mr9hb3f1PnUkwcGHEVUKgkBDN9K+EI+qJVYv5dfVKl7R4wiEtUJCrek/M0HGmJPt6yO8m4qjVqdTrrhBPf9RAoSvhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yp7VWu5f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so732841276.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773983; x=1708378783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4MAAfPCe00kOecp4g2Jxa8MlwYPnJB9NakMZqL/K7o=;
        b=yp7VWu5fNwitwcvxLMXVWjPkrx2mq8/EoVQuMBoy2EnO8DThAsULS3dOedha5ba9Jc
         3L+yb+SCr9iIKjuKlaAXecFckHmyQd/YmtuxYX94E+A+Fd8fwGKtU8/s83tyWPsBg0RI
         u5wPpludYa7PYYVoXj+eekenoXV5r4JfNQpO5Qs9WcHmxq21CCdQsdAa76R7rNzWhGRY
         ECgX33zV6c7PZZbnJNNQKCpXdD8nFJWf8n0dub4VZA3k1t1qYVOCB1X4+xsxgbnxa9VH
         xKBVx3pLDyYN0Zpr/S+/h5wD0TfSiKWAW21Peq4UD2T8CP7UviC1jDre6WFmLAj8Nkph
         HLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773983; x=1708378783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4MAAfPCe00kOecp4g2Jxa8MlwYPnJB9NakMZqL/K7o=;
        b=dOW5UE7Sm0oi8BtRWZQuqL8acc9clf5iBYfhO9DuPekKtgdQP8PjbOT+O94t5CPng+
         LMFxdsNxVjEDlvdpUZohsGngWAJ+3lprbGnVgpg3nTWupuW22EWj3i4nIjScJuBucNgC
         Kqk0uS82ZOb266JXIYbL949lgacEJS3SX8ONMzVURNkC9xN2VDKwaVHEWDKvctukDTQ1
         AdA6p9Pde9+2QrybwEwKJCZuCfELsk0frpVWbkGf8AD2BisoSC1ZpEeb7dElUJzg70Gc
         B1H6Mygql1EddHSCVe/vVzBdBrBla72MPKpFLDWWZ0IQnObcl6E4juSoc1fFKvr9E4J2
         1AJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQRO4she80DKdOntcfd1WyX04db+UlKWyz7Vj+MjNd3bJxX8zBT9ght0/DIBB4suLcBkGxA6v3xc7NGd5Nrl4+sKJwmcN5xv+C9w==
X-Gm-Message-State: AOJu0YwUuYiwcjrvTE7qm+sQzoSEjsASlOvamDCKhVhf2k0Flpzis+gF
	h1CJkLl50aizKla4/sxCs6qrsn1QF9/R/8V/4cAbzKg86JS3fKpPOQiCzDiuX+/Mxt6OBLI8orq
	rPA==
X-Google-Smtp-Source: AGHT+IEx2k/hmerJPpr6v0WCuO8HuxZg22OlVEzZgrJnpmE7cctHbOLVeHOYQJ7ufTWaWjLLEbzR787VVlU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:abcf:0:b0:dc6:a6e3:ca93 with SMTP id
 v73-20020a25abcf000000b00dc6a6e3ca93mr292076ybi.10.1707773983086; Mon, 12 Feb
 2024 13:39:43 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:51 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-6-surenb@google.com>
Subject: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab object extensions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently slab pages can store only vectors of obj_cgroup pointers in
page->memcg_data. Introduce slabobj_ext structure to allow more data
to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
to support current functionality while allowing to extend slabobj_ext
in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memcontrol.h | 20 ++++++---
 include/linux/mm_types.h   |  4 +-
 init/Kconfig               |  4 ++
 mm/kfence/core.c           | 14 +++---
 mm/kfence/kfence.h         |  4 +-
 mm/memcontrol.c            | 56 +++--------------------
 mm/page_owner.c            |  2 +-
 mm/slab.h                  | 92 +++++++++++++++++++++++++++++---------
 mm/slab_common.c           | 48 ++++++++++++++++++++
 mm/slub.c                  | 64 +++++++++++++-------------
 10 files changed, 189 insertions(+), 119 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..eb1dc181e412 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -348,8 +348,8 @@ struct mem_cgroup {
 extern struct mem_cgroup *root_mem_cgroup;
 
 enum page_memcg_data_flags {
-	/* page->memcg_data is a pointer to an objcgs vector */
-	MEMCG_DATA_OBJCGS = (1UL << 0),
+	/* page->memcg_data is a pointer to an slabobj_ext vector */
+	MEMCG_DATA_OBJEXTS = (1UL << 0),
 	/* page has been accounted as a non-slab kernel page */
 	MEMCG_DATA_KMEM = (1UL << 1),
 	/* the next bit after the last actual flag */
@@ -387,7 +387,7 @@ static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -408,7 +408,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -505,7 +505,7 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	 */
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		return NULL;
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
@@ -551,7 +551,7 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
@@ -1633,6 +1633,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+/*
+ * Extended information for slab objects stored as an array in page->memcg_data
+ * if MEMCG_DATA_OBJEXTS is set.
+ */
+struct slabobj_ext {
+	struct obj_cgroup *objcg;
+} __aligned(8);
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..9ff97f4e74c5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -169,7 +169,7 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 	unsigned long memcg_data;
 #endif
 
@@ -306,7 +306,7 @@ struct folio {
 			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 			unsigned long memcg_data;
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
diff --git a/init/Kconfig b/init/Kconfig
index deda3d14135b..8ca5285108be 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -949,10 +949,14 @@ config CGROUP_FAVOR_DYNMODS
 
           Say N if unsure.
 
+config SLAB_OBJ_EXT
+	bool
+
 config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
 	select EVENTFD
+	select SLAB_OBJ_EXT
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 8350f5c06f2e..964b8482275b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -595,9 +595,9 @@ static unsigned long kfence_init_pool(void)
 			continue;
 
 		__folio_set_slab(slab_folio(slab));
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = (unsigned long)&kfence_metadata_init[i / 2 - 1].objcg |
-				   MEMCG_DATA_OBJCGS;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = (unsigned long)&kfence_metadata_init[i / 2 - 1].obj_exts |
+				 MEMCG_DATA_OBJEXTS;
 #endif
 	}
 
@@ -645,8 +645,8 @@ static unsigned long kfence_init_pool(void)
 
 		if (!i || (i % 2))
 			continue;
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = 0;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = 0;
 #endif
 		__folio_clear_slab(slab_folio(slab));
 	}
@@ -1139,8 +1139,8 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
-#ifdef CONFIG_MEMCG
-	KFENCE_WARN_ON(meta->objcg);
+#ifdef CONFIG_MEMCG_KMEM
+	KFENCE_WARN_ON(meta->obj_exts.objcg);
 #endif
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index f46fbb03062b..084f5f36e8e7 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -97,8 +97,8 @@ struct kfence_metadata {
 	struct kfence_track free_track;
 	/* For updating alloc_covered on frees. */
 	u32 alloc_stack_hash;
-#ifdef CONFIG_MEMCG
-	struct obj_cgroup *objcg;
+#ifdef CONFIG_MEMCG_KMEM
+	struct slabobj_ext obj_exts;
 #endif
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ed40f9d3a27..7021639d2a6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2977,13 +2977,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-/*
- * The allocated objcg pointers array is not accounted directly.
- * Moreover, it should not come from DMA buffer and is not readily
- * reclaimable. So those GFP bits should be masked off.
- */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
-				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
@@ -3003,62 +2996,27 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
-int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
-				 gfp_t gfp, bool new_slab)
-{
-	unsigned int objects = objs_per_slab(s, slab);
-	unsigned long memcg_data;
-	void *vec;
-
-	gfp &= ~OBJCGS_CLEAR_MASK;
-	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
-			   slab_nid(slab));
-	if (!vec)
-		return -ENOMEM;
-
-	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
-	if (new_slab) {
-		/*
-		 * If the slab is brand new and nobody can yet access its
-		 * memcg_data, no synchronization is required and memcg_data can
-		 * be simply assigned.
-		 */
-		slab->memcg_data = memcg_data;
-	} else if (cmpxchg(&slab->memcg_data, 0, memcg_data)) {
-		/*
-		 * If the slab is already in use, somebody can allocate and
-		 * assign obj_cgroups in parallel. In this case the existing
-		 * objcg vector should be reused.
-		 */
-		kfree(vec);
-		return 0;
-	}
-
-	kmemleak_not_leak(vec);
-	return 0;
-}
-
 static __always_inline
 struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 {
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
-	 * slab->memcg_data.
+	 * slab->obj_exts.
 	 */
 	if (folio_test_slab(folio)) {
-		struct obj_cgroup **objcgs;
+		struct slabobj_ext *obj_exts;
 		struct slab *slab;
 		unsigned int off;
 
 		slab = folio_slab(folio);
-		objcgs = slab_objcgs(slab);
-		if (!objcgs)
+		obj_exts = slab_obj_exts(slab);
+		if (!obj_exts)
 			return NULL;
 
 		off = obj_to_index(slab->slab_cache, slab, p);
-		if (objcgs[off])
-			return obj_cgroup_memcg(objcgs[off]);
+		if (obj_exts[off].objcg)
+			return obj_cgroup_memcg(obj_exts[off].objcg);
 
 		return NULL;
 	}
@@ -3066,7 +3024,7 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 	/*
 	 * folio_memcg_check() is used here, because in theory we can encounter
 	 * a folio where the slab flag has been cleared already, but
-	 * slab->memcg_data has not been freed yet
+	 * slab->obj_exts has not been freed yet
 	 * folio_memcg_check() will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5634e5d890f8..262aa7d25f40 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -377,7 +377,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	if (!memcg_data)
 		goto out_unlock;
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		ret += scnprintf(kbuf + ret, count - ret,
 				"Slab cache page\n");
 
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..436a126486b5 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -87,8 +87,8 @@ struct slab {
 	unsigned int __unused;
 
 	atomic_t __page_refcount;
-#ifdef CONFIG_MEMCG
-	unsigned long memcg_data;
+#ifdef CONFIG_SLAB_OBJ_EXT
+	unsigned long obj_exts;
 #endif
 };
 
@@ -97,8 +97,8 @@ struct slab {
 SLAB_MATCH(flags, __page_flags);
 SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
 SLAB_MATCH(_refcount, __page_refcount);
-#ifdef CONFIG_MEMCG
-SLAB_MATCH(memcg_data, memcg_data);
+#ifdef CONFIG_SLAB_OBJ_EXT
+SLAB_MATCH(memcg_data, obj_exts);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
@@ -541,42 +541,90 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_SLAB_OBJ_EXT
+
 /*
- * slab_objcgs - get the object cgroups vector associated with a slab
+ * slab_obj_exts - get the pointer to the slab object extension vector
+ * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object cgroups vector associated with the slab,
+ * Returns a pointer to the object extension vector associated with the slab,
  * or NULL if no such vector has been associated yet.
  */
-static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 {
-	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
+	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
-	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS),
+#ifdef CONFIG_MEMCG
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
 							slab_page(slab));
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, slab_page(slab));
+	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 
-	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct slabobj_ext *)(obj_exts & ~MEMCG_DATA_FLAGS_MASK);
+#else
+	return (struct slabobj_ext *)obj_exts;
+#endif
 }
 
-int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
-				 gfp_t gfp, bool new_slab);
-void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr);
-#else /* CONFIG_MEMCG_KMEM */
-static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab);
+
+static inline bool need_slab_obj_ext(void)
+{
+	/*
+	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
+	 * inside memcg_slab_post_alloc_hook. No other users for now.
+	 */
+	return false;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	struct slab *slab;
+
+	if (!p)
+		return NULL;
+
+	if (!need_slab_obj_ext())
+		return NULL;
+
+	slab = virt_to_slab(p);
+	if (!slab_obj_exts(slab) &&
+	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
+		 "%s, %s: Failed to create slab extension vector!\n",
+		 __func__, s->name))
+		return NULL;
+
+	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+}
+
+#else /* CONFIG_SLAB_OBJ_EXT */
+
+static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 {
 	return NULL;
 }
 
-static inline int memcg_alloc_slab_cgroups(struct slab *slab,
-					       struct kmem_cache *s, gfp_t gfp,
-					       bool new_slab)
+static inline int alloc_slab_obj_exts(struct slab *slab,
+				      struct kmem_cache *s, gfp_t gfp,
+				      bool new_slab)
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG_KMEM */
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
+#ifdef CONFIG_MEMCG_KMEM
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr);
+#endif
 
 size_t __ksize(const void *objp);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..6bfa1810da5e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -201,6 +201,54 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 	return NULL;
 }
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/*
+ * The allocated objcg pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				__GFP_ACCOUNT | __GFP_NOFAIL)
+
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab)
+{
+	unsigned int objects = objs_per_slab(s, slab);
+	unsigned long obj_exts;
+	void *vec;
+
+	gfp &= ~OBJCGS_CLEAR_MASK;
+	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
+			   slab_nid(slab));
+	if (!vec)
+		return -ENOMEM;
+
+	obj_exts = (unsigned long)vec;
+#ifdef CONFIG_MEMCG
+	obj_exts |= MEMCG_DATA_OBJEXTS;
+#endif
+	if (new_slab) {
+		/*
+		 * If the slab is brand new and nobody can yet access its
+		 * obj_exts, no synchronization is required and obj_exts can
+		 * be simply assigned.
+		 */
+		slab->obj_exts = obj_exts;
+	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
+		/*
+		 * If the slab is already in use, somebody can allocate and
+		 * assign slabobj_exts in parallel. In this case the existing
+		 * objcg vector should be reused.
+		 */
+		kfree(vec);
+		return 0;
+	}
+
+	kmemleak_not_leak(vec);
+	return 0;
+}
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
 static struct kmem_cache *create_cache(const char *name,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..1eb1050814aa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -683,10 +683,10 @@ static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *sla
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
 		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	} else {
 		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	}
 	if (likely(ret))
 		return true;
@@ -710,13 +710,13 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
 		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	} else {
 		unsigned long flags;
 
 		local_irq_save(flags);
 		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 		local_irq_restore(flags);
 	}
 	if (likely(ret))
@@ -1881,13 +1881,25 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
-static inline void memcg_free_slab_cgroups(struct slab *slab)
+#ifdef CONFIG_SLAB_OBJ_EXT
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+	struct slabobj_ext *obj_exts;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	kfree(obj_exts);
+	slab->obj_exts = 0;
+}
+#else
+static inline void free_slab_obj_exts(struct slab *slab)
 {
-	kfree(slab_objcgs(slab));
-	slab->memcg_data = 0;
 }
+#endif
 
+#ifdef CONFIG_MEMCG_KMEM
 static inline size_t obj_full_size(struct kmem_cache *s)
 {
 	/*
@@ -1966,15 +1978,15 @@ static void __memcg_slab_post_alloc_hook(struct kmem_cache *s,
 		if (likely(p[i])) {
 			slab = virt_to_slab(p[i]);
 
-			if (!slab_objcgs(slab) &&
-			    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
+			if (!slab_obj_exts(slab) &&
+			    alloc_slab_obj_exts(slab, s, flags, false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
 
 			off = obj_to_index(s, slab, p[i]);
 			obj_cgroup_get(objcg);
-			slab_objcgs(slab)[off] = objcg;
+			slab_obj_exts(slab)[off].objcg = objcg;
 			mod_objcg_state(objcg, slab_pgdat(slab),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
@@ -1995,18 +2007,18 @@ void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
 
 static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 				   void **p, int objects,
-				   struct obj_cgroup **objcgs)
+				   struct slabobj_ext *obj_exts)
 {
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = objcgs[off];
+		objcg = obj_exts[off].objcg;
 		if (!objcg)
 			continue;
 
-		objcgs[off] = NULL;
+		obj_exts[off].objcg = NULL;
 		obj_cgroup_uncharge(objcg, obj_full_size(s));
 		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
 				-obj_full_size(s));
@@ -2018,16 +2030,16 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct obj_cgroup **objcgs;
+	struct slabobj_ext *obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
 
-	objcgs = slab_objcgs(slab);
-	if (likely(!objcgs))
+	obj_exts = slab_obj_exts(slab);
+	if (likely(!obj_exts))
 		return;
 
-	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
+	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
 
 static inline
@@ -2038,15 +2050,6 @@ void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
 		obj_cgroup_uncharge(objcg, objects * obj_full_size(s));
 }
 #else /* CONFIG_MEMCG_KMEM */
-static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
-{
-	return NULL;
-}
-
-static inline void memcg_free_slab_cgroups(struct slab *slab)
-{
-}
-
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
@@ -2314,7 +2317,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
 	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_slab_cgroups(slab, s, gfp, true);
+		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -2323,8 +2326,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online())
-		memcg_free_slab_cgroups(slab);
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
@@ -3775,6 +3777,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 			  unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	struct slabobj_ext *obj_exts;
 	bool kasan_init = init;
 	size_t i;
 	gfp_t init_flags = flags & gfp_allowed_mask;
@@ -3817,6 +3820,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
+		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-- 
2.43.0.687.g38aa6559b0-goog


