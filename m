Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452D4602A38
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJRLcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJRLcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 07:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6DBA246;
        Tue, 18 Oct 2022 04:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D628A61531;
        Tue, 18 Oct 2022 11:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68749C433D7;
        Tue, 18 Oct 2022 11:32:24 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4] LoongArch: Add unaligned access support
Date:   Tue, 18 Oct 2022 19:30:22 +0800
Message-Id: <20221018113022.3074447-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
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

Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
Loongson-3C5000) are configurable whether support unaligned access in
hardware. This patch add unaligned access emulation for those LoongArch
processors without hardware support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Simplify READ_FPR and WRITE_FPR.
V3: Cleanup unnecessary code and update documents.
V4: Refactor with switch-case and fix the fpr access bug.

 Documentation/admin-guide/sysctl/kernel.rst |   8 +-
 arch/loongarch/Kconfig                      |   2 +
 arch/loongarch/include/asm/inst.h           |  14 +
 arch/loongarch/include/asm/thread_info.h    |   2 +-
 arch/loongarch/kernel/Makefile              |   3 +-
 arch/loongarch/kernel/traps.c               |  27 ++
 arch/loongarch/kernel/unaligned.c           | 499 ++++++++++++++++++++
 arch/loongarch/lib/Makefile                 |   2 +-
 arch/loongarch/lib/unaligned.S              |  91 ++++
 9 files changed, 641 insertions(+), 7 deletions(-)
 create mode 100644 arch/loongarch/kernel/unaligned.c
 create mode 100644 arch/loongarch/lib/unaligned.S

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..f2b802cd6208 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -433,8 +433,8 @@ ignore-unaligned-usertrap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN``;
-currently, ``arc`` and ``ia64``), controls whether all unaligned traps
-are logged.
+currently, ``arc``, ``ia64`` and ``loongarch``), controls whether all
+unaligned traps are logged.
 
 = =============================================================
 0 Log all unaligned accesses.
@@ -1457,8 +1457,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc`` and ``parisc``), controls whether unaligned traps are caught
-and emulated (instead of failing).
+``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
+are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0a6ef613124c..a8dc58e8162a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,6 +122,8 @@ config LOONGARCH
 	select RTC_LIB
 	select SMP
 	select SPARSE_IRQ
