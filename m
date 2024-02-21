Return-Path: <linux-arch+bounces-2611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B00185E79A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 20:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88231C22594
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6A1272AA;
	Wed, 21 Feb 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAuSI3zF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E5126F0B
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544466; cv=none; b=am/qP+15MdO/pRop2sTl63ob0ZjigkueQ49DyDpR09yD8Q/JVBLbB0RlJ76Y/A387yoLSEcQqCrkyKJ7pT51QQsr4Yqb6J1K161t1v/CnEO8gjDO2cVuDvgG2HlhKUCXyFyB9lTpkP3HU146gf7wMae84Xba5JBfpczm4JWmPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544466; c=relaxed/simple;
	bh=0jXC3LDzUrrolAiGzpejaFGts6g9gPbvSne6eR9EGZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DAPLnTykwPLno8oUpY98xUQGrjNW1T4XdMZsf6hKKwMH+nb8h9ja9nOQMzl6kglxP3mqHjlvlKiRVYBqtBcwj63JifwDJbXlk9xxFeWGhk7x+iVBCiNWfberEy+atGdNxRntJ2sM5VyS0CuNVWWCProArVg8pquaxl5S1qYnrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAuSI3zF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607efc8e173so83947747b3.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544463; x=1709149263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=yAuSI3zFtBXJEqtOJqcZ7nFCZUwHdfr+Wu9iAy+CuCFuvUw5k6vUh7m1pSo109/ecX
         eSPLwSRNwaXOqgo30uW6xG4srrJBOp0FJJJ9WQg25TVgBagpMiS06f8PbtRUhpgZfJ+G
         /BENEgZ40l/qfZlXROmPnL3iaMo3Ir8io6yPVmam5fXDzpRaKEV2XWFuOw5c5anxWg4F
         L2iIEHk/SziLOzPkLdx9HL0V/ZcRdUwSWr2v+rTGBLMnGn/wimFfRjzk3cSpVk5LhOHb
         PA9J1utGbhUv15ENpNNyZeGO/9eT+53mAsavVQfxW85P+kvMf8JguBecVxFwrDEEHdth
         E2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544463; x=1709149263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDZXV5wClyo81E7oQNbL7t5gFNRFpKZi8JXsyoMDgnM=;
        b=vjMTld0roSTn+5KTGDXNjmld6rv92lTqJSlW1X54IHvqrjlWGM1W0rO3o4A2vZKQiy
         ZbzorRzeY/e3F54wv6NX+lPMsMvozjoGrRPgY5wSPb+n62LrGOdMJ+B05D1PWXRg8Aq3
         BGtLUTJOwG0BTChZnBGoowknnbvsF+382swms/OpGj85mdqFq/6vAlRdlVFDHEgta1FN
         jS3OmQxJEkxvplkK3HTNYfoEr84sqlnJcQktfd5tvFEXD9g+X2SHKyZiFAw1bnsV7lCz
         k8TseitP52UgAIC7tmMQySS9eQlVbNaWHvsgKlRr6P+uYCl/sr5/NdDNRKGNZVDdyd0L
         kbDA==
X-Forwarded-Encrypted: i=1; AJvYcCVYqiXoE3dhMLo98n3Icsdavk/3oqkNfeu8ELJ7aTzWDH4RoO93Bks32HYzgioFMFm04WhICpxHdYm9sZKeiZoOKGC4DNxrq6n5ug==
X-Gm-Message-State: AOJu0YyWZmZC4R9zD4PLUWuryYJqm66O9/QzMcZE3NJ68u3T6Hsq5hQc
	fRJxekOB9hg+mNd7cTuWwGa2YEI/pOl4+OED8W5hOcHDTj/EXtE0jySee6KXB1WSTnEeuzrw8Ei
	a+g==
X-Google-Smtp-Source: AGHT+IHYTX89gbhdUEyuW7HvamV6v1+4UrLx/voxHAa1LwjOId1uGP/0Vg+lc29zmz5uf9mDtRdIligkWrQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:1008:b0:dc6:d9eb:6422 with SMTP id
 w8-20020a056902100800b00dc6d9eb6422mr17397ybt.10.1708544463028; Wed, 21 Feb
 2024 11:41:03 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:16 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-4-surenb@google.com>
Subject: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.
This is done for performance reasons only.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..d31b03a8d9d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	return !kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.44.0.rc0.258.g7320e95886-goog


