Return-Path: <linux-arch+bounces-5701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702F940899
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E5B2404D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A018F2E5;
	Tue, 30 Jul 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXb4byD4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42022563;
	Tue, 30 Jul 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321794; cv=none; b=niOhqBaFvq0kIcQoCMH61TdBVvAofdeX8zZFFuYbIJx4zwaDrY9MDkUf8FNliG0V7HtpyrrHhb6Sq7GJhpZ7/12imhK88nbAIuf32H+TiHgBrjl8cVTEQcDQiHuR5X3CWovdGKDk3usBqBxr2DOILp0iuDjG7lo5Ye2ifv6h3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321794; c=relaxed/simple;
	bh=9NZb0rrKQqKYXT4j44hct+A4v/K9XblH1QcI1NJ86wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI4E/ejlpGi+tb2Lu4lXHcXCjowazjh37bFkPlIojh1kbrsKbMO4ropTLsiUASbCN47dmDWsV2rWF0q+/xHQpe9RIhjaiteq9SRMJA5bR/bb9g0bP2myOoTTD6rZqanOTi7LVlSGYoMdQLRhSipAHhPX9XBA7Og06jS6rl0pn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXb4byD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469FBC32782;
	Tue, 30 Jul 2024 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321793;
	bh=9NZb0rrKQqKYXT4j44hct+A4v/K9XblH1QcI1NJ86wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXb4byD4QEB/pykGQSUxfRgInQG2nhMHKXm5xZNegBtn3rrGWMaLewVYiqUNRYDtJ
	 aQ+opzP1rC4aJUxCXkL2wAnqAIW3nIQYdRxHYnksJ0PJsaNlzE/MV3jYxsY7CWC6i6
	 A55O5dfE29WFwTXyQHh6asj1EX4qez2hBgWChYq1nW9wZhzPJt7adzM3dujj4fTqjW
	 GPMlZQsWyciJ/EykTgqqAmIjcZelbGlK8I8ok7QSAhrcTaitTlPHXoD4wXFz71j46R
	 BpZv8MZ6nqA/BUfQ66+uiCN6lG0xAGpqKsFp7FzaM7qSm50/Hdt7uFpAhZjkPrnNQ4
	 JZOzjdQ+jlf0A==
From: alexs@kernel.org
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	sparclinux@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 02/18] mm/pgtable: convert ptdesc.pmd_huge_pte to ptdesc pointer
Date: Tue, 30 Jul 2024 14:46:56 +0800
Message-ID: <20240730064712.3714387-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

folio/page.pmd_huge_pte is a pointer to pagetable descriptor: pgtable_t.
In most arch, it is a typedef of 'struct page *'. But we have ptdesc now,
tt's better to convert it to right one: struct ptdesc pointer.

Different from others, s390/sparc use typedef 'pte_t *' as pgtable_t, so
they need different cost in their arch.

Thanks for lkp found the build issue for s390/sparc, it fixed now.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox  <willy@infradead.org>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/pgtable.c   |  6 +++---
 arch/sparc/mm/tlb.c      |  6 +++---
 include/linux/mm_types.h |  4 ++--
 mm/pgtable-generic.c     | 16 ++++++++--------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2c944bafb030..201d350abd1e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -574,7 +574,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		INIT_LIST_HEAD(lh);
 	else
 		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = pgtable;
+	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
 }
 
 pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
@@ -586,12 +586,12 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
 	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
+	pgtable = (pte_t *)pmd_huge_pte(mm, pmdp);
 	lh = (struct list_head *) pgtable;
 	if (list_empty(lh))
 		pmd_huge_pte(mm, pmdp) = NULL;
 	else {
-		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
+		pmd_huge_pte(mm, pmdp) = (struct ptdesc *) lh->next;
 		list_del(lh);
 	}
 	ptep = (pte_t *) pgtable;
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 8648a50afe88..903825b4c997 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -278,7 +278,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		INIT_LIST_HEAD(lh);
 	else
 		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = pgtable;
+	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
 }
 
 pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
@@ -289,12 +289,12 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	assert_spin_locked(&mm->page_table_lock);
 
 	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
+	pgtable = (pte_t *)pmd_huge_pte(mm, pmdp);
 	lh = (struct list_head *) pgtable;
 	if (list_empty(lh))
 		pmd_huge_pte(mm, pmdp) = NULL;
 	else {
-		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
+		pmd_huge_pte(mm, pmdp) = (struct ptdesc *) lh->next;
 		list_del(lh);
 	}
 	pte_val(pgtable[0]) = 0;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..2e3eddf6edc9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -462,7 +462,7 @@ struct ptdesc {
 		struct list_head pt_list;
 		struct {
 			unsigned long _pt_pad_1;
-			pgtable_t pmd_huge_pte;
+			struct ptdesc *pmd_huge_pte;
 		};
 	};
 	unsigned long __page_mapping;
@@ -948,7 +948,7 @@ struct mm_struct {
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
+		struct ptdesc *pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 		/*
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 2ce714f1dd15..f34a8d115f5b 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -171,8 +171,8 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	if (!pmd_huge_pte(mm, pmdp))
 		INIT_LIST_HEAD(&pgtable->lru);
 	else
-		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->lru);
-	pmd_huge_pte(mm, pmdp) = pgtable;
+		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->pt_list);
+	pmd_huge_pte(mm, pmdp) = page_ptdesc(pgtable);
 }
 #endif
 
@@ -180,17 +180,17 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 /* no "address" argument so destroys page coloring of some arch */
 pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
-	pgtable_t pgtable;
+	struct ptdesc *ptdesc;
 
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
 	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
-	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&pgtable->lru,
-							  struct page, lru);
+	ptdesc = pmd_huge_pte(mm, pmdp);
+	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&ptdesc->pt_list,
+							  struct ptdesc, pt_list);
 	if (pmd_huge_pte(mm, pmdp))
-		list_del(&pgtable->lru);
-	return pgtable;
+		list_del(&ptdesc->pt_list);
+	return ptdesc_page(ptdesc);
 }
 #endif
 
-- 
2.43.0


