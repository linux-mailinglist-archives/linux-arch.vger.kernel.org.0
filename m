Return-Path: <linux-arch+bounces-12564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C8AF95EF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B21CA59F3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463D1A76D4;
	Fri,  4 Jul 2025 14:48:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C682C60;
	Fri,  4 Jul 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640485; cv=none; b=IBzIFsA7wXb3VbcGy4WfYPrpRJwfMr0yzTpa9i19tgizCtrVkEdxbN8GqQc3Kkc6lq/s6ZYEux2Hhs/h9ja6fx6aidXUMhJuT8ltpsy2GBucgpr6et2/PXAVMokUvUstoj5jWJFV+9EHen8HkViydNYoNtMfRuU0qFyfzCCqPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640485; c=relaxed/simple;
	bh=JXd4L2Kq8Oz1KRSSNblV8nPA+cSge6LWhLf7sdLS7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TEvbCCKSLYmA2hpmJx/p275lW6ZjnWGPXKJ+Uey4UrRDppalijpWa3aYw4+SQdkX+AD8t+ykiXNcB7kR4PM77iTEPIJ/RO+s+CaimVTT5qjI03p97MR4eJffeUFwrB1f++6cPC6C0tZE+WD38FqMkWWTD/FoHUoF2Vs2U88YIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 10DB31A07AA;
	Fri,  4 Jul 2025 14:47:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 3ED5434;
	Fri,  4 Jul 2025 14:47:54 +0000 (UTC)
Date: Fri, 4 Jul 2025 10:48:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: Remove redundant config HAVE_FTRACE_MCOUNT_RECORD
Message-ID: <20250704104838.27a18690@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iq14gynp569kiykpwfptajhbgss6dipi
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3ED5434
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xJMh1Zveu5YETyZ0zjTAo3h0y38hPyPs=
X-HE-Tag: 1751640474-878958
X-HE-Meta: U2FsdGVkX18zbeJkzUbzXQociQzRQBuvVpf6BHr8xcI6B9fpuS8d5NLKyUtk/WyAnOWtDDC/LTrBC/inAxVhH2LJXAaq9xso7O/EOpNmrYTGmyJQ2VUXdqgFSc8ZVGNX05Ffd8BeDOQvcgzGuYrPpBcfUpmNyU+dWK5HhgSbQszFNiM0IAUofxzr1N3MEVUub8RmIn+Dd2e4BFKxHbKIF/cY98W2M6NP56+PHQf1tBeIb5I1NJv6kP6+stOm80YarDvNk12nzoi9SFJy3T8I88N+fVCi8RALLinKjFr38hT8HgTHw9TBR6A/6hadDv5kwtDmZFwbh5rwpjfU6TfboL0p6KrgvYXCnl8QUKfkCjfqAFm+i2TfQaSqUaqCbPyA1B2vB4iB+CLVAeY3EXy2UqiGxq1kAJknJQLLqpYhwGTnJIxAU0kRdA==

From: Steven Rostedt <rostedt@goodmis.org>

Ftrace is tightly coupled with architecture specific code because it
requires the use of trampolines written in assembly. This means that when
a new feature or optimization is made, it must be done for all
architectures. To simplify the approach, CONFIG_HAVE_FTRACE_* configs are
added to denote which architecture has the new enhancement so that other
architectures can still function until they too have been updated.

The CONFIG_HAVE_FTRACE_MCOUNT was added to help simplify the
DYNAMIC_FTRACE work, but now every architecture that implements
DYNAMIC_FTRACE also has HAVE_FTRACE_MCOUNT set too, making it redundant
with the HAVE_DYNAMIC_FTRACE.

Remove the HAVE_FTRACE_MCOUNT config and use DYNAMIC_FTRACE directly where
applicable.

