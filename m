Return-Path: <linux-arch+bounces-11320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6122A7FAA8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 12:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D0E17F354
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417372676DE;
	Tue,  8 Apr 2025 09:53:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192926A1C9;
	Tue,  8 Apr 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106002; cv=none; b=kk22BG6P5zhTZGUQYiLPXOufsym6ZppdxABGaas+TpFk9yEVlMfBnVhUG9ZCn0iOm0SktlAHdUt4MFr7XQUkGEbXkIapnqlW0EOURviRHUUWj0ogb/NIjIaEErCVPzXu0Yz6VGvGTvBLOGNycmb0GL/mif9j218dLtl2TQMEh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106002; c=relaxed/simple;
	bh=jcZ1Kr1P57a11RT8doS/2JmL0jOnCT+7UGWHdKoIUQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ15MT9evyD0Ct+9FTRn0OKfMB/mO5N/Y8HNiLJNaTXrcKVfFKvbW+Dzrc5yP6NLaDtKvTOAonuqCtZS39n4p0Se+63CR/+SatkBsJC1wBJEfTqo6+fzVA/xD2tFIKhPxzDQyVA0tDVrtwfpgnSRlK33jI+FF+gz+ZFSJU+7twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE8B616A3;
	Tue,  8 Apr 2025 02:53:20 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7EA3F6A8;
	Tue,  8 Apr 2025 02:53:15 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 02/12] x86: pgtable: Always use pte_free_kernel()
Date: Tue,  8 Apr 2025 10:52:12 +0100
Message-ID: <20250408095222.860601-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408095222.860601-1-kevin.brodsky@arm.com>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page table pages are normally freed using the appropriate helper for
the given page table level. On x86, pud_free_pmd_page() and
pmd_free_pte_page() are an exception to the rule: they call
free_page() directly.

Constructor/destructor calls are about to be introduced for kernel
PTEs. To avoid missing dtor calls in those helpers, free the PTE
pages using pte_free_kernel() instead of free_page().

While at it also use pmd_free() instead of calling pagetable_dtor()
explicitly at the PMD level.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/mm/pgtable.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7930f234c5f6..1dee9bdbeea5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -809,14 +809,13 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		if (!pmd_none(pmd_sv[i])) {
 			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
-			free_page((unsigned long)pte);
+			pte_free_kernel(&init_mm, pte);
 		}
 	}
 
 	free_page((unsigned long)pmd_sv);
 
-	pagetable_dtor(virt_to_ptdesc(pmd));
-	free_page((unsigned long)pmd);
+	pmd_free(&init_mm, pmd);
 
 	return 1;
 }
@@ -839,7 +838,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	free_page((unsigned long)pte);
+	pte_free_kernel(&init_mm, pte);
 
 	return 1;
 }
-- 
2.47.0


