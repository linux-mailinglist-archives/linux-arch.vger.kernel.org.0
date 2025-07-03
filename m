Return-Path: <linux-arch+bounces-12560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B4AF8195
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0233B172E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A962980A4;
	Thu,  3 Jul 2025 19:48:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012062B9A6;
	Thu,  3 Jul 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572121; cv=none; b=EaYcDRB6/rLYICFR6GJN+nFN60bcnnYCVfzjWEtGphLEFWXL6X+0uhtTrDoRChGyv1X94T0qRr8cOFwsWIqm0+NBPDDwCXQiuL6DdWqd6ULLpx/nP/ALn8yYPeB8FUMtUgx6Y8yc6YmnzQk6+HEt2z+5HxSHm2sX1d57dx5qY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572121; c=relaxed/simple;
	bh=BufxFC1VyZ5yZ46Pi6bAi5DuWkKeF2lFbyc+DJVO/fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UATu4AIyeFujB3OhHuzKkgTKhUCIOqnUhGIRuTKGIBBlQH4p3cS4nGIpAD8GBvP+GlROCSJuoE0w0Vxo1zKM71YKIm+LwRe4oALgyd5nYUnNFE03x0i4JbKElVgS9b+g02OqQfk26TOYCM1oipkGuVzokfkNewBlvrrXIxug9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3459B80149;
	Thu,  3 Jul 2025 19:48:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1AE7780014;
	Thu,  3 Jul 2025 19:48:34 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:49:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
Message-ID: <20250703154916.48e3ada7@gandalf.local.home>
In-Reply-To: <20250703152643.0a4a45fe@gandalf.local.home>
References: <20250703115222.2d7c8cd5@batman.local.home>
	<CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
	<20250703152643.0a4a45fe@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 46b8s1csee7cykzyqx9s5pkhes6u3b45
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1AE7780014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191Sk5GL5Ez/PT+Ysav4rirFHhO8L5oSwI=
X-HE-Tag: 1751572114-529219
X-HE-Meta: U2FsdGVkX18iW6zbFP/MJJqf1qKYdoGCS0o516ats7Nlzip4yL0MBAZC3EsJN3udzQwyrJ42S1JtvTK6q02H5BdV0InaVL54p+CgxL09M2d6lD438hDJjohk0x5ppaK9bQADP0cUbE7iIib2FI8VvwnIX6tODX0prNfbMJ9uWnhVD7KYcQDnNp5HhsfTfVe1WHrgksJVZfYY5ihw/Y4Envuxajkld28oaC4e0isHtA54xvv0rMIDSG4ntz0JWeeSASSjMh39uZ48vJI1PipA5ndPG9DrL7rh0o/LIZqXk1NMmGYrXsNZU+nqJ+dyxJyq7PXFn2BMT5asnXYtuGA7gvKJFYszRCZ5DU4Fb2y3YQ7Nr5pSxQA5DjdEtoqLS0GJr/wvIroSfBQPbOhjuQ8R2vC3icm4WJl7

On Thu, 3 Jul 2025 15:26:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I should look to see what hasn't been ported to every architecture that
> supports ftrace and remove the configs that are now universal.

HAVE_FTRACE_MCUONT_RECORD looks like a candidate for removal:

$ git grep -e HAVE_FTRACE_MCOUNT -e HAVE_FUNCTION_TRACER arch
arch/arm/Kconfig:       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
arch/arm/Kconfig:       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
arch/arm64/Kconfig:     select HAVE_FTRACE_MCOUNT_RECORD
arch/arm64/Kconfig:     select HAVE_FUNCTION_TRACER
arch/csky/Kconfig:      select HAVE_FUNCTION_TRACER
arch/csky/Kconfig:      select HAVE_FTRACE_MCOUNT_RECORD
arch/loongarch/Kconfig: select HAVE_FTRACE_MCOUNT_RECORD
arch/loongarch/Kconfig: select HAVE_FUNCTION_TRACER
arch/microblaze/Kconfig:        select HAVE_FTRACE_MCOUNT_RECORD
arch/microblaze/Kconfig:        select HAVE_FUNCTION_TRACER
arch/mips/Kconfig:      select HAVE_FTRACE_MCOUNT_RECORD
arch/mips/Kconfig:      select HAVE_FUNCTION_TRACER
arch/parisc/Kconfig:    select HAVE_FUNCTION_TRACER
arch/parisc/Kconfig:    select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
arch/powerpc/Kconfig:   select HAVE_FTRACE_MCOUNT_RECORD
arch/powerpc/Kconfig:   select HAVE_FUNCTION_TRACER             if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
arch/riscv/Kconfig:     select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
arch/riscv/Kconfig:     select HAVE_FUNCTION_TRACER if !XIP_KERNEL
arch/s390/Kconfig:      select HAVE_FTRACE_MCOUNT_RECORD
arch/s390/Kconfig:      select HAVE_FUNCTION_TRACER
arch/sh/Kconfig:        select HAVE_FUNCTION_TRACER
arch/sh/Kconfig:        select HAVE_FTRACE_MCOUNT_RECORD
arch/sparc/Kconfig:     select HAVE_FUNCTION_TRACER
arch/sparc/Kconfig:     select HAVE_FTRACE_MCOUNT_RECORD
arch/x86/Kconfig:       select HAVE_FTRACE_MCOUNT_RECORD
arch/x86/Kconfig:       select HAVE_FUNCTION_TRACER
arch/xtensa/Kconfig:    select HAVE_FUNCTION_TRACER

HAVE_FTRACE_MCOUNT_RECORD only means something if HAVE_FUNCTION_TRACER is
set. Arm and riscv have the same dependencies for both.

It is also only meaningful for HAVE_DYNAMIC_FTRACE, so parisc is fine.

But it appears that xtensa is the only one that doesn't select it. But it
is also the only arch that doesn't support DYNAMIC_FTRACE either so that's
fine. The HAVE_FTRACE_MCOUNT_RECORD can be replaced by HAVE_DYNAMIC_FTRACE,
as MCOUNT_RECORD is what is used to create the sections needed for
DYNAMIC_FTRACE.

In fact the config has:

config FTRACE_MCOUNT_RECORD
	def_bool y
	depends on DYNAMIC_FTRACE
	depends on HAVE_FTRACE_MCOUNT_RECORD

Now this config is only used for adding a section in vmlinux.lds. Thus, we
can remove the MCOUNT_RECORD configs and just use CONFIG_DYNAMIC_FTRACE
instead.

Something like below. I haven tested it. I would need to compile every
arch. But I think this would work.

-- Steve


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
index 5862433c81e1..2fc0d54ce634 100644
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
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 515d2995672d..14efd8c027aa 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -28,8 +28,8 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(current->unwind_info.id))
-		current->unwind_info.id = 0;
+	if (unlikely(current->unwind_info.id.id))
+		current->unwind_info.id.id = 0;
 	/*
 	 * As unwind_user_faultable() can be called directly and
 	 * depends on nr_entries being cleared on exit to user,
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