Link: https://lore.kernel.org/all/20250703154916.48e3ada7@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[
  I'm off today due to fireworks, but I noticed that this was
  ready to go out, so I'm posting it now.
]
 Documentation/trace/ftrace-design.rst | 12 ++++--------
 arch/arm/Kconfig                      |  1 -
 arch/arm64/Kconfig                    |  1 -
 arch/csky/Kconfig                     |  1 -
 arch/loongarch/Kconfig                |  1 -
 arch/microblaze/Kconfig               |  1 -
 arch/mips/Kconfig                     |  1 -
 arch/parisc/Kconfig                   |  1 -
 arch/powerpc/Kconfig                  |  1 -
 arch/riscv/Kconfig                    |  1 -
 arch/s390/Kconfig                     |  1 -
 arch/sh/Kconfig                       |  1 -
 arch/sparc/Kconfig                    |  1 -
 arch/x86/Kconfig                      |  1 -
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/ftrace.h                |  2 +-
 include/linux/kernel.h                |  6 +++---
 include/linux/module.h                |  2 +-
 kernel/module/main.c                  |  2 +-
 kernel/trace/Kconfig                  | 18 ++++--------------
 kernel/trace/ftrace.c                 |  4 ----
 scripts/recordmcount.pl               |  2 +-
 22 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/Documentation/trace/ftrace-design.rst b/Documentation/trace/ftrace-design.rst
index dc82d64b3a44..8f4fab3f9324 100644
--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -238,19 +238,15 @@ You need very few things to get the syscalls tracing in an arch.
   - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
 
 
-HAVE_FTRACE_MCOUNT_RECORD
--------------------------
+HAVE_DYNAMIC_FTRACE
+-------------------
 
 See scripts/recordmcount.pl for more info.  Just fill in the arch-specific
 details for how to locate the addresses of mcount call sites via objdump.
 This option doesn't make much sense without also implementing dynamic ftrace.
 
-
-HAVE_DYNAMIC_FTRACE
--------------------
-
-You will first need HAVE_FTRACE_MCOUNT_RECORD and HAVE_FUNCTION_TRACER, so
-scroll your reader back up if you got over eager.
+You will first need HAVE_FUNCTION_TRACER, so scroll your reader back up if you
+got over eager.
 
 Once those are out of the way, you will need to implement:
 	- asm/ftrace.h:
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3072731fe09c..33cc9dbb7f68 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -107,7 +107,6 @@ config ARM
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST if ARM_LPAE
-	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331af337..f943a07db139 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -223,7 +223,6 @@ config ARM64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_FREGS
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index acc431c331b0..4331313a42ff 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -80,7 +80,6 @@ config CSKY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4b19f93379a1..bead8266dc5c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -144,7 +144,6 @@ config LOONGARCH
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_FREGS
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f18ec02ddeb2..484ebb3baedf 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -28,7 +28,6 @@ config MICROBLAZE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_PAGE_SIZE_4KB
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1e48184ecf1e..268730824f75 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,7 +73,6 @@ config MIPS
 	select HAVE_EBPF_JIT if !CPU_MICROMIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fcc5973f7519..2efa4b08b7b8 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -81,7 +81,6 @@ config PARISC
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_DYNAMIC_FTRACE if $(cc-option,-fpatchable-function-entry=1,1)
-	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f120..cb4fb8d73300 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,7 +246,6 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..cd1cec255015 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -158,7 +158,6 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC
-	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f..d956e85f0465 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -199,7 +199,6 @@ config S390
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
 	select HAVE_FTRACE_GRAPH_FUNC
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_FREGS
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 89185af7bcc9..d5795067befa 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -40,7 +40,6 @@ config SUPERH
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f88123925a4..f307e730446c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -78,7 +78,6 @@ config SPARC64
 	select MMU_GATHER_NO_FLUSH_CACHE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_CONTEXT_TRACKING_USER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..eb07f236ce53 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -244,7 +244,6 @@ config X86
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a..ae2d2359b79e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -167,7 +167,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define FTRACE_STUB_HACK
 #endif
 
-#ifdef CONFIG_FTRACE_MCOUNT_RECORD
+#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * The ftrace call sites are logged to a section whose name depends on the
  * compiler option used. A given kernel image will only use one, AKA
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b672ca15f265..7ded7df6e9b5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1108,7 +1108,7 @@ static __always_inline unsigned long get_lock_parent_ip(void)
 # define trace_preempt_off(a0, a1) do { } while (0)
 #endif
 
