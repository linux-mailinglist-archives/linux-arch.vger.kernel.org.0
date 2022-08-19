Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95D95996D3
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbiHSIOX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347150AbiHSIOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:14:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F4758DFB;
        Fri, 19 Aug 2022 01:14:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+BLRv9i9I0EAA--.22658S5;
        Fri, 19 Aug 2022 16:14:08 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 3/9] LoongArch/ftrace: Add dynamic function tracer support
Date:   Fri, 19 Aug 2022 16:13:57 +0800
Message-Id: <20220819081403.7143-4-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819081403.7143-1-zhangqing@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+BLRv9i9I0EAA--.22658S5
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr4DKr1rKryDZry3KryDZFb_yoW8Gw4xuo
        WY93Wjvr4rGFWI9w4Yk3y5WFWUXry0krZ0y34Syr45uF40yry3Xr13Ca15Ka43Jr95Jr4f
        CF93uF48Aa47Xr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOw7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
        kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
        jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjfU0a9aDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compiler has inserted 2 NOPs before the regular function prologue.
T series registers are available and safe because of LoongArch psABI.

At runtime, replace nop with bl to enable ftrace call and replace bl with
nop to disable ftrace call. The bl requires us to save the original RA value,
so here it saves RA at t0.
details are:

| Compiled   |       Disabled         |        Enabled         |
+------------+------------------------+------------------------+
| nop        | move     t0, ra        | move     t0, ra        |
| nop        | nop                    | bl      ftrace_caller  |
| func_body  | func_body              | func_body              |

The RA value will be recovered by ftrace_regs_entry, and restored into RA
before returning to the regular function prologue. When a function is not
being traced, the move t0, ra is not harmful.

1) ftrace_make_call, ftrace_make_nop (in kernel/ftrace.c)
   The two functions turn each recorded call site of filtered functions
   into a call to ftrace_caller or nops.

2) ftracce_update_ftrace_func (in kernel/ftrace.c)
   turns the nops at ftrace_call into a call to a generic entry for
   function tracers.

3) ftrace_caller (in kernel/mcount-dyn.S)
   The entry where each _mcount call sites calls to once they are
   filtered to be traced.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |   1 +
 arch/loongarch/include/asm/ftrace.h |  16 ++++
 arch/loongarch/include/asm/inst.h   |  33 +++++++++
 arch/loongarch/kernel/Makefile      |   5 ++
 arch/loongarch/kernel/entry_dyn.S   |  89 ++++++++++++++++++++++
 arch/loongarch/kernel/ftrace_dyn.c  | 111 ++++++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c        |  93 +++++++++++++++++++++++
 7 files changed, 348 insertions(+)
 create mode 100644 arch/loongarch/kernel/entry_dyn.S
 create mode 100644 arch/loongarch/kernel/ftrace_dyn.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4d13bac368ed..f2d4899b1a0e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -83,6 +83,7 @@ config LOONGARCH
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
+        select HAVE_DYNAMIC_FTRACE
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 6a3e76234618..76ca58767f4d 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -10,9 +10,25 @@
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
 #ifndef __ASSEMBLY__
+#ifndef CONFIG_DYNAMIC_FTRACE
 extern void _mcount(void);
 #define mcount _mcount
+#endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+
+struct dyn_ftrace;
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
+#define ftrace_init_nop ftrace_init_nop
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7b07cbb3188c..713b4996bfac 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -8,6 +8,9 @@
 #include <linux/types.h>
 #include <asm/asm.h>
 
+#define INSN_NOP 0x03400000
+#define INSN_BREAK 0x002a0000
+
 #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
 #define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
 #define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
@@ -18,6 +21,11 @@
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
 
