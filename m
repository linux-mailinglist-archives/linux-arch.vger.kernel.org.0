Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF866D30BD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJJSpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:45:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfJJSpp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E961000;
        Thu, 10 Oct 2019 11:45:44 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAB923F703;
        Thu, 10 Oct 2019 11:45:41 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/12] arm64: Basic Branch Target Identification support
Date:   Thu, 10 Oct 2019 19:44:33 +0100
Message-Id: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
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
0x10 for arch-specific prot flags, so we use that for PROT_BTI
here.

For consistency, signal handler entry points in BTI guarded pages
are required to be annotated as such, just like any other function.
This blocks a relatively minor attack vector, but comforming
userspace will have the annotations anyway, so we may as well
enforce them.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v1:

 * Configure SCTLR_EL1.BTx to disallow BR onto a PACIxSP instruction
   (except via X16/X17):

   The AArch64 procedure call standard requires binaries marked with
   GNU_PROPERTY_AARCH64_FEATURE_1_BTI to use X16/X17 in trampolines
   and tail calls, so it makes no sense to be permissive.

 * Rename PROT_BTI_GUARDED to PROT_BTI.

 * Rename VM_ARM64_GP to VM_ARM64_BTI:

   Although the architectural name for the BTI page table bit is "GP",
   BTI is nonetheless the feature it controls.  So avoid introducing
   the "GP" naming just for this -- it's just an unecessary extra
   source of confusion.

 * Tidy up masking with ~PSR_BTYPE_MASK.

 * Drop masking out of BTYPE on SVC, with a comment outlining why.

 * Split PSR_BTYPE_SHIFT definition into this patch.  It's not
   useful yet, but it makes sense to define PSR_BTYPE_* using this
   from the outset.

 * Migrate to ct_user_exit_irqoff in entry.S:el0_bti.
---
 Documentation/arm64/cpu-feature-registers.rst |  2 ++
 Documentation/arm64/elf_hwcaps.rst            |  4 ++++
 arch/arm64/Kconfig                            | 23 +++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h              |  3 ++-
 arch/arm64/include/asm/cpufeature.h           |  6 +++++
 arch/arm64/include/asm/esr.h                  |  2 +-
 arch/arm64/include/asm/hwcap.h                |  1 +
 arch/arm64/include/asm/mman.h                 | 33 +++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |  1 +
 arch/arm64/include/asm/pgtable.h              |  2 +-
 arch/arm64/include/asm/ptrace.h               |  3 +++
 arch/arm64/include/asm/sysreg.h               |  4 ++++
 arch/arm64/include/uapi/asm/hwcap.h           |  1 +
 arch/arm64/include/uapi/asm/mman.h            |  9 ++++++++
 arch/arm64/include/uapi/asm/ptrace.h          |  1 +
 arch/arm64/kernel/cpufeature.c                | 33 +++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 arch/arm64/kernel/entry.S                     | 11 +++++++++
 arch/arm64/kernel/ptrace.c                    |  2 +-
 arch/arm64/kernel/signal.c                    |  5 ++++
 arch/arm64/kernel/syscall.c                   | 18 +++++++++++++++
 arch/arm64/kernel/traps.c                     |  7 ++++++
 include/linux/mm.h                            |  3 +++
 23 files changed, 171 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index b86828f..c96c7df 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -174,6 +174,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | SSBS                         | [7-4]   |    y    |
      +------------------------------+---------+---------+
+     | BT                           | [3-0]   |    y    |
+     +------------------------------+---------+---------+
 
 
   4) MIDR_EL1 - Main ID Register
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 91f7952..296dcac 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -201,6 +201,10 @@ HWCAP2_FRINT
 
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
 
+HWCAP2_BTI
+
+    Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
+
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 41a9b42..159ee69 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1410,6 +1410,29 @@ config ARM64_PTR_AUTH
 
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
index f19fe4b..946165e 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -52,7 +52,8 @@
 #define ARM64_HAS_IRQ_PRIO_MASKING		42
 #define ARM64_HAS_DCPODP			43
 #define ARM64_WORKAROUND_1463225		44
