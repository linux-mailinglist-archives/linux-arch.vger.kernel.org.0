Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8E17D36F
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgCHKzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 06:55:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11034 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbgCHKzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 06:55:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 028Ar4Qf118252
        for <linux-arch@vger.kernel.org>; Sun, 8 Mar 2020 06:55:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7a9k4m0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 08 Mar 2020 06:55:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 8 Mar 2020 10:54:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Mar 2020 10:54:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 028AsnRP44826770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Mar 2020 10:54:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349C4A4054;
        Sun,  8 Mar 2020 10:54:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0A2BA4060;
        Sun,  8 Mar 2020 10:54:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.7])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  8 Mar 2020 10:54:45 +0000 (GMT)
Date:   Sun, 8 Mar 2020 12:54:44 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: [PATCH v3 07/14] powerpc/32: drop get_pteptr()
References: <20200227084608.18223-1-rppt@kernel.org>
 <20200227084608.18223-8-rppt@kernel.org>
 <20200306200016.6f3865ada0daa68b645fe5d7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306200016.6f3865ada0daa68b645fe5d7@linux-foundation.org>
X-TM-AS-GCONF: 00
x-cbid: 20030810-4275-0000-0000-000003A97260
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030810-4276-0000-0000-000038BE86D2
Message-Id: <20200308105444.GE13982@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-08_03:2020-03-06,2020-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=5
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003080084
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 08:00:16PM -0800, Andrew Morton wrote:
> On Thu, 27 Feb 2020 10:46:01 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Commit 8d30c14cab30 ("powerpc/mm: Rework I$/D$ coherency (v3)") and
> > commit 90ac19a8b21b ("[POWERPC] Abolish iopa(), mm_ptov(),
> > io_block_mapping() from arch/powerpc") removed the use of get_pteptr()
> > outside of mm/pgtable_32.c
> > 
> > In mm/pgtable_32.c, the only user of get_pteptr() is __change_page_attr()
> > which operates on kernel context and on lowmem pages only.
> > 
> > Move page table traversal to __change_page_attr() and drop get_pteptr().
> 
> People have been changing things in linux-next and the powerpc patches
> are hurting.
> 
> I'll disable this patch series for now.  Can you please redo
> powerpc-32-drop-get_pteptr.patch and
> powerpc-add-support-for-folded-p4d-page-tables.patch (and
> powerpc-add-support-for-folded-p4d-page-tables-fix.patch)?
 
This is the powerpc-add-support-for-folded-p4d-page-tables.patch on top of
current powerpc/next. The powerpc-32-drop-get_pteptr.patch is already there
and I've folded powerpc-add-support-for-folded-p4d-page-tables-fix.patch
into this one.

From e2b405537d917c99430ee93b68fe4cb43d7b8787 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Sun, 24 Nov 2019 15:38:00 +0200
Subject: [PATCH v4] powerpc: add support for folded p4d page tables

Implement primitives necessary for the 4th level folding, add walks of p4d
level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # 8xx and 83xx
---
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
 arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 60 ++++++++++---------
 arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
 arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
 .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
 arch/powerpc/include/asm/pgtable.h            | 10 ++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c        | 32 ++++++----
 arch/powerpc/lib/code-patching.c              |  7 ++-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 26 +++++---
 arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
 arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
 arch/powerpc/mm/kasan/kasan_init_32.c         |  1 -
 arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 ++---
 arch/powerpc/mm/pgtable.c                     | 30 ++++++----
 arch/powerpc/mm/pgtable_64.c                  | 10 ++--
 arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
 arch/powerpc/mm/ptdump/ptdump.c               | 14 +++--
 arch/powerpc/xmon/xmon.c                      | 18 +++---
 23 files changed, 197 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7549393c4c43..6052b72216a6 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
 #define _ASM_POWERPC_BOOK3S_32_PGTABLE_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 
 #include <asm/book3s/32/hash.h>
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 2781ebf6add4..876d1528c2cf 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -134,9 +134,9 @@ static inline int get_region_id(unsigned long ea)
 
 #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
 #define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
-static inline int hash__pgd_bad(pgd_t pgd)
+static inline int hash__p4d_bad(p4d_t p4d)
 {
-	return (pgd_val(pgd) == 0);
+	return (p4d_val(p4d) == 0);
 }
 #ifdef CONFIG_STRICT_KERNEL_RWX
 extern void hash__mark_rodata_ro(void);
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index a41e91bd0580..69c5b051734f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -85,9 +85,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *pgd, pud_t *pud)
 {
-	*pgd =  __pgd(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
+	*pgd =  __p4d(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 201a69e6a355..fa60e8594b9f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 
-#include <asm-generic/5level-fixup.h>
+#include <asm-generic/pgtable-nop4d.h>
 
 #ifndef __ASSEMBLY__
 #include <linux/mmdebug.h>
@@ -251,7 +251,7 @@ extern unsigned long __pmd_frag_size_shift;
 /* Bits to mask out from a PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0xc0000000000000ffUL
 /* Bits to mask out from a PGD to get to the PUD page */
-#define PGD_MASKED_BITS		0xc0000000000000ffUL
+#define P4D_MASKED_BITS		0xc0000000000000ffUL
 
 /*
  * Used as an indicator for rcu callback functions
@@ -949,54 +949,60 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
 	return pte_access_permitted(pud_pte(pud), write);
 }
 
-#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
+#define __p4d_raw(x)	((p4d_t) { __pgd_raw(x) })
+static inline __be64 p4d_raw(p4d_t x)
+{
+	return pgd_raw(x.pgd);
+}
+
+#define p4d_write(p4d)		pte_write(p4d_pte(p4d))
 
-static inline void pgd_clear(pgd_t *pgdp)
+static inline void p4d_clear(p4d_t *p4dp)
 {
-	*pgdp = __pgd(0);
+	*p4dp = __p4d(0);
 }
 
-static inline int pgd_none(pgd_t pgd)
+static inline int p4d_none(p4d_t p4d)
 {
-	return !pgd_raw(pgd);
+	return !p4d_raw(p4d);
 }
 
-static inline int pgd_present(pgd_t pgd)
+static inline int p4d_present(p4d_t p4d)
 {
-	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
+	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PRESENT));
 }
 
-static inline pte_t pgd_pte(pgd_t pgd)
+static inline pte_t p4d_pte(p4d_t p4d)
 {
-	return __pte_raw(pgd_raw(pgd));
+	return __pte_raw(p4d_raw(p4d));
 }
 
-static inline pgd_t pte_pgd(pte_t pte)
+static inline p4d_t pte_p4d(pte_t pte)
 {
-	return __pgd_raw(pte_raw(pte));
+	return __p4d_raw(pte_raw(pte));
 }
 
-static inline int pgd_bad(pgd_t pgd)
+static inline int p4d_bad(p4d_t p4d)
 {
 	if (radix_enabled())
-		return radix__pgd_bad(pgd);
-	return hash__pgd_bad(pgd);
+		return radix__p4d_bad(p4d);
+	return hash__p4d_bad(p4d);
 }
 
-#define pgd_access_permitted pgd_access_permitted
-static inline bool pgd_access_permitted(pgd_t pgd, bool write)
+#define p4d_access_permitted p4d_access_permitted
+static inline bool p4d_access_permitted(p4d_t p4d, bool write)
 {
-	return pte_access_permitted(pgd_pte(pgd), write);
+	return pte_access_permitted(p4d_pte(p4d), write);
 }
 
-extern struct page *pgd_page(pgd_t pgd);
+extern struct page *p4d_page(p4d_t p4d);
 
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
 #define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
 #define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
-#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
 #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
 #define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
@@ -1010,8 +1016,8 @@ extern struct page *pgd_page(pgd_t pgd);
 
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-#define pud_offset(pgdp, addr)	\
-	(((pud_t *) pgd_page_vaddr(*(pgdp))) + pud_index(addr))
+#define pud_offset(p4dp, addr)	\
+	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
 #define pmd_offset(pudp,addr) \
 	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
 #define pte_offset_kernel(dir,addr) \
@@ -1368,11 +1374,11 @@ static inline bool pud_is_leaf(pud_t pud)
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 }
 
-#define pgd_is_leaf pgd_is_leaf
-#define pgd_leaf pgd_is_leaf
-static inline bool pgd_is_leaf(pgd_t pgd)
+#define p4d_is_leaf p4d_is_leaf
+#define p4d_leaf p4d_is_leaf
+static inline bool p4d_is_leaf(p4d_t p4d)
 {
-	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
+	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PTE));
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index d97db3ad9aae..9bca2ac64220 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -30,7 +30,7 @@
 /* Don't have anything in the reserved bits and leaf bits */
 #define RADIX_PMD_BAD_BITS		0x60000000000000e0UL
 #define RADIX_PUD_BAD_BITS		0x60000000000000e0UL
-#define RADIX_PGD_BAD_BITS		0x60000000000000e0UL
+#define RADIX_P4D_BAD_BITS		0x60000000000000e0UL
 
 #define RADIX_PMD_SHIFT		(PAGE_SHIFT + RADIX_PTE_INDEX_SIZE)
 #define RADIX_PUD_SHIFT		(RADIX_PMD_SHIFT + RADIX_PMD_INDEX_SIZE)
@@ -227,9 +227,9 @@ static inline int radix__pud_bad(pud_t pud)
 }
 
 
-static inline int radix__pgd_bad(pgd_t pgd)
+static inline int radix__p4d_bad(p4d_t p4d)
 {
-	return !!(pgd_val(pgd) & RADIX_PGD_BAD_BITS);
+	return !!(p4d_val(p4d) & RADIX_P4D_BAD_BITS);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b04ba257fddb..3d0bc99dd520 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_POWERPC_NOHASH_32_PGTABLE_H
 #define _ASM_POWERPC_NOHASH_32_PGTABLE_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index b9534a793293..668aee6017e7 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -15,7 +15,7 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
+#define p4d_populate(MM, P4D, PUD)	p4d_set(P4D, (unsigned long)PUD)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index c40ec32b8194..81b1c54e3cf1 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
 #define _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
 
-#include <asm-generic/5level-fixup.h>
+#include <asm-generic/pgtable-nop4d.h>
 
 /*
  * Entries per page directory level.  The PTE level must use a 64b record
@@ -45,41 +45,41 @@
 #define PMD_MASKED_BITS		0
 /* Bits to mask out from a PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0
-/* Bits to mask out from a PGD to get to the PUD page */
-#define PGD_MASKED_BITS		0
+/* Bits to mask out from a P4D to get to the PUD page */
+#define P4D_MASKED_BITS		0
 
 
 /*
  * 4-level page tables related bits
  */
 
-#define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_bad(pgd)		(pgd_val(pgd) == 0)
-#define pgd_present(pgd)	(pgd_val(pgd) != 0)
-#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define p4d_none(p4d)		(!p4d_val(p4d))
+#define p4d_bad(p4d)		(p4d_val(p4d) == 0)
+#define p4d_present(p4d)	(p4d_val(p4d) != 0)
+#define p4d_page_vaddr(p4d)	(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
 #ifndef __ASSEMBLY__
 
-static inline void pgd_clear(pgd_t *pgdp)
+static inline void p4d_clear(p4d_t *p4dp)
 {
-	*pgdp = __pgd(0);
+	*p4dp = __p4d(0);
 }
 
-static inline pte_t pgd_pte(pgd_t pgd)
+static inline pte_t p4d_pte(p4d_t p4d)
 {
-	return __pte(pgd_val(pgd));
+	return __pte(p4d_val(p4d));
 }
 
-static inline pgd_t pte_pgd(pte_t pte)
+static inline p4d_t pte_p4d(pte_t pte)
 {
-	return __pgd(pte_val(pte));
+	return __p4d(pte_val(pte));
 }
-extern struct page *pgd_page(pgd_t pgd);
+extern struct page *p4d_page(p4d_t p4d);
 
 #endif /* !__ASSEMBLY__ */
 
-#define pud_offset(pgdp, addr)	\
-  (((pud_t *) pgd_page_vaddr(*(pgdp))) + \
+#define pud_offset(p4dp, addr)	\
+  (((pud_t *) p4d_page_vaddr(*(p4dp))) + \
     (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 
 #define pud_ERROR(e) \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 9a33b8bd842d..b360f262b9c6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -175,11 +175,11 @@ static inline pud_t pte_pud(pte_t pte)
 	return __pud(pte_val(pte));
 }
 #define pud_write(pud)		pte_write(pud_pte(pud))
-#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
+#define p4d_write(pgd)		pte_write(p4d_pte(p4d))
 
-static inline void pgd_set(pgd_t *pgdp, unsigned long val)
+static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 {
-	*pgdp = __pgd(val);
+	*p4dp = __p4d(val);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b80bfd41828d..8bc1e5c3c7be 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -44,12 +44,12 @@ struct mm_struct;
 #ifdef CONFIG_PPC32
 static inline pmd_t *pmd_ptr(struct mm_struct *mm, unsigned long va)
 {
-	return pmd_offset(pud_offset(pgd_offset(mm, va), va), va);
+	return pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, va), va), va), va);
 }
 
 static inline pmd_t *pmd_ptr_k(unsigned long va)
 {
-	return pmd_offset(pud_offset(pgd_offset_k(va), va), va);
+	return pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), va), va);
 }
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
@@ -156,9 +156,9 @@ static inline bool pud_is_leaf(pud_t pud)
 }
 #endif
 
