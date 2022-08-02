Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ACB5876CA
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 07:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiHBFia (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiHBFi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 01:38:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1001B41D2D;
        Mon,  1 Aug 2022 22:38:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxoM5KuOhiZCABAA--.2520S4;
        Tue, 02 Aug 2022 13:38:21 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v3 2/4] LoongArch: Add prologue unwinder support
Date:   Tue,  2 Aug 2022 13:38:16 +0800
Message-Id: <20220802053818.18051-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220802053818.18051-1-zhangqing@loongson.cn>
References: <20220802053818.18051-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxoM5KuOhiZCABAA--.2520S4
X-Coremail-Antispam: 1UD129KBjvJXoW3XF15Cw4kGFWDGrW8AF1UZFb_yoWDJrW5pr
        ZxCr95Gr48Wrnagr9rXrs5urs5Grs29r12gFZxJr1rCF17XryxWrnYk34qvF4DJ3ykWr10
        qFs5ArWagF4UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjfUUQ6pDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It unwind the stack frame based on prologue code analyze.
CONFIG_KALLSYMS is needed, at least the address and length
of each function.

Three stages when we do unwind,
  1) unwind_start(), the prapare of unwinding, fill unwind_state.
  2) unwind_done(), judge whether the unwind process is finished or not.
  3) unwind_next_frame(), unwind the next frame.

Dividing unwinder helps to add new unwinders in the future, eg:
unwind_frame, unwind_orc .etc

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig.debug            |  19 +++
 arch/loongarch/include/asm/inst.h       |  52 +++++++
 arch/loongarch/include/asm/unwind.h     |  12 +-
 arch/loongarch/kernel/Makefile          |   1 +
 arch/loongarch/kernel/traps.c           |   3 +
 arch/loongarch/kernel/unwind_prologue.c | 172 ++++++++++++++++++++++++
 6 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c

diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
index 68634d4fa27b..57cdbe0cfd98 100644
--- a/arch/loongarch/Kconfig.debug
+++ b/arch/loongarch/Kconfig.debug
@@ -1,3 +1,11 @@
+choice
+	prompt "Choose kernel unwinder"
+	default UNWINDER_PROLOGUE if KALLSYMS
+	help
+	  This determines which method will be used for unwinding kernel stack
+	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
+	  lockdep, and more.
+
 config UNWINDER_GUESS
 	bool "Guess unwinder"
 	help
@@ -7,3 +15,14 @@ config UNWINDER_GUESS
 
 	  While this option often produces false positives, it can still be
 	  useful in many cases.
+
+config UNWINDER_PROLOGUE
+	bool "Prologue unwinder"
+	depends on KALLSYMS
+	help
+	  This option enables the "prologue" unwinder for unwinding kernel stack
+	  traces.  It unwind the stack frame based on prologue code analyze.  Symbol
+	  information is needed, at least the address and length of each function.
+	  Some of the addresses it reports may be incorrect.
+
+endchoice
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 575d1bb66ffb..b876907ca65a 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -23,12 +23,33 @@ enum reg1i20_op {
 	lu32id_op	= 0x0b,
 };
 
