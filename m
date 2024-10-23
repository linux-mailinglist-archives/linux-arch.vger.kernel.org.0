Return-Path: <linux-arch+bounces-8486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543D9AD231
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC21C24200
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3A1D0B8B;
	Wed, 23 Oct 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZQFUqs3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AB1D079C
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703295; cv=none; b=IhHky0l+qyXrF01XO3Rp16Sr4Xb9w2Cs12nEIPDz2uwkr8asfdKqohr5+JOF/l9YZdaIaewYO1SeyebVz+SHHUAB+kRI11SJGlSPhz7i7RRNoESVTDJiXzwV3jK2FVPG0QnIsPCz87dk0qmtxw1npUoDbi8R4/lErbiNnsfItQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703295; c=relaxed/simple;
	bh=iHvlDkaumSmSpNtZFfnLsYSuNLD36+oLYxkaNoBHbvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s04LgqSjDYfETvzYxVUDl7eFkz1ZKAcmqX5CpBSk2uFq+KJuV704hNCVzR8VE63qqTSRTJ1WK7YGhqb9/mYJ0OZJ/AboMUoPWzMXFL2Eipa3Sx2hbdcKr5s0hgZatyaCYkAxpC7flOBX0qTInsjCTUXiO3UEjbQzlKJLbJC9Fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZQFUqs3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso49864276.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703292; x=1730308092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wnMIe1iCPC4H6xxK8PR5xB7BjuNdLAE9wA+yh8Gbwc=;
        b=gZQFUqs3rgaZi54MGRhEGKXQzFBzWq4LwckM9zSJSmUazWS28qFxI7YCwZIxZgp6xj
         YoxNhJq9aLTXpbHu3hu3nsEjxG47LFWrhUzsO8s/I3GJ49z8nYEoZGqgNT9lhew/YJIO
         bUwfk9+XibJmzpulvT30c9LNtz4S8JNSzmD2aObqKTY0iZ6++k8KPs8p2LbGSKnOZLsL
         PmT7gmqWp9EmP61NEVRY9isYF+N5LQn7PK8ekfS7adJICLfn9wzCOHK6E+jgWvVZ1fC2
         hfDSUL+cDdE3yXEVVgj8E0fqQhdilcNUHJuYsLezin8jIRTU3O42eTiVYItZtGZd0X+S
         QPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703292; x=1730308092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wnMIe1iCPC4H6xxK8PR5xB7BjuNdLAE9wA+yh8Gbwc=;
        b=Ej+MpiaPZnvFxfsAIsZMPI4LHq8D3I7HrumZv23Ns9vMjqteb87dQEeAAFoBZB5Jl3
         9oo9XgFJlX32RGKGghoSWrIeERA9V4fOdjmmh29D+qTFduy1dBhVB3YVzIinnckI+sAM
         TUheLCQIKoQB4iBqXpIc26Wt7YdToPFW2mHfJaxrm3L/ZlDiUBFNlAwELglsyx0adylE
         qEQa2h0g3N7qSDF5susIVtwVuZ2E8lB4XKgWOAmf2SQ6STPO/lMbz5gQxNGela0jSTYQ
         AhtdrFWR9s0pJdMHQFPHP6rgHlNrTPRL6O/B0d5vn/7By2tksz/q0HizaIQ3pgEzr6ip
         Tz5w==
X-Forwarded-Encrypted: i=1; AJvYcCVSSKopoTGaFymPBlOkIAmT7nsrIymoiG0noG+Di1rAVQy/FmfmKwkBBM6KvhOd/TheU+4hc+pezfKn@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8weKJgY4ICdzkmsI5jdT4DzT+sMnUx+nc3GcKg7/z1E3/oKC
	eFTmCvpGtbsemAJOx5DHb4IVLOo9yUd9wDZqoSm7Jf7akDvHau1Huc5BwwlsKOaYWGCcIUvU9Uj
	UnA==
X-Google-Smtp-Source: AGHT+IHWTSefrY2mOEgvtjZrHcKSjJbm4CbIxnZltjP19nac0+xcMzP1s41Uk58cU65/uvtLl+YlVZeSEX4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a5b:70b:0:b0:e28:e4a7:3206 with SMTP id
 3f1490d57ef6-e2e3a6d62a7mr4485276.8.1729703291999; Wed, 23 Oct 2024 10:08:11
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:58 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-6-surenb@google.com>
Subject: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to abstract page
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
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

To simplify later changes to page tag references, introduce new
pgtag_ref_handle type. This allows easy replacement of page_ext
as a storage of page allocation tags.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h          | 25 +++++-----
 include/linux/pgalloc_tag.h | 92 ++++++++++++++++++++++---------------
 2 files changed, 67 insertions(+), 50 deletions(-)

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
index 59a3deb792a8..b13cd3313a88 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -11,46 +11,59 @@
 
 #include <linux/page_ext.h>
 
+union pgtag_ref_handle {
+	union codetag_ref *ref;	/* reference in page extension */
+};
+
 extern struct page_ext_operations page_alloc_tagging_ops;
 
-static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
+/* Should be called only if mem_alloc_profiling_enabled() */
+static inline bool get_page_tag_ref(struct page *page, union codetag_ref *ref,
+				    union pgtag_ref_handle *handle)
 {
-	return (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
-}
+	struct page_ext *page_ext;
+	union codetag_ref *tmp;
 
-static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
-{
-	return (void *)ref - page_alloc_tagging_ops.offset;
+	if (!page)
+		return false;
+
+	page_ext = page_ext_get(page);
+	if (!page_ext)
+		return false;
+
+	tmp = (union codetag_ref *)page_ext_data(page_ext, &page_alloc_tagging_ops);
+	ref->ct = tmp->ct;
+	handle->ref = tmp;
+	return true;
 }
 
-/* Should be called only if mem_alloc_profiling_enabled() */
-static inline union codetag_ref *get_page_tag_ref(struct page *page)
+static inline void put_page_tag_ref(union pgtag_ref_handle handle)
 {
-	if (page) {
-		struct page_ext *page_ext = page_ext_get(page);
+	if (WARN_ON(!handle.ref))
+		return;
 
-		if (page_ext)
-			return codetag_ref_from_page_ext(page_ext);
-	}
-	return NULL;
+	page_ext_put((void *)handle.ref - page_alloc_tagging_ops.offset);
 }
 
-static inline void put_page_tag_ref(union codetag_ref *ref)
+static inline void update_page_tag_ref(union pgtag_ref_handle handle,
+				       union codetag_ref *ref)
 {
-	if (WARN_ON(!ref))
+	if (WARN_ON(!handle.ref || !ref))
 		return;
 
-	page_ext_put(page_ext_from_codetag_ref(ref));
+	handle.ref->ct = ref->ct;
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
@@ -59,11 +72,13 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
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
@@ -71,11 +86,13 @@ static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
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
@@ -85,13 +102,14 @@ static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
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
 
@@ -106,8 +124,6 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
-static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
-static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
-- 
2.47.0.105.g07ac214952-goog


