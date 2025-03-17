Return-Path: <linux-arch+bounces-10915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6D9A6533E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BB13BC507
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423124394A;
	Mon, 17 Mar 2025 14:22:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D424A056;
	Mon, 17 Mar 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221343; cv=none; b=FHT62ByKWwXk+42sxXlFcX2TYJyD8P3y3ydQT2nXZKlr8Xw46aeJduJwjFfPFelnCR/n8uIePMOCTnVCvZ2Kh2SnD90VywSUpV+9cRcZ0kc1LyrdqAS3TTL9a4B7xu3UVMyEIclvV0kqMQ6CPU6rSRYxt9fQAU7IIuDG7fNcKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221343; c=relaxed/simple;
	bh=rQYXNBvmvmZDvgD5WxDZTChFqhlSHr1Rda9SRbyWklA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cohh2WE2ZXLDz2Cdqk/9kwP34tVqXWEMC9vMAhDzvs31h46yJzmYbwL+QaWvTGVS4sXbOfVhTsyTUPE0P/sT9Lqr07SfBxUeCQ4asI0X3HpXP4TIZQujjF1StOZL8ODP+j2ln3hLLoW/VOgLXGGFHWaad44GXJHXEPhpCvZigZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A762573;
	Mon, 17 Mar 2025 07:22:30 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35C43F63F;
	Mon, 17 Mar 2025 07:22:16 -0700 (PDT)
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
	sparclinux@vger.kernel.org
Subject: [PATCH 11/11] riscv: mm: Call PUD/P4D ctor in special kernel pgtable alloc
Date: Mon, 17 Mar 2025 14:17:00 +0000
Message-ID: <20250317141700.3701581-12-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250317141700.3701581-1-kevin.brodsky@arm.com>
References: <20250317141700.3701581-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constructors for PUD/P4D-level pgtables were recently introduced.
They should be called for all pgtables; make sure they are called
for special kernel mappings created by create_pgd_mapping() too.

While at it also switch to using pagetable_alloc() like
in alloc_{pte,pmd}_late().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/mm/init.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb18940113f2..dc2715f3fd00 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -557,11 +557,11 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 
 static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
 {
-	unsigned long vaddr;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr);
-	return __pa(vaddr);
+	BUG_ON(!ptdesc);
+	pagetable_pud_ctor(ptdesc);
+	return __pa((pud_t *)ptdesc_address(ptdesc));
 }
 
 static p4d_t *__init get_p4d_virt_early(phys_addr_t pa)
@@ -595,11 +595,11 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 
 static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
 {
-	unsigned long vaddr;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr);
-	return __pa(vaddr);
+	BUG_ON(!ptdesc);
+	pagetable_p4d_ctor(ptdesc);
+	return __pa((p4d_t *)ptdesc_address(ptdesc));
 }
 
 static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
-- 
2.47.0


