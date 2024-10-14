Return-Path: <linux-arch+bounces-8112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEF99D863
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C17B2180D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A21D433C;
	Mon, 14 Oct 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdT7Xb0Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FE1D2B11
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938221; cv=none; b=YrjZvEpjPph9tbHK7G9DOlD5pILcKxQncRV9fb+hB6cdsY6aBUDyIe9ZzU/VK+N0/bCqSQO8mmuKvC90+04wp/guRJPOZBGLA/VKg6++0Hk2H7fqUzqm85JnpuCPsGJB4XzBX/nmo57HAl8ivyFXtqAbydO/Rulo+d7JiV3lP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938221; c=relaxed/simple;
	bh=yjxn1wVWKUXE4jrDbtBUSLFw9D3HkS0XAuR2v9Mx6rI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTWbP7h7AhoqhEuggWq2fq1HiScYfbGnmrNqnp0wjlN8v2WhTXxZ25aOnGVWWnRrIkI8LXDCiyU9QGnKFJ0sSBhQv3nDKrKZSKw/Lzo7JBKbl7jr2LNmpxtTxhRdkqbvdIEYy358KE/sDCR3MpZ0FmW8u4XDe0Cz8TslrolEgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdT7Xb0Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2932b0f4fbso2800701276.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938219; x=1729543019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDELffEPLAPDpRQ8WZJTecgr0QxXWhGmdEuRSVQA138=;
        b=fdT7Xb0QC+icPH7YzRV3mR9O2DJZlTPEIRsXL4u8tkac4ufhVXr0oyNIOFT3lqq//C
         nXF1HKymKZZV5Ev3jBwh/brkCnwEEARnn0w1KHgelH+mscIlPhHiN3UoofCttP+9nLOK
         GEqTHwxSsh9dRhIBEU7QjLaVgZxq6ReNN7fL9rK18dwoM9XEROhyklbG6RuAUgRyHxxV
         ZYWIgzFu3/FPkfUEiIekd4CJFw5z/OaU7zI17bswAnUn4lFmw/IS0lv3e+YYz8tgU5R3
         zsI5EwVZR/nAYCia+ctfIaiU8GXdGoR9tGbJyCrpQulgTDyMeL/M8M1kKg9+IeSikHGz
         87+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938219; x=1729543019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDELffEPLAPDpRQ8WZJTecgr0QxXWhGmdEuRSVQA138=;
        b=XkiiZjS9pkwLmURVtmdnkcgNIa1Nc6hJBV19sQ7ngpIUyEG3WrYgd5OFqnoqxlsiOC
         OFJ8609BTb2h2unmeGakFpOBiqakzt7mar/2qwKq+BkTMnJV4Ctxuo0Dvunz015R/WiX
         fdXdhdW0OZnVJjtrzRRR3cCh/hAF/OtHa8A/1mcc73B1faOseEhXiIPLhDoxOIO5mD51
         2si0lSCmBYUiaHauyB+GVaEbkoBsh0JGlFpu3JvA8lLh4SnDUYDJmIH0OIzI3xP5Zl0i
         0Vu2dkjxJajlCrKD8kBtkxS/1AWlkBSNTFBO8SFt0V11xv9ZfwiovDmrXFtA/IKHJXJo
         5A6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4FiEWOlV02TZTxSIIcc7HPQom7CVaJe8Be3S53ohac5VFuH58aWhGs655B9gb6tyYA3tvU9U5ZfKw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoav0dFPjGx7TY6Lezmdd4Rx4zTwB3GCQc9BwQbg3NxVZ+OUrx
	wBvHEiO5QHtcZ1CvVb8h/lbNL0C5wR2hLSgkriJMVcmHeft5RmWP5/BLnYuGaipzMMpbz58mKVf
	xxA==
X-Google-Smtp-Source: AGHT+IFebmDDzFfa9NO21TdKX40eCmjiTPo05JzyoY7+ZX8h6EIqKu1BLOx2oszwApr2jiSzy+GImo1RYfc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:915:bdd7:e08a:7997])
 (user=surenb job=sendgmr) by 2002:a5b:40a:0:b0:e29:9c5:5fcb with SMTP id
 3f1490d57ef6-e290bb22b20mr207938276.4.1728938218676; Mon, 14 Oct 2024
 13:36:58 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:36:45 -0700
In-Reply-To: <20241014203646.1952505-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014203646.1952505-5-surenb@google.com>
Subject: [PATCH v3 4/5] alloc_tag: introduce pgalloc_tag_ref to abstract page
 tag references
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

To simplify later changes to page tag references, introduce new
pgalloc_tag_ref and pgtag_ref_handle types. This allows easy
replacement of page_ext as a storage of page allocation tags.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h          |  25 +++++----
 include/linux/pgalloc_tag.h | 108 ++++++++++++++++++++++++------------
 lib/alloc_tag.c             |   3 +-
 3 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5cd22303fbc0..8efb4a6a1a70 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4180,37 +4180,38 @@ static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new
 		return;
 
 	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
-		union codetag_ref *ref = get_page_tag_ref(folio_page(folio, i));
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
 
