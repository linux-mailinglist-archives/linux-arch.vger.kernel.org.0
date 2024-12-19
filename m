Return-Path: <linux-arch+bounces-9441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA419F8086
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8FD16D77F
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19991A4F2D;
	Thu, 19 Dec 2024 16:46:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEE1A4F0A;
	Thu, 19 Dec 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626806; cv=none; b=izhlryVY6eorJhuFZR52V5+nyI28VKmmTHFZzjgUtqGAQeIFCf6GWu/v5IAVymv6ZGX6J3ZH9U1TxRL1y5JlbhvQRn0ettjHfEvs382SYuTcy+5t3Arex0ID7K4l1c/L/UWxhDvEKV02H//4u2B96DU6QzN19xq2TZHpDBEVrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626806; c=relaxed/simple;
	bh=RM1s/LcJNoesIl5WZFPhuIb5E4SD7DcQuAnDOCY4mts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeTkaIkArTjb8SYCPi3y6/7wuDSXuiwAfjEYNlYaZj5aXxGmMIo3xrX96K+Fvi8K7vjXRICYfuXEtB13ghQ79M/QjlbwtF80Ybtbs/Oi0IgJVPJIMd4+1ui2Rc9P1vbOWaTg+bNC9Ak2YXgbkoWkXHiau0tzjE2pB37vzGaEcpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7B11480;
	Thu, 19 Dec 2024 08:47:12 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7743F58B;
	Thu, 19 Dec 2024 08:46:40 -0800 (PST)
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
Subject: [PATCH 08/10] ARM: mm: Rename PGD helpers
Date: Thu, 19 Dec 2024 16:44:23 +0000
Message-ID: <20241219164425.2277022-9-kevin.brodsky@arm.com>
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

Generic implementations of __pgd_alloc and __pgd_free are about to
be introduced. Rename the macros in arch/arm/mm/pgd.c to avoid
clashes. While we're at it, also pass down the mm as argument to
those helpers, as it will be needed to call the generic
__pgd_{alloc,free}.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/mm/pgd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index f8e9bc58a84f..2a1077747758 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -17,11 +17,11 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_LPAE
-#define __pgd_alloc()	kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL)
-#define __pgd_free(pgd)	kfree(pgd)
+#define _pgd_alloc(mm)		kmalloc_array(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL)
+#define _pgd_free(mm, pgd)	kfree(pgd)
 #else
-#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
-#define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2)
+#define _pgd_alloc(mm)		(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
+#define _pgd_free(mm, pgd)	free_pages((unsigned long)pgd, 2)
 #endif
 
 /*
@@ -35,7 +35,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	pmd_t *new_pmd, *init_pmd;
 	pte_t *new_pte, *init_pte;
 
-	new_pgd = __pgd_alloc();
+	new_pgd = _pgd_alloc(mm);
 	if (!new_pgd)
 		goto no_pgd;
 
@@ -134,7 +134,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 no_pud:
 	p4d_free(mm, new_p4d);
 no_p4d:
-	__pgd_free(new_pgd);
+	_pgd_free(mm, new_pgd);
 no_pgd:
 	return NULL;
 }
@@ -207,5 +207,5 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd_base)
 		p4d_free(mm, p4d);
 	}
 #endif
-	__pgd_free(pgd_base);
+	_pgd_free(mm, pgd_base);
 }
-- 
2.47.0


