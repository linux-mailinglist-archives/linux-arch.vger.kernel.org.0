Return-Path: <linux-arch+bounces-3055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90454885DD7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15711C21DB1
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDD133406;
	Thu, 21 Mar 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWAs86Pz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5713173C
	for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039041; cv=none; b=PBcGjTaQw5bfxtbJhpex07imIMtutapFLANtApl8Eyk9+DEmTKvrH0Qon0p83GC6bedMnGJ3jfw72bUSw9GIx5urLfFMDBid15gViZ2gBCGYezDz5Of0lxWuKjjy9lK65dkY9RxoAurBEEKKMOPfyhRlxRjnZATA5Qyj3QGcHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039041; c=relaxed/simple;
	bh=HDNKqGkk/azPcTtEhJHN+gpMAx3GoPDUVnE3EYb5Lwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zw8FwtRn5bD/tozEQ1LR4j/Nj46mfcX835cXGwFa2EAF0qO89C6p+jOsLFfKcS9+IMdzU4liMJWjikgD9JejwSGEqER3InaCWBU7C4itvuJmiMgqg9WyTBhyuem5JoxlXisnHfSuXiM9QdvspA0Qg13hWT625ZTA79i1ibzQwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWAs86Pz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a54004e9fso21446177b3.3
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039037; x=1711643837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=wWAs86Pzoa7/o4uO9DUaKalp5/lqsafBptAizETSwrwxG543E6aMELKTNZSJkOAIe0
         bRt0Sx5bIrvo0fEeZIMOi/WnS3w8QvJt+cukgQ97dy2sUMu/2XvrkrSPB3wxcsHWECwJ
         gXSz591epccQDT13TSfHCWEmVtILtlUzWaK6lofLdZtFD76e6xRP7kFw62KtCG/PeU3h
         vCzqp4N2MCFbRN6fJ/OGzaUN0Z+fXQRfoKah+oG2oqXKYQLTWQzgy3lkLXpiFckDQa+N
         mwKOtfm5DRQgGMMMcGfaLNoBA9YRBfqKZZyBJ0++lPTsszo1wJOPkxqU9dNzI9czQynf
         t+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039037; x=1711643837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKfaiB6dOVHxpZUYVy57amQHTHiIgtHPVa28h/bxKY=;
        b=uHB0qz7gzI0UGy9Sy4eb8PYClqbwyn5S0k9QF0spNq/sjznusNsPFSAF3nNKLV26yh
         MpJDC4/NTXSNxFc73+0Y0C62yZgGR/FgU/Cy7YO3QB8ERDpmxwBD+0CyZkpjHotSxm1v
         G+JTSdE22gOORcbI7LIpXfnW0xSZQNqr49z+rNF+d1HVfB4xMRBLMpYCcpZj+Hq5EVzS
         QhuGee/FH/FS6/GnFsHg3YJ0eQ8OmSJedYFiAJVBo0LYndgwQ5AaEHQ3nV1o+Pe/pyLl
         Zu8rV/lgu/k8SwJEhaEd7i3azs68B9+ASHWtGo5evMVovQTBcAIyKCdNf+MKHt4QAmOX
         4jZw==
X-Forwarded-Encrypted: i=1; AJvYcCWL4JmnAHVpBT2YrS6p4c10EQti0yNv20hCLA9r272cW/aovkIKl1uB9jqNia4o/V2X8yl7XK1LZq1cEXdhoAF/XQoAqJXl7pbIuQ==
X-Gm-Message-State: AOJu0YyY4Gfb0NV3oceMDrhBAk1bVpbAySVEUXOGsXplYqlsAHk9BqZD
	K97dFiPxDJ1L19dw5hcPgioKXWdKUxLZ7FCS786jM/yXro72K0gG/8wXm2N7aJxvQXTTIgfc77a
	IKQ==
X-Google-Smtp-Source: AGHT+IFYgw5ohbM2qs9qWLSKEHVv/3K2+6lhzKzCxOpGXwJ9EG3Fd8M+K30yKZwcBlNXdCTg4+rc5Suy1A8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:f88:b0:610:f11e:9d24 with SMTP id
 df8-20020a05690c0f8800b00610f11e9d24mr1686171ywb.4.1711039036599; Thu, 21 Mar
 2024 09:37:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:25 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-4-surenb@google.com>
Subject: [PATCH v6 03/37] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..bc9f40889834 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2106,9 +2106,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-					   void **head, void **tail,
-					   int *cnt)
+static __fastpath_inline
+bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
+			     int *cnt)
 {
 
 	void *object;
-- 
2.44.0.291.gc1ea87d7ee-goog


