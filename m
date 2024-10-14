Return-Path: <linux-arch+bounces-8113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FEA99D869
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D53B2178D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A251D89E4;
	Mon, 14 Oct 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoCvWsQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB11D0159
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938225; cv=none; b=APbui6SGrb52ukDLkvrOtAXsO8gGUE8ZEll6o0zezGmbfrDfv0KGdIcvAP/s8T26S431GlnOQQYNqCygqO3OO++aaJX83gXDoyOa+mM7zDxUi+rQiD4QE5X9jNNWwPlJ4DRePdiJGQKCVJxSKzHrBBQCXturoBO4baRTm1UVADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938225; c=relaxed/simple;
	bh=PpJpwll108+Kq61j5T43UFyRUVz4XXDNu8oqzIkCAiU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DuNWyG+JgVj59LvqEHQcECmWhDjmlQcYHqDy575cWq1rF22wZF2e4879KRyS6vPFvQWRnYUuafv6fPkDX8pvXbzQvcfNMN/wdzLzw5DxibPIVkOgifRrFxNl2tZp3bjIXDt3b3B2GMOq42a6m4d4FqhCKdvsAxpl64GlHkDOeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoCvWsQU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so48789987b3.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938221; x=1729543021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3awKuOd0YJMzv+83YLmL6cC1+LaUmoopuJw+yqAMR2w=;
        b=DoCvWsQUlsJORvxmYsG8nOvRa/wWKtIhQUsYNea985BSaC9URvWtRAK2ElfUPgbrsv
         /TPQOCQbxtVzKqKyamFSE65EJ41TE7rCfgElO9eTyN7nt8FDe0k+h4xMqiRV63w9zPZ6
         kH6ypm3go9apODgImEEUfnVJPrJTjZOOVhJYX4nV/0QoaxmNh3y4CbwbUfRg/D8l5Bog
         1fumj1k4M/WqkWMbr/2ho/yjxuCqbe0JilTS13xPQM/N2OhE2SqgT4oPNtRGK+HEkNUJ
         ulGObx91aaEZa7G6W7oY4uKsvgv++gjyF8+sT0ts4xwE7cdUTuvcV3RlCsoOGRDudXb6
         XQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938221; x=1729543021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3awKuOd0YJMzv+83YLmL6cC1+LaUmoopuJw+yqAMR2w=;
        b=ET1IEg5R2zO424Qh/cj9CrrO8McKBcjZ698H7+DEeTpOxh6sNs4XoXtvSQZw/ZROsZ
         l09FFR94e8k4RFv8kPIBf2zlce+Rzkm13CCAFe0BFYeNKSlkiLqNQmVM/arWra2AQwgC
         iTy0l9z8l45j5lFLyzN29zn1dttOn0XLL926bes4Pzth1xjE328StXY3gLzWEjM6+8Gv
         1eBi/tPXhAEYLapgkb2y//TH6HiyOd2Um7xbi5mj5dbAWlqNu4FZ3b6gWGwm34UXtqvs
         bMoT5MTqyDjwUs7+w0AS35G+9HOPZZm8+2pWlAY+xxBjRKXintQ+zwWn1bGMB+4I0Hpx
         klPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPsXyCAfnKhc9qVZN/4nZr6bpi38Gn1Zy661HHmPAxTJG57jx0aq64+/O3B1g/bPVjMB0AmfAzW78C@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl6loLPvoUSo95pY6z9hwUMQu1SNC2x5pEztJm/shN+wnbMOA
	K//WhYD3OxXV3Y+KlKN5WjKh+0wj1uUwuJWUncY9K+wokca1iO/l6ZMX6n2IMVEikygQugvrsFP
	AhQ==
X-Google-Smtp-Source: AGHT+IFg9tfmO7bztO2On8XBGLSENOaX0zqwxf4uBCk3a2PGQpcqPZvt7HPa1I/o1H4N1GNxRLUB/lu7jhs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:915:bdd7:e08a:7997])
 (user=surenb job=sendgmr) by 2002:a05:690c:7446:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-6e347b4b2edmr460177b3.6.1728938220715; Mon, 14 Oct 2024
 13:37:00 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:36:46 -0700
