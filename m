Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F54647E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNQlC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 12:41:02 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:57090 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbfFNQlC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 12:41:02 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE0FDC2295;
        Fri, 14 Jun 2019 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560530461; bh=iueo8gxwYJtBx4iMnrqFdzGZ5RRP386gk1czBYdaGCY=;
        h=From:To:Cc:Subject:Date:From;
        b=BhflzRvku2CPl1FmpVpMny/wDZcH9j32myZFQ51dCWK/BuShl5MitJKqWusLf1gwF
         lJkmPiQex+YeEMrB1TkwgKxKf7IV1OdTaHDyjS39iSJ1csWnaPun/ZI4TfxyTl0nlg
         1xaEHFI+L5CxkmlBUrKVfmHou1IvV+f28y7JDiFTUuhbbHiJ3uWBn5jwvbh8j3JUMt
         B1qx4g8GG7fHSYri3OOJtSNOiRrCartTB+O28qhJbLwlCptdOcewZc63T+UCdi6fMg
         P4oUNo+EpZllO9pe1TOI7zMnZED4YhiK88nFGhNEhvqy5QqFjTuO9ElWX4h2SXTOez
         T3fDckgQQBESQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.58])
        by mailhost.synopsys.com (Postfix) with ESMTP id 54564A0057;
        Fri, 14 Jun 2019 16:40:58 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arch@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date:   Fri, 14 Jun 2019 19:40:49 +0300
Message-Id: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement jump label patching for ARC. Jump labels provide
an interface to generate dynamic branches using
self-modifying code.

This allows us to implement conditional branches where
changing branch direction is expensive but branch selection
is basically 'free'

This implementation uses 32-bit NOP and BRANCH instructions
which forced to be aligned by 4 to guarantee that they don't
cross L1 cache line and can be update atomically.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                  |   8 ++
 arch/arc/include/asm/jump_label.h |  68 ++++++++++++
 arch/arc/kernel/Makefile          |   1 +
 arch/arc/kernel/jump_label.c      | 168 ++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 arch/arc/include/asm/jump_label.h
 create mode 100644 arch/arc/kernel/jump_label.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c781e45d1d99..b1313e016c54 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -47,6 +47,7 @@ config ARC
 	select OF_EARLY_FLATTREE
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
+	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
@@ -529,6 +530,13 @@ config ARC_DW2_UNWIND
 config ARC_DBG_TLB_PARANOIA
 	bool "Paranoia Checks in Low Level TLB Handlers"
 
+config ARC_DBG_STATIC_KEYS
+	bool "Paranoid checks in Static Keys code"
+	depends on JUMP_LABEL
+	select STATIC_KEYS_SELFTEST
+	help
+	  Enable paranoid checks and self-test of both ARC-specific and generic
+	  part of static-keys-related code.
 endif
 
 config ARC_BUILTIN_DTB_NAME
