Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29C1B472C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgDVOZr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 10:25:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgDVOZr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 10:25:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559B430E;
        Wed, 22 Apr 2020 07:25:46 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC69C3F68F;
        Wed, 22 Apr 2020 07:25:44 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
Date:   Wed, 22 Apr 2020 15:25:29 +0100
Message-Id: <20200422142530.32619-4-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422142530.32619-1-steven.price@arm.com>
References: <20200422142530.32619-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When swapping pages out to disk it is necessary to save any tags that
have been set, and restore when swapping back in. To do this pages that
mapped so user space can access tags are marked with a new page flag
(PG_ARCH_2, locally named PG_mte_tagged). When swapping out these pages
the tags are stored in memory and later restored when the pages are
brought back in. Because shmem can swap pages back in without restoring
the userspace PTE it is also necessary to add a hook for shmem.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig               |  2 +-
 arch/arm64/include/asm/mte.h     |  6 ++
 arch/arm64/include/asm/pgtable.h | 44 ++++++++++++++
 arch/arm64/lib/mte.S             | 50 ++++++++++++++++
 arch/arm64/mm/Makefile           |  2 +-
 arch/arm64/mm/mteswap.c          | 98 ++++++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/mm/mteswap.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index af2e6e5dae1b..697d5c6b1d53 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1615,7 +1615,7 @@ config ARM64_MTE
 	bool "Memory Tagging Extension support"
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
 	select ARCH_USES_HIGH_VMA_FLAGS
-	select ARCH_NO_SWAP
+	select ARCH_USES_PG_ARCH_2
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 0ca2aaff07a1..28bb32b270ee 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -17,6 +17,10 @@ unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
 				      unsigned long n);
 unsigned long mte_copy_tags_to_user(void __user *to, void *from,
 				    unsigned long n);
+unsigned long mte_save_page_tags(const void *page_addr, void *tag_storage);
+void mte_restore_page_tags(void *page_addr, const void *tag_storage);
+
+#define PG_mte_tagged PG_arch_2
 
 #ifdef CONFIG_ARM64_MTE
 void flush_mte_state(void);
@@ -26,6 +30,8 @@ long set_mte_ctrl(unsigned long arg);
 long get_mte_ctrl(void);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
+void *mte_allocate_tag_storage(void);
+void mte_free_tag_storage(char *storage);
 #else
 static inline void flush_mte_state(void)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 39a372bf8afc..a4ad1b75a1a7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -80,6 +80,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
 #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
+#define pte_tagged(pte)		(!!((pte_val(pte) & PTE_ATTRINDX_MASK) == \
+				    PTE_ATTRINDX(MT_NORMAL_TAGGED)))
 
 #define pte_cont_addr_end(addr, end)						\
 ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
@@ -268,12 +270,17 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
 		     __func__, pte_val(old_pte), pte_val(pte));
 }
 
+void mte_sync_tags(pte_t *ptep, pte_t pte);
+
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
 		__sync_icache_dcache(pte);
 
+	if (system_supports_mte() && pte_tagged(pte))
+		mte_sync_tags(ptep, pte);
+
 	__check_racy_pte_update(mm, ptep, pte);
 
 	set_pte(ptep, pte);
@@ -845,6 +852,43 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 
 extern int kern_addr_valid(unsigned long addr);
 
