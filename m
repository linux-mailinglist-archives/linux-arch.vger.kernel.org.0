Return-Path: <linux-arch+bounces-1134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C6818F29
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F11F2AF87
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E938F80;
	Tue, 19 Dec 2023 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZeIMWFF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90438FB3;
	Tue, 19 Dec 2023 18:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F40EC433CB;
	Tue, 19 Dec 2023 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009007;
	bh=DsAEkljb9nELe7pOkNsFuedvY7TlIkqM0TVa9ONTLHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZeIMWFFttxnxsz70F8UouiwH0y4TqZqUR0au/SLYyPTk1mvMoENsBc4ab890iYVP
	 BLByYZiQvFaJaD70giLF0L/HZSuSnQoA27jZ9O0sTHDMS+CV7k5vLv971aK+ISHT0h
	 Q723BOdVl4693wzHnanJbWjMnp8eMfvvBuZL+MqIdTyv4cvHil7xR5nCM9zK5aZIBl
	 duobbluzAihDUQKnsNK7gbSfhRYl4rIktzJyXgaa/afOM+eBTBTEvSSO+NmqV+Zt0X
	 kyvovCVxXTiaOcuXTRROcZOvZHg5P/fqLv8479zyhTaEDOiXIlorhkYKPkcN5VeNZg
	 uIXfSnq44E5/Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] riscv: tlb: convert __p*d_free_tlb() to inline functions
Date: Wed, 20 Dec 2023 01:50:44 +0800
Message-Id: <20231219175046.2496-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231219175046.2496-1-jszhang@kernel.org>
References: <20231219175046.2496-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for enabling MMU_GATHER_RCU_TABLE_FREE.
No functionality changes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/pgalloc.h | 54 +++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index a12fb83fa1f5..3c5e3bd15f46 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -95,13 +95,16 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 		__pud_free(mm, pud);
 }
 
-#define __pud_free_tlb(tlb, pud, addr)					\
-do {									\
-	if (pgtable_l4_enabled) {					\
-		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
-		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
-	}								\
-} while (0)
+static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
+				  unsigned long addr)
+{
+	if (pgtable_l4_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
+
+		pagetable_pud_dtor(ptdesc);
+		tlb_remove_page_ptdesc(tlb, ptdesc);
+	}
+}
 
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -130,11 +133,12 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 		__p4d_free(mm, p4d);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)					\
-do {									\
-	if (pgtable_l5_enabled)						\
-		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
-} while (0)
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
+				  unsigned long addr)
+{
+	if (pgtable_l5_enabled)
+		tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
+}
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 static inline void sync_kernel_mappings(pgd_t *pgd)
@@ -159,19 +163,25 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-#define __pmd_free_tlb(tlb, pmd, addr)				\
-do {								\
-	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
-} while (0)
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
+	pagetable_pmd_dtor(ptdesc);
+	tlb_remove_page_ptdesc(tlb, ptdesc);
+}
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)			\
-do {							\
-	pagetable_pte_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
-} while (0)
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	pagetable_pte_dtor(ptdesc);
+	tlb_remove_page_ptdesc(tlb, ptdesc);
+}
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_PGALLOC_H */
-- 
2.40.0


