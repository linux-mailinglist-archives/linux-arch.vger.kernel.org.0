Return-Path: <linux-arch+bounces-9577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B048A00DED
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12043164B85
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE81FDE19;
	Fri,  3 Jan 2025 18:44:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95E1FDE12;
	Fri,  3 Jan 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929893; cv=none; b=Y+emjFjcTHOzu/8XNp7BBvIwO9vk1qstcxEEI+OPXgbQAWRm6UTOGQWL5YcAS/UHtF9Th07QqMXdROICRaVhJ8wu6Hk52RjmbkZiSjE3qKeJv37OXJjXB7u05vAl1QGhVf0w2oo6cj3CgMaN55CxTi5qEJoP1Kp1Ll45/lXqHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929893; c=relaxed/simple;
	bh=9kZYicTfSh2U92gGvO0e1EFF63mSMPjFF5WQlePJsYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU987rAy01X4iz5XXgTwYCj30qgLAsvvr8QpzuoRZKTUExUl14TQJptaeR4EmxYVlw+3InNt3C5HWdU2s5l/awiovKi52EmE2KPw2b3aYRiaIB9V5g8qbPn8F13OH6M9PxaSUNwfHhKIdHlcAKAeyp3ITqEWm/HBXbyaoA69Yn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B18B1480;
	Fri,  3 Jan 2025 10:45:19 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9F483F673;
	Fri,  3 Jan 2025 10:44:46 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
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
Subject: [PATCH v2 5/6] asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
Date: Fri,  3 Jan 2025 18:44:14 +0000
Message-ID: <20250103184415.2744423-6-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250103184415.2744423-1-kevin.brodsky@arm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have a generic implementation of alloc/free up to P4D
level, as well as pgd_free(). Let's finish the work and add a
generic PGD-level alloc helper as well.

Unlike at lower levels, almost all architectures need some specific
magic at PGD level (typically initialising PGD entries), so
introducing a generic pgd_alloc() isn't worth it. Instead we
introduce two new helpers, __pgd_alloc() and __pgd_free(), and make
use of them in the arch-specific pgd_alloc() and pgd_free() wherever
possible. To accommodate as many arch as possible, __pgd_alloc()
takes a page allocation order.

Because pagetable_alloc() allocates zeroed pages, explicit zeroing
in pgd_alloc() becomes redundant and we can get rid of it.
Some trivial implementations of pgd_free() also become unnecessary
once __pgd_alloc() is used; remove them.

Another small improvement is consistent accounting of PGD pages by
using GFP_PGTABLE_{USER,KERNEL} as appropriate.

Not all PGD allocations can be handled by the generic helpers. In
particular, multiple architectures allocate PGDs from a kmem_cache,
and those PGDs may not be page-sized.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/alpha/mm/init.c                  |  2 +-
 arch/arc/include/asm/pgalloc.h        |  9 ++-------
 arch/arm/mm/pgd.c                     |  8 +++-----
 arch/arm64/mm/pgd.c                   |  4 ++--
 arch/csky/include/asm/pgalloc.h       |  2 +-
 arch/hexagon/include/asm/pgalloc.h    |  2 +-
 arch/loongarch/mm/pgtable.c           |  7 +++----
 arch/m68k/include/asm/sun3_pgalloc.h  |  2 +-
 arch/microblaze/include/asm/pgalloc.h |  7 +------
 arch/mips/include/asm/pgalloc.h       |  6 ------
 arch/mips/mm/pgtable.c                |  8 +++-----
 arch/nios2/mm/pgtable.c               |  3 ++-
 arch/openrisc/include/asm/pgalloc.h   |  6 ++----
 arch/parisc/include/asm/pgalloc.h     | 16 +---------------
 arch/riscv/include/asm/pgalloc.h      |  3 +--
 arch/um/kernel/mem.c                  |  7 +++----
 arch/x86/mm/pgtable.c                 | 24 +++++++++++-------------
 arch/xtensa/include/asm/pgalloc.h     |  2 +-
 include/asm-generic/pgalloc.h         | 27 ++++++++++++++++++++++++++-
 19 files changed, 65 insertions(+), 80 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 4fe618446e4c..61c2198b1359 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -42,7 +42,7 @@ pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret, *init;
 
