Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C67295BD
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbfEXK0d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 06:26:33 -0400
Received: from foss.arm.com ([217.140.101.70]:39230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfEXK0c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 868A215A2;
        Fri, 24 May 2019 03:26:31 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D52A3F703;
        Fri, 24 May 2019 03:26:29 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andrew Jones <drjones@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        Paul Elliott <paul.elliott@arm.com>
Subject: [PATCH 4/8] arm64: Basic Branch Target Identification support
Date:   Fri, 24 May 2019 11:25:29 +0100
Message-Id: <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the bare minimum required to expose the ARMv8.5
Branch Target Identification feature to userspace.

By itself, this does _not_ automatically enable BTI for any initial
executable pages mapped by execve().  This will come later, but for
now it should be possible to enable BTI manually on those pages by
using mprotect() from within the target process.

Other arches already using the generic mman.h are already using
0x10 for arch-specific prot flags, so we use that for
PROT_BTI_GUARDED here.

For consistency, signal handler entry points in BTI guarded pages
are required to be annotated as such, just like any other function.
This blocks a relatively minor attack vector, but comforming
userspace will have the annotations anyway, so we may as well
enforce them.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Notes:

 * An #ifdef CONFIG_ARM64_BTI controls the cpufeature field visibility
   for userspace.  It's probably best not to report BTI as present if
   the required kernel support is unavailable.

 * It's not clear whether anything extra needs to be done for hugepages.
---
 Documentation/arm64/cpu-feature-registers.txt |  2 ++
 Documentation/arm64/elf_hwcaps.txt            |  4 ++++
 arch/arm64/Kconfig                            | 23 +++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h              |  3 ++-
 arch/arm64/include/asm/cpufeature.h           |  6 +++++
 arch/arm64/include/asm/esr.h                  |  2 +-
 arch/arm64/include/asm/hwcap.h                |  1 +
 arch/arm64/include/asm/mman.h                 | 33 +++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |  1 +
 arch/arm64/include/asm/pgtable.h              |  2 +-
 arch/arm64/include/asm/ptrace.h               |  1 +
 arch/arm64/include/asm/sysreg.h               |  2 ++
 arch/arm64/include/uapi/asm/hwcap.h           |  1 +
 arch/arm64/include/uapi/asm/mman.h            |  9 ++++++++
 arch/arm64/include/uapi/asm/ptrace.h          |  1 +
 arch/arm64/kernel/cpufeature.c                | 17 ++++++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 arch/arm64/kernel/entry.S                     | 11 +++++++++
 arch/arm64/kernel/ptrace.c                    |  2 +-
 arch/arm64/kernel/signal.c                    |  5 ++++
 arch/arm64/kernel/syscall.c                   |  1 +
 arch/arm64/kernel/traps.c                     |  7 ++++++
 include/linux/mm.h                            |  3 +++
 23 files changed, 134 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index 54d2bfa..602eb6e 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -165,6 +165,8 @@ infrastructure:
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
      | SSBS                         | [7-4]   |    y    |
+     |--------------------------------------------------|
+     | BT                           | [3-0]   |    y    |
      x--------------------------------------------------x
 
 
diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index b73a251..7a872d3 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -223,6 +223,10 @@ HWCAP_PACG
     ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
     Documentation/arm64/pointer-authentication.txt.
 
+HWCAP2_BTI
+
+    Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
+
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4780eb7..0f6765e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1361,6 +1361,29 @@ config ARM64_PTR_AUTH
 
 endmenu
 
+menu "ARMv8.5 architectural features"
+
+config ARM64_BTI
+	bool "Branch Target Identification support"
+	default y
+	help
+	  Branch Target Identification (part of the ARMv8.5 Extensions)
+	  provides a mechanism to limit the set of locations to which computed
+	  branch instructions such as BR or BLR can jump.
+
+	  This is intended to provide complementary protection to other control
+	  flow integrity protection mechanisms, such as the Pointer
+	  authentication mechanism provided as part of the ARMv8.2 Extensions.
+
+	  To make use of BTI on CPUs that support it, say Y.
+
+	  Userspace binaries must also be specifically compiled to make use of
+	  this mechanism.  If you say N here or the hardware does not support
+	  BTI, such binaries can still run, but you get no additional
+	  enforcement of branch destinations.
+
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index defdc67..ccb44ae 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -62,7 +62,8 @@
 #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
 #define ARM64_HAS_IRQ_PRIO_MASKING		42
 #define ARM64_HAS_DCPODP			43
+#define ARM64_BTI				44
 
-#define ARM64_NCAPS				44
+#define ARM64_NCAPS				45
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bc895c8..308cc54 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -617,6 +617,12 @@ static inline bool system_uses_irq_prio_masking(void)
 	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
 }
 
+static inline bool system_supports_bti(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_BTI) &&
+		cpus_have_const_cap(ARM64_BTI);
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 0e27fe9..0dd43a5 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -33,7 +33,7 @@
 #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
-/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_BTI		(0x0D)
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index b4bfb66..c6b918f 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -95,6 +95,7 @@
 #define KERNEL_HWCAP_SVEBITPERM		__khwcap2_feature(SVEBITPERM)
 #define KERNEL_HWCAP_SVESHA3		__khwcap2_feature(SVESHA3)
 #define KERNEL_HWCAP_SVESM4		__khwcap2_feature(SVESM4)
