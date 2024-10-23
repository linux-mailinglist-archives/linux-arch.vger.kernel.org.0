Return-Path: <linux-arch+bounces-8487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A09AD236
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92B6B25270
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1881D14EA;
	Wed, 23 Oct 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpeM1YZi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC81D0796
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703298; cv=none; b=EmpM72FVx25H34dGMJzv+14lLZdimEUu7401ymRqvZmotWc3qddm6CC6VVKSKoQJ/cg5tqhjoBtjOkcUfxb4fnvhVf7sqJ+dHBM3IjoCDU9Jd7fJJvz6UU630FH0eM7SaFVV1z1XJAIDt/tdOaWk0VbhFPzzcxofayT73ooK+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703298; c=relaxed/simple;
	bh=GrkyMactMUumDxMQ8TJnIaREPJ1yXV+q+168Cd4Deg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R+unhJKG4e4Z4q3A7VNxONHD8fItBAZbok9QLxGHzX58lO47f+OakHwme7/9G/LD8px2/p/Napz8oPb5GnuawH3dF3/pCfCd29QyH/TbGtmIDWkM86qXFd0xPwIJqaS2apHT35dBQLns/XTZh+EMfy6sNWjdMyFKIAzDAj4oYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpeM1YZi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd09d2505so22932276.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703294; x=1730308094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUAPSrGkP1fndYxBbEXwkdRLC1ZGIzlRm3shVAxWj1o=;
        b=OpeM1YZiF3LkgDlCnLPckp1CQyhG9bDgBg11XJXv8h+4gEKDxmKRWMKY0WqI2ui0G6
         tSf0DepCCFwGTTCnojfyX4W0HNllUu5h9XthBOdlQXj5LyQZ8t7XTfbVyJ5TAuYDRflk
         JqYjYOBE3e1IWHNJS4WvWoaANFg5FM7pXWfFLJPXEyEZS+NsSkOWjARSFGgInPxucgRv
         0ODxrgGe099fY23Ogo+Dh1eaR9zHAf2UwSabhqSQN65wf+UQ4WK8wS5eD6B1Y9+Y7rNo
         OR5dTCHngWivqOF/xQ/mSha339V6dKu3FaILwAAYI2c5M6MGQWmp2XWsB48DGSFFyelz
         hIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703294; x=1730308094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUAPSrGkP1fndYxBbEXwkdRLC1ZGIzlRm3shVAxWj1o=;
        b=NtbNr0SunsZ1nENKs2CapAhnVE6bzdhznpZAYBGKN4BslPfPM9HrLs5NDfqDVa5ZOS
         L71OY+I/kY8HPyqk6heSlpLM+OAH+q7qLN9zA6EMCT/jhdYmf+nnowh4+9EKiAQW57qX
         eJh7lpiWwnu+OLtVB3Y38gBg5heXxZM80LstoR24WQpkqlg/euoChTp4cO6TJxCWv3Pr
         2bmBPJqN2UNAwTpyycLJRlguiIMaOkrTFyz7ztQuOUkIccc/K8SjAExO/AL3QdFaOeFk
         YOgBxdxT1G82lMPiFrxCleChvgu1JTLRfW56bPKcG951opiwRm30IE3hF/hKJJuY5mun
         YcwA==
X-Forwarded-Encrypted: i=1; AJvYcCXdUE9vuU9zf/AuO+69e0mzLa16FSqlS+AP4F2w0MyuyPRmGkniLZj5Rndgdm7P6DIt+BtLSbl0PDBc@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXYK3cuLJPuO9U64ZzbJkVg7PHDZfl53ezubNcBC7+mdQYu/K
	hPy1U6JTdjvJ6qFnrqL+SK30HWoW+azOk7zG8GWvZG/DrUGEEjPpf38MbyXLgvGQciQztoLhjad
	AqA==