-		if (ref) {
+		if (get_page_tag_ref(folio_page(folio, i), &ref, &handle)) {
 			/* Set new reference to point to the original tag */
-			alloc_tag_ref_set(ref, tag);
-			put_page_tag_ref(ref);
+			alloc_tag_ref_set(&ref, tag);
+			update_page_tag_ref(handle, &ref);
+			put_page_tag_ref(handle);
 		}
 	}
 }
 
 static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
 {
+	union pgtag_ref_handle handle;
+	union codetag_ref ref;
 	struct alloc_tag *tag;
-	union codetag_ref *ref;
 
 	tag = pgalloc_tag_get(&old->page);
 	if (!tag)
 		return;
 
-	ref = get_page_tag_ref(&new->page);
-	if (!ref)
+	if (!get_page_tag_ref(&new->page, &ref, &handle))
 		return;
 
 	/* Clear the old ref to the original allocation tag. */
 	clear_page_tag_ref(&old->page);
 	/* Decrement the counters of the tag on get_new_folio. */
-	alloc_tag_sub(ref, folio_nr_pages(new));
-
-	__alloc_tag_ref_set(ref, tag);
-
-	put_page_tag_ref(ref);
+	alloc_tag_sub(&ref, folio_nr_pages(new));
+	__alloc_tag_ref_set(&ref, tag);
+	update_page_tag_ref(handle, &ref);
+	put_page_tag_ref(handle);
 }
 #else /* !CONFIG_MEM_ALLOC_PROFILING */
 static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 59a3deb792a8..bc65710ee1f9 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -9,48 +9,83 @@
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+typedef union codetag_ref	pgalloc_tag_ref;
+
+static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	ref->ct = pgref->ct;
+}
+
+static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	pgref->ct = ref->ct;
+}
+
+union pgtag_ref_handle {
+	pgalloc_tag_ref *pgref;	/* reference in page extension */
+};
+
 #include <linux/page_ext.h>
 
 extern struct page_ext_operations page_alloc_tagging_ops;
 
-static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
+static inline pgalloc_tag_ref *pgref_from_page_ext(struct page_ext *page_ext)
 {
-	return (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
+	return (pgalloc_tag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
 }
 
-static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
+static inline struct page_ext *page_ext_from_pgref(pgalloc_tag_ref *pgref)
 {
-	return (void *)ref - page_alloc_tagging_ops.offset;
+	return (void *)pgref - page_alloc_tagging_ops.offset;
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
-static inline union codetag_ref *get_page_tag_ref(struct page *page)
+static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
+				    union pgtag_ref_handle *handle)
 {
-	if (page) {
-		struct page_ext *page_ext = page_ext_get(page);
+	struct page_ext *page_ext;
+	pgalloc_tag_ref *pgref;
 
-		if (page_ext)
-			return codetag_ref_from_page_ext(page_ext);
-	}
-	return NULL;
+	if (!page)
+		return false;
+
+	page_ext = page_ext_get(page);
+	if (!page_ext)
+		return false;
+
+	pgref = pgref_from_page_ext(page_ext);
+	read_pgref(pgref, ref);
+	handle->pgref = pgref;
+	return true;
+}
+
+static inline void put_page_tag_ref(union pgtag_ref_handle handle)
+{
+	if (WARN_ON(!handle.pgref))
+		return;
+
+	page_ext_put(page_ext_from_pgref(handle.pgref));
 }
 
-static inline void put_page_tag_ref(union codetag_ref *ref)
+static inline void update_page_tag_ref(union pgtag_ref_handle handle,
+				       union codetag_ref *ref)
 {
-	if (WARN_ON(!ref))
+	if (WARN_ON(!handle.pgref || !ref))
 		return;
 
-	page_ext_put(page_ext_from_codetag_ref(ref));
+	write_pgref(handle.pgref, ref);
 }
 
 static inline void clear_page_tag_ref(struct page *page)
 {
 	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
 
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
+		if (get_page_tag_ref(page, &ref, &handle)) {
+			set_codetag_empty(&ref);
+			update_page_tag_ref(handle, &ref);
+			put_page_tag_ref(handle);
 		}
 	}
 }
@@ -59,11 +94,13 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr)
 {
 	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
 
-		if (ref) {
-			alloc_tag_add(ref, task->alloc_tag, PAGE_SIZE * nr);
-			put_page_tag_ref(ref);
+		if (get_page_tag_ref(page, &ref, &handle)) {
+			alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
+			update_page_tag_ref(handle, &ref);
+			put_page_tag_ref(handle);
 		}
 	}
 }
@@ -71,11 +108,13 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 {
 	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
 
-		if (ref) {
-			alloc_tag_sub(ref, PAGE_SIZE * nr);
-			put_page_tag_ref(ref);
+		if (get_page_tag_ref(page, &ref, &handle)) {
+			alloc_tag_sub(&ref, PAGE_SIZE * nr);
+			update_page_tag_ref(handle, &ref);
+			put_page_tag_ref(handle);
 		}
 	}
 }
@@ -85,13 +124,14 @@ static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
 	struct alloc_tag *tag = NULL;
 
 	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		alloc_tag_sub_check(ref);
-		if (ref) {
-			if (ref->ct)
-				tag = ct_to_alloc_tag(ref->ct);
-			put_page_tag_ref(ref);
+		union pgtag_ref_handle handle;
+		union codetag_ref ref;
+
+		if (get_page_tag_ref(page, &ref, &handle)) {
+			alloc_tag_sub_check(&ref);
+			if (ref.ct)
+				tag = ct_to_alloc_tag(ref.ct);
+			put_page_tag_ref(handle);
 		}
 	}
 
@@ -106,8 +146,6 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
-static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
-static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 648f32d52b8d..2ef762acc203 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -5,6 +5,7 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
@@ -474,7 +475,7 @@ static __init void init_page_alloc_tagging(void)
 }
 
 struct page_ext_operations page_alloc_tagging_ops = {
-	.size = sizeof(union codetag_ref),
+	.size = sizeof(pgalloc_tag_ref),
 	.need = need_page_alloc_tagging,
 	.init = init_page_alloc_tagging,
 };
-- 
2.47.0.rc1.288.g06298d1525-goog