+#define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
new file mode 100644
index 0000000..a1f67aa
--- /dev/null
+++ b/arch/arm64/include/asm/mman.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <uapi/asm/mman.h>
+
+#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
+static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
+{
+	if (system_supports_bti() && (prot & PROT_BTI_GUARDED))
+		return VM_ARM64_GP;
+
+	return 0;
+}
+
+#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
+static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_ARM64_GP) ? __pgprot(PTE_GP) : __pgprot(0);
+}
+
+#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
+static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (system_supports_bti())
+		supported |= PROT_BTI_GUARDED;
+
+	return (prot & ~supported) == 0;
+}
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index a69259c..6e8af3a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -162,6 +162,7 @@
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
+#define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */
 #define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
 #define PTE_CONT		(_AT(pteval_t, 1) << 52)	/* Contiguous range */
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2c41b04..eefd9a44 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -640,7 +640,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index b2de329..b868ef11 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -41,6 +41,7 @@
 
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_IL_BIT		(1 << 20)
+#define PSR_BTYPE_CALL		(2 << 10)
 
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 902d75b..2b8d364 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -604,10 +604,12 @@
 
 /* id_aa64pfr1 */
 #define ID_AA64PFR1_SSBS_SHIFT		4
+#define ID_AA64PFR1_BT_SHIFT		0
 
 #define ID_AA64PFR1_SSBS_PSTATE_NI	0
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
+#define ID_AA64PFR1_BT_BTI		0x1
 
 /* id_aa64zfr0 */
 #define ID_AA64ZFR0_SM4_SHIFT		40
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 1a772b1..ea5bdda 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -63,5 +63,6 @@
 #define HWCAP2_SVEBITPERM	(1 << 4)
 #define HWCAP2_SVESHA3		(1 << 5)
 #define HWCAP2_SVESM4		(1 << 6)
+#define HWCAP2_BTI		(1 << 7)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
new file mode 100644
index 0000000..4776b43
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/mman.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_MMAN_H
+#define _UAPI__ASM_MMAN_H
+
+#include <asm-generic/mman.h>
+
+#define PROT_BTI_GUARDED	0x10		/* BTI guarded page */
+
+#endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d78623a..e2361a1 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -46,6 +46,7 @@
 #define PSR_I_BIT	0x00000080
 #define PSR_A_BIT	0x00000100
 #define PSR_D_BIT	0x00000200
+#define PSR_BTYPE_MASK	0x00000c00
 #define PSR_SSBS_BIT	0x00001000
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ca27e08..0a6dbb3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -182,6 +182,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_BTI),
+				    FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -1558,6 +1560,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 	},
 #endif
+#ifdef CONFIG_ARM64_BTI
+	{
+		.desc = "Branch Target Identification",
+		.capability = ARM64_BTI,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.field_pos = ID_AA64PFR1_BT_SHIFT,
+		.min_field_value = ID_AA64PFR1_BT_BTI,
+		.sign = FTR_UNSIGNED,
+	},
+#endif
 	{},
 };
 
@@ -1651,6 +1665,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SM4_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SM4, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
 #endif
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
+#ifdef CONFIG_ARM64_BTI
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_BT_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_BT_BTI, CAP_HWCAP, KERNEL_HWCAP_BTI),
+#endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, KERNEL_HWCAP_PACA),
 	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f6f7936..0fd3899 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -92,6 +92,7 @@ static const char *const hwcap_str[] = {
 	"svebitperm",
 	"svesha3",
 	"svesm4",
+	"bti",
 	NULL
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1a7811b..da3694e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -707,6 +707,8 @@ el0_sync:
 	b.eq	el0_sp_pc
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
+	cmp	x24, #ESR_ELx_EC_BTI		// branch target exception
+	b.eq	el0_bti
 	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
@@ -851,6 +853,15 @@ el0_undef:
 	mov	x0, sp
 	bl	do_undefinstr
 	b	ret_to_user
+el0_bti:
+	/*
+	 * Branch target exception
+	 */
+	enable_daif
+	ct_user_exit
+	mov	x0, sp
+	bl	do_bti
+	b	ret_to_user
 el0_sys:
 	/*
 	 * System instructions, for trapped cache maintenance instructions
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b82e0a9..3717b06 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1860,7 +1860,7 @@ void syscall_trace_exit(struct pt_regs *regs)
  */
 #define SPSR_EL1_AARCH64_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
-	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
+	 GENMASK_ULL(20, 13) | GENMASK_ULL(5, 5))
 #define SPSR_EL1_AARCH32_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a9b0485..2e540f5 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -741,6 +741,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
+	if (system_supports_bti()) {
+		regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);
+		regs->pstate |= PSR_BTYPE_CALL;
+	}
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5610ac0..85b456b 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -66,6 +66,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	unsigned long flags = current_thread_info()->flags;
 
 	regs->orig_x0 = regs->regs[0];
+	regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);
 	regs->syscallno = scno;
 
 	local_daif_restore(DAIF_PROCCTX);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ade3204..079ce1a 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -426,6 +426,12 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
 }
 
+asmlinkage void __exception do_bti(struct pt_regs *regs)
+{
+	BUG_ON(!user_mode(regs));
+	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
+}
+
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
 		res = -EFAULT;					\
@@ -756,6 +762,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
 	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
 	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
+	[ESR_ELx_EC_BTI]		= "BTI",
 	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
 	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
 	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834a..639dc54 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -318,6 +318,9 @@ extern unsigned int kobjsize(const void *objp);
 #elif defined(CONFIG_SPARC64)
 # define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
 # define VM_ARCH_CLEAR	VM_SPARC_ADI
+#elif defined(CONFIG_ARM64)
+# define VM_ARM64_GP	VM_ARCH_1	/* BTI guarded page */
+# define VM_ARCH_CLEAR	VM_ARM64_GP
 #elif !defined(CONFIG_MMU)
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
-- 
2.1.4

