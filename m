Return-Path: <linux-arch+bounces-1203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479881F62B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 09:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143401F225C7
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52E6FD1;
	Thu, 28 Dec 2023 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKBsmvO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2E6FCB;
	Thu, 28 Dec 2023 08:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5389DC433CC;
	Thu, 28 Dec 2023 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703753970;
	bh=4x9t1f04s06EEvjvtQ7yC2/ljPKJqNDBrcj2L/hT3Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKBsmvO8700bopUsWROGXLmoCWFXsTW+dDVnNGSxOkaL/USi53RKl8TdsixW0+meq
	 ZCWxQdbp33ikg/G9ezCtq7NkctrZnj90/OzQ0n9iUxG+YKDW4DQ0nPcXFY42wiBv+r
	 997dRhgKccetlwPkyjqAZY+f5mx70kEYFtXj+CoiB8mr5EJbZvQA7ejpm/TS62Kx8Z
	 MVCzbTzHlBLytfAxGrORGDpTnrYATlbt8PPwaCWGIg2WfXt/VlliMYXrTExd8VnHSR
	 LxHkWdaNYJGBiXawHPjLTvQ6a2cSRLkXc9Y/wtpnv3MN3QHCLVBpveSUN4P0ShLMkB
	 BBgaja1UR4WBA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] riscv: tlb: avoid tlb flushing if fullmm == 1
Date: Thu, 28 Dec 2023 16:46:42 +0800
Message-Id: <20231228084642.1765-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231228084642.1765-1-jszhang@kernel.org>
References: <20231228084642.1765-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmu_gather code sets fullmm=1 when tearing down the entire address
space for an mm_struct on exit or execve. So if the underlying platform
supports ASID, the tlb flushing can be avoided because the ASID
allocator will never re-allocate a dirty ASID.

Use the performance of Process creation in unixbench on T-HEAD TH1520
platform is improved by about 4%.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/tlb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1eb5682b2af6..35f3c214332e 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -12,10 +12,19 @@ static void tlb_flush(struct mmu_gather *tlb);
 
 #define tlb_flush tlb_flush
 #include <asm-generic/tlb.h>
+#include <asm/mmu_context.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_MMU
+	/*
+	 * If ASID is supported, the ASID allocator will either invalidate the
+	 * ASID or mark it as used. So we can avoid TLB invalidation when
+	 * pulling down a full mm.
+	 */
+	if (static_branch_likely(&use_asid_allocator) && tlb->fullmm)
+		return;
+
 	if (tlb->fullmm || tlb->need_flush_all)
 		flush_tlb_mm(tlb->mm);
 	else
-- 
2.40.0


