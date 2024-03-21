Return-Path: <linux-arch+bounces-3073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E1B885E45
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F40528178F
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B713A86E;
	Thu, 21 Mar 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOTqi4yy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577113A243
	for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039078; cv=none; b=PvJqjtJyhkd8HT0gQRgjl4dX1aWIgT0MWS7x6vcoeg3ar19Emf0+OWzYQseYXJqXl6y2bT0xKpbtXm/rDtO4rc4TNn3o4tycoGyyn37D3G38CC2ykLnQEWY1oFiWEzwXQYjar0A5bL47gxPe93oLKsba3BSV1AM8ELgA/AUPsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039078; c=relaxed/simple;
	bh=45odmARV+wc28Eekx3IQDiinIolT4AjrR5ZRCYWG43k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hto0ch3927tfnrSE6Jsy5OBhzWEKuLvkdn9ECpDgsxvfih7qkNaCNQTWDWwG5w92+OnO8o37Bk7hSITvo84nogUFTWcuiEbBTEfFJGTtxehwLufd0S+PeT6zFM4f3VYxwW/7/PpPgNO9ghpO7tQ8JRjBPWQ/TvmshuCE9FsiXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOTqi4yy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ab69a9e6fso28863607b3.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039075; x=1711643875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0NoLpdPXZUI9jv+GBaFWeUdE0u/LS8GwKny2YwhxYE=;
        b=cOTqi4yylo1zItYupYq6hXU2zieV6q3fZ3ea2brMbILJ2SctQRXF+CwEZ5+vdnJMR4
         bbh7kYFQRPRQe7HzVkQrX7kqcmM99+OnbjERN9ySp9XhC3x9LIjgATXEeZCHwda33nyc
         b+K75gh8TGW6jjZRjZYsaaL4hID16biGpNyI9JWyVeYUdwjFg9fH6XW+V9sV7UORqy4K
         wPKWMIODTWcjBT6TYBQJGwIwX+20H83N9U9PqpAPmtbAvkpUuzW1O/wTEhlDl900CetJ
         28zihKo/PGXBUSFNRN/K+4cFg87QOFfyhA3qjc3Yq4QN/3thsbUz1rEa5HxMvRvfzXPZ
         Ma1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039075; x=1711643875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0NoLpdPXZUI9jv+GBaFWeUdE0u/LS8GwKny2YwhxYE=;
        b=fBDIBWnHGLHwcnh5A5HnByhonN9AG6AmMcXDVp07qTFKai1dbtdQ6mdNgEZm6eOCjy
         eX7FVp9sUB2/U3DBecIJT3RP6jk7WRjK2X8zsEH74eD7hhIgKZjfGGr6nGnPeQq1NGlb
         bvgxwUY4CxJa9tCyaniNOZbpHCIm+zpC6+a/0v9XygfBPBP3RNXcpEgTcfFDRrd4BU0A
         lsOlulv6s7VP2ZL//Ec6heNvsn+LBlyM5yhEnqdBlUytBxzQPgqtXkNv3+wFgAxSTefp
         eNRFwP5xr2VpleTGVDTWtq+Ezdzs4JQD79SZME3LNDWg6r6FzMPYADNcaMIHspwUH0lB
         Ib6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE76DLdVGSxdAlGweuKg1AIRCHP+5G75ohjljcPgIx370fO4n6C4Y+Y43mBWaUfVWUnFLB6gAks9P9iu1PctaVYj89SNt9oBtajQ==
X-Gm-Message-State: AOJu0YxLqmc7KmuYEZ5O4BjMQzObfGaQNf8qEKcwuFcutrkMEzjzPY8E
	ewMTOqfncW0WjPwX2P0gugXbbIy8WtRcuDXPhYS7kSydwB9YuPQMSr94/FKO0HgN70xYdJwYbFZ
	bew==
X-Google-Smtp-Source: AGHT+IEretF+q2ZgfU/nK2U7IsM8qgxzJOcM6j0PHFTxTRvud7ewavgn/Hqbg7folhUnncWwNi0CsjWDS2Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a25:ce51:0:b0:dc7:4ca0:cbf0 with SMTP id
 x78-20020a25ce51000000b00dc74ca0cbf0mr607569ybe.3.1711039075564; Thu, 21 Mar
 2024 09:37:55 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:43 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-22-surenb@google.com>
Subject: [PATCH v6 21/37] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3c58fe8a24df..e7d8f1a5589e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -95,7 +95,16 @@ unsigned long page_ext_size;
 
 static unsigned long total_usage;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.44.0.291.gc1ea87d7ee-goog