+enum reg1i21_op {
+	beqz_op		= 0x10,
+	bnez_op		= 0x11,
+};
+
 enum reg2i12_op {
+	addiw_op	= 0x0a,
+	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
+	ldb_op		= 0xa0,
+	ldh_op		= 0xa1,
+	ldw_op		= 0xa2,
+	ldd_op		= 0xa3,
+	stb_op		= 0xa4,
+	sth_op		= 0xa5,
+	stw_op		= 0xa6,
+	std_op		= 0xa7,
 };
 
 enum reg2i16_op {
 	jirl_op		= 0x13,
+	beq_op		= 0x16,
+	bne_op		= 0x17,
+	blt_op		= 0x18,
+	bge_op		= 0x19,
+	bltu_op		= 0x1a,
+	bgeu_op		= 0x1b,
 };
 
 struct reg0i26_format {
@@ -110,6 +131,37 @@ enum loongarch_gpr {
 	LOONGARCH_GPR_MAX
 };
 
+#define is_imm12_negative(val)	is_imm_negative(val, 12)
+
+static inline bool is_imm_negative(unsigned long val, unsigned int bit)
+{
+	return val & (1UL << (bit - 1));
+}
+
+static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
+{
+	/* addi.d $sp, $sp, -imm */
+	return ip->reg2i12_format.opcode == addid_op &&
+		ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
+		ip->reg2i12_format.rd == LOONGARCH_GPR_SP &&
+		is_imm12_negative(ip->reg2i12_format.immediate);
+}
+
+static inline bool is_ra_save_ins(union loongarch_instruction *ip)
+{
+	/* st.d $ra, $sp, offset */
+	return ip->reg2i12_format.opcode == std_op &&
+		ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
+		ip->reg2i12_format.rd == LOONGARCH_GPR_RA &&
+		!is_imm12_negative(ip->reg2i12_format.immediate);
+}
+
+static inline bool is_branch_insn(union loongarch_instruction insn)
+{
+	return insn.reg1i21_format.opcode >= beqz_op &&
+		insn.reg1i21_format.opcode <= bgeu_op;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 243330b39d0d..67e542e136af 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -11,10 +11,20 @@
 
 #include <asm/stacktrace.h>
 
+enum unwinder_type {
+	UNWINDER_GUESS,
+	UNWINDER_PROLOGURE,
+};
+
 struct unwind_state {
+	/*
+	 * UNWINDER_PROLOGURE is the prologue analysis method
+	 * UNWINDER_GUESS is the way to guess.
+	 */
+	char type;
 	struct stack_info stack_info;
 	struct task_struct *task;
-	unsigned long sp, pc;
+	unsigned long sp, pc, ra;
 	bool first;
 	bool error;
 };
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c5fa4adb23b6..918600e7b30f 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -23,5 +23,6 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_NUMA)		+= numa.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
+obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index f65fdf90d29e..aa1c95aaf595 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -71,6 +71,9 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 	if (!task)
 		task = current;
 
+	if (user_mode(regs))
+		state.type = UNWINDER_GUESS;
+
 	printk("%sCall Trace:", loglvl);
 	for (unwind_start(&state, task, pregs);
 	      !unwind_done(&state); unwind_next_frame(&state)) {
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
new file mode 100644
index 000000000000..3860d17aad74
--- /dev/null
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/kallsyms.h>
+
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+#include <asm/unwind.h>
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+
+	if (unwind_done(state))
+		return 0;
+	else if (state->type)
+		return state->pc;
+	else if (state->first)
+		return state->pc;
+
+	return *(unsigned long *)(state->sp);
+
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+static bool unwind_by_prologue(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	union loongarch_instruction *ip, *ip_end;
+	unsigned long frame_size = 0, frame_ra = -1;
+	unsigned long size, offset, pc = state->pc;
+
+	if (state->sp >= info->end || state->sp < info->begin)
+		return false;
+
+	if (!kallsyms_lookup_size_offset(pc, &size, &offset))
+		return false;
+
+	ip = (union loongarch_instruction *)(pc - offset);
+	ip_end = (union loongarch_instruction *)pc;
+
+	while (ip < ip_end) {
+		if (is_stack_alloc_ins(ip)) {
+			frame_size = (1 << 12) - ip->reg2i12_format.immediate;
+			ip++;
+			break;
+		}
+		ip++;
+	}
+
+	if (!frame_size) {
+		if (state->first)
+			goto first;
+
+		return false;
+	}
+
+	while (ip < ip_end) {
+		if (is_ra_save_ins(ip)) {
+			frame_ra = ip->reg2i12_format.immediate;
+			break;
+		}
+		if (is_branch_insn(*ip))
+			break;
+		ip++;
+	}
+
+	if (frame_ra < 0) {
+		if (state->first) {
+			state->sp = state->sp + frame_size;
+			goto first;
+		}
+		return false;
+	}
+
+	if (state->first)
+		state->first = false;
+
+	state->pc = *(unsigned long *)(state->sp + frame_ra);
+	state->sp = state->sp + frame_size;
+	return !!__kernel_text_address(state->pc);
+
+first:
+	state->first = false;
+	if (state->pc == state->ra)
+		return false;
+
+	state->pc = state->ra;
+
+	return !!__kernel_text_address(state->ra);
+}
+
+static bool unwind_by_guess(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	unsigned long addr;
+
+	for (state->sp += sizeof(unsigned long);
+	     state->sp < info->end;
+	     state->sp += sizeof(unsigned long)) {
+		addr = *(unsigned long *)(state->sp);
+		if (__kernel_text_address(addr))
+			return true;
+	}
+
+	return false;
+}
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs)
+{
+	memset(state, 0, sizeof(*state));
+
+	if (__kernel_text_address(regs->csr_era))
+		state->type = UNWINDER_PROLOGURE;
+
+	state->task = task;
+	state->pc = regs->csr_era;
+	state->sp = regs->regs[3];
+	state->ra = regs->regs[1];
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
+	struct pt_regs *regs;
+	unsigned long pc;
+
+	if (unwind_done(state))
+		return false;
+
+	do {
+		if (state->type) {
+			if (unwind_by_prologue(state))
+				return true;
+
+			if (info->type == STACK_TYPE_IRQ &&
+				info->end == state->sp) {
+				regs = (struct pt_regs *)info->next_sp;
+				pc = regs->csr_era;
+				if (user_mode(regs) || !__kernel_text_address(pc))
+					return false;
+
+				state->pc = pc;
+				state->sp = regs->regs[3];
+				state->ra = regs->regs[1];
+				state->first = true;
+				get_stack_info(state->sp, state->task, info);
+
+				return true;
+			}
+		} else {
+			if (state->first)
+				state->first = false;
+			else if (unwind_by_guess(state))
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

