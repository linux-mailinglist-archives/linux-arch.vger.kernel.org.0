Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8A7D5332
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjJXNvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjJXNuU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:50:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB326A8
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so5381778276.3
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155282; x=1698760082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3jXXsjNPLXrWv+rf69UQa/6uvXnoVOikFRei2b/KT8=;
        b=mj7mp9mjCnUwbHFzXtJRB8JtxCctz3Xv/EqKylemAcbGt3uoD4496yEaf5lDjabkHE
         tcFBvnP/9NZuVH7xxABOxsHuGMlWTjIpU4ohTuYAN9usv5NLAEoKk1/eO4+1+GknmpfM
         5B6469drXXWkacLG2A428xOET1WYv/6UQDtqvDZLDRevtVGiskNMxKrZcppMWKkU7zrf
         lwGUctS2Eg9fLDMQdLsqgw/rbFqd7W1xNoEMo4iW/CBjLkbdwsAGfaI+hEzdTZeBZNEE
         HoUmlqjWNgenU05LbyAavx2Yyfu182dIM8E08RGfVax6V5DaBmuH3THAAIYfmy5Ke2Cn
         xxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155282; x=1698760082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3jXXsjNPLXrWv+rf69UQa/6uvXnoVOikFRei2b/KT8=;
        b=bdss+h5K5LWeML8KoEnVNV4BpHV8FMLmAHcdje+XeWU5hKjZGK6pOKj6/1Dt2pLzjk
         LkaCVg3ryRdcF5Un6prUakb3EOeGsMcLxpD+DRcgIgjOdWDIiNKgfxqSv2bp6CLRYtlw
         PxL39cHelYCfZdJk4D+lZB/SlRa+cYZ2dBTXKy6XPgJrtzIQeBbpfqvYew4B8U5+6KAU
         Q637NzGMlVBEtENQnygCiMVrISMRPoJYKz/Ert7pJkpYPaEimnoiXNN6/VpdHT0Zf5jC
         ncIrLQSiVQ0MBtJxNPHFfIScjNbRBj4LBs8OoABeESZXlLCW/KzzuT+SvQP9NTj2V5B/
         nhtg==
X-Gm-Message-State: AOJu0Ywdstittr5rMVjivGZN49wrOH3GpwBBIz1/mSJkbl29SkLqSv2j
        zIZTIuiyaBPZ74T4oZtmjK24nB8EChs=
X-Google-Smtp-Source: AGHT+IH8yezIA8jxKZavrTPxkBvsmi2Yxz7WtkoiuiQPT9VSDtMO7/bIUQjwMdJw5xsPHzLAEf+sR1TuKL8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:d50c:0:b0:d9c:66d1:9597 with SMTP id
 r12-20020a25d50c000000b00d9c66d19597mr227720ybe.13.1698155281680; Tue, 24 Oct
 2023 06:48:01 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:33 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-37-surenb@google.com>
Subject: [PATCH v2 36/39] codetag: debug: skip objext checking when it's for
 objext itself
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

objext objects are created with __GFP_NO_OBJ_EXT flag and therefore have
no corresponding objext themselves (otherwise we would get an infinite
recursion). When freeing these objects their codetag will be empty and
when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to false
warnings. Introduce CODETAG_EMPTY special codetag value to mark
allocations which intentionally lack codetag to avoid these warnings.
Set objext codetags to CODETAG_EMPTY before freeing to indicate that
the codetag is expected to be empty.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
 mm/slab.h                 | 33 +++++++++++++++++++++++++++++++++
 mm/slab_common.c          |  1 +
 3 files changed, 60 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 0a5973c4ad77..1f3207097b03 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -77,6 +77,27 @@ static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 	return v;
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+#define CODETAG_EMPTY	(void *)1
+
+static inline bool is_codetag_empty(union codetag_ref *ref)
+{
+	return ref->ct == CODETAG_EMPTY;
+}
+
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+	if (ref)
+		ref->ct = CODETAG_EMPTY;
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 {
 	struct alloc_tag *tag;
@@ -87,6 +108,11 @@ static inline void __alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	if (!ref || !ref->ct)
 		return;
 
+	if (is_codetag_empty(ref)) {
+		ref->ct = NULL;
+		return;
+	}
+
 	tag = ct_to_alloc_tag(ref->ct);
 
 	this_cpu_sub(tag->counters->bytes, bytes);
diff --git a/mm/slab.h b/mm/slab.h
index 4859ce1f8808..45216bad34b8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -455,6 +455,31 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, bool new_slab);
 
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
+{
+	struct slabobj_ext *slab_exts;
+	struct slab *obj_exts_slab;
+
+	obj_exts_slab = virt_to_slab(obj_exts);
+	slab_exts = slab_obj_exts(obj_exts_slab);
+	if (slab_exts) {
+		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
+						 obj_exts_slab, obj_exts);
+		/* codetag should be NULL */
+		WARN_ON(slab_exts[offs].ref.ct);
+		set_codetag_empty(&slab_exts[offs].ref);
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
+static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
+
 static inline bool need_slab_obj_ext(void)
 {
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -476,6 +501,14 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	if (!obj_exts)
 		return;
 
+	/*
+	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
+	 * warning if slab has extensions but the extension of an object is
+	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
+	 * the extension for obj_exts is expected to be NULL.
+	 */
+	mark_objexts_empty(obj_exts);
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8ef5e47ff6a7..db2cd7afc353 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -246,6 +246,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * assign slabobj_exts in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
+		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
 	}
-- 
2.42.0.758.gaed0368e0e-goog

