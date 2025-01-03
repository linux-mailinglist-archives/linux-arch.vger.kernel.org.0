Return-Path: <linux-arch+bounces-9578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE8A00DF7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 19:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F26164DB7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFA1FDE35;
	Fri,  3 Jan 2025 18:44:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6831F9F7D;
	Fri,  3 Jan 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929898; cv=none; b=SRzodrhBAfS4OPyt0X9b6RFkNPoMbanD6zhzAqq3GKajwHV9ua6RNB8Uq7ag8gQKVxylllLNaohaLu+97mu+KCL7zInCm6Ac0J8sQr4GWKXk0VpGyq6/udYASz+gFJrZwSLp5ZqSYtpvB4whAXc7do6TtvyLrdHKDmlJF+MBnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929898; c=relaxed/simple;
	bh=Ew7hsMLrfUdjKrXDhAKFhRJ7b4ft/IVhPbLobtBTgDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH6xuFri8EffxTXigCL0sb/4XvlXwXoARhD9bU+0cyji1hKSHI8hgP+XM/AHKEXUNuktrwOH/2Ml1wSBDBrjVWGz8pw+YbzcdRSMTgA64IEsjIuZLB/jnMRMVNGDDrkmNx7Nvb3N2xnaZ2cI2M8RgsalnXz2rOIbPJ6MDAx4I78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575781C14;
	Fri,  3 Jan 2025 10:45:23 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2191A3F673;
	Fri,  3 Jan 2025 10:44:51 -0800 (PST)
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
Subject: [PATCH v2 6/6] mm: Introduce ctor/dtor at PGD level
Date: Fri,  3 Jan 2025 18:44:15 +0000
Message-ID: <20250103184415.2744423-7-kevin.brodsky@arm.com>
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

Following on from the introduction of P4D-level ctor/dtor, let's
finish the job and introduce ctor/dtor at PGD level. The incurred
improvement in page accounting is minimal - the main motivation is
to create a single, generic place where construction/destruction
hooks can be added for all page table pages.

This patch should cover all architectures and all configurations
where PGDs are one or more regular pages. This excludes any
configuration where PGDs are allocated from a kmem_cache object.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h | 3 ++-
 arch/m68k/mm/motorola.c             | 6 ++++--
 arch/s390/include/asm/pgalloc.h     | 9 ++++++++-
 include/asm-generic/pgalloc.h       | 3 ++-
 include/linux/mm.h                  | 5 +++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 22d6c1fcabfb..4c648b51e7fd 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -73,7 +73,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_free(virt_to_ptdesc(pgd));
+	pagetable_dtor_free(virt_to_ptdesc(pgd));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
@@ -84,6 +84,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pgd_ctor(ptdesc);
 	new_pgd = ptdesc_address(ptdesc);
 
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 6c09ccb72e8b..73651e093c4d 100644
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
@@ -207,8 +210,7 @@ int free_pointer_table(void *table, int type)
 		/* all tables in page are free, free page */
 		list_del(dp);
 		mmu_page_dtor((void *)page);
-		if (type == TABLE_PTE || type == TABLE_PMD)
-			pagetable_dtor(virt_to_ptdesc((void *)page));
+		pagetable_dtor(virt_to_ptdesc((void *)page));
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 5fced6d3c36b..b19b6ed2ab53 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -130,11 +130,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *) crst_table_alloc(mm);
+	unsigned long *table = crst_table_alloc(mm);
+
+	if (!table)
+		return NULL;
+	pagetable_pgd_ctor(virt_to_ptdesc(table));
+
+	return (pgd_t *) table;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index de4df14158e6..892ece4558a2 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -271,6 +271,7 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_pgd_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
@@ -280,7 +281,7 @@ static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
 	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PGD_FREE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 065fa9449d03..486638d22fc6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3243,6 +3243,11 @@ static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
 	__pagetable_ctor(ptdesc);
 }
 
+static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+{
+	__pagetable_ctor(ptdesc);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.47.0


