Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB81D5734
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgEORQh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:37 -0400
Received: from foss.arm.com ([217.140.110.172]:59404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgEORQh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C7991042;
        Fri, 15 May 2020 10:16:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE8733F305;
        Fri, 15 May 2020 10:16:34 -0700 (PDT)
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
        Steven Price <steven.price@arm.com>
Subject: [PATCH v4 07/26] arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE
Date:   Fri, 15 May 2020 18:15:53 +0100
Message-Id: <20200515171612.1020-8-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pages allocated by the kernel are not guaranteed to have the tags
zeroed, especially as the kernel does not yet use MTE itself. To ensure
the user can still access such pages when mapped into its address space,
clear the tags via set_pte_at(). A new page flag - PG_mte_tagged
(PG_arch_2) - is used to track pages with valid allocation tags.

Co-developed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    New in v4. Replacing a previous page zeroing the tags in clear_page().

 arch/arm64/include/asm/assembler.h | 12 ++++++++++++
 arch/arm64/include/asm/mte.h       | 16 ++++++++++++++++
 arch/arm64/include/asm/pgtable.h   |  6 ++++++
 arch/arm64/kernel/mte.c            | 14 ++++++++++++++
 arch/arm64/lib/Makefile            |  2 ++
 arch/arm64/lib/mte.S               | 23 +++++++++++++++++++++++
 6 files changed, 73 insertions(+)
 create mode 100644 arch/arm64/lib/mte.S

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bff325117b4..dacd66df6c05 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 #include <asm/thread_info.h>
 
 	.macro save_and_disable_daif, flags
@@ -736,4 +737,15 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 .Lyield_out_\@ :
 	.endm
 
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
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index a0bf310da74b..4310a7ff10c0 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -7,12 +7,28 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/page-flags.h>
+
+#include <asm/pgtable-types.h>
+
+void mte_clear_page_tags(void *addr, size_t size);
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
index 538c85e62f86..647a3f0c7874 100644
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
@@ -274,6 +277,9 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
+	if (system_supports_mte() && pte_present(pte) && pte_tagged(pte))
+		mte_sync_tags(ptep, pte);
+
 	__check_racy_pte_update(mm, ptep, pte);
 
 	set_pte(ptep, pte);
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 032016823957..65a2f8490d18 100644
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
+
+	/* if PG_mte_tagged is set, tags have already been initialised */
+	if (test_and_set_bit(PG_mte_tagged, &page->flags))
+		return;
+
+	/* tags of the zero page will be cleared on first mapping */
+	mte_clear_page_tags(page_address(page), page_size(page));
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
index 000000000000..130fb7047e17
--- /dev/null
+++ b/arch/arm64/lib/mte.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+
+	.arch	armv8.5-a+memtag
+
+/*
+ * Clear the tags in a (potentially huge) page
+ *   x0 - page address
+ *   x1 - page size
+ */
+SYM_FUNC_START(mte_clear_page_tags)
+	multitag_transfer_size x2, x3
+1:	stgm	xzr, [x0]
+	add	x0, x0, x2
+	sub	x1, x1, x2
+	cbnz	x1, 1b
+	ret
+SYM_FUNC_END(mte_clear_page_tags)