+	select SYSCTL_ARCH_UNALIGN_ALLOW
+	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_EXCEPTION_TRACE
 	select SWIOTLB
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index fce1843ceebb..889d6c9fc2b6 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -76,6 +76,10 @@ enum reg2i12_op {
 	ldbu_op		= 0xa8,
 	ldhu_op		= 0xa9,
 	ldwu_op		= 0xaa,
+	flds_op		= 0xac,
+	fsts_op		= 0xad,
+	fldd_op		= 0xae,
+	fstd_op		= 0xaf,
 };
 
 enum reg2i14_op {
@@ -146,6 +150,10 @@ enum reg3_op {
 	ldxbu_op	= 0x7040,
 	ldxhu_op	= 0x7048,
 	ldxwu_op	= 0x7050,
+	fldxs_op	= 0x7060,
+	fldxd_op	= 0x7068,
+	fstxs_op	= 0x7070,
+	fstxd_op	= 0x7078,
 	amswapw_op	= 0x70c0,
 	amswapd_op	= 0x70c1,
 	amaddw_op	= 0x70c2,
@@ -566,4 +574,10 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 
 DEF_EMIT_REG3SA2_FORMAT(alsld, alsld_op)
 
+struct pt_regs;
+
+void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc);
+unsigned long unaligned_read(void __user *addr, void *value, unsigned long n, bool sign);
+unsigned long unaligned_write(void __user *addr, unsigned long value, unsigned long n);
+
 #endif /* _ASM_INST_H */
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index b7dd9f19a5a9..1a3354ca056e 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -38,7 +38,7 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
-	.flags		= 0,			\
+	.flags		= _TIF_FIXADE,		\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 42be564278fa..2ad2555b53ea 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -7,7 +7,8 @@ extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
-		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
+		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
+		   unaligned.o
 
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 1a4dce84ebc6..7ea62faeeadb 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -368,13 +368,40 @@ asmlinkage void noinstr do_ade(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+/* sysctl hooks */
+int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
+int no_unaligned_warning __read_mostly = 1;	/* Only 1 warning by default */
+
 asmlinkage void noinstr do_ale(struct pt_regs *regs)
 {
+	unsigned int *pc;
 	irqentry_state_t state = irqentry_enter(regs);
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
+
+	/*
+	 * Did we catch a fault trying to load an instruction?
+	 */
+	if (regs->csr_badvaddr == regs->csr_era)
+		goto sigbus;
+	if (user_mode(regs) && !test_thread_flag(TIF_FIXADE))
+		goto sigbus;
+	if (!unaligned_enabled)
+		goto sigbus;
+	if (!no_unaligned_warning)
+		show_registers(regs);
+
+	pc = (unsigned int *)exception_era(regs);
+
+	emulate_load_store_insn(regs, (void __user *)regs->csr_badvaddr, pc);
+
+	goto out;
+
+sigbus:
 	die_if_kernel("Kernel ale access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
 
+out:
 	irqentry_exit(regs, state);
 }
 
diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
new file mode 100644
index 000000000000..bdff825d29ef
--- /dev/null
+++ b/arch/loongarch/kernel/unaligned.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle unaligned accesses by emulation.
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1996, 1998, 1999, 2002 by Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ */
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/debugfs.h>
+#include <linux/perf_event.h>
+
+#include <asm/asm.h>
+#include <asm/branch.h>
+#include <asm/fpu.h>
+#include <asm/inst.h>
+
+#include "access-helper.h"
+
+#ifdef CONFIG_DEBUG_FS
+static u32 unaligned_instructions_user;
+static u32 unaligned_instructions_kernel;
+#endif
+
+static inline unsigned long read_fpr(unsigned int idx)
+{
+#define READ_FPR(idx, __value)		\
+	__asm__ __volatile__("movfr2gr.d %0, $f"#idx"\n\t" : "=r"(__value));
+
+	unsigned long __value;
+
+	switch (idx) {
+	case 0:
+		READ_FPR(0, __value);
+		break;
+	case 1:
+		READ_FPR(1, __value);
+		break;
+	case 2:
+		READ_FPR(2, __value);
+		break;
+	case 3:
+		READ_FPR(3, __value);
+		break;
+	case 4:
+		READ_FPR(4, __value);
+		break;
+	case 5:
+		READ_FPR(5, __value);
+		break;
+	case 6:
+		READ_FPR(6, __value);
+		break;
+	case 7:
+		READ_FPR(7, __value);
+		break;
+	case 8:
+		READ_FPR(8, __value);
+		break;
+	case 9:
+		READ_FPR(9, __value);
+		break;
+	case 10:
+		READ_FPR(10, __value);
+		break;
+	case 11:
+		READ_FPR(11, __value);
+		break;
+	case 12:
+		READ_FPR(12, __value);
+		break;
+	case 13:
+		READ_FPR(13, __value);
+		break;
+	case 14:
+		READ_FPR(14, __value);
+		break;
+	case 15:
+		READ_FPR(15, __value);
+		break;
+	case 16:
+		READ_FPR(16, __value);
+		break;
+	case 17:
+		READ_FPR(17, __value);
+		break;
+	case 18:
+		READ_FPR(18, __value);
+		break;
+	case 19:
+		READ_FPR(19, __value);
+		break;
+	case 20:
+		READ_FPR(20, __value);
+		break;
+	case 21:
+		READ_FPR(21, __value);
+		break;
+	case 22:
+		READ_FPR(22, __value);
+		break;
+	case 23:
+		READ_FPR(23, __value);
+		break;
+	case 24:
+		READ_FPR(24, __value);
+		break;
+	case 25:
+		READ_FPR(25, __value);
+		break;
+	case 26:
+		READ_FPR(26, __value);
+		break;
+	case 27:
+		READ_FPR(27, __value);
+		break;
+	case 28:
+		READ_FPR(28, __value);
+		break;
+	case 29:
+		READ_FPR(29, __value);
+		break;
+	case 30:
+		READ_FPR(30, __value);
+		break;
+	case 31:
+		READ_FPR(31, __value);
+		break;
+	default:
+		panic("unexpected idx '%d'", idx);
+	}
+#undef READ_FPR
+	return __value;
+}
+
+static inline void write_fpr(unsigned int idx, unsigned long value)
+{
+#define WRITE_FPR(idx, value)		\
+	__asm__ __volatile__("movgr2fr.d $f"#idx", %0\n\t" :: "r"(value));
+
+	switch (idx) {
+	case 0:
+		WRITE_FPR(0, value);
+		break;
+	case 1:
+		WRITE_FPR(1, value);
+		break;
+	case 2:
+		WRITE_FPR(2, value);
+		break;
+	case 3:
+		WRITE_FPR(3, value);
+		break;
+	case 4:
+		WRITE_FPR(4, value);
+		break;
+	case 5:
+		WRITE_FPR(5, value);
+		break;
+	case 6:
+		WRITE_FPR(6, value);
+		break;
+	case 7:
+		WRITE_FPR(7, value);
+		break;
+	case 8:
+		WRITE_FPR(8, value);
+		break;
+	case 9:
+		WRITE_FPR(9, value);
+		break;
+	case 10:
+		WRITE_FPR(10, value);
+		break;
+	case 11:
+		WRITE_FPR(11, value);
+		break;
+	case 12:
+		WRITE_FPR(12, value);
+		break;
+	case 13:
+		WRITE_FPR(13, value);
+		break;
+	case 14:
+		WRITE_FPR(14, value);
+		break;
+	case 15:
+		WRITE_FPR(15, value);
+		break;
+	case 16:
+		WRITE_FPR(16, value);
+		break;
+	case 17:
+		WRITE_FPR(17, value);
+		break;
+	case 18:
+		WRITE_FPR(18, value);
+		break;
+	case 19:
+		WRITE_FPR(19, value);
+		break;
+	case 20:
+		WRITE_FPR(20, value);
+		break;
+	case 21:
+		WRITE_FPR(21, value);
+		break;
+	case 22:
+		WRITE_FPR(22, value);
+		break;
+	case 23:
+		WRITE_FPR(23, value);
+		break;
+	case 24:
+		WRITE_FPR(24, value);
+		break;
+	case 25:
+		WRITE_FPR(25, value);
+		break;
+	case 26:
+		WRITE_FPR(26, value);
+		break;
+	case 27:
+		WRITE_FPR(27, value);
+		break;
+	case 28:
+		WRITE_FPR(28, value);
+		break;
+	case 29:
+		WRITE_FPR(29, value);
+		break;
+	case 30:
+		WRITE_FPR(30, value);
+		break;
+	case 31:
+		WRITE_FPR(31, value);
+		break;
+	default:
+		panic("unexpected idx '%d'", idx);
+	}
+#undef WRITE_FPR
+}
+
+void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc)
+{
+	bool fp = false;
+	bool sign, write;
+	bool user = user_mode(regs);
+	unsigned int res, size = 0;
+	unsigned long value = 0;
+	union loongarch_instruction insn;
+
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
+
+	__get_inst(&insn.word, pc, user);
+
+	switch (insn.reg2i12_format.opcode) {
+	case ldh_op:
+		size = 2;
+		sign = true;
+		write = false;
+		break;
+	case ldhu_op:
+		size = 2;
+		sign = false;
+		write = false;
+		break;
+	case sth_op:
+		size = 2;
+		sign = true;
+		write = true;
+		break;
+	case ldw_op:
+		size = 4;
+		sign = true;
+		write = false;
+		break;
+	case ldwu_op:
+		size = 4;
+		sign = false;
+		write = false;
+		break;
+	case stw_op:
+		size = 4;
+		sign = true;
+		write = true;
+		break;
+	case ldd_op:
+		size = 8;
+		sign = true;
+		write = false;
+		break;
+	case std_op:
+		size = 8;
+		sign = true;
+		write = true;
+		break;
+	case flds_op:
+		size = 4;
+		fp = true;
+		sign = true;
+		write = false;
+		break;
+	case fsts_op:
+		size = 4;
+		fp = true;
+		sign = true;
+		write = true;
+		break;
+	case fldd_op:
+		size = 8;
+		fp = true;
+		sign = true;
+		write = false;
+		break;
+	case fstd_op:
+		size = 8;
+		fp = true;
+		sign = true;
+		write = true;
+		break;
+	}
+
+	switch (insn.reg2i14_format.opcode) {
+	case ldptrw_op:
+		size = 4;
+		sign = true;
+		write = false;
+		break;
+	case stptrw_op:
+		size = 4;
+		sign = true;
+		write = true;
+		break;
+	case ldptrd_op:
+		size = 8;
+		sign = true;
+		write = false;
+		break;
+	case stptrd_op:
+		size = 8;
+		sign = true;
+		write = true;
+		break;
+	}
+
+	switch (insn.reg3_format.opcode) {
+	case ldxh_op:
+		size = 2;
+		sign = true;
+		write = false;
+		break;
+	case ldxhu_op:
+		size = 2;
+		sign = false;
+		write = false;
+		break;
+	case stxh_op:
+		size = 2;
+		sign = true;
+		write = true;
+		break;
+	case ldxw_op:
+		size = 4;
+		sign = true;
+		write = false;
+		break;
+	case ldxwu_op:
+		size = 4;
+		sign = false;
+		write = false;
+		break;
+	case stxw_op:
+		size = 4;
+		sign = true;
+		write = true;
+		break;
+	case ldxd_op:
+		size = 8;
+		sign = true;
+		write = false;
+		break;
+	case stxd_op:
+		size = 8;
+		sign = true;
+		write = true;
+		break;
+	case fldxs_op:
+		size = 4;
+		fp = true;
+		sign = true;
+		write = false;
+		break;
+	case fstxs_op:
+		size = 4;
+		fp = true;
+		sign = true;
+		write = true;
+		break;
+	case fldxd_op:
+		size = 8;
+		fp = true;
+		sign = true;
+		write = false;
+		break;
+	case fstxd_op:
+		size = 8;
+		fp = true;
+		sign = true;
+		write = true;
+		break;
+	}
+
+	if (!size)
+		goto sigbus;
+	if (user && !access_ok(addr, size))
+		goto sigbus;
+
+	if (!write) {
+		res = unaligned_read(addr, &value, size, sign);
+		if (res)
+			goto fault;
+
+		/* Rd is the same field in any formats */
+		if (!fp)
+			regs->regs[insn.reg3_format.rd] = value;
+		else {
+			if (is_fpu_owner())
+				write_fpr(insn.reg3_format.rd, value);
+			else
+				set_fpr64(&current->thread.fpu.fpr[insn.reg3_format.rd], 0, value);
+		}
+	} else {
+		/* Rd is the same field in any formats */
+		if (!fp)
+			value = regs->regs[insn.reg3_format.rd];
+		else {
+			if (is_fpu_owner())
+				value = read_fpr(insn.reg3_format.rd);
+			else
+				value = get_fpr64(&current->thread.fpu.fpr[insn.reg3_format.rd], 0);
+		}
+
+		res = unaligned_write(addr, value, size);
+		if (res)
+			goto fault;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	if (user)
+		unaligned_instructions_user++;
+	else
+		unaligned_instructions_kernel++;
+#endif
+
+	compute_return_era(regs);
+
+	return;
+
+fault:
+	/* Did we have an exception handler installed? */
+	if (fixup_exception(regs))
+		return;
+
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGSEGV);
+
+	return;
+
+sigbus:
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGBUS);
+
+	return;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int __init debugfs_unaligned(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("loongarch", NULL);
+	if (!d)
+		return -ENOMEM;
+
+	debugfs_create_u32("unaligned_instructions_user",
+				S_IRUGO, d, &unaligned_instructions_user);
+	debugfs_create_u32("unaligned_instructions_kernel",
+				S_IRUGO, d, &unaligned_instructions_kernel);
+
+	return 0;
+}
+arch_initcall(debugfs_unaligned);
+#endif
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index e36635fccb69..867895530340 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,4 +3,4 @@
 # Makefile for LoongArch-specific library files.
 #
 
-lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o
+lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o unaligned.o
diff --git a/arch/loongarch/lib/unaligned.S b/arch/loongarch/lib/unaligned.S
new file mode 100644
index 000000000000..b42c4a2edfad
--- /dev/null
+++ b/arch/loongarch/lib/unaligned.S
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/errno.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+.macro fixup_ex from, to, fix
+.if \fix
+	.section .fixup, "ax"
+\to:	li.w	a0, -EFAULT
+	jr	ra
+	.previous
+.endif
+	.section __ex_table, "a"
+	PTR	\from\()b, \to\()b
+	.previous
+.endm
+
+/*
+ * unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign)
+ *
+ * a0: addr
+ * a1: value
+ * a2: n
+ * a3: sign
+ */
+SYM_FUNC_START(unaligned_read)
+	beqz	a2, 5f
+
+	li.w	t2, 0
+	addi.d	t0, a2, -1
+	slli.d	t1, t0, 3
+	add.d 	a0, a0, t0
+
+	beqz	a3, 2f
+1:	ld.b	t3, a0, 0
+	b	3f
+
+2:	ld.bu	t3, a0, 0
+3:	sll.d	t3, t3, t1
+	or	t2, t2, t3
+	addi.d	t1, t1, -8
+	addi.d	a0, a0, -1
+	addi.d	a2, a2, -1
+	bgtz	a2, 2b
+4:	st.d	t2, a1, 0
+
+	move	a0, a2
+	jr	ra
+
+5:	li.w    a0, -EFAULT
+	jr	ra
+
+	fixup_ex 1, 6, 1
+	fixup_ex 2, 6, 0
+	fixup_ex 4, 6, 0
+SYM_FUNC_END(unaligned_read)
+
+/*
+ * unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n)
+ *
+ * a0: addr
+ * a1: value
+ * a2: n
+ */
+SYM_FUNC_START(unaligned_write)
+	beqz	a2, 3f
+
+	li.w	t0, 0
+1:	srl.d	t1, a1, t0
+2:	st.b	t1, a0, 0
+	addi.d	t0, t0, 8
+	addi.d	a2, a2, -1
+	addi.d	a0, a0, 1
+	bgtz	a2, 1b
+
+	move	a0, a2
+	jr	ra
+
+3:	li.w    a0, -EFAULT
+	jr	ra
+
+	fixup_ex 2, 4, 1
+SYM_FUNC_END(unaligned_write)
-- 
2.31.1