+enum reg0i26_op {
+	b_op		= 0x14,
+	bl_op		= 0x15,
+};
+
 enum reg1i20_op {
 	lu12iw_op	= 0x0a,
 	lu32id_op	= 0x0b,
@@ -32,6 +40,7 @@ enum reg2i12_op {
 	addiw_op	= 0x0a,
 	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
+	ori_op          = 0x0e,
 	ldb_op		= 0xa0,
 	ldh_op		= 0xa1,
 	ldw_op		= 0xa2,
@@ -52,6 +61,10 @@ enum reg2i16_op {
 	bgeu_op		= 0x1b,
 };
 
+enum reg3_op {
+	or_op		= 0x2a,
+};
+
 struct reg0i26_format {
 	unsigned int immediate_h : 10;
 	unsigned int immediate_l : 16;
@@ -85,6 +98,13 @@ struct reg2i16_format {
 	unsigned int opcode : 6;
 };
 
+struct reg3_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int opcode : 17;
+};
+
 union loongarch_instruction {
 	unsigned int word;
 	struct reg0i26_format reg0i26_format;
@@ -92,6 +112,7 @@ union loongarch_instruction {
 	struct reg1i21_format reg1i21_format;
 	struct reg2i12_format reg2i12_format;
 	struct reg2i16_format reg2i16_format;
+	struct reg3_format    reg3_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
@@ -162,6 +183,18 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
 		is_imm12_negative(ip->reg2i12_format.immediate);
 }
 
+int larch_insn_read(void *addr, u32 *insnp);
+int larch_insn_write(void *addr, u32 insn);
+int larch_insn_patch_text(void *addr, u32 insn);
+
+u32 larch_insn_gen_nop(void);
+u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
+u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest);
+
+u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
+			enum loongarch_gpr rk);
+u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 0a745d24d3e5..a73599619466 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -15,8 +15,13 @@ obj-$(CONFIG_EFI) 		+= efi.o
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 
 ifdef CONFIG_FUNCTION_TRACER
+  ifndef CONFIG_DYNAMIC_FTRACE
     obj-y += mcount.o ftrace.o
     CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+  else
+    obj-y += entry_dyn.o ftrace_dyn.o
+    CFLAGS_REMOVE_ftrace_dyn.o = $(CC_FLAGS_FTRACE)
+  endif
   CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
   CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
   CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/loongarch/kernel/entry_dyn.S b/arch/loongarch/kernel/entry_dyn.S
new file mode 100644
index 000000000000..e4686e67f049
--- /dev/null
+++ b/arch/loongarch/kernel/entry_dyn.S
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/export.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/ftrace.h>
+
+	.text
+/*
+ * Due to -fpatchable-function-entry=2: the compiler inserted 2 NOPs before the
+ * regular C function prologue. When PC arrived here, the last 2 instructions
+ * as follows,
+ * 	move		t0, ra
+ * 	bl		callsite (for modules, callsite is a tramplione)
+ *
+ * modules tramplione as follows,
+ * 	addu16i.d	t1, zero, callsite[31:16]
+ * 	lu32i.d		t1, callsite[51:32]
+ * 	lu52i.d		t1, t1, callsite[63:52]
+ * 	jirl		zero, t1, callsite[15:0] >> 2
+ *
+ * See arch/loongarch/kernel/ftrace_dyn.c for details. Here, pay attention to
+ * that the T series regs are available and safe because each C functions
+ * follows the LoongArch psABI well.
+ */
+
+	.macro  ftrace_regs_entry
+	PTR_ADDI sp, sp, -PT_SIZE
+	/* Save trace function ra at PT_ERA */
+	PTR_S	ra, sp, PT_ERA
+	/* Save parent ra at PT_R1(RA) */
+	PTR_S	t0, sp, PT_R1
+	PTR_S	a0, sp, PT_R4
+	PTR_S	a1, sp, PT_R5
+	PTR_S	a2, sp, PT_R6
+	PTR_S	a3, sp, PT_R7
+	PTR_S	a4, sp, PT_R8
+	PTR_S	a5, sp, PT_R9
+	PTR_S	a6, sp, PT_R10
+	PTR_S	a7, sp, PT_R11
+	PTR_S	fp, sp, PT_R22
+
+	PTR_ADDI t8, sp, PT_SIZE
+	PTR_S   t8, sp, PT_R3
+
+	.endm
+
+SYM_CODE_START(ftrace_caller)
+	ftrace_regs_entry
+	b	ftrace_common
+SYM_CODE_END(ftrace_caller)
+
+SYM_CODE_START(ftrace_common)
+	PTR_ADDI	a0, ra, -8	/* arg0: ip */
+	move		a1, t0		/* arg1: parent_ip */
+	la.pcrel	t1, function_trace_op
+	PTR_L		a2, t1, 0	/* arg2: op */
+	move		a3, sp		/* arg3: regs */
+	.globl ftrace_call
+ftrace_call:
+	bl		ftrace_stub
+/*
+ * As we didn't use S series regs in this assmembly code and all calls
+ * are C function which will save S series regs by themselves, there is
+ * no need to restore S series regs. The T series is available and safe
+ * at the callsite, so there is no need to restore the T series regs.
+ */
+ftrace_common_return:
+	PTR_L	a0, sp, PT_R4
+	PTR_L	a1, sp, PT_R5
+	PTR_L	a2, sp, PT_R6
+	PTR_L	a3, sp, PT_R7
+	PTR_L	a4, sp, PT_R8
+	PTR_L	a5, sp, PT_R9
+	PTR_L	a6, sp, PT_R10
+	PTR_L	a7, sp, PT_R11
+	PTR_L	fp, sp, PT_R22
+	PTR_L	ra, sp, PT_R1
+	PTR_L	t0, sp, PT_ERA
+	PTR_ADDI sp, sp, PT_SIZE
+	jirl	zero, t0, 0
+SYM_CODE_END(ftrace_common)
+
+SYM_FUNC_START(ftrace_stub)
+	jirl	zero, ra, 0
+SYM_FUNC_END(ftrace_stub)
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
new file mode 100644
index 000000000000..1f8955be8b64
--- /dev/null
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on arch/arm64/kernel/ftrace.c
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/ftrace.h>
+#include <linux/uaccess.h>
+
+#include <asm/inst.h>
+
+static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
+			      bool validate)
+{
+	u32 replaced;
+
+	if (validate) {
+		if (larch_insn_read((void *)pc, &replaced))
+			return -EFAULT;
+
+		if (replaced != old)
+			return -EINVAL;
+	}
+
+	if (larch_insn_patch_text((void *)pc, new))
+		return -EPERM;
+
+	return 0;
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	unsigned long pc;
+	u32 new;
+
+	pc = (unsigned long)&ftrace_call;
+	new = larch_insn_gen_bl(pc, (unsigned long)func);
+
+	return ftrace_modify_code(pc, 0, new, false);
+}
+
+/*
+ * The compiler has inserted 2 NOPs before the regular function prologue.
+ * T series registers are available and safe because of LoongArch psABI.
+ *
+ * At runtime, replace nop with bl to enable ftrace call and replace bl with
+ * nop to disable ftrace call. The bl requires us to save the original RA value,
+ * so here it saves RA at t0.
+ * details are:
+ *
+ * | Compiled   |       Disabled         |        Enabled         |
+ * +------------+------------------------+------------------------+
+ * | nop        | move     t0, ra        | move     t0, ra        |
+ * | nop        | nop                    | bl      ftrace_caller  |
+ * | func_body  | func_body              | func_body              |
+ *
+ * The RA value will be recovered by ftrace_regs_entry, and restored into RA
+ * before returning to the regular function prologue. When a function is not
+ * being traced, the move t0, ra is not harmful.
+ */
+
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip;
+	old = larch_insn_gen_nop();
+	new = larch_insn_gen_move(LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	old = larch_insn_gen_nop();
+	new = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	new = larch_insn_gen_nop();
+	old = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+void arch_ftrace_update_code(int command)
+{
+	command |= FTRACE_MAY_SLEEP;
+	ftrace_modify_all_code(command);
+}
+
+int __init ftrace_dyn_arch_init(void)
+{
+	return 0;
+}
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index b1df0ec34bd1..f2759ae9a8bd 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -2,8 +2,83 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <linux/sizes.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
 #include <asm/inst.h>
 
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
+int larch_insn_read(void *addr, u32 *insnp)
+{
+	int ret;
+	u32 val;
+
+	ret = copy_from_kernel_nofault(&val, addr, LOONGARCH_INSN_SIZE);
+	if (!ret)
+		*insnp = val;
+
+	return ret;
+}
+
+int larch_insn_write(void *addr, u32 insn)
+{
+	int ret;
+	unsigned long flags = 0;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	ret = copy_to_kernel_nofault(addr, &insn, LOONGARCH_INSN_SIZE);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
+int larch_insn_patch_text(void *addr, u32 insn)
+{
+	int ret;
+	u32 *tp = addr;
+
+	if ((unsigned long)tp & 3)
+		return -EINVAL;
+
+	ret = larch_insn_write(tp, insn);
+	if (!ret)
+		flush_icache_range((unsigned long)tp,
+				   (unsigned long)tp + LOONGARCH_INSN_SIZE);
+
+	return ret;
+}
+
+u32 larch_insn_gen_nop(void)
+{
+	return INSN_NOP;
+}
+
+u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
+{
+	unsigned int immediate_l, immediate_h;
+	union loongarch_instruction insn;
+	long offset = dest - pc;
+
+	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
+		pr_warn("The generated bl instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	offset >>= 2;
+
+	immediate_l = offset & 0xffff;
+	offset >>= 16;
+	immediate_h = offset & 0x3ff;
+
+	insn.reg0i26_format.opcode = bl_op;
+	insn.reg0i26_format.immediate_l = immediate_l;
+	insn.reg0i26_format.immediate_h = immediate_h;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
@@ -38,3 +113,21 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
 
 	return insn.word;
 }
+
+u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	union loongarch_instruction insn;
+
+	insn.reg3_format.opcode = or_op;
+	insn.reg3_format.rd = rd;
+	insn.reg3_format.rj = rj;
+	insn.reg3_format.rk = rk;
+
+	return insn.word;
+}
+
+u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj)
+{
+	return larch_insn_gen_or(rd, rj, 0);
+}
+
-- 
2.36.1

