Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376123FFDBE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348959AbhICKCc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 06:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhICKCb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 06:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 107C260FDA;
        Fri,  3 Sep 2021 10:01:27 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 15/22] LoongArch: Add elf and module support
Date:   Fri,  3 Sep 2021 17:52:06 +0800
Message-Id: <20210903095213.797973-16-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds elf definition and module relocate codes.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/cpufeature.h  |  24 +
 arch/loongarch/include/asm/elf.h         | 308 +++++++++++
 arch/loongarch/include/asm/exec.h        |  10 +
 arch/loongarch/include/asm/module.h      |  15 +
 arch/loongarch/include/asm/vermagic.h    |  19 +
 arch/loongarch/include/uapi/asm/auxvec.h |  17 +
 arch/loongarch/include/uapi/asm/hwcap.h  |  20 +
 arch/loongarch/kernel/elf.c              |  41 ++
 arch/loongarch/kernel/module.c           | 652 +++++++++++++++++++++++
 9 files changed, 1106 insertions(+)
 create mode 100644 arch/loongarch/include/asm/cpufeature.h
 create mode 100644 arch/loongarch/include/asm/elf.h
 create mode 100644 arch/loongarch/include/asm/exec.h
 create mode 100644 arch/loongarch/include/asm/module.h
 create mode 100644 arch/loongarch/include/asm/vermagic.h
 create mode 100644 arch/loongarch/include/uapi/asm/auxvec.h
 create mode 100644 arch/loongarch/include/uapi/asm/hwcap.h
 create mode 100644 arch/loongarch/kernel/elf.c
 create mode 100644 arch/loongarch/kernel/module.c

