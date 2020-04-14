Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6701A835A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440594AbgDNPjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 11:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440444AbgDNPgr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 11:36:47 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6B42076D;
        Tue, 14 Apr 2020 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878606;
        bh=fvLukdwkQTHO+51q3DGLoikuRIRMlioJ2DyvNE+LsyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsjR1/Yifkflit9+eKwFZLCCJFB8DergOAGiV4wfeGmM/V7L4EnrXxVxok0npwk6h
         WiBKvp5y1ti7RWPhFlbhCg0/KvxW5loI8ag/8FCL6WW1nK8DMZtzMhuoVRHVMUmF6W
         Av3cMdSJVEJr8PZ+JmDhYERiuyxHsfJxjLsfIVRk=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 10/14] sh: drop __pXd_offset() macros that duplicate pXd_index() ones
Date:   Tue, 14 Apr 2020 18:34:51 +0300
Message-Id: <20200414153455.21744-11-rppt@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414153455.21744-1-rppt@kernel.org>
References: <20200414153455.21744-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The __pXd_offset() macros are identical to the pXd_index() macros and there
is no point to keep both of them. All architectures define and use
pXd_index() so let's keep only those to make mips consistent with the rest
of the kernel.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sh/include/asm/pgtable_32.h | 5 ++---
 arch/sh/include/asm/pgtable_64.h | 5 ++---
 arch/sh/mm/init.c                | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 29274f0e428e..4acce5f2cbf9 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -407,13 +407,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
-#define __pgd_offset(address)	pgd_index(address)
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address)	pgd_offset(&init_mm, address)
 
-#define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /* Find an entry in the third-level page table.. */
 #define pte_index(address)	((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 1778bc5971e7..27cc282ec6c0 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -46,14 +46,13 @@ static __inline__ void set_pte(pte_t *pteptr, pte_t pteval)
 
 /* To find an entry in a generic PGD. */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-#define __pgd_offset(address) pgd_index(address)
 #define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
 
 /* To find an entry in a kernel PGD. */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
-#define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+/* #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1)) */
 
 /*
  * PMD level access routines. Same notes as above.
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b9de2d4fa57e..f445ba630790 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -172,9 +172,9 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 	unsigned long vaddr;
 
 	vaddr = start;
-	i = __pgd_offset(vaddr);
-	j = __pud_offset(vaddr);
-	k = __pmd_offset(vaddr);
+	i = pgd_index(vaddr);
+	j = pud_index(vaddr);
+	k = pmd_index(vaddr);
 	pgd = pgd_base + i;
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
-- 
2.25.1

