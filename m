Return-Path: <linux-arch+bounces-2855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C01873EE5
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53FF1F23224
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B7146E79;
	Wed,  6 Mar 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZDQSp0P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67A13EFEE
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749517; cv=none; b=D1qS2N6kxp3gufxzQBHrQE0ftru4TUP056+3OKcppOBVGJH/bFJ0HzYTAloEO7I/292SSQvp5RoLF4ewepdD/kRiSHmcyohbqRInoFIqUi2D31/krYbBwqg4ri+4HEtlLOkOk2BG1IVNBSnEC0h9Gqk+z0p1JQt6i/2b1ciTTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749517; c=relaxed/simple;
	bh=mBf0IqjV8IEFldcjzbVS7O899IXdlye7ACDOjOftMw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t4yVryCO1twnliuHKkIR+3o8HMdGp9h1jK88+K5fCdy+ogLTtoKK2X8lf57MCWQSJQp+fXelilzkIc6w6sy7poRAVjHDG0LAxNnRiTsGt1lPd1tpjwD6dJyhqyjfAyk1KtSqB9ftSMXxPA1LL2wy/pEEsReqB4AK+xsGdiMwIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZDQSp0P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so13633738276.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749513; x=1710354313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnpH2fzc60uRea0gIp8vcDyDoI+2TUkhYU4AGh25C8A=;
        b=AZDQSp0PY25p1s8L7LAMIbruCIhWP4Qx3NYAgBxtMv+wTT/kjLOqC/x6l/zSyudXcF
         bPS/oWIDJ9ct0vOIJq7O6MPrSYyLIg1lmGE9kC4lqpNvGAfMd750Dm59Zp1ziP53pjpr
         FIypQl/llaLhm9RnZ112cbl/Y/cDOO7JDIpjf0GL1YP9PM8jGVxkQdKlvR/+cERBQejp
         GFGv0Mro/ot6Mizh7/7uyeDB305gIU16DYOlnw5mrR18picgDZ2RbDbQ/QAjvZMI5M/P
         YRUa6p9AtN/lOcxIciezW6WozqQUTcJAMevff/5J7CAiHxSea+qwHJwAlNkHhAlU9yTA
         /z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749513; x=1710354313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnpH2fzc60uRea0gIp8vcDyDoI+2TUkhYU4AGh25C8A=;
        b=Mvz7VIYiY8kOsNNK0IseDstX+dWizVB5/CiAvUBhNjNgbH4rE7PTQIPGF/eGrhlRjL
         BSZ1+X/WgWNFwtSJAAMiAmNwG6MVF3SsH14t8K4Bi+jZplC3otiDLo8dkKooXWfu5sRQ
         pS7Go1RzdMb1N4TueBtS0A88j8tEMTq0A1yVPMdIHGRoV/Vbp0Mjv6B+Bf8vPvW5t/YA
         TavKsvIpVg2tcC+I3pNqZfKl9rJM7dgOvj3MLjCskbwF9OE36kQGgsNbBnvLLinCoPKI
         vgnlY/oFUcar43LQAS5Fhr+jNQADSagO9iVXVA5lyH67c3AFDPAu5YLH+x7djo+iFNlE
         AUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUaabxhih6ihEWXKh4yXzf78UNO+UOgxrvMFe4GO0toUeyzE6Qy67PWhwmpHjkorMaOqaRO8cqdvlaNI19/btobOxYDCtT79hYPhQ==
X-Gm-Message-State: AOJu0YwjzmpHgXcSp+lzjTDpW2uqeikRNfQr5/pZejcF2/ZA9PtgxUCZ
	MpdbFZK0UlsKs3nDwwfSo0bWExVoARMA0EwFf5pkymmwp6VDJCGGPaeAsjiOxwcerjP05iKrDmH
	uiQ==
X-Google-Smtp-Source: AGHT+IGX3juLGqkY9E1zWVL+Y8vMZ2gv0idtMMYFCn+Z2jw5L1fpCvfCW0xTdSo9nyCa2B1lhhZALB6C6dY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1891:b0:dcc:54d0:85e0 with SMTP id
 cj17-20020a056902189100b00dcc54d085e0mr4037556ybb.11.1709749512799; Wed, 06
 Mar 2024 10:25:12 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:11 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-14-surenb@google.com>