-#ifdef CONFIG_FTRACE_MCOUNT_RECORD
+#ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_init(void);
 #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
 #define FTRACE_CALLSITE_SECTION	"__patchable_function_entries"
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1cce1f6410a9..989315dabb86 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -373,9 +373,9 @@ ftrace_vprintk(const char *fmt, va_list ap)
 static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
-/* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
-#ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
+/* Rebuild everything on CONFIG_DYNAMIC_FTRACE */
+#ifdef CONFIG_DYNAMIC_FTRACE
+# define REBUILD_DUE_TO_DYNAMIC_FTRACE
 #endif
 
 /* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
diff --git a/include/linux/module.h b/include/linux/module.h
index 5faa1fb1f4b4..800e6fde9bf7 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -539,7 +539,7 @@ struct module {
 	struct trace_eval_map **trace_evals;
 	unsigned int num_trace_evals;
 #endif
-#ifdef CONFIG_FTRACE_MCOUNT_RECORD
+#ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea3702..58d36f8cef0d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2639,7 +2639,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					 sizeof(*mod->trace_bprintk_fmt_start),
 					 &mod->num_trace_bprintk_fmt);
 #endif
-#ifdef CONFIG_FTRACE_MCOUNT_RECORD
+#ifdef CONFIG_DYNAMIC_FTRACE
 	/* sechdrs[0].sh_size is always zero */
 	mod->ftrace_callsites = section_objs(info, FTRACE_CALLSITE_SECTION,
 					     sizeof(*mod->ftrace_callsites),
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..c2ce834313a9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -74,11 +74,6 @@ config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	  If the architecture generates __patchable_function_entries sections
 	  but does not want them included in the ftrace locations.
 
-config HAVE_FTRACE_MCOUNT_RECORD
-	bool
-	help
-	  See Documentation/trace/ftrace-design.rst
-
 config HAVE_SYSCALL_TRACEPOINTS
 	bool
 	help
@@ -803,27 +798,22 @@ config BPF_KPROBE_OVERRIDE
 	 Allows BPF to override the execution of a probed function and
 	 set a different return value.  This is used for error injection.
 
-config FTRACE_MCOUNT_RECORD
-	def_bool y
-	depends on DYNAMIC_FTRACE
-	depends on HAVE_FTRACE_MCOUNT_RECORD
-
 config FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	bool
-	depends on FTRACE_MCOUNT_RECORD
+	depends on DYNAMIC_FTRACE
 
 config FTRACE_MCOUNT_USE_CC
 	def_bool y
 	depends on $(cc-option,-mrecord-mcount)
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
-	depends on FTRACE_MCOUNT_RECORD
+	depends on DYNAMIC_FTRACE
 
 config FTRACE_MCOUNT_USE_OBJTOOL
 	def_bool y
 	depends on HAVE_OBJTOOL_MCOUNT
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
-	depends on FTRACE_MCOUNT_RECORD
+	depends on DYNAMIC_FTRACE
 	select OBJTOOL
 
 config FTRACE_MCOUNT_USE_RECORDMCOUNT
@@ -831,7 +821,7 @@ config FTRACE_MCOUNT_USE_RECORDMCOUNT
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
 	depends on !FTRACE_MCOUNT_USE_OBJTOOL
-	depends on FTRACE_MCOUNT_RECORD
+	depends on DYNAMIC_FTRACE
 
 config TRACING_MAP
 	bool
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4203fad56b6c..00b76d450a89 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1042,10 +1042,6 @@ static struct ftrace_ops *removed_ops;
  */
 static bool update_all_ops;
 
-#ifndef CONFIG_FTRACE_MCOUNT_RECORD
-# error Dynamic ftrace depends on MCOUNT_RECORD
-#endif
-
 struct ftrace_func_probe {
 	struct ftrace_probe_ops	*probe_ops;
 	struct ftrace_ops	ops;
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 0871b2e92584..861b56dda64e 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -359,7 +359,7 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_CKCORE_PCREL_JSR_IMM26BY2\\s+_mcount\$";
     $alignment = 2;
 } else {
-    die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
+    die "Arch $arch is not supported with CONFIG_DYNAMIC_FTRACE";
 }
 
 my $text_found = 0;
-- 
2.47.2


