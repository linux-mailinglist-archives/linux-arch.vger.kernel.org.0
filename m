Return-Path: <linux-arch+bounces-3080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF2885E7D
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6FF281CE8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70200142631;
	Thu, 21 Mar 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pug3BjJ+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3913AA4C
	for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039095; cv=none; b=U11uKKMTnIVoRNeGhK3SCihGITBZSJKppQPcNQ7sKV/VNNFFX2G6vtd/67Ag4yIFf3U56U+QG5HLaxG9NfO7drzpCF8VUBSEaVInHICsSSvBxypWOtqEIw3UE7tZEbNRzSt0Cu0Z7Vx8i6Ol7FNBceKleEcM0P3wPeZ9cuFrD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039095; c=relaxed/simple;
	bh=5ajV2iI74MCcJvdY3e41StjfOvcO/AanK2/O3Zac0KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOwhDX6tEeBEbZ0DcARL/qSJkIGvR7hDzMYPW4ruRMwMDTE4WqLPM3LN5wTDZKeQzQbUyvJFKBFnphblBb+EMGJ+Wm+QgcPEhbeIzjOuO4gUU4dVuE5zY2j55v81JZR0KdPR5ihMrgHNz2QgS1NLRxCo6Y0TK3iq6RNVT2TppjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pug3BjJ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so1702222276.2
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039091; x=1711643891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=krRMCxbEdPvR0gpNvdmt+1GzNi+HHBvoijzlHbN4rmY=;
        b=pug3BjJ+V1Rng7W/ozJY8wGrvo+b2YITJ8EnhZ/boP7Sqog7MupqCVHMt7XQ4YKQJy
         CEr4Bq+h8ob1sduSeQnVlrS8nng5lqLBbeD0NKfFVjk2AJl4AOYRFusRaqwFxMClSxjV
         SNUS7QjNstnv5CUr+ku2CHIE+DiMK2pqofwi5AbV0IFQdK8Q8bS4Q6j4pEyMbaHrm9y7
         nLb6pd6qYALuwqEM1aHRLdDdw0yoMzTtohp95md0NrYc29toJQqmoPSVtteaHdnikrf1
         JwWbYdDsOaSkx9YQrRNC45g3j6zNHOvZQ8LQpZ9YoIG4zsB/Wjw3KMqeIgiRz09Fp99h
         2gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039091; x=1711643891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krRMCxbEdPvR0gpNvdmt+1GzNi+HHBvoijzlHbN4rmY=;
        b=BOlVzCxlPg3ViaI5nhRVH/c4GmaY9WXq7KbWOfjlphivmJVAUZn5KDN27kviyOB9J0
         GT4yjDHbZL+ha0RzN6R/ZYWcgMXeOgEAGC1N0aPlnnYPeiZpwYNfRDqGnZuZKBomUmbT
         D8xTw29251BLcwIaWyEA1mOFVzh84bkZYAQia0TkX7Uj/XgqQZ0ParahQy1apjlReQti
         EVCPG8nykJFiw0eSgpWCDevLAEcpzuxHU8ifJ6Hv9OB3V2/KtwpgjpG/JBOSxcG2eH4L
         t+jgN8/2VbvFh+hMl4agYtR4QZxHeSQDu4ypKNk62QOk77Irn1poXQCQxnNjegMiFdeM
         dOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoGWt8DFpK20eIZkObFgZh6rvaSKOmXifK74ae640MyY1hq2w8HDTvLw0OZhc4K7/v7kjbRBBidw+A7ljW9L7GcE/dsJ5nlba6OQ==
X-Gm-Message-State: AOJu0YznRglCSa1rQCqeDcQf4H9VEXao9rc2vqZKiv4do7DJgKyKQqmF
	59szolzQ6EhBdAY1GjKzfwIGspecnNCp54I6Gje+JUsCM4xtU79hCTrAV5se+8zp+ohIDs4lNdX
	n8w==
X-Google-Smtp-Source: AGHT+IGHRX7538S2HF/3oOa1sNnpVXnzB+i3nUjYB81n0AdHPc2tfmh7wCvtVRvHYQ8dsZZZ2KX9wsSWPB4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:2506:b0:dd1:390a:51e8 with SMTP id
 dt6-20020a056902250600b00dd1390a51e8mr2395872ybb.10.1711039090742; Thu, 21
 Mar 2024 09:38:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:50 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-29-surenb@google.com>
Subject: [PATCH v6 28/37] mm: percpu: Add codetag reference into pcpuobj_ext
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

To store codetag for every per-cpu allocation, a codetag reference is
embedded into pcpuobj_ext when CONFIG_MEM_ALLOC_PROFILING=y. Hooks to
use the newly introduced codetag are added.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/percpu-internal.h | 11 +++++++++--
 mm/percpu.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index e62d582f4bf3..7e42f0ca3b7b 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -36,9 +36,12 @@ struct pcpuobj_ext {
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup	*cgroup;
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	union codetag_ref	tag;
+#endif
 };
 
-#ifdef CONFIG_MEMCG_KMEM
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEM_ALLOC_PROFILING)
 #define NEED_PCPUOBJ_EXT
 #endif
 
@@ -86,7 +89,11 @@ struct pcpu_chunk {
 
 static inline bool need_pcpuobj_ext(void)
 {
-	return !mem_cgroup_kmem_disabled();
+	if (IS_ENABLED(CONFIG_MEM_ALLOC_PROFILING))
+		return true;
+	if (!mem_cgroup_kmem_disabled())
+		return true;
+	return false;
 }
 
 extern spinlock_t pcpu_lock;
diff --git a/mm/percpu.c b/mm/percpu.c
index 2e5edaad9cc3..90e9e4004ac9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1699,6 +1699,32 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
+			      current->alloc_tag, size);
+	}
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
+		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+}
+#else
+static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
+				      size_t size)
+{
+}
+
+static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
+{
+}
+#endif
+
 /**
  * pcpu_alloc - the percpu allocator
  * @size: size of area to allocate in bytes
-- 
2.44.0.291.gc1ea87d7ee-goog