X-Google-Smtp-Source: AGHT+IGRE52J3Q/FMmtRptFBkvIdYNYKY+K4lu8CvvfN06S+6RGcE++e1CnN4bokrfVHywZPohucB5wHvBc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a25:9787:0:b0:e29:7cfa:9fbc with SMTP id
 3f1490d57ef6-e2e3a6dc4d5mr1689276.11.1729703294360; Wed, 23 Oct 2024 10:08:14
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:59 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-7-surenb@google.com>
Subject: [PATCH v4 6/6] alloc_tag: support for page allocation tag compression
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Implement support for storing page allocation tag references directly
in the page flags instead of page extensions. sysctl.vm.mem_profiling
boot parameter it extended to provide a way for a user to request this
mode. Enabling compression eliminates memory overhead caused by page_ext
and results in better performance for page allocations. However this
mode will not work if the number of available page flag bits is
insufficient to address all kernel allocations. Such condition can
happen during boot or when loading a module. If this condition is
detected, memory allocation profiling gets disabled with an appropriate
warning. By default compression mode is disabled.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst |   7 +-
 include/linux/alloc_tag.h                 |  10 +-
 include/linux/codetag.h                   |   3 +
 include/linux/page-flags-layout.h         |   7 ++
 include/linux/pgalloc_tag.h               | 145 +++++++++++++++++++---
 lib/alloc_tag.c                           | 142 +++++++++++++++++++--
 lib/codetag.c                             |   4 +-
 mm/mm_init.c                              |   5 +-
 8 files changed, 290 insertions(+), 33 deletions(-)

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
index ffd6655b7be2..316311240e6a 100644
--- a/Documentation/mm/allocation-profiling.rst
+++ b/Documentation/mm/allocation-profiling.rst
@@ -18,12 +18,17 @@ kconfig options:
   missing annotation
 
 Boot parameter:
-  sysctl.vm.mem_profiling=0|1|never
+  sysctl.vm.mem_profiling={0|1|never}[,compressed]
 
   When set to "never", memory allocation profiling overhead is minimized and it
   cannot be enabled at runtime (sysctl becomes read-only).
   When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y, default value is "1".
   When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n, default value is "never".
+  "compressed" optional parameter will try to store page tag references in a
+  compact format, avoiding page extensions. This results in improved performance
+  and memory consumption, however it might fail depending on system configuration.
+  If compression fails, a warning is issued and memory allocation profiling gets
+  disabled.
 
 sysctl:
   /proc/sys/vm/mem_profiling
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
index d10bd9810d32..d14dbd26b370 100644
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
index b13cd3313a88..1fe63b52e5e5 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -11,29 +11,118 @@
 
 #include <linux/page_ext.h>
 
+extern struct page_ext_operations page_alloc_tagging_ops;
+extern unsigned long alloc_tag_ref_mask;
+extern int alloc_tag_ref_offs;
+extern struct alloc_tag_kernel_section kernel_tags;
+
+DECLARE_STATIC_KEY_FALSE(mem_profiling_compressed);
+
+typedef u16	pgalloc_tag_idx;
+
 union pgtag_ref_handle {
 	union codetag_ref *ref;	/* reference in page extension */
+	struct page *page;	/* reference in page flags */
 };
 
