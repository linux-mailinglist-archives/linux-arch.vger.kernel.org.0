Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF90417132D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 09:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgB0Itq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 03:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgB0Itq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 03:49:46 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791282468E;
        Thu, 27 Feb 2020 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582793384;
        bh=GA7NOKUteHjazd0omlCrZ7LB67zWZrKKvz+PdqlHU1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dqqxuayacp6kUBvoz6Ep0WwbORX+x52ZATH9VbgId12KNRaV+YCpOWSUJX/p2ye8L
         XgBNf6QAAH1JPV4NZsT2o7+iAe9f+vpuLHkuXWnuAcXicPWeqdHJrc39pBQX2CLodv
         XIt+PNhD1CezRM6zy/o5J3hHby0EBCFMyoIokpFQ=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 09/14] sh: fault: Modernize printing of kernel messages
Date:   Thu, 27 Feb 2020 10:46:03 +0200
Message-Id: <20200227084608.18223-10-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227084608.18223-1-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

  - Convert from printk() to pr_*(),
  - Add missing continuations,
  - Use "%llx" to format u64,
  - Join multiple prints in show_fault_oops() into a single print.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sh/mm/fault.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f51456f4fc7..a2b0275413e8 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -47,10 +47,10 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
 			pgd = swapper_pg_dir;
 	}
 
-	printk(KERN_ALERT "pgd = %p\n", pgd);
+	pr_alert("pgd = %p\n", pgd);
 	pgd += pgd_index(addr);
-	printk(KERN_ALERT "[%08lx] *pgd=%0*Lx", addr,
-	       (u32)(sizeof(*pgd) * 2), (u64)pgd_val(*pgd));
+	pr_alert("[%08lx] *pgd=%0*llx", addr, (u32)(sizeof(*pgd) * 2),
+		 (u64)pgd_val(*pgd));
 
 	do {
 		pud_t *pud;
@@ -61,33 +61,33 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		if (pgd_bad(*pgd)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
 		pud = pud_offset(pgd, addr);
 		if (PTRS_PER_PUD != 1)
-			printk(", *pud=%0*Lx", (u32)(sizeof(*pud) * 2),
-			       (u64)pud_val(*pud));
+			pr_cont(", *pud=%0*llx", (u32)(sizeof(*pud) * 2),
+				(u64)pud_val(*pud));
 
 		if (pud_none(*pud))
 			break;
 
 		if (pud_bad(*pud)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (PTRS_PER_PMD != 1)
-			printk(", *pmd=%0*Lx", (u32)(sizeof(*pmd) * 2),
-			       (u64)pmd_val(*pmd));
+			pr_cont(", *pmd=%0*llx", (u32)(sizeof(*pmd) * 2),
+				(u64)pmd_val(*pmd));
 
 		if (pmd_none(*pmd))
 			break;
 
 		if (pmd_bad(*pmd)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
@@ -96,11 +96,11 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pte = pte_offset_kernel(pmd, addr);
-		printk(", *pte=%0*Lx", (u32)(sizeof(*pte) * 2),
-		       (u64)pte_val(*pte));
+		pr_cont(", *pte=%0*llx", (u32)(sizeof(*pte) * 2),
+			(u64)pte_val(*pte));
 	} while (0);
 
-	printk("\n");
+	pr_cont("\n");
 }
 
 static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
@@ -188,14 +188,11 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 	if (!oops_may_print())
 		return;
 
-	printk(KERN_ALERT "BUG: unable to handle kernel ");
-	if (address < PAGE_SIZE)
-		printk(KERN_CONT "NULL pointer dereference");
-	else
-		printk(KERN_CONT "paging request");
-
-	printk(KERN_CONT " at %08lx\n", address);
-	printk(KERN_ALERT "PC:");
+	pr_alert("BUG: unable to handle kernel %s at %08lx\n",
+		 address < PAGE_SIZE ? "NULL pointer dereference"
+				     : "paging request",
+		 address);
+	pr_alert("PC:");
 	printk_address(regs->pc, 1);
 
 	show_pte(NULL, address);
-- 
2.24.0

