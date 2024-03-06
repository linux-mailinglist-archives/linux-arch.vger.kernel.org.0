Return-Path: <linux-arch+bounces-2879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5F873FA7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC6428715B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE341534FB;
	Wed,  6 Mar 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/UMJVvP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28024152DE2
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749567; cv=none; b=k4qc12FnY9UtRQJzPMGQFv9TaXXp4BmQB1i4U5x/YaF1zIMTUpE+l9/0XP4Z9hsakmKOi+3muWNvMMv+9lB+HizaVthoSDguad8WpYX12BiL04Uugh/f3flY56QBEWbbwZwQkpub8bVmWBE/LOeSiO0DQMGJd8bWE4YbWYWxyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749567; c=relaxed/simple;
	bh=WZ9Wfhph9SqMvpwjpOilQz7uq5chx2Sd29yINS9foKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XMuzQaXS8iu/pbqzDeM4C0fbfAv3DT/W3lDFEeuIPygdPedF9BWdF9jY4HC/MJBMVJ45F8amDl6exvTpjk87a5veYQ82r6jqSSLF7AVbaMVxzGd7EEF9uhBaDMFhYh8WP1vWzPsjOeZrMh5QJ2s0fy0u4VXaJN7nUNYZy7A5/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/UMJVvP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so8287228276.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749564; x=1710354364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGhey761h+yk0goaaYaIkNpiVVUjQ3rocN1HojLD7sY=;
        b=D/UMJVvP9HSPPg/+UMFUn2uZmSu2zF9hVOmrJ8EDa6yA8umDSMaFwniCa11IGfob6+
         pPTYXHkvmUQZ7h5CbcIAv6z5Jc6pNpACFiOM0RanoRglnxOK2Us+/8PdMVd7VNPGpn5R
         gEWA/O7R6ylKAL9OWCKGt56aPulT1OItTwVIqjTMjP9+CPPayXSqheN4JJYkAlh+YWpf
         YWjsqWfjx5qQ3iirKrDcIsg76y44ErK7ViJMUMtFnB9PCUMx8lXIA1e+0+sCnVZW+Pdv
         ZLCNBRifYQXpn7hbpYkEIZJjuiSaHX54snkLPAT8zxkbs7l/Bvf1uPpdw74AvHsWkS3N
         vK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749564; x=1710354364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGhey761h+yk0goaaYaIkNpiVVUjQ3rocN1HojLD7sY=;
        b=OKp207fHGliZijfCDpFqHfPP1WV00mP5a3bhA+yF+n9O9OwkWSDsdhxoK/wvpIIF0t
         Xag/ARzGC5Gk8k5SHyfuY5HS/tAWnKDDACcyf65qNYB7U7FoneAvEwsUx5Ub6A47ru3S
         dK6+AMT/3TKlwBa6tdTRmvXhbbl1Gvqun3NqAm3Rph212hh5bBHZS55OhhucxW4fClE0
         56RHQz4HM7Md4P07qEmKXDT9dQ2l8IbJZlx61Ge+DJxtCG/2sqjsvGK9P7M01CvKcB8J
         XvNx1jHzWCLCGThU9VkSkJ241Vx+OKJc9WVRLxnt44SBOJmMD7wdwoA+od1FrQF1/YGX
         Uavw==
X-Forwarded-Encrypted: i=1; AJvYcCUvZS/yh88pcv+DtD4oIYQSq/lEKi7GBwECzo/QN0ZOB5HglaPs69vp7r3JKDh5NaLYGLVwSNbsbhybH22wmJD68ILgSPJNFNI0Rw==
X-Gm-Message-State: AOJu0Yydq/cttSRhkRvoXgTTSnwhYZ5aumVMpT9Zayk/AZ3B0ewpZiZa
	bn1ZBK1dh/XDy7GpVF06C3Fk4739Hc9fBCBBzujhyuXY7eKUDWu4d298ySr2mQKbPp+QxCXfxMP
	z2w==
