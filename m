Return-Path: <linux-arch+bounces-2849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE251873EC3
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6951F22E2C
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05DE143727;
	Wed,  6 Mar 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6Csgq/G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E214374C
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749504; cv=none; b=UwcbPxfkEVz2HrmtaPhIBmmMd8HDggCOe1rwMrXkMoOEw3fLUA0ZbofhWWTO36Z9jKv2b3GabOoAKla/dm4gv/8UasiFNtcSeNXGJ/YesXzNQdTn5s0ufRPN5XBidvqhLnRpHxNXaAM5BTBL6jlBitHEseQwLuabtwuVFlSdjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749504; c=relaxed/simple;
	bh=R2DVckge80A2ruR232rDSrP7/GV74FogObtaXjKjFt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uGiBxNyx/aJ6XXonGtYdeTh9nYnUptfS8d/N8fm1spt+ajysjJZRoYRdJ4C9DBBaVEVU8RpfII68PasHeHcvsS7TFlPc08GVBa0AN4PAAPzQDn5evghdJamGl/neeK8vE0ALTfQEVXf2Fh66pg8cxX5vFpIaUU5RC82p4nUZJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6Csgq/G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so2058362276.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749500; x=1710354300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=z6Csgq/GpdiAe/2EPMOGSkC2HPAWpdm6wsmaT0tXTRd1oqJ1m+W2JXkygqBzBcF8WM
         WtLuFAkHn6wjeSqx+vHHHzX9YJus/kVLjMfFZ5uMGWDRAG8BlsbKVphRki6kXGTA7b/2
         Jn4G11pkF0ohN30bWz/KRrLyu4oeU329e/8QN9wuANcX5Q8seA4QvANEnVL7KR072tcp
         o2uNxsBhwPM6ACBSZ8Vb7AIhQl8h83raKw/3BfZRGDloTI394CE91N5fWgiUW7xSUkBw
         EbOj0f4H0BUf7T5MM73iceYQEPqAhCchgBVSM8oX/gDAFmtMKJ/F6IwqHjU1jJ+09erO
         R5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749500; x=1710354300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=cX/T9D5j4hXLfXubxrSXZdzPoM4ti6n4g+nKh/s5G2fuED74mdHoUNDUcBpPEMQsG4
         9Zc33TMfB+ijRO5KBGEzIwUPhlp01v4++Sa39p5qPLmPgNVzPQrtEPMDrndF3U7UuJnY
         D1q83QVI3kRNx5pji9eJaf6i2W/2peIxv5YVCK9VnFp+AMLB/OUTZSd5lxo2iAtf88pV
         ZIfEtAOtEH94uJMn2SZ3H5P7/JwvuvHXNKTgXYNzwV07+x/mhA85BUOU0MmOpNio1APB
         JI8HIcOlHDpsdkjIxr5mI15BJLLf6UF4sUNAOhDmsoNm2ENsgYmXP3264Y0I1O/S0xG5
         uceA==
X-Forwarded-Encrypted: i=1; AJvYcCXGsJAgBc4OUjUXZRlvZxqNy2QdTml+BpQWDdSR8Fr71KmlgrorC+CCX9i/MKgJ+4MxvfBDaI1+qTad67ES2/NF3OaBcEv3jNe7og==
X-Gm-Message-State: AOJu0Yx+RNEemHRC9ys9oRc8ql0AYggnfX0za2ZyD97HenHeRlQSUYpx
	uEE0ygc+nI0lqVZb+r5hyPXAk/RKV7YtdPT3engFCdZGDXDSFWKTCvgAYqczdjxMSJ2MbKn/TuC
	Yig==
X-Google-Smtp-Source: AGHT+IHxR0olBWteUpSeEtMuXDZWp8I1meqV0Icf5ps5DXZSQPpSTLoMw3+arJQFndTmnzLC9JieP9mTFwI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP id
 cj5-20020a056902188500b00dc6207ee8b1mr3919663ybb.2.1709749499865; Wed, 06 Mar
 2024 10:24:59 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:05 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-8-surenb@google.com>
Subject: [PATCH v5 07/37] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp_types.h | 11 +++++++++++
 mm/slub.c                 |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/mm/slub.c b/mm/slub.c
index 6ab9f8f38ac5..2ba5d7b2711d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1899,6 +1899,8 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.278.ge034bb2e1d-goog


