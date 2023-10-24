Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385B17D5339
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjJXNwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbjJXNu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:50:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20A171B
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so4433490276.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155286; x=1698760086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwLU1aU2LNAtecsch6dr14rd1yTTpsfUN6nYD0uWJEE=;
        b=lO8oYsG5g14dNpqW9ouj1s9M69yM5MZ0rmpNEdvNfhQGuka2UpS4+gTkTkTLrnRCu+
         R5AobkkLh7AXlvJkml+093Ak5izfo+xFuzyMswEZK5obqBZh6gXDiMnx5gR7fOKGlgjY
         Ri85Ii+Gh46qA74+B5+IOlRDrppLj62h3HhEptVf/gj4i7dUTEoU7A09+HKIHAHLwmG0
         eTesSqwFQfe705J6lwxlV5cFVg0bln3s+XVTH1zXDNcxzEtSW58PEZptjFRlMzqI9FUR
         m0pdOVNzJv7fbXqaf+sqajhdL+625ejoN30xcyS3LVTKZ9LLuDW/+EYSUxR1nGuGwCzn
         qCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155286; x=1698760086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwLU1aU2LNAtecsch6dr14rd1yTTpsfUN6nYD0uWJEE=;
        b=OQW6HYl0v7GAw7LlzYyC001p+a2R4dB0zxqxvA35r2ADygLVpOZE/03AREyDlSXaJX
         Q86ym8uOCoCJMPjeqG7jRmC5CeZHcM1F/l5zyGrBmK1GPx0DlosD8aPn9TkwuFpdXn3e
         sJvSc96VIKwdOrtUjnIyV+J4H9CkPU4sunyT3fBqUh3EWzYETEShUHGclIYtNFH9+3M6
         E3BLrkSJJ8jVzCjuk1OQPniEqWId02cJD/isSCoHPsLJMY7/2CsOaIGFFXI+3jW2LBxb
         ReHHv4Jhjq3axuUIyLx/n7OZOCiJGcTiWmMy+c+qndPrdYgH5Y735zmtH0Fp0CO5FGxp
         YYvw==
X-Gm-Message-State: AOJu0Yx6qqu8mVNIi5cnAk7a/FVV0cCqtLJwyI132a8vfRYg6+cEMIAj
        RJP+TBMr2oY5sRzRG1wEQZ35aBt1dTc=
X-Google-Smtp-Source: AGHT+IEQFxSAdc50qujfzmzJKJcWY3qyZfXbT1k7XuYaFuTlpAInpKqkovdUmqHR4hu8HiZ2L8Ah2MqCV0A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:d244:0:b0:d9a:4cc1:b59a with SMTP id
 j65-20020a25d244000000b00d9a4cc1b59amr317326ybg.1.1698155286109; Tue, 24 Oct
 2023 06:48:06 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:35 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-39-surenb@google.com>
Subject: [PATCH v2 38/39] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark
 failed slab_ext allocations
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

If slabobj_ext vector allocation for a slab object fails and later on it
succeeds for another object in the same slab, the slabobj_ext for the
original object will be NULL and will be flagged in case when
CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Mark failed slabobj_ext vector allocations using a new objext_flags flag
stored in the lower bits of slab->obj_exts. When new allocation succeeds
it marks all tag references in the same slabobj_ext vector as empty to
avoid warnings implemented by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memcontrol.h |  4 +++-
 mm/slab.h                  | 25 +++++++++++++++++++++++++
 mm/slab_common.c           | 22 +++++++++++++++-------
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 853a24b5f713..6b680ca424e3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -363,8 +363,10 @@ enum page_memcg_data_flags {
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
+	/* slabobj_ext vector failed to allocate */
+	OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
 	/* the next bit after the last actual flag */
-	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
 
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
diff --git a/mm/slab.h b/mm/slab.h
index 45216bad34b8..1736268892e6 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -474,9 +474,34 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
+static inline void mark_failed_objexts_alloc(struct slab *slab)
+{
+	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+}
+
+static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
+			struct slabobj_ext *vec, unsigned int objects)
+{
+	/*
+	 * If vector previously failed to allocate then we have live
+	 * objects with no tag reference. Mark all references in this
+	 * vector as empty to avoid warnings later on.
+	 */
+	if (obj_exts & OBJEXTS_ALLOC_FAIL) {
+		unsigned int i;
+
+		for (i = 0; i < objects; i++)
+			set_codetag_empty(&vec[i].ref);
+	}
+}
+
+
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
+static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
+			struct slabobj_ext *vec, unsigned int objects) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index db2cd7afc353..cea73314f919 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -218,29 +218,37 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			gfp_t gfp, bool new_slab)
 {
 	unsigned int objects = objs_per_slab(s, slab);
-	unsigned long obj_exts;
-	void *vec;
+	unsigned long new_exts;
+	unsigned long old_exts;
+	struct slabobj_ext *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
-	if (!vec)
+	if (!vec) {
+		/* Mark vectors which failed to allocate */
+		if (new_slab)
+			mark_failed_objexts_alloc(slab);
+
 		return -ENOMEM;
+	}
 
-	obj_exts = (unsigned long)vec;
+	new_exts = (unsigned long)vec;
 #ifdef CONFIG_MEMCG
-	obj_exts |= MEMCG_DATA_OBJEXTS;
+	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+	old_exts = slab->obj_exts;
+	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
 		 * obj_exts, no synchronization is required and obj_exts can
 		 * be simply assigned.
 		 */
-		slab->obj_exts = obj_exts;
-	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
+		slab->obj_exts = new_exts;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
-- 
2.42.0.758.gaed0368e0e-goog