-	ret = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	ret = __pgd_alloc(mm, 0);
 	init = pgd_offset(&init_mm, 0UL);
 	if (ret) {
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 096b8ef58edb..dfae070fe8d5 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -53,19 +53,14 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte_
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret = (pgd_t *) __get_free_page(GFP_KERNEL);
+	pgd_t *ret = __pgd_alloc(mm, 0);
 
 	if (ret) {
 		int num, num2;
-		num = USER_PTRS_PER_PGD + USER_KERNEL_GUTTER / PGDIR_SIZE;
-		memzero(ret, num * sizeof(pgd_t));
 
+		num = USER_PTRS_PER_PGD + USER_KERNEL_GUTTER / PGDIR_SIZE;
 		num2 = VMALLOC_SIZE / PGDIR_SIZE;
 		memcpy(ret + num, swapper_pg_dir + num, num2 * sizeof(pgd_t));
-
-		memzero(ret + num + num2,
-			       (PTRS_PER_PGD - num - num2) * sizeof(pgd_t));
-
 	}
 	return ret;
 }
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 2a1077747758..4eb81b7ed03a 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -17,11 +17,11 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_LPAE
-#define _pgd_alloc(mm)		kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL)
+#define _pgd_alloc(mm)		kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL | __GFP_ZERO)
 #define _pgd_free(mm, pgd)	kfree(pgd)
 #else
-#define _pgd_alloc(mm)		(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
-#define _pgd_free(mm, pgd)	free_pages((unsigned long)pgd, 2)
+#define _pgd_alloc(mm)		__pgd_alloc(mm, 2)
+#define _pgd_free(mm, pgd)	__pgd_free(mm, pgd)
 #endif
 
 /*
@@ -39,8 +39,6 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (!new_pgd)
 		goto no_pgd;
 
-	memset(new_pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-
 	/*
 	 * Copy over the kernel and IO PGD entries
 	 */
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 0c501cabc238..8160cff35089 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -33,7 +33,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (pgdir_is_page_size())
-		return (pgd_t *)__get_free_page(gfp);
+		return __pgd_alloc(mm, 0);
 	else
 		return kmem_cache_alloc(pgd_cache, gfp);
 }
@@ -41,7 +41,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	if (pgdir_is_page_size())
-		free_page((unsigned long)pgd);
+		__pgd_free(mm, pgd);
 	else
 		kmem_cache_free(pgd_cache, pgd);
 }
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index f1ce5b7b28f2..bf8400c28b5a 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -44,7 +44,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	pgd_t *ret;
 	pgd_t *init;
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
+	ret = __pgd_alloc(mm, 0);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init((unsigned long *)ret);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 40e42a0e7167..1ee5f5f157ca 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -22,7 +22,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
-	pgd = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	pgd = __pgd_alloc(mm, 0);
 
 	/*
 	 * There may be better ways to do this, but to ensure
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 3fa69b23ff84..22a94bb3e6e8 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -23,11 +23,10 @@ EXPORT_SYMBOL(tlb_virt_to_page);
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *init, *ret = NULL;
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
+	pgd_t *init, *ret;
 
-	if (ptdesc) {
-		ret = (pgd_t *)ptdesc_address(ptdesc);
+	ret = __pgd_alloc(mm, 0);
+	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 2b626cb3ad0a..f1ae4ed890db 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -43,7 +43,7 @@ static inline pgd_t * pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *new_pgd;
 
-	new_pgd = (pgd_t *)get_zeroed_page(GFP_KERNEL);
+	new_pgd = __pgd_alloc(mm, 0);
 	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
 	memset(new_pgd, 0, (PAGE_OFFSET >> PGDIR_SHIFT));
 	return new_pgd;
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index 6c33b05f730f..084a8a0dc239 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -21,12 +21,7 @@
 
 extern void __bad_pte(pmd_t *pmd);
 
-static inline pgd_t *get_pgd(void)
-{
-	return (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
-}
-
-#define pgd_alloc(mm)		get_pgd()
+#define pgd_alloc(mm)		__pgd_alloc(mm, 0)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 36d9805033c4..26c7a6ede983 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -15,7 +15,6 @@
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
-#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -49,11 +48,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(void *addr);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	pagetable_free(virt_to_ptdesc(pgd));
-}
-
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index 1506e458040d..10835414819f 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -10,12 +10,10 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *init, *ret = NULL;
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM,
-			PGD_TABLE_ORDER);
+	pgd_t *init, *ret;
 
-	if (ptdesc) {
-		ret = ptdesc_address(ptdesc);
+	ret = __pgd_alloc(mm, PGD_TABLE_ORDER);
+	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
diff --git a/arch/nios2/mm/pgtable.c b/arch/nios2/mm/pgtable.c
index 7c76e8a7447a..6470ed378782 100644
--- a/arch/nios2/mm/pgtable.c
+++ b/arch/nios2/mm/pgtable.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 
 #include <asm/cpuinfo.h>
+#include <asm/pgalloc.h>
 
 /* pteaddr:
  *   ptbase | vpn* | zero
@@ -54,7 +55,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret, *init;
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
+	ret = __pgd_alloc(mm, 0);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 596e2355824e..3372f4e6ab4b 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -41,15 +41,13 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
  */
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret = (pgd_t *)__get_free_page(GFP_KERNEL);
+	pgd_t *ret = __pgd_alloc(mm, 0);
 
