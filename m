Return-Path: <linux-arch+bounces-6891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103C967E99
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 06:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC242818E5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 04:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4B16EC1B;
	Mon,  2 Sep 2024 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lubv6Fnf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8331155739
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252105; cv=none; b=WtaWT7Q7D1UiFIKLyP4NZ5JJan+YAUGgDynTeOTQLP6KQQ2LaAc5Cl6uu/OuR5qzsVJOA8G29SOzCZRv4aUIlfeaC8ycVikeOPQMNFzVGD51+6omwzpqLj/TPQnlHGPKVP7SyorR+x3cbpdWNHEu2DsFkNMqCnwUjAu0931YZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252105; c=relaxed/simple;
	bh=E4oc23KhDb6ZE9N3AIvlxHWCldpXbbwIWiTUFvrD6V4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwegcMWuadfx3zGDD60xsYfo8EOTZoC/YXOJBcn9dHxdxM8Wi3TkNryDOy4FTEnJusWHqoiIMvwDmTPabT7vQEF79L27a3VcfFlfy2bDY97vhB90B6U95iEjnlLAEm7Zl/WrCQdRHbfP63LJbzw6wNKZDdt2yt8gnK3RWW62TSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lubv6Fnf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso7932799276.1
        for <linux-arch@vger.kernel.org>; Sun, 01 Sep 2024 21:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252102; x=1725856902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIAzqL0tmqWuUadipZSgPIzfdbVk1YeOcL9yjZr6O/Q=;
        b=Lubv6FnfD+nPCUWXX+IoCGhSr1VA+iBmf7a6V6w4v7e5wADCA+icU8uLLKrnpYRFzf
         FpZI5lqFxXZpK6ifx/ijy5yw9pxvKnwo+lh2JsDNmUIPgmHzZ9PHWECC0D2YK58ZKvo8
         dc/bulEdShbMIGCS6IfqbcIPtXOnTwdTh2KM9ZB2A1aDf1hnQvA6hTWSZMkMZyZMpVXl
         wMsom8T4MU+BZnAWZPi/41b5dZdfMJB3uL63tSDEBQ29fYkMuQuSWFq4/15f3bsLGucs
         E1aJ3SSjq9un2c7X00effOFUMCDX3JnBBqMEsfxkHSqkJ+b6EYi4B8xmviDztLyIjFHr
         EuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252102; x=1725856902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIAzqL0tmqWuUadipZSgPIzfdbVk1YeOcL9yjZr6O/Q=;
        b=wfd1sdm4DzNoq7Qowbiwc1mB1vSgaCOCO6WV3G4RJhhoEVEc8K53a0VirXWJPpG/7A
         FfmFOWfhdPSSXMDNONDwHDGWvIIGlKyF9KmBOffXdh5f9QAkkZfLPA43KgCnFTK+wCJN
         6xXW0oP5/JV0cZMtmtK5cC1n7MvQG+GTf9ahX8yR40XCHTVmZ/kcpiVk39xY6bO4mhGr
         rmxBsPX5Ccrp68oBjdEVOr6AbstGNFFMzXIV8DJkdUONaBe6zzHjfBswoYDuGx3RuZ8K
         +7hg7d+6L0GBf6sQ2Ue/GaAZhyfqijm736MARBJXloMEL4uarQjm0w6wKawc+QnGzaCP
         dgxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFDia+ZmtkUONDsB3lrvtgreUA9N7xXfC8kJ4du1IBd4f5Vjqy6QzGfv7/0TDAh2+o9U4vYjvnKJRY@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCb65G4IjfFTMAuT7J0Wl8XsUVncUYaSUtxWu2cHJMGuJRthr
	KiU7cRYJfjiBZP6JiLK1hNgbuBjCCtoWS3in0nKe6PynLCHdplLuKlnoxzIU7Uz6KrkdEUqL28L
	T5A==
X-Google-Smtp-Source: AGHT+IGweUdtvzfkyW3WmJuGFzyyd2e8B2d2obHsNq5jvXmRb4BdxuAkJtcuoa6tBEzRO4VbtFxeXiTxIrs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a5b:d06:0:b0:e11:6a73:b0d with SMTP id
 3f1490d57ef6-e1a7a171852mr16567276.6.1725252102521; Sun, 01 Sep 2024 21:41:42
 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:27 -0700
