Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD01D5738
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEORQp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgEORQp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FA261063;
        Fri, 15 May 2020 10:16:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0FB03F305;
        Fri, 15 May 2020 10:16:42 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
Date:   Fri, 15 May 2020 18:15:57 +0100
Message-Id: <20200515171612.1020-12-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To enable tagging on a memory range, the user must explicitly opt in via
a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
memory type in the AttrIndx field of a pte, simplify the or'ing of these
bits over the protection_map[] attributes by making MT_NORMAL index 0.

There are two conditions for arch_vm_get_page_prot() to return the
MT_NORMAL_TAGGED memory type: (1) the user requested it via PROT_MTE,
registered as VM_MTE in the vm_flags, and (2) the vma supports MTE,
decided during the mmap() call (only) and registered as VM_MTE_ALLOWED.

arch_calc_vm_prot_bits() is responsible for registering the user request
as VM_MTE. The newly introduced arch_calc_vm_flag_bits() sets
VM_MTE_ALLOWED if the mapping is MAP_ANONYMOUS. An MTE-capable
filesystem (RAM-based) may be able to set VM_MTE_ALLOWED during its
mmap() file ops call.

In addition, update VM_DATA_DEFAULT_FLAGS to allow mprotect(PROT_MTE) on
stack or brk area.

The Linux mmap() syscall currently ignores unknown PROT_* flags. In the
presence of MTE, an mmap(PROT_MTE) on a file which does not support MTE
will not report an error and the memory will not be mapped as Normal
Tagged. For consistency, mprotect(PROT_MTE) will not report an error
either if the memory range does not support MTE. Two subsequent patches
in the series will propose tightening of this behaviour.

Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v2:
    - Add VM_MTE_ALLOWED to show_smap_vma_flags().

 arch/arm64/include/asm/memory.h    | 18 +++++----
 arch/arm64/include/asm/mman.h      | 64 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/page.h      |  2 +-
 arch/arm64/include/asm/pgtable.h   |  7 +++-
 arch/arm64/include/uapi/asm/mman.h | 14 +++++++
 fs/proc/task_mmu.c                 |  4 ++
 include/linux/mm.h                 |  8 ++++
 7 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 472c77a68225..770535b7ca35 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -129,14 +129,18 @@
 
 /*
  * Memory types available.
+ *
+ * IMPORTANT: MT_NORMAL must be index 0 since vm_get_page_prot() may 'or' in
+ *	      the MT_NORMAL_TAGGED memory type for PROT_MTE mappings. Note
+ *	      that protection_map[] only contains MT_NORMAL attributes.
  */
-#define MT_DEVICE_nGnRnE	0
-#define MT_DEVICE_nGnRE		1
-#define MT_DEVICE_GRE		2
-#define MT_NORMAL_NC		3
-#define MT_NORMAL		4
-#define MT_NORMAL_WT		5
-#define MT_NORMAL_TAGGED	6
+#define MT_NORMAL		0
+#define MT_NORMAL_TAGGED	1
+#define MT_NORMAL_NC		2
+#define MT_NORMAL_WT		3
+#define MT_DEVICE_nGnRnE	4
+#define MT_DEVICE_nGnRE		5
+#define MT_DEVICE_GRE		6
 
 /*
  * Memory types for Stage-2 translation
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
new file mode 100644
index 000000000000..c77a23869223
--- /dev/null
+++ b/arch/arm64/include/asm/mman.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <uapi/asm/mman.h>
+
+/*
+ * There are two conditions required for returning a Normal Tagged memory type
+ * in arch_vm_get_page_prot(): (1) the user requested it via PROT_MTE passed
+ * to mmap() or mprotect() and (2) the corresponding vma supports MTE. We
+ * register (1) as VM_MTE in the vma->vm_flags and (2) as VM_MTE_ALLOWED. Note
+ * that the latter can only be set during the mmap() call since mprotect()
+ * does not accept MAP_* flags.
+ */
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+						   unsigned long pkey)
+{
+	if (!system_supports_mte())
+		return 0;
+
+	if (prot & PROT_MTE)
+		return VM_MTE;
+
+	return 0;
+}
+#define arch_calc_vm_prot_bits arch_calc_vm_prot_bits
+
+static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+{
+	if (!system_supports_mte())
+		return 0;
+
+	/*
+	 * Only allow MTE on anonymous mappings as these are guaranteed to be
+	 * backed by tags-capable memory. The vm_flags may be overridden by a
+	 * filesystem supporting MTE (RAM-based).
+	 */
+	if (flags & MAP_ANONYMOUS)
+		return VM_MTE_ALLOWED;
+
+	return 0;
+}
+#define arch_calc_vm_flag_bits arch_calc_vm_flag_bits
+
+static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_MTE) && (vm_flags & VM_MTE_ALLOWED) ?
+		__pgprot(PTE_ATTRINDX(MT_NORMAL_TAGGED)) :
+		__pgprot(0);
+}
+#define arch_vm_get_page_prot arch_vm_get_page_prot
+
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
+{
+	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
+
+	if (system_supports_mte())
+		supported |= PROT_MTE;
+
+	return (prot & ~supported) == 0;
+}
+#define arch_validate_prot arch_validate_prot
+
+#endif /* !__ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index c01b52add377..673033e0393b 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -36,7 +36,7 @@ extern int pfn_valid(unsigned long);
 
 #endif /* !__ASSEMBLY__ */
 
-#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
+#define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
 
 #include <asm-generic/getorder.h>
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 647a3f0c7874..f2cd59b01b27 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -665,8 +665,13 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+	/*
+	 * Normal and Normal-Tagged are two different memory types and indices
+	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
+	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE |
+			      PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
new file mode 100644
index 000000000000..d7677ee84878
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_MMAN_H
+#define _UAPI__ASM_MMAN_H
+
+#include <asm-generic/mman.h>
+
+/*
+ * The generic mman.h file reserves 0x10 and 0x20 for arch-specific PROT_*
+ * flags.
+ */
+/* 0x10 reserved for PROT_BTI */
+#define PROT_MTE	 0x20		/* Normal Tagged mapping */
+
+#endif /* !_UAPI__ASM_MMAN_H */
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8d382d4ec067..2f26112ebb77 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -647,6 +647,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MERGEABLE)]	= "mg",
 		[ilog2(VM_UFFD_MISSING)]= "um",
 		[ilog2(VM_UFFD_WP)]	= "uw",
+#ifdef CONFIG_ARM64_MTE
+		[ilog2(VM_MTE)]		= "mt",
+		[ilog2(VM_MTE_ALLOWED)]	= "",
+#endif
 #ifdef CONFIG_ARCH_HAS_PKEYS
 		/* These come out via ProtectionKey: */
 		[ilog2(VM_PKEY_BIT0)]	= "",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..132ca88e407d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -336,6 +336,14 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MPX		VM_NONE
 #endif
 
+#if defined(CONFIG_ARM64_MTE)
+# define VM_MTE		VM_HIGH_ARCH_0	/* Use Tagged memory for access control */
+# define VM_MTE_ALLOWED	VM_HIGH_ARCH_1	/* Tagged memory permitted */
+#else
+# define VM_MTE		VM_NONE
+# define VM_MTE_ALLOWED	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
