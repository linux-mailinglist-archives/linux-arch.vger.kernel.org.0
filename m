Return-Path: <linux-arch+bounces-2236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624B8520B4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21971F22C31
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAE5FB97;
	Mon, 12 Feb 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9tRS26q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DC5F573
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774050; cv=none; b=mVtEb5BEAX74C8NDE/s8WKCRyGdvwmZ1o9lSTNFTn6g81IOnPqjZeD8vQQ3Y/2EyrMtODO5vR3XmlPFD6gPQJcF6bggVpiCgThu1XL63s+8pVHhnBwI38LlyVhR4E7cwk8eyKJK18ra2clEbfwitZ+b+kmpEcs/j0uhCI1NmUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774050; c=relaxed/simple;
	bh=rFxOazRmJvXVDMBFp+0gxbyGbXjSs9OXcenRjz5zrp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXPdFbDxV1l4IJS8ZXi4tjuZfvsqTF/r/jLUCUd1Wqh3oS3EykNYnJmmJ9Aya9rZgtsRJEb3bhvHHQwPfuVq7QYEZlN04V19BLbeRyyHUhVaDf4cRr7rjrB4Hf4RjpR/8hg98iHxEUfJMURpvRIQ6Lo14zfco8O/E1rTewxF4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9tRS26q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5927511276.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774046; x=1708378846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVDAYkVgDU7fuXLh0MJZ7V+qIVlVtuXoydpki6LzsY=;
        b=O9tRS26qal1HZMYF7ammvgw/ywiDw8AWm6PPmTg7HW+iCa8bKyQFxuy6KXdWeUcYzy
         bKFqD79XbbclStxC6/b433r+dYqlqMq6QXHUhC1xqYNIVxywCa9BQt/t3/zx/W4qZgEH
         stLvOkNtGbOW6aMLoPW3omgezI5IpAtafmuz7IqHUeups2ywSisXDVTBGJmxeR8klh/L
         b6L85WxEkPy38PiADRrcjJRNXPQG3RE8JWRpCClI41FQefQW2i9NaGaZIUHiGKh6lMyE
         ytjf5peUUN3WV46bH7MdREZA3cCjp/R7BWpRlcSOcD8dhSzRI9LqsX46wylLx1upKa95
         x/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774046; x=1708378846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVDAYkVgDU7fuXLh0MJZ7V+qIVlVtuXoydpki6LzsY=;
        b=QrIhDbuvVkFpTBq0muk29+Q/wRSBz1L33HbAm/kKd9RENqjX1tlAP/jof+guNz9gel
         6WdSoaI8ek3qPeAwPvA+ZYb2dY84ba28U+xmQwbPi5jb9+EKSSir441IGcKu2FhXarGC
         vFzi14G5D43kCR/0B8xU68fg+W2bNSqhyOJfxCbjMhyP+Hnd36pdeGAeWWD12f+8nNcL
         TZUdiuM9tmsydd7vVj4G18XlIR4Z1A+vKVN4J2WMsIoBflMoN+JAS7DCI3Nx66NqFTRy
         vP1iXqeU8YHyL/IfYfsjs+wYjwd/u+79PCDdCM4sILexDRkyjr2URtTB6rWnWZpzWdCO
         TJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbXnzi5TVyzY4qAZ8MeY+lUcHunf21XzNWnrpM1Q/8MQl23NkRh0P6rkQN1cFj1U2HsawF9NCMtdrLQ+wp+Hn+IlrEo/graSe3Zg==
X-Gm-Message-State: AOJu0YyB7oCnONXRxu4zFU7rRt5g4Mj+5Lqk+54o//kyW7qENufPrj29
	UeX3nw9Ay1QBbLgYML8Fruth/WMy+HDK0SIMzpI/XECH1z89Osesc3+WUFJ4SBAX+JUY8WL13U/
	ZZg==
X-Google-Smtp-Source: AGHT+IESoh+UWKTP+1hXTVbYaUvPuidDpjnUl+NYldJf9cgWEgRiy1LGQkGWPWQFR+H7vya0ViMEzA6ILJE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:150d:b0:dc6:d678:371d with SMTP id
 q13-20020a056902150d00b00dc6d678371dmr2278885ybu.3.1707774046204; Mon, 12 Feb
 2024 13:40:46 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:20 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-35-surenb@google.com>
Subject: [PATCH v3 34/35] codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark
 failed slab_ext allocations
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
index 2b010316016c..f95241ca9052 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -365,8 +365,10 @@ enum page_memcg_data_flags {
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
index cf332a839bf4..7bb3900f83ef 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -586,9 +586,34 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
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
index d5f75d04ced2..489c7a8ba8f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -214,29 +214,37 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
2.43.0.687.g38aa6559b0-goog