diff --git a/arch/arc/include/asm/jump_label.h b/arch/arc/include/asm/jump_label.h
new file mode 100644
index 000000000000..8971d0608f2c
--- /dev/null
+++ b/arch/arc/include/asm/jump_label.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARC_JUMP_LABEL_H
+#define _ASM_ARC_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+/*
+ * To make atomic update of patched instruction available we need to guarantee
+ * that this instruction doesn't cross L1 cache line boundary.
+ *
+ * As of today we simply align instruction which can be patched by 4 byte using
+ * ".balign 4" directive. In that case patched instruction is aligned with one
+ * 16-bit NOP_S if this is required.
+ * However 'align by 4' directive is much stricter than it actually required.
+ * It's enough that our 32-bit instruction don't cross l1 cache line boundary
+ * which can be achieved by using ".bundle_align_mode" directive. That will save
+ * us from adding useless NOP_S padding in most of the cases.
+ *
+ * TODO: switch to ".bundle_align_mode" directive using whin it will be
+ * supported by ARC toolchain.
+ */
+
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
+{
+	asm_volatile_goto(".balign 4			\n"
+		 "1:					\n"
+		 "nop					\n"
+		 ".pushsection __jump_table, \"aw\"	\n"
+		 ".word 1b, %l[l_yes], %c0		\n"
+		 ".popsection				\n"
+		 : : "i" (&((char *)key)[branch]) : : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
+{
+	asm_volatile_goto(".balign 4			\n"
+		 "1:					\n"
+		 "b %l[l_yes]				\n"
+		 ".pushsection __jump_table, \"aw\"	\n"
+		 ".word 1b, %l[l_yes], %c0		\n"
+		 ".popsection				\n"
+		 : : "i" (&((char *)key)[branch]) : : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+typedef u32 jump_label_t;
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
+#endif  /* __ASSEMBLY__ */
+#endif
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 2dc5f4296d44..307f74156d99 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARC_EMUL_UNALIGNED) 	+= unaligned.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
 obj-$(CONFIG_ARC_METAWARE_HLINK)	+= arc_hostlink.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 
 obj-$(CONFIG_ARC_FPU_SAVE_RESTORE)	+= fpu.o
 CFLAGS_fpu.o   += -mdpfp
diff --git a/arch/arc/kernel/jump_label.c b/arch/arc/kernel/jump_label.c
new file mode 100644
index 000000000000..93e3bc84288f
--- /dev/null
+++ b/arch/arc/kernel/jump_label.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+
+#include "asm/cacheflush.h"
+
+#define JUMPLABEL_ERR	"ARC: jump_label: ERROR: "
+
+/* Halt system on fatal error to make debug easier */
+#define arc_jl_fatal(format...)						\
+({									\
+	pr_err(JUMPLABEL_ERR format);					\
+	BUG();								\
+})
+
+static inline u32 arc_gen_nop(void)
+{
+	/* 1x 32bit NOP in middle endian */
+	return 0x7000264a;
+}
+
+static inline bool cross_l1_cache_line(void *addr, int len)
+{
+	unsigned long a = (unsigned long)addr;
+
+	return (a >> L1_CACHE_SHIFT) != ((a + len - 1) >> L1_CACHE_SHIFT);
+}
+
+/*
+ * ARCv2 'Branch unconditionally' instruction:
+ * 00000ssssssssss1SSSSSSSSSSNRtttt
+ * s S[n:0] lower bits signed immediate (number is bitfield size)
+ * S S[m:n+1] upper bits signed immediate (number is bitfield size)
+ * t S[24:21] upper bits signed immediate (branch unconditionally far)
+ * N N <.d> delay slot mode
+ * R R Reserved
+ */
+static inline u32 arc_gen_branch(jump_label_t pc, jump_label_t target)
+{
+	u32 instruction_l, instruction_r;
+	u32 pcl = pc & GENMASK(31, 2);
+	u32 u_offset = target - pcl;
+	u32 s, S, t;
+
+	/*
+	 * Offset in 32-bit branch instruction must to fit into s25.
+	 * Something is terribly broken if we get such huge offset within one
+	 * function.
+	 */
+	if ((s32)u_offset < -16777216 || (s32)u_offset > 16777214)
+		arc_jl_fatal("gen branch with offset (%d) not fit in s25\n",
+			     (s32)u_offset);
+
+	/*
+	 * All instructions are aligned by 2 bytes so we should never get offset
+	 * here which is not 2 bytes aligned.
+	 */
+	if (u_offset & 0x1)
+		arc_jl_fatal("gen branch with offset (%d) unaligned to 2 bytes\n",
+			     (s32)u_offset);
+
+	s = (u_offset >> 1)  & GENMASK(9, 0);
+	S = (u_offset >> 11) & GENMASK(9, 0);
+	t = (u_offset >> 21) & GENMASK(3, 0);
+
+	/* 00000ssssssssss1 */
+	instruction_l = (s << 1) | 0x1;
+	/* SSSSSSSSSSNRtttt */
+	instruction_r = (S << 6) | t;
+
+	return (instruction_r << 16) | (instruction_l & GENMASK(15, 0));
+}
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	jump_label_t *instr_addr = (jump_label_t *)entry->code;
+	u32 instr;
+
+	/*
+	 * Atomic update of patched instruction is only available if this
+	 * instruction doesn't cross L1 cache line boundary. You can read about
+	 * the way we achieve this in arc/include/asm/jump_label.h
+	 */
+	if (cross_l1_cache_line(instr_addr, JUMP_LABEL_NOP_SIZE))
+		arc_jl_fatal("instruction (addr %px) cross L1 cache line",
+			     instr_addr);
+
+	if (type == JUMP_LABEL_JMP)
+		instr = arc_gen_branch(entry->code, entry->target);
+	else
+		instr = arc_gen_nop();
+
+	WRITE_ONCE(*instr_addr, instr);
+	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);
+}
+
+void arch_jump_label_transform_static(struct jump_entry *entry,
+				      enum jump_label_type type)
+{
+	/*
+	 * We use only one NOP type (1x, 4 byte) in arch_static_branch, so
+	 * there's no need to patch an identical NOP over the top of it here.
+	 * The generic code calls 'arch_jump_label_transform' if the NOP needs
+	 * to be replaced by a branch, so 'arch_jump_label_transform_static' is
+	 * newer called with type other than JUMP_LABEL_NOP.
+	 */
+	BUG_ON(type != JUMP_LABEL_NOP);
+}
+
+#ifdef CONFIG_ARC_DBG_STATIC_KEYS
+#define SELFTEST_MSG	"ARC: instruction generation self-test: "
+
+struct arc_gen_branch_testdata {
+	jump_label_t pc;
+	jump_label_t target_address;
+	u32 expected_instr;
+};
+
+static __init int branch_gen_test(struct arc_gen_branch_testdata *test_data)
+{
+	u32 instr_got;
+
+	instr_got = arc_gen_branch(test_data->pc, test_data->target_address);
+	if (instr_got != test_data->expected_instr) {
+		pr_err(SELFTEST_MSG "FAIL:\n arc_gen_branch(0x%08x, 0x%08x) != 0x%08x, got 0x%08x\n",
+		       test_data->pc, test_data->target_address,
+		       test_data->expected_instr, instr_got);
+
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static __init int instr_gen_test(void)
+{
+	int i, ret;
+
+	struct arc_gen_branch_testdata test_data[] = {
+		{0x90007548, 0x90007514, 0xffcf07cd}, /* tiny (-52) offs */
+		{0x9000c9c0, 0x9000c782, 0xffcf05c3}, /* tiny (-574) offs */
+		{0x9000cc1c, 0x9000c782, 0xffcf0367}, /* tiny (-1178) offs */
+		{0x9009dce0, 0x9009d106, 0xff8f0427}, /* small (-3034) offs */
+		{0x9000f5de, 0x90007d30, 0xfc0f0755}, /* big  (-30892) offs */
+		{0x900a2444, 0x90035f64, 0xc9cf0321}, /* huge (-443616) offs */
+		{0x90007514, 0x9000752c, 0x00000019}, /* tiny (+24) offs */
+		{0x9001a578, 0x9001a77a, 0x00000203}, /* tiny (+514) offs */
+		{0x90031ed8, 0x90032634, 0x0000075d}, /* tiny (+1884) offs */
+		{0x9008c7f2, 0x9008d3f0, 0x00400401}, /* small (+3072) offs */
+		{0x9000bb38, 0x9003b340, 0x17c00009}, /* big  (+194568) offs */
+		{0x90008f44, 0x90578d80, 0xb7c2063d}  /* huge (+5701180) offs */
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
+		ret = branch_gen_test(&test_data[i]);
+		if (ret)
+			return ret;
+	}
+
+	pr_info(SELFTEST_MSG "OK\n");
+
+	return 0;
+}
+early_initcall(instr_gen_test);
+
+#endif /* CONFIG_ARC_STATIC_KEYS_DEBUG */
-- 
2.21.0