+#define ARM64_BTI				45
 
-#define ARM64_NCAPS				45
+#define ARM64_NCAPS				46
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9cde5d2..84fa48f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -613,6 +613,12 @@ static inline bool system_has_prio_mask_debugging(void)
 	       system_uses_irq_prio_masking();
 }
 
+static inline bool system_supports_bti(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_BTI) &&
+		cpus_have_const_cap(ARM64_BTI);
+}
+
 #define ARM64_BP_HARDEN_UNKNOWN		-1
 #define ARM64_BP_HARDEN_WA_NEEDED	0
 #define ARM64_BP_HARDEN_NOT_REQUIRED	1
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index cb29253..390b8ba 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -22,7 +22,7 @@
 #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
-/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_BTI		(0x0D)
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 3d2f247..f9e681d 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define KERNEL_HWCAP_SVESM4		__khwcap2_feature(SVESM4)
 #define KERNEL_HWCAP_FLAGM2		__khwcap2_feature(FLAGM2)
 #define KERNEL_HWCAP_FRINT		__khwcap2_feature(FRINT)
+#define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
new file mode 100644
index 0000000..cbfe3238
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
+	if (system_supports_bti() && (prot & PROT_BTI))
+		return VM_ARM64_BTI;
+
+	return 0;
+}
+
+#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
+static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
+}
+
+#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
+static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (system_supports_bti())
+		supported |= PROT_BTI;
+
+	return (prot & ~supported) == 0;
+}
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 3df60f9..f85d1fc 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -150,6 +150,7 @@
 #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
 #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
+#define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */
 #define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
 #define PTE_CONT		(_AT(pteval_t, 1) << 52)	/* Contiguous range */
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7576df0..a7b5a81 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -679,7 +679,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index fbebb41..7d4cd59 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -35,7 +35,10 @@
 #define GIC_PRIO_PSR_I_SET		(1 << 4)
 
 /* Additional SPSR bits not exposed in the UABI */
+#define PSR_BTYPE_SHIFT		10
+
 #define PSR_IL_BIT		(1 << 20)
+#define PSR_BTYPE_CALL		(2 << PSR_BTYPE_SHIFT)
 
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 972d196..58a5e5e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -510,6 +510,8 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_BT1		(BIT(36))
+#define SCTLR_EL1_BT0		(BIT(35))
 #define SCTLR_EL1_UCI		(BIT(26))
 #define SCTLR_EL1_E0E		(BIT(24))
 #define SCTLR_EL1_SPAN		(BIT(23))
@@ -599,10 +601,12 @@
 
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
index a1e7288..363f569 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -65,5 +65,6 @@
 #define HWCAP2_SVESM4		(1 << 6)
 #define HWCAP2_FLAGM2		(1 << 7)
 #define HWCAP2_FRINT		(1 << 8)
+#define HWCAP2_BTI		(1 << 9)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
new file mode 100644
index 0000000..6fdd71e
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/mman.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_MMAN_H
+#define _UAPI__ASM_MMAN_H
+
+#include <asm-generic/mman.h>
+
+#define PROT_BTI	0x10		/* BTI guarded page */
+
+#endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7ed9294..09e66fa 100644
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
index 9323bcc..4bab6e7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -171,6 +171,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_BTI),
+				    FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -1260,6 +1262,21 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 }
 #endif
 
+#ifdef CONFIG_ARM64_BTI
+static void bti_enable(const struct arm64_cpu_capabilities *__unused)
+{
+	/*
+	 * Use of X16/X17 for tail-calls and trampolines that jump to
+	 * function entry points using BR is a requirement for
+	 * marking binaries with GNU_PROPERTY_AARCH64_FEATURE_1_BTI.
+	 * So, be strict and forbid other BRs using other registers to
+	 * jump onto a PACIxSP instruction:
+	 */
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_BT0 | SCTLR_EL1_BT1);
+	isb();
+}
+#endif /* CONFIG_ARM64_BTI */
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1560,6 +1577,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 	},
 #endif
