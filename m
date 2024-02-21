Return-Path: <linux-arch+bounces-2613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B385E7AC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 20:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EECD1F21C4A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065C12883A;
	Wed, 21 Feb 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byge+aaK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741ED128369
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544470; cv=none; b=R7Lwuee8GxqAy+gRubUsdUtunhYGLpLkcuAXQuZkWBCANi5mPxqaNefIq7BbMgViJ2xdJqiCQ5QvOeVg4KHGLdfXoDQl0pg17dzpYun0s91YO3A9V0k6Q5XWU3Z2ATc24xmpUARomOXfnvfCyB7ZizQHwRrYsqRiAisjmBVlITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544470; c=relaxed/simple;
	bh=Z0uieU1Hw2qDymgn+R30jj728IuRbiBIVd6A3QTsoEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXf1CZBe7U49o3+/7ve+tcQObkxReQ2ibv+4MeiuqB7Ma4klPeYzxTtGrLeDm/atjxxuWIRjdWyqcpcwjWvMDGjnpG/2fJ3U/G86mfJ7TMbFExDGFv3mvXZemhBLulCRCrsQ7pGrlp/JFp4nXtW5kK+sKlrd2Aoh9pRIQh2r6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byge+aaK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6082ad43ca1so60767867b3.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544467; x=1709149267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=byge+aaKKirc/1HtrNjKyqcEh1JvgEDAfzILDPbokj0bGNmdMzHMyliJoEP6JRJ+qk
         bhGiYyCwGhDZTEOKGxj+ABhC9mVdMWWHv6GtmMuN7ybSvKpU8Mc2FfbA9zcdorlH0cUO
         /L6GVNl9T1n0I9asPP9NvNY5yWPUtwerWFneQlK/tLXWQ0Uj0Y7AxBagPMg6rZywoPSr
         DjvV3RRrSoPKkW9TkKqtxhnHY/39vU560lNYeMS9SS340Xh+dtqnHhO3nGEnyfghptt7
         l4vhmHvMk3ulYJQO++e6PAVqPtel0Zx0cTfWBxhcj+Ilqp8YAQYPCxDi8/df4KQ+bWLa
         +R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544467; x=1709149267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=tnpbGFxxgG7iXzaVTxpEzTrrLfSB+z7zC4QXoSabENqRzUiX9k48+rF1blL7AocYdu
         LwsUGXt7JZEbI9L/hVPsiIogucFT8dL1Z/xGJU1ZaRH7sQGJNPJIfau7tYTsQBbMRY5j
         cWRxJdPv9FuyIMDAdAfqODte89bNt1jYaROqexwEJQtCFpzLEOmFJ9tElT4T0cuWiIZh
         dPo2jm4EiuprdKvbXusHL0N6x/SQkaTJsxS+2J7ETdGXXxtjqAqlvEee52zIVZyiP7wm
         qB2qEqTnK5bnZASceAtdbi1kzMsRUU+Un2JVNVyNelV1IDgR68PO/5ZiIgSgBgjjHPP0
         8XdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZCkGMagm8Fg5yWdUCqZmTARmJC6vNkzFbAzvhmjkP89TOAXYLiNb+OkeTKoTgpHNBvWd92Groegff2TU6UNM7Bi9HrkUhxUj9DA==
X-Gm-Message-State: AOJu0YzoTIftckLgM3TVKyBzre+D1GSDFrwFYe6k6fBjydE452Ha7XGq
	fXfEcU8x5B2EZffbLTxvzAFK9KyykdccytUhi/DS6ZKjhVIqwJzrvX0lYsPA49mOhSXTUw3g5OH
	nRQ==
X-Google-Smtp-Source: AGHT+IEg8J3/Tgw3rQ0HmvocmCN1KEaF26PclNShE/JXdkinKLyGnMcr7oBUIgKaZkEgV9b6wmo43w0h+Rc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:4c2:b0:dcc:4785:b51e with SMTP id
 v2-20020a05690204c200b00dcc4785b51emr10314ybs.12.1708544467498; Wed, 21 Feb
 2024 11:41:07 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:18 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-6-surenb@google.com>
Subject: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f37c60709..08d8246399c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.44.0.rc0.258.g7320e95886-goog


