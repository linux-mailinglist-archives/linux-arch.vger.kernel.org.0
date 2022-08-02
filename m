Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764CC5876CB
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiHBFib (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 01:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHBFi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 01:38:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8F183DF1B;
        Mon,  1 Aug 2022 22:38:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxoM5KuOhiZCABAA--.2520S3;
        Tue, 02 Aug 2022 13:38:20 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v3 1/4] LoongArch: Add guess unwinder support
Date:   Tue,  2 Aug 2022 13:38:15 +0800
Message-Id: <20220802053818.18051-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220802053818.18051-1-zhangqing@loongson.cn>
References: <20220802053818.18051-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxoM5KuOhiZCABAA--.2520S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1xAFyrXw4rZF4Dur1xKrg_yoWfCr1UpF
        95C3Z3GrW5G34Igr9xXr18Zrn8Gr4kCw12gF9xtFyFkF12qFyfXrnaya4DZFs8J3ykW3WI
        gF95Krs8Ka1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjfU86pBDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Name "guess unwinder" comes from x86, It scans the stack and reports
every kernel text address it finds.

Three stages when we do unwind,
  1) unwind_start(), the prapare of unwinding, fill unwind_state.
  2) unwind_done(), judge whether the unwind process is finished or not.
  3) unwind_next_frame(), unwind the next frame.

Make the dump_stack process go through unwind process.
Add get_stack_info() to get stack info. At present we have irq stack and
task stack. Maybe add another type in future. The next_sp means the key
info between this type stack and next type stack.

Dividing unwinder helps to add new unwinders in the future.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig.debug            |  9 ++++
 arch/loongarch/include/asm/stacktrace.h | 17 +++++++
 arch/loongarch/include/asm/unwind.h     | 37 ++++++++++++++
 arch/loongarch/kernel/Makefile          |  2 +
 arch/loongarch/kernel/process.c         | 61 +++++++++++++++++++++++
 arch/loongarch/kernel/traps.c           | 21 ++++----
 arch/loongarch/kernel/unwind_guess.c    | 65 +++++++++++++++++++++++++
 7 files changed, 201 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/include/asm/unwind.h
 create mode 100644 arch/loongarch/kernel/unwind_guess.c

diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
index e69de29bb2d1..68634d4fa27b 100644
--- a/arch/loongarch/Kconfig.debug
+++ b/arch/loongarch/Kconfig.debug
@@ -0,0 +1,9 @@
+config UNWINDER_GUESS
+	bool "Guess unwinder"
+	help
+	  This option enables the "guess" unwinder for unwinding kernel stack
+	  traces.  It scans the stack and reports every kernel text address it
+	  finds.  Some of the addresses it reports may be incorrect.
+
+	  While this option often produces false positives, it can still be
+	  useful in many cases.
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index 6b5c2a7aa706..49cb89213aeb 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -10,6 +10,23 @@
 #include <asm/loongarch.h>
 #include <linux/stringify.h>
 
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+};
+
+struct stack_info {
+	enum stack_type type;
+	unsigned long begin, end, next_sp;
+};
+
+bool in_task_stack(unsigned long stack, struct task_struct *task,
+			struct stack_info *info);
+bool in_irq_stack(unsigned long stack, struct stack_info *info);
+int get_stack_info(unsigned long stack, struct task_struct *task,
+			struct stack_info *info);
+
 #define STR_LONG_L    __stringify(LONG_L)
 #define STR_LONG_S    __stringify(LONG_S)
 #define STR_LONGSIZE  __stringify(LONGSIZE)
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
new file mode 100644
index 000000000000..243330b39d0d
--- /dev/null
+++ b/arch/loongarch/include/asm/unwind.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Most of this ideas comes from x86.
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_UNWIND_H
+#define _ASM_UNWIND_H
+
+#include <linux/sched.h>
+
+#include <asm/stacktrace.h>
+
+struct unwind_state {
+	struct stack_info stack_info;
+	struct task_struct *task;
+	unsigned long sp, pc;
+	bool first;
+	bool error;
+};
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		      struct pt_regs *regs);
+bool unwind_next_frame(struct unwind_state *state);
+unsigned long unwind_get_return_address(struct unwind_state *state);
+
+static inline bool unwind_done(struct unwind_state *state)
+{
+	return state->stack_info.type == STACK_TYPE_UNKNOWN;
+}
+
+static inline bool unwind_error(struct unwind_state *state)
+{
+	return state->error;
+}
+
+#endif /* _ASM_UNWIND_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 940de9173542..c5fa4adb23b6 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -22,4 +22,6 @@ obj-$(CONFIG_SMP)		+= smp.o
 
 obj-$(CONFIG_NUMA)		+= numa.o
 
+obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index bfa0dfe8b7d7..709b7a1664f8 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -44,6 +44,7 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/reg.h>
+#include <asm/unwind.h>
 #include <asm/vdso.h>
 
 /*
@@ -183,6 +184,66 @@ unsigned long __get_wchan(struct task_struct *task)
 	return 0;
 }
 
+bool in_task_stack(unsigned long stack, struct task_struct *task,
+			struct stack_info *info)
+{
+	unsigned long begin = (unsigned long)task_stack_page(task);
+	unsigned long end = begin + THREAD_SIZE - 32;
+
+	if (stack < begin || stack >= end)
+		return false;
+
+	info->type = STACK_TYPE_TASK;
+	info->begin = begin;
+	info->end = end;
+	info->next_sp = 0;
+
+	return true;
+}
+
+bool in_irq_stack(unsigned long stack, struct stack_info *info)
+{
+	unsigned long nextsp;
+	unsigned long begin = (unsigned long)this_cpu_read(irq_stack);
+	unsigned long end = begin + IRQ_STACK_START;
+
+	if (stack < begin || stack >= end)
+		return false;
+
+	nextsp = *(unsigned long *)end;
+	if (nextsp & (SZREG - 1))
+		return false;
+
+	info->type = STACK_TYPE_IRQ;
+	info->begin = begin;
+	info->end = end;
+	info->next_sp = nextsp;
+
+	return true;
+}
+
+int get_stack_info(unsigned long stack, struct task_struct *task,
+		   struct stack_info *info)
+{
+	task = task ? : current;
+
+	if (!stack || stack & (SZREG - 1))
+		goto unknown;
+
+	if (in_task_stack(stack, task, info))
+		return 0;
+
+	if (task != current)
+		goto unknown;
+
+	if (in_irq_stack(stack, info))
+		return 0;
+
+unknown:
+	info->type = STACK_TYPE_UNKNOWN;
+	return -EINVAL;
+}
+
 unsigned long stack_top(void)
 {
 	unsigned long top = TASK_SIZE & PAGE_MASK;
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 1bf58c65e2bf..f65fdf90d29e 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -43,6 +43,7 @@
 #include <asm/stacktrace.h>
 #include <asm/tlb.h>
 #include <asm/types.h>
+#include <asm/unwind.h>
 
 #include "access-helper.h"
 
@@ -64,19 +65,17 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 			   const char *loglvl, bool user)
 {
 	unsigned long addr;
-	unsigned long *sp = (unsigned long *)(regs->regs[3] & ~3);
+	struct unwind_state state;
+	struct pt_regs *pregs = (struct pt_regs *)regs;
+
+	if (!task)
+		task = current;
 
 	printk("%sCall Trace:", loglvl);
-#ifdef CONFIG_KALLSYMS
-	printk("%s\n", loglvl);
-#endif
-	while (!kstack_end(sp)) {
-		if (__get_addr(&addr, sp++, user)) {
-			printk("%s (Bad stack address)", loglvl);
-			break;
-		}
-		if (__kernel_text_address(addr))
-			print_ip_sym(loglvl, addr);
+	for (unwind_start(&state, task, pregs);
+	      !unwind_done(&state); unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		print_ip_sym(loglvl, addr);
 	}
 	printk("%s\n", loglvl);
 }
diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
new file mode 100644
index 000000000000..71bad8a345a7
--- /dev/null
+++ b/arch/loongarch/kernel/unwind_guess.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+
+#include <asm/unwind.h>
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+	if (unwind_done(state))
+		return 0;
+	else if (state->first)
+		return state->pc;
+
+	return *(unsigned long *)(state->sp);
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs)
+{
+	memset(state, 0, sizeof(*state));
+
+	state->task = task;
+
+	state->sp = regs->regs[3];
+	state->pc = regs->csr_era;
+	state->first = true;
+
+	get_stack_info(state->sp, state->task, &state->stack_info);
+
+	if (!unwind_done(state) && !__kernel_text_address(state->pc))
+		unwind_next_frame(state);
+}
+EXPORT_SYMBOL_GPL(unwind_start);
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	unsigned long addr;
+
+	if (unwind_done(state))
+		return false;
+
+	if (state->first)
+		state->first = false;
+
+	do {
+		for (state->sp += sizeof(unsigned long);
+		     state->sp < info->end;
+		     state->sp += sizeof(unsigned long)) {
+			addr = *(unsigned long *)(state->sp);
+
+			if (__kernel_text_address(addr))
+				return true;
+		}
+
+		state->sp = info->next_sp;
+
+	} while (!get_stack_info(state->sp, state->task, info));
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(unwind_next_frame);
-- 
2.20.1

