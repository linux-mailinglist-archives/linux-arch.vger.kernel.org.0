Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AF36DD5F
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhD1QrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 12:47:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38738 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241222AbhD1QrB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 12:47:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FVkzV4qlxz9tcX;
        Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rGxpY2iI8zAH; Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FVkzV3vmDz9tcV;
        Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F0128B837;
        Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4PWl6TcHRv8j; Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 083158B831;
        Wed, 28 Apr 2021 18:46:14 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D8D336428C; Wed, 28 Apr 2021 16:46:13 +0000 (UTC)
Message-Id: <6f482b6722f7a891ce335db7e02ecbdb42574e8b.1619628001.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1619628001.git.christophe.leroy@csgroup.eu>
References: <cover.1619628001.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 3/4] mm/pgtable: Add stubs for
 {pmd/pub}_{set/clear}_huge
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 28 Apr 2021 16:46:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For architectures with no PMD and/or no PUD, add stubs
similar to what we have for architectures without P4D.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/pgtable.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 46b13780c2c8..d41474a2d255 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1371,10 +1371,34 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 }
 #endif /* !__PAGETABLE_P4D_FOLDED */
 
+#ifndef __PAGETABLE_PUD_FOLDED
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
-int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
+#else
+static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
+{
+	return 0;
+}
+static inline int pud_clear_huge(pud_t *pud)
+{
+	return 0;
+}
+#endif /* !__PAGETABLE_PUD_FOLDED */
+
+#ifndef __PAGETABLE_PMD_FOLDED
+int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pmd_clear_huge(pmd_t *pmd);
+#else
+static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
+{
+	return 0;
+}
+static inline int pmd_clear_huge(pmd_t *pmd)
+{
+	return 0;
+}
+#endif /* !__PAGETABLE_PMD_FOLDED */
+
 int p4d_free_pud_page(p4d_t *p4d, unsigned long addr);
 int pud_free_pmd_page(pud_t *pud, unsigned long addr);
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
-- 
2.25.0

