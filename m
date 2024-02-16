Return-Path: <linux-arch+bounces-2443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB898577E1
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 09:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828E728474F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0895D17BD6;
	Fri, 16 Feb 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XBAf9glz"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276C1B7F0
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072971; cv=none; b=SjOng0kPQs5xj85uTYsVOCl2PTjJ5E/sn64LhiAO97avf9aobUreAa2bmlT/zn6Gq9/JwEw3XkUoLuTDmrvuCyfA6c28E9ALQA5GmEikUugv9UXU7UTXDoIa0fYbG9RhMyTAZQOtwFIdwpb1Zi85CjPfLHiiSzbzzICB++7Bbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072971; c=relaxed/simple;
	bh=b53VFsoNua1SMZqHjnIYy5K7hQcfzKzegpUx8kXZyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o08HKQ1hbDYSiIXI/Neynaly7LN9j5IxAMdGjt9DYWFs9Qpvfslnsv2UZdh3cUvonMm8cNlljk36Y4kLQXJHtmGQcgksWkgR0whd4U1ptZbj4fSbK7tX4MW6XTxQlntRY1H+nQb8AW2xV8Z2mYBsmirJlUCai015AGtMtCjhAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XBAf9glz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Feb 2024 03:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708072966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iD3JwaVQ74VDSKWCWZ1B7FlzTV5HffeulQedls0mqs0=;
	b=XBAf9glzfRroBpjYY88uxjbSeNe6nZkW/0CXOHHsLM6By7g/JCALirh+eoFHaaqsSDTPQ2
	p0DHixc5L1OKMb9Iz2FgNbI18R8cvnQR9Y15IGd3LB03PHcrWC6cMtuwIB34H07uDGwSie
	r35pkeuC/79+KtJtKkxhiztqNUSrJug=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <plijmr6acz2cvrfokgc46bt5budre5d5ed3alpapu4gvhkqkmn@55yhfdhigjp3>
References: <20240212213922.783301-1-surenb@google.com>
 <87sf1s4xef.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf1s4xef.fsf@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 16, 2024 at 10:38:00AM +0200, Jani Nikula wrote:
> On Mon, 12 Feb 2024, Suren Baghdasaryan <surenb@google.com> wrote:
> > Memory allocation, v3 and final:
> >
> > Overview:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for debug
> > kernels, overhead low enough to be deployed in production.
> >
> > We're aiming to get this in the next merge window, for 6.9. The feedback
> > we've gotten has been that even out of tree this patchset has already
> > been useful, and there's a significant amount of other work gated on the
> > code tagging functionality included in this patchset [2].
> 
> I wonder if it wouldn't be too much trouble to write at least a brief
> overview document under Documentation/ describing what this is all
> about? Even as follow-up. People seeing the patch series have the
> benefit of the cover letter and the commit messages, but that's hardly
> documentation.
> 
> We have all these great frameworks and tools but their discoverability
> to kernel developers isn't always all that great.

commit f589b48789de4b8f77bfc70b9f3ab2013c01eaf2
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Feb 14 01:13:04 2024 -0500

    memprofiling: Documentation
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
new file mode 100644
index 000000000000..d906e9360279
--- /dev/null
+++ b/Documentation/mm/allocation-profiling.rst
@@ -0,0 +1,68 @@
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
+sysctl:
+  /proc/sys/vm/mem_profiling
+
+Runtime info:
+  /proc/allocinfo
+
+Example output:
+  root@moria-kvm:~# sort -h /proc/allocinfo|tail
+   3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_inode
+   3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_stack_node
+   3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
+   4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_collapse_alloc_folio
+   10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc_rqs
+   14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_alloc_noprof
+   26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_alloc_noprof
+   64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_init
+   98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio_alloc_noprof
+    125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page
+
+
+Theory of operation:
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