diff --git a/arch/loongarch/include/asm/cpufeature.h b/arch/loongarch/include/asm/cpufeature.h
new file mode 100644
index 000000000000..7e4c6a769830
--- /dev/null
+++ b/arch/loongarch/include/asm/cpufeature.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CPU feature definitions for module loading, used by
+ * module_cpu_feature_match(), see uapi/asm/hwcap.h for LoongArch CPU features.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_CPUFEATURE_H
+#define __ASM_CPUFEATURE_H
+
+#include <uapi/asm/hwcap.h>
+#include <asm/elf.h>
+
+#define MAX_CPU_FEATURES (8 * sizeof(elf_hwcap))
+
+#define cpu_feature(x)		ilog2(HWCAP_ ## x)
+
+static inline bool cpu_have_feature(unsigned int num)
+{
+	return elf_hwcap & (1UL << num);
+}
+
+#endif /* __ASM_CPUFEATURE_H */
diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
new file mode 100644
index 000000000000..9f8c2ab1a206
--- /dev/null
+++ b/arch/loongarch/include/asm/elf.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_ELF_H
+#define _ASM_ELF_H
+
+#include <linux/auxvec.h>
+#include <linux/fs.h>
+#include <linux/mm_types.h>
+
+#include <uapi/linux/elf.h>
+
+#include <asm/current.h>
+
+/* ELF header e_flags defines. */
+
+/* The ABI of a file. */
+#define EF_LARCH_ABI_LP32		0x00000001	/* LP32 ABI.  */
+#define EF_LARCH_ABI_LPX32		0x00000002	/* LPX32 ABI  */
+#define EF_LARCH_ABI_LP64		0x00000003	/* LP64 ABI  */
+#define EF_LARCH_ABI			0x00000003
+
+/* LoongArch relocation types used by the dynamic linker */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+#define R_LARCH_COPY				4
+#define R_LARCH_JUMP_SLOT			5
+#define R_LARCH_TLS_DTPMOD32			6
+#define R_LARCH_TLS_DTPMOD64			7
+#define R_LARCH_TLS_DTPREL32			8
+#define R_LARCH_TLS_DTPREL64			9
+#define R_LARCH_TLS_TPREL32			10
+#define R_LARCH_TLS_TPREL64			11
+#define R_LARCH_IRELATIVE			12
+#define R_LARCH_MARK_LA				20
+#define R_LARCH_MARK_PCREL			21
+#define R_LARCH_SOP_PUSH_PCREL			22
+#define R_LARCH_SOP_PUSH_ABSOLUTE		23
+#define R_LARCH_SOP_PUSH_DUP			24
+#define R_LARCH_SOP_PUSH_GPREL			25
+#define R_LARCH_SOP_PUSH_TLS_TPREL		26
+#define R_LARCH_SOP_PUSH_TLS_GOT		27
+#define R_LARCH_SOP_PUSH_TLS_GD			28
+#define R_LARCH_SOP_PUSH_PLT_PCREL		29
+#define R_LARCH_SOP_ASSERT			30
+#define R_LARCH_SOP_NOT				31
+#define R_LARCH_SOP_SUB				32
+#define R_LARCH_SOP_SL				33
+#define R_LARCH_SOP_SR				34
+#define R_LARCH_SOP_ADD				35
+#define R_LARCH_SOP_AND				36
+#define R_LARCH_SOP_IF_ELSE			37
+#define R_LARCH_SOP_POP_32_S_10_5		38
+#define R_LARCH_SOP_POP_32_U_10_12		39
+#define R_LARCH_SOP_POP_32_S_10_12		40
+#define R_LARCH_SOP_POP_32_S_10_16		41
+#define R_LARCH_SOP_POP_32_S_10_16_S2		42
+#define R_LARCH_SOP_POP_32_S_5_20		43
+#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2	44
+#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2	45
+#define R_LARCH_SOP_POP_32_U			46
+#define R_LARCH_ADD8				47
+#define R_LARCH_ADD16				48
+#define R_LARCH_ADD24				49
+#define R_LARCH_ADD32				50
+#define R_LARCH_ADD64				51
+#define R_LARCH_SUB8				52
+#define R_LARCH_SUB16				53
+#define R_LARCH_SUB24				54
+#define R_LARCH_SUB32				55
+#define R_LARCH_SUB64				56
+#define R_LARCH_GNU_VTINHERIT			57
+#define R_LARCH_GNU_VTENTRY			58
+
+#ifndef ELF_ARCH
+
+/* ELF register definitions */
+
+/*
+ * General purpose have the following registers:
+ *	Register	Number
+ *	GPRs		32
+ *	EPC		1
+ *	BADVADDR	1
+ *	CRMD		1
+ *	PRMD		1
+ *	EUEN		1
+ *	ECFG		1
+ *	ESTAT		1
+ *	Reserved	6
+ */
+#define ELF_NGREG	45
+
+/*
+ * Floating point have the following registers:
+ *	Register	Number
+ *	FPR		32
+ *	FCC		1
+ *	FCSR		1
+ */
+#define ELF_NFPREG	34
+
+typedef unsigned long elf_greg_t;
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef double elf_fpreg_t;
+typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
+
+void loongarch_dump_regs64(u64 *uregs, const struct pt_regs *regs);
+
+#ifdef CONFIG_32BIT
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch elf32_check_arch
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+
+#define ELF_CORE_COPY_REGS(dest, regs) \
+	loongarch_dump_regs32((u32 *)&(dest), (regs));
+
+#endif /* CONFIG_32BIT */
+
+#ifdef CONFIG_64BIT
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch elf64_check_arch
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS64
+
+#define ELF_CORE_COPY_REGS(dest, regs) \
+	loongarch_dump_regs64((u64 *)&(dest), (regs));
+
+#endif /* CONFIG_64BIT */
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_DATA	ELFDATA2LSB
+#define ELF_ARCH	EM_LOONGARCH
+
+#endif /* !defined(ELF_ARCH) */
+
+#define loongarch_elf_check_machine(x) ((x)->e_machine == EM_LOONGARCH)
+
+#define vmcore_elf32_check_arch loongarch_elf_check_machine
+#define vmcore_elf64_check_arch loongarch_elf_check_machine
+
+/*
+ * Return non-zero if HDR identifies an 32bit ELF binary.
+ */
+#define elf32_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (!loongarch_elf_check_machine(__h))				\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+/*
+ * Return non-zero if HDR identifies an 64bit ELF binary.
+ */
+#define elf64_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (!loongarch_elf_check_machine(__h))				\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+struct loongarch_abi;
+extern struct loongarch_abi loongarch_abi;
+
+#ifdef CONFIG_32BIT
+
+#define SET_PERSONALITY2(ex, state)					\
+do {									\
+	current->thread.abi = &loongarch_abi;				\
+									\
+	loongarch_set_personality_fcsr(state);				\
+									\
+	if (personality(current->personality) != PER_LINUX)		\
+		set_personality(PER_LINUX);				\
+} while (0)
+
+#endif /* CONFIG_32BIT */
+
+#ifdef CONFIG_64BIT
+
+#define SET_PERSONALITY2(ex, state)					\
+do {									\
+	unsigned int p;							\
+									\
+	clear_thread_flag(TIF_32BIT_REGS);				\
+	clear_thread_flag(TIF_32BIT_ADDR);				\
+									\
+	current->thread.abi = &loongarch_abi;			\
+	loongarch_set_personality_fcsr(state);				\
+									\
+	p = personality(current->personality);				\
+	if (p != PER_LINUX32 && p != PER_LINUX)				\
+		set_personality(PER_LINUX);				\
+} while (0)
+
+#endif /* CONFIG_64BIT */
+
+#define CORE_DUMP_USE_REGSET
+#define ELF_EXEC_PAGESIZE	PAGE_SIZE
+
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this cpu supports. This could be done in userspace,
+ * but it's not easy, and we've already done it here.
+ */
+
+#define ELF_HWCAP	(elf_hwcap)
+extern unsigned int elf_hwcap;
+#include <asm/hwcap.h>
+
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.	 This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
+
+#define ELF_PLATFORM  __elf_platform
+extern const char *__elf_platform;
+
+/* The regs[11] (a7) holds the syscall number and should not cleared */
+#define ELF_PLAT_INIT(_r, load_addr)	do { \
+	_r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;	\
+	_r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;	\
+	_r->regs[9] = _r->regs[10] = _r->regs[12] = _r->regs[13] = 0;	\
+	_r->regs[14] = _r->regs[15] = _r->regs[16] = _r->regs[17] = 0;	\
+	_r->regs[18] = _r->regs[19] = _r->regs[20] = _r->regs[21] = 0;	\
+	_r->regs[22] = _r->regs[23] = _r->regs[24] = _r->regs[25] = 0;	\
+	_r->regs[26] = _r->regs[27] = _r->regs[28] = _r->regs[29] = 0;	\
+	_r->regs[30] = _r->regs[31] = 0;				\
+} while (0)
+
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed. Typical
+ * use of this is to invoke "./ld.so someprog" to test out a new version of
+ * the loader. We need to make sure that it is out of the way of the program
+ * that it will "exec", and that there is sufficient room for the brk.
+ */
+
+#ifndef ELF_ET_DYN_BASE
+#define ELF_ET_DYN_BASE		(TASK_SIZE / 3 * 2)
+#endif
+
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
+#define ARCH_DLINFO							\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (unsigned long)current->mm->context.vdso);		\
+} while (0)
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp);
+
+struct arch_elf_state {
+	int fp_abi;
+	int interp_fp_abi;
+};
+
+#define LOONGARCH_ABI_FP_ANY	(0)
+
+#define INIT_ARCH_ELF_STATE {			\
+	.fp_abi = LOONGARCH_ABI_FP_ANY,		\
+	.interp_fp_abi = LOONGARCH_ABI_FP_ANY,	\
+}
+
+
+extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
+			    bool is_interp, struct arch_elf_state *state);
+
+extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
+			  struct arch_elf_state *state);
+
+extern void loongarch_set_personality_fcsr(struct arch_elf_state *state);
+
+#define elf_read_implies_exec(ex, stk) loongarch_elf_read_implies_exec(&(ex), stk)
+extern int loongarch_elf_read_implies_exec(void *elf_ex, int exstack);
+
+#endif /* _ASM_ELF_H */
diff --git a/arch/loongarch/include/asm/exec.h b/arch/loongarch/include/asm/exec.h
new file mode 100644
index 000000000000..00df07ce3529
--- /dev/null
+++ b/arch/loongarch/include/asm/exec.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_EXEC_H
+#define _ASM_EXEC_H
+
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#endif /* _ASM_EXEC_H */
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
new file mode 100644
index 000000000000..6df72c6228e0
--- /dev/null
+++ b/arch/loongarch/include/asm/module.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_MODULE_H
+#define _ASM_MODULE_H
+
+#include <asm-generic/module.h>
+
+#define RELA_STACK_DEPTH 16
+
+struct mod_arch_specific {
+};
+
+#endif /* _ASM_MODULE_H */
diff --git a/arch/loongarch/include/asm/vermagic.h b/arch/loongarch/include/asm/vermagic.h
new file mode 100644
index 000000000000..9882dfd4702a
--- /dev/null
+++ b/arch/loongarch/include/asm/vermagic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#define MODULE_PROC_FAMILY "LOONGARCH "
+
+#ifdef CONFIG_32BIT
+#define MODULE_KERNEL_TYPE "32BIT "
+#elif defined CONFIG_64BIT
+#define MODULE_KERNEL_TYPE "64BIT "
+#endif
+
+#define MODULE_ARCH_VERMAGIC \
+	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/loongarch/include/uapi/asm/auxvec.h b/arch/loongarch/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..5a2200fd75bf
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/auxvec.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* Location of VDSO image. */
+#define AT_SYSINFO_EHDR		33
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/include/uapi/asm/hwcap.h
new file mode 100644
index 000000000000..8840b72fa8e8
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/hwcap.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_HWCAP_H
+#define _UAPI_ASM_HWCAP_H
+
+/* HWCAP flags */
+#define HWCAP_LOONGARCH_CPUCFG		(1 << 0)
+#define HWCAP_LOONGARCH_LAM		(1 << 1)
+#define HWCAP_LOONGARCH_UAL		(1 << 2)
+#define HWCAP_LOONGARCH_FPU		(1 << 3)
+#define HWCAP_LOONGARCH_LSX		(1 << 4)
+#define HWCAP_LOONGARCH_LASX		(1 << 5)
+#define HWCAP_LOONGARCH_CRC32		(1 << 6)
+#define HWCAP_LOONGARCH_COMPLEX		(1 << 7)
+#define HWCAP_LOONGARCH_CRYPTO		(1 << 8)
+#define HWCAP_LOONGARCH_LVZ		(1 << 9)
+#define HWCAP_LOONGARCH_LBT_X86		(1 << 10)
+#define HWCAP_LOONGARCH_LBT_ARM		(1 << 11)
+#define HWCAP_LOONGARCH_LBT_MIPS	(1 << 12)
+
+#endif /* _UAPI_ASM_HWCAP_H */
diff --git a/arch/loongarch/kernel/elf.c b/arch/loongarch/kernel/elf.c
new file mode 100644
index 000000000000..072dfd40f0b5
--- /dev/null
+++ b/arch/loongarch/kernel/elf.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+
+#include <asm/cpu-features.h>
+#include <asm/cpu-info.h>
+
+int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
+		     bool is_interp, struct arch_elf_state *state)
+{
+	return 0;
+}
+
+int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
+		   struct arch_elf_state *state)
+{
+	return 0;
+}
+
+void loongarch_set_personality_fcsr(struct arch_elf_state *state)
+{
+	current->thread.fpu.fcsr = boot_cpu_data.fpu_csr0;
+}
+
+int loongarch_elf_read_implies_exec(void *elf_ex, int exstack)
+{
+	if (exstack != EXSTACK_DISABLE_X) {
+		/* The binary doesn't request a non-executable stack */
+		return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(loongarch_elf_read_implies_exec);
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
new file mode 100644
index 000000000000..af7c403b032b
--- /dev/null
+++ b/arch/loongarch/kernel/module.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#undef DEBUG
+
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
+{
+	if (*rela_stack_top >= RELA_STACK_DEPTH)
+		return -ENOEXEC;
+
+	rela_stack[(*rela_stack_top)++] = stack_value;
+	pr_debug("%s stack_value = 0x%llx\n", __func__, stack_value);
+
+	return 0;
+}
+
+static int rela_stack_pop(s64 *stack_value, s64 *rela_stack, size_t *rela_stack_top)
+{
+	if (*rela_stack_top == 0)
+		return -ENOEXEC;
+
+	*stack_value = rela_stack[--(*rela_stack_top)];
+	pr_debug("%s stack_value = 0x%llx\n", __func__, *stack_value);
+
+	return 0;
+}
+
+static int apply_r_larch_none(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	return 0;
+}
+
+static int apply_r_larch_32(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*location = v;
+	return 0;
+}
+
+static int apply_r_larch_64(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*(Elf_Addr *)location = v;
+	return 0;
+}
+
+static int apply_r_larch_mark_la(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	return 0;
+}
+
+static int apply_r_larch_mark_pcrel(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	return 0;
+}
+
+static int apply_r_larch_sop_push_pcrel(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	return rela_stack_push(v - (u64)location, rela_stack, rela_stack_top);
+}
+
+static int apply_r_larch_sop_push_absolute(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	return rela_stack_push(v, rela_stack, rela_stack_top);
+}
+
+static int apply_r_larch_sop_push_dup(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_push_plt_pcrel(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	return apply_r_larch_sop_push_pcrel(me, location, v, rela_stack, rela_stack_top);
+}
+
+static int apply_r_larch_sop_sub(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2;
+
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 - opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_sl(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2;
+
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 << opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_sr(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2;
+
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 >> opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_add(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2;
+
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 + opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+static int apply_r_larch_sop_and(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2;
+
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 & opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_if_else(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1, opr2, opr3;
+
+	err = rela_stack_pop(&opr3, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+	err = rela_stack_push(opr1 ? opr2 : opr3, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_10_5(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 5-bit signed */
+	if ((opr1 & ~(u64)0xf) &&
+	    (opr1 & ~(u64)0xf) != ~(u64)0xf) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [14 ... 10] = opr [4 ... 0] */
+	*location = (*location & (~(u32)0x7c00)) | ((opr1 & 0x1f) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_u_10_12(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 12-bit unsigned */
+	if (opr1 & ~(u64)0xfff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [21 ... 10] = opr [11 ... 0] */
+	*location = (*location & (~(u32)0x3ffc00)) | ((opr1 & 0xfff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_10_12(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 12-bit signed */
+	if ((opr1 & ~(u64)0x7ff) &&
+	    (opr1 & ~(u64)0x7ff) != ~(u64)0x7ff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [21 ... 10] = opr [11 ... 0] */
+	*location = (*location & (~(u32)0x3ffc00)) | ((opr1 & 0xfff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_10_16(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 16-bit signed */
+	if ((opr1 & ~(u64)0x7fff) &&
+	    (opr1 & ~(u64)0x7fff) != ~(u64)0x7fff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [25 ... 10] = opr [15 ... 0] */
+	*location = (*location & 0xfc0003ff) | ((opr1 & 0xffff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_10_16_s2(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 4-aligned */
+	if (opr1 % 4) {
+		pr_err("module %s: opr1 = 0x%llx unaligned! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	opr1 >>= 2;
+	/* check 18-bit signed */
+	if ((opr1 & ~(u64)0x7fff) &&
+	    (opr1 & ~(u64)0x7fff) != ~(u64)0x7fff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [25 ... 10] = opr [17 ... 2] */
+	*location = (*location & 0xfc0003ff) | ((opr1 & 0xffff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_5_20(struct module *me, u32 *location, Elf_Addr v,
+						s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 20-bit signed */
+	if ((opr1 & ~(u64)0x7ffff) &&
+	    (opr1 & ~(u64)0x7ffff) != ~(u64)0x7ffff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) [24 ... 5] = opr [19 ... 0] */
+	*location = (*location & (~(u32)0x1ffffe0)) | ((opr1 & 0xfffff) << 5);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_0_5_10_16_s2(struct module *me, u32 *location, Elf_Addr v,
+							s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 4-aligned */
+	if (opr1 % 4) {
+		pr_err("module %s: opr1 = 0x%llx unaligned! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	opr1 >>= 2;
+	/* check 23-bit signed */
+	if ((opr1 & ~(u64)0xfffff) &&
+	    (opr1 & ~(u64)0xfffff) != ~(u64)0xfffff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/*
+	 * (*(uint32_t *) PC) [4 ... 0] = opr [22 ... 18]
+	 * (*(uint32_t *) PC) [25 ... 10] = opr [17 ... 2]
+	 */
+	*location = (*location & 0xfc0003e0)
+		| ((opr1 & 0x1f0000) >> 16) | ((opr1 & 0xffff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_s_0_10_10_16_s2(struct module *me, u32 *location, Elf_Addr v,
+							s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 4-aligned */
+	if (opr1 % 4) {
+		pr_err("module %s: opr1 = 0x%llx unaligned! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	opr1 >>= 2;
+	/* check 28-bit signed */
+	if ((opr1 & ~(u64)0x1ffffff) &&
+	    (opr1 & ~(u64)0x1ffffff) != ~(u64)0x1ffffff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/*
+	 * (*(uint32_t *) PC) [9 ... 0] = opr [27 ... 18]
+	 * (*(uint32_t *) PC) [25 ... 10] = opr [17 ... 2]
+	 */
+	*location = (*location & 0xfc000000)
+		| ((opr1 & 0x3ff0000) >> 16) | ((opr1 & 0xffff) << 10);
+
+	return 0;
+}
+
+static int apply_r_larch_sop_pop_32_u(struct module *me, u32 *location, Elf_Addr v,
+					s64 *rela_stack, size_t *rela_stack_top)
+{
+	int err = 0;
+	s64 opr1;
+
+	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
+	if (err)
+		return err;
+
+	/* check 32-bit unsigned */
+	if (opr1 & ~(u64)0xffffffff) {
+		pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s relocation\n",
+			me->name, opr1, __func__);
+		return -ENOEXEC;
+	}
+
+	/* (*(uint32_t *) PC) = opr */
+	*location = (u32)opr1;
+
+	return 0;
+}
+
+static int apply_r_larch_add32(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*(s32 *)location += v;
+	return 0;
+}
+
+static int apply_r_larch_add64(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*(s64 *)location += v;
+	return 0;
+}
+
+static int apply_r_larch_sub32(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*(s32 *)location -= v;
+	return 0;
+}
+
+static int apply_r_larch_sub64(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top)
+{
+	*(s64 *)location -= v;
+	return 0;
+}
+
+/*
+ * reloc_handlers_rela() - Apply a particular relocation to a module
+ * @me: the module to apply the reloc to
+ * @location: the address at which the reloc is to be applied
+ * @v: the value of the reloc, with addend for RELA-style
+ * @rela_stack: the stack used for store relocation info, LOCAL to THIS module
+ * @rela_stac_top: where the stack operation(pop/push) applies to
+ *
+ * Return: 0 upon success, else -ERRNO
+ */
+typedef int (*reloc_rela_handler)(struct module *me, u32 *location, Elf_Addr v,
+				s64 *rela_stack, size_t *rela_stack_top);
+
+/* The handlers for known reloc types */
+static reloc_rela_handler reloc_rela_handlers[] = {
+	[R_LARCH_NONE]				= apply_r_larch_none,
+	[R_LARCH_32]				= apply_r_larch_32,
+	[R_LARCH_64]				= apply_r_larch_64,
+	[R_LARCH_MARK_LA]			= apply_r_larch_mark_la,
+	[R_LARCH_MARK_PCREL]			= apply_r_larch_mark_pcrel,
+	[R_LARCH_SOP_PUSH_PCREL]		= apply_r_larch_sop_push_pcrel,
+	[R_LARCH_SOP_PUSH_ABSOLUTE]		= apply_r_larch_sop_push_absolute,
+	[R_LARCH_SOP_PUSH_DUP]			= apply_r_larch_sop_push_dup,
+	[R_LARCH_SOP_PUSH_PLT_PCREL]		= apply_r_larch_sop_push_plt_pcrel,
+	[R_LARCH_SOP_SUB]			= apply_r_larch_sop_sub,
+	[R_LARCH_SOP_SL]			= apply_r_larch_sop_sl,
+	[R_LARCH_SOP_SR]			= apply_r_larch_sop_sr,
+	[R_LARCH_SOP_ADD]			= apply_r_larch_sop_add,
+	[R_LARCH_SOP_AND]			= apply_r_larch_sop_and,
+	[R_LARCH_SOP_IF_ELSE]			= apply_r_larch_sop_if_else,
+	[R_LARCH_SOP_POP_32_S_10_5]		= apply_r_larch_sop_pop_32_s_10_5,
+	[R_LARCH_SOP_POP_32_U_10_12]		= apply_r_larch_sop_pop_32_u_10_12,
+	[R_LARCH_SOP_POP_32_S_10_12]		= apply_r_larch_sop_pop_32_s_10_12,
+	[R_LARCH_SOP_POP_32_S_10_16]		= apply_r_larch_sop_pop_32_s_10_16,
+	[R_LARCH_SOP_POP_32_S_10_16_S2]		= apply_r_larch_sop_pop_32_s_10_16_s2,
+	[R_LARCH_SOP_POP_32_S_5_20]		= apply_r_larch_sop_pop_32_s_5_20,
+	[R_LARCH_SOP_POP_32_S_0_5_10_16_S2]	= apply_r_larch_sop_pop_32_s_0_5_10_16_s2,
+	[R_LARCH_SOP_POP_32_S_0_10_10_16_S2]	= apply_r_larch_sop_pop_32_s_0_10_10_16_s2,
+	[R_LARCH_SOP_POP_32_U]			= apply_r_larch_sop_pop_32_u,
+	[R_LARCH_ADD32]				= apply_r_larch_add32,
+	[R_LARCH_ADD64]				= apply_r_larch_add64,
+	[R_LARCH_SUB32]				= apply_r_larch_sub32,
+	[R_LARCH_SUB64]				= apply_r_larch_sub64,
+};
+
+int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relsec,
+		   struct module *me)
+{
+	int i, err;
+	unsigned int type;
+	s64 rela_stack[RELA_STACK_DEPTH];
+	size_t rela_stack_top = 0;
+	reloc_rela_handler handler;
+	void *location;
+	Elf_Addr v;
+	Elf_Sym *sym;
+	Elf_Rel *rel = (void *) sechdrs[relsec].sh_addr;
+
+	pr_debug("%s: Applying relocate section %u to %u\n", __func__, relsec,
+	       sechdrs[relsec].sh_info);
+
+	rela_stack_top = 0;
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr + rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf_Sym *)sechdrs[symindex].sh_addr + ELF_R_SYM(rel[i].r_info);
+		if (IS_ERR_VALUE(sym->st_value)) {
+			/* Ignore unresolved weak symbol */
+			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
+				continue;
+			pr_warn("%s: Unknown symbol %s\n", me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		type = ELF_R_TYPE(rel[i].r_info);
+
+		if (type < ARRAY_SIZE(reloc_rela_handlers))
+			handler = reloc_rela_handlers[type];
+		else
+			handler = NULL;
+
+		if (!handler) {
+			pr_err("%s: Unknown relocation type %u\n", me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value;
+		err = handler(me, location, v, rela_stack, &rela_stack_top);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+		       unsigned int symindex, unsigned int relsec,
+		       struct module *me)
+{
+	int i, err;
+	unsigned int type;
+	s64 rela_stack[RELA_STACK_DEPTH];
+	size_t rela_stack_top = 0;
+	reloc_rela_handler handler;
+	void *location;
+	Elf_Addr v;
+	Elf_Sym *sym;
+	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
+
+	pr_debug("%s: Applying relocate section %u to %u\n", __func__, relsec,
+	       sechdrs[relsec].sh_info);
+
+	rela_stack_top = 0;
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr + rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf_Sym *)sechdrs[symindex].sh_addr + ELF_R_SYM(rel[i].r_info);
+		if (IS_ERR_VALUE(sym->st_value)) {
+			/* Ignore unresolved weak symbol */
+			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
+				continue;
+			pr_warn("%s: Unknown symbol %s\n", me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		type = ELF_R_TYPE(rel[i].r_info);
+
+		if (type < ARRAY_SIZE(reloc_rela_handlers))
+			handler = reloc_rela_handlers[type];
+		else
+			handler = NULL;
+
+		if (!handler) {
+			pr_err("%s: Unknown relocation type %u\n", me->name, type);
+			return -EINVAL;
+		}
+
+		pr_debug("type %d st_value %llx r_addend %llx loc %llx\n",
+		       (int)ELF64_R_TYPE(rel[i].r_info),
+		       sym->st_value, rel[i].r_addend, (u64)location);
+
+		v = sym->st_value + rel[i].r_addend;
+		err = handler(me, location, v, rela_stack, &rela_stack_top);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
-- 
2.27.0

