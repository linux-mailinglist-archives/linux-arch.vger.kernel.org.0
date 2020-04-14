Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5658F1A833E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440505AbgDNPhd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 11:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440475AbgDNPhQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 11:37:16 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1522085B;
        Tue, 14 Apr 2020 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878636;
        bh=y5upl5y5kDKcOZZTB6xnGHWCDtOJ5v9v3QvgjuKGYnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VU/LlyjuZjD2xgCfZA7m8dLQDTyPj28OI08DI540xTc3wP1fJsitV67hiVVil7eVJ
         aSNmRqUVKgNW+oW2T/ecAsUG7/P9Ym38a5dxBUPtF2JQyqCeN7tx/o7OYsA14TDjOD
         JatvJvEQqBS9dHMIx3mUATBkVLOVSm36w2YSGeaE=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 13/14] asm-generic: remove pgtable-nop4d-hack.h
Date:   Tue, 14 Apr 2020 18:34:54 +0300
Message-Id: <20200414153455.21744-14-rppt@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414153455.21744-1-rppt@kernel.org>
References: <20200414153455.21744-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

No architecture defines __ARCH_USE_5LEVEL_HACK and therefore
pgtable-nop4d-hack.h will be never actually included.

Remove it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/asm-generic/pgtable-nop4d-hack.h | 64 ------------------------
 include/asm-generic/pgtable-nopud.h      |  4 --
 2 files changed, 68 deletions(-)
 delete mode 100644 include/asm-generic/pgtable-nop4d-hack.h

diff --git a/include/asm-generic/pgtable-nop4d-hack.h b/include/asm-generic/pgtable-nop4d-hack.h
deleted file mode 100644
index 829bdb0d6327..000000000000
--- a/include/asm-generic/pgtable-nop4d-hack.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PGTABLE_NOP4D_HACK_H
-#define _PGTABLE_NOP4D_HACK_H
-
-#ifndef __ASSEMBLY__
-#include <asm-generic/5level-fixup.h>
-
-#define __PAGETABLE_PUD_FOLDED 1
-
-/*
- * Having the pud type consist of a pgd gets the size right, and allows
- * us to conceptually access the pgd entry that this pud is folded into
- * without casting.
- */
-typedef struct { pgd_t pgd; } pud_t;
-
-#define PUD_SHIFT	PGDIR_SHIFT
-#define PTRS_PER_PUD	1
-#define PUD_SIZE	(1UL << PUD_SHIFT)
-#define PUD_MASK	(~(PUD_SIZE-1))
-
-/*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pud is never bad, and a pud always exists (as it's folded
- * into the pgd entry)
- */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-static inline void pgd_clear(pgd_t *pgd)	{ }
-#define pud_ERROR(pud)				(pgd_ERROR((pud).pgd))
-
-#define pgd_populate(mm, pgd, pud)		do { } while (0)
-#define pgd_populate_safe(mm, pgd, pud)		do { } while (0)
-/*
- * (puds are folded into pgds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-#define set_pgd(pgdptr, pgdval)	set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
-
-static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
-{
-	return (pud_t *)pgd;
-}
-
-#define pud_val(x)				(pgd_val((x).pgd))
-#define __pud(x)				((pud_t) { __pgd(x) })
-
-#define pgd_page(pgd)				(pud_page((pud_t){ pgd }))
-#define pgd_page_vaddr(pgd)			(pud_page_vaddr((pud_t){ pgd }))
-
-/*
- * allocating and freeing a pud is trivial: the 1-entry pud is
- * inside the pgd, so has no extra memory associated with it.
- */
-#define pud_alloc_one(mm, address)		NULL
-#define pud_free(mm, x)				do { } while (0)
-#define __pud_free_tlb(tlb, x, a)		do { } while (0)
-
-#undef  pud_addr_end
-#define pud_addr_end(addr, end)			(end)
-
-#endif /* __ASSEMBLY__ */
-#endif /* _PGTABLE_NOP4D_HACK_H */
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index d3776cb494c0..ad05c1684bfc 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -4,9 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef __ARCH_USE_5LEVEL_HACK
-#include <asm-generic/pgtable-nop4d-hack.h>
-#else
 #include <asm-generic/pgtable-nop4d.h>
 
 #define __PAGETABLE_PUD_FOLDED 1
@@ -65,5 +62,4 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define pud_addr_end(addr, end)			(end)
 
 #endif /* __ASSEMBLY__ */
-#endif /* !__ARCH_USE_5LEVEL_HACK */
 #endif /* _PGTABLE_NOPUD_H */
-- 
2.25.1

