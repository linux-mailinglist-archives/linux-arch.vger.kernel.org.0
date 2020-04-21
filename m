Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526661B1BF1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDUCfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 22:35:43 -0400
Received: from foss.arm.com ([217.140.110.172]:56898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgDUCfn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 22:35:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2C331B;
        Mon, 20 Apr 2020 19:35:41 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 401E03F73D;
        Mon, 20 Apr 2020 19:35:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH V17 2/2] mm/debug: Add tests validating architecture page table helpers
Date:   Tue, 21 Apr 2020 08:04:55 +0530
Message-Id: <1587436495-22033-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587436495-22033-1-git-send-email-anshuman.khandual@arm.com>
References: <1587436495-22033-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds tests which will validate architecture page table helpers and
other accessors in their compliance with expected generic MM semantics.
This will help various architectures in validating changes to existing
page table helpers or addition of new ones.

This test covers basic page table entry transformations including but not
limited to old, young, dirty, clean, write, write protect etc at various
level along with populating intermediate entries with next page table page
and validating them.

Test page table pages are allocated from system memory with required size
and alignments. The mapped pfns at page table levels are derived from a
real pfn representing a valid kernel text symbol. This test gets called
via late_initcall().

This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
architecture, which is willing to subscribe this test will need to select
ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
and powerpc platforms where the test is known to build and run successfully
Going forward, other architectures too can subscribe the test after fixing
any build or runtime problems with their page table helpers. Meanwhile for
better platform coverage, the test can also be enabled with CONFIG_EXPERT
even without ARCH_HAS_DEBUG_VM_PGTABLE.

Folks interested in making sure that a given platform's page table helpers
conform to expected generic MM semantics should enable the above config
which will just trigger this test during boot. Any non conformity here will
be reported as an warning which would need to be fixed. This test will help
catch any changes to the agreed upon semantics expected from generic MM and
enable platforms to accommodate it thereafter.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>	# s390
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>	# ppc32
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../debug/debug-vm-pgtable/arch-support.txt   |  34 ++
 arch/arc/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/s390/Kconfig                             |   1 +
 arch/x86/Kconfig                              |   1 +
 lib/Kconfig.debug                             |  25 ++
 mm/Makefile                                   |   1 +
 mm/debug_vm_pgtable.c                         | 382 ++++++++++++++++++
 9 files changed, 447 insertions(+)
 create mode 100644 Documentation/features/debug/debug-vm-pgtable/arch-support.txt
 create mode 100644 mm/debug_vm_pgtable.c

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
new file mode 100644
index 000000000000..c527d05c0459
--- /dev/null
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -0,0 +1,34 @@
+#
+# Feature name:          debug-vm-pgtable
+#         Kconfig:       ARCH_HAS_DEBUG_VM_PGTABLE
+#         description:   arch supports pgtable tests for semantics compliance
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: |  ok  |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |         c6x: | TODO |
+    |        csky: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |       nds32: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ff306246d0f8..471ef22216c4 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..0efb46abaf3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a9260..4e89f22cdd27 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -116,6 +116,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2167bce993ff..8206b2c19aa8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -59,6 +59,7 @@ config KASAN_SHADOW_OFFSET
 config S390
 	def_bool y
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..eaba476f4660 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,7 @@ config X86
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
+	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..6a492e32579a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -653,6 +653,12 @@ config SCHED_STACK_END_CHECK
 	  data corruption or a sporadic crash at a later stage once the region
 	  is examined. The runtime overhead introduced is minimal.
 
+config ARCH_HAS_DEBUG_VM_PGTABLE
+	bool
+	help
+	  An architecture should select this when it can successfully
+	  build and run DEBUG_VM_PGTABLE.
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -688,6 +694,25 @@ config DEBUG_VM_PGFLAGS
 
 	  If unsure, say N.
 
