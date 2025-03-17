Return-Path: <linux-arch+bounces-10908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B666A65306
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40675167971
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592E24337E;
	Mon, 17 Mar 2025 14:21:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD72417C9;
	Mon, 17 Mar 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221311; cv=none; b=YpJ8QS+hYv+B2IGo3cn3Ou/gMhiSnB1c2qEkzQndSeUTOVSZIK67Mhph3Ln22JfjYUHyZpfNe23VaCVNFFvIQdBKHmPJFwD4nrdPJIVvMYCIeA2wtqxAGz5InoGivVFA/4qoea5rYgkY9ZFyuXQQ2AsTnexKGtx3SPB59an4OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221311; c=relaxed/simple;
	bh=sJY3k14WBl1j2uqNZ+rNzVrFO/O8YxCuCcrCnNtLeO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqFeSOGav7yi8PgJgDv8gLDFrAAzURhWCNg96wSmmxvRQs4DWxq9mkOLr9/NRI0sv+OH3gmYwOMEN7uh3v/o4tgN5lY8ocehjKElObNVqFUJwrxa5vlaV2w1x9sF0uSTHNFlqYdigObfDA+PjzYf8bMQcX8Ic923SXhpMyy1sdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005532576;
	Mon, 17 Mar 2025 07:21:58 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9AA3F63F;
	Mon, 17 Mar 2025 07:21:44 -0700 (PDT)
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
Subject: [PATCH 04/11] powerpc: mm: Call ctor/dtor for kernel PTEs
Date: Mon, 17 Mar 2025 14:16:53 +0000
Message-ID: <20250317141700.3701581-5-kevin.brodsky@arm.com>
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

The generic implementation of pte_{alloc_one,free}_kernel now calls
the [cd]tor, without initialising the ptlock needlessly as
pagetable_pte_ctor() skips it for init_mm.

On powerpc, all functions related to PTE allocation are implemented
by common helpers, which are passed a boolean to differentiate user
from kernel pgtables. This patch aligns the powerpc implementation
with the generic one by calling pagetable_pte_[cd]tor()
unconditionally in those helpers.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/powerpc/mm/pgtable-frag.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 387e9b1fe12c..77e55eac16e4 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -56,19 +56,17 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
 	struct ptdesc *ptdesc;
+	gfp_t gfp = PGALLOC_GFP;
 
-	if (!kernel) {
-		ptdesc = pagetable_alloc(PGALLOC_GFP | __GFP_ACCOUNT, 0);
-		if (!ptdesc)
-			return NULL;
-		if (!pagetable_pte_ctor(mm, ptdesc)) {
-			pagetable_free(ptdesc);
-			return NULL;
-		}
-	} else {
-		ptdesc = pagetable_alloc(PGALLOC_GFP, 0);
-		if (!ptdesc)
-			return NULL;
+	if (!kernel)
+		gfp |= __GFP_ACCOUNT;
+
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
 	}
 
 	atomic_set(&ptdesc->pt_frag_refcount, 1);
@@ -124,12 +122,10 @@ void pte_fragment_free(unsigned long *table, int kernel)
 
 	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
-		if (kernel)
-			pagetable_free(ptdesc);
-		else if (folio_test_clear_active(ptdesc_folio(ptdesc)))
-			call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
-		else
+		if (kernel || !folio_test_clear_active(ptdesc_folio(ptdesc)))
 			pte_free_now(&ptdesc->pt_rcu_head);
+		else
+			call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
 	}
 }
 
-- 
2.47.0


