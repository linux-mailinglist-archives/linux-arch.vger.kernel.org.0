Return-Path: <linux-arch+bounces-2857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF42873EF4
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0534D286FBC
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12131487CE;
	Wed,  6 Mar 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zbliseqw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553413EFEE
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749520; cv=none; b=BS4+Y/VYsflrLRP42RtTEYoNFjsmEKIyRGs6Ze8Np/fJnLj3NG49hEQq+2zsBjhm0k20FmHF0P4xQxT8iJad4O6E6A9ZGrIKAmUO4rPCAw4d69qA4HZaO2T1XtB1Bc9HRq8u+umjOGZk+OE9tycWavdyJgIrzTrkuYfegcRBCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749520; c=relaxed/simple;
	bh=Dv0eI32ABhCg/c3ioBN2YUnGdkO8o8M10k34MMBgAyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MExvuqk5jiIsSZKUNdDJXH5c+7EgWKDC4NMM9EvKW5gaCYqBcK5QwUpmXnMIlM10r9hb9gEJwQxUdOxxeEeIggheXGO8uPRKUj8gSIh7ieWNFYB8xAgueYOef4EIvWsGVqI0jdRN2VVt7Yn9a12jfYVUUGpjsI2D3UZBVq6x2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zbliseqw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so13299397276.1
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749517; x=1710354317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=ZbliseqwaEa+vFlbwJFZ4qt5t9Pd2WQg3OKci0yjhtfGWEz9MYfNtDl3cWYuBnOVGJ
         MvLDfFb393YjCeEYwxcLWQhScVKFjrSG0YvY8jxk4Kx7tdtNziFGdAptuDnQFh4lXH7p
         OIgm789hYKJANxzsAfpPalLO/BanSQ/Vw3tpJjMoA9oF5niM6oEkXyipv4k9TsP3sWga
         b7CoAxBU3vW1oXrx9n7EehWALeBythb4o4IQ4DubRo969NG0rY2QpvtvTyZxwG4XIRr0
         Zx9yF0X89RAfuB6Wjz/gMr63PcUn/Y8w9w/nN771Cd/wfj5eS3Oa0wdFBcsMvBNcgKFC
         ytpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749517; x=1710354317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=Bz0B4qQKv9DSI1DeMMYOaTCMBgPwrtknHAYCvrew/6YiAVyjY2yCPMWMb+XgfSLsNL
         XoBsJGL7rk+xnIoaFLIPMsW6lEIGHjs8d0FNn5//GRGLBLYQ03vaRLOK65iUNK1dbElt
         tuaI0bMrxtgcIeh27JCTQJatBxfv4NaB1f3ZDibmnAQKS4suxqC3F8/68NrPtQ0xWHyl
         YlhZ+eLktexl8aFPC0WfRaSnfMC8AtQgoTkx8G/paHbrqhmEwi+3BR+DH54omrEg8z3Y
         Pez6+IQpbZenT2wmGBzLxngy+A0ze2/9i+BbSjDb0OaT5JKTyhuTIGwPdAh770wgAawN
         ZOdA==
X-Forwarded-Encrypted: i=1; AJvYcCUFiqWwdbP3B1q/7m42AgWnLoH8KBhu8W8B2o8CuXYoxFbPNp7HUEnKVj6TwPlk9A0gZgBRQRBLAgzpfjcS/byygkb0pdWiuUEFRw==
X-Gm-Message-State: AOJu0YwoYHqBr1UjcxvWySwVpokncNAQtz4JBXWUVghMsZTeEp8OOxSa
	1zN78kxeFRm/7hLAbLZ8/5Z3c1CQlIgYLryNIw6suQLi8MZUYphRoLmU0pcJeC1dCyv7RgNWk/A
	wFA==
X-Google-Smtp-Source: AGHT+IEY0dq37W/YL8K/UAYJglAS6s8iwOM7lJC17R20EwJUoGE14Vwyo3M1UA8Agcy0JGlj8awomXhRYvE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:18c9:b0:dcd:5e5d:458b with SMTP id
 ck9-20020a05690218c900b00dcd5e5d458bmr4001383ybb.3.1709749516858; Wed, 06 Mar
 2024 10:25:16 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:13 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-16-surenb@google.com>
Subject: [PATCH v5 15/37] lib: introduce early boot parameter to avoid
 page_ext memory overhead
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

The highest memory overhead from memory allocation profiling comes from
page_ext objects. This overhead exists even if the feature is disabled
but compiled-in. To avoid it, introduce an early boot parameter that
prevents page_ext object creation. The new boot parameter is a tri-state
with possible values of 0|1|never. When it is set to "never" the
memory allocation profiling support is disabled, and overhead is minimized
(currently no page_ext objects are allocated, in the future more overhead
might be eliminated). As a result we also lose ability to enable memory
allocation profiling at runtime (because there is no space to store
alloctag references). Runtime sysctrl becomes read-only if the early boot
parameter was set to "never". Note that the default value of this boot
parameter depends on the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
configuration. When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n
the boot parameter is set to "never", therefore eliminating any overhead.
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y results in boot parameter
being set to 1 (enabled). This allows distributions to avoid any overhead
by setting CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n config and
with no changes to the kernel command line.
We reuse sysctl.vm.mem_profiling boot parameter name in order to avoid
introducing yet another control. This change turns it into a tri-state
early boot parameter.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index cb5adec4b2e2..617c2fbb6673 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -116,9 +116,46 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+static bool mem_profiling_support __meminitdata = true;
+#else
+static bool mem_profiling_support __meminitdata;
+#endif
+
+static int __init setup_early_mem_profiling(char *str)
+{
+	bool enable;
+
+	if (!str || !str[0])
+		return -EINVAL;
+
+	if (!strncmp(str, "never", 5)) {
+		enable = false;
+		mem_profiling_support = false;
+	} else {
+		int res;
+
+		res = kstrtobool(str, &enable);
+		if (res)
+			return res;
+
+		mem_profiling_support = true;
+	}
+
+	if (enable != static_key_enabled(&mem_alloc_profiling_key)) {
+		if (enable)
+			static_branch_enable(&mem_alloc_profiling_key);
+		else
+			static_branch_disable(&mem_alloc_profiling_key);
+	}
+
+	return 0;
+}
+early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
+
 static __init bool need_page_alloc_tagging(void)
 {
-	return true;
+	return mem_profiling_support;
 }
 
 static __init void init_page_alloc_tagging(void)
@@ -158,6 +195,8 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR_OR_NULL(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
+	if (!mem_profiling_support)
+		memory_allocation_profiling_sysctls[0].mode = 0444;
 	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
 	procfs_init();
 
-- 
2.44.0.278.ge034bb2e1d-goog


