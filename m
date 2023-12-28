Return-Path: <linux-arch+bounces-1202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D481F628
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 09:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28AA1C21D07
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531B6FA3;
	Thu, 28 Dec 2023 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPt/k23K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543306FA1;
	Thu, 28 Dec 2023 08:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB820C433CA;
	Thu, 28 Dec 2023 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703753966;
	bh=16+Nu0Wb1JkSQStq2mcU9kdq58a4r2QX4o0XnGMbW1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPt/k23KQR/ek+Wk4Mb0Ffgqjpr0C4tGoF8uMnFE+csMqgfr093NXmCFQN67kLxmg
	 2wX671IgLVNFprhYGlOqZT9sQd45M//tMA96Y48PuyxuAUw2YYrGJheIf3jUNzegsO
	 oZr1LwJ+Pd98LSUtkZQ1GQJGY/kKAzRUqhRAQ2LGss8txZ4sD1RLgnpeb+dxBj+bEm
	 lTFy+2WWHg42Kl6nbbR4U7U8bNB7+1AF95XqLf72vf4OQxZI1A08+R/V8QaP95mAv4
	 W39UhXGY1i/064M112ShThexcH0ieACEEyC3qc6Oesf9LT7f5gDAuaHeHCYJG86mq+
	 AIf2i7+FdSkcQ==
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
	linux-riscv@lists.infradead.org,
	Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yu Zhao <yuzhao@google.com>,
	x86@kernel.org
Subject: [PATCH 1/2] mm/tlb: fix fullmm semantics
Date: Thu, 28 Dec 2023 16:46:41 +0800
Message-Id: <20231228084642.1765-2-jszhang@kernel.org>
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

From: Nadav Amit <namit@vmware.com>

fullmm in mmu_gather is supposed to indicate that the mm is torn-down
(e.g., on process exit) and can therefore allow certain optimizations.
However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
the TLB should be fully flushed.

Change tlb_finish_mmu() to set need_flush_all and check this flag in
tlb_flush_mmu_tlbonly() when deciding whether a flush is needed.

At the same time, bring the arm64 fullmm on process exit optimization back.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 arch/arm64/include/asm/tlb.h | 5 ++++-
 include/asm-generic/tlb.h    | 2 +-
 mm/mmu_gather.c              | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 846c563689a8..6164c5f3b78f 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	 * invalidating the walk-cache, since the ASID allocator won't
 	 * reallocate our ASID without invalidating the entire TLB.
 	 */
-	if (tlb->fullmm) {
+	if (tlb->fullmm)
+		return;
+
+	if (tlb->need_flush_all) {
 		if (!last_level)
 			flush_tlb_mm(tlb->mm);
 		return;
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..f2d46357bcbb 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -452,7 +452,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 	 * these bits.
 	 */
 	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
-	      tlb->cleared_puds || tlb->cleared_p4ds))
+	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->need_flush_all))
 		return;
 
 	tlb_flush(tlb);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd21..79298bac3481 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -384,7 +384,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
 		 * On x86 non-fullmm doesn't yield significant difference
 		 * against fullmm.
 		 */
-		tlb->fullmm = 1;
+		tlb->need_flush_all = 1;
 		__tlb_reset_range(tlb);
 		tlb->freed_tables = 1;
 	}
-- 
2.40.0