-#ifndef pgd_is_leaf
-#define pgd_is_leaf pgd_is_leaf
-static inline bool pgd_is_leaf(pgd_t pgd)
+#ifndef p4d_is_leaf
+#define p4d_is_leaf p4d_is_leaf
+static inline bool p4d_is_leaf(p4d_t p4d)
 {
 	return false;
 }
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 1d75ed684b53..ea8a96038bb4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -499,13 +499,14 @@ void kvmppc_free_pgtable_radix(struct kvm *kvm, pgd_t *pgd, unsigned int lpid)
 	unsigned long ig;
 
 	for (ig = 0; ig < PTRS_PER_PGD; ++ig, ++pgd) {
+		p4d_t *p4d = p4d_offset(pgd, 0);
 		pud_t *pud;
 
-		if (!pgd_present(*pgd))
+		if (!p4d_present(*p4d))
 			continue;
-		pud = pud_offset(pgd, 0);
+		pud = pud_offset(p4d, 0);
 		kvmppc_unmap_free_pud(kvm, pud, lpid);
-		pgd_clear(pgd);
+		p4d_clear(p4d);
 	}
 }
 
@@ -566,6 +567,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		      unsigned long *rmapp, struct rmap_nested **n_rmap)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud, *new_pud = NULL;
 	pmd_t *pmd, *new_pmd = NULL;
 	pte_t *ptep, *new_ptep = NULL;