-extern struct page_ext_operations page_alloc_tagging_ops;
+/* Reserved indexes */
+#define CODETAG_ID_NULL		0
+#define CODETAG_ID_EMPTY	1
+#define CODETAG_ID_FIRST	2
+
+#ifdef CONFIG_MODULES
+
+extern struct alloc_tag_module_section module_tags;
+
+static inline struct alloc_tag *module_idx_to_tag(pgalloc_tag_idx idx)
+{
+	return &module_tags.first_tag[idx - kernel_tags.count];
+}
+
+static inline pgalloc_tag_idx module_tag_to_idx(struct alloc_tag *tag)
+{
+	return CODETAG_ID_FIRST + kernel_tags.count + (tag - module_tags.first_tag);
+}
+
+#else /* CONFIG_MODULES */
+
+static inline struct alloc_tag *module_idx_to_tag(pgalloc_tag_idx idx)
+{
+	pr_warn("invalid page tag reference %lu\n", (unsigned long)idx);
+	return NULL;
+}
+
+static inline pgalloc_tag_idx module_tag_to_idx(struct alloc_tag *tag)
+{
+	pr_warn("invalid page tag 0x%lx\n", (unsigned long)tag);
+	return CODETAG_ID_NULL;
+}
+
+#endif /* CONFIG_MODULES */
+
+static inline void idx_to_ref(pgalloc_tag_idx idx, union codetag_ref *ref)
+{
+	switch (idx) {
+	case (CODETAG_ID_NULL):
+		ref->ct = NULL;
+		break;
+	case (CODETAG_ID_EMPTY):
+		set_codetag_empty(ref);
+		break;
+	default:
+		idx -= CODETAG_ID_FIRST;
+		ref->ct = idx < kernel_tags.count ?
+			&kernel_tags.first_tag[idx].ct :
+			&module_idx_to_tag(idx)->ct;
+		break;
+	}
+}
+
+static inline pgalloc_tag_idx ref_to_idx(union codetag_ref *ref)
+{
+	struct alloc_tag *tag;
+
+	if (!ref->ct)
+		return CODETAG_ID_NULL;
+
+	if (is_codetag_empty(ref))
+		return CODETAG_ID_EMPTY;
+
+	tag = ct_to_alloc_tag(ref->ct);
+	if (tag >= kernel_tags.first_tag && tag < kernel_tags.first_tag + kernel_tags.count)
+		return CODETAG_ID_FIRST + (tag - kernel_tags.first_tag);
+
+	return module_tag_to_idx(tag);
+}
+
+
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
 				    union pgtag_ref_handle *handle)
 {
-	struct page_ext *page_ext;
-	union codetag_ref *tmp;
-
 	if (!page)
 		return false;
 
-	page_ext = page_ext_get(page);
-	if (!page_ext)
-		return false;
+	if (static_key_enabled(&mem_profiling_compressed)) {
+		pgalloc_tag_idx idx;
+
+		idx = (page->flags >> alloc_tag_ref_offs) & alloc_tag_ref_mask;
+		idx_to_ref(idx, ref);
+		handle->page = page;
+	} else {
+		struct page_ext *page_ext;
+		union codetag_ref *tmp;
+
+		page_ext = page_ext_get(page);
+		if (!page_ext)
+			return false;
+
+		tmp = (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
+		ref->ct = tmp->ct;
+		handle->ref = tmp;
+	}
 
-	tmp = (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
-	ref->ct = tmp->ct;
-	handle->ref = tmp;
 	return true;
 }
 
@@ -42,16 +131,35 @@ static inline void put_page_tag_ref(union pgtag_ref_handle handle)
 	if (WARN_ON(!handle.ref))
 		return;
 
-	page_ext_put((void *)handle.ref - page_alloc_tagging_ops.offset);
+	if (!static_key_enabled(&mem_profiling_compressed))
+		page_ext_put((void *)handle.ref - page_alloc_tagging_ops.offset);
 }
 
-static inline void update_page_tag_ref(union pgtag_ref_handle handle,
-				       union codetag_ref *ref)
+static inline void update_page_tag_ref(union pgtag_ref_handle handle, union codetag_ref *ref)
 {
-	if (WARN_ON(!handle.ref || !ref))
-		return;
-
-	handle.ref->ct = ref->ct;
+	if (static_key_enabled(&mem_profiling_compressed)) {
+		struct page *page = handle.page;
+		unsigned long old_flags;
+		unsigned long flags;
+		unsigned long idx;
+
+		if (WARN_ON(!page || !ref))
+			return;
+
+		idx = (unsigned long)ref_to_idx(ref);
+		idx = (idx & alloc_tag_ref_mask) << alloc_tag_ref_offs;
+		do {
+			old_flags = READ_ONCE(page->flags);
+			flags = old_flags;
+			flags &= ~(alloc_tag_ref_mask << alloc_tag_ref_offs);
+			flags |= idx;
+		} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+	} else {
+		if (WARN_ON(!handle.ref || !ref))
+			return;
+
+		handle.ref->ct = ref->ct;
+	}
 }
 
 static inline void clear_page_tag_ref(struct page *page)
@@ -122,6 +230,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 		this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
 }
 
