Return-Path: <linux-arch+bounces-9574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901AA00DD5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA73A44BE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4F1FCF57;
	Fri,  3 Jan 2025 18:44:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616081FCCFF;
	Fri,  3 Jan 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929880; cv=none; b=Dg0jCxrZJe6Nuh5c6NyU39Gdvbd4iBDQTY70e4qYYKRPhBq+D6fCWLma49Qd1ItzpX2bZ51b/JdAA92SH+omzTIT4C4j0ZLTz6GZa7BCJYui712X7+Hu7Pt+WhMYxBvlQDVOk3P7U9v4vWGbklTAAD5u1/tmS3gvq5n4H38SjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929880; c=relaxed/simple;
	bh=/7xd1qwI+V6LAz4fDaB/KFFcPFfXSKau+WrvZgcwgFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWiuOMWJ1LZ1wingwPmQY7l8ctWdS4I4ug/0ZrdmLbzY3u8lC2CisUWw/mrCfjeDa6X27kXW8BUarhBO/fHdiOJOakmRXWKR3k+gLJma3sa264RGbq28lAkL8O4idWQj8cyBKDUfJkGLrU+Af4Vsv+ZDnfupvatVjlVjtVy+tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED50C1C14;
	Fri,  3 Jan 2025 10:45:05 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7C5C3F673;
	Fri,  3 Jan 2025 10:44:33 -0800 (PST)
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
Subject: [PATCH v2 2/6] parisc: mm: Ensure pagetable_pmd_[cd]tor are called
Date: Fri,  3 Jan 2025 18:44:11 +0000
Message-ID: <20250103184415.2744423-3-kevin.brodsky@arm.com>
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

The implementation of pmd_{alloc_one,free} on parisc requires a
non-zero allocation order, but is completely standard aside from
that. Let's reuse the generic implementation of pmd_alloc_one().
Explicit zeroing is not needed as GFP_PGTABLE_KERNEL includes
__GFP_ZERO. The generic pmd_free() can handle higher allocation
orders so we don't need to define our own.

These changes ensure that pagetable_pmd_[cd]tor are called,
improving the accounting of page table pages.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/parisc/include/asm/pgalloc.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index e3e142b1c5c5..3e8dbd79670b 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -11,7 +11,6 @@
 #include <asm/cache.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
-#define __HAVE_ARCH_PMD_FREE
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -46,17 +45,19 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *pmd;
+	struct ptdesc *ptdesc;
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	pmd = (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_TABLE_ORDER);
-	if (likely(pmd))
-		memset ((void *)pmd, 0, PAGE_SIZE << PMD_TABLE_ORDER);
-	return pmd;
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	free_pages((unsigned long)pmd, PMD_TABLE_ORDER);
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	ptdesc = pagetable_alloc(gfp, PMD_TABLE_ORDER);
+	if (!ptdesc)
+		return NULL;
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
+	return ptdesc_address(ptdesc);
 }
 #endif
 
-- 
2.47.0


