Return-Path: <linux-arch+bounces-11328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A78A7FAFB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7293E189AFAA
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0A26E162;
	Tue,  8 Apr 2025 09:54:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B43266594;
	Tue,  8 Apr 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106040; cv=none; b=U+1V/CP6Nzmn46lSdVJQBWLcuBLWw9M8RE/NvE34FfScYMee2RJfUbNTw8F65uWvXfF0u7hAp8W8gTAvLFPzoOKOnq7YA0CKLUFrU/PVyA4rGI5en3PfPIK5waRxB/rD/uCF0MAewy7BIAQCbdXlwXp35EXsrX488S6az8bMbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106040; c=relaxed/simple;
	bh=PWLeu289fXlXcBmOnTypDs6Tc9pxoDi1WRHvtvQYZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR82ff/nyAEXI8Qz1fB52AJhLhGhBUbz5+vBvlAY8bRaGVsoSs+AJu1kEYqvtfogePjJfu1KLpf5RG1P4OgsfBLfFEnPRiLgrJg7rfGGL4c5RzqTGVY/PIkCgs4In2QtQj+qWIk0Hz9FlTdlw+1f2+5fsNlxb5bhaADmNBnrerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D48D16A3;
	Tue,  8 Apr 2025 02:53:58 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DCDA3F6A8;
	Tue,  8 Apr 2025 02:53:52 -0700 (PDT)
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
Subject: [PATCH v2 10/12] riscv: mm: Clarify ctor mm argument in alloc_{pte,pmd}_late
Date: Tue,  8 Apr 2025 10:52:20 +0100
Message-ID: <20250408095222.860601-11-kevin.brodsky@arm.com>
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

pagetable_{pte,pmd}_ctor(mm, ptdesc) skip the ptlock initialisation
if mm is &init_mm. To avoid unnecessary overhead, it is therefore
preferable to pass the actual mm associated to the PTE/PMD.

Unfortunately, this proves challenging for alloc_{pte,pmd}_late() as
the associated mm is not available at the point where they are
called - in fact not even top-level functions like
create_pgd_mapping() are passed the mm. As a result they both call
the ctor with NULL as mm; this is safe but potentially wasteful.

This is not a new situation, but let's add a couple of comments to
clarify it.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e5ef693fc778..59a982f88908 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -442,6 +442,11 @@ static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
+	/*
+	 * We do not know which mm the PTE page is associated to at this point.
+	 * Passing NULL to the ctor is the safe option, though it may result
+	 * in unnecessary work (e.g. initialising the ptlock for init_mm).
+	 */
 	BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
@@ -522,6 +527,7 @@ static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
+	/* See comment in alloc_pte_late() regarding NULL passed the ctor */
 	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
 	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
-- 
2.47.0


