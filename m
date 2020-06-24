Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3869207ADF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405855AbgFXRxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405363AbgFXRxR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:53:17 -0400
Received: from localhost.localdomain (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3329820823;
        Wed, 24 Jun 2020 17:53:14 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 12/25] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
Date:   Wed, 24 Jun 2020 18:52:31 +0100
Message-Id: <20200624175244.25837-13-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624175244.25837-1-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
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

 arch/arm64/include/asm/memory.h    | 18 +++++++-----
 arch/arm64/include/asm/mman.h      | 44 ++++++++++++++++++++++++++++--
 arch/arm64/include/asm/page.h      |  2 +-
 arch/arm64/include/asm/pgtable.h   |  7 ++++-
 arch/arm64/include/uapi/asm/mman.h |  1 +
 fs/proc/task_mmu.c                 |  4 +++
 include/linux/mm.h                 |  8 ++++++
 7 files changed, 72 insertions(+), 12 deletions(-)

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
index 081ec8de9ea6..b01051be7750 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -9,16 +9,51 @@
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	unsigned long pkey __always_unused)
 {
+	unsigned long ret = 0;
+
 	if (system_supports_bti() && (prot & PROT_BTI))
-		return VM_ARM64_BTI;
+		ret |= VM_ARM64_BTI;
 
-	return 0;
+	if (system_supports_mte() && (prot & PROT_MTE))
+		ret |= VM_MTE;
+
+	return ret;
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
+static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+{
+	/*
+	 * Only allow MTE on anonymous mappings as these are guaranteed to be
+	 * backed by tags-capable memory. The vm_flags may be overridden by a
+	 * filesystem supporting MTE (RAM-based).
+	 */
+	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+		return VM_MTE_ALLOWED;
+
+	return 0;
+}
+#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
-	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
+	pteval_t prot = 0;
+
+	if (vm_flags & VM_ARM64_BTI)
+		prot |= PTE_GP;
+
+	/*
+	 * There are two conditions required for returning a Normal Tagged
+	 * memory type: (1) the user requested it via PROT_MTE passed to
+	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
+	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
+	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
+	 * mmap() call since mprotect() does not accept MAP_* flags.
+	 */
+	if ((vm_flags & VM_MTE) && (vm_flags & VM_MTE_ALLOWED))
+		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
+
+	return __pgprot(prot);
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
@@ -30,6 +65,9 @@ static inline bool arch_validate_prot(unsigned long prot,
 	if (system_supports_bti())
 		supported |= PROT_BTI;
 
+	if (system_supports_mte())
+		supported |= PROT_MTE;
+
 	return (prot & ~supported) == 0;
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index d918cb1d83a6..012cffc574e8 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -43,7 +43,7 @@ extern int pfn_valid(unsigned long);
 
 #endif /* !__ASSEMBLY__ */
 
-#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
+#define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
 
 #include <asm-generic/getorder.h>
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f9401a3205a8..78a545536a45 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -671,8 +671,13 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+	/*
+	 * Normal and Normal-Tagged are two different memory types and indices
+	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
+	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP;
+			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
+			      PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
index 6fdd71eb644f..1e6482a838e1 100644
--- a/arch/arm64/include/uapi/asm/mman.h
+++ b/arch/arm64/include/uapi/asm/mman.h
@@ -5,5 +5,6 @@
 #include <asm-generic/mman.h>
 
 #define PROT_BTI	0x10		/* BTI guarded page */
+#define PROT_MTE	0x20		/* Normal Tagged mapping */
 
 #endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index dbda4499a859..4f8ae353a8c5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -653,6 +653,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
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
index dc7b87310c10..65cbbfaa739b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -333,6 +333,14 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
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