+#ifdef CONFIG_ARM64_MTE
+
+#define __HAVE_ARCH_PREPARE_TO_SWAP
+int mte_save_tags(struct page *page);
+static inline int arch_prepare_to_swap(struct page *page)
+{
+	if (system_supports_mte())
+		return mte_save_tags(page);
+	return 0;
+}
+
+#define __HAVE_ARCH_SWAP_INVALIDATE
+void mte_invalidate_tags(int type, pgoff_t offset);
+void mte_invalidate_tags_area(int type);
+
+static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
+{
+	if (system_supports_mte())
+		mte_invalidate_tags(type, offset);
+}
+
+static inline void arch_swap_invalidate_area(int type)
+{
+	if (system_supports_mte())
+		mte_invalidate_tags_area(type);
+}
+
+#define __HAVE_ARCH_SWAP_RESTORE_TAGS
+void mte_restore_tags(swp_entry_t entry, struct page *page);
+static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
+{
+	if (system_supports_mte())
+		mte_restore_tags(entry, page);
+}
+
+#endif /* CONFIG_ARM64_MTE */
+
 #include <asm-generic/pgtable.h>
 
 /*
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 45be04a8c73c..df8800dfe891 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -94,3 +94,53 @@ USER(2f, sttrb	w4, [x0])
 2:	sub	x0, x0, x3		// update the number of tags copied
 	ret
 SYM_FUNC_END(mte_copy_tags_from_user)
+
+/*
+ * Save the tags in a page
+ *   x0 - page address
+ *   x1 - tag storage
+ *
+ * Returns 0 if all tags are 0, otherwise non-zero
+ */
+SYM_FUNC_START(mte_save_page_tags)
+	multitag_transfer_size x7, x5
+	mov	x3, #0
+1:
+	mov	x2, #0
+2:
+	ldgm	x5, [x0]
+	orr	x2, x2, x5
+	add	x0, x0, x7
+	tst	x0, #0xFF		// 16 tag values fit in a register,
+	b.ne	2b			// which is 16*4=256 bytes
+
+	str	x2, [x1], #8
+
+	orr	x3, x3, x2		// OR together all the tag values
+	tst	x0, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	mov	x0, x3
+	ret
+SYM_FUNC_END(mte_save_page_tags)
+
+/*
+ * Restore the tags in a page
+ *   x0 - page address
+ *   x1 - tag storage
+ */
+SYM_FUNC_START(mte_restore_page_tags)
+	multitag_transfer_size x7, x5
+1:
+	ldr	x2, [x1], #8
+2:
+	stgm	x2, [x0]
+	add	x0, x0, x7
+	tst	x0, #0xFF
+	b.ne	2b
+
+	tst	x0, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	ret
+SYM_FUNC_END(mte_restore_page_tags)
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index e93d696295d0..cd7cb19fc224 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
-obj-$(CONFIG_ARM64_MTE)		+= cmppages.o
+obj-$(CONFIG_ARM64_MTE)		+= cmppages.o mteswap.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
new file mode 100644
index 000000000000..3f8ab5a6d33b
--- /dev/null
+++ b/arch/arm64/mm/mteswap.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/pagemap.h>
+#include <linux/xarray.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <asm/mte.h>
+
+static DEFINE_XARRAY(mte_pages);
+
+void *mte_allocate_tag_storage(void)
+{
+	/* tags granule is 16 bytes, 2 tags stored per byte */
+	return kmalloc(PAGE_SIZE / 16 / 2, GFP_KERNEL);
+}
+
+void mte_free_tag_storage(char *storage)
+{
+	kfree(storage);
+}
+
+int mte_save_tags(struct page *page)
+{
+	void *tag_storage, *ret;
+
+	if (!test_bit(PG_mte_tagged, &page->flags))
+		return 0;
+
+	tag_storage = mte_allocate_tag_storage();
+	if (!tag_storage)
+		return -ENOMEM;
+
+	mte_save_page_tags(page_address(page), tag_storage);
+
+	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
+	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
+		mte_free_tag_storage(tag_storage);
+		return xa_err(ret);
+	} else if (ret) {
+		mte_free_tag_storage(ret);
+	}
+
+	return 0;
+}
+
+void mte_restore_tags(swp_entry_t entry, struct page *page)
+{
+	void *tags = xa_load(&mte_pages, entry.val);
+
+	if (!tags)
+		return;
+
+	mte_restore_page_tags(page_address(page), tags);
+
+	set_bit(PG_mte_tagged, &page->flags);
+}
+
+void mte_invalidate_tags(int type, pgoff_t offset)
+{
+	swp_entry_t entry = swp_entry(type, offset);
+	void *tags = xa_erase(&mte_pages, entry.val);
+
+	mte_free_tag_storage(tags);
+}
+
+void mte_invalidate_tags_area(int type)
+{
+	swp_entry_t entry = swp_entry(type, 0);
+	swp_entry_t last_entry = swp_entry(type + 1, 0);
+	void *tags;
+
+	XA_STATE(xa_state, &mte_pages, entry.val);
+
+	xa_lock(&mte_pages);
+	xas_for_each(&xa_state, tags, last_entry.val - 1) {
+		__xa_erase(&mte_pages, xa_state.xa_index);
+		mte_free_tag_storage(tags);
+	}
+	xa_unlock(&mte_pages);
+}
+
+void mte_sync_tags(pte_t *ptep, pte_t pte)
+{
+	struct page *page = pte_page(pte);
+	pte_t old_pte = READ_ONCE(*ptep);
+	swp_entry_t entry;
+
+	set_bit(PG_mte_tagged, &page->flags);
+
+	if (!is_swap_pte(old_pte))
+		return;
+
+	entry = pte_to_swp_entry(old_pte);
+	if (non_swap_entry(entry))
+		return;
+
+	mte_restore_tags(entry, page);
+}
-- 
2.20.1