@@ -573,9 +575,11 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 
 	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
 	pgd = pgtable + pgd_index(gpa);
+	p4d = p4d_offset(pgd, gpa);
+
 	pud = NULL;
-	if (pgd_present(*pgd))
-		pud = pud_offset(pgd, gpa);
+	if (p4d_present(*p4d))
+		pud = pud_offset(p4d, gpa);
 	else
 		new_pud = pud_alloc_one(kvm->mm, gpa);
 
@@ -596,13 +600,13 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 
 	/* Now traverse again under the lock and change the tree */
 	ret = -ENOMEM;
-	if (pgd_none(*pgd)) {
+	if (p4d_none(*p4d)) {
 		if (!new_pud)
 			goto out_unlock;
-		pgd_populate(kvm->mm, pgd, new_pud);
+		p4d_populate(kvm->mm, p4d, new_pud);
 		new_pud = NULL;
 	}
-	pud = pud_offset(pgd, gpa);
+	pud = pud_offset(p4d, gpa);
 	if (pud_is_leaf(*pud)) {
 		unsigned long hgpa = gpa & PUD_MASK;
 
@@ -1219,7 +1223,8 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 	unsigned long gpa;
 	pgd_t *pgt;
 	struct kvm_nested_guest *nested;
-	pgd_t pgd, *pgdp;
+	pgd_t *pgdp;
+	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
 	pte_t *ptep;
@@ -1292,13 +1297,14 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		}
 
 		pgdp = pgt + pgd_index(gpa);
-		pgd = READ_ONCE(*pgdp);
-		if (!(pgd_val(pgd) & _PAGE_PRESENT)) {
-			gpa = (gpa & PGDIR_MASK) + PGDIR_SIZE;
+		p4dp = p4d_offset(pgdp, gpa);
+		p4d = READ_ONCE(*p4dp);
+		if (!(p4d_val(p4d) & _PAGE_PRESENT)) {
+			gpa = (gpa & P4D_MASK) + P4D_SIZE;
 			continue;
 		}
 
-		pudp = pud_offset(&pgd, gpa);
+		pudp = pud_offset(&p4d, gpa);
 		pud = READ_ONCE(*pudp);
 		if (!(pud_val(pud) & _PAGE_PRESENT)) {
 			gpa = (gpa & PUD_MASK) + PUD_SIZE;
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 3345f039a876..7a59f6863cec 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -107,13 +107,18 @@ static inline int unmap_patch_area(unsigned long addr)
 	pte_t *ptep;
 	pmd_t *pmdp;
 	pud_t *pudp;
+	p4d_t *p4dp;
 	pgd_t *pgdp;
 
 	pgdp = pgd_offset_k(addr);
 	if (unlikely(!pgdp))
 		return -EINVAL;
 
-	pudp = pud_offset(pgdp, addr);
+	p4dp = p4d_offset(pgdp, addr);
+	if (unlikely(!p4dp))
+		return -EINVAL;
+
+	pudp = pud_offset(p4dp, addr);
 	if (unlikely(!pudp))
 		return -EINVAL;
 
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 64733b9cb20a..9cd15937e88a 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -148,6 +148,7 @@ void hash__vmemmap_remove_mapping(unsigned long start,
 int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -155,7 +156,8 @@ int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 	BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
 	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
-		pudp = pud_alloc(&init_mm, pgdp, ea);
+		p4dp = p4d_offset(pgdp, ea);
+		pudp = pud_alloc(&init_mm, p4dp, ea);
 		if (!pudp)
 			return -ENOMEM;
 		pmdp = pmd_alloc(&init_mm, pudp, ea);
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index dd1bea45325c..fc3d0b0460b0 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -64,17 +64,19 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
 {
 	unsigned long pfn = pa >> PAGE_SHIFT;
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
 	pgdp = pgd_offset_k(ea);
-	if (pgd_none(*pgdp)) {
+	p4dp = p4d_offset(pgdp, ea);
+	if (p4d_none(*p4dp)) {
 		pudp = early_alloc_pgtable(PUD_TABLE_SIZE, nid,
 						region_start, region_end);
-		pgd_populate(&init_mm, pgdp, pudp);
+		p4d_populate(&init_mm, p4dp, pudp);
 	}
-	pudp = pud_offset(pgdp, ea);
+	pudp = pud_offset(p4dp, ea);
 	if (map_page_size == PUD_SIZE) {
 		ptep = (pte_t *)pudp;
 		goto set_the_pte;
@@ -114,6 +116,7 @@ static int __map_kernel_page(unsigned long ea, unsigned long pa,
 {
 	unsigned long pfn = pa >> PAGE_SHIFT;
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -136,7 +139,8 @@ static int __map_kernel_page(unsigned long ea, unsigned long pa,
 	 * boot.
 	 */
 	pgdp = pgd_offset_k(ea);
-	pudp = pud_alloc(&init_mm, pgdp, ea);
+	p4dp = p4d_offset(pgdp, ea);
+	pudp = pud_alloc(&init_mm, p4dp, ea);
 	if (!pudp)
 		return -ENOMEM;
 	if (map_page_size == PUD_SIZE) {
@@ -173,6 +177,7 @@ void radix__change_memory_range(unsigned long start, unsigned long end,
 {
 	unsigned long idx;
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -185,7 +190,8 @@ void radix__change_memory_range(unsigned long start, unsigned long end,
 
 	for (idx = start; idx < end; idx += PAGE_SIZE) {
 		pgdp = pgd_offset_k(idx);
-		pudp = pud_alloc(&init_mm, pgdp, idx);
+		p4dp = p4d_offset(pgdp, idx);
+		pudp = pud_alloc(&init_mm, p4dp, idx);
 		if (!pudp)
 			continue;
 		if (pud_is_leaf(*pudp)) {
@@ -847,6 +853,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 	unsigned long addr, next;
 	pud_t *pud_base;
 	pgd_t *pgd;
+	p4d_t *p4d;
 
 	spin_lock(&init_mm.page_table_lock);
 
@@ -854,15 +861,16 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 		next = pgd_addr_end(addr, end);
 
 		pgd = pgd_offset_k(addr);
-		if (!pgd_present(*pgd))
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_present(*p4d))
 			continue;
 
-		if (pgd_is_leaf(*pgd)) {
-			split_kernel_mapping(addr, end, PGDIR_SIZE, (pte_t *)pgd);
+		if (p4d_is_leaf(*p4d)) {
+			split_kernel_mapping(addr, end, P4D_SIZE, (pte_t *)p4d);
 			continue;
 		}
 
-		pud_base = (pud_t *)pgd_page_vaddr(*pgd);
+		pud_base = (pud_t *)p4d_page_vaddr(*p4d);
 		remove_pud_table(pud_base, addr, next);
 	}
 
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 2ef24a53f4c9..25a0c044bd93 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -54,15 +54,17 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 			     int npages)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
 
 	pgd = pgd_offset(mm, addr);
-	if (pgd_none(*pgd))
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
 		return;
-	pud = pud_offset(pgd, addr);
+	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud))
 		return;
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 73d4873fc7f8..43d463f20fc3 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -112,6 +112,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	pgd_t *pg;
+	p4d_t *p4;
 	pud_t *pu;
 	pmd_t *pm;
 	hugepd_t *hpdp = NULL;
@@ -121,20 +122,21 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 	addr &= ~(sz-1);
 	pg = pgd_offset(mm, addr);
+	p4 = p4d_offset(pg, addr);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (pshift == PGDIR_SHIFT)
 		/* 16GB huge page */
-		return (pte_t *) pg;
+		return (pte_t *) p4;
 	else if (pshift > PUD_SHIFT) {
 		/*
 		 * We need to use hugepd table
 		 */
 		ptl = &mm->page_table_lock;
-		hpdp = (hugepd_t *)pg;
+		hpdp = (hugepd_t *)p4;
 	} else {
 		pdshift = PUD_SHIFT;
-		pu = pud_alloc(mm, pg, addr);
+		pu = pud_alloc(mm, p4, addr);
 		if (!pu)
 			return NULL;
 		if (pshift == PUD_SHIFT)
@@ -159,10 +161,10 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 #else
 	if (pshift >= PGDIR_SHIFT) {
 		ptl = &mm->page_table_lock;
-		hpdp = (hugepd_t *)pg;
+		hpdp = (hugepd_t *)p4;
 	} else {
 		pdshift = PUD_SHIFT;
-		pu = pud_alloc(mm, pg, addr);
+		pu = pud_alloc(mm, p4, addr);
 		if (!pu)
 			return NULL;
 		if (pshift >= PUD_SHIFT) {
@@ -384,7 +386,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	mm_dec_nr_pmds(tlb->mm);
 }
 
-static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 				   unsigned long addr, unsigned long end,
 				   unsigned long floor, unsigned long ceiling)
 {
@@ -394,7 +396,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 
 	start = addr;
 	do {
-		pud = pud_offset(pgd, addr);
+		pud = pud_offset(p4d, addr);
 		next = pud_addr_end(addr, end);
 		if (!is_hugepd(__hugepd(pud_val(*pud)))) {
 			if (pud_none_or_clear_bad(pud))
@@ -429,8 +431,8 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 	if (end - 1 > ceiling - 1)
 		return;
 
-	pud = pud_offset(pgd, start);
-	pgd_clear(pgd);
+	pud = pud_offset(p4d, start);
+	p4d_clear(p4d);
 	pud_free_tlb(tlb, pud, start);
 	mm_dec_nr_puds(tlb->mm);
 }
@@ -443,6 +445,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 			    unsigned long floor, unsigned long ceiling)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	unsigned long next;
 
 	/*
@@ -465,10 +468,11 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	do {
 		next = pgd_addr_end(addr, end);
 		pgd = pgd_offset(tlb->mm, addr);
+		p4d = p4d_offset(pgd, addr);
 		if (!is_hugepd(__hugepd(pgd_val(*pgd)))) {
-			if (pgd_none_or_clear_bad(pgd))
+			if (p4d_none_or_clear_bad(p4d))
 				continue;
-			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+			hugetlb_free_pud_range(tlb, p4d, addr, next, floor, ceiling);
 		} else {
 			unsigned long more;
 			/*
@@ -481,7 +485,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 			if (more > next)
 				next = more;
 
-			free_hugepd_range(tlb, (hugepd_t *)pgd, PGDIR_SHIFT,
+			free_hugepd_range(tlb, (hugepd_t *)p4d, PGDIR_SHIFT,
 					  addr, next, floor, ceiling);
 		}
 	} while (addr = next, addr != end);
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index b195d085970a..c823f294ecf0 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -37,7 +37,6 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 	pte_t *new = NULL;
 
 	pmd = pmd_ptr_k(k_start);
-
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
 		k_next = pgd_addr_end(k_cur, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
index 4637fdd469cf..77884e24281d 100644
--- a/arch/powerpc/mm/nohash/book3e_pgtable.c
+++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
@@ -73,6 +73,7 @@ static void __init *early_alloc_pgtable(unsigned long size)
 int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -80,7 +81,8 @@ int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 	BUILD_BUG_ON(TASK_SIZE_USER64 > PGTABLE_RANGE);
 	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
-		pudp = pud_alloc(&init_mm, pgdp, ea);
+		p4dp = p4d_offset(pgdp, ea);
+		pudp = pud_alloc(&init_mm, p4dp, ea);
 		if (!pudp)
 			return -ENOMEM;
 		pmdp = pmd_alloc(&init_mm, pudp, ea);
@@ -91,13 +93,12 @@ int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 			return -ENOMEM;
 	} else {
 		pgdp = pgd_offset_k(ea);
-#ifndef __PAGETABLE_PUD_FOLDED
-		if (pgd_none(*pgdp)) {
-			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
-			pgd_populate(&init_mm, pgdp, pudp);
+		p4dp = p4d_offset(pgdp, ea);
+		if (p4d_none(*p4dp)) {
+			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
+			p4d_populate(&init_mm, p4dp, pmdp);
 		}
-#endif /* !__PAGETABLE_PUD_FOLDED */
-		pudp = pud_offset(pgdp, ea);
+		pudp = pud_offset(p4dp, ea);
 		if (pud_none(*pudp)) {
 			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
 			pud_populate(&init_mm, pudp, pmdp);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index e3759b69f81b..c2499271f6c1 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -265,6 +265,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
@@ -272,7 +273,9 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 		return;
 	pgd = mm->pgd + pgd_index(addr);
 	BUG_ON(pgd_none(*pgd));
-	pud = pud_offset(pgd, addr);
+	p4d = p4d_offset(pgd, addr);
+	BUG_ON(p4d_none(*p4d));
+	pud = pud_offset(p4d, addr);
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
 	/*
@@ -312,12 +315,13 @@ EXPORT_SYMBOL_GPL(vmalloc_to_phys);
 pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			bool *is_thp, unsigned *hpage_shift)
 {
-	pgd_t pgd, *pgdp;
+	pgd_t *pgdp;
+	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
 	pte_t *ret_pte;
 	hugepd_t *hpdp = NULL;
-	unsigned pdshift = PGDIR_SHIFT;
+	unsigned pdshift;
 
 	if (hpage_shift)
 		*hpage_shift = 0;
@@ -325,24 +329,28 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	if (is_thp)
 		*is_thp = false;
 
-	pgdp = pgdir + pgd_index(ea);
-	pgd  = READ_ONCE(*pgdp);
 	/*
 	 * Always operate on the local stack value. This make sure the
 	 * value don't get updated by a parallel THP split/collapse,
 	 * page fault or a page unmap. The return pte_t * is still not
 	 * stable. So should be checked there for above conditions.
+	 * Top level is an exception because it is folded into p4d.
 	 */
-	if (pgd_none(pgd))
+	pgdp = pgdir + pgd_index(ea);
+	p4dp = p4d_offset(pgdp, ea);
+	p4d  = READ_ONCE(*p4dp);
+	pdshift = P4D_SHIFT;
+
+	if (p4d_none(p4d))
 		return NULL;
 
-	if (pgd_is_leaf(pgd)) {
-		ret_pte = (pte_t *)pgdp;
+	if (p4d_is_leaf(p4d)) {
+		ret_pte = (pte_t *)p4dp;
 		goto out;
 	}
 
-	if (is_hugepd(__hugepd(pgd_val(pgd)))) {
-		hpdp = (hugepd_t *)&pgd;
+	if (is_hugepd(__hugepd(p4d_val(p4d)))) {
+		hpdp = (hugepd_t *)&p4d;
 		goto out_huge;
 	}
 
@@ -352,7 +360,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	 * irq disabled
 	 */
 	pdshift = PUD_SHIFT;
-	pudp = pud_offset(&pgd, ea);
+	pudp = pud_offset(&p4d, ea);
 	pud  = READ_ONCE(*pudp);
 
 	if (pud_none(pud))
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e78832dce7bb..1f86a88fd4bb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -101,13 +101,13 @@ EXPORT_SYMBOL(__pte_frag_size_shift);
 
 #ifndef __PAGETABLE_PUD_FOLDED
 /* 4 level page table */
-struct page *pgd_page(pgd_t pgd)
+struct page *p4d_page(p4d_t p4d)
 {
-	if (pgd_is_leaf(pgd)) {
-		VM_WARN_ON(!pgd_huge(pgd));
-		return pte_page(pgd_pte(pgd));
+	if (p4d_is_leaf(p4d)) {
+		VM_WARN_ON(!p4d_huge(p4d));
+		return pte_page(p4d_pte(p4d));
 	}
-	return virt_to_page(pgd_page_vaddr(pgd));
+	return virt_to_page(p4d_page_vaddr(p4d));
 }
 #endif
 
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index b6ed9578382f..6aaeb1eb3b9c 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -417,9 +417,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 	}
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
 {
-	pud_t *pud = pud_offset(pgd, 0);
+	pud_t *pud = pud_offset(p4d, 0);
 	unsigned long addr;
 	unsigned int i;
 
@@ -431,6 +431,20 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 	}
 }
 
+static void walk_p4d(struct pg_state *st, pgd_t *pgd, unsigned long start)
+{
+	p4d_t *p4d = p4d_offset(pgd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_P4D; i++, p4d++) {
+		addr = start + i * P4D_SIZE;
+		if (!p4d_none(*p4d))
+			/* p4d exists */
+			walk_pud(st, p4d, addr);
+	}
+}
+
 static void walk_pagetables(struct pg_state *st)
 {
 	pgd_t *pgd = pgd_offset_k(0UL);
@@ -445,7 +459,7 @@ static void walk_pagetables(struct pg_state *st)
 		addr = KERN_VIRT_START + i * PGDIR_SIZE;
 		if (!pgd_none(*pgd))
 			/* pgd exists */
-			walk_pud(st, pgd, addr);
+			walk_p4d(st, pgd, addr);
 	}
 }
 
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index d92bb8ea229c..507cb9793b26 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -277,9 +277,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 	}
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
 {
-	pud_t *pud = pud_offset(pgd, 0);
+	pud_t *pud = pud_offset(p4d, 0);
 	unsigned long addr;
 	unsigned int i;
 
@@ -304,11 +304,13 @@ static void walk_pagetables(struct pg_state *st)
 	 * the hash pagetable.
 	 */
 	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
-		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
-			/* pgd exists */
-			walk_pud(st, pgd, addr);
+		p4d_t *p4d = p4d_offset(pgd, 0);
+
+		if (!p4d_none(*p4d) && !p4d_is_leaf(*p4d))
+			/* p4d exists */
+			walk_pud(st, p4d, addr);
 		else
-			note_page(st, addr, 1, pgd_val(*pgd));
+			note_page(st, addr, 1, p4d_val(*p4d));
 	}
 }
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e8c84d265602..0e1cc7275566 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3130,6 +3130,7 @@ static void show_pte(unsigned long addr)
 	struct task_struct *tsk = NULL;
 	struct mm_struct *mm;
 	pgd_t *pgdp, *pgdir;
+	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -3161,20 +3162,21 @@ static void show_pte(unsigned long addr)
 		pgdir = pgd_offset(mm, 0);
 	}
 
-	if (pgd_none(*pgdp)) {
-		printf("no linux page table for address\n");
+	p4dp = p4d_offset(pgdp, addr);
+
+	if (p4d_none(*p4dp)) {
+		printf("No valid P4D\n");
 		return;
 	}
 
-	printf("pgd  @ 0x%px\n", pgdir);
-
-	if (pgd_is_leaf(*pgdp)) {
-		format_pte(pgdp, pgd_val(*pgdp));
+	if (p4d_is_leaf(*p4dp)) {
+		format_pte(p4dp, p4d_val(*p4dp));
 		return;
 	}
-	printf("pgdp @ 0x%px = 0x%016lx\n", pgdp, pgd_val(*pgdp));
 
-	pudp = pud_offset(pgdp, addr);
+	printf("p4dp @ 0x%px = 0x%016lx\n", p4dp, p4d_val(*p4dp));
+
+	pudp = pud_offset(p4dp, addr);
 
 	if (pud_none(*pudp)) {
 		printf("No valid PUD\n");
-- 
2.25.1

