Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591572F1E0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 03:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbjFNBak (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjFNBai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 21:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2A1727;
        Tue, 13 Jun 2023 18:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB75638BD;
        Wed, 14 Jun 2023 01:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE05C433C0;
        Wed, 14 Jun 2023 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686706227;
        bh=azzWoVCj3Bccwg8Kywl22aCyL/uPe8mZErp3ZfcZjno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsZ2ixvW1iFZ4XPLl767dRd6H3gGLs7hjL7T0Jj7qfH+6hOZXrFzkci3A0qRDvvpg
         I+E1WoX01vbgM43oqA6nWdcY6tqCWkkBTCyopRlxNy7vW9tleuqg3UKkpKNFKwAFCz
         VbmCnwfQuXDf1QdmF6wJFQCXowOxQj8fhfrOBogwrTIJWrtaqepKUnmdFwwwbaimEE
         XL7ZNdMA75gZOIki475U/VwE00wQrG9F8sbzGYaNxUlk+nyoMjFDi94L67KLHCtBRV
         o8Mz3Q7CtN6k+e3BusfhZZUuj3+wUhKbHEqBlCMHiWosOMbN6MryEFUtwf+f80hg6t
         yYZsBhYASZhxQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        bjorn@kernel.org, cleger@rivosinc.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V13 1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Tue, 13 Jun 2023 21:30:16 -0400
Message-Id: <20230614013018.2168426-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230614013018.2168426-1-guoren@kernel.org>
References: <20230614013018.2168426-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add independent irq stacks for percpu to prevent kernel stack overflows.
It is also compatible with VMAP_STACK by arch_alloc_vmap_stack.

Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/Kconfig                   |  7 ++++++
 arch/riscv/include/asm/irq_stack.h   | 30 ++++++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h |  2 ++
 arch/riscv/kernel/irq.c              | 33 ++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c            | 35 ++++++++++++++++++++++++++--
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_stack.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a3d54cd14fca..a8368fe7be14 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -590,6 +590,13 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config IRQ_STACKS
+	bool "Independent irq stacks" if EXPERT
+	default y
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	help
+	  Add independent irq stacks for percpu to prevent kernel stack overflows.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/irq_stack.h
new file mode 100644
index 000000000000..e4042d297580
--- /dev/null
+++ b/arch/riscv/include/asm/irq_stack.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_IRQ_STACK_H
+#define _ASM_RISCV_IRQ_STACK_H
+
+#include <linux/bug.h>
+#include <linux/gfp.h>
+#include <linux/kconfig.h>
+#include <linux/vmalloc.h>
+#include <linux/pgtable.h>
+#include <asm/thread_info.h>
+
+DECLARE_PER_CPU(ulong *, irq_stack_ptr);
+
+#ifdef CONFIG_VMAP_STACK
+/*
+ * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
+ * stacks need to have the same alignment.
+ */
+static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
+{
+	void *p;
+
+	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+			__builtin_return_address(0));
+	return kasan_reset_tag(p);
+}
+#endif /* CONFIG_VMAP_STACK */
+
+#endif /* _ASM_RISCV_IRQ_STACK_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 97e6f65ec176..2f32875276b0 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -40,6 +40,8 @@
 #define OVERFLOW_STACK_SIZE     SZ_4K
 #define SHADOW_OVERFLOW_STACK_SIZE (1024)
 
+#define IRQ_STACK_SIZE		THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 
 extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index eb9a68a539e6..a1dcf8e43b3c 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -28,6 +28,38 @@ struct fwnode_handle *riscv_get_intc_hwnode(void)
 }
 EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
 
+#ifdef CONFIG_IRQ_STACKS
+#include <asm/irq_stack.h>
+
+DEFINE_PER_CPU(ulong *, irq_stack_ptr);
+
+#ifdef CONFIG_VMAP_STACK
+static void init_irq_stacks(void)
+{
+	int cpu;
+	ulong *p;
+
+	for_each_possible_cpu(cpu) {
+		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
+		per_cpu(irq_stack_ptr, cpu) = p;
+	}
+}
+#else
+/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
+DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack);
+
+static void init_irq_stacks(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
+}
+#endif /* CONFIG_VMAP_STACK */
+#else
+static void init_irq_stacks(void) {}
+#endif /* CONFIG_IRQ_STACKS */
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_stats(p, prec);
@@ -36,6 +68,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void __init init_IRQ(void)
 {
+	init_irq_stacks();
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05ffdcd1424e..5158961ea977 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -27,6 +27,7 @@
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/vector.h>
+#include <asm/irq_stack.h>
 
 int show_unhandled_signals = 1;
 
@@ -327,16 +328,46 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 }
 #endif
 
-asmlinkage __visible noinstr void do_irq(struct pt_regs *regs)
+static void noinstr handle_riscv_irq(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	irqentry_state_t state = irqentry_enter(regs);
 
 	irq_enter_rcu();
 	old_regs = set_irq_regs(regs);
 	handle_arch_irq(regs);
 	set_irq_regs(old_regs);
 	irq_exit_rcu();
+}
+
+asmlinkage void noinstr do_irq(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+#ifdef CONFIG_IRQ_STACKS
+	if (on_thread_stack()) {
+		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
+					+ IRQ_STACK_SIZE/sizeof(ulong);
+		__asm__ __volatile(
+		"addi	sp, sp, -"RISCV_SZPTR  "\n"
+		REG_S"  ra, (sp)		\n"
+		"addi	sp, sp, -"RISCV_SZPTR  "\n"
+		REG_S"  s0, (sp)		\n"
+		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
+		"move	sp, %[sp]		\n"
+		"move	a0, %[regs]		\n"
+		"call	handle_riscv_irq	\n"
+		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
+		REG_L"  s0, (sp)		\n"
+		"addi	sp, sp, "RISCV_SZPTR   "\n"
+		REG_L"  ra, (sp)		\n"
+		"addi	sp, sp, "RISCV_SZPTR   "\n"
+		:
+		: [sp] "r" (sp), [regs] "r" (regs)
+		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+		  "memory");
+	} else
+#endif
+		handle_riscv_irq(regs);
 
 	irqentry_exit(regs, state);
 }
-- 
2.36.1

