Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A945BBED6
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIRPya (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIRPxn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:53:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE941F622;
        Sun, 18 Sep 2022 08:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7264B81054;
        Sun, 18 Sep 2022 15:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA3C433D6;
        Sun, 18 Sep 2022 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663516418;
        bh=N89srr0KL4e++biMLedKPeyLRsixVNfmbgWLOcpNJRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sza6zjPanI+/p6LMGy466J+zypyruukIxHPuk+Gjev1G1LapelHi4Pa9Sd3IAl3nm
         wODZi7J2F3QZKcWsaMVkkjEvKpZe+MUm99Ntv13Bd20RxmdItvY0DCEG4YA+z9foDw
         O7137uEOiyYfB4xhEx5hnomxXbPubBoRbFBTXLe9X7BEeGcBFDCWBapA10fQpVlFYF
         +13Zwq7ny3MN/T3UzOnuEo8v9VNLpiS64hvHlLss6uKftFWxPqIoUtUhD91mR8/NKO
         aGpnkpFXTZ/6yMIlea3vKT0712MapomviVoFFekZWv6FPuLfZOr5Cgu4Z6O4nDwGQO
         tVELXPioDk7OA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Sun, 18 Sep 2022 11:52:43 -0400
Message-Id: <20220918155246.1203293-9-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220918155246.1203293-1-guoren@kernel.org>
References: <20220918155246.1203293-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add independent irq stacks for percpu to prevent kernel stack overflows.
It is also compatible with VMAP_STACK by implementing
arch_alloc_vmap_stack.  Many architectures have supported
HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                   |  8 +++++
 arch/riscv/include/asm/irq.h         |  3 ++
 arch/riscv/include/asm/thread_info.h |  2 ++
 arch/riscv/include/asm/vmap_stack.h  | 28 ++++++++++++++++
 arch/riscv/kernel/entry.S            | 27 ++++++++++++++++
 arch/riscv/kernel/irq.c              | 48 ++++++++++++++++++++++++++--
 6 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/vmap_stack.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a07bb3b73b5b..75db47a983f2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -433,6 +433,14 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config IRQ_STACKS
+	bool "Independent irq stacks" if EXPERT
+	default y
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	help
+	  Add independent irq stacks for percpu to prevent kernel stack overflows.
+	  We may save some memory footprint by disabling IRQ_STACKS.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..205e1c693dfd 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -13,5 +13,8 @@
 #include <asm-generic/irq.h>
 
 extern void __init init_IRQ(void);
+asmlinkage void call_on_stack(struct pt_regs *regs, ulong *sp,
+				     void (*fn)(struct pt_regs *), ulong tmp);
+asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs);
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 7de4fb96f0b5..043da8ccc7e6 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -40,6 +40,8 @@
 #define OVERFLOW_STACK_SIZE     SZ_4K
 #define SHADOW_OVERFLOW_STACK_SIZE (1024)
 
+#define IRQ_STACK_SIZE		THREAD_SIZE
+
 #ifndef __ASSEMBLY__
 
 extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
diff --git a/arch/riscv/include/asm/vmap_stack.h b/arch/riscv/include/asm/vmap_stack.h
new file mode 100644
index 000000000000..3fbf481abf4f
--- /dev/null
+++ b/arch/riscv/include/asm/vmap_stack.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copied from arch/arm64/include/asm/vmap_stack.h.
+#ifndef _ASM_RISCV_VMAP_STACK_H
+#define _ASM_RISCV_VMAP_STACK_H
+
+#include <linux/bug.h>
+#include <linux/gfp.h>
+#include <linux/kconfig.h>
+#include <linux/vmalloc.h>
+#include <linux/pgtable.h>
+#include <asm/thread_info.h>
+
+/*
+ * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
+ * stacks need to have the same alignment.
+ */
+static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
+{
+	void *p;
+
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
+
+	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+			__builtin_return_address(0));
+	return kasan_reset_tag(p);
+}
+
+#endif /* _ASM_RISCV_VMAP_STACK_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 5f49517cd3a2..426529b84db0 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -332,6 +332,33 @@ ENTRY(ret_from_kernel_thread)
 	tail syscall_exit_to_user_mode
 ENDPROC(ret_from_kernel_thread)
 
+#ifdef CONFIG_IRQ_STACKS
+ENTRY(call_on_stack)
+	/* Create a frame record to save our ra and fp */
+	addi	sp, sp, -RISCV_SZPTR
+	REG_S	ra, (sp)
+	addi	sp, sp, -RISCV_SZPTR
+	REG_S	fp, (sp)
+
+	/* Save sp in fp */
+	move	fp, sp
+
+	/* Move to the new stack and call the function there */
+	li	a3, IRQ_STACK_SIZE
+	add	sp, a1, a3
+	jalr	a2
+
+	/*
+	 * Restore sp from prev fp, and fp, ra from the frame
+	 */
+	move	sp, fp
+	REG_L	fp, (sp)
+	addi	sp, sp, RISCV_SZPTR
+	REG_L	ra, (sp)
+	addi	sp, sp, RISCV_SZPTR
+	ret
+ENDPROC(call_on_stack)
+#endif
 
 /*
  * Integer register context switch
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 24c2e1bd756a..5ad4952203c5 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,6 +10,37 @@
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
+#include <asm/vmap_stack.h>
+
+#ifdef CONFIG_IRQ_STACKS
+static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
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
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
@@ -19,21 +50,34 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void __init init_IRQ(void)
 {
+	init_irq_stacks();
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
 
-asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
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
+asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+#ifdef CONFIG_IRQ_STACKS
+	ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
+
+	if (on_thread_stack())
+		call_on_stack(regs, sp, handle_riscv_irq, 0);
+	else
+#endif
+		handle_riscv_irq(regs);
 
 	irqentry_exit(regs, state);
 }
-- 
2.36.1

