Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07F38865E
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 07:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhESFGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 01:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244225AbhESFGq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:06:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4401E61364;
        Wed, 19 May 2021 05:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621400727;
        bh=Mc4hZG1Zr7Tnoyw/Uvexi2F7Qpbq/iGh58EZtVvBeAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4jJGnA5e17WivC5h1/FZT2i6/Or1dFr3+vaoIvac6qtpJQT36d+n/Pn5b0ez3kos
         9gg1htVsfY+qbUxZD9z75CfsUdfK1zzz+PSU1IpXxHsFlRQO5ITwpdEAcI4lBEHten
         XuAFJXgDK/eUPKZXYPQbrHsaS3mS349sOheRzMDObKnwyIO4ZtFba96Rd6Vad01lx2
         hKzvhmTCaQhq8iQuwpgimSRWMRYFGXKla9gJ+d6JtOahOEB7y9eNCk9UtyzFM+F+Zm
         AYoeLfBEz+Lgz2mgpGCNhpUNwAE+lUJwFWHbKlloQVNi+vId5mK4+JsFZy1bH0Enil
         0SINvKMDVdhEg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        drew@beagleboard.org, hch@lst.de, wefu@redhat.com,
        lazyparser@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 1/3] riscv: pgtable.h: Fixup _PAGE_CHG_MASK usage
Date:   Wed, 19 May 2021 05:04:14 +0000
Message-Id: <1621400656-25678-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621400656-25678-1-git-send-email-guoren@kernel.org>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

'& _PAGE_CHG_MASK' should masks all attributes BITS then
'>> _PAGE_PFN_SHIFT' get the final correct PFN value.

'& _PAGE_CHG_MASK' makes the code semantics more accurate.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Drew Fustini <drew@beagleboard.org>
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
index 9469f46..869d6bf 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -216,12 +216,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
 
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
@@ -232,7 +232,7 @@ static inline pte_t pmd_pte(pmd_t pmd)
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
+	return ((pte_val(pte) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
-- 
2.7.4