Subject: [PATCH v5 13/37] lib: add allocation tagging support for memory
 allocation profiling
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

Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
instrument memory allocators. It registers an "alloc_tags" codetag type
with /proc/allocinfo interface to output allocation tag information when
the feature is enabled.
CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
allocation profiling instrumentation.
Memory allocation profiling can be enabled or disabled at runtime using
/proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=n.
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
profiling by default.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 Documentation/admin-guide/sysctl/vm.rst |  16 +++
 Documentation/filesystems/proc.rst      |  29 +++++
 include/asm-generic/codetag.lds.h       |  14 +++
 include/asm-generic/vmlinux.lds.h       |   3 +
 include/linux/alloc_tag.h               | 145 +++++++++++++++++++++++
 include/linux/sched.h                   |  24 ++++
 lib/Kconfig.debug                       |  25 ++++
 lib/Makefile                            |   2 +
 lib/alloc_tag.c                         | 149 ++++++++++++++++++++++++
 scripts/module.lds.S                    |   7 ++
 10 files changed, 414 insertions(+)
 create mode 100644 include/asm-generic/codetag.lds.h
 create mode 100644 include/linux/alloc_tag.h
 create mode 100644 lib/alloc_tag.c

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index c59889de122b..e86c968a7a0e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -43,6 +43,7 @@ Currently, these files are in /proc/sys/vm:
 - legacy_va_layout
 - lowmem_reserve_ratio
 - max_map_count
+- mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
 - memory_failure_early_kill
 - memory_failure_recovery
 - min_free_kbytes
@@ -425,6 +426,21 @@ e.g., up to one or two maps per allocation.
 The default value is 65530.
 
 
+mem_profiling
+==============
+
+Enable memory profiling (when CONFIG_MEM_ALLOC_PROFILING=y)
+
+1: Enable memory profiling.
+
+0: Disable memory profiling.
+
+Enabling memory profiling introduces a small performance overhead for all
+memory allocations.
+
+The default value depends on CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT.
+
+
 memory_failure_early_kill:
 ==========================
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 104c6d047d9b..8150dc3d689c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -688,6 +688,7 @@ files are there, and which are missing.
  ============ ===============================================================
  File         Content
  ============ ===============================================================
+ allocinfo    Memory allocations profiling information
  apm          Advanced power management info
  bootconfig   Kernel command line obtained from boot config,
  	      and, if there were kernel parameters from the
@@ -953,6 +954,34 @@ also be allocatable although a lot of filesystem metadata may have to be
 reclaimed to achieve this.
 
 
+allocinfo
+~~~~~~~
+
+Provides information about memory allocations at all locations in the code
+base. Each allocation in the code is identified by its source file, line
+number, module (if originates from a loadable module) and the function calling
+the allocation. The number of bytes allocated and number of calls at each
+location are reported.
+
+Example output.
+
+::
+
+    > sort -rn /proc/allocinfo
+   127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
+    56373248     4737 mm/slub.c:2259 func:alloc_slab_page
+    14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
+    14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
+    13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
+    11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
+     9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
+     4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct_alloc_hashtable
+     4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] func:ctagmod_start
+     3940352      962 mm/memory.c:4214 func:alloc_anon_folio
+     2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
+     ...
+
+
 meminfo
 ~~~~~~~
 
diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
new file mode 100644
index 000000000000..64f536b80380
--- /dev/null
+++ b/include/asm-generic/codetag.lds.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_CODETAG_LDS_H
+#define __ASM_GENERIC_CODETAG_LDS_H
+
+#define SECTION_WITH_BOUNDARIES(_name)	\
+	. = ALIGN(8);			\
+	__start_##_name = .;		\
+	KEEP(*(_name))			\
+	__stop_##_name = .;
+
+#define CODETAG_SECTIONS()		\
+	SECTION_WITH_BOUNDARIES(alloc_tags)
+
+#endif /* __ASM_GENERIC_CODETAG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61d673d..c9997dc50c50 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -50,6 +50,8 @@
  *               [__nosave_begin, __nosave_end] for the nosave data
  */
 
+#include <asm-generic/codetag.lds.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
@@ -366,6 +368,7 @@
 	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
