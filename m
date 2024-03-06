Return-Path: <linux-arch+bounces-2850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BB873EC6
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E391C212C2
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC4144047;
	Wed,  6 Mar 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdL50ccR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A127143C69
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749505; cv=none; b=HoIgjn+uzKPa6bZwlixJWlhkd2B0SidqQOMRMcx9es9L4FdLWMxiDKEnQSGCZ+O1uYQJRoNIPbrcy0oDdWJnjx+iWeOgAcrHXMT+MO6sfUbxJp6d/nN0PVerZnCb9qHoQCB4XnXsUS/VaFbso+aYpHWNOYA6b7EN9ADBVoN//RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749505; c=relaxed/simple;
	bh=mR/WH4/rGc0Yxkm2oc530v0+CTDwReRkmqPn4EB+6Eg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WXr7x+imF2l58YHIYr0C4Qb5+128wZEyPj7dVSf4Qp2oJihWF6hzFZr8JsMy/Vb40PYjho902JJTt6e1D2VGUs7+sPFCLorK8Oc8biuxKTd7oWE18Qzgv9O1KmT3wo2c8FzPObMsRVpN9zAIw3MWS9RGdIqoWUoIKEs9z5a762s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdL50ccR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so13129607b3.1
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749502; x=1710354302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWCYv1v0m9ThdSU1Yjo1XvUgYihcegNMceRH273060M=;
        b=vdL50ccRjoB/oXSJD6TM7743OkFzxKWggMNNZzSLtf+6y546eprVGJCSP35bl3yBE6
         PcCwog/rDnwT3rUu6b96Y7Qe4XBxn5Dvd2ZGSFLoxDpcyuEOj6iMsTW8fBLxD74R/XMY
         ZNT6oLe/c/V0K0Vk5cByzUdscSQ2+ESkH0ZDRifQwcd5aWAvQfz1qAtkqrMjfi/pw4ym
         a71xL69B1tYy/I8hJ93m0hNjDl22vfh/JBiby030K24cCipE8A5fv02R72gQjbOJjxUD
         dhIfPOhjEAfM98A6cHvErycDFx1EGkybQgMntxw1A0QKFq4xZ4Mk47Ett1dxNE2aUs92
         QQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749502; x=1710354302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWCYv1v0m9ThdSU1Yjo1XvUgYihcegNMceRH273060M=;
        b=T0PPLgU5nOIlpGZqVLo3kYKC+t5iFIR9s4XUWvOOYY681nYSCDEG0YXm7n3DnxRN8J
         YJJ07zEKE/Zrj0yQMG3y0gTwqVsfrGG7el2OqxADV5A7gI6WNQa7HxJXUR7lg2/rUJ6b
         QO5jkk9HKMi7g8RtUGfsc25rt0wSjqwQ5c025CTDes2bUkDIErDAvIjlzMx5IuaQ/5Y4
         nQG7wc/9gaW6IBZD9RAb38KRFs6hrAXWbJ6zZvhHNZbNe+XJCG0MYKN7Gr4cAmPFJH3G
         n85K/rY9EbvPXIuQ9YAUkXJqW67O8+1Z6s/DSsL78Yjw55NuHDxYUoMVXDFIANtmjRYd
         v+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYQv0OZA/sz+8aZMEenP0uHjjM6gSml7MhA0KLGypTnSmAHZzBFqN16sTKLO294wfLBZJW0CzgRuzUrIfZMtslzakd6rhSDZ7hxA==
X-Gm-Message-State: AOJu0YwzTbenazRRwNk5xKhXJbhRHm+6fGbZEBsAih8se/y77w61FqhR
	C3k49nnMEwcZay+zmC9Yc53pFlUEouRQ5RVMzazwjGWLR3tFReCpjC0Gl7InbR8ygssjTvDyypI
	IsQ==
X-Google-Smtp-Source: AGHT+IGnljfjTXizPPHvZAgx20zMOkYizKuctvx7GCLoCP3KSTZj+nHPn74pStdoBYj7G+M/rBJH3HI3tiw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a5b:54c:0:b0:dc7:5925:92d2 with SMTP id
 r12-20020a5b054c000000b00dc7592592d2mr1248065ybp.1.1709749502066; Wed, 06 Mar
 2024 10:25:02 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:06 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-9-surenb@google.com>
Subject: [PATCH v5 08/37] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 6 ++++++
 mm/slub.c            | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..58794043ab5b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -28,6 +28,12 @@
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
 #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
+/* Slab created using create_boot_cache */
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define SLAB_NO_OBJ_EXT		((slab_flags_t __force)0x00000200U)
+#else
+#define SLAB_NO_OBJ_EXT		0
+#endif
 /* DEBUG: Red zone objs in a cache */
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
diff --git a/mm/slub.c b/mm/slub.c
index 2ba5d7b2711d..e94d3cc1b270 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5704,7 +5704,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5714,7 +5715,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.44.0.278.ge034bb2e1d-goog


