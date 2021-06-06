Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CEE39CE45
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFFJHN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFFJHN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDA4061422;
        Sun,  6 Jun 2021 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970323;
        bh=L8xajDumKH1Cg7eZ91SM48KqOMpWXfNl+mHnoCZQBpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEmXI3b7k0JcId3xCv4dEM2lO6p0ojmwnUagRx4hHFRbltGKWrXdKaUFGk6UUXmxD
         S4NRtKgdwy7NSX0ztjbCdWBpn7Be6Pp9y3lw8F0pvTkVBooLvaE4v2cLjEVweyDd5D
         YUellDH7CiZ6JxajGwYIdcTFqqEfYU3h/K3YOA1WVdlubGrb1n4uBs6lFaEQx23Y2J
         NMBRJoeEpjRtduGzFkbgbWeQTkaCrtCbrQdZ8zy8NkJP1e66SeOBto5yK2EQFFy/b/
         5NYfMeVWRalVgxRf8Nv7qdKn6e2j5OWdlzqtxNqRATxVbtptUsFQMO4tmHbstOpaKF
         9Y3slo/pyf/xg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 04/11] riscv: pgtable: Fixup _PAGE_CHG_MASK usage
Date:   Sun,  6 Jun 2021 09:04:02 +0000
Message-Id: <1622970249-50770-8-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We should masks all attributes BITS first, and then
using '>> _PAGE_PFN_SHIFT' to get the final PFN value.

Adding '& _PAGE_CHG_MASK' makes the code semantics more accurate.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/include/asm/pgtable-64.h | 8 +++++---
 arch/riscv/include/asm/pgtable.h    | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da6..cbf9acf 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -62,12 +62,14 @@ static inline void pud_clear(pud_t *pudp)
 
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
-	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (unsigned long)pfn_to_virt(
+		(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
 {
-	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page(
+		(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
@@ -77,7 +79,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 
 static inline unsigned long _pmd_pfn(pmd_t pmd)
 {
-	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
+	return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
 }
 
 #define pmd_ERROR(e) \
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 346a3c6..13a79643 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -217,12 +217,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
 
 static inline struct page *pmd_page(pmd_t pmd)
 {
-	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+	return pfn_to_page((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
-	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+	return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 static inline pte_t pmd_pte(pmd_t pmd)
@@ -233,7 +233,7 @@ static inline pte_t pmd_pte(pmd_t pmd)
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
+	return ((pte_val(pte) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
-- 
2.7.4

