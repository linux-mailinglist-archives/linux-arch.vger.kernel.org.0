Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1D3610E3
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhDORSk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 13:18:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40908 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233407AbhDORSk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 13:18:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FLmJR3NnVz9vBLn;
        Thu, 15 Apr 2021 19:18:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C9R3Cqc6HllM; Thu, 15 Apr 2021 19:18:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FLmJR2HvLz9tyvC;
        Thu, 15 Apr 2021 19:18:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2924B8B804;
        Thu, 15 Apr 2021 19:18:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G8IFx-cy7Cpg; Thu, 15 Apr 2021 19:18:15 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F20A8B7F6;
        Thu, 15 Apr 2021 19:18:14 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7E3BA679F6; Thu, 15 Apr 2021 17:18:14 +0000 (UTC)
Message-Id: <733408f48b1ed191f53518123ee6fc6d42287cc6.1618506910.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/5] mm: pagewalk: Fix walk for hugepage tables
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Date:   Thu, 15 Apr 2021 17:18:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pagewalk ignores hugepd entries and walk down the tables
as if it was traditionnal entries, leading to crazy result.

Add walk_hugepd_range() and use it to walk hugepage tables.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/pagewalk.c | 54 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d9f177..410a9d8f7572 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,6 +58,32 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return err;
 }
 
+static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
+			     unsigned long end, struct mm_walk *walk, int pdshift)
+{
+	int err = 0;
+#ifdef CONFIG_ARCH_HAS_HUGEPD
+	const struct mm_walk_ops *ops = walk->ops;
+	int shift = hugepd_shift(*phpd);
+	int page_size = 1 << shift;
+
+	if (addr & (page_size - 1))
+		return 0;
+
+	for (;;) {
+		pte_t *pte = hugepte_offset(*phpd, addr, pdshift);
+
+		err = ops->pte_entry(pte, addr, addr + page_size, walk);
+		if (err)
+			break;
+		if (addr >= end - page_size)
+			break;
+		addr += page_size;
+	}
+#endif
+	return err;
+}
+
 static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
@@ -108,7 +134,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 				goto again;
 		}
 
-		err = walk_pte_range(pmd, addr, next, walk);
+		if (is_hugepd(__hugepd(pmd_val(*pmd))))
+			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
+		else
+			err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
 			break;
 	} while (pmd++, addr = next, addr != end);
@@ -157,7 +186,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (pud_none(*pud))
 			goto again;
 
-		err = walk_pmd_range(pud, addr, next, walk);
+		if (is_hugepd(__hugepd(pud_val(*pud))))
+			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
+		else
+			err = walk_pmd_range(pud, addr, next, walk);
 		if (err)
 			break;
 	} while (pud++, addr = next, addr != end);
@@ -189,8 +221,13 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 			if (err)
 				break;
 		}
-		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
-			err = walk_pud_range(p4d, addr, next, walk);
+		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry) {
+			if (is_hugepd(__hugepd(p4d_val(*p4d))))
+				err = walk_hugepd_range((hugepd_t *)p4d, addr, next, walk,
+							P4D_SHIFT);
+			else
+				err = walk_pud_range(p4d, addr, next, walk);
+		}
 		if (err)
 			break;
 	} while (p4d++, addr = next, addr != end);
@@ -225,8 +262,13 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 				break;
 		}
 		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
-		    ops->pte_entry)
-			err = walk_p4d_range(pgd, addr, next, walk);
+		    ops->pte_entry) {
+			if (is_hugepd(__hugepd(pgd_val(*pgd))))
+				err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk,
+							PGDIR_SHIFT);
+			else
+				err = walk_p4d_range(pgd, addr, next, walk);
+		}
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-- 
2.25.0

