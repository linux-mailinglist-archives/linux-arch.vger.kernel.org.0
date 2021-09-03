Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53E3FFDA0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbhICJ5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235067AbhICJ5W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 218E16056B;
        Fri,  3 Sep 2021 09:56:17 +0000 (UTC)
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
Subject: [PATCH V2 06/22] LoongArch: Add CPU definition headers
Date:   Fri,  3 Sep 2021 17:51:57 +0800
Message-Id: <20210903095213.797973-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds common headers (CPU definition and address space layout)
for basic LoongArch support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/addrspace.h    |  110 ++
 arch/loongarch/include/asm/cpu-features.h |   67 +
 arch/loongarch/include/asm/cpu-info.h     |  136 ++
 arch/loongarch/include/asm/cpu.h          |  123 ++
 arch/loongarch/include/asm/fpregdef.h     |   55 +
 arch/loongarch/include/asm/loongarch.h    | 1509 +++++++++++++++++++++
 arch/loongarch/include/asm/loongson.h     |  159 +++
 arch/loongarch/include/asm/regdef.h       |   43 +
 8 files changed, 2202 insertions(+)
 create mode 100644 arch/loongarch/include/asm/addrspace.h
 create mode 100644 arch/loongarch/include/asm/cpu-features.h
 create mode 100644 arch/loongarch/include/asm/cpu-info.h
 create mode 100644 arch/loongarch/include/asm/cpu.h
 create mode 100644 arch/loongarch/include/asm/fpregdef.h
 create mode 100644 arch/loongarch/include/asm/loongarch.h
 create mode 100644 arch/loongarch/include/asm/loongson.h
 create mode 100644 arch/loongarch/include/asm/regdef.h

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
new file mode 100644
index 000000000000..44e834039057
--- /dev/null
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_ADDRSPACE_H
+#define _ASM_ADDRSPACE_H
+
+#include <linux/const.h>
+
+#include <asm/loongarch.h>
+
+/*
+ * This gives the physical RAM offset.
+ */
+#ifndef __ASSEMBLY__
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET	_AC(0, UL)
+#endif
+extern unsigned long vm_map_base;
+#endif /* __ASSEMBLY__ */
+
+#ifndef IO_BASE
+#define IO_BASE			CSR_DMW0_BASE
+#endif
+
+#ifndef CAC_BASE
+#define CAC_BASE		CSR_DMW1_BASE
+#endif
+
+#ifndef UNCAC_BASE
+#define UNCAC_BASE		CSR_DMW0_BASE
+#endif
+
+#define DMW_PABITS	48
+#define TO_PHYS_MASK	((1ULL << DMW_PABITS) - 1)
+
+/*
+ * Memory above this physical address will be considered highmem.
+ */
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		(_AC(1, UL) << _AC(DMW_PABITS, UL))
+#endif
+
+#define TO_PHYS(x)		(	      ((x) & TO_PHYS_MASK))
+#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+
+/*
+ * This handles the memory map.
+ */
+#ifndef PAGE_OFFSET
+#define PAGE_OFFSET		(CAC_BASE + PHYS_OFFSET)
+#endif
+
+#ifndef FIXADDR_TOP
+#define FIXADDR_TOP		((unsigned long)(long)0xfffe0000)
+#endif
+
+/*
+ *  Configure language
+ */
+#ifdef __ASSEMBLY__
+#define _ATYPE_
+#define _ATYPE32_
+#define _ATYPE64_
+#define _CONST64_(x)	x
+#else
+#define _ATYPE_		__PTRDIFF_TYPE__
+#define _ATYPE32_	int
+#define _ATYPE64_	__s64
+#ifdef CONFIG_64BIT
+#define _CONST64_(x)	x ## L
+#else
+#define _CONST64_(x)	x ## LL
+#endif
+#endif
+
+/*
+ *  32/64-bit LoongArch address spaces
+ */
+#ifdef __ASSEMBLY__
+#define _ACAST32_
+#define _ACAST64_
+#else
+#define _ACAST32_		(_ATYPE_)(_ATYPE32_)	/* widen if necessary */
+#define _ACAST64_		(_ATYPE64_)		/* do _not_ narrow */
+#endif
+
+#ifdef CONFIG_32BIT
+
+#define UVRANGE			0x00000000
+#define KPRANGE0		0x80000000
+#define KPRANGE1		0xa0000000
+#define KVRANGE			0xc0000000
+
+#else
+
+#define XUVRANGE		_CONST64_(0x0000000000000000)
+#define XSPRANGE		_CONST64_(0x4000000000000000)
+#define XKPRANGE		_CONST64_(0x8000000000000000)
+#define XKVRANGE		_CONST64_(0xc000000000000000)
+
+#endif
+
+/*
+ * Returns the physical address of a KPRANGEx / XKPRANGE address
+ */
+#define PHYSADDR(a)		((_ACAST64_(a)) & TO_PHYS_MASK)
+
+#endif /* _ASM_ADDRSPACE_H */
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
new file mode 100644
index 000000000000..2d307f30e3c5
--- /dev/null
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_CPU_FEATURES_H
+#define __ASM_CPU_FEATURES_H
+
+#include <asm/cpu.h>
+#include <asm/cpu-info.h>
+
+#define cpu_opt(opt)			(cpu_data[0].options & (opt))
+#define cpu_has(feat)			(cpu_data[0].options & BIT_ULL(feat))
+
+#define cpu_has_loongarch		(cpu_has_loongarch32 | cpu_has_loongarch64)
+#define cpu_has_loongarch32		(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_32BIT)
+#define cpu_has_loongarch64		(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
+
+#define cpu_icache_line_size()		cpu_data[0].icache.linesz
+#define cpu_dcache_line_size()		cpu_data[0].dcache.linesz
+#define cpu_vcache_line_size()		cpu_data[0].vcache.linesz
+#define cpu_scache_line_size()		cpu_data[0].scache.linesz
+
+#ifdef CONFIG_32BIT
+# define cpu_has_64bits			(cpu_data[0].isa_level & LOONGARCH_CPU_ISA_64BIT)
+# define cpu_vabits			31
+# define cpu_pabits			31
+#endif
+
+#ifdef CONFIG_64BIT
+# define cpu_has_64bits			1
+# define cpu_vabits			cpu_data[0].vabits
+# define cpu_pabits			cpu_data[0].pabits
+# define __NEED_ADDRBITS_PROBE
+#endif
+
+/*
+ * SMP assumption: Options of CPU 0 are a superset of all processors.
+ * This is true for all known LoongArch systems.
+ */
+#define cpu_has_cpucfg		cpu_opt(LOONGARCH_CPU_CPUCFG)
+#define cpu_has_lam		cpu_opt(LOONGARCH_CPU_LAM)
+#define cpu_has_ual		cpu_opt(LOONGARCH_CPU_UAL)
+#define cpu_has_fpu		cpu_opt(LOONGARCH_CPU_FPU)
+#define cpu_has_lsx		cpu_opt(LOONGARCH_CPU_LSX)
+#define cpu_has_lasx		cpu_opt(LOONGARCH_CPU_LASX)
+#define cpu_has_complex		cpu_opt(LOONGARCH_CPU_COMPLEX)
+#define cpu_has_crypto		cpu_opt(LOONGARCH_CPU_CRYPTO)
+#define cpu_has_lvz		cpu_opt(LOONGARCH_CPU_LVZ)
+#define cpu_has_lbt_x86		cpu_opt(LOONGARCH_CPU_LBT_X86)
+#define cpu_has_lbt_arm		cpu_opt(LOONGARCH_CPU_LBT_ARM)
+#define cpu_has_lbt_mips	cpu_opt(LOONGARCH_CPU_LBT_MIPS)
+#define cpu_has_lbt		(cpu_has_lbt_x86|cpu_has_lbt_arm|cpu_has_lbt_mips)
+#define cpu_has_csr		cpu_opt(LOONGARCH_CPU_CSR)
+#define cpu_has_tlb		cpu_opt(LOONGARCH_CPU_TLB)
+#define cpu_has_watch		cpu_opt(LOONGARCH_CPU_WATCH)
+#define cpu_has_vint		cpu_opt(LOONGARCH_CPU_VINT)
+#define cpu_has_csripi		cpu_opt(LOONGARCH_CPU_CSRIPI)
+#define cpu_has_extioi		cpu_opt(LOONGARCH_CPU_EXTIOI)
+#define cpu_has_prefetch	cpu_opt(LOONGARCH_CPU_PREFETCH)
+#define cpu_has_pmp		cpu_opt(LOONGARCH_CPU_PMP)
+#define cpu_has_perf		cpu_opt(LOONGARCH_CPU_PMP)
+#define cpu_has_scalefreq	cpu_opt(LOONGARCH_CPU_SCALEFREQ)
+#define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
+#define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
+
+
+#endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
new file mode 100644
index 000000000000..1d07597b4fd2
--- /dev/null
+++ b/arch/loongarch/include/asm/cpu-info.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_CPU_INFO_H
+#define __ASM_CPU_INFO_H
+
+#include <linux/cache.h>
+#include <linux/types.h>
+
+#include <asm/loongarch.h>
+
+/*
+ * Descriptor for a cache
+ */
+struct cache_desc {
+	unsigned int waysize;	/* Bytes per way */
+	unsigned short sets;	/* Number of lines per set */
+	unsigned char ways;	/* Number of ways */
+	unsigned char linesz;	/* Size of line in bytes */
+	unsigned char waybit;	/* Bits to select in a cache set */
+	unsigned char flags;	/* Flags describing cache properties */
+};
+
+struct cpuinfo_loongarch {
+	u64			asid_cache;
+	unsigned long		asid_mask;
+
+	/*
+	 * Capability and feature descriptor structure for LoongArch CPU
+	 */
+	unsigned long		ases;
+	unsigned long long	options;
+	unsigned int		processor_id;
+	unsigned int		fpu_vers;
+	unsigned int		fpu_csr0;
+	unsigned int		fpu_mask;
+	unsigned int		cputype;
+	int			isa_level;
+	int			tlbsize;
+	int			tlbsizemtlb;
+	int			tlbsizestlbsets;
+	int			tlbsizestlbways;
+	struct cache_desc	icache; /* Primary I-cache */
+	struct cache_desc	dcache; /* Primary D or combined I/D cache */
+	struct cache_desc	vcache; /* Victim cache, between pcache and scache */
+	struct cache_desc	scache; /* Secondary cache */
+	struct cache_desc	tcache; /* Tertiary/split secondary cache */
+	int			package;/* physical package number */
+	unsigned int		globalnumber;
+	int			vabits; /* Virtual Address size in bits */
+	int			pabits; /* Physical Address size in bits */
+	void			*data;	/* Additional data */
+	unsigned int		watch_dreg_count;   /* Number data breakpoints */
+	unsigned int		watch_ireg_count;   /* Number instruction breakpoints */
+	unsigned int		watch_reg_use_cnt; /* min(NUM_WATCH_REGS, watch_dreg_count + watch_ireg_count), Usable by ptrace */
+	unsigned int		kscratch_mask; /* Usable KScratch mask. */
+} __aligned(SMP_CACHE_BYTES);
+
+extern struct cpuinfo_loongarch cpu_data[];
+#define boot_cpu_data cpu_data[0]
+#define current_cpu_data cpu_data[smp_processor_id()]
+#define raw_current_cpu_data cpu_data[raw_smp_processor_id()]
+
+extern void cpu_probe(void);
+
+extern const char *__cpu_family[];
+extern const char *__cpu_full_name[];
+#define cpu_family_string()	__cpu_family[raw_smp_processor_id()]
+#define cpu_full_name_string()	__cpu_full_name[raw_smp_processor_id()]
+
+struct seq_file;
+struct notifier_block;
+
+extern int register_proc_cpuinfo_notifier(struct notifier_block *nb);
+extern int proc_cpuinfo_notifier_call_chain(unsigned long val, void *v);
+
+#define proc_cpuinfo_notifier(fn, pri)					\
+({									\
+	static struct notifier_block fn##_nb = {			\
+		.notifier_call = fn,					\
+		.priority = pri						\
+	};								\
+									\
+	register_proc_cpuinfo_notifier(&fn##_nb);			\
+})
+
+struct proc_cpuinfo_notifier_args {
+	struct seq_file *m;
+	unsigned long n;
+};
+
+static inline unsigned int cpu_cluster(struct cpuinfo_loongarch *cpuinfo)
+{
+	return (cpuinfo->globalnumber & LOONGARCH_GLOBALNUMBER_CLUSTER) >>
+		LOONGARCH_GLOBALNUMBER_CLUSTER_SHF;
+}
+
+static inline unsigned int cpu_core(struct cpuinfo_loongarch *cpuinfo)
+{
+	return (cpuinfo->globalnumber & LOONGARCH_GLOBALNUMBER_CORE) >>
+		LOONGARCH_GLOBALNUMBER_CORE_SHF;
+}
+
+extern void cpu_set_cluster(struct cpuinfo_loongarch *cpuinfo, unsigned int cluster);
+extern void cpu_set_core(struct cpuinfo_loongarch *cpuinfo, unsigned int core);
+
+static inline bool cpus_are_siblings(int cpua, int cpub)
+{
+	struct cpuinfo_loongarch *infoa = &cpu_data[cpua];
+	struct cpuinfo_loongarch *infob = &cpu_data[cpub];
+	unsigned int gnuma, gnumb;
+
+	if (infoa->package != infob->package)
+		return false;
+
+	gnuma = infoa->globalnumber & ~LOONGARCH_GLOBALNUMBER_VP;
+	gnumb = infob->globalnumber & ~LOONGARCH_GLOBALNUMBER_VP;
+	if (gnuma != gnumb)
+		return false;
+
+	return true;
+}
+
+static inline unsigned long cpu_asid_mask(struct cpuinfo_loongarch *cpuinfo)
+{
+	return cpuinfo->asid_mask;
+}
+
+static inline void set_cpu_asid_mask(struct cpuinfo_loongarch *cpuinfo,
+				     unsigned long asid_mask)
+{
+	cpuinfo->asid_mask = asid_mask;
+}
+
+#endif /* __ASM_CPU_INFO_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
new file mode 100644
index 000000000000..c5fbe2a0716a
--- /dev/null
+++ b/arch/loongarch/include/asm/cpu.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * cpu.h: Values of the PRId register used to match up
+ *	  various LoongArch cpu types.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_CPU_H
+#define _ASM_CPU_H
+
+/*
+ * As of the LoongArch specs from Loongson Technology, the PRId register
+ * (CPUCFG.00) is defined in this (backwards compatible) way:
+ *
+ * +----------------+----------------+----------------+----------------+
+ * | Reserved       | Company ID	    | Processor ID   | Revision	      |
+ * +----------------+----------------+----------------+----------------+
+ *  31		 24 23		  16 15		    8 7              0
+ *
+ */
+
+/*
+ * Assigned Company values for bits 23:16 of the PRId register.
+ */
+
+#define PRID_COMP_MASK		0xff0000
+
+#define PRID_COMP_LOONGSON	0x140000
+
+/*
+ * Assigned Processor ID (implementation) values for bits 15:8 of the PRId
+ * register.  In order to detect a certain CPU type exactly eventually
+ * additional registers may need to be examined.
+ */
+
+#define PRID_IMP_MASK		0xff00
+
+#define PRID_IMP_LOONGSON_32	0x4200  /* Loongson 32bit */
+#define PRID_IMP_LOONGSON_64R	0x6100  /* Reduced Loongson 64bit */
+#define PRID_IMP_LOONGSON_64C	0x6300  /* Classic Loongson 64bit */
+#define PRID_IMP_LOONGSON_64G	0xc000  /* Generic Loongson 64bit */
+#define PRID_IMP_UNKNOWN	0xff00
+
+/*
+ * Particular Revision values for bits 7:0 of the PRId register.
+ */
+
+#define PRID_REV_MASK		0x00ff
+
+#if !defined(__ASSEMBLY__)
+
+enum cpu_type_enum {
+	CPU_UNKNOWN,
+	CPU_LOONGSON32,
+	CPU_LOONGSON64,
+	CPU_LAST
+};
+
+#endif /* !__ASSEMBLY */
+
+/*
+ * ISA Level encodings
+ *
+ */
+
+#define LOONGARCH_CPU_ISA_LA32R 0x00000001
+#define LOONGARCH_CPU_ISA_LA32S 0x00000002
+#define LOONGARCH_CPU_ISA_LA64  0x00000004
+
+#define LOONGARCH_CPU_ISA_32BIT (LOONGARCH_CPU_ISA_LA32R | LOONGARCH_CPU_ISA_LA32S)
+#define LOONGARCH_CPU_ISA_64BIT LOONGARCH_CPU_ISA_LA64
+
+/*
+ * CPU Option encodings
+ */
+#define CPU_FEATURE_CPUCFG		0	/* CPU has CPUCFG */
+#define CPU_FEATURE_LAM			1	/* CPU has Atomic instructions */
+#define CPU_FEATURE_UAL			2	/* CPU has Unaligned Access support */
+#define CPU_FEATURE_FPU			3	/* CPU has FPU */
+#define CPU_FEATURE_LSX			4	/* CPU has 128bit SIMD instructions */
+#define CPU_FEATURE_LASX		5	/* CPU has 256bit SIMD instructions */
+#define CPU_FEATURE_COMPLEX		6	/* CPU has Complex instructions */
+#define CPU_FEATURE_CRYPTO		7	/* CPU has Crypto instructions */
+#define CPU_FEATURE_LVZ			8	/* CPU has Virtualization extension */
+#define CPU_FEATURE_LBT_X86		9	/* CPU has X86 Binary Translation */
+#define CPU_FEATURE_LBT_ARM		10	/* CPU has ARM Binary Translation */
+#define CPU_FEATURE_LBT_MIPS		11	/* CPU has MIPS Binary Translation */
+#define CPU_FEATURE_TLB			12	/* CPU has TLB */
+#define CPU_FEATURE_CSR			13	/* CPU has CSR feature */
+#define CPU_FEATURE_WATCH		14	/* CPU has watchpoint registers */
+#define CPU_FEATURE_VINT		15	/* CPU has vectored interrupts */
+#define CPU_FEATURE_CSRIPI		16	/* CPU has CSR-IPI */
+#define CPU_FEATURE_EXTIOI		17	/* CPU has EXT-IOI */
+#define CPU_FEATURE_PREFETCH		18	/* CPU has prefetch instructions */
+#define CPU_FEATURE_PMP			19	/* CPU has perfermance counter */
+#define CPU_FEATURE_SCALEFREQ		20	/* CPU support scale cpufreq */
+#define CPU_FEATURE_GUESTID		21	/* CPU has GuestID feature */
+#define CPU_FEATURE_HYPERVISOR		22	/* CPU has hypervisor (run in VM) */
+
+#define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
+#define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
+#define LOONGARCH_CPU_UAL		BIT_ULL(CPU_FEATURE_UAL)
+#define LOONGARCH_CPU_FPU		BIT_ULL(CPU_FEATURE_FPU)
+#define LOONGARCH_CPU_LSX		BIT_ULL(CPU_FEATURE_LSX)
+#define LOONGARCH_CPU_LASX		BIT_ULL(CPU_FEATURE_LASX)
+#define LOONGARCH_CPU_COMPLEX		BIT_ULL(CPU_FEATURE_COMPLEX)
+#define LOONGARCH_CPU_CRYPTO		BIT_ULL(CPU_FEATURE_CRYPTO)
+#define LOONGARCH_CPU_LVZ		BIT_ULL(CPU_FEATURE_LVZ)
+#define LOONGARCH_CPU_LBT_X86		BIT_ULL(CPU_FEATURE_LBT_X86)
+#define LOONGARCH_CPU_LBT_ARM		BIT_ULL(CPU_FEATURE_LBT_ARM)
+#define LOONGARCH_CPU_LBT_MIPS		BIT_ULL(CPU_FEATURE_LBT_MIPS)
+#define LOONGARCH_CPU_TLB		BIT_ULL(CPU_FEATURE_TLB)
+#define LOONGARCH_CPU_CSR		BIT_ULL(CPU_FEATURE_CSR)
+#define LOONGARCH_CPU_WATCH		BIT_ULL(CPU_FEATURE_WATCH)
+#define LOONGARCH_CPU_VINT		BIT_ULL(CPU_FEATURE_VINT)
+#define LOONGARCH_CPU_CSRIPI		BIT_ULL(CPU_FEATURE_CSRIPI)
+#define LOONGARCH_CPU_EXTIOI		BIT_ULL(CPU_FEATURE_EXTIOI)
+#define LOONGARCH_CPU_PREFETCH		BIT_ULL(CPU_FEATURE_PREFETCH)
+#define LOONGARCH_CPU_PMP		BIT_ULL(CPU_FEATURE_PMP)
+#define LOONGARCH_CPU_SCALEFREQ		BIT_ULL(CPU_FEATURE_SCALEFREQ)
+#define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
+#define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
+#endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
new file mode 100644
index 000000000000..17b43c28cd6b
--- /dev/null
+++ b/arch/loongarch/include/asm/fpregdef.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definitions for the FPU register names
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_FPREGDEF_H
+#define _ASM_FPREGDEF_H
+
+#include <asm/abidefs.h>
+
+#if _LOONGARCH_SIM == _LOONGARCH_SIM_ABILP64
+
+#define fv0	$f0	/* return value */
+#define fv1	$f2
+#define fa0	$f12	/* argument registers */
+#define fa1	$f13
+#define fa2	$f14
+#define fa3	$f15
+#define fa4	$f16
+#define fa5	$f17
+#define fa6	$f18
+#define fa7	$f19
+#define ft0	$f4	/* caller saved */
+#define ft1	$f5
+#define ft2	$f6
+#define ft3	$f7
+#define ft4	$f8
+#define ft5	$f9
+#define ft6	$f10
+#define ft7	$f11
+#define ft8	$f20
+#define ft9	$f21
+#define ft10	$f22
+#define ft11	$f23
+#define ft12	$f1
+#define ft13	$f3
+#define fs0	$f24	/* callee saved */
+#define fs1	$f25
+#define fs2	$f26
+#define fs3	$f27
+#define fs4	$f28
+#define fs5	$f29
+#define fs6	$f30
+#define fs7	$f31
+
+#endif /* _LOONGARCH_SIM == _LOONGARCH_SIM_ABILP64 */
+
+#define fcsr0	$r0
+#define fcsr1	$r1
+#define fcsr2	$r2
+#define fcsr3	$r3
+#define vcsr16	$r16
+
+#endif /* _ASM_FPREGDEF_H */
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
new file mode 100644
index 000000000000..ae0e5aa4f6c6
--- /dev/null
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -0,0 +1,1509 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_LOONGARCH_H
+#define _ASM_LOONGARCH_H
+
+#include <linux/bits.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+
+#ifndef __ASSEMBLY__
+#include <larchintrin.h>
+
+/*
+ * parse_r var, r - Helper assembler macro for parsing register names.
+ *
+ * This converts the register name in $n form provided in \r to the
+ * corresponding register number, which is assigned to the variable \var. It is
+ * needed to allow explicit encoding of instructions in inline assembly where
+ * registers are chosen by the compiler in $n form, allowing us to avoid using
+ * fixed register numbers.
+ *
+ * It also allows newer instructions (not implemented by the assembler) to be
+ * transparently implemented using assembler macros, instead of needing separate
+ * cases depending on toolchain support.
+ *
+ * Simple usage example:
+ * __asm__ __volatile__("parse_r addr, %0\n\t"
+ *			"#invtlb op, 0, %0\n\t"
+ *			".word ((0x6498000) | (addr << 10) | (0 << 5) | op)"
+ *			: "=r" (status);
+ */
+
+/* Match an individual register number and assign to \var */
+#define _IFC_REG(n)				\
+	".ifc	\\r, $r" #n "\n\t"		\
+	"\\var	= " #n "\n\t"			\
+	".endif\n\t"
+
+__asm__(".macro	parse_r var r\n\t"
+	"\\var	= -1\n\t"
+	_IFC_REG(0)  _IFC_REG(1)  _IFC_REG(2)  _IFC_REG(3)
+	_IFC_REG(4)  _IFC_REG(5)  _IFC_REG(6)  _IFC_REG(7)
+	_IFC_REG(8)  _IFC_REG(9)  _IFC_REG(10) _IFC_REG(11)
+	_IFC_REG(12) _IFC_REG(13) _IFC_REG(14) _IFC_REG(15)
+	_IFC_REG(16) _IFC_REG(17) _IFC_REG(18) _IFC_REG(19)
+	_IFC_REG(20) _IFC_REG(21) _IFC_REG(22) _IFC_REG(23)
+	_IFC_REG(24) _IFC_REG(25) _IFC_REG(26) _IFC_REG(27)
+	_IFC_REG(28) _IFC_REG(29) _IFC_REG(30) _IFC_REG(31)
+	".iflt	\\var\n\t"
+	".error	\"Unable to parse register name \\r\"\n\t"
+	".endif\n\t"
+	".endm");
+
+#undef _IFC_REG
+
+/* CPUCFG */
+static inline u32 read_cpucfg(u32 reg)
+{
+	return __cpucfg(reg);
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#ifdef __ASSEMBLY__
+
+/* LoongArch Registers */
+#define REG_RA	0x1
+#define REG_TP	0x2
+#define REG_SP	0x3
+#define REG_A0	0x4
+#define REG_A1	0x5
+#define REG_A2	0x6
+#define REG_A3	0x7
+#define REG_A4	0x8
+#define REG_A5	0x9
+#define REG_A6	0xa
+#define REG_A7	0xb
+#define REG_V0	REG_A0
+#define REG_V1	REG_A1
+#define REG_T0	0xc
+#define REG_T1	0xd
+#define REG_T2	0xe
+#define REG_T3	0xf
+#define REG_T4	0x10
+#define REG_T5	0x11
+#define REG_T6	0x12
+#define REG_T7	0x13
+#define REG_T8	0x14
+#define REG_X0	0x15
+#define REG_FP	0x16
+#define REG_S0	0x17
+#define REG_S1	0x18
+#define REG_S2	0x19
+#define REG_S3	0x1a
+#define REG_S4	0x1b
+#define REG_S5	0x1c
+#define REG_S6	0x1d
+#define REG_S7	0x1e
+#define REG_S8	0x1f
+
+#endif /* __ASSEMBLY__ */
+
+/* Bit Domains for CPUCFG registers */
+#define LOONGARCH_CPUCFG0		0x0
+#define  CPUCFG0_PRID			GENMASK(31, 0)
+
+#define LOONGARCH_CPUCFG1		0x1
+#define  CPUCFG1_ISGR32			BIT(0)
+#define  CPUCFG1_ISGR64			BIT(1)
+#define  CPUCFG1_PAGING			BIT(2)
+#define  CPUCFG1_IOCSR			BIT(3)
+#define  CPUCFG1_PABITS			GENMASK(11, 4)
+#define  CPUCFG1_VABITS			GENMASK(19, 12)
+#define  CPUCFG1_UAL			BIT(20)
+#define  CPUCFG1_RI			BIT(21)
+#define  CPUCFG1_XI			BIT(22)
+#define  CPUCFG1_RPLV			BIT(23)
+#define  CPUCFG1_HUGEPG			BIT(24)
+#define  CPUCFG1_IOCSRBRD		BIT(25)
+#define  CPUCFG1_MSGINT			BIT(26)
+
+#define LOONGARCH_CPUCFG2		0x2
+#define  CPUCFG2_FP			BIT(0)
+#define  CPUCFG2_FPSP			BIT(1)
+#define  CPUCFG2_FPDP			BIT(2)
+#define  CPUCFG2_FPVERS			GENMASK(5, 3)
+#define  CPUCFG2_LSX			BIT(6)
+#define  CPUCFG2_LASX			BIT(7)
+#define  CPUCFG2_COMPLEX		BIT(8)
+#define  CPUCFG2_CRYPTO			BIT(9)
+#define  CPUCFG2_LVZP			BIT(10)
+#define  CPUCFG2_LVZVER			GENMASK(13, 11)
+#define  CPUCFG2_LLFTP			BIT(14)
+#define  CPUCFG2_LLFTPREV		GENMASK(17, 15)
+#define  CPUCFG2_X86BT			BIT(18)
+#define  CPUCFG2_ARMBT			BIT(19)
+#define  CPUCFG2_MIPSBT			BIT(20)
+#define  CPUCFG2_LSPW			BIT(21)
+#define  CPUCFG2_LAM			BIT(22)
+
+#define LOONGARCH_CPUCFG3		0x3
+#define  CPUCFG3_CCDMA			BIT(0)
+#define  CPUCFG3_SFB			BIT(1)
+#define  CPUCFG3_UCACC			BIT(2)
+#define  CPUCFG3_LLEXC			BIT(3)
+#define  CPUCFG3_SCDLY			BIT(4)
+#define  CPUCFG3_LLDBAR			BIT(5)
+#define  CPUCFG3_ITLBT			BIT(6)
+#define  CPUCFG3_ICACHET		BIT(7)
+#define  CPUCFG3_SPW_LVL		GENMASK(10, 8)
+#define  CPUCFG3_SPW_HG_HF		BIT(11)
+#define  CPUCFG3_RVA			BIT(12)
+#define  CPUCFG3_RVAMAX			GENMASK(16, 13)
+
+#define LOONGARCH_CPUCFG4		0x4
+#define  CPUCFG4_CCFREQ			GENMASK(31, 0)
+
+#define LOONGARCH_CPUCFG5		0x5
+#define  CPUCFG5_CCMUL			GENMASK(15, 0)
+#define  CPUCFG5_CCDIV			GENMASK(31, 16)
+
+#define LOONGARCH_CPUCFG6		0x6
+#define  CPUCFG6_PMP			BIT(0)
+#define  CPUCFG6_PAMVER			GENMASK(3, 1)
+#define  CPUCFG6_PMNUM			GENMASK(7, 4)
+#define  CPUCFG6_PMBITS			GENMASK(13, 8)
+#define  CPUCFG6_UPM			BIT(14)
+
+#define LOONGARCH_CPUCFG16		0x10
+#define  CPUCFG16_L1_IUPRE		BIT(0)
+#define  CPUCFG16_L1_UNIFY		BIT(1)
+#define  CPUCFG16_L1_DPRE		BIT(2)
+#define  CPUCFG16_L2_IUPRE		BIT(3)
+#define  CPUCFG16_L2_IUUNIFY		BIT(4)
+#define  CPUCFG16_L2_IUPRIV		BIT(5)
+#define  CPUCFG16_L2_IUINCL		BIT(6)
+#define  CPUCFG16_L2_DPRE		BIT(7)
+#define  CPUCFG16_L2_DPRIV		BIT(8)
+#define  CPUCFG16_L2_DINCL		BIT(9)
+#define  CPUCFG16_L3_IUPRE		BIT(10)
+#define  CPUCFG16_L3_IUUNIFY		BIT(11)
+#define  CPUCFG16_L3_IUPRIV		BIT(12)
+#define  CPUCFG16_L3_IUINCL		BIT(13)
+#define  CPUCFG16_L3_DPRE		BIT(14)
+#define  CPUCFG16_L3_DPRIV		BIT(15)
+#define  CPUCFG16_L3_DINCL		BIT(16)
+
+#define LOONGARCH_CPUCFG17		0x11
+#define  CPUCFG17_L1I_WAYS_M		GENMASK(15, 0)
+#define  CPUCFG17_L1I_SETS_M		GENMASK(23, 16)
+#define  CPUCFG17_L1I_SIZE_M		GENMASK(30, 24)
+#define  CPUCFG17_L1I_WAYS		0
+#define  CPUCFG17_L1I_SETS		16
+#define  CPUCFG17_L1I_SIZE		24
+
+#define LOONGARCH_CPUCFG18		0x12
+#define  CPUCFG18_L1D_WAYS_M		GENMASK(15, 0)
+#define  CPUCFG18_L1D_SETS_M		GENMASK(23, 16)
+#define  CPUCFG18_L1D_SIZE_M		GENMASK(30, 24)
+#define  CPUCFG18_L1D_WAYS		0
+#define  CPUCFG18_L1D_SETS		16
+#define  CPUCFG18_L1D_SIZE		24
+
+#define LOONGARCH_CPUCFG19		0x13
+#define  CPUCFG19_L2_WAYS_M		GENMASK(15, 0)
+#define  CPUCFG19_L2_SETS_M		GENMASK(23, 16)
+#define  CPUCFG19_L2_SIZE_M		GENMASK(30, 24)
+#define  CPUCFG19_L2_WAYS		0
+#define  CPUCFG19_L2_SETS		16
+#define  CPUCFG19_L2_SIZE		24
+
+#define LOONGARCH_CPUCFG20		0x14
+#define  CPUCFG20_L3_WAYS_M		GENMASK(15, 0)
+#define  CPUCFG20_L3_SETS_M		GENMASK(23, 16)
+#define  CPUCFG20_L3_SIZE_M		GENMASK(30, 24)
+#define  CPUCFG20_L3_WAYS		0
+#define  CPUCFG20_L3_SETS		16
+#define  CPUCFG20_L3_SIZE		24
+
+#define LOONGARCH_CPUCFG48		0x30
+#define  CPUCFG48_MCSR_LCK		BIT(0)
+#define  CPUCFG48_NAP_EN		BIT(1)
+#define  CPUCFG48_VFPU_CG		BIT(2)
+#define  CPUCFG48_RAM_CG		BIT(3)
+
+#ifndef __ASSEMBLY__
+
+/* CSR */
+static inline u32 csr_readl(u32 reg)
+{
+	return __csrrd(reg);
+}
+
+static inline u64 csr_readq(u32 reg)
+{
+	return __dcsrrd(reg);
+}
+
+static inline void csr_writel(u32 val, u32 reg)
+{
+	__csrwr(val, reg);
+}
+
+static inline void csr_writeq(u64 val, u32 reg)
+{
+	__dcsrwr(val, reg);
+}
+
+static inline u32 csr_xchgl(u32 val, u32 mask, u32 reg)
+{
+	return __csrxchg(val, mask, reg);
+}
+
+static inline u64 csr_xchgq(u64 val, u64 mask, u32 reg)
+{
+	return __dcsrxchg(val, mask, reg);
+}
+
+/* IOCSR */
+static inline u32 iocsr_readl(u32 reg)
+{
+	return __iocsrrd_w(reg);
+}
+
+static inline u64 iocsr_readq(u32 reg)
+{
+	return __iocsrrd_d(reg);
+}
+
+static inline void iocsr_writel(u32 val, u32 reg)
+{
+	__iocsrwr_w(val, reg);
+}
+
+static inline void iocsr_writeq(u64 val, u32 reg)
+{
+	__iocsrwr_d(val, reg);
+}
+
+#endif /* !__ASSEMBLY__ */
+
+/* CSR register number */
+
+/* Basic CSR registers */
+#define LOONGARCH_CSR_CRMD		0x0	/* Current mode info */
+#define  CSR_CRMD_DACM_SHIFT		7
+#define  CSR_CRMD_DACM_WIDTH		2
+#define  CSR_CRMD_DACM			(_ULCAST_(0x3) << CSR_CRMD_DACM_SHIFT)
+#define  CSR_CRMD_DACF_SHIFT		5
+#define  CSR_CRMD_DACF_WIDTH		2
+#define  CSR_CRMD_DACF			(_ULCAST_(0x3) << CSR_CRMD_DACF_SHIFT)
+#define  CSR_CRMD_PG_SHIFT		4
+#define  CSR_CRMD_PG			(_ULCAST_(0x1) << CSR_CRMD_PG_SHIFT)
+#define  CSR_CRMD_DA_SHIFT		3
+#define  CSR_CRMD_DA			(_ULCAST_(0x1) << CSR_CRMD_DA_SHIFT)
+#define  CSR_CRMD_IE_SHIFT		2
+#define  CSR_CRMD_IE			(_ULCAST_(0x1) << CSR_CRMD_IE_SHIFT)
+#define  CSR_CRMD_PLV_SHIFT		0
+#define  CSR_CRMD_PLV_WIDTH		2
+#define  CSR_CRMD_PLV			(_ULCAST_(0x3) << CSR_CRMD_PLV_SHIFT)
+
+#define PLV_KERN			0
+#define PLV_USER			3
+#define PLV_MASK			0x3
+
+#define LOONGARCH_CSR_PRMD		0x1	/* Prev-exception mode info */
+#define  CSR_PRMD_PIE_SHIFT		2
+#define  CSR_PRMD_PIE			(_ULCAST_(0x1) << CSR_PRMD_PIE_SHIFT)
+#define  CSR_PRMD_PPLV_SHIFT		0
+#define  CSR_PRMD_PPLV_WIDTH		2
+#define  CSR_PRMD_PPLV			(_ULCAST_(0x3) << CSR_PRMD_PPLV_SHIFT)
+
+#define LOONGARCH_CSR_EUEN		0x2	/* Extended unit enable */
+#define  CSR_EUEN_LBTEN_SHIFT		3
+#define  CSR_EUEN_LBTEN			(_ULCAST_(0x1) << CSR_EUEN_LBTEN_SHIFT)
+#define  CSR_EUEN_LASXEN_SHIFT		2
+#define  CSR_EUEN_LASXEN		(_ULCAST_(0x1) << CSR_EUEN_LASXEN_SHIFT)
+#define  CSR_EUEN_LSXEN_SHIFT		1
+#define  CSR_EUEN_LSXEN			(_ULCAST_(0x1) << CSR_EUEN_LSXEN_SHIFT)
+#define  CSR_EUEN_FPEN_SHIFT		0
+#define  CSR_EUEN_FPEN			(_ULCAST_(0x1) << CSR_EUEN_FPEN_SHIFT)
+
+#define LOONGARCH_CSR_MISC		0x3	/* Misc config */
+
+#define LOONGARCH_CSR_ECFG		0x4	/* Exception config */
+#define  CSR_ECFG_VS_SHIFT		16
+#define  CSR_ECFG_VS_WIDTH		3
+#define  CSR_ECFG_VS			(_ULCAST_(0x7) << CSR_ECFG_VS_SHIFT)
+#define  CSR_ECFG_IM_SHIFT		0
+#define  CSR_ECFG_IM_WIDTH		13
+#define  CSR_ECFG_IM			(_ULCAST_(0x1fff) << CSR_ECFG_IM_SHIFT)
+
+#define LOONGARCH_CSR_ESTAT		0x5	/* Exception status */
+#define  CSR_ESTAT_ESUBCODE_SHIFT	22
+#define  CSR_ESTAT_ESUBCODE_WIDTH	9
+#define  CSR_ESTAT_ESUBCODE		(_ULCAST_(0x1ff) << CSR_ESTAT_ESUBCODE_SHIFT)
+#define  CSR_ESTAT_EXC_SHIFT		16
+#define  CSR_ESTAT_EXC_WIDTH		6
+#define  CSR_ESTAT_EXC			(_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
+#define  CSR_ESTAT_IS_SHIFT		0
+#define  CSR_ESTAT_IS_WIDTH		15
+#define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
+
+#define LOONGARCH_CSR_EPC		0x6	/* EPC */
+
+#define LOONGARCH_CSR_BADV		0x7	/* Bad virtual address */
+
+#define LOONGARCH_CSR_BADI		0x8	/* Bad instruction */
+
+#define LOONGARCH_CSR_EENTRY		0xc	/* Exception entry */
+
+/* TLB related CSR registers */
+#define LOONGARCH_CSR_TLBIDX		0x10	/* TLB Index, EHINV, PageSize, NP */
+#define  CSR_TLBIDX_EHINV_SHIFT		31
+#define  CSR_TLBIDX_EHINV		(_ULCAST_(1) << CSR_TLBIDX_EHINV_SHIFT)
+#define  CSR_TLBIDX_PS_SHIFT		24
+#define  CSR_TLBIDX_PS_WIDTH		6
+#define  CSR_TLBIDX_PS			(_ULCAST_(0x3f) << CSR_TLBIDX_PS_SHIFT)
+#define  CSR_TLBIDX_IDX_SHIFT		0
+#define  CSR_TLBIDX_IDX_WIDTH		12
+#define  CSR_TLBIDX_IDX			(_ULCAST_(0xfff) << CSR_TLBIDX_IDX_SHIFT)
+#define  CSR_TLBIDX_SIZEM		0x3f000000
+#define  CSR_TLBIDX_SIZE		CSR_TLBIDX_PS_SHIFT
+#define  CSR_TLBIDX_IDXM		0xfff
+#define  CSR_INVALID_ENTRY(e)		(CSR_TLBIDX_EHINV | e)
+
+#define LOONGARCH_CSR_TLBEHI		0x11	/* TLB EntryHi */
+
+#define LOONGARCH_CSR_TLBELO0		0x12	/* TLB EntryLo0 */
+#define  CSR_TLBLO0_RPLV_SHIFT		63
+#define  CSR_TLBLO0_RPLV		(_ULCAST_(0x1) << CSR_TLBLO0_RPLV_SHIFT)
+#define  CSR_TLBLO0_XI_SHIFT		62
+#define  CSR_TLBLO0_XI			(_ULCAST_(0x1) << CSR_TLBLO0_XI_SHIFT)
+#define  CSR_TLBLO0_RI_SHIFT		61
+#define  CSR_TLBLO0_RI			(_ULCAST_(0x1) << CSR_TLBLO0_RI_SHIFT)
+#define  CSR_TLBLO0_PFN_SHIFT		12
+#define  CSR_TLBLO0_PFN_WIDTH		36
+#define  CSR_TLBLO0_PFN			(_ULCAST_(0xfffffffff) << CSR_TLBLO0_PFN_SHIFT)
+#define  CSR_TLBLO0_GLOBAL_SHIFT	6
+#define  CSR_TLBLO0_GLOBAL		(_ULCAST_(0x1) << CSR_TLBLO0_GLOBAL_SHIFT)
+#define  CSR_TLBLO0_CCA_SHIFT		4
+#define  CSR_TLBLO0_CCA_WIDTH		2
+#define  CSR_TLBLO0_CCA			(_ULCAST_(0x3) << CSR_TLBLO0_CCA_SHIFT)
+#define  CSR_TLBLO0_PLV_SHIFT		2
+#define  CSR_TLBLO0_PLV_WIDTH		2
+#define  CSR_TLBLO0_PLV			(_ULCAST_(0x3) << CSR_TLBLO0_PLV_SHIFT)
+#define  CSR_TLBLO0_WE_SHIFT		1
+#define  CSR_TLBLO0_WE			(_ULCAST_(0x1) << CSR_TLBLO0_WE_SHIFT)
+#define  CSR_TLBLO0_V_SHIFT		0
+#define  CSR_TLBLO0_V			(_ULCAST_(0x1) << CSR_TLBLO0_V_SHIFT)
+
+#define LOONGARCH_CSR_TLBELO1		0x13	/* TLB EntryLo1 */
+#define  CSR_TLBLO1_RPLV_SHIFT		63
+#define  CSR_TLBLO1_RPLV		(_ULCAST_(0x1) << CSR_TLBLO1_RPLV_SHIFT)
+#define  CSR_TLBLO1_XI_SHIFT		62
+#define  CSR_TLBLO1_XI			(_ULCAST_(0x1) << CSR_TLBLO1_XI_SHIFT)
+#define  CSR_TLBLO1_RI_SHIFT		61
+#define  CSR_TLBLO1_RI			(_ULCAST_(0x1) << CSR_TLBLO1_RI_SHIFT)
+#define  CSR_TLBLO1_PFN_SHIFT		12
+#define  CSR_TLBLO1_PFN_WIDTH		36
+#define  CSR_TLBLO1_PFN			(_ULCAST_(0xfffffffff) << CSR_TLBLO1_PFN_SHIFT)
+#define  CSR_TLBLO1_GLOBAL_SHIFT	6
+#define  CSR_TLBLO1_GLOBAL		(_ULCAST_(0x1) << CSR_TLBLO1_GLOBAL_SHIFT)
+#define  CSR_TLBLO1_CCA_SHIFT		4
+#define  CSR_TLBLO1_CCA_WIDTH		2
+#define  CSR_TLBLO1_CCA			(_ULCAST_(0x3) << CSR_TLBLO1_CCA_SHIFT)
+#define  CSR_TLBLO1_PLV_SHIFT		2
+#define  CSR_TLBLO1_PLV_WIDTH		2
+#define  CSR_TLBLO1_PLV			(_ULCAST_(0x3) << CSR_TLBLO1_PLV_SHIFT)
+#define  CSR_TLBLO1_WE_SHIFT		1
+#define  CSR_TLBLO1_WE			(_ULCAST_(0x1) << CSR_TLBLO1_WE_SHIFT)
+#define  CSR_TLBLO1_V_SHIFT		0
+#define  CSR_TLBLO1_V			(_ULCAST_(0x1) << CSR_TLBLO1_V_SHIFT)
+
+#define LOONGARCH_CSR_GTLBC		0x15	/* Guest TLB control */
+#define  CSR_GTLBC_RID_SHIFT		16
+#define  CSR_GTLBC_RID_WIDTH		8
+#define  CSR_GTLBC_RID			(_ULCAST_(0xff) << CSR_GTLBC_RID_SHIFT)
+#define  CSR_GTLBC_TOTI_SHIFT		13
+#define  CSR_GTLBC_TOTI			(_ULCAST_(0x1) << CSR_GTLBC_TOTI_SHIFT)
+#define  CSR_GTLBC_USERID_SHIFT		12
+#define  CSR_GTLBC_USERID		(_ULCAST_(0x1) << CSR_GTLBC_USERID_SHIFT)
+#define  CSR_GTLBC_GMTLBSZ_SHIFT	0
+#define  CSR_GTLBC_GMTLBSZ_WIDTH	6
+#define  CSR_GTLBC_GMTLBSZ		(_ULCAST_(0x3f) << CSR_GTLBC_GMTLBSZ_SHIFT)
+
+#define LOONGARCH_CSR_TRGP		0x16	/* TLBR read guest info */
+#define  CSR_TRGP_RID_SHIFT		16
+#define  CSR_TRGP_RID_WIDTH		8
+#define  CSR_TRGP_RID			(_ULCAST_(0xff) << CSR_TRGP_RID_SHIFT)
+#define  CSR_TRGP_GTLB_SHIFT		0
+#define  CSR_TRGP_GTLB			(1 << CSR_TRGP_GTLB_SHIFT)
+
+#define LOONGARCH_CSR_ASID		0x18	/* ASID */
+#define  CSR_ASID_BIT_SHIFT		16	/* ASIDBits */
+#define  CSR_ASID_BIT_WIDTH		8
+#define  CSR_ASID_BIT			(_ULCAST_(0xff) << CSR_ASID_BIT_SHIFT)
+#define  CSR_ASID_ASID_SHIFT		0
+#define  CSR_ASID_ASID_WIDTH		10
+#define  CSR_ASID_ASID			(_ULCAST_(0x3ff) << CSR_ASID_ASID_SHIFT)
+
+#define LOONGARCH_CSR_PGDL		0x19	/* Page table base address when VA[47] = 0 */
+
+#define LOONGARCH_CSR_PGDH		0x1a	/* Page table base address when VA[47] = 1 */
+
+#define LOONGARCH_CSR_PGD		0x1b	/* Page table base */
+
+#define LOONGARCH_CSR_PWCTL0		0x1c	/* PWCtl0 */
+#define  CSR_PWCTL0_PTEW_SHIFT		30
+#define  CSR_PWCTL0_PTEW_WIDTH		2
+#define  CSR_PWCTL0_PTEW		(_ULCAST_(0x3) << CSR_PWCTL0_PTEW_SHIFT)
+#define  CSR_PWCTL0_DIR1WIDTH_SHIFT	25
+#define  CSR_PWCTL0_DIR1WIDTH_WIDTH	5
+#define  CSR_PWCTL0_DIR1WIDTH		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR1WIDTH_SHIFT)
+#define  CSR_PWCTL0_DIR1BASE_SHIFT	20
+#define  CSR_PWCTL0_DIR1BASE_WIDTH	5
+#define  CSR_PWCTL0_DIR1BASE		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR1BASE_SHIFT)
+#define  CSR_PWCTL0_DIR0WIDTH_SHIFT	15
+#define  CSR_PWCTL0_DIR0WIDTH_WIDTH	5
+#define  CSR_PWCTL0_DIR0WIDTH		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR0WIDTH_SHIFT)
+#define  CSR_PWCTL0_DIR0BASE_SHIFT	10
+#define  CSR_PWCTL0_DIR0BASE_WIDTH	5
+#define  CSR_PWCTL0_DIR0BASE		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR0BASE_SHIFT)
+#define  CSR_PWCTL0_PTWIDTH_SHIFT	5
+#define  CSR_PWCTL0_PTWIDTH_WIDTH	5
+#define  CSR_PWCTL0_PTWIDTH		(_ULCAST_(0x1f) << CSR_PWCTL0_PTWIDTH_SHIFT)
+#define  CSR_PWCTL0_PTBASE_SHIFT	0
+#define  CSR_PWCTL0_PTBASE_WIDTH	5
+#define  CSR_PWCTL0_PTBASE		(_ULCAST_(0x1f) << CSR_PWCTL0_PTBASE_SHIFT)
+
+#define LOONGARCH_CSR_PWCTL1		0x1d	/* PWCtl1 */
+#define  CSR_PWCTL1_DIR3WIDTH_SHIFT	18
+#define  CSR_PWCTL1_DIR3WIDTH_WIDTH	5
+#define  CSR_PWCTL1_DIR3WIDTH		(_ULCAST_(0x1f) << CSR_PWCTL1_DIR3WIDTH_SHIFT)
+#define  CSR_PWCTL1_DIR3BASE_SHIFT	12
+#define  CSR_PWCTL1_DIR3BASE_WIDTH	5
+#define  CSR_PWCTL1_DIR3BASE		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR3BASE_SHIFT)
+#define  CSR_PWCTL1_DIR2WIDTH_SHIFT	6
+#define  CSR_PWCTL1_DIR2WIDTH_WIDTH	5
+#define  CSR_PWCTL1_DIR2WIDTH		(_ULCAST_(0x1f) << CSR_PWCTL1_DIR2WIDTH_SHIFT)
+#define  CSR_PWCTL1_DIR2BASE_SHIFT	0
+#define  CSR_PWCTL1_DIR2BASE_WIDTH	5
+#define  CSR_PWCTL1_DIR2BASE		(_ULCAST_(0x1f) << CSR_PWCTL0_DIR2BASE_SHIFT)
+
+#define LOONGARCH_CSR_STLBPGSIZE	0x1e
+#define  CSR_STLBPGSIZE_PS_WIDTH	6
+#define  CSR_STLBPGSIZE_PS		(_ULCAST_(0x3f))
+
+#define LOONGARCH_CSR_RVACFG		0x1f
+#define  CSR_RVACFG_RDVA_WIDTH		4
+#define  CSR_RVACFG_RDVA		(_ULCAST_(0xf))
+
+/* Config CSR registers */
+#define LOONGARCH_CSR_CPUID		0x20	/* CPU core id */
+#define  CSR_CPUID_COREID_WIDTH		9
+#define  CSR_CPUID_COREID		_ULCAST_(0x1ff)
+
+#define LOONGARCH_CSR_PRCFG1		0x21	/* Config1 */
+#define  CSR_CONF1_VSMAX_SHIFT		12
+#define  CSR_CONF1_VSMAX_WIDTH		3
+#define  CSR_CONF1_VSMAX		(_ULCAST_(7) << CSR_CONF1_VSMAX_SHIFT)
+#define  CSR_CONF1_TMRBITS_SHIFT	4
+#define  CSR_CONF1_TMRBITS_WIDTH	8
+#define  CSR_CONF1_TMRBITS		(_ULCAST_(0xff) << CSR_CONF1_TMRBITS_SHIFT)
+#define  CSR_CONF1_KSNUM_WIDTH		4
+#define  CSR_CONF1_KSNUM		_ULCAST_(0xf)
+
+#define LOONGARCH_CSR_PRCFG2		0x22	/* Config2 */
+#define  CSR_CONF2_PGMASK_SUPP		0x3ffff000
+
+#define LOONGARCH_CSR_PRCFG3		0x23	/* Config3 */
+#define  CSR_CONF3_STLBIDX_SHIFT	20
+#define  CSR_CONF3_STLBIDX_WIDTH	6
+#define  CSR_CONF3_STLBIDX		(_ULCAST_(0x3f) << CSR_CONF3_STLBIDX_SHIFT)
+#define  CSR_CONF3_STLBWAYS_SHIFT	12
+#define  CSR_CONF3_STLBWAYS_WIDTH	8
+#define  CSR_CONF3_STLBWAYS		(_ULCAST_(0xff) << CSR_CONF3_STLBWAYS_SHIFT)
+#define  CSR_CONF3_MTLBSIZE_SHIFT	4
+#define  CSR_CONF3_MTLBSIZE_WIDTH	8
+#define  CSR_CONF3_MTLBSIZE		(_ULCAST_(0xff) << CSR_CONF3_MTLBSIZE_SHIFT)
+#define  CSR_CONF3_TLBTYPE_SHIFT	0
+#define  CSR_CONF3_TLBTYPE_WIDTH	4
+#define  CSR_CONF3_TLBTYPE		(_ULCAST_(0xf) << CSR_CONF3_TLBTYPE_SHIFT)
+
+/* Kscratch registers */
+#define LOONGARCH_CSR_KS0		0x30
+#define LOONGARCH_CSR_KS1		0x31
+#define LOONGARCH_CSR_KS2		0x32
+#define LOONGARCH_CSR_KS3		0x33
+#define LOONGARCH_CSR_KS4		0x34
+#define LOONGARCH_CSR_KS5		0x35
+#define LOONGARCH_CSR_KS6		0x36
+#define LOONGARCH_CSR_KS7		0x37
+#define LOONGARCH_CSR_KS8		0x38
+
+/* Exception allocated KS0, KS1 and KS2 statically */
+#define EXCEPTION_KS0			LOONGARCH_CSR_KS0
+#define EXCEPTION_KS1			LOONGARCH_CSR_KS1
+#define EXCEPTION_KS2			LOONGARCH_CSR_KS2
+#define EXC_KSCRATCH_MASK		(1 << 0 | 1 << 1 | 1 << 2)
+
+/* Percpu-data base allocated KS3 statically */
+#define PERCPU_BASE_KS			LOONGARCH_CSR_KS3
+#define PERCPU_KSCRATCH_MASK		(1 << 3)
+
+/* KVM allocated KS4 and KS5 statically */
+#define KVM_VCPU_KS			LOONGARCH_CSR_KS4
+#define KVM_TEMP_KS			LOONGARCH_CSR_KS5
+#define KVM_KSCRATCH_MASK		(1 << 4 | 1 << 5)
+
+/* Timer registers */
+#define LOONGARCH_CSR_TMID		0x40	/* Timer ID */
+
+#define LOONGARCH_CSR_TCFG		0x41	/* Timer config */
+#define  CSR_TCFG_VAL_SHIFT		2
+#define	 CSR_TCFG_VAL_WIDTH		48
+#define  CSR_TCFG_VAL			(_ULCAST_(0x3fffffffffff) << CSR_TCFG_VAL_SHIFT)
+#define  CSR_TCFG_PERIOD_SHIFT		1
+#define  CSR_TCFG_PERIOD		(_ULCAST_(0x1) << CSR_TCFG_PERIOD_SHIFT)
+#define  CSR_TCFG_EN			(_ULCAST_(0x1))
+
+#define LOONGARCH_CSR_TVAL		0x42	/* Timer value */
+
+#define LOONGARCH_CSR_CNTC		0x43	/* Timer offset */
+
+#define LOONGARCH_CSR_TINTCLR		0x44	/* Timer interrupt clear */
+#define  CSR_TINTCLR_TI_SHIFT		0
+#define  CSR_TINTCLR_TI			(1 << CSR_TINTCLR_TI_SHIFT)
+
+/* Guest registers */
+#define LOONGARCH_CSR_GSTAT		0x50	/* Guest status */
+#define  CSR_GSTAT_GID_SHIFT		16
+#define  CSR_GSTAT_GID_WIDTH		8
+#define  CSR_GSTAT_GID			(_ULCAST_(0xff) << CSR_GSTAT_GID_SHIFT)
+#define  CSR_GSTAT_GIDBIT_SHIFT		4
+#define  CSR_GSTAT_GIDBIT_WIDTH		6
+#define  CSR_GSTAT_GIDBIT		(_ULCAST_(0x3f) << CSR_GSTAT_GIDBIT_SHIFT)
+#define  CSR_GSTAT_PVM_SHIFT		1
+#define  CSR_GSTAT_PVM			(_ULCAST_(0x1) << CSR_GSTAT_PVM_SHIFT)
+#define  CSR_GSTAT_VM_SHIFT		0
+#define  CSR_GSTAT_VM			(_ULCAST_(0x1) << CSR_GSTAT_VM_SHIFT)
+
+#define LOONGARCH_CSR_GCFG		0x51	/* Guest config */
+#define  CSR_GCFG_GPERF_SHIFT		24
+#define  CSR_GCFG_GPERF_WIDTH		3
+#define  CSR_GCFG_GPERF			(_ULCAST_(0x7) << CSR_GCFG_GPERF_SHIFT)
+#define  CSR_GCFG_GCI_SHIFT		20
+#define  CSR_GCFG_GCI_WIDTH		2
+#define  CSR_GCFG_GCI			(_ULCAST_(0x3) << CSR_GCFG_GCI_SHIFT)
+#define  CSR_GCFG_GCI_ALL		(_ULCAST_(0x0) << CSR_GCFG_GCI_SHIFT)
+#define  CSR_GCFG_GCI_HIT		(_ULCAST_(0x1) << CSR_GCFG_GCI_SHIFT)
+#define  CSR_GCFG_GCI_SECURE		(_ULCAST_(0x2) << CSR_GCFG_GCI_SHIFT)
+#define  CSR_GCFG_GCIP_SHIFT		16
+#define  CSR_GCFG_GCIP			(_ULCAST_(0xf) << CSR_GCFG_GCIP_SHIFT)
+#define  CSR_GCFG_GCIP_ALL		(_ULCAST_(0x1) << CSR_GCFG_GCIP_SHIFT)
+#define  CSR_GCFG_GCIP_HIT		(_ULCAST_(0x1) << (CSR_GCFG_GCIP_SHIFT + 1))
+#define  CSR_GCFG_GCIP_SECURE		(_ULCAST_(0x1) << (CSR_GCFG_GCIP_SHIFT + 2))
+#define  CSR_GCFG_TORU_SHIFT		15
+#define  CSR_GCFG_TORU			(_ULCAST_(0x1) << CSR_GCFG_TORU_SHIFT)
+#define  CSR_GCFG_TORUP_SHIFT		14
+#define  CSR_GCFG_TORUP			(_ULCAST_(0x1) << CSR_GCFG_TORUP_SHIFT)
+#define  CSR_GCFG_TOP_SHIFT		13
+#define  CSR_GCFG_TOP			(_ULCAST_(0x1) << CSR_GCFG_TOP_SHIFT)
+#define  CSR_GCFG_TOPP_SHIFT		12
+#define  CSR_GCFG_TOPP			(_ULCAST_(0x1) << CSR_GCFG_TOPP_SHIFT)
+#define  CSR_GCFG_TOE_SHIFT		11
+#define  CSR_GCFG_TOE			(_ULCAST_(0x1) << CSR_GCFG_TOE_SHIFT)
+#define  CSR_GCFG_TOEP_SHIFT		10
+#define  CSR_GCFG_TOEP			(_ULCAST_(0x1) << CSR_GCFG_TOEP_SHIFT)
+#define  CSR_GCFG_TIT_SHIFT		9
+#define  CSR_GCFG_TIT			(_ULCAST_(0x1) << CSR_GCFG_TIT_SHIFT)
+#define  CSR_GCFG_TITP_SHIFT		8
+#define  CSR_GCFG_TITP			(_ULCAST_(0x1) << CSR_GCFG_TITP_SHIFT)
+#define  CSR_GCFG_SIT_SHIFT		7
+#define  CSR_GCFG_SIT			(_ULCAST_(0x1) << CSR_GCFG_SIT_SHIFT)
+#define  CSR_GCFG_SITP_SHIFT		6
+#define  CSR_GCFG_SITP			(_ULCAST_(0x1) << CSR_GCFG_SITP_SHIFT)
+#define  CSR_GCFG_MATC_SHITF		4
+#define  CSR_GCFG_MATC_WIDTH		2
+#define  CSR_GCFG_MATC_MASK		(_ULCAST_(0x3) << CSR_GCFG_MATC_SHITF)
+#define  CSR_GCFG_MATC_GUEST		(_ULCAST_(0x0) << CSR_GCFG_MATC_SHITF)
+#define  CSR_GCFG_MATC_ROOT		(_ULCAST_(0x1) << CSR_GCFG_MATC_SHITF)
+#define  CSR_GCFG_MATC_NEST		(_ULCAST_(0x2) << CSR_GCFG_MATC_SHITF)
+
+#define LOONGARCH_CSR_GINTC		0x52	/* Guest interrupt control */
+#define  CSR_GINTC_HC_SHIFT		16
+#define  CSR_GINTC_HC_WIDTH		8
+#define  CSR_GINTC_HC			(_ULCAST_(0xff) << CSR_GINTC_HC_SHIFT)
+#define  CSR_GINTC_PIP_SHIFT		8
+#define  CSR_GINTC_PIP_WIDTH		8
+#define  CSR_GINTC_PIP			(_ULCAST_(0xff) << CSR_GINTC_PIP_SHIFT)
+#define  CSR_GINTC_VIP_SHIFT		0
+#define  CSR_GINTC_VIP_WIDTH		8
+#define  CSR_GINTC_VIP			(_ULCAST_(0xff))
+
+#define LOONGARCH_CSR_GCNTC		0x53	/* Guest timer offset */
+
+/* LLBCTL register */
+#define LOONGARCH_CSR_LLBCTL		0x60	/* LLBit control */
+#define  CSR_LLBCTL_ROLLB_SHIFT		0
+#define  CSR_LLBCTL_ROLLB		(_ULCAST_(1) << CSR_LLBCTL_ROLLB_SHIFT)
+#define  CSR_LLBCTL_WCLLB_SHIFT		1
+#define  CSR_LLBCTL_WCLLB		(_ULCAST_(1) << CSR_LLBCTL_WCLLB_SHIFT)
+#define  CSR_LLBCTL_KLO_SHIFT		2
+#define  CSR_LLBCTL_KLO			(_ULCAST_(1) << CSR_LLBCTL_KLO_SHIFT)
+
+/* Implement dependent */
+#define LOONGARCH_CSR_IMPCTL1		0x80	/* Loongson config1 */
+#define  CSR_MISPEC_SHIFT		20
+#define  CSR_MISPEC_WIDTH		8
+#define  CSR_MISPEC			(_ULCAST_(0xff) << CSR_MISPEC_SHIFT)
+#define  CSR_SSEN_SHIFT			18
+#define  CSR_SSEN			(_ULCAST_(1) << CSR_SSEN_SHIFT)
+#define  CSR_SCRAND_SHIFT		17
+#define  CSR_SCRAND			(_ULCAST_(1) << CSR_SCRAND_SHIFT)
+#define  CSR_LLEXCL_SHIFT		16
+#define  CSR_LLEXCL			(_ULCAST_(1) << CSR_LLEXCL_SHIFT)
+#define  CSR_DISVC_SHIFT		15
+#define  CSR_DISVC			(_ULCAST_(1) << CSR_DISVC_SHIFT)
+#define  CSR_VCLRU_SHIFT		14
+#define  CSR_VCLRU			(_ULCAST_(1) << CSR_VCLRU_SHIFT)
+#define  CSR_DCLRU_SHIFT		13
+#define  CSR_DCLRU			(_ULCAST_(1) << CSR_DCLRU_SHIFT)
+#define  CSR_FASTLDQ_SHIFT		12
+#define  CSR_FASTLDQ			(_ULCAST_(1) << CSR_FASTLDQ_SHIFT)
+#define  CSR_USERCAC_SHIFT		11
+#define  CSR_USERCAC			(_ULCAST_(1) << CSR_USERCAC_SHIFT)
+#define  CSR_ANTI_MISPEC_SHIFT		10
+#define  CSR_ANTI_MISPEC		(_ULCAST_(1) << CSR_ANTI_MISPEC_SHIFT)
+#define  CSR_AUTO_FLUSHSFB_SHIFT	9
+#define  CSR_AUTO_FLUSHSFB		(_ULCAST_(1) << CSR_AUTO_FLUSHSFB_SHIFT)
+#define  CSR_STFILL_SHIFT		8
+#define  CSR_STFILL			(_ULCAST_(1) << CSR_STFILL_SHIFT)
+#define  CSR_LIFEP_SHIFT		7
+#define  CSR_LIFEP			(_ULCAST_(1) << CSR_LIFEP_SHIFT)
+#define  CSR_LLSYNC_SHIFT		6
+#define  CSR_LLSYNC			(_ULCAST_(1) << CSR_LLSYNC_SHIFT)
+#define  CSR_BRBTDIS_SHIFT		5
+#define  CSR_BRBTDIS			(_ULCAST_(1) << CSR_BRBTDIS_SHIFT)
+#define  CSR_RASDIS_SHIFT		4
+#define  CSR_RASDIS			(_ULCAST_(1) << CSR_RASDIS_SHIFT)
+#define  CSR_STPRE_SHIFT		2
+#define  CSR_STPRE_WIDTH		2
+#define  CSR_STPRE			(_ULCAST_(3) << CSR_STPRE_SHIFT)
+#define  CSR_INSTPRE_SHIFT		1
+#define  CSR_INSTPRE			(_ULCAST_(1) << CSR_INSTPRE_SHIFT)
+#define  CSR_DATAPRE_SHIFT		0
+#define  CSR_DATAPRE			(_ULCAST_(1) << CSR_DATAPRE_SHIFT)
+
+#define LOONGARCH_CSR_IMPCTL2		0x81	/* Loongson config2 */
+#define  CSR_FLUSH_MTLB_SHIFT		0
+#define  CSR_FLUSH_MTLB			(_ULCAST_(1) << CSR_FLUSH_MTLB_SHIFT)
+#define  CSR_FLUSH_STLB_SHIFT		1
+#define  CSR_FLUSH_STLB			(_ULCAST_(1) << CSR_FLUSH_STLB_SHIFT)
+#define  CSR_FLUSH_DTLB_SHIFT		2
+#define  CSR_FLUSH_DTLB			(_ULCAST_(1) << CSR_FLUSH_DTLB_SHIFT)
+#define  CSR_FLUSH_ITLB_SHIFT		3
+#define  CSR_FLUSH_ITLB			(_ULCAST_(1) << CSR_FLUSH_ITLB_SHIFT)
+#define  CSR_FLUSH_BTAC_SHIFT		4
+#define  CSR_FLUSH_BTAC			(_ULCAST_(1) << CSR_FLUSH_BTAC_SHIFT)
+
+#define LOONGARCH_CSR_GNMI		0x82
+
+/* TLB Refill registers */
+#define LOONGARCH_CSR_TLBRENTRY		0x88	/* TLB refill exception entry */
+#define LOONGARCH_CSR_TLBRBADV		0x89	/* TLB refill badvaddr */
+#define LOONGARCH_CSR_TLBREPC		0x8a	/* TLB refill EPC */
+#define LOONGARCH_CSR_TLBRSAVE		0x8b	/* KScratch for TLB refill exception */
+#define LOONGARCH_CSR_TLBRELO0		0x8c	/* TLB refill entrylo0 */
+#define LOONGARCH_CSR_TLBRELO1		0x8d	/* TLB refill entrylo1 */
+#define LOONGARCH_CSR_TLBREHI		0x8e	/* TLB refill entryhi */
+#define LOONGARCH_CSR_TLBRPRMD		0x8f	/* TLB refill mode info */
+
+/* Machine Error registers */
+#define LOONGARCH_CSR_MERRCTL		0x90	/* MERRCTL */
+#define LOONGARCH_CSR_MERRINFO1		0x91	/* MError info1 */
+#define LOONGARCH_CSR_MERRINFO2		0x92	/* MError info2 */
+#define LOONGARCH_CSR_MERRENTRY		0x93	/* MError exception entry */
+#define LOONGARCH_CSR_MERREPC		0x94	/* MError exception PC */
+#define LOONGARCH_CSR_MERRSAVE		0x95	/* KScratch for machine error exception */
+
+#define LOONGARCH_CSR_CTAG		0x98	/* TagLo + TagHi */
+
+#define LOONGARCH_CSR_PRID		0xc0
+
+/* Shadow MCSR : 0xc0 ~ 0xff */
+#define LOONGARCH_CSR_MCSR0		0xc0	/* CPUCFG0 and CPUCFG1 */
+#define  MCSR0_INT_IMPL_SHIFT		58
+#define  MCSR0_INT_IMPL			0
+#define  MCSR0_IOCSR_BRD_SHIFT		57
+#define  MCSR0_IOCSR_BRD		(_ULCAST_(1) << MCSR0_IOCSR_BRD_SHIFT)
+#define  MCSR0_HUGEPG_SHIFT		56
+#define  MCSR0_HUGEPG			(_ULCAST_(1) << MCSR0_HUGEPG_SHIFT)
+#define  MCSR0_RPLMTLB_SHIFT		55
+#define  MCSR0_RPLMTLB			(_ULCAST_(1) << MCSR0_RPLMTLB_SHIFT)
+#define  MCSR0_EXEPROT_SHIFT		54
+#define  MCSR0_EXEPROT			(_ULCAST_(1) << MCSR0_EXEPROT_SHIFT)
+#define  MCSR0_RI_SHIFT			53
+#define  MCSR0_RI			(_ULCAST_(1) << MCSR0_RI_SHIFT)
+#define  MCSR0_UAL_SHIFT		52
+#define  MCSR0_UAL			(_ULCAST_(1) << MCSR0_UAL_SHIFT)
+#define  MCSR0_VABIT_SHIFT		44
+#define  MCSR0_VABIT_WIDTH		8
+#define  MCSR0_VABIT			(_ULCAST_(0xff) << MCSR0_VABIT_SHIFT)
+#define  VABIT_DEFAULT			0x2f
+#define  MCSR0_PABIT_SHIFT		36
+#define  MCSR0_PABIT_WIDTH		8
+#define  MCSR0_PABIT			(_ULCAST_(0xff) << MCSR0_PABIT_SHIFT)
+#define  PABIT_DEFAULT			0x2f
+#define  MCSR0_IOCSR_SHIFT		35
+#define  MCSR0_IOCSR			(_ULCAST_(1) << MCSR0_IOCSR_SHIFT)
+#define  MCSR0_PAGING_SHIFT		34
+#define  MCSR0_PAGING			(_ULCAST_(1) << MCSR0_PAGING_SHIFT)
+#define  MCSR0_GR64_SHIFT		33
+#define  MCSR0_GR64			(_ULCAST_(1) << MCSR0_GR64_SHIFT)
+#define  GR64_DEFAULT			1
+#define  MCSR0_GR32_SHIFT		32
+#define  MCSR0_GR32			(_ULCAST_(1) << MCSR0_GR32_SHIFT)
+#define  GR32_DEFAULT			0
+#define  MCSR0_PRID_WIDTH		32
+#define  MCSR0_PRID			0x14C010
+
+#define LOONGARCH_CSR_MCSR1		0xc1	/* CPUCFG2 and CPUCFG3 */
+#define  MCSR1_HPFOLD_SHIFT		43
+#define  MCSR1_HPFOLD			(_ULCAST_(1) << MCSR1_HPFOLD_SHIFT)
+#define  MCSR1_SPW_LVL_SHIFT		40
+#define  MCSR1_SPW_LVL_WIDTH		3
+#define  MCSR1_SPW_LVL			(_ULCAST_(7) << MCSR1_SPW_LVL_SHIFT)
+#define  MCSR1_ICACHET_SHIFT		39
+#define  MCSR1_ICACHET			(_ULCAST_(1) << MCSR1_ICACHET_SHIFT)
+#define  MCSR1_ITLBT_SHIFT		38
+#define  MCSR1_ITLBT			(_ULCAST_(1) << MCSR1_ITLBT_SHIFT)
+#define  MCSR1_LLDBAR_SHIFT		37
+#define  MCSR1_LLDBAR			(_ULCAST_(1) << MCSR1_LLDBAR_SHIFT)
+#define  MCSR1_SCDLY_SHIFT		36
+#define  MCSR1_SCDLY			(_ULCAST_(1) << MCSR1_SCDLY_SHIFT)
+#define  MCSR1_LLEXC_SHIFT		35
+#define  MCSR1_LLEXC			(_ULCAST_(1) << MCSR1_LLEXC_SHIFT)
+#define  MCSR1_UCACC_SHIFT		34
+#define  MCSR1_UCACC			(_ULCAST_(1) << MCSR1_UCACC_SHIFT)
+#define  MCSR1_SFB_SHIFT		33
+#define  MCSR1_SFB			(_ULCAST_(1) << MCSR1_SFB_SHIFT)
+#define  MCSR1_CCDMA_SHIFT		32
+#define  MCSR1_CCDMA			(_ULCAST_(1) << MCSR1_CCDMA_SHIFT)
+#define  MCSR1_LAMO_SHIFT		22
+#define  MCSR1_LAMO			(_ULCAST_(1) << MCSR1_LAMO_SHIFT)
+#define  MCSR1_LSPW_SHIFT		21
+#define  MCSR1_LSPW			(_ULCAST_(1) << MCSR1_LSPW_SHIFT)
+#define  MCSR1_LOONGARCHBT_SHIFT	20
+#define  MCSR1_LOONGARCHBT		(_ULCAST_(1) << MCSR1_LOONGARCHBT_SHIFT)
+#define  MCSR1_ARMBT_SHIFT		19
+#define  MCSR1_ARMBT			(_ULCAST_(1) << MCSR1_ARMBT_SHIFT)
+#define  MCSR1_X86BT_SHIFT		18
+#define  MCSR1_X86BT			(_ULCAST_(1) << MCSR1_X86BT_SHIFT)
+#define  MCSR1_LLFTPVERS_SHIFT		15
+#define  MCSR1_LLFTPVERS_WIDTH		3
+#define  MCSR1_LLFTPVERS		(_ULCAST_(7) << MCSR1_LLFTPVERS_SHIFT)
+#define  MCSR1_LLFTP_SHIFT		14
+#define  MCSR1_LLFTP			(_ULCAST_(1) << MCSR1_LLFTP_SHIFT)
+#define  MCSR1_VZVERS_SHIFT		11
+#define  MCSR1_VZVERS_WIDTH		3
+#define  MCSR1_VZVERS			(_ULCAST_(7) << MCSR1_VZVERS_SHIFT)
+#define  MCSR1_VZ_SHIFT			10
+#define  MCSR1_VZ			(_ULCAST_(1) << MCSR1_VZ_SHIFT)
+#define  MCSR1_CRYPTO_SHIFT		9
+#define  MCSR1_CRYPTO			(_ULCAST_(1) << MCSR1_CRYPTO_SHIFT)
+#define  MCSR1_COMPLEX_SHIFT		8
+#define  MCSR1_COMPLEX			(_ULCAST_(1) << MCSR1_COMPLEX_SHIFT)
+#define  MCSR1_LASX_SHIFT		7
+#define  MCSR1_LASX			(_ULCAST_(1) << MCSR1_LASX_SHIFT)
+#define  MCSR1_LSX_SHIFT		6
+#define  MCSR1_LSX			(_ULCAST_(1) << MCSR1_LSX_SHIFT)
+#define  MCSR1_FPVERS_SHIFT		3
+#define  MCSR1_FPVERS_WIDTH		3
+#define  MCSR1_FPVERS			(_ULCAST_(7) << MCSR1_FPVERS_SHIFT)
+#define  MCSR1_FPDP_SHIFT		2
+#define  MCSR1_FPDP			(_ULCAST_(1) << MCSR1_FPDP_SHIFT)
+#define  MCSR1_FPSP_SHIFT		1
+#define  MCSR1_FPSP			(_ULCAST_(1) << MCSR1_FPSP_SHIFT)
+#define  MCSR1_FP_SHIFT			0
+#define  MCSR1_FP			(_ULCAST_(1) << MCSR1_FP_SHIFT)
+
+#define LOONGARCH_CSR_MCSR2		0xc2	/* CPUCFG4 and CPUCFG5 */
+#define  MCSR2_CCDIV_SHIFT		48
+#define  MCSR2_CCDIV_WIDTH		16
+#define  MCSR2_CCDIV			(_ULCAST_(0xffff) << MCSR2_CCDIV_SHIFT)
+#define  MCSR2_CCMUL_SHIFT		32
+#define  MCSR2_CCMUL_WIDTH		16
+#define  MCSR2_CCMUL			(_ULCAST_(0xffff) << MCSR2_CCMUL_SHIFT)
+#define  MCSR2_CCFREQ_WIDTH		32
+#define  MCSR2_CCFREQ			(_ULCAST_(0xffffffff))
+#define  CCFREQ_DEFAULT			0x5f5e100	/* 100MHz */
+
+#define LOONGARCH_CSR_MCSR3		0xc3	/* CPUCFG6 */
+#define  MCSR3_UPM_SHIFT		14
+#define  MCSR3_UPM			(_ULCAST_(1) << MCSR3_UPM_SHIFT)
+#define  MCSR3_PMBITS_SHIFT		8
+#define  MCSR3_PMBITS_WIDTH		6
+#define  MCSR3_PMBITS			(_ULCAST_(0x3f) << MCSR3_PMBITS_SHIFT)
+#define  PMBITS_DEFAULT			0x40
+#define  MCSR3_PMNUM_SHIFT		4
+#define  MCSR3_PMNUM_WIDTH		4
+#define  MCSR3_PMNUM			(_ULCAST_(0xf) << MCSR3_PMNUM_SHIFT)
+#define  MCSR3_PAMVER_SHIFT		1
+#define  MCSR3_PAMVER_WIDTH		3
+#define  MCSR3_PAMVER			(_ULCAST_(0x7) << MCSR3_PAMVER_SHIFT)
+#define  MCSR3_PMP_SHIFT		0
+#define  MCSR3_PMP			(_ULCAST_(1) << MCSR3_PMP_SHIFT)
+
+#define LOONGARCH_CSR_MCSR8		0xc8	/* CPUCFG16 and CPUCFG17 */
+#define  MCSR8_L1I_SIZE_SHIFT		56
+#define  MCSR8_L1I_SIZE_WIDTH		7
+#define  MCSR8_L1I_SIZE			(_ULCAST_(0x7f) << MCSR8_L1I_SIZE_SHIFT)
+#define  MCSR8_L1I_IDX_SHIFT		48
+#define  MCSR8_L1I_IDX_WIDTH		8
+#define  MCSR8_L1I_IDX			(_ULCAST_(0xff) << MCSR8_L1I_IDX_SHIFT)
+#define  MCSR8_L1I_WAY_SHIFT		32
+#define  MCSR8_L1I_WAY_WIDTH		16
+#define  MCSR8_L1I_WAY			(_ULCAST_(0xffff) << MCSR8_L1I_WAY_SHIFT)
+#define  MCSR8_L3DINCL_SHIFT		16
+#define  MCSR8_L3DINCL			(_ULCAST_(1) << MCSR8_L3DINCL_SHIFT)
+#define  MCSR8_L3DPRIV_SHIFT		15
+#define  MCSR8_L3DPRIV			(_ULCAST_(1) << MCSR8_L3DPRIV_SHIFT)
+#define  MCSR8_L3DPRE_SHIFT		14
+#define  MCSR8_L3DPRE			(_ULCAST_(1) << MCSR8_L3DPRE_SHIFT)
+#define  MCSR8_L3IUINCL_SHIFT		13
+#define  MCSR8_L3IUINCL			(_ULCAST_(1) << MCSR8_L3IUINCL_SHIFT)
+#define  MCSR8_L3IUPRIV_SHIFT		12
+#define  MCSR8_L3IUPRIV			(_ULCAST_(1) << MCSR8_L3IUPRIV_SHIFT)
+#define  MCSR8_L3IUUNIFY_SHIFT		11
+#define  MCSR8_L3IUUNIFY		(_ULCAST_(1) << MCSR8_L3IUUNIFY_SHIFT)
+#define  MCSR8_L3IUPRE_SHIFT		10
+#define  MCSR8_L3IUPRE			(_ULCAST_(1) << MCSR8_L3IUPRE_SHIFT)
+#define  MCSR8_L2DINCL_SHIFT		9
+#define  MCSR8_L2DINCL			(_ULCAST_(1) << MCSR8_L2DINCL_SHIFT)
+#define  MCSR8_L2DPRIV_SHIFT		8
+#define  MCSR8_L2DPRIV			(_ULCAST_(1) << MCSR8_L2DPRIV_SHIFT)
+#define  MCSR8_L2DPRE_SHIFT		7
+#define  MCSR8_L2DPRE			(_ULCAST_(1) << MCSR8_L2DPRE_SHIFT)
+#define  MCSR8_L2IUINCL_SHIFT		6
+#define  MCSR8_L2IUINCL			(_ULCAST_(1) << MCSR8_L2IUINCL_SHIFT)
+#define  MCSR8_L2IUPRIV_SHIFT		5
+#define  MCSR8_L2IUPRIV			(_ULCAST_(1) << MCSR8_L2IUPRIV_SHIFT)
+#define  MCSR8_L2IUUNIFY_SHIFT		4
+#define  MCSR8_L2IUUNIFY		(_ULCAST_(1) << MCSR8_L2IUUNIFY_SHIFT)
+#define  MCSR8_L2IUPRE_SHIFT		3
+#define  MCSR8_L2IUPRE			(_ULCAST_(1) << MCSR8_L2IUPRE_SHIFT)
+#define  MCSR8_L1DPRE_SHIFT		2
+#define  MCSR8_L1DPRE			(_ULCAST_(1) << MCSR8_L1DPRE_SHIFT)
+#define  MCSR8_L1IUUNIFY_SHIFT		1
+#define  MCSR8_L1IUUNIFY		(_ULCAST_(1) << MCSR8_L1IUUNIFY_SHIFT)
+#define  MCSR8_L1IUPRE_SHIFT		0
+#define  MCSR8_L1IUPRE			(_ULCAST_(1) << MCSR8_L1IUPRE_SHIFT)
+
+#define LOONGARCH_CSR_MCSR9		0xc9	/* CPUCFG18 and CPUCFG19 */
+#define  MCSR9_L2U_SIZE_SHIFT		56
+#define  MCSR9_L2U_SIZE_WIDTH		7
+#define  MCSR9_L2U_SIZE			(_ULCAST_(0x7f) << MCSR9_L2U_SIZE_SHIFT)
+#define  MCSR9_L2U_IDX_SHIFT		48
+#define  MCSR9_L2U_IDX_WIDTH		8
+#define  MCSR9_L2U_IDX			(_ULCAST_(0xff) << MCSR9_IDX_LOG_SHIFT)
+#define  MCSR9_L2U_WAY_SHIFT		32
+#define  MCSR9_L2U_WAY_WIDTH		16
+#define  MCSR9_L2U_WAY			(_ULCAST_(0xffff) << MCSR9_L2U_WAY_SHIFT)
+#define  MCSR9_L1D_SIZE_SHIFT		24
+#define  MCSR9_L1D_SIZE_WIDTH		7
+#define  MCSR9_L1D_SIZE			(_ULCAST_(0x7f) << MCSR9_L1D_SIZE_SHIFT)
+#define  MCSR9_L1D_IDX_SHIFT		16
+#define  MCSR9_L1D_IDX_WIDTH		8
+#define  MCSR9_L1D_IDX			(_ULCAST_(0xff) << MCSR9_L1D_IDX_SHIFT)
+#define  MCSR9_L1D_WAY_SHIFT		0
+#define  MCSR9_L1D_WAY_WIDTH		16
+#define  MCSR9_L1D_WAY			(_ULCAST_(0xffff) << MCSR9_L1D_WAY_SHIFT)
+
+#define LOONGARCH_CSR_MCSR10		0xca	/* CPUCFG20 */
+#define  MCSR10_L3U_SIZE_SHIFT		24
+#define  MCSR10_L3U_SIZE_WIDTH		7
+#define  MCSR10_L3U_SIZE		(_ULCAST_(0x7f) << MCSR10_L3U_SIZE_SHIFT)
+#define  MCSR10_L3U_IDX_SHIFT		16
+#define  MCSR10_L3U_IDX_WIDTH		8
+#define  MCSR10_L3U_IDX			(_ULCAST_(0xff) << MCSR10_L3U_IDX_SHIFT)
+#define  MCSR10_L3U_WAY_SHIFT		0
+#define  MCSR10_L3U_WAY_WIDTH		16
+#define  MCSR10_L3U_WAY			(_ULCAST_(0xffff) << MCSR10_L3U_WAY_SHIFT)
+
+#define LOONGARCH_CSR_MCSR24		0xf0	/* cpucfg48 */
+#define  MCSR24_RAMCG_SHIFT		3
+#define  MCSR24_RAMCG			(_ULCAST_(1) << MCSR24_RAMCG_SHIFT)
+#define  MCSR24_VFPUCG_SHIFT		2
+#define  MCSR24_VFPUCG			(_ULCAST_(1) << MCSR24_VFPUCG_SHIFT)
+#define  MCSR24_NAPEN_SHIFT		1
+#define  MCSR24_NAPEN			(_ULCAST_(1) << MCSR24_NAPEN_SHIFT)
+#define  MCSR24_MCSRLOCK_SHIFT		0
+#define  MCSR24_MCSRLOCK		(_ULCAST_(1) << MCSR24_MCSRLOCK_SHIFT)
+
+/* Uncached accelerate windows registers */
+#define LOONGARCH_CSR_UCAWIN		0x100
+#define LOONGARCH_CSR_UCAWIN0_LO	0x102
+#define LOONGARCH_CSR_UCAWIN0_HI	0x103
+#define LOONGARCH_CSR_UCAWIN1_LO	0x104
+#define LOONGARCH_CSR_UCAWIN1_HI	0x105
+#define LOONGARCH_CSR_UCAWIN2_LO	0x106
+#define LOONGARCH_CSR_UCAWIN2_HI	0x107
+#define LOONGARCH_CSR_UCAWIN3_LO	0x108
+#define LOONGARCH_CSR_UCAWIN3_HI	0x109
+
+/* Direct Map windows registers */
+#define LOONGARCH_CSR_DMWIN0		0x180	/* 64 direct map win0: MEM & IF */
+#define LOONGARCH_CSR_DMWIN1		0x181	/* 64 direct map win1: MEM & IF */
+#define LOONGARCH_CSR_DMWIN2		0x182	/* 64 direct map win2: MEM */
+#define LOONGARCH_CSR_DMWIN3		0x183	/* 64 direct map win3: MEM */
+
+/* Direct Map window 0/1 */
+#define CSR_DMW0_PLV0		_CONST64_(1 << 0)
+#define CSR_DMW0_VSEG		_CONST64_(0x8000)
+#define CSR_DMW0_BASE		(CSR_DMW0_VSEG << DMW_PABITS)
+#define CSR_DMW0_INIT		(CSR_DMW0_BASE | CSR_DMW0_PLV0)
+
+#define CSR_DMW1_PLV0		_CONST64_(1 << 0)
+#define CSR_DMW1_MAT		_CONST64_(1 << 4)
+#define CSR_DMW1_VSEG		_CONST64_(0x9000)
+#define CSR_DMW1_BASE		(CSR_DMW1_VSEG << DMW_PABITS)
+#define CSR_DMW1_INIT		(CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_PLV0)
+
+/* Performance Counter registers */
+#define LOONGARCH_CSR_PERFCTRL0		0x200	/* 32 perf event 0 config */
+#define LOONGARCH_CSR_PERFCNTR0		0x201	/* 64 perf event 0 count value */
+#define LOONGARCH_CSR_PERFCTRL1		0x202	/* 32 perf event 1 config */
+#define LOONGARCH_CSR_PERFCNTR1		0x203	/* 64 perf event 1 count value */
+#define LOONGARCH_CSR_PERFCTRL2		0x204	/* 32 perf event 2 config */
+#define LOONGARCH_CSR_PERFCNTR2		0x205	/* 64 perf event 2 count value */
+#define LOONGARCH_CSR_PERFCTRL3		0x206	/* 32 perf event 3 config */
+#define LOONGARCH_CSR_PERFCNTR3		0x207	/* 64 perf event 3 count value */
+#define  CSR_PERFCTRL_PLV0		(_ULCAST_(1) << 16)
+#define  CSR_PERFCTRL_PLV1		(_ULCAST_(1) << 17)
+#define  CSR_PERFCTRL_PLV2		(_ULCAST_(1) << 18)
+#define  CSR_PERFCTRL_PLV3		(_ULCAST_(1) << 19)
+#define  CSR_PERFCTRL_IE		(_ULCAST_(1) << 20)
+#define  CSR_PERFCTRL_EVENT		0x3ff
+
+/* Debug registers */
+#define LOONGARCH_CSR_MWPC		0x300	/* data breakpoint config */
+#define LOONGARCH_CSR_MWPS		0x301	/* data breakpoint status */
+
+#define LOONGARCH_CSR_DB0ADDR		0x310	/* data breakpoint 0 address */
+#define LOONGARCH_CSR_DB0MASK		0x311	/* data breakpoint 0 mask */
+#define LOONGARCH_CSR_DB0CTL		0x312	/* data breakpoint 0 control */
+#define LOONGARCH_CSR_DB0ASID		0x313	/* data breakpoint 0 asid */
+
+#define LOONGARCH_CSR_DB1ADDR		0x318	/* data breakpoint 1 address */
+#define LOONGARCH_CSR_DB1MASK		0x319	/* data breakpoint 1 mask */
+#define LOONGARCH_CSR_DB1CTL		0x31a	/* data breakpoint 1 control */
+#define LOONGARCH_CSR_DB1ASID		0x31b	/* data breakpoint 1 asid */
+
+#define LOONGARCH_CSR_DB2ADDR		0x320	/* data breakpoint 2 address */
+#define LOONGARCH_CSR_DB2MASK		0x321	/* data breakpoint 2 mask */
+#define LOONGARCH_CSR_DB2CTL		0x322	/* data breakpoint 2 control */
+#define LOONGARCH_CSR_DB2ASID		0x323	/* data breakpoint 2 asid */
+
+#define LOONGARCH_CSR_DB3ADDR		0x328	/* data breakpoint 3 address */
+#define LOONGARCH_CSR_DB3MASK		0x329	/* data breakpoint 3 mask */
+#define LOONGARCH_CSR_DB3CTL		0x32a	/* data breakpoint 3 control */
+#define LOONGARCH_CSR_DB3ASID		0x32b	/* data breakpoint 3 asid */
+
+#define LOONGARCH_CSR_DB4ADDR		0x330	/* data breakpoint 4 address */
+#define LOONGARCH_CSR_DB4MASK		0x331	/* data breakpoint 4 maks */
+#define LOONGARCH_CSR_DB4CTL		0x332	/* data breakpoint 4 control */
+#define LOONGARCH_CSR_DB4ASID		0x333	/* data breakpoint 4 asid */
+
+#define LOONGARCH_CSR_DB5ADDR		0x338	/* data breakpoint 5 address */
+#define LOONGARCH_CSR_DB5MASK		0x339	/* data breakpoint 5 mask */
+#define LOONGARCH_CSR_DB5CTL		0x33a	/* data breakpoint 5 control */
+#define LOONGARCH_CSR_DB5ASID		0x33b	/* data breakpoint 5 asid */
+
+#define LOONGARCH_CSR_DB6ADDR		0x340	/* data breakpoint 6 address */
+#define LOONGARCH_CSR_DB6MASK		0x341	/* data breakpoint 6 mask */
+#define LOONGARCH_CSR_DB6CTL		0x342	/* data breakpoint 6 control */
+#define LOONGARCH_CSR_DB6ASID		0x343	/* data breakpoint 6 asid */
+
+#define LOONGARCH_CSR_DB7ADDR		0x348	/* data breakpoint 7 address */
+#define LOONGARCH_CSR_DB7MASK		0x349	/* data breakpoint 7 mask */
+#define LOONGARCH_CSR_DB7CTL		0x34a	/* data breakpoint 7 control */
+#define LOONGARCH_CSR_DB7ASID		0x34b	/* data breakpoint 7 asid */
+
+#define LOONGARCH_CSR_FWPC		0x380	/* instruction breakpoint config */
+#define LOONGARCH_CSR_FWPS		0x381	/* instruction breakpoint status */
+
+#define LOONGARCH_CSR_IB0ADDR		0x390	/* inst breakpoint 0 address */
+#define LOONGARCH_CSR_IB0MASK		0x391	/* inst breakpoint 0 mask */
+#define LOONGARCH_CSR_IB0CTL		0x392	/* inst breakpoint 0 control */
+#define LOONGARCH_CSR_IB0ASID		0x393	/* inst breakpoint 0 asid */
+
+#define LOONGARCH_CSR_IB1ADDR		0x398	/* inst breakpoint 1 address */
+#define LOONGARCH_CSR_IB1MASK		0x399	/* inst breakpoint 1 mask */
+#define LOONGARCH_CSR_IB1CTL		0x39a	/* inst breakpoint 1 control */
+#define LOONGARCH_CSR_IB1ASID		0x39b	/* inst breakpoint 1 asid */
+
+#define LOONGARCH_CSR_IB2ADDR		0x3a0	/* inst breakpoint 2 address */
+#define LOONGARCH_CSR_IB2MASK		0x3a1	/* inst breakpoint 2 mask */
+#define LOONGARCH_CSR_IB2CTL		0x3a2	/* inst breakpoint 2 control */
+#define LOONGARCH_CSR_IB2ASID		0x3a3	/* inst breakpoint 2 asid */
+
+#define LOONGARCH_CSR_IB3ADDR		0x3a8	/* inst breakpoint 3 address */
+#define LOONGARCH_CSR_IB3MASK		0x3a9	/* breakpoint 3 mask */
+#define LOONGARCH_CSR_IB3CTL		0x3aa	/* inst breakpoint 3 control */
+#define LOONGARCH_CSR_IB3ASID		0x3ab	/* inst breakpoint 3 asid */
+
+#define LOONGARCH_CSR_IB4ADDR		0x3b0	/* inst breakpoint 4 address */
+#define LOONGARCH_CSR_IB4MASK		0x3b1	/* inst breakpoint 4 mask */
+#define LOONGARCH_CSR_IB4CTL		0x3b2	/* inst breakpoint 4 control */
+#define LOONGARCH_CSR_IB4ASID		0x3b3	/* inst breakpoint 4 asid */
+
+#define LOONGARCH_CSR_IB5ADDR		0x3b8	/* inst breakpoint 5 address */
+#define LOONGARCH_CSR_IB5MASK		0x3b9	/* inst breakpoint 5 mask */
+#define LOONGARCH_CSR_IB5CTL		0x3ba	/* inst breakpoint 5 control */
+#define LOONGARCH_CSR_IB5ASID		0x3bb	/* inst breakpoint 5 asid */
+
+#define LOONGARCH_CSR_IB6ADDR		0x3c0	/* inst breakpoint 6 address */
+#define LOONGARCH_CSR_IB6MASK		0x3c1	/* inst breakpoint 6 mask */
+#define LOONGARCH_CSR_IB6CTL		0x3c2	/* inst breakpoint 6 control */
+#define LOONGARCH_CSR_IB6ASID		0x3c3	/* inst breakpoint 6 asid */
+
+#define LOONGARCH_CSR_IB7ADDR		0x3c8	/* inst breakpoint 7 address */
+#define LOONGARCH_CSR_IB7MASK		0x3c9	/* inst breakpoint 7 mask */
+#define LOONGARCH_CSR_IB7CTL		0x3ca	/* inst breakpoint 7 control */
+#define LOONGARCH_CSR_IB7ASID		0x3cb	/* inst breakpoint 7 asid */
+
+#define LOONGARCH_CSR_DEBUG		0x500	/* debug config */
+#define LOONGARCH_CSR_DEPC		0x501	/* debug epc */
+#define LOONGARCH_CSR_DESAVE		0x502	/* debug save */
+
+/*
+ * CSR_ECFG IM
+ */
+#define ECFG0_IM		0x00001fff
+#define ECFGB_SIP0		0
+#define ECFGF_SIP0		(_ULCAST_(1) << ECFGB_SIP0)
+#define ECFGB_SIP1		1
+#define ECFGF_SIP1		(_ULCAST_(1) << ECFGB_SIP1)
+#define ECFGB_IP0		2
+#define ECFGF_IP0		(_ULCAST_(1) << ECFGB_IP0)
+#define ECFGB_IP1		3
+#define ECFGF_IP1		(_ULCAST_(1) << ECFGB_IP1)
+#define ECFGB_IP2		4
+#define ECFGF_IP2		(_ULCAST_(1) << ECFGB_IP2)
+#define ECFGB_IP3		5
+#define ECFGF_IP3		(_ULCAST_(1) << ECFGB_IP3)
+#define ECFGB_IP4		6
+#define ECFGF_IP4		(_ULCAST_(1) << ECFGB_IP4)
+#define ECFGB_IP5		7
+#define ECFGF_IP5		(_ULCAST_(1) << ECFGB_IP5)
+#define ECFGB_IP6		8
+#define ECFGF_IP6		(_ULCAST_(1) << ECFGB_IP6)
+#define ECFGB_IP7		9
+#define ECFGF_IP7		(_ULCAST_(1) << ECFGB_IP7)
+#define ECFGB_PMC		10
+#define ECFGF_PMC		(_ULCAST_(1) << ECFGB_PMC)
+#define ECFGB_TIMER		11
+#define ECFGF_TIMER		(_ULCAST_(1) << ECFGB_TIMER)
+#define ECFGB_IPI		12
+#define ECFGF_IPI		(_ULCAST_(1) << ECFGB_IPI)
+#define ECFGF(hwirq)		(_ULCAST_(1) << hwirq)
+
+#define ESTATF_IP		0x00001fff
+
+#define LOONGARCH_IOCSR_FEATURES	0x8
+#define  IOCSRF_TEMP			BIT_ULL(0)
+#define  IOCSRF_NODECNT			BIT_ULL(1)
+#define  IOCSRF_MSI			BIT_ULL(2)
+#define  IOCSRF_EXTIOI			BIT_ULL(3)
+#define  IOCSRF_CSRIPI			BIT_ULL(4)
+#define  IOCSRF_FREQCSR			BIT_ULL(5)
+#define  IOCSRF_FREQSCALE		BIT_ULL(6)
+#define  IOCSRF_DVFSV1			BIT_ULL(7)
+#define  IOCSRF_GMOD			BIT_ULL(9)
+#define  IOCSRF_VM			BIT_ULL(11)
+
+#define LOONGARCH_IOCSR_VENDOR		0x10
+
+#define LOONGARCH_IOCSR_CPUNAME		0x20
+
+#define LOONGARCH_IOCSR_NODECNT		0x408
+
+#define LOONGARCH_IOCSR_MISC_FUNC	0x420
+#define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
+#define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
+
+#define LOONGARCH_IOCSR_CPUTEMP		0x428
+
+/* PerCore CSR, only accessible by local cores */
+#define LOONGARCH_IOCSR_IPI_STATUS	0x1000
+#define LOONGARCH_IOCSR_IPI_EN		0x1004
+#define LOONGARCH_IOCSR_IPI_SET		0x1008
+#define LOONGARCH_IOCSR_IPI_CLEAR	0x100c
+#define LOONGARCH_IOCSR_MBUF0		0x1020
+#define LOONGARCH_IOCSR_MBUF1		0x1028
+#define LOONGARCH_IOCSR_MBUF2		0x1030
+#define LOONGARCH_IOCSR_MBUF3		0x1038
+
+#define LOONGARCH_IOCSR_IPI_SEND	0x1040
+#define  IOCSR_IPI_SEND_IP_SHIFT	0
+#define  IOCSR_IPI_SEND_CPU_SHIFT	16
+#define  IOCSR_IPI_SEND_BLOCKING	BIT(31)
+
+#define LOONGARCH_IOCSR_MBUF_SEND	0x1048
+#define  IOCSR_MBUF_SEND_BLOCKING	BIT_ULL(31)
+#define  IOCSR_MBUF_SEND_BOX_SHIFT	2
+#define  IOCSR_MBUF_SEND_BOX_LO(box)	(box << 1)
+#define  IOCSR_MBUF_SEND_BOX_HI(box)	((box << 1) + 1)
+#define  IOCSR_MBUF_SEND_CPU_SHIFT	16
+#define  IOCSR_MBUF_SEND_BUF_SHIFT	32
+#define  IOCSR_MBUF_SEND_H32_MASK	0xFFFFFFFF00000000ULL
+
+#define LOONGARCH_IOCSR_ANY_SEND	0x1158
+#define  IOCSR_ANY_SEND_BLOCKING	BIT_ULL(31)
+#define  IOCSR_ANY_SEND_NODE_SHIFT	18
+#define  IOCSR_ANY_SEND_MASK_SHIFT	27
+#define  IOCSR_ANY_SEND_BUF_SHIFT	32
+#define  IOCSR_ANY_SEND_H32_MASK	0xFFFFFFFF00000000ULL
+
+/* Register offset and bit definition for CSR access */
+#define LOONGARCH_IOCSR_TIMER_CFG       0x1060
+#define LOONGARCH_IOCSR_TIMER_TICK      0x1070
+#define  IOCSR_TIMER_CFG_RESERVED       (_ULCAST_(1) << 63)
+#define  IOCSR_TIMER_CFG_PERIODIC       (_ULCAST_(1) << 62)
+#define  IOCSR_TIMER_CFG_EN             (_ULCAST_(1) << 61)
+#define  IOCSR_TIMER_MASK		0x0ffffffffffffULL
+#define  IOCSR_TIMER_INITVAL_RST        (_ULCAST_(0xffff) << 48)
+
+#define LOONGARCH_IOCSR_EXTIOI_NODEMAP_BASE	0x14a0
+#define LOONGARCH_IOCSR_EXTIOI_IPMAP_BASE	0x14c0
+#define LOONGARCH_IOCSR_EXTIOI_EN_BASE		0x1600
+#define LOONGARCH_IOCSR_EXTIOI_BOUNCE_BASE	0x1680
+#define LOONGARCH_IOCSR_EXTIOI_ISR_BASE		0x1800
+#define LOONGARCH_IOCSR_EXTIOI_ROUTE_BASE	0x1c00
+#define IOCSR_EXTIOI_VECTOR_NUM			256
+
+#ifndef __ASSEMBLY__
+
+static inline u64 drdtime(void)
+{
+	int rID = 0;
+	u64 val = 0;
+
+	__asm__ __volatile__(
+		"rdtime.d %0, %1 \n\t"
+		: "=r"(val), "=r"(rID)
+		:
+		);
+	return val;
+}
+
+static inline unsigned int get_csr_cpuid(void)
+{
+	return csr_readl(LOONGARCH_CSR_CPUID);
+}
+
+static inline void csr_any_send(unsigned int addr, unsigned int data,
+				unsigned int data_mask, unsigned int node)
+{
+	uint64_t val = 0;
+
+	val = IOCSR_ANY_SEND_BLOCKING | addr;
+	val |= (node << IOCSR_ANY_SEND_NODE_SHIFT);
+	val |= (data_mask << IOCSR_ANY_SEND_MASK_SHIFT);
+	val |= ((uint64_t)data << IOCSR_ANY_SEND_BUF_SHIFT);
+	__iocsrwr_d(val, LOONGARCH_IOCSR_ANY_SEND);
+}
+
+static inline unsigned int read_csr_excode(void)
+{
+	return (csr_readl(LOONGARCH_CSR_ESTAT) & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
+}
+
+static inline void write_csr_index(unsigned int idx)
+{
+	__csrxchg(idx, CSR_TLBIDX_IDXM, LOONGARCH_CSR_TLBIDX);
+}
+
+static inline unsigned int read_csr_pagesize(void)
+{
+	return (__csrrd(LOONGARCH_CSR_TLBIDX) & CSR_TLBIDX_SIZEM) >> CSR_TLBIDX_SIZE;
+}
+
+static inline void write_csr_pagesize(unsigned int size)
+{
+	__csrxchg(size << CSR_TLBIDX_SIZE, CSR_TLBIDX_SIZEM, LOONGARCH_CSR_TLBIDX);
+}
+
+#define read_csr_asid()			__csrrd(LOONGARCH_CSR_ASID)
+#define write_csr_asid(val)		__csrwr(val, LOONGARCH_CSR_ASID)
+#define read_csr_entryhi()		__dcsrrd(LOONGARCH_CSR_TLBEHI)
+#define write_csr_entryhi(val)		__dcsrwr(val, LOONGARCH_CSR_TLBEHI)
+#define read_csr_entrylo0()		__dcsrrd(LOONGARCH_CSR_TLBELO0)
+#define write_csr_entrylo0(val)		__dcsrwr(val, LOONGARCH_CSR_TLBELO0)
+#define read_csr_entrylo1()		__dcsrrd(LOONGARCH_CSR_TLBELO1)
+#define write_csr_entrylo1(val)		__dcsrwr(val, LOONGARCH_CSR_TLBELO1)
+#define read_csr_ecfg()			__csrrd(LOONGARCH_CSR_ECFG)
+#define write_csr_ecfg(val)		__csrwr(val, LOONGARCH_CSR_ECFG)
+#define read_csr_estat()		__csrrd(LOONGARCH_CSR_ESTAT)
+#define write_csr_estat(val)		__csrwr(val, LOONGARCH_CSR_ESTAT)
+#define read_csr_tlbidx()		__csrrd(LOONGARCH_CSR_TLBIDX)
+#define write_csr_tlbidx(val)		__csrwr(val, LOONGARCH_CSR_TLBIDX)
+#define read_csr_euen()			__csrrd(LOONGARCH_CSR_EUEN)
+#define write_csr_euen(val)		__csrwr(val, LOONGARCH_CSR_EUEN)
+#define read_csr_cpuid()		__csrrd(LOONGARCH_CSR_CPUID)
+#define read_csr_prcfg1()		__dcsrrd(LOONGARCH_CSR_PRCFG1)
+#define write_csr_prcfg1(val)		__dcsrwr(val, LOONGARCH_CSR_PRCFG1)
+#define read_csr_prcfg2()		__dcsrrd(LOONGARCH_CSR_PRCFG2)
+#define write_csr_prcfg2(val)		__dcsrwr(val, LOONGARCH_CSR_PRCFG2)
+#define read_csr_prcfg3()		__dcsrrd(LOONGARCH_CSR_PRCFG3)
+#define write_csr_prcfg3(val)		__dcsrwr(val, LOONGARCH_CSR_PRCFG3)
+#define read_csr_stlbpgsize()		__csrrd(LOONGARCH_CSR_STLBPGSIZE)
+#define write_csr_stlbpgsize(val)	__csrwr(val, LOONGARCH_CSR_STLBPGSIZE)
+#define read_csr_rvacfg()		__dcsrrd(LOONGARCH_CSR_RVACFG)
+#define write_csr_rvacfg(val)		__dcsrwr(val, LOONGARCH_CSR_RVACFG)
+#define write_csr_tintclear(val)	__dcsrwr(val, LOONGARCH_CSR_TINTCLR)
+#define read_csr_impctl1()		__dcsrrd(LOONGARCH_CSR_IMPCTL1)
+#define write_csr_impctl1(val)		__dcsrwr(val, LOONGARCH_CSR_IMPCTL1)
+#define write_csr_impctl2(val)		__dcsrwr(val, LOONGARCH_CSR_IMPCTL2)
+
+#define read_csr_perfctrl0()		__dcsrrd(LOONGARCH_CSR_PERFCTRL0)
+#define read_csr_perfcntr0()		__dcsrrd(LOONGARCH_CSR_PERFCNTR0)
+#define read_csr_perfctrl1()		__dcsrrd(LOONGARCH_CSR_PERFCTRL1)
+#define read_csr_perfcntr1()		__dcsrrd(LOONGARCH_CSR_PERFCNTR1)
+#define read_csr_perfctrl2()		__dcsrrd(LOONGARCH_CSR_PERFCTRL2)
+#define read_csr_perfcntr2()		__dcsrrd(LOONGARCH_CSR_PERFCNTR2)
+#define read_csr_perfctrl3()		__dcsrrd(LOONGARCH_CSR_PERFCTRL3)
+#define read_csr_perfcntr3()		__dcsrrd(LOONGARCH_CSR_PERFCNTR3)
+#define write_csr_perfctrl0(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCTRL0)
+#define write_csr_perfcntr0(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCNTR0)
+#define write_csr_perfctrl1(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCTRL1)
+#define write_csr_perfcntr1(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCNTR1)
+#define write_csr_perfctrl2(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCTRL2)
+#define write_csr_perfcntr2(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCNTR2)
+#define write_csr_perfctrl3(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCTRL3)
+#define write_csr_perfcntr3(val)	__dcsrwr(val, LOONGARCH_CSR_PERFCNTR3)
+
+/*
+ * Manipulate bits in a register.
+ */
+#define __BUILD_CSR_COMMON(name)				\
+static inline unsigned long					\
+set_##name(unsigned long set)					\
+{								\
+	unsigned long res, new;					\
+								\
+	res = read_##name();					\
+	new = res | set;					\
+	write_##name(new);					\
+								\
+	return res;						\
+}								\
+								\
+static inline unsigned long					\
+clear_##name(unsigned long clear)				\
+{								\
+	unsigned long res, new;					\
+								\
+	res = read_##name();					\
+	new = res & ~clear;					\
+	write_##name(new);					\
+								\
+	return res;						\
+}								\
+								\
+static inline unsigned long					\
+change_##name(unsigned long change, unsigned long val)		\
+{								\
+	unsigned long res, new;					\
+								\
+	res = read_##name();					\
+	new = res & ~change;					\
+	new |= (val & change);					\
+	write_##name(new);					\
+								\
+	return res;						\
+}
+
+#define __BUILD_CSR_OP(name)	__BUILD_CSR_COMMON(csr_##name)
+
+__BUILD_CSR_OP(euen)
+__BUILD_CSR_OP(ecfg)
+__BUILD_CSR_OP(tlbidx)
+
+#define set_csr_estat(val)	\
+	__dcsrxchg(val, val, LOONGARCH_CSR_ESTAT)
+#define clear_csr_estat(val)	\
+	__dcsrxchg(~(val), val, LOONGARCH_CSR_ESTAT)
+
+#endif /* __ASSEMBLY__ */
+
+/* Generic EntryLo bit definitions */
+#define ENTRYLO_V		(_ULCAST_(1) << 0)
+#define ENTRYLO_D		(_ULCAST_(1) << 1)
+#define ENTRYLO_PLV_SHIFT	2
+#define ENTRYLO_PLV		(_ULCAST_(3) << ENTRYLO_PLV_SHIFT)
+#define ENTRYLO_C_SHIFT		4
+#define ENTRYLO_C		(_ULCAST_(3) << ENTRYLO_C_SHIFT)
+#define ENTRYLO_G		(_ULCAST_(1) << 6)
+#define ENTRYLO_RI		(_ULCAST_(1) << 61)
+#define ENTRYLO_XI		(_ULCAST_(1) << 62)
+
+/* LoongArch GlobalNumber definitions */
+#define LOONGARCH_GLOBALNUMBER_VP_SHF	0
+#define LOONGARCH_GLOBALNUMBER_VP		(_ULCAST_(0xff) << LOONGARCH_GLOBALNUMBER_VP_SHF)
+#define LOONGARCH_GLOBALNUMBER_CORE_SHF	8
+#define LOONGARCH_GLOBALNUMBER_CORE		(_ULCAST_(0xff) << LOONGARCH_GLOBALNUMBER_CORE_SHF)
+#define LOONGARCH_GLOBALNUMBER_CLUSTER_SHF	16
+#define LOONGARCH_GLOBALNUMBER_CLUSTER	(_ULCAST_(0xf) << LOONGARCH_GLOBALNUMBER_CLUSTER_SHF)
+
+/* Values for PageSize register */
+#define PS_4K		0x0000000c
+#define PS_8K		0x0000000d
+#define PS_16K		0x0000000e
+#define PS_32K		0x0000000f
+#define PS_64K		0x00000010
+#define PS_128K		0x00000011
+#define PS_256K		0x00000012
+#define PS_512K		0x00000013
+#define PS_1M		0x00000014
+#define PS_2M		0x00000015
+#define PS_4M		0x00000016
+#define PS_8M		0x00000017
+#define PS_16M		0x00000018
+#define PS_32M		0x00000019
+#define PS_64M		0x0000001a
+#define PS_256M		0x0000001b
+#define PS_1G		0x0000001c
+
+#define PS_MASK		0x3f000000
+#define PS_SHIFT	24
+
+/* Default page size for a given kernel configuration */
+#ifdef CONFIG_PAGE_SIZE_4KB
+#define PS_DEFAULT_SIZE PS_4K
+#elif defined(CONFIG_PAGE_SIZE_16KB)
+#define PS_DEFAULT_SIZE PS_16K
+#elif defined(CONFIG_PAGE_SIZE_64KB)
+#define PS_DEFAULT_SIZE PS_64K
+#else
+#error Bad page size configuration!
+#endif
+
+/* Default huge tlb size for a given kernel configuration */
+#ifdef CONFIG_PAGE_SIZE_4KB
+#define PS_HUGE_SIZE   PS_1M
+#elif defined(CONFIG_PAGE_SIZE_16KB)
+#define PS_HUGE_SIZE   PS_16M
+#elif defined(CONFIG_PAGE_SIZE_64KB)
+#define PS_HUGE_SIZE   PS_256M
+#else
+#error Bad page size configuration for hugetlbfs!
+#endif
+
+/* ExStatus.ExcCode */
+#define EXCCODE_RSV		0	/* Reserved */
+#define EXCCODE_TLBL		1	/* TLB miss on a load */
+#define EXCCODE_TLBS		2	/* TLB miss on a store */
+#define EXCCODE_TLBI		3	/* TLB miss on a ifetch */
+#define EXCCODE_TLBM		4	/* TLB modified fault */
+#define EXCCODE_TLBRI		5	/* TLB Read-Inhibit exception */
+#define EXCCODE_TLBXI		6	/* TLB Execution-Inhibit exception */
+#define EXCCODE_TLBPE		7	/* TLB Privilege Error */
+#define EXCCODE_ADE		8	/* Address Error */
+	#define EXSUBCODE_ADEF		0	/* Fetch Instruction */
+	#define EXSUBCODE_ADEM		1	/* Access Memory*/
+#define EXCCODE_ALE		9	/* Unalign Access */
+#define EXCCODE_OOB		10	/* Out of bounds */
+#define EXCCODE_SYS		11	/* System call */
+#define EXCCODE_BP		12	/* Breakpoint */
+#define EXCCODE_INE		13	/* Inst. Not Exist */
+#define EXCCODE_IPE		14	/* Inst. Privileged Error */
+#define EXCCODE_FPDIS		15	/* FPU Disabled */
+#define EXCCODE_LSXDIS		16	/* LSX Disabled */
+#define EXCCODE_LASXDIS		17	/* LASX Disabled */
+#define EXCCODE_FPE		18	/* Floating Point Exception */
+	#define EXCSUBCODE_FPE		0	/* Floating Point Exception */
+	#define EXCSUBCODE_VFPE		1	/* Vector Exception */
+#define EXCCODE_WATCH		19	/* Watch address reference */
+#define EXCCODE_BTDIS		20	/* Binary Trans. Disabled */
+#define EXCCODE_BTE		21	/* Binary Trans. Exception */
+#define EXCCODE_PSI		22	/* Guest Privileged Error */
+#define EXCCODE_HYP		23	/* Hypercall */
+#define EXCCODE_GCM		24	/* Guest CSR modified */
+	#define EXCSUBCODE_GCSC		0	/* Software caused */
+	#define EXCSUBCODE_GCHC		1	/* Hardware caused */
+#define EXCCODE_SE		25	/* Security */
+
+#define EXCCODE_INT_START   64
+#define EXCCODE_SIP0        64
+#define EXCCODE_SIP1        65
+#define EXCCODE_IP0         66
+#define EXCCODE_IP1         67
+#define EXCCODE_IP2         68
+#define EXCCODE_IP3         69
+#define EXCCODE_IP4         70
+#define EXCCODE_IP5         71
+#define EXCCODE_IP6         72
+#define EXCCODE_IP7         73
+#define EXCCODE_PMC         74 /* Performance Counter */
+#define EXCCODE_TIMER       75
+#define EXCCODE_IPI         76
+#define EXCCODE_NMI         77
+#define EXCCODE_INT_END     78
+#define EXCCODE_INT_NUM	    (EXCCODE_INT_END - EXCCODE_INT_START)
+
+/* FPU register names */
+#define LOONGARCH_FCSR0	$r0
+#define LOONGARCH_FCSR1	$r1
+#define LOONGARCH_FCSR2	$r2
+#define LOONGARCH_FCSR3	$r3
+
+/* FPU Status Register Values */
+#define FPU_CSR_RSVD	0xe0e0fce0
+
+/*
+ * X the exception cause indicator
+ * E the exception enable
+ * S the sticky/flag bit
+ */
+#define FPU_CSR_ALL_X	0x1f000000
+#define FPU_CSR_INV_X	0x10000000
+#define FPU_CSR_DIV_X	0x08000000
+#define FPU_CSR_OVF_X	0x04000000
+#define FPU_CSR_UDF_X	0x02000000
+#define FPU_CSR_INE_X	0x01000000
+
+#define FPU_CSR_ALL_S	0x001f0000
+#define FPU_CSR_INV_S	0x00100000
+#define FPU_CSR_DIV_S	0x00080000
+#define FPU_CSR_OVF_S	0x00040000
+#define FPU_CSR_UDF_S	0x00020000
+#define FPU_CSR_INE_S	0x00010000
+
+#define FPU_CSR_ALL_E	0x0000001f
+#define FPU_CSR_INV_E	0x00000010
+#define FPU_CSR_DIV_E	0x00000008
+#define FPU_CSR_OVF_E	0x00000004
+#define FPU_CSR_UDF_E	0x00000002
+#define FPU_CSR_INE_E	0x00000001
+
+/* Bits 8 and 9 of FPU Status Register specify the rounding mode */
+#define FPU_CSR_RM	0x300
+#define FPU_CSR_RN	0x000	/* nearest */
+#define FPU_CSR_RZ	0x100	/* towards zero */
+#define FPU_CSR_RU	0x200	/* towards +Infinity */
+#define FPU_CSR_RD	0x300	/* towards -Infinity */
+
+#define read_fcsr(source)	\
+({	\
+	unsigned int __res;	\
+\
+	__asm__ __volatile__(	\
+	"	movfcsr2gr	%0, "STR(source)"	\n"	\
+	: "=r" (__res));	\
+	__res;	\
+})
+
+#define write_fcsr(dest, val) \
+do {	\
+	__asm__ __volatile__(	\
+	"	movgr2fcsr	%0, "STR(dest)"	\n"	\
+	: : "r" (val));	\
+} while (0)
+
+#endif /* _ASM_LOONGARCH_H */
diff --git a/arch/loongarch/include/asm/loongson.h b/arch/loongarch/include/asm/loongson.h
new file mode 100644
index 000000000000..ef4e842578f6
--- /dev/null
+++ b/arch/loongarch/include/asm/loongson.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_LOONGSON_H
+#define __ASM_LOONGSON_H
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <asm/addrspace.h>
+#include <asm/boot_param.h>
+
+extern const struct plat_smp_ops loongson3_smp_ops;
+
+/* loongson-specific command line, env and memory initialization */
+extern void __init fw_init_environ(void);
+extern void __init fw_init_memory(void);
+extern void __init fw_init_numa_memory(void);
+
+#define LOONGSON_REG(x) \
+	(*(volatile u32 *)((char *)TO_UNCAC(LOONGSON_REG_BASE) + (x)))
+
+#define LOONGSON_LIO_BASE	0x18000000
+#define LOONGSON_LIO_SIZE	0x00100000	/* 1M */
+#define LOONGSON_LIO_TOP	(LOONGSON_LIO_BASE+LOONGSON_LIO_SIZE-1)
+
+#define LOONGSON_BOOT_BASE	0x1c000000
+#define LOONGSON_BOOT_SIZE	0x02000000	/* 32M */
+#define LOONGSON_BOOT_TOP	(LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
+
+#define LOONGSON_REG_BASE	0x1fe00000
+#define LOONGSON_REG_SIZE	0x00100000	/* 1M */
+#define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
+
+/* GPIO Regs - r/w */
+
+#define LOONGSON_GPIODATA		LOONGSON_REG(0x11c)
+#define LOONGSON_GPIOIE			LOONGSON_REG(0x120)
+#define LOONGSON_REG_GPIO_BASE          (LOONGSON_REG_BASE + 0x11c)
+
+#define MAX_PACKAGES 16
+
+/* Chip Config registor of each physical cpu package */
+extern u64 loongson_chipcfg[MAX_PACKAGES];
+#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
+
+/* Chip Temperature registor of each physical cpu package */
+extern u64 loongson_chiptemp[MAX_PACKAGES];
+#define LOONGSON_CHIPTEMP(id) (*(volatile u32 *)(loongson_chiptemp[id]))
+
+/* Freq Control register of each physical cpu package */
+extern u64 loongson_freqctrl[MAX_PACKAGES];
+#define LOONGSON_FREQCTRL(id) (*(volatile u32 *)(loongson_freqctrl[id]))
+
+#define xconf_readl(addr) readl(addr)
+#define xconf_readq(addr) readq(addr)
+
+static inline void xconf_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile (
+	"	st.w	%[v], %[hw], 0	\n"
+	"	ld.b	$r0, %[hw], 0	\n"
+	:
+	: [hw] "r" (addr), [v] "r" (val)
+	);
+}
+
+static inline void xconf_writeq(u64 val64, volatile void __iomem *addr)
+{
+	asm volatile (
+	"	st.d	%[v], %[hw], 0	\n"
+	"	ld.b	$r0, %[hw], 0	\n"
+	:
+	: [hw] "r" (addr),  [v] "r" (val64)
+	);
+}
+
+/* ============== LS7A registers =============== */
+#define LS7A_PCH_REG_BASE		0x10000000UL
+/* LPC regs */
+#define LS7A_LPC_REG_BASE		(LS7A_PCH_REG_BASE + 0x00002000)
+/* CHIPCFG regs */
+#define LS7A_CHIPCFG_REG_BASE		(LS7A_PCH_REG_BASE + 0x00010000)
+/* MISC reg base */
+#define LS7A_MISC_REG_BASE		(LS7A_PCH_REG_BASE + 0x00080000)
+/* ACPI regs */
+#define LS7A_ACPI_REG_BASE		(LS7A_MISC_REG_BASE + 0x00050000)
+/* RTC regs */
+#define LS7A_RTC_REG_BASE		(LS7A_MISC_REG_BASE + 0x00050100)
+
+#define LS7A_DMA_CFG			(volatile void *)TO_UNCAC(LS7A_CHIPCFG_REG_BASE + 0x041c)
+#define LS7A_DMA_NODE_SHF		8
+#define LS7A_DMA_NODE_MASK		0x1F00
+
+#define LS7A_INT_MASK_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x020)
+#define LS7A_INT_EDGE_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x060)
+#define LS7A_INT_CLEAR_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x080)
+#define LS7A_INT_HTMSI_EN_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x040)
+#define LS7A_INT_ROUTE_ENTRY_REG	(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x100)
+#define LS7A_INT_HTMSI_VEC_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x200)
+#define LS7A_INT_STATUS_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x3a0)
+#define LS7A_INT_POL_REG		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x3e0)
+#define LS7A_LPC_INT_CTL		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2000)
+#define LS7A_LPC_INT_ENA		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2004)
+#define LS7A_LPC_INT_STS		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2008)
+#define LS7A_LPC_INT_CLR		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x200c)
+#define LS7A_LPC_INT_POL		(volatile void *)TO_UNCAC(LS7A_PCH_REG_BASE + 0x2010)
+
+#define LS7A_PMCON_SOC_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x000)
+#define LS7A_PMCON_RESUME_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x004)
+#define LS7A_PMCON_RTC_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x008)
+#define LS7A_PM1_EVT_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x00c)
+#define LS7A_PM1_ENA_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x010)
+#define LS7A_PM1_CNT_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x014)
+#define LS7A_PM1_TMR_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x018)
+#define LS7A_P_CNT_REG			(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x01c)
+#define LS7A_GPE0_STS_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x028)
+#define LS7A_GPE0_ENA_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x02c)
+#define LS7A_RST_CNT_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x030)
+#define LS7A_WD_SET_REG			(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x034)
+#define LS7A_WD_TIMER_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x038)
+#define LS7A_THSENS_CNT_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x04c)
+#define LS7A_GEN_RTC_1_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x050)
+#define LS7A_GEN_RTC_2_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x054)
+#define LS7A_DPM_CFG_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x400)
+#define LS7A_DPM_STS_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x404)
+#define LS7A_DPM_CNT_REG		(volatile void *)TO_UNCAC(LS7A_ACPI_REG_BASE + 0x408)
+
+typedef enum {
+	ACPI_PCI_HOTPLUG_STATUS	= 1 << 1,
+	ACPI_CPU_HOTPLUG_STATUS	= 1 << 2,
+	ACPI_MEM_HOTPLUG_STATUS	= 1 << 3,
+	ACPI_POWERBUTTON_STATUS	= 1 << 8,
+	ACPI_RTC_WAKE_STATUS	= 1 << 10,
+	ACPI_PCI_WAKE_STATUS	= 1 << 14,
+	ACPI_ANY_WAKE_STATUS	= 1 << 15,
+} AcpiEventStatusBits;
+
+#define HT1LO_OFFSET		0xe0000000000UL
+
+/* PCI Configuration Space Base */
+#define MCFG_EXT_PCICFG_BASE		0xefe00000000UL
+
+/* REG ACCESS*/
+#define ls7a_readb(addr)			  (*(volatile unsigned char  *)TO_UNCAC(addr))
+#define ls7a_readw(addr)			  (*(volatile unsigned short *)TO_UNCAC(addr))
+#define ls7a_readl(addr)			  (*(volatile unsigned int   *)TO_UNCAC(addr))
+#define ls7a_readq(addr)			  (*(volatile unsigned long  *)TO_UNCAC(addr))
+#define ls7a_writeb(val, addr)		*(volatile unsigned char  *)TO_UNCAC(addr) = (val)
+#define ls7a_writew(val, addr)		*(volatile unsigned short *)TO_UNCAC(addr) = (val)
+#define ls7a_writel(val, addr)		ls7a_write_type(val, addr, uint32_t)
+#define ls7a_writeq(val, addr)		ls7a_write_type(val, addr, uint64_t)
+#define ls7a_write(val, addr)		ls7a_write_type(val, addr, uint64_t)
+
+#endif /* __ASM_LOONGSON_H */
diff --git a/arch/loongarch/include/asm/regdef.h b/arch/loongarch/include/asm/regdef.h
new file mode 100644
index 000000000000..7d98e38a5a2f
--- /dev/null
+++ b/arch/loongarch/include/asm/regdef.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_REGDEF_H
+#define _ASM_REGDEF_H
+
+#define zero	$r0	/* wired zero */
+#define ra	$r1	/* return address */
+#define tp	$r2
+#define sp	$r3	/* stack pointer */
+#define v0	$r4	/* return value - caller saved */
+#define v1	$r5
+#define a0	$r4	/* argument registers */
+#define a1	$r5
+#define a2	$r6
+#define a3	$r7
+#define a4	$r8
+#define a5	$r9
+#define a6	$r10
+#define a7	$r11
+#define t0	$r12	/* caller saved */
+#define t1	$r13
+#define t2	$r14
+#define t3	$r15
+#define t4	$r16
+#define t5	$r17
+#define t6	$r18
+#define t7	$r19
+#define t8	$r20
+#define x0	$r21
+#define fp	$r22	/* frame pointer */
+#define s0	$r23	/* callee saved */
+#define s1	$r24
+#define s2	$r25
+#define s3	$r26
+#define s4	$r27
+#define s5	$r28
+#define s6	$r29
+#define s7	$r30
+#define s8	$r31
+
+#endif /* _ASM_REGDEF_H */
-- 
2.27.0

