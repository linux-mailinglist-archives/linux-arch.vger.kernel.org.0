Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72A739CE47
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFFJHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFFJHQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B31861420;
        Sun,  6 Jun 2021 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970327;
        bh=pFy+y/+bXIJMqxs4sackrvYzWSva1Mz5n5hReLvzQ2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtpbA8AlU0ccA8OkNJspvbTidxcmnnf0kYjcDgXOvagHKFb/iQIxywysgS3xqUmhx
         86++Ucgwzia8ZkT76nZj29/6Fh1oavydoS+ucW2ISCHEMkbWSdT96dcNeLtRaJmguK
         mssRzhBlZnzLymiM/3WU2d3cxDd/8r01mDDC9jEE47oK/V7HnoKsiuUC+IjCtxXGtw
         6LQqElbeGh/0eAyX8bRrQDzm6XY+qN6/CWT+sCyTkEgcAdczotesXDtBy+3ZyCu7dq
         DRatX9jNRlY7hK5dYIFOo6/WgUxEyhNpW1htURh6JP5wuEXHiXm0gP8r6pr3PK+4w1
         5lEPEXb+DAX5g==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [RFC PATCH v2 05/11] riscv: pgtable: Add custom protection_map init
Date:   Sun,  6 Jun 2021 09:04:03 +0000
Message-Id: <1622970249-50770-9-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Some RISC-V CPU vendors have defined their own PTE attributes to
solve non-coherent DMA bus problems. That makes _P/SXXX definitions
contain global variables which could be initialized at the early
boot stage before setup_vm.

This patch is similar to 316d097c4cd4  (x86/pti: Filter at
vma->vm_page_prot population) which give a choice for arch custom
implementation.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/Kconfig   |  4 ++++
 arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
 mm/mmap.c            |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5914e7..05c4976 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_PROTECTION_MAP_INIT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
@@ -198,6 +199,9 @@ config GENERIC_HWEIGHT
 config FIX_EARLYCON_MEM
 	def_bool MMU
 
+config ARCH_HAS_PROTECTION_MAP_INIT
+	def_bool y
+
 config PGTABLE_LEVELS
 	int
 	default 3 if 64BIT
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4faf8bd..4b398c6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -496,6 +496,26 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
 }
 #endif
 
+static void __init setup_protection_map(void)
+{
+	protection_map[0]  = __P000;
+	protection_map[1]  = __P001;
+	protection_map[2]  = __P010;
+	protection_map[3]  = __P011;
+	protection_map[4]  = __P100;
+	protection_map[5]  = __P101;
+	protection_map[6]  = __P110;
+	protection_map[7]  = __P111;
+	protection_map[8]  = __S000;
+	protection_map[9]  = __S001;
+	protection_map[10] = __S010;
+	protection_map[11] = __S011;
+	protection_map[12] = __S100;
+	protection_map[13] = __S101;
+	protection_map[14] = __S110;
+	protection_map[15] = __S111;
+}
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	uintptr_t __maybe_unused pa;
@@ -504,6 +524,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pmd_t fix_bmap_spmd, fix_bmap_epmd;
 #endif
 
+	setup_protection_map();
+
 #ifdef CONFIG_XIP_KERNEL
 	xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
diff --git a/mm/mmap.c b/mm/mmap.c
index 0584e54..0a86059 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -100,10 +100,14 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
+#ifdef CONFIG_ARCH_HAS_PROTECTION_MAP_INIT
+pgprot_t protection_map[16] __ro_after_init;
+#else
 pgprot_t protection_map[16] __ro_after_init = {
 	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
+#endif
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-- 
2.7.4

