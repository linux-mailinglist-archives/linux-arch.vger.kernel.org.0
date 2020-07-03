Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF047213CC0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGCPhn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 11:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPhn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 11:37:43 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F84820899;
        Fri,  3 Jul 2020 15:37:39 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v6 08/26] arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE
Date:   Fri,  3 Jul 2020 16:37:00 +0100
Message-Id: <20200703153718.16973-9-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703153718.16973-1-catalin.marinas@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pages allocated by the kernel are not guaranteed to have the tags
zeroed, especially as the kernel does not (yet) use MTE itself. To
ensure the user can still access such pages when mapped into its address
space, clear the tags via set_pte_at(). A new page flag - PG_mte_tagged
(PG_arch_2) - is used to track pages with valid allocation tags.

Since the zero page is mapped as pte_special(), it won't be covered by
the above set_pte_at() mechanism. Clear its tags during early MTE
initialisation.

Co-developed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v5:
    - Fix the handling of compound pages. Previously, set_pte_at() could
      have erased already valid tags if the first page in a compound one
      did not have the PG_mte_tagged flag set.
    - Move the multi_tag_transfer_size macro from assembler.h to mte.S.
    - Ignore pte_special() mappings and clear the tags in the zero page
      separately (since it's mapped as a special pte).
    - Clearing the tags of the zero page was moved to this patch from an
      earlier one since mte_clear_page_tags() was not available.
    
    New in v4. Replacing a previous page zeroing the tags in clear_page().

 arch/arm64/include/asm/mte.h     | 16 +++++++++++++++
 arch/arm64/include/asm/pgtable.h |  7 +++++++
 arch/arm64/kernel/cpufeature.c   |  7 +++++++
 arch/arm64/kernel/mte.c          | 14 +++++++++++++
 arch/arm64/lib/Makefile          |  2 ++
 arch/arm64/lib/mte.S             | 34 ++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
 create mode 100644 arch/arm64/lib/mte.S

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index a0bf310da74b..1716b3d02489 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -7,12 +7,28 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/page-flags.h>
+
+#include <asm/pgtable-types.h>
+
+void mte_clear_page_tags(void *addr);
+
 #ifdef CONFIG_ARM64_MTE
 
+/* track which pages have valid allocation tags */
+#define PG_mte_tagged	PG_arch_2
+
+void mte_sync_tags(pte_t *ptep, pte_t pte);
 void flush_mte_state(void);
 
 #else
 
+/* unused if !CONFIG_ARM64_MTE, silence the compiler */
+#define PG_mte_tagged	0
+
+static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
+{
+}
 static inline void flush_mte_state(void)
 {
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 758e2d1577d0..f9401a3205a8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -9,6 +9,7 @@
 #include <asm/proc-fns.h>
 
 #include <asm/memory.h>
+#include <asm/mte.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable-prot.h>
 #include <asm/tlbflush.h>
@@ -80,6 +81,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
 #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
+#define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
+				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
 #define pte_cont_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
@@ -274,6 +277,10 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
+	if (system_supports_mte() &&
+	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
+		mte_sync_tags(ptep, pte);
+
 	__check_racy_pte_update(mm, ptep, pte);
 
 	set_pte(ptep, pte);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 51645f39bbae..f55a3b63abfd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -75,6 +75,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 #include <asm/traps.h>
@@ -1690,6 +1691,12 @@ static int __init system_enable_mte(void)
 	/* Ensure the TLB does not have stale MAIR attributes */
 	flush_tlb_all();
 
+	/*
+	 * Clear the tags in the zero page. This needs to be done via the
+	 * linear map which has the Tagged attribute.
+	 */
+	mte_clear_page_tags(lm_alias(empty_zero_page));
+
 	return 0;
 }
 core_initcall(system_enable_mte);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 032016823957..5bf9bbed5a25 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -3,12 +3,26 @@
  * Copyright (C) 2020 ARM Ltd.
  */
 
+#include <linux/bitops.h>
+#include <linux/mm.h>
 #include <linux/thread_info.h>
 
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 #include <asm/sysreg.h>
 
+void mte_sync_tags(pte_t *ptep, pte_t pte)
+{
+	struct page *page = pte_page(pte);
+	long i, nr_pages = compound_nr(page);
+
+	/* if PG_mte_tagged is set, tags have already been initialised */
+	for (i = 0; i < nr_pages; i++, page++) {
+		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
+			mte_clear_page_tags(page_address(page));
+	}
+}
+
 void flush_mte_state(void)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 2fc253466dbf..d31e1169d9b8 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -16,3 +16,5 @@ lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 obj-$(CONFIG_CRC32) += crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_ARM64_MTE) += mte.o
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
new file mode 100644
index 000000000000..a36705640086
--- /dev/null
+++ b/arch/arm64/lib/mte.S
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+#include <asm/sysreg.h>
+
+	.arch	armv8.5-a+memtag
+
+/*
+ * multitag_transfer_size - set \reg to the block size that is accessed by the
+ * LDGM/STGM instructions.
+ */
+	.macro	multitag_transfer_size, reg, tmp
+	mrs_s	\reg, SYS_GMID_EL1
+	ubfx	\reg, \reg, #SYS_GMID_EL1_BS_SHIFT, #SYS_GMID_EL1_BS_SIZE
+	mov	\tmp, #4
+	lsl	\reg, \tmp, \reg
+	.endm
+
+/*
+ * Clear the tags in a page
+ *   x0 - address of the page to be cleared
+ */
+SYM_FUNC_START(mte_clear_page_tags)
+	multitag_transfer_size x1, x2
+1:	stgm	xzr, [x0]
+	add	x0, x0, x1
+	tst	x0, #(PAGE_SIZE - 1)
+	b.ne	1b
+	ret
+SYM_FUNC_END(mte_clear_page_tags)
