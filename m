Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E158B47B
	for <lists+linux-arch@lfdr.de>; Sat,  6 Aug 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiHFIK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Aug 2022 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiHFIKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2022 04:10:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5DDFF53;
        Sat,  6 Aug 2022 01:10:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxbyPdIe5ixooIAA--.1165S5;
        Sat, 06 Aug 2022 16:10:08 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v4 3/4] LoongArch: Add stacktrace and get_wchan support
Date:   Sat,  6 Aug 2022 16:10:04 +0800
Message-Id: <20220806081005.332-4-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220806081005.332-1-zhangqing@loongson.cn>
References: <20220806081005.332-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxbyPdIe5ixooIAA--.1165S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43tFy5Zr18WrWkGryrXrb_yoWfKr4kpF
        9rCwsrJr4jgw1I9r9xt395ur98twn2gw42gF9xta4rAF12qFyrXry8JasrZF4Yv3y8Ga1S
        qrn5K39rKan8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUBWlkUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

1. Use common arch_stack_walk infrastructure to avoid duplicated code and
avoid taking care of the stack storage and filtering.
2. Add sra (means sched return address) and scfa (means sched call
frame address) to thread_info and store it in switch_to().
3. Add get wchan implement.

Now we can print the process stack and wait channel by cat /proc/*/stack
and /proc/*/wchan.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig                 |  5 ++++
 arch/loongarch/include/asm/processor.h |  9 +++++++
 arch/loongarch/include/asm/switch_to.h | 14 ++++++----
 arch/loongarch/kernel/Makefile         |  1 +
 arch/loongarch/kernel/asm-offsets.c    |  2 ++
 arch/loongarch/kernel/process.c        | 30 ++++++++++++++++++++-
 arch/loongarch/kernel/stacktrace.c     | 37 ++++++++++++++++++++++++++
 arch/loongarch/kernel/switch.S         |  2 ++
 8 files changed, 94 insertions(+), 6 deletions(-)
 create mode 100644 arch/loongarch/kernel/stacktrace.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fc2465892a60..8143774f99cb 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -39,6 +39,7 @@ config LOONGARCH
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_STACKWALK
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
@@ -141,6 +142,10 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 # MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
 # MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
 # are shared between architectures, and specifically expecting the symbols.
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 57ec45aa078e..1c4b4308378d 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -101,6 +101,10 @@ struct thread_struct {
 	unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
 	unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */
 
+	/* __schedule() return address / call frame address */
+	unsigned long sched_ra;
+	unsigned long sched_cfa;
+
 	/* CSR registers */
 	unsigned long csr_prmd;
 	unsigned long csr_crmd;
@@ -129,6 +133,9 @@ struct thread_struct {
 	struct loongarch_fpu fpu FPU_ALIGN;
 };
 
+#define thread_saved_ra(tsk)	(tsk->thread.sched_ra)
+#define thread_saved_fp(tsk)	(tsk->thread.sched_cfa)
+
 #define INIT_THREAD  {						\
 	/*							\
 	 * Main processor registers				\
@@ -145,6 +152,8 @@ struct thread_struct {
 	.reg29			= 0,				\
 	.reg30			= 0,				\
 	.reg31			= 0,				\
+	.sched_ra		= 0,				\
+	.sched_cfa		= 0,				\
 	.csr_crmd		= 0,				\
 	.csr_prmd		= 0,				\
 	.csr_euen		= 0,				\
diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
index 2a8d04375574..43a5ab162d38 100644
--- a/arch/loongarch/include/asm/switch_to.h
+++ b/arch/loongarch/include/asm/switch_to.h
@@ -15,12 +15,15 @@ struct task_struct;
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
  * @next_ti:	task_thread_info(next).
+ * @sched_ra:	__schedule return address.
+ * @sched_cfa:	__schedule call frame address.
  *
  * This function is used whilst scheduling to save the context of prev & load
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
-			struct task_struct *next, struct thread_info *next_ti);
+			struct task_struct *next, struct thread_info *next_ti,
+			void *sched_ra, void *sched_cfa);
 
 /*
  * For newly created kernel threads switch_to() will return to
@@ -28,10 +31,11 @@ extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
  * That is, everything following __switch_to() will be skipped for new threads.
  * So everything that matters to new threads should be placed before __switch_to().
  */
-#define switch_to(prev, next, last)					\
-do {									\
-	lose_fpu_inatomic(1, prev);					\
-	(last) = __switch_to(prev, next, task_thread_info(next));	\
+#define switch_to(prev, next, last)						\
+do {										\
+	lose_fpu_inatomic(1, prev);						\
+	(last) = __switch_to(prev, next, task_thread_info(next),		\
+		 __builtin_return_address(0), __builtin_frame_address(0));	\
 } while (0)
 
 #endif /* _ASM_SWITCH_TO_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 918600e7b30f..7449513eb08d 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_EFI) 		+= efi.o
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
+obj-$(CONFIG_STACKTRACE)        += stacktrace.o
 
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 20cd9e16a95a..eb350f3ffae5 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -103,6 +103,8 @@ void output_thread_defines(void)
 	OFFSET(THREAD_REG29, task_struct, thread.reg29);
 	OFFSET(THREAD_REG30, task_struct, thread.reg30);
 	OFFSET(THREAD_REG31, task_struct, thread.reg31);
+	OFFSET(THREAD_SCHED_RA, task_struct, thread.sched_ra);
+	OFFSET(THREAD_SCHED_CFA, task_struct, thread.sched_cfa);
 	OFFSET(THREAD_CSRCRMD, task_struct,
 	       thread.csr_crmd);
 	OFFSET(THREAD_CSRPRMD, task_struct,
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 709b7a1664f8..d9dba725ef02 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -135,6 +135,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childregs = (struct pt_regs *) childksp - 1;
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
+	p->thread.sched_cfa = 0;
 	p->thread.csr_euen = 0;
 	p->thread.csr_crmd = csr_read32(LOONGARCH_CSR_CRMD);
 	p->thread.csr_prmd = csr_read32(LOONGARCH_CSR_PRMD);
@@ -145,6 +146,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		p->thread.reg23 = (unsigned long)args->fn;
 		p->thread.reg24 = (unsigned long)args->fn_arg;
 		p->thread.reg01 = (unsigned long)ret_from_kernel_thread;
+		p->thread.sched_ra = (unsigned long)ret_from_kernel_thread;
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->csr_euen = p->thread.csr_euen;
 		childregs->csr_crmd = p->thread.csr_crmd;
@@ -161,6 +163,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	p->thread.reg03 = (unsigned long) childregs;
 	p->thread.reg01 = (unsigned long) ret_from_fork;
+	p->thread.sched_ra = (unsigned long) ret_from_fork;
 
 	/*
 	 * New tasks lose permission to use the fpu. This accelerates context
@@ -181,9 +184,34 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 unsigned long __get_wchan(struct task_struct *task)
 {
-	return 0;
+	unsigned long pc;
+	struct unwind_state state;
+
+	if (!try_get_task_stack(task))
+		return 0;
+
+	unwind_start(&state, task, NULL);
+	state.sp = thread_saved_fp(task);
+	get_stack_info(state.sp, state.task, &state.stack_info);
+	state.pc = thread_saved_ra(task);
+#ifdef CONFIG_UNWINDER_PROLOGUE
+	state.type = UNWINDER_PROLOGUE;
+#endif
+	for ( ; !unwind_done(&state); unwind_next_frame(&state)) {
+		pc = unwind_get_return_address(&state);
+		if (!pc)
+			break;
+		if (in_sched_functions(pc))
+			continue;
+		break;
+	}
+
+	put_task_stack(task);
+
+	return pc;
 }
 
+
 bool in_task_stack(unsigned long stack, struct task_struct *task,
 			struct stack_info *info)
 {
diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
new file mode 100644
index 000000000000..f4f4b8ad3917
--- /dev/null
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stack trace management functions
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+
+#include <asm/stacktrace.h>
+#include <asm/unwind.h>
+
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
+{
+	struct pt_regs dummyregs;
+	struct unwind_state state;
+	unsigned long addr;
+
+	regs = &dummyregs;
+
+	if (task == current) {
+		regs->csr_era = (unsigned long)__builtin_return_address(0);
+		regs->regs[3] = (unsigned long)__builtin_frame_address(0);
+	} else {
+		regs->csr_era = thread_saved_ra(task);
+		regs->regs[3] = thread_saved_fp(task);
+	}
+
+	regs->regs[1] = 0;
+	for (unwind_start(&state, task, regs);
+	      !unwind_done(&state); unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || !consume_entry(cookie, addr))
+			break;
+	}
+}
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 37e84ac8ffc2..43ebbc3990f7 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -21,6 +21,8 @@ SYM_FUNC_START(__switch_to)
 
 	cpu_save_nonscratch a0
 	stptr.d	ra, a0, THREAD_REG01
+	stptr.d a3, a0, THREAD_SCHED_RA
+	stptr.d a4, a0, THREAD_SCHED_CFA
 	move	tp, a2
 	cpu_restore_nonscratch a1
 
-- 
2.20.1