In-Reply-To: <20240902044128.664075-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-6-surenb@google.com>
Subject: [PATCH v2 5/6] alloc_tag: make page allocation tag reference size configurable
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
page allocation tag references. When the size is configured to be
less than a direct pointer, the tags are searched using an index
stored as the tag reference.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 10 +++-
 include/linux/codetag.h     |  3 ++
 include/linux/pgalloc_tag.h | 99 +++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           | 11 +++++
 lib/alloc_tag.c             | 51 ++++++++++++++++++-
 lib/codetag.c               |  4 +-
 mm/mm_init.c                |  1 +
 7 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 21e3098220e3..b5cf24517333 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,8 +30,16 @@ struct alloc_tag {
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
+struct alloc_tag_kernel_section {
+	struct alloc_tag *first_tag;
+	unsigned long count;
+};
+
 struct alloc_tag_module_section {
-	unsigned long start_addr;
+	union {
+		unsigned long start_addr;
+		struct alloc_tag *first_tag;
+	};
 	unsigned long end_addr;
 	/* used size */
 	unsigned long size;
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index fb4e7adfa746..401fc297eeda 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -13,6 +13,9 @@ struct codetag_module;
 struct seq_buf;
 struct module;
 
+#define CODETAG_SECTION_START_PREFIX	"__start_"
+#define CODETAG_SECTION_STOP_PREFIX	"__stop_"
+
 /*
  * An instance of this structure is created in a special ELF section at every
  * code location being tagged.  At runtime, the special section is treated as
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index c76b629d0206..a7f8f00c118f 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -9,7 +9,18 @@
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+#if !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32
+#define PGALLOC_TAG_DIRECT_REF
 typedef union codetag_ref	pgalloc_tag_ref;
+#else /* !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32 */
+#if CONFIG_PGALLOC_TAG_REF_BITS > 16
+typedef u32	pgalloc_tag_ref;
+#else
+typedef u16	pgalloc_tag_ref;
+#endif
+#endif /* !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32 */
+
+#ifdef PGALLOC_TAG_DIRECT_REF
 
 static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 {
@@ -20,6 +31,93 @@ static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 {
 	pgref->ct = ref->ct;
 }
+
+static inline void alloc_tag_sec_init(void) {}
+
+#else /* PGALLOC_TAG_DIRECT_REF */
+
+extern struct alloc_tag_kernel_section kernel_tags;
+
+#define CODETAG_ID_NULL		0
+#define CODETAG_ID_EMPTY	1
+#define CODETAG_ID_FIRST	2
+
+#ifdef CONFIG_MODULES
+
+extern struct alloc_tag_module_section module_tags;
+
+static inline struct codetag *get_module_ct(pgalloc_tag_ref pgref)
+{
+	return &module_tags.first_tag[pgref - kernel_tags.count].ct;
+}
+
+static inline pgalloc_tag_ref get_module_pgref(struct alloc_tag *tag)
+{
+	return CODETAG_ID_FIRST + kernel_tags.count + (tag - module_tags.first_tag);
+}
+
+#else /* CONFIG_MODULES */
+
+static inline struct codetag *get_module_ct(pgalloc_tag_ref pgref)
+{
+	pr_warn("invalid page tag reference %lu\n", (unsigned long)pgref);
+	return NULL;
+}
+
+static inline pgalloc_tag_ref get_module_pgref(struct alloc_tag *tag)
+{
+	pr_warn("invalid page tag 0x%lx\n", (unsigned long)tag);
+	return CODETAG_ID_NULL;
+}
+
+#endif /* CONFIG_MODULES */
+
+static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	pgalloc_tag_ref pgref_val = *pgref;
+
+	switch (pgref_val) {
+	case (CODETAG_ID_NULL):
+		ref->ct = NULL;
+		break;
+	case (CODETAG_ID_EMPTY):
+		set_codetag_empty(ref);
+		break;
+	default:
+		pgref_val -= CODETAG_ID_FIRST;
+		ref->ct = pgref_val < kernel_tags.count ?
+			&kernel_tags.first_tag[pgref_val].ct :
+			get_module_ct(pgref_val);
+		break;
+	}
+}
+
+static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	struct alloc_tag *tag;
+
+	if (!ref->ct) {
+		*pgref = CODETAG_ID_NULL;
+		return;
+	}
+
+	if (is_codetag_empty(ref)) {
+		*pgref = CODETAG_ID_EMPTY;
+		return;
+	}
+
+	tag = ct_to_alloc_tag(ref->ct);
+	if (tag >= kernel_tags.first_tag && tag < kernel_tags.first_tag + kernel_tags.count) {
+		*pgref = CODETAG_ID_FIRST + (tag - kernel_tags.first_tag);
+		return;
+	}
+
+	*pgref = get_module_pgref(tag);
+}
+
+void __init alloc_tag_sec_init(void);
+
+#endif /* PGALLOC_TAG_DIRECT_REF */
 #include <linux/page_ext.h>
 
 extern struct page_ext_operations page_alloc_tagging_ops;
@@ -197,6 +295,7 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
+static inline void alloc_tag_sec_init(void) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..253f9c2028da 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1000,6 +1000,17 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config PGALLOC_TAG_REF_BITS
+	int "Number of bits for page allocation tag reference (10-64)"
+	range 10 64
+	default "64"
+	depends on MEM_ALLOC_PROFILING
+	help
+	  Number of bits used to encode a page allocation tag reference.
+
+	  Smaller number results in less memory overhead but limits the number of
+	  allocations which can be tagged (including allocations from modules).
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 53bd3236d30b..73791aa55ab6 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -3,6 +3,7 @@
 #include <linux/execmem.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
 #include <linux/pgalloc_tag.h>
@@ -151,6 +152,26 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
+#ifndef PGALLOC_TAG_DIRECT_REF
+
+#define SECTION_START(NAME)	(CODETAG_SECTION_START_PREFIX NAME)
+#define SECTION_STOP(NAME)	(CODETAG_SECTION_STOP_PREFIX NAME)
+
+struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
+
+void __init alloc_tag_sec_init(void)
+{
+	struct alloc_tag *last_codetag;
+
+	kernel_tags.first_tag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_START(ALLOC_TAG_SECTION_NAME));
+	last_codetag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_STOP(ALLOC_TAG_SECTION_NAME));
+	kernel_tags.count = last_codetag - kernel_tags.first_tag;
+}
+
+#endif /* PGALLOC_TAG_DIRECT_REF */
+
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
@@ -159,7 +180,16 @@ static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
 static struct module prepend_mod;
 
