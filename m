Return-Path: <linux-arch+bounces-9443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DD9F809A
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE81916D917
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000C1A9B3D;
	Thu, 19 Dec 2024 16:46:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBC1A9B29;
	Thu, 19 Dec 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626815; cv=none; b=YE8J2Rl91uYG52M19YKTFc+vO4rcSwTZFSSXuKeBcYeygbrLweMhqLB8Uzn6HhSEEjUToC4R9+aU1AfvNj+euuUhWsXRETtduoG0dQnGe4A/mSZzHWS4mnhIelbBDIcU4DxDJsWp5ZqL4W1Fknq4OKLyMgcYlQh+/iSl91Pe2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626815; c=relaxed/simple;
	bh=p16u+6he38A58mrGYiGYHXj0yO+tXnIwmYx1S0JFsAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8tICWrQPkThbiO/20hGdahhXuz5XaLU0nsiY7qUas21/QjEAP7OUTOTwkb7Ef7CEAbP5wJJK5pCUSSK8H3MmyNQoWzm4+jS0MuwckVB1sbaRSbAWHnL/qWPxFZ/muEJ1xwEPWUXT31a6kkJpcPm4iBm9QrXkdHf0PSE8rvSPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46F061480;
	Thu, 19 Dec 2024 08:47:21 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47EE93F58B;
	Thu, 19 Dec 2024 08:46:49 -0800 (PST)
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
Subject: [PATCH 10/10] mm: Introduce ctor/dtor at PGD level
Date: Thu, 19 Dec 2024 16:44:25 +0000
Message-ID: <20241219164425.2277022-11-kevin.brodsky@arm.com>
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

Following on from the introduction of P4D-level ctor/dtor, let's
finish the job and introduce ctor/dtor at PGD level. The incurred
improvement in page accounting is minimal - the main motivation is
to create a single, generic place where construction/destruction
hooks can be added for all page table pages.

This patch should cover all architectures and all configurations
where PGDs are one or more regular pages. This excludes any
configuration where PGDs are allocated from a kmem_cache object.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h |  2 ++
 arch/m68k/mm/motorola.c             |  6 ++++++
 arch/s390/include/asm/pgalloc.h     |  8 +++++++-
 include/asm-generic/pgalloc.h       |  2 ++
 include/linux/mm.h                  | 10 ++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 302c5bf67179..7bb9652e1d67 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -73,6 +73,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_pgd_dtor(virt_to_ptdesc(pgd));
 	pagetable_free(virt_to_ptdesc(pgd));
 }
 
@@ -84,6 +85,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pgd_ctor(ptdesc);
 	new_pgd = ptdesc_address(ptdesc);
 
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 37010ee15928..b0fbb369589f 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -169,6 +169,9 @@ void *get_pointer_table(int type)
 		case TABLE_PMD:
 			pagetable_pmd_ctor(virt_to_ptdesc(page));
 			break;
+		case TABLE_PGD:
+			pagetable_pgd_ctor(virt_to_ptdesc(page));
+			break;
 		}
 
 		mmu_page_ctor(page);
@@ -215,6 +218,9 @@ int free_pointer_table(void *table, int type)
 		case TABLE_PMD:
 			pagetable_pmd_dtor(virt_to_ptdesc((void *)page));
 			break;
+		case TABLE_PGD:
+			pagetable_pgd_dtor(virt_to_ptdesc((void *)page));
+			break;
 		}
 
 		free_page (page);
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 85a5d07365aa..00b69f4ddf17 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -126,11 +126,17 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *) crst_table_alloc(mm);
+	unsigned long *table = crst_table_alloc(mm);
+
+	if (!table)
+		return NULL;
+	pagetable_pgd_ctor(virt_to_ptdesc(table));
+	return (pgd_t *) table;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_pgd_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index daa8bea36952..112b09dc992e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -275,6 +275,7 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_pgd_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
@@ -284,6 +285,7 @@ static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
 	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
+	pagetable_pgd_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8b92f4bf3f1..7347da3460c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3171,6 +3171,16 @@ static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
 	__pagetable_dtor(ptdesc);
 }
 
+static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+{
+	__pagetable_ctor(ptdesc);
+}
+
+static inline void pagetable_pgd_dtor(struct ptdesc *ptdesc)
+{
+	__pagetable_dtor(ptdesc);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.47.0