In-Reply-To: <20241014203646.1952505-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014203646.1952505-6-surenb@google.com>
Subject: [PATCH v3 5/5] alloc_tag: config to store page allocation tag refs in
 page flags
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

Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
references directly in the page flags. This eliminates memory
overhead caused by page_ext and results in better performance
for page allocations.
If the number of available page flag bits is insufficient to
address all kernel allocations, profiling falls back to using
page extensions with an appropriate warning to disable this
config.
If dynamically loaded modules add enough tags that they can't
be addressed anymore with available page flag bits, memory
profiling gets disabled and a warning is issued.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h         |  10 +-
 include/linux/codetag.h           |   3 +
 include/linux/page-flags-layout.h |   7 ++
 include/linux/pgalloc_tag.h       | 184 +++++++++++++++++++++++++++++-
 lib/Kconfig.debug                 |  19 +++
 lib/alloc_tag.c                   |  90 ++++++++++++++-
 lib/codetag.c                     |   4 +-
 mm/mm_init.c                      |   5 +-
 8 files changed, 310 insertions(+), 12 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7431757999c5..4f811ec0ffe0 100644
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
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7d79818dc065..4f5c9e979bb9 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -111,5 +111,12 @@
 			    ZONES_WIDTH - LRU_GEN_WIDTH - SECTIONS_WIDTH - \
 			    NODES_WIDTH - KASAN_TAG_WIDTH - LAST_CPUPID_WIDTH)
 
+#define NR_NON_PAGEFLAG_BITS	(SECTIONS_WIDTH + NODES_WIDTH + ZONES_WIDTH + \
+				LAST_CPUPID_SHIFT + KASAN_TAG_WIDTH + \
+				LRU_GEN_WIDTH + LRU_REFS_WIDTH)
+
+#define NR_UNUSED_PAGEFLAG_BITS	(BITS_PER_LONG - \
+				(NR_NON_PAGEFLAG_BITS + NR_PAGEFLAGS))
+
 #endif
 #endif /* _LINUX_PAGE_FLAGS_LAYOUT */
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index bc65710ee1f9..69976cf747a6 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -9,6 +9,93 @@
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
+typedef u16	pgalloc_tag_ref;
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
+#else /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 typedef union codetag_ref	pgalloc_tag_ref;
 
 static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
@@ -21,8 +108,13 @@ static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 	pgref->ct = ref->ct;
 }
 
+static inline void alloc_tag_sec_init(void) {}
+
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 union pgtag_ref_handle {
 	pgalloc_tag_ref *pgref;	/* reference in page extension */
+	struct page *page;	/* reference in page flags */
 };
 
 #include <linux/page_ext.h>
@@ -40,8 +132,8 @@ static inline struct page_ext *page_ext_from_pgref(pgalloc_tag_ref *pgref)
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
-static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
-				    union pgtag_ref_handle *handle)
+static inline bool page_ext_get_page_tag_ref(struct page *page, union codetag_ref *ref,
+					     union pgtag_ref_handle *handle)
 {
 	struct page_ext *page_ext;
 	pgalloc_tag_ref *pgref;
@@ -59,7 +151,7 @@ static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
 	return true;
 }
 
-static inline void put_page_tag_ref(union pgtag_ref_handle handle)
+static inline void page_ext_put_page_tag_ref(union pgtag_ref_handle handle)
 {
 	if (WARN_ON(!handle.pgref))
 		return;
@@ -67,8 +159,8 @@ static inline void put_page_tag_ref(union pgtag_ref_handle handle)
 	page_ext_put(page_ext_from_pgref(handle.pgref));
 }
 
