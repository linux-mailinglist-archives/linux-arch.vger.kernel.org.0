Return-Path: <linux-arch+bounces-6033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF69489C4
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F1E1C23203
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663FD165F1A;
	Tue,  6 Aug 2024 07:07:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F48165F0A;
	Tue,  6 Aug 2024 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928060; cv=none; b=IlGMTqH3Ol/rsdVFwkG6noOsmLY80DJ1V8qQPn+4Qo15iSvXpA/7MLZHnzN3wE13ReTBvqB/dVYFO1BJ3xUAkOogstJCNYsXUMS6MwXYSEJiAH/ohPzmtQ+ySG6JPETc4BXfp1FBKhPV2jURNi9OO8Yz2tfVa1AnumWkxelhr0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928060; c=relaxed/simple;
	bh=0QyfPp2XyuRP/3Ii92yBHnxtCiHbLZQdi+sxjgJzRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PaTPmnfgcgcvg/FIOum9GoMd+2EwQ7aIGxykjEQamW2ITUVAE+6r02/aD3/zUvRSBdFOzASaaeNWa18VkUGpveKJ6j4AM8BVfs1RVBIIJ5qCgSbOy2vZxlXgX91Oq+0R1NjkUT4UG78hbuE3oTu0iVd6JsWydb7NAarUdV9kvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1566C32786;
	Tue,  6 Aug 2024 07:07:36 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add ARCH_HAS_SET_MEMORY support
Date: Tue,  6 Aug 2024 15:07:24 +0800
Message-ID: <20240806070724.128023-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add set_memory_ro/rw/x/nx architecture hooks to change the page
attribution.

Use own set_memory.h rather than generic set_memory.h (i.e.
include/asm-generic/set_memory.h), because we want to add other function
prototypes here.

Note: We can only set attributes for KVRANGE/XKVRANGE kernel addresses.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                  |   1 +
 arch/loongarch/include/asm/set_memory.h |  17 +++
 arch/loongarch/mm/Makefile              |   3 +-
 arch/loongarch/mm/pageattr.c            | 159 ++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/set_memory.h
 create mode 100644 arch/loongarch/mm/pageattr.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0e3abf7b0bd3..49efa0470e16 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -25,6 +25,7 @@ config LOONGARCH
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
new file mode 100644
index 000000000000..64c7f942e8ec
--- /dev/null
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_LOONGARCH_SET_MEMORY_H
+#define _ASM_LOONGARCH_SET_MEMORY_H
+
+/*
+ * Functions to change memory attributes.
+ */
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+
+#endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/Makefile b/arch/loongarch/mm/Makefile
index e4d1e581dbae..278be2c8fc36 100644
--- a/arch/loongarch/mm/Makefile
+++ b/arch/loongarch/mm/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-y				+= init.o cache.o tlb.o tlbex.o extable.o \
-				   fault.o ioremap.o maccess.o mmap.o pgtable.o page.o
+				   fault.o ioremap.o maccess.o mmap.o pgtable.o \
+				   page.o pageattr.o
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
new file mode 100644
index 000000000000..d11c8f4b8248
--- /dev/null
+++ b/arch/loongarch/mm/pageattr.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include <linux/pagewalk.h>
+#include <linux/pgtable.h>
+#include <linux/vmalloc.h>
+#include <asm/set_memory.h>
+#include <asm/tlbflush.h>
+
+struct pageattr_masks {
+	pgprot_t set_mask;
+	pgprot_t clear_mask;
+};
+
+static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
+{
+	unsigned long new_val = val;
+	struct pageattr_masks *masks = walk->private;
+
+	new_val &= ~(pgprot_val(masks->clear_mask));
+	new_val |= (pgprot_val(masks->set_mask));
+
+	return new_val;
+}
+
+static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pgd_t val = pgdp_get(pgd);
+
+	if (pgd_leaf(val)) {
+		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
+		set_pgd(pgd, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	p4d_t val = p4dp_get(p4d);
+
+	if (p4d_leaf(val)) {
+		val = __p4d(set_pageattr_masks(p4d_val(val), walk));
+		set_p4d(p4d, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pud_t val = pudp_get(pud);
+
+	if (pud_leaf(val)) {
+		val = __pud(set_pageattr_masks(pud_val(val), walk));
+		set_pud(pud, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t val = pmdp_get(pmd);
+
+	if (pmd_leaf(val)) {
+		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
+		set_pmd(pmd, val);
+	}
+
+	return 0;
+}
+
+static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pte_t val = ptep_get(pte);
+
+	val = __pte(set_pageattr_masks(pte_val(val), walk));
+	set_pte(pte, val);
+
+	return 0;
+}
+
+static int pageattr_pte_hole(unsigned long addr, unsigned long next,
+			     int depth, struct mm_walk *walk)
+{
+	return 0;
+}
+
+static const struct mm_walk_ops pageattr_ops = {
+	.pgd_entry = pageattr_pgd_entry,
+	.p4d_entry = pageattr_p4d_entry,
+	.pud_entry = pageattr_pud_entry,
+	.pmd_entry = pageattr_pmd_entry,
+	.pte_entry = pageattr_pte_entry,
+	.pte_hole = pageattr_pte_hole,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgprot_t clear_mask)
+{
+	int ret;
+	unsigned long start = addr;
+	unsigned long end = start + PAGE_SIZE * numpages;
+	struct pageattr_masks masks = {
+		.set_mask = set_mask,
+		.clear_mask = clear_mask
+	};
+
+	if (!numpages)
+		return 0;
+
+	mmap_write_lock(&init_mm);
+	ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
+	mmap_write_unlock(&init_mm);
+
+	flush_tlb_kernel_range(start, end);
+
+	return ret;
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_NO_EXEC));
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, numpages, __pgprot(_PAGE_NO_EXEC), __pgprot(0));
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_WRITE | _PAGE_DIRTY));
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, numpages, __pgprot(_PAGE_WRITE | _PAGE_DIRTY), __pgprot(0));
+}
-- 
2.43.5


