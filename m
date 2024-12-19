Return-Path: <linux-arch+bounces-9436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C889F8059
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494F4188FAE3
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9519E83C;
	Thu, 19 Dec 2024 16:46:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AC219C56D;
	Thu, 19 Dec 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626785; cv=none; b=upZB1H5z80RvJrpaEmnzMkvwjVAnRlpCjIxDGqgGznHMV9s746iZht7i3UpH93qHTzOQbk+LOImoBsrMkULcOBCIIXSug4P0sbaF1IBRr/+JfkIcXZlMOdF3bMpZnzp1NcqKo0LTDqgB++u3h1Rm2+R2xD8d6Cp3EtxBOrbkV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626785; c=relaxed/simple;
	bh=S8MwfFJEn/DsgnM28z6RAQleE27mFfBYXi2rjSFpd90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjl8ehSs/iafE3XwGhvN6DlVQEWCePbsQ7YmLHTJrv7jiNdvnG1d17gJwMFpYeOO8qKQXsOAbscrGzG+pfC6UOknTKri7H/8U+owAzTeSvx7ZrM00C/WeUWFAyRMk04DtJ1uQkwDYK0kgu/uPIpsSnj5mw5lj2TVWU3q4Wz6iDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB531480;
	Thu, 19 Dec 2024 08:46:51 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C069C3F58B;
	Thu, 19 Dec 2024 08:46:19 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 03/10] m68k: mm: Add calls to pagetable_pmd_[cd]tor
Date: Thu, 19 Dec 2024 16:44:18 +0000
Message-ID: <20241219164425.2277022-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219164425.2277022-1-kevin.brodsky@arm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_pointer_table() and free_pointer_table() already special-case
TABLE_PTE to call pagetable_pte_[cd]tor. Let's do the same at PMD
level to improve accounting further. TABLE_PGD and TABLE_PMD are
currently defined to the same value, so we first need to separate
them. That also implies separating ptable_list for PMD/PGD levels.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/motorola_pgalloc.h |  6 +++---
 arch/m68k/mm/motorola.c                  | 25 +++++++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index 74a817d9387f..5abe7da8ac5a 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -9,9 +9,9 @@ extern void mmu_page_ctor(void *page);
 extern void mmu_page_dtor(void *page);
 
 enum m68k_table_types {
-	TABLE_PGD = 0,
-	TABLE_PMD = 0, /* same size as PGD */
-	TABLE_PTE = 1,
+	TABLE_PGD,
+	TABLE_PMD,
+	TABLE_PTE,
 };
 
 extern void init_pointer_table(void *table, int type);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index c1761d309fc6..37010ee15928 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -97,17 +97,19 @@ void mmu_page_dtor(void *page)
 
 typedef struct list_head ptable_desc;
 
-static struct list_head ptable_list[2] = {
+static struct list_head ptable_list[3] = {
 	LIST_HEAD_INIT(ptable_list[0]),
 	LIST_HEAD_INIT(ptable_list[1]),
+	LIST_HEAD_INIT(ptable_list[2]),
 };
 
 #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page((void *)(page))->lru))
 #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
 #define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
 
-static const int ptable_shift[2] = {
-	7+2, /* PGD, PMD */
+static const int ptable_shift[3] = {
+	7+2, /* PGD */
+	7+2, /* PMD */
 	6+2, /* PTE */
 };
 
@@ -156,12 +158,17 @@ void *get_pointer_table(int type)
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
-		if (type == TABLE_PTE) {
+		switch (type) {
+		case TABLE_PTE:
 			/*
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
 			 * SMP.
 			 */
 			pagetable_pte_ctor(virt_to_ptdesc(page));
+			break;
+		case TABLE_PMD:
+			pagetable_pmd_ctor(virt_to_ptdesc(page));
+			break;
 		}
 
 		mmu_page_ctor(page);
@@ -200,8 +207,16 @@ int free_pointer_table(void *table, int type)
 		/* all tables in page are free, free page */
 		list_del(dp);
 		mmu_page_dtor((void *)page);
-		if (type == TABLE_PTE)
+
+		switch (type) {
+		case TABLE_PTE:
 			pagetable_pte_dtor(virt_to_ptdesc((void *)page));
+			break;
+		case TABLE_PMD:
+			pagetable_pmd_dtor(virt_to_ptdesc((void *)page));
+			break;
+		}
+
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
-- 
2.47.0


