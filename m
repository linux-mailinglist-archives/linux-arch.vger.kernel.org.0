Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C2F13D292
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 04:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgAPDON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 22:14:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729486AbgAPDOM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 22:14:12 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E354639AE2689F3FF6F;
        Thu, 16 Jan 2020 11:14:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 11:13:59 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH 2/2] arm64: mm: rework the pmd protect changing flow
Date:   Thu, 16 Jan 2020 11:09:17 +0800
Message-ID: <1579144157-7736-3-git-send-email-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1579144157-7736-1-git-send-email-wxf.wang@hisilicon.com>
References: <1579144157-7736-1-git-send-email-wxf.wang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On KunPeng920 board. When changing permission of a large range region,
pmdp_invalidate() takes about 65% in profile (with hugepages) in JIT tool.
Kernel will flush tlb twice: first flush happens in pmdp_invalidate, second
flush happens at the end of change_protect_range(). The first pmdp_invalidate
is not necessary if the hardware support atomic pmdp changing. The atomic
changing pimd to zero can prevent the hardware from update asynchronous.
So reconstruct it and remove the first pmdp_invalidate. And the second tlb
flush can make sure the new tlb entry valid.

Add pmdp_modify_prot_start() in arm64, which uses pmdp_huge_get_and_clear()
to fetch the pmd and zero entry, preventing racing of any hardware updates.

After rework, the mprotect can get 3~13 times performace gain in range
64M to 512M.

4K granule/THP on
memory size(M)	64	128	256	320	448	512
pre-patch		0.77	1.40	2.64	3.23	4.49	5.10
post-patch		0.20	0.23	0.28	0.31	0.37	0.39

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index cd5de0e40bfa..bccdaa5bd5f2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -769,6 +769,20 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_PMDP_MODIFY_PROT_TRANSACTION
+static inline pmd_t pmdp_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr,
+						pmd_t *pmdp)
+{
+	/*
+	 * Atomic change pmd to zero, prevent the hardware from update
+	 * aynchronously update it.
+	 */
+	return pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * ptep_set_wrprotect - mark read-only while trasferring potential hardware
  * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
-- 
2.17.1

