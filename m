Return-Path: <linux-arch+bounces-6329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9D956E6F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9D282724
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117C3CF74;
	Mon, 19 Aug 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbkwS2QI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5F39851
	for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080521; cv=none; b=XNAIP79cU8TcM7zu2hXs36eki2FVdh8V5BIstWF15vYUk1JY4/jfouES++zwcE9w25ViMMtldKxFkR8fO/OAcAhBZeegq4/q1p64B5Ji8ZXIw8qjA8fn6hlxTP1VhZT0am41thYZkFQJEcXVmetLM+cFLLdiNuzqiyqL00kLJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080521; c=relaxed/simple;
	bh=QNtt7nrudv1sg5/MkXuYHkfQoV0QFVSTo3l1TW67kZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=czHHnKvW3UwXTdDWxYiF9qbBjMGffRB5PhK/msLkS26sjOxfdF/W1QudjozfI3x1+Bj6yOq2h9y3qJG8Ua0H+lcHeoKBdGNzecnht1yktiC7dpx05Smn25/D0JLoNVCrLHq0f0hs2BG15r87vZfxgvSEH/Iv68D5Vte971dSfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbkwS2QI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b052c5939cso38877427b3.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080519; x=1724685319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNxQmk8ltcvVRdy69Ay4z75/w4T2K+JdAEqULautUD8=;
        b=gbkwS2QIYAkkgho/K3KLMPU3GDoh/vN5KwMbDVyNZaxvIn0iPQiHX+rfy1Y0OlbW0j
         jtAcJ8WlTMiLfx/ZxAdl+f+z2AhtkO9LQbqzYiHcRGagS78yme0A6iHBbj2azUhHzstW
         y2qfAbU8Ik2BP3huTxKc1DNXVF9KNKfC4pfUtebxL0CG0GwJbCcNVjfOy9aa+TNGv8bg
         v/uZe+koizstmjiXkzJIbU2x3j8KOCiPji3BHVk3VLdafke9HJJP6IDWrYp4Fc/vGkoi
         z0xN83bWNynPCoE6gpJvmR+OZVF7XHgmntpRYLWxX0k/34/kRlrzTGJ70SIumCiJn5J9
         faoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080519; x=1724685319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNxQmk8ltcvVRdy69Ay4z75/w4T2K+JdAEqULautUD8=;
        b=j4ZZ7qPrSKAy/dAjVxNHDgVyPw2s7+N+cPLE9wA6V30bNMP0rbW5GLLBtlWj8QB9Xj
         e693f/iBOx7VxrFTFA+6er1cug+nWnwv1sl41hFNuGj/o25eruOrM5EwDOD7eCjGZa5P
         d/DVocwxh6hbBD79TgmcpndFfj+71XlGaSpfu3RmwPv91BA4Kzub3pS0pfXtRBoxBiJM
         TIOY11/NZsQTHi8UtDVNkJhVPJMPk6YczaSbP0aCxXrhaQfSjf7n+pszk4VBXoWy6Wu5
         PygyZ/vrT43zIctavJTjCjxh4fLPOME/FlvQpXgYP718TcH4vxQPTT8b7HmSPKhKYM5a
         itfg==
X-Forwarded-Encrypted: i=1; AJvYcCXb3Y8pY6mzcZ+FJsMlnToM+JBbDTxr37jdX0mx3SPoFYLOwq8zV2QlkTk6GPVXFXUrRHp4B8hfkNYb@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmDwxNzBGFZ5tLSlLhNWLAic+Z4reZtUfbpRf0bxSwmxhu3i0
	P0bguxX0Rd4xzhxzOajZMclO90mAVkaSRmR+spqX5RhWVBzz4lvUg+GDiWCIZ4CDHGJnnec/az2
	0kw==
X-Google-Smtp-Source: AGHT+IFc3XJvlFR9abCJBzx6LfnqtUZrq0wbNXmeGLgIyv9XIwJOTdcKULoLpjDTZrzYGsBBSDXaDMNiqLo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5aea:cf26:50f4:76db])
 (user=surenb job=sendgmr) by 2002:a05:690c:b8e:b0:648:2f1d:1329 with SMTP id
 00721157ae682-6b1d38cac51mr8818697b3.1.1724080518814; Mon, 19 Aug 2024
 08:15:18 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:15:08 -0700
In-Reply-To: <20240819151512.2363698-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819151512.2363698-3-surenb@google.com>
Subject: [PATCH 2/5] alloc_tag: eliminate alloc_tag_ref_set
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

To simplify further refactoring, open-code the only two callers
of alloc_tag_ref_set().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 25 ++-----------------------
 include/linux/pgalloc_tag.h | 12 +++++++++++-
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 99cbc7f086ad..21e3098220e3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -143,36 +143,15 @@ static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag
 static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
 #endif
 
-/* Caller should verify both ref and tag to be valid */
-static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
-{
-	ref->ct = &tag->ct;
-	/*
-	 * We need in increment the call counter every time we have a new
-	 * allocation or when we split a large allocation into smaller ones.
-	 * Each new reference for every sub-allocation needs to increment call
-	 * counter because when we free each part the counter will be decremented.
-	 */
-	this_cpu_inc(tag->counters->calls);
-}
-
-static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
-{
-	alloc_tag_add_check(ref, tag);
-	if (!ref || !tag)
-		return;
-
-	__alloc_tag_ref_set(ref, tag);
-}
-
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
 	alloc_tag_add_check(ref, tag);
 	if (!ref || !tag)
 		return;
 
-	__alloc_tag_ref_set(ref, tag);
+	ref->ct = &tag->ct;
 	this_cpu_add(tag->counters->bytes, bytes);
+	this_cpu_inc(tag->counters->calls);
 }
 
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 207f0c83c8e9..244a328dff62 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -103,7 +103,17 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 	page_ext = page_ext_next(page_ext);
 	for (i = 1; i < nr; i++) {
 		/* Set new reference to point to the original tag */
-		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
+		ref = codetag_ref_from_page_ext(page_ext);
+		alloc_tag_add_check(ref, tag);
+		if (ref) {
+			ref->ct = &tag->ct;
+			/*
+			 * We need in increment the call counter every time we split a
+			 * large allocation into smaller ones because when we free each
+			 * part the counter will be decremented.
+			 */
+			this_cpu_inc(tag->counters->calls);
+		}
 		page_ext = page_ext_next(page_ext);
 	}
 out:
-- 
2.46.0.184.g6999bdac58-goog


