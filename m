Return-Path: <linux-arch+bounces-2223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CE852062
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97EE287F65
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 21:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC355E54;
	Mon, 12 Feb 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+8/C5Ql"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E957305
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774021; cv=none; b=sOE/nfcORpTb3A7/QgTSYMU3vp8qPgQxLZbOvIMg5r4Ih2wyzyxNJaVn77RTBE44LMXCL6h1nQep3yA3q0gHgg6ZDsQFBCfFoRtpqrX2DxgcQGZoGPTCju7APTiPfcEhh2dt6Uw/6SB7THtXJFyF/eDwqnIB9YYdzETPIdDBgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774021; c=relaxed/simple;
	bh=zQbNUcgZTcmtYa+q7mrh4BT9RI4mys9HqWTZhG7v/zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IybqqVjcAK8nSd9RQ7uHNRtDPf57LzCqHVr7drgpRoj2wz/oqgFhPbYfztLmQ4lcAnA3ZvedlFPeY2oz6a9dAbaEntT5J+y0yzHE56G0DlU5syVqSSaW5igXfTt9mgsxUrwSrZcL0k7O3rCu2YTB4KMLU8DchJlK7JeKmZsYWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+8/C5Ql; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5926813276.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774018; x=1708378818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxFmyXLHYuBt1ZmWD3OCbH5m3f76lMQsgX1qwMm0SnA=;
        b=G+8/C5QlJHXwh0LEd9ckH1UAUUHHgMvWgNCS/zt70qKJ3P7g1gEuos6UfEZTGS34X/
         VvwWHlwsTqFv7U34C7UfcgphH7zvLx+wYRJlGQR9bXomi7dMBBYmR5Ioqj631FZR5OlX
         b/34+hA7kMqL0VX1IQemIEZNroHYbcs2eStvCtnVdml1+w5TAJkQr2Jmk07wMr7H60SU
         UfIkQBcEAJJFQXaC3swdL+1gGVLK2lqufipd25e8A/uyEbgn3WPjZYz4c+TQV6Iysctt
         VQBECAJdysCXHRCp2ceiX8M6L6mMQiA8AvdgxBWQaadnCa0U62VGzul3QWOKLJ053EDX
         iXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774018; x=1708378818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxFmyXLHYuBt1ZmWD3OCbH5m3f76lMQsgX1qwMm0SnA=;
        b=X5SC7Axi4RJTY/N1+JpOX/Rn2xC2vDIXEoUKxXbKx5jaLKXZyYvdW8V1dbwJGAtZ5M
         ZW64SYPCjN2BpbMRQA3W4tE+WzL473wpraCGKmztYUhMNhGEhgNJweOIg1cHYCUruVBn
         h6gBjTSX1PukMSBU60kFtSsbW/UMlM9rvOke166jHJJ4TiDm1TQOo6S0NojiDuAPR06a
         uO9SAAU3oBwol+0LJ4MeP/hnHUySpnunHh3cb9sR37D5bSZV1S4Xy2tNOBvHxld0tflk
         EfXZGqMAL8dTtA8EKyxlaRL6fp5B62Fw3+/ZKHbL6baHL/VgzN+UoKR6mxpkbZSa98wl
         wwrg==
X-Forwarded-Encrypted: i=1; AJvYcCUojDpIMgzB84XKlp5LBGWcEPN5p6sDTjJ6x2CLSfthox8RbT7L9LGr3SiWIhBJtwLX3+fNwPutw+omkztP4qskDMfEEXelzQjK4w==
X-Gm-Message-State: AOJu0YyHFmZzd9XRrhd1X657y9sws9ndNATQ/Adzzk8M9gPVUr8neaxm
	UVNvk4Dt2wUR5KCWWnDukt1AXa7I67rQY/jFE/cm7Fyw0JD6REqmLtCwMbnzo+9yrnCNjw0z2B+
	PIQ==
X-Google-Smtp-Source: AGHT+IGBONdcVlXEEGFa18cuaG6bv+Dg1NI+YmaYVRfFeBb82PPmmVaHOveRp5zx3fRCNj/22b8sYtrJmjo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:2291:b0:dcc:5a91:aee9 with SMTP id
 dn17-20020a056902229100b00dcc5a91aee9mr85473ybb.7.1707774018612; Mon, 12 Feb
 2024 13:40:18 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:07 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-22-surenb@google.com>
Subject: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
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

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/slab.h | 26 ++++++++++++++++++++++++++
 mm/slub.c |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 224a4b2305fb..c4bd0d5348cb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -629,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 
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
diff --git a/mm/slub.c b/mm/slub.c
index 9fd96238ed39..f4d5794c1e86 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,6 +3821,11 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
-- 
2.43.0.687.g38aa6559b0-goog


