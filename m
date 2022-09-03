Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E85ABFD7
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiICQii (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiICQid (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 12:38:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60185543F4;
        Sat,  3 Sep 2022 09:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13FDBB80B0F;
        Sat,  3 Sep 2022 16:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE90C433D6;
        Sat,  3 Sep 2022 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662223108;
        bh=r+/B4y7/2Ycs9FH3YAlRj9b9rkR7ki0cuEuVaBBj208=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPovO0k6S6QfV4mX+kQwNVjRpeUbiim5XRq8Gucu4SVe55FY0LFgyXjLjOs4VpPAy
         DXSRjsMIQO6O+5O6hyPNfT9WEUpjuHQtMf7STEwARMAJYOb/efNWGE4XOyJCyErNbn
         b1BA7OlRjpJYsWl6woVLfFb9x0A4JqvoPYYICggcVviTW5e8ePSkW0+vPAxwhpZt6A
         g7AyB+FeFm0ueLdydHdGC+iQNS2eLaYkRQ0wd1g1eVU8K6VM6Can+VSdVWGAzpI8i+
         W9NiEMOwf2zrSj/3eOWFFflQPhXojNg72TXHdsUDL5TA9T7eLewEeacrNGXwr9xiCP
         rVsBQyrBGTfUg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Sat,  3 Sep 2022 12:38:07 -0400
Message-Id: <20220903163808.1954131-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220903163808.1954131-1-guoren@kernel.org>
References: <20220903163808.1954131-1-guoren@kernel.org>
MIME-Version: 1.0
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
It is also compatible with VMAP_STACK by implementing
arch_alloc_vmap_stack.  Many architectures have supported
HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                   |  8 +++++
 arch/riscv/include/asm/irq.h         |  2 ++
 arch/riscv/include/asm/thread_info.h |  2 ++
 arch/riscv/include/asm/vmap_stack.h  | 28 ++++++++++++++++
 arch/riscv/kernel/entry.S            | 27 ++++++++++++++++
 arch/riscv/kernel/irq.c              | 48 ++++++++++++++++++++++++++--
 6 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/vmap_stack.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a07bb3b73b5b..a8a12b4ba1a9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -433,6 +433,14 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config IRQ_STACKS
+	bool "Independent irq stacks"
+	default y
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	help
+	  Add independent irq stacks for percpu to prevent kernel stack overflows.
+	  We may save some memory footprint by disabling IRQ_STACKS.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..4579777a49f7 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -13,5 +13,7 @@
 #include <asm-generic/irq.h>
 
 extern void __init init_IRQ(void);
+extern asmlinkage void call_on_stack(struct pt_regs *regs, ulong *sp,
+				     void (*fn)(struct pt_regs *), ulong tmp);
 
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
index 5f49517cd3a2..551ce4c25698 100644
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
+	la	a3, IRQ_STACK_SIZE
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
index 24c2e1bd756a..eec5c38100b6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,6 +10,37 @@
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
+#include <asm/vmap_stack.h>
+
+#ifdef CONFIG_IRQ_STACKS
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
+asmlinkage void noinstr handle_riscv_irq(struct pt_regs *regs)
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