+#ifdef CONFIG_ARM64_BTI
+	{
+		.desc = "Branch Target Identification",
+		.capability = ARM64_BTI,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.cpu_enable = bti_enable,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.field_pos = ID_AA64PFR1_BT_SHIFT,
+		.min_field_value = ID_AA64PFR1_BT_BTI,
+		.sign = FTR_UNSIGNED,
+	},
+#endif
 	{},
 };
 
@@ -1655,6 +1685,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
index 05933c0..e1fd053 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -84,6 +84,7 @@ static const char *const hwcap_str[] = {
 	"svesm4",
 	"flagm2",
 	"frint",
+	"bti",
 	NULL
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 84a8227..6c5adea 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -737,6 +737,8 @@ el0_sync:
 	b.eq	el0_pc
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
+	cmp	x24, #ESR_ELx_EC_BTI		// branch target exception
+	b.eq	el0_bti
 	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
 	b.ge	el0_dbg
 	b	el0_inv
@@ -887,6 +889,15 @@ el0_undef:
 	mov	x0, sp
 	bl	do_undefinstr
 	b	ret_to_user
+el0_bti:
+	/*
+	 * Branch target exception
+	 */
+	ct_user_exit_irqoff
+	enable_daif
+	mov	x0, sp
+	bl	do_bti
+	b	ret_to_user
 el0_sys:
 	/*
 	 * System instructions, for trapped cache maintenance instructions
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 21176d0..ff5ea70 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1853,7 +1853,7 @@ void syscall_trace_exit(struct pt_regs *regs)
  */
 #define SPSR_EL1_AARCH64_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
-	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
+	 GENMASK_ULL(20, 13) | GENMASK_ULL(5, 5))
 #define SPSR_EL1_AARCH32_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index dd2cdc0..4a3bd32 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -730,6 +730,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
+	if (system_supports_bti()) {
+		regs->pstate &= ~PSR_BTYPE_MASK;
+		regs->pstate |= PSR_BTYPE_CALL;
+	}
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 871c739..b6b8e48 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -98,6 +98,24 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
 
+	/*
+	 * BTI note:
+	 * The architecture does not guarantee that SPSR.BTYPE is zero
+	 * on taking an SVC, so we could return to userspace with a
+	 * non-zero BTYPE after the syscall.
+	 *
+	 * This shouldn't matter except when userspace is explicitly
+	 * doing something stupid, such as setting PROT_BTI on a page
+	 * that lacks conforming BTI/PACIxSP instructions, falling
+	 * through from one executable page to another with differing
+	 * PROT_BTI, or messing with BYTPE via ptrace: in such cases,
+	 * userspace should not be surprised if a SIGILL occurs on
+	 * syscall return.
+	 *
+	 * So, don't touch regs->pstate & PSR_BTYPE_MASK here.
+	 * (Similarly for HVC and SMC elsewhere.)
+	 */
+
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 34739e8..15e3c4f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -406,6 +406,12 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
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
@@ -737,6 +743,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
 	[ESR_ELx_EC_PAC]		= "PAC",
 	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
+	[ESR_ELx_EC_BTI]		= "BTI",
 	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
 	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
 	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc29227..5ed5a99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -329,6 +329,9 @@ extern unsigned int kobjsize(const void *objp);
 #elif defined(CONFIG_SPARC64)
 # define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
 # define VM_ARCH_CLEAR	VM_SPARC_ADI
+#elif defined(CONFIG_ARM64)
+# define VM_ARM64_BTI	VM_ARCH_1	/* BTI guarded page, a.k.a. GP bit */
+# define VM_ARCH_CLEAR	VM_ARM64_BTI
 #elif !defined(CONFIG_MMU)
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
-- 
2.1.4

