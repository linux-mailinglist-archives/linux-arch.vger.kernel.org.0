Return-Path: <linux-arch+bounces-1133-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7205B818F27
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F53D287CD6
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F0381B1;
	Tue, 19 Dec 2023 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ+HplTE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B56381A5;
	Tue, 19 Dec 2023 18:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62CDC433C9;
	Tue, 19 Dec 2023 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703009005;
	bh=39JAuH598M6uo4CmVtLFeafqNHIttPmqjwfQDvfhOjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZ+HplTEbztnxahsANz3uYQlJxV91QZtNCH9i3pK9wbRFkjwTt4VzJXgiEfG1XQyS
	 BXqJkmD+ZuHI3pJbq7hpWh4FazAdi4Y3yKeIPf67IpkIahu9t2PTGodx/3z22CFrV7
	 m+cNydw6UBPt2db6BACnS7usZ86CqOzEjfRnK1vUXTwLBuz8h9WArwgkfMCsadNvpZ
	 ADKvoV3VZLzOxA8w0qKo27CtkfmEvEQi0IGRe7dYSov3cTESJzZ5pYlOHNLP8W51Mp
	 QrorLyrRGypL6qE5j1GbuY+013Qauw6noSlblzldFoZ80Yl2nqBBjJIFW2VycqEPjS
	 p8/QIHPpMR03g==
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
Subject: [PATCH 1/4] riscv: tlb: fix __p*d_free_tlb()
Date: Wed, 20 Dec 2023 01:50:43 +0800
Message-Id: <20231219175046.2496-2-jszhang@kernel.org>
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

If non-leaf PTEs I.E pmd, pud or p4d is modified, a sfence.vma is
a must for safe, imagine if an implementation caches the non-leaf
translation in TLB, although I didn't meet this HW so far, but it's
possible in theory.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/pgalloc.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index d169a4f41a2e..a12fb83fa1f5 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -95,7 +95,13 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 		__pud_free(mm, pud);
 }
 
-#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
+#define __pud_free_tlb(tlb, pud, addr)					\
+do {									\
+	if (pgtable_l4_enabled) {					\
+		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
+		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+	}								\
+} while (0)
 
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -124,7 +130,11 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 		__p4d_free(mm, p4d);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
+#define __p4d_free_tlb(tlb, p4d, addr)					\
+do {									\
+	if (pgtable_l5_enabled)						\
+		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
+} while (0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 static inline void sync_kernel_mappings(pgd_t *pgd)
@@ -149,7 +159,11 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, addr)				\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-- 
2.40.0


