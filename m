Return-Path: <linux-arch+bounces-9435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA639F804C
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C7C16B6C5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A219D881;
	Thu, 19 Dec 2024 16:46:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12819C56D;
	Thu, 19 Dec 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626781; cv=none; b=fCmn83UasbDD6IidrylJ3GLWGc6tloO3s5zqnG3VN08TqBHIYhgqFzNvJcDWq7telS/IQ6OQIJoKNROpZm9PgucS0TL02BvK5468Bg9R7qILsIi6uflCGQqcIXxODXgftTHLGL4ZyMr/ccdCBUdxcKXEbIw4KDOrUOT3cqs1qZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626781; c=relaxed/simple;
	bh=7k73V98UoXYdW11oOcO0pNm8HlnYRmxZb3m4FQQZzbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0zcaRvPwAvvOL7KszWluxY6KxSK/xY5mgGWG8uduLaWmHz/a46KO8C3ZwIFhRUvkwzejc+XQoEZ4NpulZpG7fwGT2xwZNsKRqq3o6nMWPk9qIWALJoDiLtS6jSSZuWZSCThwuIewzeXS8Z0bGxbeEHowOKXqS8hbNX1MSjt1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90DDF1480;
	Thu, 19 Dec 2024 08:46:47 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90EAC3F58B;
	Thu, 19 Dec 2024 08:46:15 -0800 (PST)
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
Subject: [PATCH 02/10] parisc: mm: Ensure pagetable_pmd_[cd]tor are called
Date: Thu, 19 Dec 2024 16:44:17 +0000
Message-ID: <20241219164425.2277022-3-kevin.brodsky@arm.com>
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

The implementation of pmd_{alloc_one,free} on parisc requires a
non-zero allocation order, but is completely standard aside from
that. Let's reuse the generic implementation of pmd_alloc_one().
Explicit zeroing is not needed as GFP_PGTABLE_KERNEL includes
__GFP_ZERO. The generic pmd_free() can handle higher allocation
orders so we don't need to define our own.

These changes ensure that pagetable_pmd_[cd]tor are called,
improving the accounting of page table pages.

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