-static struct alloc_tag_module_section module_tags;
+struct alloc_tag_module_section module_tags;
+
+#ifndef PGALLOC_TAG_DIRECT_REF
+static inline unsigned long alloc_tag_align(unsigned long val)
+{
+	if (val % sizeof(struct alloc_tag) == 0)
+		return val;
+	return ((val / sizeof(struct alloc_tag)) + 1) * sizeof(struct alloc_tag);
+}
+#endif /* PGALLOC_TAG_DIRECT_REF */
 
 static bool needs_section_mem(struct module *mod, unsigned long size)
 {
@@ -216,6 +246,21 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (!align)
 		align = 1;
 
+#ifndef PGALLOC_TAG_DIRECT_REF
+	/*
+	 * If alloc_tag size is not a multiple of required alignment tag
+	 * indexing does not work.
+	 */
+	if (!IS_ALIGNED(sizeof(struct alloc_tag), align)) {
+		pr_err("%s: alignment %lu is incompatible with allocation tag indexing (CONFIG_PGALLOC_TAG_REF_BITS)",
+			mod->name, align);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Ensure prepend consumes multiple of alloc_tag-sized blocks */
+	if (prepend)
+		prepend = alloc_tag_align(prepend);
+#endif /* PGALLOC_TAG_DIRECT_REF */
 	mas_lock(&mas);
 repeat:
 	/* Try finding exact size and hope the start is aligned */
@@ -373,6 +418,10 @@ static int __init alloc_mod_tags_mem(void)
 		return -ENOMEM;
 
 	module_tags.end_addr = module_tags.start_addr + module_tags_mem_sz;
+#ifndef PGALLOC_TAG_DIRECT_REF
+	/* Ensure the base is alloc_tag aligned */
+	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
+#endif
 
 	return 0;
 }
diff --git a/lib/codetag.c b/lib/codetag.c
index 60463ef4bb85..cb3aa1631417 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -149,8 +149,8 @@ static struct codetag_range get_section_range(struct module *mod,
 					      const char *section)
 {
 	return (struct codetag_range) {
-		get_symbol(mod, "__start_", section),
-		get_symbol(mod, "__stop_", section),
+		get_symbol(mod, CODETAG_SECTION_START_PREFIX, section),
+		get_symbol(mod, CODETAG_SECTION_STOP_PREFIX, section),
 	};
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..231a95782455 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2650,6 +2650,7 @@ void __init mm_core_init(void)
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
+	alloc_tag_sec_init();
 	mem_init();
 	kmem_cache_init();
 	/*
-- 
2.46.0.469.g59c65b2a67-goog