+config DEBUG_VM_PGTABLE
+	bool "Debug arch page table for semantics compliance"
+	depends on MMU
+	depends on !IA64 && !ARM
+	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
+	default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
+	help
+	  This option provides a debug method which can be used to test
+	  architecture page table helper functions on various platforms in
+	  verifying if they comply with expected generic MM semantics. This
+	  will help architecture code in making sure that any changes or
+	  new additions of these helpers still conform to expected
+	  semantics of the generic MM. Platforms will have to opt in for
+	  this through ARCH_HAS_DEBUG_VM_PGTABLE. Although it can also be
+	  enabled through EXPERT without requiring code change. This test
+	  is disabled on IA64 and ARM platforms where it fails to build.
+
+	  If unsure, say N.
+
 config ARCH_HAS_DEBUG_VIRTUAL
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index fccd3756b25f..662fd1504646 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_HWPOISON_INJECT) += hwpoison-inject.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
+obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
new file mode 100644
index 000000000000..188c18908964
--- /dev/null
+++ b/mm/debug_vm_pgtable.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This kernel test validates architecture page table helpers and
+ * accessors and helps in verifying their continued compliance with
+ * expected generic MM semantics.
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define pr_fmt(fmt) "debug_vm_pgtable: %s: " fmt, __func__
+
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/hugetlb.h>
+#include <linux/kernel.h>
+#include <linux/kconfig.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/mm_types.h>
+#include <linux/module.h>
+#include <linux/pfn_t.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/spinlock.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/start_kernel.h>
+#include <linux/sched/mm.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+
+#define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
+
+/*
+ * On s390 platform, the lower 4 bits are used to identify given page table
+ * entry type. But these bits might affect the ability to clear entries with
+ * pxx_clear() because of how dynamic page table folding works on s390. So
+ * while loading up the entries do not change the lower 4 bits. It does not
+ * have affect any other platform.
+ */
+#define S390_MASK_BITS	4
+#define RANDOM_ORVALUE	GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
+#define RANDOM_NZVALUE	GENMASK(7, 0)
+
+static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	WARN_ON(!pte_same(pte, pte));
+	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
+	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
+	WARN_ON(!pte_write(pte_mkwrite(pte_wrprotect(pte))));
+	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
+	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
+	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = pfn_pmd(pfn, prot);
+
+	WARN_ON(!pmd_same(pmd, pmd));
+	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
+	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
+	WARN_ON(!pmd_write(pmd_mkwrite(pmd_wrprotect(pmd))));
+	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
+	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
+	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
+	/*
+	 * A huge page does not point to next level page table
+	 * entry. Hence this must qualify as pmd_bad().
+	 */
+	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
+}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	pud_t pud = pfn_pud(pfn, prot);
+
+	WARN_ON(!pud_same(pud, pud));
+	WARN_ON(!pud_young(pud_mkyoung(pud_mkold(pud))));
+	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
+	WARN_ON(pud_write(pud_wrprotect(pud_mkwrite(pud))));
+	WARN_ON(pud_young(pud_mkold(pud_mkyoung(pud))));
+
+	if (mm_pmd_folded(mm))
+		return;
+
+	/*
+	 * A huge page does not point to next level page table
+	 * entry. Hence this must qualify as pud_bad().
+	 */
+	WARN_ON(!pud_bad(pud_mkhuge(pud)));
+}
+#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+#else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	p4d_t p4d;
+
+	memset(&p4d, RANDOM_NZVALUE, sizeof(p4d_t));
+	WARN_ON(!p4d_same(p4d, p4d));
+}
+
+static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	pgd_t pgd;
+
+	memset(&pgd, RANDOM_NZVALUE, sizeof(pgd_t));
+	WARN_ON(!pgd_same(pgd, pgd));
+}
+
+#ifndef __PAGETABLE_PUD_FOLDED
+static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
+{
+	pud_t pud = READ_ONCE(*pudp);
+
+	if (mm_pmd_folded(mm))
+		return;
+
+	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
+	WRITE_ONCE(*pudp, pud);
+	pud_clear(pudp);
+	pud = READ_ONCE(*pudp);
+	WARN_ON(!pud_none(pud));
+}
+
+static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
+				      pmd_t *pmdp)
+{
+	pud_t pud;
+
+	if (mm_pmd_folded(mm))
+		return;
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pud_bad().
+	 */
+	pmd_clear(pmdp);
+	pud_clear(pudp);
+	pud_populate(mm, pudp, pmdp);
+	pud = READ_ONCE(*pudp);
+	WARN_ON(pud_bad(pud));
+}
+#else  /* !__PAGETABLE_PUD_FOLDED */
+static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp) { }
+static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
+				      pmd_t *pmdp)
+{
+}
+#endif /* PAGETABLE_PUD_FOLDED */
+
+#ifndef __PAGETABLE_P4D_FOLDED
+static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
+{
+	p4d_t p4d = READ_ONCE(*p4dp);
+
+	if (mm_pud_folded(mm))
+		return;
+
+	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
+	WRITE_ONCE(*p4dp, p4d);
+	p4d_clear(p4dp);
+	p4d = READ_ONCE(*p4dp);
+	WARN_ON(!p4d_none(p4d));
+}
+
+static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
+				      pud_t *pudp)
+{
+	p4d_t p4d;
+
+	if (mm_pud_folded(mm))
+		return;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as p4d_bad().
+	 */
+	pud_clear(pudp);
+	p4d_clear(p4dp);
+	p4d_populate(mm, p4dp, pudp);
+	p4d = READ_ONCE(*p4dp);
+	WARN_ON(p4d_bad(p4d));
+}
+
+static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
+{
+	pgd_t pgd = READ_ONCE(*pgdp);
+
+	if (mm_p4d_folded(mm))
+		return;
+
+	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
+	WRITE_ONCE(*pgdp, pgd);
+	pgd_clear(pgdp);
+	pgd = READ_ONCE(*pgdp);
+	WARN_ON(!pgd_none(pgd));
+}
+
+static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
+				      p4d_t *p4dp)
+{
+	pgd_t pgd;
+
+	if (mm_p4d_folded(mm))
+		return;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pgd_bad().
+	 */
+	p4d_clear(p4dp);
+	pgd_clear(pgdp);
+	pgd_populate(mm, pgdp, p4dp);
+	pgd = READ_ONCE(*pgdp);
+	WARN_ON(pgd_bad(pgd));
+}
+#else  /* !__PAGETABLE_P4D_FOLDED */
+static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp) { }
+static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp) { }
+static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
+				      pud_t *pudp)
+{
+}
+static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
+				      p4d_t *p4dp)
+{
+}
+#endif /* PAGETABLE_P4D_FOLDED */
+
+static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
+				   unsigned long vaddr)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
+	set_pte_at(mm, vaddr, ptep, pte);
+	barrier();
+	pte_clear(mm, vaddr, ptep);
+	pte = READ_ONCE(*ptep);
+	WARN_ON(!pte_none(pte));
+}
+
+static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
+{
+	pmd_t pmd = READ_ONCE(*pmdp);
+
+	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
+	WRITE_ONCE(*pmdp, pmd);
+	pmd_clear(pmdp);
+	pmd = READ_ONCE(*pmdp);
+	WARN_ON(!pmd_none(pmd));
+}
+
+static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
+				      pgtable_t pgtable)
+{
+	pmd_t pmd;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pmd_bad().
+	 */
+	pmd_clear(pmdp);
+	pmd_populate(mm, pmdp, pgtable);
+	pmd = READ_ONCE(*pmdp);
+	WARN_ON(pmd_bad(pmd));
+}
+
+static unsigned long __init get_random_vaddr(void)
+{
+	unsigned long random_vaddr, random_pages, total_user_pages;
+
+	total_user_pages = (TASK_SIZE - FIRST_USER_ADDRESS) / PAGE_SIZE;
+
+	random_pages = get_random_long() % total_user_pages;
+	random_vaddr = FIRST_USER_ADDRESS + random_pages * PAGE_SIZE;
+
+	return random_vaddr;
+}
+
+static int __init debug_vm_pgtable(void)
+{
+	struct mm_struct *mm;
+	pgd_t *pgdp;
+	p4d_t *p4dp, *saved_p4dp;
+	pud_t *pudp, *saved_pudp;
+	pmd_t *pmdp, *saved_pmdp, pmd;
+	pte_t *ptep;
+	pgtable_t saved_ptep;
+	pgprot_t prot;
+	phys_addr_t paddr;
+	unsigned long vaddr, pte_aligned, pmd_aligned;
+	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
+	spinlock_t *uninitialized_var(ptl);
+
+	pr_info("Validating architecture page table helpers\n");
+	prot = vm_get_page_prot(VMFLAGS);
+	vaddr = get_random_vaddr();
+	mm = mm_alloc();
+	if (!mm) {
+		pr_err("mm_struct allocation failed\n");
+		return 1;
+	}
+
+	/*
+	 * PFN for mapping at PTE level is determined from a standard kernel
+	 * text symbol. But pfns for higher page table levels are derived by
+	 * masking lower bits of this real pfn. These derived pfns might not
+	 * exist on the platform but that does not really matter as pfn_pxx()
+	 * helpers will still create appropriate entries for the test. This
+	 * helps avoid large memory block allocations to be used for mapping
+	 * at higher page table levels.
+	 */
+	paddr = __pa_symbol(&start_kernel);
+
+	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
+	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
+	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
+	p4d_aligned = (paddr & P4D_MASK) >> PAGE_SHIFT;
+	pgd_aligned = (paddr & PGDIR_MASK) >> PAGE_SHIFT;
+	WARN_ON(!pfn_valid(pte_aligned));
+
+	pgdp = pgd_offset(mm, vaddr);
+	p4dp = p4d_alloc(mm, pgdp, vaddr);
+	pudp = pud_alloc(mm, p4dp, vaddr);
+	pmdp = pmd_alloc(mm, pudp, vaddr);
+	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
+
+	/*
+	 * Save all the page table page addresses as the page table
+	 * entries will be used for testing with random or garbage
+	 * values. These saved addresses will be used for freeing
+	 * page table pages.
+	 */
+	pmd = READ_ONCE(*pmdp);
+	saved_p4dp = p4d_offset(pgdp, 0UL);
+	saved_pudp = pud_offset(p4dp, 0UL);
+	saved_pmdp = pmd_offset(pudp, 0UL);
+	saved_ptep = pmd_pgtable(pmd);
+
+	pte_basic_tests(pte_aligned, prot);
+	pmd_basic_tests(pmd_aligned, prot);
+	pud_basic_tests(pud_aligned, prot);
+	p4d_basic_tests(p4d_aligned, prot);
+	pgd_basic_tests(pgd_aligned, prot);
+
+	pte_clear_tests(mm, ptep, vaddr);
+	pmd_clear_tests(mm, pmdp);
+	pud_clear_tests(mm, pudp);
+	p4d_clear_tests(mm, p4dp);
+	pgd_clear_tests(mm, pgdp);
+
+	pte_unmap_unlock(ptep, ptl);
+
+	pmd_populate_tests(mm, pmdp, saved_ptep);
+	pud_populate_tests(mm, pudp, saved_pmdp);
+	p4d_populate_tests(mm, p4dp, saved_pudp);
+	pgd_populate_tests(mm, pgdp, saved_p4dp);
+
+	p4d_free(mm, saved_p4dp);
+	pud_free(mm, saved_pudp);
+	pmd_free(mm, saved_pmdp);
+	pte_free(mm, saved_ptep);
+
+	mm_dec_nr_puds(mm);
+	mm_dec_nr_pmds(mm);
+	mm_dec_nr_ptes(mm);
+	mmdrop(mm);
+	return 0;
+}
+late_initcall(debug_vm_pgtable);
-- 
2.20.1

