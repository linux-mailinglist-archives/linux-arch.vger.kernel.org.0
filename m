Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB714623B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 08:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAWHFN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 02:05:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgAWHFN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 02:05:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48CDD697474171B3E209;
        Thu, 23 Jan 2020 15:05:10 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 15:05:03 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <chenzhou10@huawei.com>,
        Xuefeng Wang <wxf.wang@hisilicon.com>
Subject: [PATCH v2 1/2] mm: add helpers pmdp_modify_prot_start/commit
Date:   Thu, 23 Jan 2020 15:55:12 +0800
Message-ID: <20200123075514.15142-2-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123075514.15142-1-wxf.wang@hisilicon.com>
References: <20200123075514.15142-1-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce helpers pmdp_modify_prot_start/commit to abstract
pmdp_modify_prot transaction. Helpers pmdp_modify_prot_start/commit are
functionally unchanged.

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 include/asm-generic/pgtable.h | 35 +++++++++++++++++++++++++++++++++++
 mm/huge_memory.c              | 19 ++++++++-----------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 798ea36a0549..e81bd58a9170 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -673,6 +673,41 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+static inline pmd_t __pmdp_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp)
+{
+	return pmdp_invalidate(vma, addr, pmdp);
+}
+
+static inline void __pmdp_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp, pmd_t pmd)
+{
+	set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifndef __HAVE_ARCH_PMDP_MODIFY_PROT_TRANSACTION
+static inline pmd_t pmdp_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp)
+{
+	__pmdp_modify_prot_start(vma, addr, pmdp);
+}
+#endif /* __HAVE_ARCH_PMDP_MODIFY_PROT_TRANSACTION */
+
+/*
+ * Commit an update to a pmd.
+ */
+static inline void pmdp_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp, pmd_t old_pmd, pmd_t pmd)
+{
+	__pmdp_modify_prot_commit(vma, addr, pmdp, pmd);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* CONFIG_MMU */

 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a88093213674..53515a3c91dd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1933,9 +1933,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
		unsigned long addr, pgprot_t newprot, int prot_numa)
 {
-	struct mm_struct *mm = vma->vm_mm;
	spinlock_t *ptl;
-	pmd_t entry;
+	pmd_t pmdnt, oldpmd;
	bool preserve_write;
	int ret;

@@ -1961,7 +1960,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
			newpmd = swp_entry_to_pmd(entry);
			if (pmd_swp_soft_dirty(*pmd))
				newpmd = pmd_swp_mksoft_dirty(newpmd);
-			set_pmd_at(mm, addr, pmd, newpmd);
+			set_pmd_at(vma->vm_mm, addr, pmd, newpmd);
		}
		goto unlock;
	}
@@ -1995,18 +1994,16 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
	 *
	 * The race makes MADV_DONTNEED miss the huge pmd and don't clear it
	 * which may break userspace.
-	 *
-	 * pmdp_invalidate() is required to make sure we don't miss
-	 * dirty/young flags set by hardware.
	 */
-	entry = pmdp_invalidate(vma, addr, pmd);

-	entry = pmd_modify(entry, newprot);
+	oldpmd = pmdp_modify_prot_start(vma, addr, pmd);
+	pmdnt = pmd_modify(oldpmd, newprot);
	if (preserve_write)
-		entry = pmd_mk_savedwrite(entry);
+		pmdnt = pmd_mk_savedwrite(pmdnt);
+	pmdp_modify_prot_commit(vma, addr, pmd, oldpmd, pmdnt);
+
	ret = HPAGE_PMD_NR;
-	set_pmd_at(mm, addr, pmd, entry);
-	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
+	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(pmdnt));
 unlock:
	spin_unlock(ptl);
	return ret;
--
2.17.1