-	if (ret) {
-		memset(ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+	if (ret)
 		memcpy(ret + USER_PTRS_PER_PGD,
 		       swapper_pg_dir + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 
-	}
 	return ret;
 }
 
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 3e8dbd79670b..2ca74a56415c 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -11,26 +11,12 @@
 #include <asm/cache.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
-#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 /* Allocate the top level pgd (page directory) */
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd;
-
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
-	if (unlikely(pgd == NULL))
-		return NULL;
-
-	memset(pgd, 0, PAGE_SIZE << PGD_TABLE_ORDER);
-
-	return pgd;
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
+	return __pgd_alloc(mm, PGD_TABLE_ORDER);
 }
 
 #if CONFIG_PGTABLE_LEVELS == 3
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index c8907b831711..3e2aebea6312 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -130,9 +130,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
-	pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	pgd = __pgd_alloc(mm, 0);
 	if (likely(pgd != NULL)) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 		/* Copy kernel mappings */
 		sync_kernel_mappings(pgd);
 	}
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 53248ed04771..d98812907493 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -214,14 +214,13 @@ void free_initmem(void)
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	pgd_t *pgd = __pgd_alloc(mm, 0);
 
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+	if (pgd)
 		memcpy(pgd + USER_PTRS_PER_PGD,
 		       swapper_pg_dir + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
+
 	return pgd;
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a0b0e501ba66..29b0196ae49c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -395,15 +395,14 @@ void __init pgtable_cache_init(void)
 				      SLAB_PANIC, NULL);
 }
 
-static inline pgd_t *_pgd_alloc(void)
+static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 {
 	/*
 	 * If no SHARED_KERNEL_PMD, PAE kernel is running as a Xen domain.
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
-						 PGD_ALLOCATION_ORDER);
+		return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
 
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
@@ -412,24 +411,23 @@ static inline pgd_t *_pgd_alloc(void)
 	return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
 }
 
-static inline void _pgd_free(pgd_t *pgd)
+static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	if (!SHARED_KERNEL_PMD)
-		free_pages((unsigned long)pgd, PGD_ALLOCATION_ORDER);
+		__pgd_free(mm, pgd);
 	else
 		kmem_cache_free(pgd_cache, pgd);
 }
 #else
 
-static inline pgd_t *_pgd_alloc(void)
+static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
-					 PGD_ALLOCATION_ORDER);
+	return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
 }
 
-static inline void _pgd_free(pgd_t *pgd)
+static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_ALLOCATION_ORDER);
+	__pgd_free(mm, pgd);
 }
 #endif /* CONFIG_X86_PAE */
 
@@ -439,7 +437,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
 	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
 
-	pgd = _pgd_alloc();
+	pgd = _pgd_alloc(mm);
 
 	if (pgd == NULL)
 		goto out;
@@ -482,7 +480,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (sizeof(pmds) != 0)
 		free_pmds(mm, pmds, PREALLOCATED_PMDS);
 out_free_pgd:
-	_pgd_free(pgd);
+	_pgd_free(mm, pgd);
 out:
 	return NULL;
 }
@@ -492,7 +490,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	pgd_mop_up_pmds(mm, pgd);
 	pgd_dtor(pgd);
 	paravirt_pgd_free(mm, pgd);
-	_pgd_free(pgd);
+	_pgd_free(mm, pgd);
 }
 
 /*
diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 7fc0f9126dd3..1919ee9c3dd6 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -29,7 +29,7 @@
 static inline pgd_t*
 pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t*) __get_free_page(GFP_KERNEL | __GFP_ZERO);
+	return __pgd_alloc(mm, 0);
 }
 
 static inline void ptes_clear(pte_t *ptep)
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index e3977ddca15e..de4df14158e6 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -258,10 +258,35 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 
 #endif /* CONFIG_PGTABLE_LEVELS > 4 */
 
+static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+	struct ptdesc *ptdesc;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	gfp &= ~__GFP_HIGHMEM;
+
+	ptdesc = pagetable_alloc_noprof(gfp, order);
+	if (!ptdesc)
+		return NULL;
+
+	return ptdesc_address(ptdesc);
+}
+#define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
+
+static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
+
+	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
+	pagetable_free(ptdesc);
+}
+
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_free(virt_to_ptdesc(pgd));
+	__pgd_free(mm, pgd);
 }
 #endif
 
-- 
2.47.0