new file mode 100644
index 000000000000..b970ff1c80dc
--- /dev/null
+++ b/include/linux/alloc_tag.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * allocation tagging
+ */
+#ifndef _LINUX_ALLOC_TAG_H
+#define _LINUX_ALLOC_TAG_H
+
+#include <linux/bug.h>
+#include <linux/codetag.h>
+#include <linux/container_of.h>
+#include <linux/preempt.h>
+#include <asm/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/static_key.h>
+
+struct alloc_tag_counters {
+	u64 bytes;
+	u64 calls;
+};
+
+/*
+ * An instance of this structure is created in a special ELF section at every
+ * allocation callsite. At runtime, the special section is treated as
+ * an array of these. Embedded codetag utilizes codetag framework.
+ */
+struct alloc_tag {
+	struct codetag			ct;
+	struct alloc_tag_counters __percpu	*counters;
+} __aligned(8);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
+{
+	return container_of(ct, struct alloc_tag, ct);
+}
+
+#ifdef ARCH_NEEDS_WEAK_PER_CPU
+/*
+ * When percpu variables are required to be defined as weak, static percpu
+ * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
+ */
+#error "Memory allocation profiling is incompatible with ARCH_NEEDS_WEAK_PER_CPU"
+#endif
+
+#define DEFINE_ALLOC_TAG(_alloc_tag)						\
+	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
+	static struct alloc_tag _alloc_tag __used __aligned(8)			\
+	__section("alloc_tags") = {						\
+		.ct = CODE_TAG_INIT,						\
+		.counters = &_alloc_tag_cntr };
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
+			mem_alloc_profiling_key);
+
+static inline bool mem_alloc_profiling_enabled(void)
+{
+	return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
+				   &mem_alloc_profiling_key);
+}
+
+static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
+{
+	struct alloc_tag_counters v = { 0, 0 };
+	struct alloc_tag_counters *counter;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		counter = per_cpu_ptr(tag->counters, cpu);
+		v.bytes += counter->bytes;
+		v.calls += counter->calls;
+	}
+
+	return v;
+}
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	WARN_ONCE(ref && ref->ct,
+		  "alloc_tag was not cleared (got tag for %s:%u)\n",
+		  ref->ct->filename, ref->ct->lineno);
+
+	WARN_ONCE(!tag, "current->alloc_tag not set");
+}
+
+static inline void alloc_tag_sub_check(union codetag_ref *ref)
+{
+	WARN_ONCE(ref && !ref->ct, "alloc_tag was not set\n");
+}
+#else
+static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag) {}
+static inline void alloc_tag_sub_check(union codetag_ref *ref) {}
+#endif
+
+/* Caller should verify both ref and tag to be valid */
+static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	ref->ct = &tag->ct;
+	/*
+	 * We need in increment the call counter every time we have a new
+	 * allocation or when we split a large allocation into smaller ones.
+	 * Each new reference for every sub-allocation needs to increment call
+	 * counter because when we free each part the counter will be decremented.
+	 */
+	this_cpu_inc(tag->counters->calls);
+}
+
+static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
+{
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
+	__alloc_tag_ref_set(ref, tag);
+	this_cpu_add(tag->counters->bytes, bytes);
+}
+
+static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
+{
+	struct alloc_tag *tag;
+
+	alloc_tag_sub_check(ref);
+	if (!ref || !ref->ct)
+		return;
+
+	tag = ct_to_alloc_tag(ref->ct);
+
+	this_cpu_sub(tag->counters->bytes, bytes);
+	this_cpu_dec(tag->counters->calls);
+
+	ref->ct = NULL;
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING */
+
+#define DEFINE_ALLOC_TAG(_alloc_tag)
+static inline bool mem_alloc_profiling_enabled(void) { return false; }
+static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
+				 size_t bytes) {}
+static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
+#endif /* _LINUX_ALLOC_TAG_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 998861865b84..f85b58e385a3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -770,6 +770,10 @@ struct task_struct {
 	unsigned int			flags;
 	unsigned int			ptrace;
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	struct alloc_tag		*alloc_tag;
+#endif
+
 #ifdef CONFIG_SMP
 	int				on_cpu;
 	struct __call_single_node	wake_entry;
