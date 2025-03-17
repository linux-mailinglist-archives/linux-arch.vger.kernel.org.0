Return-Path: <linux-arch+bounces-10906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A8A652F4
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C79188DA7D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F2242915;
	Mon, 17 Mar 2025 14:21:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97465241CA3;
	Mon, 17 Mar 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221303; cv=none; b=rV7vUCqPWe+4LDZ9n/K4YihPoX5zLbHM1ymfrBhdaGN4ZMX3YMCAldMlny++cOeS6Co2AgMIFPpOu/ETEVouZDAhs5qJWklArrh4cZsWAK1hX3ymJzAPXkTAluFsdJ+xUGqd5MU1KmZjv40mr3iTcoW813cRmCtJgd5GFYnjZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221303; c=relaxed/simple;
	bh=AIOmX96DReFPlzhtOAbuvr12YuLFspc4aJyh2yGNzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaO0dtrIZiv/z6SGxDv+UILqtk+rHv/4Ln+ksLREFl3lldLzhqWAf4ZitlzvbpyWoOpuoz3TanSYdFExbcawjsTo/r6QLDZos9goayszkc+yCNcIc3u5BdOEIBgUGQWAmyTUb7WMPmTtnqUOqfbhS0gRp87Ay8OksvmuiWLQTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF25D22FA;
	Mon, 17 Mar 2025 07:21:48 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78843F63F;
	Mon, 17 Mar 2025 07:21:35 -0700 (PDT)
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
Subject: [PATCH 02/11] mm: Call ctor/dtor for kernel PTEs
Date: Mon, 17 Mar 2025 14:16:51 +0000
Message-ID: <20250317141700.3701581-3-kevin.brodsky@arm.com>
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

Since [1], constructors/destructors are expected to be called for
all page table pages, at all levels and for both user and kernel
pgtables. There is however one glaring exception: kernel PTEs are
managed via separate helpers (pte_alloc_kernel/pte_free_kernel),
which do not call the [cd]tor, at least not in the generic
implementation.

The most obvious reason for this anomaly is that init_mm is
special-cased not to use split page table locks. As a result calling
ptlock_init() for PTEs associated with init_mm would be wasteful,
potentially resulting in dynamic memory allocation. However, pgtable
[cd]tors perform other actions - currently related to
accounting/statistics, and potentially more functionally significant
in the future.

Now that pagetable_pte_ctor() is passed the associated mm, we can
make it skip the call to ptlock_init() for init_mm; this allows us
to call the ctor from pte_alloc_one_kernel() too. This is matched by
a call to the pgtable destructor in pte_free_kernel(); no
special-casing is needed on that path, as ptlock_free() is already
called unconditionally. (ptlock_free() is a no-op unless a ptlock
was allocated for the given PTP.)

This patch ensures that all architectures that rely on
<asm-generic/pgalloc.h> call the [cd]tor for kernel PTEs.
pte_free_kernel() cannot be overridden so changing the generic
implementation is sufficient. pte_alloc_one_kernel() can be
overridden using __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, and a few
architectures implement it by calling the page allocator directly.
We amend those so that they call the generic
__pte_alloc_one_kernel() instead, if possible, ensuring that the
ctor is called.

A few architectures do not use <asm-generic/pgalloc.h>; those will
be taken care of separately.

[1] https://lore.kernel.org/linux-mm/20250103184415.2744423-1-kevin.brodsky@arm.com/

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/csky/include/asm/pgalloc.h | 2 +-
 arch/microblaze/mm/pgtable.c    | 2 +-
 arch/openrisc/mm/ioremap.c      | 2 +-
 include/asm-generic/pgalloc.h   | 7 ++++++-
 include/linux/mm.h              | 2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf8400c28b5a..288dca0d160a 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 	unsigned long i;
 
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	pte = __pte_alloc_one_kernel(mm);
 	if (!pte)
 		return NULL;
 
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 9f73265aad4e..e96dd1b7aba4 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -245,7 +245,7 @@ unsigned long iopa(unsigned long addr)
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	if (mem_init_done)
-		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		return __pte_alloc_one_kernel(mm);
 	else
 		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
 					      MEMBLOCK_LOW_LIMIT,
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 8e63e86251ca..3b352f97fecb 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -36,7 +36,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 
 	if (likely(mem_init_done)) {
-		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
+		pte = __pte_alloc_one_kernel(mm);
 	} else {
 		pte = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
 	}
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index e164ca66f0f6..3c8ec3bfea44 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -23,6 +23,11 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	if (!pagetable_pte_ctor(mm, ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
+
 	return ptdesc_address(ptdesc);
 }
 #define __pte_alloc_one_kernel(...)	alloc_hooks(__pte_alloc_one_kernel_noprof(__VA_ARGS__))
@@ -48,7 +53,7 @@ static inline pte_t *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pagetable_free(virt_to_ptdesc(pte));
+	pagetable_dtor_free(virt_to_ptdesc(pte));
 }
 
 /**
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d92c16f6cfa2..ee31ffd7ead2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3018,7 +3018,7 @@ static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
 static inline bool pagetable_pte_ctor(struct mm_struct *mm,
 				      struct ptdesc *ptdesc)
 {
-	if (!ptlock_init(ptdesc))
+	if (mm != &init_mm && !ptlock_init(ptdesc))
 		return false;
 	__pagetable_ctor(ptdesc);
 	return true;
-- 
2.47.0


