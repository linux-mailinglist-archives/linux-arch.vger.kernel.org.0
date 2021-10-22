Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2224379CF
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhJVP0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhJVP0o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45810C061764;
        Fri, 22 Oct 2021 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=S1GzPS9pdvUCsR3HRbmOkD1RH5st22K2sjTa/Fe9XSA=; b=BcIO2UKqhYe9PM4dfjyCzjuVet
        Ftl6gzclHdNQ7i1Z5eRHsJHF1vKIOuqP9tQXPK1v4Ja7WaBq7X35hwVCh53DTllaf3Ocx8lANNWwR
        dY6vwXnC/KzGpBmpAkYYTz14kaQTfO+atQQKxrGt6oAbKJrVKZt7bsn6Y5yUhsbWOKBFvj6KmmpQK
        kRREIokOmSeOb14NA60njPgNQmXVd2Rcn/OwPTmodeLUJDTvNS4wYf9iFxt2g1g+CCELU0hHrv46C
        HdP/+Bjvu6oveFf6883cIAcFQFR31MUtBl5BjXS+QrR8Z6AIBKwBWPKtSwO1fTBYiVQM7risOZbff
        TXjteb2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00BbM1-5F; Fri, 22 Oct 2021 15:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C042300792;
        Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6F5182C0CA17F; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.356586621@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 4/7] arch: Make ARCH_STACKWALK independent of STACKTRACE
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make arch_stack_walk() available for ARCH_STACKWALK architectures
without it being entangled in STACKTRACE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/kernel/stacktrace.c   |    2 --
 arch/arm64/kernel/stacktrace.c |    4 ----
 arch/powerpc/kernel/Makefile   |    3 +--
 arch/riscv/kernel/stacktrace.c |    4 ----
 arch/s390/kernel/Makefile      |    3 +--
 arch/x86/kernel/Makefile       |    2 +-
 include/linux/stacktrace.h     |   33 +++++++++++++++++----------------
 7 files changed, 20 insertions(+), 31 deletions(-)

--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -87,7 +87,6 @@ void notrace walk_stackframe(struct stac
 }
 EXPORT_SYMBOL(walk_stackframe);
 
-#ifdef CONFIG_STACKTRACE
 noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 				      void *cookie, struct task_struct *task,
 				      struct pt_regs *regs)
@@ -113,4 +112,3 @@ noinline notrace void arch_stack_walk(st
 			break;
 	}
 }
-#endif
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -216,8 +216,6 @@ void show_stack(struct task_struct *tsk,
 	barrier();
 }
 
-#ifdef CONFIG_STACKTRACE
-
 noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 			      void *cookie, struct task_struct *task,
 			      struct pt_regs *regs)
@@ -236,5 +234,3 @@ noinline notrace void arch_stack_walk(st
 
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
-
-#endif
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -47,7 +47,7 @@ obj-y				:= cputable.o syscalls.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o firmware.o \
 				   hw_breakpoint_constraints.o interrupt.o \
-				   kdebugfs.o
+				   kdebugfs.o stacktrace.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o \
 				   paca.o nvram_64.o note.o
@@ -116,7 +116,6 @@ obj-$(CONFIG_OPTPROBES)		+= optprobes.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 obj-$(CONFIG_ARCH_HAS_DMA_SET_MASK) += dma-mask.o
 
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -139,12 +139,8 @@ unsigned long __get_wchan(struct task_st
 	return pc;
 }
 
-#ifdef CONFIG_STACKTRACE
-
 noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
 	walk_stackframe(task, regs, consume_entry, cookie);
 }
-
-#endif /* CONFIG_STACKTRACE */
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -40,7 +40,7 @@ obj-y	+= sysinfo.o lgr.o os_info.o machi
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
-obj-y	+= smp.o text_amode31.o
+obj-y	+= smp.o text_amode31.o stacktrace.o
 
 extra-y				+= head64.o vmlinux.lds
 
@@ -55,7 +55,6 @@ compat-obj-$(CONFIG_AUDIT)	+= compat_aud
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
 obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_KPROBES)		+= kprobes_insn_page.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-y				+= stacktrace.o
 obj-y				+= cpu/
 obj-y				+= acpi/
 obj-y				+= reboot.o
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -8,21 +8,6 @@
 struct task_struct;
 struct pt_regs;
 
-#ifdef CONFIG_STACKTRACE
-void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
-		       int spaces);
-int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
-			unsigned int nr_entries, int spaces);
-unsigned int stack_trace_save(unsigned long *store, unsigned int size,
-			      unsigned int skipnr);
-unsigned int stack_trace_save_tsk(struct task_struct *task,
-				  unsigned long *store, unsigned int size,
-				  unsigned int skipnr);
-unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
-				   unsigned int size, unsigned int skipnr);
-unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
-
-/* Internal interfaces. Do not use in generic code */
 #ifdef CONFIG_ARCH_STACKWALK
 
 /**
@@ -75,8 +60,24 @@ int arch_stack_walk_reliable(stack_trace
 
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
+#endif /* CONFIG_ARCH_STACKWALK */
 
-#else /* CONFIG_ARCH_STACKWALK */
+#ifdef CONFIG_STACKTRACE
+void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
+		       int spaces);
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
+			unsigned int nr_entries, int spaces);
+unsigned int stack_trace_save(unsigned long *store, unsigned int size,
+			      unsigned int skipnr);
+unsigned int stack_trace_save_tsk(struct task_struct *task,
+				  unsigned long *store, unsigned int size,
+				  unsigned int skipnr);
+unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
+				   unsigned int size, unsigned int skipnr);
+unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
+
+#ifndef CONFIG_ARCH_STACKWALK
+/* Internal interfaces. Do not use in generic code */
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;