+void __init alloc_tag_sec_init(void);
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void clear_page_tag_ref(struct page *page) {}
@@ -130,6 +240,7 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
+static inline void alloc_tag_sec_init(void) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 061e43196247..a6f6f014461e 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -3,6 +3,7 @@
 #include <linux/execmem.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
 #include <linux/proc_fs.h>
@@ -12,6 +13,8 @@
 
 #define ALLOCINFO_FILE_NAME		"allocinfo"
 #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
+#define SECTION_START(NAME)		(CODETAG_SECTION_START_PREFIX NAME)
+#define SECTION_STOP(NAME)		(CODETAG_SECTION_STOP_PREFIX NAME)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
 static bool mem_profiling_support = true;
@@ -26,6 +29,11 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
+DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
+
+struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
+unsigned long alloc_tag_ref_mask;
+int alloc_tag_ref_offs;
 
 struct allocinfo_private {
 	struct codetag_iterator iter;
@@ -155,7 +163,7 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	return nr;
 }
 
-static void shutdown_mem_profiling(void)
+static void shutdown_mem_profiling(bool remove_file)
 {
 	if (mem_alloc_profiling_enabled())
 		static_branch_disable(&mem_alloc_profiling_key);
@@ -163,6 +171,8 @@ static void shutdown_mem_profiling(void)
 	if (!mem_profiling_support)
 		return;
 
+	if (remove_file)
+		remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
 	mem_profiling_support = false;
 }
 
@@ -173,10 +183,40 @@ static void __init procfs_init(void)
 
 	if (!proc_create_seq(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_seq_op)) {
 		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
-		shutdown_mem_profiling();
+		shutdown_mem_profiling(false);
 	}
 }
 
+void __init alloc_tag_sec_init(void)
+{
+	struct alloc_tag *last_codetag;
+
+	if (!mem_profiling_support)
+		return;
+
+	if (!static_key_enabled(&mem_profiling_compressed))
+		return;
+
+	kernel_tags.first_tag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_START(ALLOC_TAG_SECTION_NAME));
+	last_codetag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_STOP(ALLOC_TAG_SECTION_NAME));
+	kernel_tags.count = last_codetag - kernel_tags.first_tag;
+
+	/* Check if kernel tags fit into page flags */
+	if (kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
+		shutdown_mem_profiling(false); /* allocinfo file does not exist yet */
+		pr_err("%lu allocation tags cannot be references using %d available page flag bits. Memory allocation profiling is disabled!\n",
+			kernel_tags.count, NR_UNUSED_PAGEFLAG_BITS);
+		return;
+	}
+
+	alloc_tag_ref_offs = (LRU_REFS_PGOFF - NR_UNUSED_PAGEFLAG_BITS);
+	alloc_tag_ref_mask = ((1UL << NR_UNUSED_PAGEFLAG_BITS) - 1);
+	pr_debug("Memory allocation profiling compression is using %d page flag bits!\n",
+		 NR_UNUSED_PAGEFLAG_BITS);
+}
+
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
@@ -186,10 +226,59 @@ static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
 static struct module prepend_mod;
 
-static struct alloc_tag_module_section module_tags;
+struct alloc_tag_module_section module_tags;
+
+static inline unsigned long alloc_tag_align(unsigned long val)
+{
+	if (!static_key_enabled(&mem_profiling_compressed)) {
+		/* No alignment requirements when we are not indexing the tags */
+		return val;
+	}
+
+	if (val % sizeof(struct alloc_tag) == 0)
+		return val;
+	return ((val / sizeof(struct alloc_tag)) + 1) * sizeof(struct alloc_tag);
+}
+
+static bool ensure_alignment(unsigned long align, unsigned int *prepend)
+{
+	if (!static_key_enabled(&mem_profiling_compressed)) {
+		/* No alignment requirements when we are not indexing the tags */
+		return true;
+	}
+
+	/*
+	 * If alloc_tag size is not a multiple of required alignment, tag
+	 * indexing does not work.
+	 */
+	if (!IS_ALIGNED(sizeof(struct alloc_tag), align))
+		return false;
+
+	/* Ensure prepend consumes multiple of alloc_tag-sized blocks */
+	if (*prepend)
+		*prepend = alloc_tag_align(*prepend);
+
+	return true;
+}
+
+static inline bool tags_addressable(void)
+{
+	unsigned long tag_idx_count;
+
+	if (!static_key_enabled(&mem_profiling_compressed))
+		return true; /* with page_ext tags are always addressable */
+
+	tag_idx_count = CODETAG_ID_FIRST + kernel_tags.count +
+			module_tags.size / sizeof(struct alloc_tag);
+
+	return tag_idx_count < (1UL << NR_UNUSED_PAGEFLAG_BITS);
+}
 
 static bool needs_section_mem(struct module *mod, unsigned long size)
 {
+	if (!mem_profiling_support)
+		return false;
+
 	return size >= sizeof(struct alloc_tag);
 }
 
