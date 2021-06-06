Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A939CE4E
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFFJHi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhFFJH1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C7861426;
        Sun,  6 Jun 2021 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970338;
        bh=qph7YI4bBELR4x3cH34m49m6VFlBeHt4WLSEim7zato=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uet+WCvoJuyWL0SFrd+1jc6Ilaj8YMQJHj1VWC39aPQPAR+SPjI1wrb7V8fb3fGh2
         MEB9ca1PE+TXAUNVnNV+22vcxI8/Aup5ue6UqIY9NcIfDUHC/pYiKDcvW8Bg17F98s
         2fO0OdAMZbh8VkNxMEbWm4fdnEn6yMA0IjK1oZQYrhRB73d/9G8LS1U7f+ZJxGFVKu
         ZqlIa8doFRapqKvNgCpGpw7NMHzRNu3cSBtDvH2WammdZLv0pYh/EudHQi7Q0bq/OM
         gVN6DKpvmO5B14prT9gTCYwAFoKWE3OVODc8VPoIEeHbdWqoU91glJiqloi3KAOnEf
         JnIQ2NHuhBKcw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: [RFC PATCH v2 08/11] riscv: cmo: Add vendor custom icache sync
Date:   Sun,  6 Jun 2021 09:04:06 +0000
Message-Id: <1622970249-50770-12-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

It's a draft version to show you how T-HEAD C9xx work with the
icache sync (We use hardware broadcast mechanism, and our icache
is VIPT):
 - icache.i(v/p)a will broadcast all harts' icache invalidtion
 - sync.is will broadcast all harts' pipeline flush and ensure all
   broadcasts finished.

This patch could improve the performance of OpenJDK on JIT and
reduce flush_icache_all in linux.

Epecially:
static inline void set_pte_at(struct mm_struct *mm,
        unsigned long addr, pte_t *ptep, pte_t pteval)
{
	if (pte_present(pteval) && pte_exec(pteval))
		flush_icache_pte(pteval);

	set_pte(ptep, pteval);
}

Different from sbi_dma_sync, it can't be hidden in SBI and we must
set up a framework to hold all vendors' implementations in
linux/arch/riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/include/asm/cacheflush.h   | 48 ++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/vdso/flush_icache.S | 33 +++++++++++++++++++-----
 arch/riscv/mm/cacheflush.c            |  3 ++-
 3 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 23ff703..2e2dba1 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -22,11 +22,57 @@ static inline void flush_dcache_page(struct page *page)
 }
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
+#define ICACHE_IPA_X5   ".long 0x0382800b"
+#define ICACHE_IVA_X5   ".long 0x0302800b"
+#define SYNC_IS         ".long 0x01b0000b"
+
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	register unsigned long tmp asm("x5") = start & (~(L1_CACHE_BYTES-1));
+
+	for (; tmp < ALIGN(end, L1_CACHE_BYTES); tmp += L1_CACHE_BYTES) {
+		__asm__ __volatile__ (
+				ICACHE_IVA_X5
+				:
+				: "r" (tmp)
+				: "memory");
+	}
+
+	__asm__ __volatile__(SYNC_IS);
+
+	return;
+}
+
+static inline void flush_icache_range_phy(unsigned long start, unsigned long end)
+{
+	register unsigned long tmp asm("x5") = start & (~(L1_CACHE_BYTES-1));
+
+	for (; tmp < ALIGN(end, L1_CACHE_BYTES); tmp += L1_CACHE_BYTES) {
+		__asm__ __volatile__ (
+				ICACHE_IPA_X5
+				:
+				: "r" (tmp)
+				: "memory");
+	}
+
+	__asm__ __volatile__(SYNC_IS);
+
+	return;
+}
+
+static inline void __flush_icache_page(struct page *page) {
+	unsigned long start = PFN_PHYS(page_to_pfn(page));
+
+	flush_icache_range_phy(start, start + PAGE_SIZE);
+
+	return;
+}
+
 /*
  * RISC-V doesn't have an instruction to flush parts of the instruction cache,
  * so instead we just flush the whole thing.
  */
-#define flush_icache_range(start, end) flush_icache_all()
+#define flush_icache_range(start, end) flush_icache_range(start, end)
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vdso/flush_icache.S
index 82f97d6..efb2d2e 100644
--- a/arch/riscv/kernel/vdso/flush_icache.S
+++ b/arch/riscv/kernel/vdso/flush_icache.S
@@ -5,18 +5,39 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/cache.h>
+
+/*
+ * icache.ipa rs1
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    11000      rs1       000      00000  0001011
+ *
+ * icache.iva rs1
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    10000      rs1       000      00000  0001011
+ *
+ * sync.is
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11011     00000      000      00000  0001011
+ */
+#define ICACHE_IPA_X5	.long 0x0382800b
+#define ICACHE_IVA_X5	.long 0x0302800b
+#define SYNC_IS		.long 0x01b0000b
 
 	.text
 /* int __vdso_flush_icache(void *start, void *end, unsigned long flags); */
 ENTRY(__vdso_flush_icache)
 	.cfi_startproc
-#ifdef CONFIG_SMP
-	li a7, __NR_riscv_flush_icache
-	ecall
-#else
-	fence.i
+	srli	t0, a0, L1_CACHE_SHIFT
+	slli	t0, t0, L1_CACHE_SHIFT
+	addi	a1, a1, (L1_CACHE_BYTES - 1)
+	srli	a1, a1, L1_CACHE_SHIFT
+	slli	a1, a1, L1_CACHE_SHIFT
+1:	ICACHE_IVA_X5
+	addi	t0, t0, L1_CACHE_BYTES
+	bne	t0, a1, 1b
+	SYNC_IS
 	li a0, 0
-#endif
 	ret
 	.cfi_endproc
 ENDPROC(__vdso_flush_icache)
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 0941186..0fb8344 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/pfn.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -84,6 +85,6 @@ void flush_icache_pte(pte_t pte)
 	struct page *page = pte_page(pte);
 
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
-		flush_icache_all();
+		__flush_icache_page(page);
 }
 #endif /* CONFIG_MMU */
-- 
2.7.4

