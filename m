Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBD3610EB
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhDORSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 13:18:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13545 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhDORSm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 13:18:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FLmJT5JSZz9twp1;
        Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l2Wp58dxZgKV; Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FLmJT4SFtz9twp0;
        Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57C5C8B804;
        Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TH1aHRUvkNOs; Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2B8A8B7F6;
        Thu, 15 Apr 2021 19:18:16 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8FC1E679F6; Thu, 15 Apr 2021 17:18:16 +0000 (UTC)
Message-Id: <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Date:   Thu, 15 Apr 2021 17:18:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to support large pages on powerpc, notepage()
needs to know the page size of the page.

Add a page_size argument to notepage().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/mm/ptdump.c         |  2 +-
 arch/riscv/mm/ptdump.c         |  2 +-
 arch/s390/mm/dump_pagetables.c |  3 ++-
 arch/x86/mm/dump_pagetables.c  |  2 +-
 include/linux/ptdump.h         |  2 +-
 mm/ptdump.c                    | 16 ++++++++--------
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 0e050d76b83a..ea1a1c3a3ea0 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -257,7 +257,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+		      u64 val, unsigned long page_size)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	static const char units[] = "KMGTPE";
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index ace74dec7492..0a7f276ba799 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -235,7 +235,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page(struct ptdump_state *pt_st, unsigned long addr,
-		      int level, u64 val)
+		      int level, u64 val, unsigned long page_size)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index e40a30647d99..29673c38e773 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -116,7 +116,8 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 #endif /* CONFIG_DEBUG_WX */
 }
 
-static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level, u64 val)
+static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
+		      u64 val, unsigned long page_size)
 {
 	int width = sizeof(unsigned long) * 2;
 	static const char units[] = "KMGTPE";
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..2ec76737c1f1 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -272,7 +272,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
  * print what we collected so far.
  */
 static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
-		      u64 val)
+		      u64 val, unsigned long page_size)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	pgprotval_t new_prot, new_eff;
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 2a3a95586425..3a971fadc95e 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -13,7 +13,7 @@ struct ptdump_range {
 struct ptdump_state {
 	/* level is 0:PGD to 4:PTE, or -1 if unknown */
 	void (*note_page)(struct ptdump_state *st, unsigned long addr,
-			  int level, u64 val);
+			  int level, u64 val, unsigned long page_size);
 	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
 	const struct ptdump_range *range;
 };
diff --git a/mm/ptdump.c b/mm/ptdump.c
index da751448d0e4..61cd16afb1c8 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -17,7 +17,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
 {
 	struct ptdump_state *st = walk->private;
 
-	st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]));
+	st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]), PAGE_SIZE);
 
 	walk->action = ACTION_CONTINUE;
 
@@ -41,7 +41,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 		st->effective_prot(st, 0, pgd_val(val));
 
 	if (pgd_leaf(val))
-		st->note_page(st, addr, 0, pgd_val(val));
+		st->note_page(st, addr, 0, pgd_val(val), PGDIR_SIZE);
 
 	return 0;
 }
@@ -62,7 +62,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 		st->effective_prot(st, 1, p4d_val(val));
 
 	if (p4d_leaf(val))
-		st->note_page(st, addr, 1, p4d_val(val));
+		st->note_page(st, addr, 1, p4d_val(val), P4D_SIZE);
 
 	return 0;
 }
@@ -83,7 +83,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 		st->effective_prot(st, 2, pud_val(val));
 
 	if (pud_leaf(val))
-		st->note_page(st, addr, 2, pud_val(val));
+		st->note_page(st, addr, 2, pud_val(val), PUD_SIZE);
 
 	return 0;
 }
@@ -102,7 +102,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
 	if (pmd_leaf(val))
-		st->note_page(st, addr, 3, pmd_val(val));
+		st->note_page(st, addr, 3, pmd_val(val), PMD_SIZE);
 
 	return 0;
 }
@@ -116,7 +116,7 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 4, pte_val(val));
 
-	st->note_page(st, addr, 4, pte_val(val));
+	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
 
 	return 0;
 }
@@ -126,7 +126,7 @@ static int ptdump_hole(unsigned long addr, unsigned long next,
 {
 	struct ptdump_state *st = walk->private;
 
-	st->note_page(st, addr, depth, 0);
+	st->note_page(st, addr, depth, 0, 0);
 
 	return 0;
 }
@@ -153,5 +153,5 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 	mmap_read_unlock(mm);
 
 	/* Flush out the last page */
-	st->note_page(st, 0, -1, 0);
+	st->note_page(st, 0, -1, 0, 0);
 }
-- 
2.25.0