@@ -810,6 +814,7 @@ struct task_struct {
 	struct task_group		*sched_task_group;
 #endif
 
+
 #ifdef CONFIG_UCLAMP_TASK
 	/*
 	 * Clamp values requested for a scheduling entity.
@@ -2185,4 +2190,23 @@ static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
+{
+	swap(current->alloc_tag, tag);
+	return tag;
+}
+
+static inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
+{
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+	WARN(current->alloc_tag != tag, "current->alloc_tag was changed:\n");
+#endif
+	current->alloc_tag = old;
+}
+#else
+#define alloc_tag_save(_tag)			NULL
+#define alloc_tag_restore(_tag, _old)		do {} while (0)
+#endif
+
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5485a5780fa7..0dd6ab986246 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -972,6 +972,31 @@ config CODE_TAGGING
 	bool
 	select KALLSYMS
 
+config MEM_ALLOC_PROFILING
+	bool "Enable memory allocation profiling"
+	default n
+	depends on PROC_FS
+	depends on !DEBUG_FORCE_WEAK_PER_CPU
+	select CODE_TAGGING
+	help
+	  Track allocation source code and record total allocation size
+	  initiated at that code location. The mechanism can be used to track
+	  memory leaks with a low performance and memory impact.
+
+config MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+	bool "Enable memory allocation profiling by default"
+	default y
+	depends on MEM_ALLOC_PROFILING
+
+config MEM_ALLOC_PROFILING_DEBUG
+	bool "Memory allocation profiler debugging"
+	default n
+	depends on MEM_ALLOC_PROFILING
+	select MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+	help
+	  Adds warnings with helpful error messages for memory allocation
+	  profiling.
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/Makefile b/lib/Makefile
index 6b48b22fdfac..859112f09bf5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -236,6 +236,8 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_CODE_TAGGING) += codetag.o
+obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
+
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
new file mode 100644
index 000000000000..f09c8a422bc2
--- /dev/null
+++ b/lib/alloc_tag.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/alloc_tag.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+
+static struct codetag_type *alloc_tag_cttype;
+
+DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
+			mem_alloc_profiling_key);
+
+static void *allocinfo_start(struct seq_file *m, loff_t *pos)
+{
+	struct codetag_iterator *iter;
+	struct codetag *ct;
+	loff_t node = *pos;
+
+	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+	m->private = iter;
+	if (!iter)
+		return NULL;
+
+	codetag_lock_module_list(alloc_tag_cttype, true);
+	*iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(iter)) != NULL && node)
+		node--;
+
+	return ct ? iter : NULL;
+}
+
+static void *allocinfo_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
+	struct codetag *ct = codetag_next_ct(iter);
+
+	(*pos)++;
+	if (!ct)
+		return NULL;
+
+	return iter;
+}
+
+static void allocinfo_stop(struct seq_file *m, void *arg)
+{
+	struct codetag_iterator *iter = (struct codetag_iterator *)m->private;
+
+	if (iter) {
+		codetag_lock_module_list(alloc_tag_cttype, false);
+		kfree(iter);
+	}
+}
+
+static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
+{
+	struct alloc_tag *tag = ct_to_alloc_tag(ct);
+	struct alloc_tag_counters counter = alloc_tag_read(tag);
+	s64 bytes = counter.bytes;
+
+	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
+	codetag_to_text(out, ct);
+	seq_buf_putc(out, ' ');
+	seq_buf_putc(out, '\n');
+}
+
+static int allocinfo_show(struct seq_file *m, void *arg)
+{
+	struct codetag_iterator *iter = (struct codetag_iterator *)arg;
+	char *bufp;
+	size_t n = seq_get_buf(m, &bufp);
+	struct seq_buf buf;
+
+	seq_buf_init(&buf, bufp, n);
+	alloc_tag_to_text(&buf, iter->ct);
+	seq_commit(m, seq_buf_used(&buf));
+	return 0;
+}
+
+static const struct seq_operations allocinfo_seq_op = {
+	.start	= allocinfo_start,
+	.next	= allocinfo_next,
+	.stop	= allocinfo_stop,
+	.show	= allocinfo_show,
+};
+
+static void __init procfs_init(void)
+{
+	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
+}
+
+static bool alloc_tag_module_unload(struct codetag_type *cttype,
+				    struct codetag_module *cmod)
+{
+	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
+	struct alloc_tag_counters counter;
+	bool module_unused = true;
+	struct alloc_tag *tag;
+	struct codetag *ct;
+
+	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
+		if (iter.cmod != cmod)
+			continue;
+
+		tag = ct_to_alloc_tag(ct);
+		counter = alloc_tag_read(tag);
+
+		if (WARN(counter.bytes,
+			 "%s:%u module %s func:%s has %llu allocated at module unload",
+			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
+			module_unused = false;
+	}
+
+	return module_unused;
+}
+
+static struct ctl_table memory_allocation_profiling_sysctls[] = {
+	{
+		.procname	= "mem_profiling",
+		.data		= &mem_alloc_profiling_key,
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+		.mode		= 0444,
+#else
+		.mode		= 0644,
+#endif
+		.proc_handler	= proc_do_static_key,
+	},
+	{ }
+};
+
+static int __init alloc_tag_init(void)
+{
+	const struct codetag_type_desc desc = {
+		.section	= "alloc_tags",
+		.tag_size	= sizeof(struct alloc_tag),
+		.module_unload	= alloc_tag_module_unload,
+	};
+
+	alloc_tag_cttype = codetag_register_type(&desc);
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return PTR_ERR(alloc_tag_cttype);
+
+	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
+	procfs_init();
+
+	return 0;
+}
+module_init(alloc_tag_init);
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..45c67a0994f3 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -9,6 +9,8 @@
 #define DISCARD_EH_FRAME	*(.eh_frame)
 #endif
 
+#include <asm-generic/codetag.lds.h>
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
@@ -47,12 +49,17 @@ SECTIONS {
 	.data : {
 		*(.data .data.[0-9a-zA-Z_]*)
 		*(.data..L*)
+		CODETAG_SECTIONS()
 	}
 
 	.rodata : {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
+#else
+	.data : {
+		CODETAG_SECTIONS()
+	}
 #endif
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


