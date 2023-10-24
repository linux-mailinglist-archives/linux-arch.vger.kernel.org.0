Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6B7D52FC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjJXNuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbjJXNsw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:48:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE091FD4
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso4391817276.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155253; x=1698760053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=Xw8/uaWh99jt2xK+xyr1zz5Kog3gL8WpEHA8dZdPGys2OtC5Gg4NK91d9N0ir3H00c
         R2Dpet4fW7D7lwetzBo7Enb+ojL426Q9VupFcKmzMzdjYTpCev6wIhqDkN1j8CAZjMSj
         y+QI8uxm/F07lzVG7qdFCoty3+28RQ5/9y9OwEEPkqgc7J3IUmadDUEXrzeegxbEZtme
         M+/QDZ+86ie414B0L4rzjXLjtkfQGn7kdaQQSFU6OEvJycCa1KFpT797l09/Ib2ZHsHz
         tOrx2lot5IA7HEjgP1G4C043iIJ5YrELcPUr054LXB/3i1dAgt1AkE+Q2MnZWvHoGi4X
         IAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155253; x=1698760053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxcZ43bmgT/q64Ul96+yH7BdLzW8wJzWTibIuRMuFN0=;
        b=Ufl947DmkfhQWxyERYj87fqSLR/zjY4KCMkBfZZVLJ7304kcRhqIubh3b6LdN0ENMv
         6q3wPVLYqVESWh9Ciomgwuk9fMegnaELlhSw+5OLSoTcxFNSrKUc78hiZze910Ut/jnH
         8TAKLtX7nOzNQeaGGF8YnnTza55gtejs1g5XKxdIDnUY8S88MQW8KI4KmeSWlR4kKcJL
         cq3P6WKAvto7iuRAB/9Vjf+TlyCNmPXCouQUkUnkIQ3L/mlQVjPybnNfSM5zfVhF7xu/
         R6DFzhZYY8O1coVLApRfVAaenWCFz+ViVO+fFy0w5Z9O0nM4er0SLDrBckoi+KcF8Y1u
         tkHw==
X-Gm-Message-State: AOJu0Yw8NZ89z46tzhbF8p9g1ow8IY54ld9VbKC8HMeR4nRpgrYAGJwu
        0PGW3MnyZQXjvG46KmdvIHcgfD9IQ/0=
X-Google-Smtp-Source: AGHT+IHLiWJmtuPzRqvJDSScUKUh0y8YokFyWjfHx2rxdH2c6l653IiepUePcxPp47iOlZTgh6t0s/pZmOY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:d05:0:b0:d9a:5b63:a682 with SMTP id
 5-20020a250d05000000b00d9a5b63a682mr216305ybn.13.1698155252840; Tue, 24 Oct
 2023 06:47:32 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:20 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-24-surenb@google.com>
Subject: [PATCH v2 23/39] mm/slab: add allocation accounting into slab
 allocation and free paths
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

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/slab_def.h |  2 +-
 include/linux/slub_def.h |  4 ++--
 mm/slab.c                |  4 +++-
 mm/slab.h                | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index a61e7d55d0d3..23f14dcb8d5b 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -107,7 +107,7 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
  *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
  */
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	u32 offset = (obj - slab->s_mem);
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..43fda4a5f23a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -182,14 +182,14 @@ static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *sla
 
 /* Determine object index from a given position */
 static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
-					  void *addr, void *obj)
+					  void *addr, const void *obj)
 {
 	return reciprocal_divide(kasan_reset_tag(obj) - addr,
 				 cache->reciprocal_size);
 }
 
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
+					const struct slab *slab, const void *obj)
 {
 	if (is_kfence_address(obj))
 		return 0;
diff --git a/mm/slab.c b/mm/slab.c
index cefcb7499b6c..18923f5f05b5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3348,9 +3348,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	struct slab *slab = virt_to_slab(objp);
 	bool init;
 
-	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
+	memcg_slab_free_hook(cachep, slab, &objp, 1);
+	alloc_tagging_slab_free_hook(cachep, slab, &objp, 1);
 
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
diff --git a/mm/slab.h b/mm/slab.h
index 293210ed10a9..4859ce1f8808 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -533,6 +533,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		unsigned int off = obj_to_index(s, slab, p[i]);
+
+		alloc_tag_sub(&obj_exts[off].ref, s->size);
+	}
+}
+
+#else
+
+static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #ifdef CONFIG_MEMCG_KMEM
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
@@ -827,6 +853,12 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-- 
2.42.0.758.gaed0368e0e-goog