@@ -300,6 +389,13 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (!align)
 		align = 1;
 
+	if (!ensure_alignment(align, &prepend)) {
+		shutdown_mem_profiling(true);
+		pr_err("%s: alignment %lu is incompatible with allocation tag indexing. Memory allocation profiling is disabled!\n",
+			mod->name, align);
+		return ERR_PTR(-EINVAL);
+	}
+
 	mas_lock(&mas);
 	if (!find_aligned_area(&mas, section_size, size, prepend, align)) {
 		ret = ERR_PTR(-ENOMEM);
@@ -343,9 +439,15 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
+		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+			shutdown_mem_profiling(true);
+			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
+				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+		}
+
 		grow_res = vm_module_tags_populate();
 		if (grow_res) {
-			shutdown_mem_profiling();
+			shutdown_mem_profiling(true);
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
 			return ERR_PTR(grow_res);
@@ -429,6 +531,8 @@ static int __init alloc_mod_tags_mem(void)
 
 	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
 	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
+	/* Ensure the base is alloc_tag aligned when required for indexing */
+	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
 
 	return 0;
 }
@@ -451,8 +555,10 @@ static inline void free_mod_tags_mem(void) {}
 
 #endif /* CONFIG_MODULES */
 
+/* See: Documentation/mm/allocation-profiling.rst */
 static int __init setup_early_mem_profiling(char *str)
 {
+	bool compressed = false;
 	bool enable;
 
 	if (!str || !str[0])
@@ -461,22 +567,37 @@ static int __init setup_early_mem_profiling(char *str)
 	if (!strncmp(str, "never", 5)) {
 		enable = false;
 		mem_profiling_support = false;
+		pr_info("Memory allocation profiling is disabled!\n");
 	} else {
-		int res;
+		char *token = strsep(&str, ",");
+
+		if (kstrtobool(token, &enable))
+			return -EINVAL;
 
-		res = kstrtobool(str, &enable);
-		if (res)
-			return res;
+		if (str) {
 
+			if (strcmp(str, "compressed"))
+				return -EINVAL;
+
+			compressed = true;
+		}
 		mem_profiling_support = true;
+		pr_info("Memory allocation profiling is enabled %s compression and is turned %s!\n",
+			compressed ? "with" : "without", enable ? "on" : "off");
 	}
 
-	if (enable != static_key_enabled(&mem_alloc_profiling_key)) {
+	if (enable != mem_alloc_profiling_enabled()) {
 		if (enable)
 			static_branch_enable(&mem_alloc_profiling_key);
 		else
 			static_branch_disable(&mem_alloc_profiling_key);
 	}
+	if (compressed != static_key_enabled(&mem_profiling_compressed)) {
+		if (compressed)
+			static_branch_enable(&mem_profiling_compressed);
+		else
+			static_branch_disable(&mem_profiling_compressed);
+	}
 
 	return 0;
 }
@@ -484,6 +605,9 @@ early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
 
 static __init bool need_page_alloc_tagging(void)
 {
+	if (static_key_enabled(&mem_profiling_compressed))
+		return false;
+
 	return mem_profiling_support;
 }
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 654496952f86..4949511b4933 100644
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
2.47.0.105.g07ac214952-goog


