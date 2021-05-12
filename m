Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F037B566
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhELFVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 01:21:33 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36271 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhELFVd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 May 2021 01:21:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fg2gN39fvz9sf6;
        Wed, 12 May 2021 07:01:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w1RGZNF_GKyD; Wed, 12 May 2021 07:01:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg2gN238Rz9sdw;
        Wed, 12 May 2021 07:01:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5C878B7D6;
        Wed, 12 May 2021 07:01:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fIl-CQcZAHcL; Wed, 12 May 2021 07:01:03 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EA098B769;
        Wed, 12 May 2021 07:01:03 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E55FE64164; Wed, 12 May 2021 05:01:02 +0000 (UTC)
Message-Id: <8b972f1c03fb6bd59953035f0a3e4d26659de4f8.1620795204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1620795204.git.christophe.leroy@csgroup.eu>
References: <cover.1620795204.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/8xx: Add support for huge pages on VMAP and
 VMALLOC
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 May 2021 05:01:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc 8xx has 4 page sizes:
- 4k
- 16k
- 512k
- 8M

At the time being, vmalloc and vmap only support huge pages which are
leaf at PMD level.

Here the PMD level is 4M, it doesn't correspond to any supported
page size.

For now, implement use of 16k and 512k pages which is done
at PTE level.

Support of 8M pages will be implemented later, it requires vmalloc to
support hugepd tables.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 43 ++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2afcfe4..ce3f59531b51 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -187,7 +187,7 @@ config PPC
 	select GENERIC_VDSO_TIME_NS
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
-	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 6e4faa0a9b35..997cec973406 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -178,6 +178,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/mmdebug.h>
+#include <linux/sizes.h>
 
 void mmu_pin_tlb(unsigned long top, bool readonly);
 
@@ -225,6 +226,48 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 	BUG();
 }
 
+static inline bool arch_vmap_try_size(unsigned long addr, unsigned long end, u64 pfn,
+				      unsigned int max_page_shift, unsigned long size)
+{
+	if (end - addr < size)
+		return false;
+
+	if ((1UL << max_page_shift) < size)
+		return false;
+
+	if (!IS_ALIGNED(addr, size))
+		return false;
+
+	if (!IS_ALIGNED(PFN_PHYS(pfn), size))
+		return false;
+
+	return true;
+}
+
+static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
+							 u64 pfn, unsigned int max_page_shift)
+{
+	if (arch_vmap_try_size(addr, end, pfn, max_page_shift, SZ_512K))
+		return SZ_512K;
+	if (PAGE_SIZE == SZ_16K)
+		return SZ_16K;
+	if (arch_vmap_try_size(addr, end, pfn, max_page_shift, SZ_16K))
+		return SZ_16K;
+	return PAGE_SIZE;
+}
+#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
+
+static inline int arch_vmap_pte_supported_shift(unsigned long size)
+{
+	if (size >= SZ_512K)
+		return 19;
+	else if (size >= SZ_16K)
+		return 14;
+	else
+		return PAGE_SHIFT;
+}
+#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
+
 /* patch sites */
 extern s32 patch__itlbmiss_exit_1, patch__dtlbmiss_exit_1;
 extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
-- 
2.25.0

