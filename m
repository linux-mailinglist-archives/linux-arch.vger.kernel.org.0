Return-Path: <linux-arch+bounces-6034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533F9489C6
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA62282A95
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1C165F08;
	Tue,  6 Aug 2024 07:08:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD615FA72;
	Tue,  6 Aug 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928088; cv=none; b=O25SBxDjOlvpcFJlHfhOet540n9/TBqKfdKiTTo8MjSU6UZjrTpaCDbsZcMhRv5HrUNHHAoYT76N2/Q9xZOM4fibYY0VOUB1ChAeuiYWKGAST+jO+wayzMA7BuWLZDYqFPN/8ykb76ZIqPGf3+BE4z+75GOlX4dll78yIJMWoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928088; c=relaxed/simple;
	bh=iEwktt8Rx8h2dYXaJk7IyXpqPBEjz8cLyrQLNmVwRdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ed01Tl2XIgXG2zQB1uYzwdtB7U9Vfq1suSIzDWUONbBRveEStkQeOJ116cDvhqtMGvexSD6WPCvCYOOLtpRw3I5/iepML8OmaP2Ix1Lq4DnXx4P67MtkI26lh0CXvumJ5IWNwKPK3Sr4pT1b6f039/iDVQrXF3gvt0GOLGO3eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F61EC32786;
	Tue,  6 Aug 2024 07:08:05 +0000 (UTC)
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
Subject: [PATCH] LoongArch: Add ARCH_HAS_SET_DIRECT_MAP support
Date: Tue,  6 Aug 2024 15:07:42 +0800
Message-ID: <20240806070742.128064-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add set_direct_map_*() functions for setting the direct map alias for
the page to its default permissions and to an invalid state that cannot
be cached in a TLB. (See d253ca0c3 ("x86/mm/cpa: Add set_direct_map_*()
functions")) Add a similar implementation for LoongArch.

This fixes the KFENCE warnings during hibernation:

 ==================================================================
 BUG: KFENCE: invalid read in swsusp_save+0x368/0x4d8

 Invalid read at 0x00000000f7b89a3c:
  swsusp_save+0x368/0x4d8
  hibernation_snapshot+0x3f0/0x4e0
  hibernate+0x20c/0x440
  state_store+0x128/0x140
  kernfs_fop_write_iter+0x160/0x260
  vfs_write+0x2c0/0x520
  ksys_write+0x74/0x160
  do_syscall+0xb0/0x160

 CPU: 0 UID: 0 PID: 812 Comm: bash Tainted: G    B              6.11.0-rc1+ #1566
 Tainted: [B]=BAD_PAGE
 Hardware name: Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0 10/21/2022
 ==================================================================

Note: We can only set permissions for KVRANGE/XKVRANGE kernel addresses.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                  |  1 +
 arch/loongarch/include/asm/set_memory.h |  4 ++
 arch/loongarch/mm/pageattr.c            | 60 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 49efa0470e16..727dc80d0477 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -26,6 +26,7 @@ config LOONGARCH
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index 64c7f942e8ec..d70505b6676c 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -14,4 +14,8 @@ int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 
+bool kernel_page_present(struct page *page);
+int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page);
+
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index d11c8f4b8248..5ca25481b275 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -157,3 +157,63 @@ int set_memory_rw(unsigned long addr, int numpages)
 
 	return __set_memory(addr, numpages, __pgprot(_PAGE_WRITE | _PAGE_DIRTY), __pgprot(0));
 }
+
+bool kernel_page_present(struct page *page)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (addr < vm_map_base)
+		return true;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(pgdp_get(pgd)))
+		return false;
+	if (pgd_leaf(pgdp_get(pgd)))
+		return true;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(p4dp_get(p4d)))
+		return false;
+	if (p4d_leaf(p4dp_get(p4d)))
+		return true;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(pudp_get(pud)))
+		return false;
+	if (pud_leaf(pudp_get(pud)))
+		return true;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(pmdp_get(pmd)))
+		return false;
+	if (pmd_leaf(pmdp_get(pmd)))
+		return true;
+
+	pte = pte_offset_kernel(pmd, addr);
+	return pte_present(ptep_get(pte));
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, 1, PAGE_KERNEL, __pgprot(0));
+}
+
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (addr < vm_map_base)
+		return 0;
+
+	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
+}
-- 
2.43.5


