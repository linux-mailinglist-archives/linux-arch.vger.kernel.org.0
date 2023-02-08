Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5E68F054
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBHOFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHOFn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 09:05:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11D234DA;
        Wed,  8 Feb 2023 06:05:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C493A616BE;
        Wed,  8 Feb 2023 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C6CC433EF;
        Wed,  8 Feb 2023 14:05:34 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] LoongArch: Make -mstrict-align configurable
Date:   Wed,  8 Feb 2023 22:05:36 +0800
Message-Id: <20230208140536.2911880-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
configurable.

Not all LoongArch cores support h/w unaligned access, we can use the
-mstrict-align build parameter to prevent unaligned accesses.

CPUs with h/w unaligned access support:
Loongson-2K2000/2K3000/3A5000/3C5000/3D5000.

CPUs without h/w unaligned access support:
Loongson-2K500/2K1000.

This option is enabled by default to make the kernel be able to run on
all LoongArch systems. But you can disable it manually if you want to
run kernel only on systems with h/w unaligned access support in order to
optimise for performance.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2:
1, Enabled ARCH_STRICT_ALIGN by default;
2, Keep consistency with HAVE_EFFICIENT_UNALIGNED_ACCESS;
3, Build unaligned access emulation only if ARCH_STRICT_ALIGN enabled.

 arch/loongarch/Kconfig         | 19 +++++++++++++++++++
 arch/loongarch/Makefile        |  5 +++++
 arch/loongarch/kernel/Makefile |  4 +++-
 arch/loongarch/kernel/traps.c  |  9 +++++++--
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9cc8b84f7eb0..0c1c6063cc66 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -94,6 +94,7 @@ config LOONGARCH
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
@@ -441,6 +442,24 @@ config ARCH_IOREMAP
 	  protection support. However, you can enable LoongArch DMW-based
 	  ioremap() for better performance.
 
+config ARCH_STRICT_ALIGN
+	bool "Enable -mstrict-align to prevent unaligned accesses" if EXPERT
+	default y
+	help
+	  Not all LoongArch cores support h/w unaligned access, we can use
+	  -mstrict-align build parameter to prevent unaligned accesses.
+
+	  CPUs with h/w unaligned access support:
+	  Loongson-2K2000/2K3000/3A5000/3C5000/3D5000.
+
+	  CPUs without h/w unaligned access support:
+	  Loongson-2K500/2K1000.
+
+	  This option is enabled by default to make the kernel be able to run
+	  on all LoongArch systems. But you can disable it manually if you want
+	  to run kernel only on systems with h/w unaligned access support in
+	  order to optimise for performance.
+
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4402387d2755..6e1c931a8507 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -91,10 +91,15 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
 # instead of .eh_frame so we don't discard them.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
+ifdef CONFIG_ARCH_STRICT_ALIGN
 # Don't emit unaligned accesses.
 # Not all LoongArch cores support unaligned access, and as kernel we can't
 # rely on others to provide emulation for these accesses.
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+else
+# Optimise for performance on hardware supports unaligned access.
+KBUILD_CFLAGS += $(call cc-option,-mno-strict-align)
+endif
 
 KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c8cfbd562921..df5dbabfe7a6 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,13 +8,15 @@ extra-y		:= vmlinux.lds
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
-		   alternative.o unaligned.o unwind.o
+		   alternative.o unwind.o
 
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
 
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 
+obj-$(CONFIG_ARCH_STRICT_ALIGN)	+= unaligned.o
+
 ifdef CONFIG_FUNCTION_TRACER
   ifndef CONFIG_DYNAMIC_FTRACE
     obj-y += mcount.o ftrace.o
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index c38a146a973b..05511203732c 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -371,9 +371,14 @@ int no_unaligned_warning __read_mostly = 1;	/* Only 1 warning by default */
 
 asmlinkage void noinstr do_ale(struct pt_regs *regs)
 {
-	unsigned int *pc;
 	irqentry_state_t state = irqentry_enter(regs);
 
+#ifndef CONFIG_ARCH_STRICT_ALIGN
+	die_if_kernel("Kernel ale access", regs);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
+#else
+	unsigned int *pc;
+
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
 
 	/*
@@ -397,8 +402,8 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 sigbus:
 	die_if_kernel("Kernel ale access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
-
 out:
+#endif
 	irqentry_exit(regs, state);
 }
 
-- 
2.39.0

