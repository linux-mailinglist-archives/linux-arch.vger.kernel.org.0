Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA8D9732
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406185AbfJPQYH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 12:24:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58502 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbfJPQYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:07 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F0BB6C2FFF;
        Wed, 16 Oct 2019 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571243046; bh=UXULR1r/3kxBPP9KtRfgHaDn7Fn06VTK/VtH3ylzUjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIT3ymoMWVR4KhvFSgq+nGmBvxD2ZVa2NLkvX3cF/zkj+e9kji/YD3WEZLawNuKyY
         0VmsXCG4BfAjRESSunMDPOwxo2t2Y/5nejkmcptlQzmgx3AotkTgl7NlMCS5MrSMVe
         Lz9RhZ4D0Tk89HaED4R8wQ5TEtf+SJ161Jk9ySs91GP+yqCBj1ftQK+QBJ913fXX/k
         zwLLYAAnG7jH+Nen1GiTr8MX86UP94A7WDh6rULvwmNe+Ah/0g8L+SFdDk6+TQIg9P
         Cfmz7DxKvuneDblV9O7JpIoE6guZ9xHv3Dljf4gND94gTm75AvN9UDC6g7nF/ERGKi
         0ILTv79lp6D5A==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5CDF9A0078;
        Wed, 16 Oct 2019 16:24:04 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-mm@kvack.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Date:   Wed, 16 Oct 2019 09:23:56 -0700
Message-Id: <20191016162400.14796-2-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016162400.14796-1-vgupta@synopsys.com>
References: <20191016162400.14796-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With paging code made 5-level compliant, this is no longer needed.
ARC has software page walker with 2 lookup levels (pgd -> pte)

This was expected to be non functional change but ended with slight
code bloat due to needless inclusions of p*d_free_tlb() macros which
will be addressed in further patches.

| bloat-o-meter2 vmlinux-[AB]*
| add/remove: 0/0 grow/shrink: 2/0 up/down: 128/0 (128)
| function                                     old     new   delta
| free_pgd_range                               546     656    +110
| p4d_clear_bad                                  2      20     +18
| Total: Before=4137148, After=4137276, chg 0.000000%

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/pgtable.h |  1 -
 arch/arc/mm/fault.c            | 10 ++++++++--
 arch/arc/mm/highmem.c          |  4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 7addd0301c51..b917b596f7fb 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -33,7 +33,6 @@
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
 #include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..fb86bc3e9b35 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -30,6 +30,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	 * with the 'reference' page table.
 	 */
 	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
@@ -39,8 +40,13 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
-	pud = pud_offset(pgd, address);
-	pud_k = pud_offset(pgd_k, address);
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d_k))
+		goto bad_area;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index a4856bfaedf3..fc8849e4f72e 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -111,12 +111,14 @@ EXPORT_SYMBOL(__kunmap_atomic);
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
 	pgd_t *pgd_k;
+	p4d_t *p4d_k;
 	pud_t *pud_k;
 	pmd_t *pmd_k;
 	pte_t *pte_k;
 
 	pgd_k = pgd_offset_k(kvaddr);
-	pud_k = pud_offset(pgd_k, kvaddr);
+	p4d_k = p4d_offset(pgd_k, kvaddr);
+	pud_k = pud_offset(p4d_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
 	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-- 
2.20.1

