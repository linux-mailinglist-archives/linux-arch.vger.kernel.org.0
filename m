Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6CEBFAA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 09:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKAIlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 04:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfKAIlw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 04:41:52 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8C7217F9;
        Fri,  1 Nov 2019 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572597710;
        bh=0lGj0AI/IfAJbVTLRfdK6fD/lMA7GlT+qoua/5oNwys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDN/oYfqISunxv0VTK/om6jqzJocqdXTriMHJm1P+NqMT6Y/ALN8nHxLQXCfaHkdy
         RtA6uUV+Cw5RB2jOnf2+JpfiCOvEsDzOaFFCeVoBiP0n1wqhVNdYGRlvqk8jsJ7zxI
         uzkR+lXTbzGXzS8RlIb07uxyo4yxqPnB+LhVMVQw=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and include/asm-generic/4level-fixup.h
Date:   Fri,  1 Nov 2019 10:39:44 +0200
Message-Id: <1572597584-6390-14-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572597584-6390-1-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are no architectures that use include/asm-generic/4level-fixup.h
therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/asm-generic/4level-fixup.h | 40 --------------------------------------
 include/asm-generic/tlb.h          |  2 --
 include/linux/mm.h                 | 10 +++++-----
 mm/memory.c                        |  8 --------
 4 files changed, 5 insertions(+), 55 deletions(-)
 delete mode 100644 include/asm-generic/4level-fixup.h

diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
deleted file mode 100644
index e3667c9..0000000
--- a/include/asm-generic/4level-fixup.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _4LEVEL_FIXUP_H
-#define _4LEVEL_FIXUP_H
-
-#define __ARCH_HAS_4LEVEL_HACK
-#define __PAGETABLE_PUD_FOLDED 1
-
-#define PUD_SHIFT			PGDIR_SHIFT
-#define PUD_SIZE			PGDIR_SIZE
-#define PUD_MASK			PGDIR_MASK
-#define PTRS_PER_PUD			1
-
-#define pud_t				pgd_t
-
-#define pmd_alloc(mm, pud, address) \
-	((unlikely(pgd_none(*(pud))) && __pmd_alloc(mm, pud, address))? \
- 		NULL: pmd_offset(pud, address))
-
-#define pud_offset(pgd, start)		(pgd)
-#define pud_none(pud)			0
-#define pud_bad(pud)			0
-#define pud_present(pud)		1
-#define pud_ERROR(pud)			do { } while (0)
-#define pud_clear(pud)			pgd_clear(pud)
-#define pud_val(pud)			pgd_val(pud)
-#define pud_populate(mm, pud, pmd)	pgd_populate(mm, pud, pmd)
-#define pud_page(pud)			pgd_page(pud)
-#define pud_page_vaddr(pud)		pgd_page_vaddr(pud)
-
-#undef pud_free_tlb
-#define pud_free_tlb(tlb, x, addr)	do { } while (0)
-#define pud_free(mm, x)			do { } while (0)
-#define __pud_free_tlb(tlb, x, addr)	do { } while (0)
-
-#undef  pud_addr_end
-#define pud_addr_end(addr, end)		(end)
-
-#include <asm-generic/5level-fixup.h>
-
-#endif
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 04c0644..5e0c2d0 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -584,7 +584,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
-#ifndef __ARCH_HAS_4LEVEL_HACK
 #ifndef pud_free_tlb
 #define pud_free_tlb(tlb, pudp, address)			\
 	do {							\
@@ -594,7 +593,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__pud_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
-#endif
 
 #ifndef __ARCH_HAS_5LEVEL_HACK
 #ifndef p4d_free_tlb
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc29227..477b52a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1850,12 +1850,12 @@ static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
 int __pte_alloc_kernel(pmd_t *pmd);
 
+#if defined(CONFIG_MMU)
+
 /*
- * The following ifdef needed to get the 4level-fixup.h header to work.
- * Remove it when 4level-fixup.h has been removed.
+ * The following ifdef needed to get the 5level-fixup.h header to work.
+ * Remove it when 5level-fixup.h has been removed.
  */
-#if defined(CONFIG_MMU) && !defined(__ARCH_HAS_4LEVEL_HACK)
-
 #ifndef __ARCH_HAS_5LEVEL_HACK
 static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
 		unsigned long address)
@@ -1877,7 +1877,7 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
 		NULL: pmd_offset(pud, address);
 }
-#endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
+#endif /* CONFIG_MMU */
 
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a..50300f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4095,19 +4095,11 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 	smp_wmb(); /* See comment in __pte_alloc */
 
 	ptl = pud_lock(mm, pud);
-#ifndef __ARCH_HAS_4LEVEL_HACK
 	if (!pud_present(*pud)) {
 		mm_inc_nr_pmds(mm);
 		pud_populate(mm, pud, new);
 	} else	/* Another has populated it */
 		pmd_free(mm, new);
-#else
-	if (!pgd_present(*pud)) {
-		mm_inc_nr_pmds(mm);
-		pgd_populate(mm, pud, new);
-	} else /* Another has populated it */
-		pmd_free(mm, new);
-#endif /* __ARCH_HAS_4LEVEL_HACK */
 	spin_unlock(ptl);
 	return 0;
 }
-- 
2.7.4