-static inline void update_page_tag_ref(union pgtag_ref_handle handle,
-				       union codetag_ref *ref)
+static inline void page_ext_update_page_tag_ref(union pgtag_ref_handle handle,
+						union codetag_ref *ref)
 {
 	if (WARN_ON(!handle.pgref || !ref))
 		return;
@@ -76,6 +168,87 @@ static inline void update_page_tag_ref(union pgtag_ref_handle handle,
 	write_pgref(handle.pgref, ref);
 }
 
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
+DECLARE_STATIC_KEY_TRUE(mem_profiling_use_pageflags);
+extern unsigned long alloc_tag_ref_mask;
+extern int alloc_tag_ref_offs;
+
+/* Should be called only if mem_alloc_profiling_enabled() */
+static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
+				    union pgtag_ref_handle *handle)
+{
+	pgalloc_tag_ref pgref;
+
+	if (!static_key_enabled(&mem_profiling_use_pageflags))
+		return page_ext_get_page_tag_ref(page, ref, handle);
+
+	if (!page)
+		return false;
+
+	pgref = (page->flags >> alloc_tag_ref_offs) & alloc_tag_ref_mask;
+	read_pgref(&pgref, ref);
+	handle->page = page;
+	return true;
+}
+
+static inline void put_page_tag_ref(union pgtag_ref_handle handle)
+{
+	if (!static_key_enabled(&mem_profiling_use_pageflags)) {
+		page_ext_put_page_tag_ref(handle);
+		return;
+	}
+
+	WARN_ON(!handle.page);
+}
+
+static inline void update_page_tag_ref(union pgtag_ref_handle handle, union codetag_ref *ref)
+{
+	unsigned long old_flags, flags, val;
+	struct page *page = handle.page;
+	pgalloc_tag_ref pgref;
+
+	if (!static_key_enabled(&mem_profiling_use_pageflags)) {
+		page_ext_update_page_tag_ref(handle, ref);
+		return;
+	}
+
+	if (WARN_ON(!page || !ref))
+		return;
+
+	write_pgref(&pgref, ref);
+	val = (unsigned long)pgref;
+	val = (val & alloc_tag_ref_mask) << alloc_tag_ref_offs;
+	do {
+		old_flags = READ_ONCE(page->flags);
+		flags = old_flags;
+		flags &= ~(alloc_tag_ref_mask << alloc_tag_ref_offs);
+		flags |= val;
+	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+}
+
+#else /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
+/* Should be called only if mem_alloc_profiling_enabled() */
+static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
+				    union pgtag_ref_handle *handle)
+{
+	return page_ext_get_page_tag_ref(page, ref, handle);
+}
+
+static inline void put_page_tag_ref(union pgtag_ref_handle handle)
+{
+	page_ext_put_page_tag_ref(handle);
+}
+
+static inline void update_page_tag_ref(union pgtag_ref_handle handle,
+				       union codetag_ref *ref)
+{
+	page_ext_update_page_tag_ref(handle, ref);
+}
+
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 static inline void clear_page_tag_ref(struct page *page)
 {
 	if (mem_alloc_profiling_enabled()) {
@@ -152,6 +325,7 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
+static inline void alloc_tag_sec_init(void) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..f4c272c30719 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1017,6 +1017,25 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config PGALLOC_TAG_USE_PAGEFLAGS
+	bool "Use pageflags to encode page allocation tag reference"
+	default n
+	depends on MEM_ALLOC_PROFILING
+	help
+	  When set, page allocation tag references are encoded inside page
+	  flags if they fit, otherwise they are encoded in page extensions.
+
+	  Setting this flag reduces memory and performance overhead of memory
+	  allocation profiling but it requires enough unused page flag bits to
+	  address all kernel allocations. If enabled but there are not enough
+	  unused page flag bits, profiling will fall back to using page
+	  extensions and a warning will be issued to disable this config.
+	  If dynamically loaded modules add enough tags that they can't be
+	  addressed anymore with available page flag bits, profiling for such
+	  modules will be disabled and a warning will be issued.
+
+	  Say N if unsure.
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 2ef762acc203..341a5c826449 100644
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
@@ -152,6 +153,42 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+
+DEFINE_STATIC_KEY_TRUE(mem_profiling_use_pageflags);
+unsigned long alloc_tag_ref_mask;
+int alloc_tag_ref_offs;
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
+
+	/* Check if kernel tags fit into page flags */
+	if (kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
+		static_branch_disable(&mem_profiling_use_pageflags);
+		pr_warn("%lu kernel tags do not fit into %d available page flag bits, page extensions will be used instead!\n",
+			kernel_tags.count, NR_UNUSED_PAGEFLAG_BITS);
+	} else {
+		alloc_tag_ref_offs = (LRU_REFS_PGOFF - NR_UNUSED_PAGEFLAG_BITS);
+		alloc_tag_ref_mask = ((1UL << NR_UNUSED_PAGEFLAG_BITS) - 1);
+		pr_info("All unused page flags (%d bits) are used to store page tag references!\n",
+			NR_UNUSED_PAGEFLAG_BITS);
+	}
+}
+
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
@@ -161,7 +198,29 @@ static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
 static struct module prepend_mod;
 
-static struct alloc_tag_module_section module_tags;
+struct alloc_tag_module_section module_tags;
+
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+static inline unsigned long alloc_tag_align(unsigned long val)
+{
+	if (val % sizeof(struct alloc_tag) == 0)
+		return val;
+	return ((val / sizeof(struct alloc_tag)) + 1) * sizeof(struct alloc_tag);
+}
+
+static inline bool tags_addressable(void)
+{
+	unsigned long tag_idx_count = CODETAG_ID_FIRST + kernel_tags.count +
+					module_tags.size / sizeof(struct alloc_tag);
+
+	return tag_idx_count < (1UL << NR_UNUSED_PAGEFLAG_BITS);
+}
+
+#else /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
+
+static inline bool tags_addressable(void) { return true; }
+
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
 
 static bool needs_section_mem(struct module *mod, unsigned long size)
 {
@@ -237,6 +296,21 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (!align)
 		align = 1;
 
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+	/*
+	 * If alloc_tag size is not a multiple of required alignment tag
+	 * indexing does not work.
+	 */
+	if (!IS_ALIGNED(sizeof(struct alloc_tag), align)) {
+		pr_err("%s: alignment %lu is incompatible with allocation tag indexing, disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS",
+			mod->name, align);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Ensure prepend consumes multiple of alloc_tag-sized blocks */
+	if (prepend)
+		prepend = alloc_tag_align(prepend);
+#endif /* CONFIG_PGALLOC_TAG_USE_PAGEFLAGS */
 	mas_lock(&mas);
 repeat:
 	/* Try finding exact size and hope the start is aligned */
@@ -305,6 +379,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
 
 		module_tags.size = offset + size;
+		if (!tags_addressable() && mem_alloc_profiling_enabled()) {
+			static_branch_disable(&mem_alloc_profiling_key);
+			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory profiling is disabled!\n",
+				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+		}
+
 		if (phys_size < module_tags.size) {
 			int grow_res;
 
@@ -406,6 +486,10 @@ static int __init alloc_mod_tags_mem(void)
 
 	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
 	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+	/* Ensure the base is alloc_tag aligned */
+	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
+#endif
 
 	return 0;
 }
@@ -467,6 +551,10 @@ early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
 
 static __init bool need_page_alloc_tagging(void)
 {
+#ifdef CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
+	if (static_key_enabled(&mem_profiling_use_pageflags))
+		return false;
+#endif
 	return mem_profiling_support;
 }
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 3f3a4f4ca72d..cda5a852ef30 100644
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
index 4ba5607aaf19..1c205b0a86ed 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -83,8 +83,7 @@ void __init mminit_verify_pageflags_layout(void)
 	unsigned long or_mask, add_mask;
 
 	shift = BITS_PER_LONG;
-	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
-		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
+	width = shift - NR_NON_PAGEFLAG_BITS;
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
 		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d Gen %d Tier %d Flags %d\n",
 		SECTIONS_WIDTH,
@@ -2639,7 +2638,7 @@ void __init mm_core_init(void)
 	BUILD_BUG_ON(MAX_ZONELISTS > 2);
 	build_all_zonelists(NULL);
 	page_alloc_init_cpuhp();
-
+	alloc_tag_sec_init();
 	/*
 	 * page_ext requires contiguous pages,
 	 * bigger than MAX_PAGE_ORDER unless SPARSEMEM.
-- 
2.47.0.rc1.288.g06298d1525-goog