X-Google-Smtp-Source: AGHT+IGSwvnidbX0/rOv0INS3he6frJgJB+IsYvN52GAPjMVdVuwPoKCHiyeHTzcN2rL9OOwKUgSVjL4/4I=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a25:2fc1:0:b0:dc6:ebd4:cca2 with SMTP id
 v184-20020a252fc1000000b00dc6ebd4cca2mr528159ybv.11.1709749563843; Wed, 06
 Mar 2024 10:26:03 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:35 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-38-surenb@google.com>
Subject: [PATCH v5 37/37] memprofiling: Documentation
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

From: Kent Overstreet <kent.overstreet@linux.dev>

Provide documentation for memory allocation profiling.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst | 91 +++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/mm/allocation-profiling.rst

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
new file mode 100644
index 000000000000..8a862c7d3aab
--- /dev/null
+++ b/Documentation/mm/allocation-profiling.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+MEMORY ALLOCATION PROFILING
+===========================
+
+Low overhead (suitable for production) accounting of all memory allocations,
+tracked by file and line number.
+
+Usage:
+kconfig options:
+ - CONFIG_MEM_ALLOC_PROFILING
+ - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+ - CONFIG_MEM_ALLOC_PROFILING_DEBUG
+   adds warnings for allocations that weren't accounted because of a
+   missing annotation
+
+Boot parameter:
+  sysctl.vm.mem_profiling=0|1|never
+
+  When set to "never", memory allocation profiling overheads is minimized and it
+  cannot be enabled at runtime (sysctl becomes read-only).
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y, default value is "1".
+  When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n, default value is "never".
+
+sysctl:
+  /proc/sys/vm/mem_profiling
+
+Runtime info:
+  /proc/allocinfo
+
+Example output:
+  root@moria-kvm:~# sort -g /proc/allocinfo|tail|numfmt --to=iec
+        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
+        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
+        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
+        4.1M        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
+        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
+        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
+         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
+         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
+         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
+         55M     4887 mm/slub.c:2259 func:alloc_slab_page
+        122M    31168 mm/page_ext.c:270 func:alloc_page_ext
+===================
+Theory of operation
+===================
+
+Memory allocation profiling builds off of code tagging, which is a library for
+declaring static structs (that typcially describe a file and line number in
+some way, hence code tagging) and then finding and operating on them at runtime
+- i.e. iterating over them to print them in debugfs/procfs.
+
+To add accounting for an allocation call, we replace it with a macro
+invocation, alloc_hooks(), that
+ - declares a code tag
+ - stashes a pointer to it in task_struct
+ - calls the real allocation function
+ - and finally, restores the task_struct alloc tag pointer to its previous value.
+
+This allows for alloc_hooks() calls to be nested, with the most recent one
+taking effect. This is important for allocations internal to the mm/ code that
+do not properly belong to the outer allocation context and should be counted
+separately: for example, slab object extension vectors, or when the slab
+allocates pages from the page allocator.
+
+Thus, proper usage requires determining which function in an allocation call
+stack should be tagged. There are many helper functions that essentially wrap
+e.g. kmalloc() and do a little more work, then are called in multiple places;
+we'll generally want the accounting to happen in the callers of these helpers,
+not in the helpers themselves.
+
+To fix up a given helper, for example foo(), do the following:
+ - switch its allocation call to the _noprof() version, e.g. kmalloc_noprof()
+ - rename it to foo_noprof()
+ - define a macro version of foo() like so:
+   #define foo(...) alloc_hooks(foo_noprof(__VA_ARGS__))
+
+It's also possible to stash a pointer to an alloc tag in your own data structures.
+
+Do this when you're implementing a generic data structure that does allocations
+"on behalf of" some other code - for example, the rhashtable code. This way,
+instead of seeing a large line in /proc/allocinfo for rhashtable.c, we can
+break it out by rhashtable type.
+
+To do so:
+ - Hook your data structure's init function, like any other allocation function
+ - Within your init function, use the convenience macro alloc_tag_record() to
+   record alloc tag in your data structure.
+ - Then, use the following form for your allocations:
+   alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
-- 
2.44.0.278.ge034bb2e1d-goog


