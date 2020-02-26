Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC31E16FCB9
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBZK4h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 05:56:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727463AbgBZK4h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 05:56:37 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QAuEES075512
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 05:56:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqbsg0js-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 05:56:34 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@kernel.org>;
        Wed, 26 Feb 2020 10:56:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 10:56:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QAuKhS62390520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 10:56:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89E70A4066;
        Wed, 26 Feb 2020 10:56:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A021A4054;
        Wed, 26 Feb 2020 10:56:17 +0000 (GMT)
Received: from hump (unknown [9.148.207.76])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Feb 2020 10:56:17 +0000 (GMT)
Date:   Wed, 26 Feb 2020 12:56:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
 <c79b363c-a111-389a-5752-51cf85fa8c44@c-s.fr>
 <20200218105440.GA1698@hump>
 <20200226091315.GA11803@hump>
 <f881f732-729b-a098-f520-b30e44dc10c8@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f881f732-729b-a098-f520-b30e44dc10c8@c-s.fr>
X-TM-AS-GCONF: 00
x-cbid: 20022610-0008-0000-0000-000003568EA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022610-0009-0000-0000-00004A77AD25
Message-Id: <20200226105615.GB11803@hump>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_03:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002260083
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 10:46:13AM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/02/2020 à 10:13, Mike Rapoport a écrit :
> > On Tue, Feb 18, 2020 at 12:54:40PM +0200, Mike Rapoport wrote:
> > > On Sun, Feb 16, 2020 at 11:41:07AM +0100, Christophe Leroy wrote:
> > > > 
> > > > 
> > > > Le 16/02/2020 à 09:18, Mike Rapoport a écrit :
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > Implement primitives necessary for the 4th level folding, add walks of p4d
> > > > > level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
> > > > 
> > > > I don't think it is worth adding all this additionnals walks of p4d, this
> > > > patch could be limited to changes like:
> > > > 
> > > > -		pud = pud_offset(pgd, gpa);
> > > > +		pud = pud_offset(p4d_offset(pgd, gpa), gpa);
> > > > 
> > > > The additionnal walks should be added through another patch the day powerpc
> > > > need them.
> > > 
> > > Ok, I'll update the patch to reduce walking the p4d.
> > 
> > Here's what I have with more direct acceses from pgd to pud.
> 
> I went quickly through. This looks promising.
> 
> Do we need the walk_p4d() in arch/powerpc/mm/ptdump/hashpagetable.c ?
> Can't we just do
> 
> @@ -445,7 +459,7 @@ static void walk_pagetables(struct pg_state *st)
>  		addr = KERN_VIRT_START + i * PGDIR_SIZE;
>  		if (!pgd_none(*pgd))
>  			/* pgd exists */
> -			walk_pud(st, pgd, addr);
> +			walk_pud(st, p4d_offset(pgd, addr), addr);

We can do

	addr = KERN_VIRT_START + i * PGDIR_SIZE;
	p4d = p4d_offset(pgd, addr);
	if (!p4d_none(*pgd))
		walk_pud()

But I don't think this is really essential. Again, we are trading off code
consistency vs line count. I don't think line count is that important.

>  	}
>  }
> 
> 
> 
> Also, I think the removal of get_pteptr() should be a patch by itself.
> 
> You could include my patches in your series. See
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=152102
> 
> Christophe
> 
> 
> 
> > 
> >  From 6c59a86ce8394fb6100e9b6ced2e346981fb0ce9 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Sun, 24 Nov 2019 15:38:00 +0200
> > Subject: [PATCH v3] powerpc: add support for folded p4d page tables
> > 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # 8xx and 83xx
> > ---
> > v3:
> > * reduce amount of added p4d walks
> > * kill pgtable_32::get_pteptr and traverse page table in
> >    pgtable_32::__change_page_attr_noflush
> > 
> > 
> >   arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
> >   arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
> >   arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
> >   arch/powerpc/include/asm/book3s/64/pgtable.h  | 60 ++++++++++---------
> >   arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
> >   arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
> >   arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
> >   .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
> >   arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
> >   arch/powerpc/include/asm/pgtable.h            |  6 +-
> >   arch/powerpc/kvm/book3s_64_mmu_radix.c        | 30 ++++++----
> >   arch/powerpc/lib/code-patching.c              |  7 ++-
> >   arch/powerpc/mm/book3s32/mmu.c                |  2 +-
> >   arch/powerpc/mm/book3s32/tlb.c                |  4 +-
> >   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
> >   arch/powerpc/mm/book3s64/radix_pgtable.c      | 26 +++++---
> >   arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
> >   arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
> >   arch/powerpc/mm/kasan/kasan_init_32.c         |  8 +--
> >   arch/powerpc/mm/mem.c                         |  4 +-
> >   arch/powerpc/mm/nohash/40x.c                  |  4 +-
> >   arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 ++---
> >   arch/powerpc/mm/pgtable.c                     | 30 ++++++----
> >   arch/powerpc/mm/pgtable_32.c                  | 45 +++-----------
> >   arch/powerpc/mm/pgtable_64.c                  | 10 ++--
> >   arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
> >   arch/powerpc/mm/ptdump/ptdump.c               | 14 +++--
> >   arch/powerpc/xmon/xmon.c                      | 18 +++---
> >   28 files changed, 213 insertions(+), 184 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> > index 5b39c11e884a..39ec11371be0 100644
> > --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> > @@ -2,7 +2,6 @@
> >   #ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
> >   #define _ASM_POWERPC_BOOK3S_32_PGTABLE_H
> > -#define __ARCH_USE_5LEVEL_HACK
> >   #include <asm-generic/pgtable-nopmd.h>
> >   #include <asm/book3s/32/hash.h>
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > index 2781ebf6add4..876d1528c2cf 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -134,9 +134,9 @@ static inline int get_region_id(unsigned long ea)
> >   #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
> >   #define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
> > -static inline int hash__pgd_bad(pgd_t pgd)
> > +static inline int hash__p4d_bad(p4d_t p4d)
> >   {
> > -	return (pgd_val(pgd) == 0);
> > +	return (p4d_val(p4d) == 0);
> >   }
> >   #ifdef CONFIG_STRICT_KERNEL_RWX
> >   extern void hash__mark_rodata_ro(void);
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > index a41e91bd0580..69c5b051734f 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> > @@ -85,9 +85,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> >   	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
> >   }
> > -static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
> > +static inline void p4d_populate(struct mm_struct *mm, p4d_t *pgd, pud_t *pud)
> >   {
> > -	*pgd =  __pgd(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
> > +	*pgd =  __p4d(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
> >   }
> >   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > index 201a69e6a355..fa60e8594b9f 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> > @@ -2,7 +2,7 @@
> >   #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
> >   #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
> > -#include <asm-generic/5level-fixup.h>
> > +#include <asm-generic/pgtable-nop4d.h>
> >   #ifndef __ASSEMBLY__
> >   #include <linux/mmdebug.h>
> > @@ -251,7 +251,7 @@ extern unsigned long __pmd_frag_size_shift;
> >   /* Bits to mask out from a PUD to get to the PMD page */
> >   #define PUD_MASKED_BITS		0xc0000000000000ffUL
> >   /* Bits to mask out from a PGD to get to the PUD page */
> > -#define PGD_MASKED_BITS		0xc0000000000000ffUL
> > +#define P4D_MASKED_BITS		0xc0000000000000ffUL
> >   /*
> >    * Used as an indicator for rcu callback functions
> > @@ -949,54 +949,60 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
> >   	return pte_access_permitted(pud_pte(pud), write);
> >   }
> > -#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
> > +#define __p4d_raw(x)	((p4d_t) { __pgd_raw(x) })
> > +static inline __be64 p4d_raw(p4d_t x)
> > +{
> > +	return pgd_raw(x.pgd);
> > +}
> > +
> > +#define p4d_write(p4d)		pte_write(p4d_pte(p4d))
> > -static inline void pgd_clear(pgd_t *pgdp)
> > +static inline void p4d_clear(p4d_t *p4dp)
> >   {
> > -	*pgdp = __pgd(0);
> > +	*p4dp = __p4d(0);
> >   }
> > -static inline int pgd_none(pgd_t pgd)
> > +static inline int p4d_none(p4d_t p4d)
> >   {
> > -	return !pgd_raw(pgd);
> > +	return !p4d_raw(p4d);
> >   }
> > -static inline int pgd_present(pgd_t pgd)
> > +static inline int p4d_present(p4d_t p4d)
> >   {
> > -	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> > +	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PRESENT));
> >   }
> > -static inline pte_t pgd_pte(pgd_t pgd)
> > +static inline pte_t p4d_pte(p4d_t p4d)
> >   {
> > -	return __pte_raw(pgd_raw(pgd));
> > +	return __pte_raw(p4d_raw(p4d));
> >   }
> > -static inline pgd_t pte_pgd(pte_t pte)
> > +static inline p4d_t pte_p4d(pte_t pte)
> >   {
> > -	return __pgd_raw(pte_raw(pte));
> > +	return __p4d_raw(pte_raw(pte));
> >   }
> > -static inline int pgd_bad(pgd_t pgd)
> > +static inline int p4d_bad(p4d_t p4d)
> >   {
> >   	if (radix_enabled())
> > -		return radix__pgd_bad(pgd);
> > -	return hash__pgd_bad(pgd);
> > +		return radix__p4d_bad(p4d);
> > +	return hash__p4d_bad(p4d);
> >   }
> > -#define pgd_access_permitted pgd_access_permitted
> > -static inline bool pgd_access_permitted(pgd_t pgd, bool write)
> > +#define p4d_access_permitted p4d_access_permitted
> > +static inline bool p4d_access_permitted(p4d_t p4d, bool write)
> >   {
> > -	return pte_access_permitted(pgd_pte(pgd), write);
> > +	return pte_access_permitted(p4d_pte(p4d), write);
> >   }
> > -extern struct page *pgd_page(pgd_t pgd);
> > +extern struct page *p4d_page(p4d_t p4d);
> >   /* Pointers in the page table tree are physical addresses */
> >   #define __pgtable_ptr_val(ptr)	__pa(ptr)
> >   #define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
> >   #define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
> > -#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
> > +#define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
> >   #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
> >   #define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
> > @@ -1010,8 +1016,8 @@ extern struct page *pgd_page(pgd_t pgd);
> >   #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
> > -#define pud_offset(pgdp, addr)	\
> > -	(((pud_t *) pgd_page_vaddr(*(pgdp))) + pud_index(addr))
> > +#define pud_offset(p4dp, addr)	\
> > +	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
> >   #define pmd_offset(pudp,addr) \
> >   	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
> >   #define pte_offset_kernel(dir,addr) \
> > @@ -1368,11 +1374,11 @@ static inline bool pud_is_leaf(pud_t pud)
> >   	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> >   }
> > -#define pgd_is_leaf pgd_is_leaf
> > -#define pgd_leaf pgd_is_leaf
> > -static inline bool pgd_is_leaf(pgd_t pgd)
> > +#define p4d_is_leaf p4d_is_leaf
> > +#define p4d_leaf p4d_is_leaf
> > +static inline bool p4d_is_leaf(p4d_t p4d)
> >   {
> > -	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
> > +	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PTE));
> >   }
> >   #endif /* __ASSEMBLY__ */
> > diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> > index d97db3ad9aae..9bca2ac64220 100644
> > --- a/arch/powerpc/include/asm/book3s/64/radix.h
> > +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> > @@ -30,7 +30,7 @@
> >   /* Don't have anything in the reserved bits and leaf bits */
> >   #define RADIX_PMD_BAD_BITS		0x60000000000000e0UL
> >   #define RADIX_PUD_BAD_BITS		0x60000000000000e0UL
> > -#define RADIX_PGD_BAD_BITS		0x60000000000000e0UL
> > +#define RADIX_P4D_BAD_BITS		0x60000000000000e0UL
> >   #define RADIX_PMD_SHIFT		(PAGE_SHIFT + RADIX_PTE_INDEX_SIZE)
> >   #define RADIX_PUD_SHIFT		(RADIX_PMD_SHIFT + RADIX_PMD_INDEX_SIZE)
> > @@ -227,9 +227,9 @@ static inline int radix__pud_bad(pud_t pud)
> >   }
> > -static inline int radix__pgd_bad(pgd_t pgd)
> > +static inline int radix__p4d_bad(p4d_t p4d)
> >   {
> > -	return !!(pgd_val(pgd) & RADIX_PGD_BAD_BITS);
> > +	return !!(p4d_val(p4d) & RADIX_P4D_BAD_BITS);
> >   }
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> > index 60c4d829152e..d4c2c4259fa3 100644
> > --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> > +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> > @@ -2,7 +2,6 @@
> >   #ifndef _ASM_POWERPC_NOHASH_32_PGTABLE_H
> >   #define _ASM_POWERPC_NOHASH_32_PGTABLE_H
> > -#define __ARCH_USE_5LEVEL_HACK
> >   #include <asm-generic/pgtable-nopmd.h>
> >   #ifndef __ASSEMBLY__
> > diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> > index b9534a793293..668aee6017e7 100644
> > --- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> > +++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> > @@ -15,7 +15,7 @@ struct vmemmap_backing {
> >   };
> >   extern struct vmemmap_backing *vmemmap_list;
> > -#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
> > +#define p4d_populate(MM, P4D, PUD)	p4d_set(P4D, (unsigned long)PUD)
> >   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> >   {
> > diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
> > index c40ec32b8194..81b1c54e3cf1 100644
> > --- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
> > +++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
> > @@ -2,7 +2,7 @@
> >   #ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
> >   #define _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
> > -#include <asm-generic/5level-fixup.h>
> > +#include <asm-generic/pgtable-nop4d.h>
> >   /*
> >    * Entries per page directory level.  The PTE level must use a 64b record
> > @@ -45,41 +45,41 @@
> >   #define PMD_MASKED_BITS		0
> >   /* Bits to mask out from a PUD to get to the PMD page */
> >   #define PUD_MASKED_BITS		0
> > -/* Bits to mask out from a PGD to get to the PUD page */
> > -#define PGD_MASKED_BITS		0
> > +/* Bits to mask out from a P4D to get to the PUD page */
> > +#define P4D_MASKED_BITS		0
> >   /*
> >    * 4-level page tables related bits
> >    */
> > -#define pgd_none(pgd)		(!pgd_val(pgd))
> > -#define pgd_bad(pgd)		(pgd_val(pgd) == 0)
> > -#define pgd_present(pgd)	(pgd_val(pgd) != 0)
> > -#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
> > +#define p4d_none(p4d)		(!p4d_val(p4d))
> > +#define p4d_bad(p4d)		(p4d_val(p4d) == 0)
> > +#define p4d_present(p4d)	(p4d_val(p4d) != 0)
> > +#define p4d_page_vaddr(p4d)	(p4d_val(p4d) & ~P4D_MASKED_BITS)
> >   #ifndef __ASSEMBLY__
> > -static inline void pgd_clear(pgd_t *pgdp)
> > +static inline void p4d_clear(p4d_t *p4dp)
> >   {
> > -	*pgdp = __pgd(0);
> > +	*p4dp = __p4d(0);
> >   }
> > -static inline pte_t pgd_pte(pgd_t pgd)
> > +static inline pte_t p4d_pte(p4d_t p4d)
> >   {
> > -	return __pte(pgd_val(pgd));
> > +	return __pte(p4d_val(p4d));
> >   }
> > -static inline pgd_t pte_pgd(pte_t pte)
> > +static inline p4d_t pte_p4d(pte_t pte)
> >   {
> > -	return __pgd(pte_val(pte));
> > +	return __p4d(pte_val(pte));
> >   }
> > -extern struct page *pgd_page(pgd_t pgd);
> > +extern struct page *p4d_page(p4d_t p4d);
> >   #endif /* !__ASSEMBLY__ */
> > -#define pud_offset(pgdp, addr)	\
> > -  (((pud_t *) pgd_page_vaddr(*(pgdp))) + \
> > +#define pud_offset(p4dp, addr)	\
> > +  (((pud_t *) p4d_page_vaddr(*(p4dp))) + \
> >       (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
> >   #define pud_ERROR(e) \
> > diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> > index 9a33b8bd842d..b360f262b9c6 100644
> > --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> > +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> > @@ -175,11 +175,11 @@ static inline pud_t pte_pud(pte_t pte)
> >   	return __pud(pte_val(pte));
> >   }
> >   #define pud_write(pud)		pte_write(pud_pte(pud))
> > -#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
> > +#define p4d_write(pgd)		pte_write(p4d_pte(p4d))
> > -static inline void pgd_set(pgd_t *pgdp, unsigned long val)
> > +static inline void p4d_set(p4d_t *p4dp, unsigned long val)
> >   {
> > -	*pgdp = __pgd(val);
> > +	*p4dp = __p4d(val);
> >   }
> >   /*
> > diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> > index 8cc543ed114c..05205d7a7b4a 100644
> > --- a/arch/powerpc/include/asm/pgtable.h
> > +++ b/arch/powerpc/include/asm/pgtable.h
> > @@ -139,9 +139,9 @@ static inline bool pud_is_leaf(pud_t pud)
> >   }
> >   #endif
> > -#ifndef pgd_is_leaf
> > -#define pgd_is_leaf pgd_is_leaf
> > -static inline bool pgd_is_leaf(pgd_t pgd)
> > +#ifndef p4d_is_leaf
> > +#define p4d_is_leaf p4d_is_leaf
> > +static inline bool p4d_is_leaf(p4d_t p4d)
> >   {
> >   	return false;
> >   }
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > index 803940d79b73..beb694285100 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > @@ -499,13 +499,14 @@ void kvmppc_free_pgtable_radix(struct kvm *kvm, pgd_t *pgd, unsigned int lpid)
> >   	unsigned long ig;
> >   	for (ig = 0; ig < PTRS_PER_PGD; ++ig, ++pgd) {
> > +		p4d_t *p4d = p4d_offset(pgd, 0);
> >   		pud_t *pud;
> > -		if (!pgd_present(*pgd))
> > +		if (!p4d_present(*p4d))
> >   			continue;
> > -		pud = pud_offset(pgd, 0);
> > +		pud = pud_offset(p4d, 0);
> >   		kvmppc_unmap_free_pud(kvm, pud, lpid);
> > -		pgd_clear(pgd);
> > +		p4d_clear(p4d);
> >   	}
> >   }
> > @@ -566,6 +567,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> >   		      unsigned long *rmapp, struct rmap_nested **n_rmap)
> >   {
> >   	pgd_t *pgd;
> > +	p4d_t *p4d;
> >   	pud_t *pud, *new_pud = NULL;
> >   	pmd_t *pmd, *new_pmd = NULL;
> >   	pte_t *ptep, *new_ptep = NULL;
> > @@ -573,9 +575,11 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> >   	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
> >   	pgd = pgtable + pgd_index(gpa);
> > +	p4d = p4d_offset(pgd, gpa);
> > +
> >   	pud = NULL;
> > -	if (pgd_present(*pgd))
> > -		pud = pud_offset(pgd, gpa);
> > +	if (p4d_present(*p4d))
> > +		pud = pud_offset(p4d, gpa);
> >   	else
> >   		new_pud = pud_alloc_one(kvm->mm, gpa);
> > @@ -596,13 +600,13 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> >   	/* Now traverse again under the lock and change the tree */
> >   	ret = -ENOMEM;
> > -	if (pgd_none(*pgd)) {
> > +	if (p4d_none(*p4d)) {
> >   		if (!new_pud)
> >   			goto out_unlock;
> > -		pgd_populate(kvm->mm, pgd, new_pud);
> > +		p4d_populate(kvm->mm, p4d, new_pud);
> >   		new_pud = NULL;
> >   	}
> > -	pud = pud_offset(pgd, gpa);
> > +	pud = pud_offset(p4d, gpa);
> >   	if (pud_is_leaf(*pud)) {
> >   		unsigned long hgpa = gpa & PUD_MASK;
> > @@ -1220,6 +1224,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
> >   	pgd_t *pgt;
> >   	struct kvm_nested_guest *nested;
> >   	pgd_t pgd, *pgdp;
> > +	p4d_t p4d, *p4dp;
> >   	pud_t pud, *pudp;
> >   	pmd_t pmd, *pmdp;
> >   	pte_t *ptep;
> > @@ -1292,13 +1297,14 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
> >   		}
> >   		pgdp = pgt + pgd_index(gpa);
> > -		pgd = READ_ONCE(*pgdp);
> > -		if (!(pgd_val(pgd) & _PAGE_PRESENT)) {
> > -			gpa = (gpa & PGDIR_MASK) + PGDIR_SIZE;
> > +		p4dp = p4d_offset(pgdp, gpa);
> > +		p4d = READ_ONCE(*p4dp);
> > +		if (!(p4d_val(p4d) & _PAGE_PRESENT)) {
> > +			gpa = (gpa & P4D_MASK) + P4D_SIZE;
> >   			continue;
> >   		}
> > -		pudp = pud_offset(&pgd, gpa);
> > +		pudp = pud_offset(&p4d, gpa);
> >   		pud = READ_ONCE(*pudp);
> >   		if (!(pud_val(pud) & _PAGE_PRESENT)) {
> >   			gpa = (gpa & PUD_MASK) + PUD_SIZE;
> > diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> > index 3345f039a876..7a59f6863cec 100644
> > --- a/arch/powerpc/lib/code-patching.c
> > +++ b/arch/powerpc/lib/code-patching.c
> > @@ -107,13 +107,18 @@ static inline int unmap_patch_area(unsigned long addr)
> >   	pte_t *ptep;
> >   	pmd_t *pmdp;
> >   	pud_t *pudp;
> > +	p4d_t *p4dp;
> >   	pgd_t *pgdp;
> >   	pgdp = pgd_offset_k(addr);
> >   	if (unlikely(!pgdp))
> >   		return -EINVAL;
> > -	pudp = pud_offset(pgdp, addr);
> > +	p4dp = p4d_offset(pgdp, addr);
> > +	if (unlikely(!p4dp))
> > +		return -EINVAL;
> > +
> > +	pudp = pud_offset(p4dp, addr);
> >   	if (unlikely(!pudp))
> >   		return -EINVAL;
> > diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
> > index f888cbb109b9..edef17c97206 100644
> > --- a/arch/powerpc/mm/book3s32/mmu.c
> > +++ b/arch/powerpc/mm/book3s32/mmu.c
> > @@ -312,7 +312,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea)
> >   	if (!Hash)
> >   		return;
> > -	pmd = pmd_offset(pud_offset(pgd_offset(mm, ea), ea), ea);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, ea), ea), ea), ea);
> >   	if (!pmd_none(*pmd))
> >   		add_hash_page(mm->context.id, ea, pmd_val(*pmd));
> >   }
> > diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
> > index 2fcd321040ff..175bc33b41b7 100644
> > --- a/arch/powerpc/mm/book3s32/tlb.c
> > +++ b/arch/powerpc/mm/book3s32/tlb.c
> > @@ -87,7 +87,7 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
> >   	if (start >= end)
> >   		return;
> >   	end = (end - 1) | ~PAGE_MASK;
> > -	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, start), start), start), start);
> >   	for (;;) {
> >   		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
> >   		if (pmd_end > end)
> > @@ -145,7 +145,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
> >   		return;
> >   	}
> >   	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
> > -	pmd = pmd_offset(pud_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr), vmaddr);
> >   	if (!pmd_none(*pmd))
> >   		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
> >   }
> > diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> > index 64733b9cb20a..9cd15937e88a 100644
> > --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> > @@ -148,6 +148,7 @@ void hash__vmemmap_remove_mapping(unsigned long start,
> >   int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
> >   {
> >   	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> > @@ -155,7 +156,8 @@ int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
> >   	BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
> >   	if (slab_is_available()) {
> >   		pgdp = pgd_offset_k(ea);
> > -		pudp = pud_alloc(&init_mm, pgdp, ea);
> > +		p4dp = p4d_offset(pgdp, ea);
> > +		pudp = pud_alloc(&init_mm, p4dp, ea);
> >   		if (!pudp)
> >   			return -ENOMEM;
> >   		pmdp = pmd_alloc(&init_mm, pudp, ea);
> > diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > index dd1bea45325c..fc3d0b0460b0 100644
> > --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > @@ -64,17 +64,19 @@ static int early_map_kernel_page(unsigned long ea, unsigned long pa,
> >   {
> >   	unsigned long pfn = pa >> PAGE_SHIFT;
> >   	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> >   	pgdp = pgd_offset_k(ea);
> > -	if (pgd_none(*pgdp)) {
> > +	p4dp = p4d_offset(pgdp, ea);
> > +	if (p4d_none(*p4dp)) {
> >   		pudp = early_alloc_pgtable(PUD_TABLE_SIZE, nid,
> >   						region_start, region_end);
> > -		pgd_populate(&init_mm, pgdp, pudp);
> > +		p4d_populate(&init_mm, p4dp, pudp);
> >   	}
> > -	pudp = pud_offset(pgdp, ea);
> > +	pudp = pud_offset(p4dp, ea);
> >   	if (map_page_size == PUD_SIZE) {
> >   		ptep = (pte_t *)pudp;
> >   		goto set_the_pte;
> > @@ -114,6 +116,7 @@ static int __map_kernel_page(unsigned long ea, unsigned long pa,
> >   {
> >   	unsigned long pfn = pa >> PAGE_SHIFT;
> >   	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> > @@ -136,7 +139,8 @@ static int __map_kernel_page(unsigned long ea, unsigned long pa,
> >   	 * boot.
> >   	 */
> >   	pgdp = pgd_offset_k(ea);
> > -	pudp = pud_alloc(&init_mm, pgdp, ea);
> > +	p4dp = p4d_offset(pgdp, ea);
> > +	pudp = pud_alloc(&init_mm, p4dp, ea);
> >   	if (!pudp)
> >   		return -ENOMEM;
> >   	if (map_page_size == PUD_SIZE) {
> > @@ -173,6 +177,7 @@ void radix__change_memory_range(unsigned long start, unsigned long end,
> >   {
> >   	unsigned long idx;
> >   	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> > @@ -185,7 +190,8 @@ void radix__change_memory_range(unsigned long start, unsigned long end,
> >   	for (idx = start; idx < end; idx += PAGE_SIZE) {
> >   		pgdp = pgd_offset_k(idx);
> > -		pudp = pud_alloc(&init_mm, pgdp, idx);
> > +		p4dp = p4d_offset(pgdp, idx);
> > +		pudp = pud_alloc(&init_mm, p4dp, idx);
> >   		if (!pudp)
> >   			continue;
> >   		if (pud_is_leaf(*pudp)) {
> > @@ -847,6 +853,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
> >   	unsigned long addr, next;
> >   	pud_t *pud_base;
> >   	pgd_t *pgd;
> > +	p4d_t *p4d;
> >   	spin_lock(&init_mm.page_table_lock);
> > @@ -854,15 +861,16 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
> >   		next = pgd_addr_end(addr, end);
> >   		pgd = pgd_offset_k(addr);
> > -		if (!pgd_present(*pgd))
> > +		p4d = p4d_offset(pgd, addr);
> > +		if (!p4d_present(*p4d))
> >   			continue;
> > -		if (pgd_is_leaf(*pgd)) {
> > -			split_kernel_mapping(addr, end, PGDIR_SIZE, (pte_t *)pgd);
> > +		if (p4d_is_leaf(*p4d)) {
> > +			split_kernel_mapping(addr, end, P4D_SIZE, (pte_t *)p4d);
> >   			continue;
> >   		}
> > -		pud_base = (pud_t *)pgd_page_vaddr(*pgd);
> > +		pud_base = (pud_t *)p4d_page_vaddr(*p4d);
> >   		remove_pud_table(pud_base, addr, next);
> >   	}
> > diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
> > index 2ef24a53f4c9..25a0c044bd93 100644
> > --- a/arch/powerpc/mm/book3s64/subpage_prot.c
> > +++ b/arch/powerpc/mm/book3s64/subpage_prot.c
> > @@ -54,15 +54,17 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
> >   			     int npages)
> >   {
> >   	pgd_t *pgd;
> > +	p4d_t *p4d;
> >   	pud_t *pud;
> >   	pmd_t *pmd;
> >   	pte_t *pte;
> >   	spinlock_t *ptl;
> >   	pgd = pgd_offset(mm, addr);
> > -	if (pgd_none(*pgd))
> > +	p4d = p4d_offset(pgd, addr);
> > +	if (p4d_none(*p4d))
> >   		return;
> > -	pud = pud_offset(pgd, addr);
> > +	pud = pud_offset(p4d, addr);
> >   	if (pud_none(*pud))
> >   		return;
> >   	pmd = pmd_offset(pud, addr);
> > diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> > index 33b3461d91e8..54f5994d4cbb 100644
> > --- a/arch/powerpc/mm/hugetlbpage.c
> > +++ b/arch/powerpc/mm/hugetlbpage.c
> > @@ -119,6 +119,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
> >   pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
> >   {
> >   	pgd_t *pg;
> > +	p4d_t *p4;
> >   	pud_t *pu;
> >   	pmd_t *pm;
> >   	hugepd_t *hpdp = NULL;
> > @@ -128,20 +129,21 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
> >   	addr &= ~(sz-1);
> >   	pg = pgd_offset(mm, addr);
> > +	p4 = p4d_offset(pg, addr);
> >   #ifdef CONFIG_PPC_BOOK3S_64
> >   	if (pshift == PGDIR_SHIFT)
> >   		/* 16GB huge page */
> > -		return (pte_t *) pg;
> > +		return (pte_t *) p4;
> >   	else if (pshift > PUD_SHIFT) {
> >   		/*
> >   		 * We need to use hugepd table
> >   		 */
> >   		ptl = &mm->page_table_lock;
> > -		hpdp = (hugepd_t *)pg;
> > +		hpdp = (hugepd_t *)p4;
> >   	} else {
> >   		pdshift = PUD_SHIFT;
> > -		pu = pud_alloc(mm, pg, addr);
> > +		pu = pud_alloc(mm, p4, addr);
> >   		if (!pu)
> >   			return NULL;
> >   		if (pshift == PUD_SHIFT)
> > @@ -166,10 +168,10 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
> >   #else
> >   	if (pshift >= PGDIR_SHIFT) {
> >   		ptl = &mm->page_table_lock;
> > -		hpdp = (hugepd_t *)pg;
> > +		hpdp = (hugepd_t *)p4;
> >   	} else {
> >   		pdshift = PUD_SHIFT;
> > -		pu = pud_alloc(mm, pg, addr);
> > +		pu = pud_alloc(mm, p4, addr);
> >   		if (!pu)
> >   			return NULL;
> >   		if (pshift >= PUD_SHIFT) {
> > @@ -390,7 +392,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> >   	mm_dec_nr_pmds(tlb->mm);
> >   }
> > -static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
> > +static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> >   				   unsigned long addr, unsigned long end,
> >   				   unsigned long floor, unsigned long ceiling)
> >   {
> > @@ -400,7 +402,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
> >   	start = addr;
> >   	do {
> > -		pud = pud_offset(pgd, addr);
> > +		pud = pud_offset(p4d, addr);
> >   		next = pud_addr_end(addr, end);
> >   		if (!is_hugepd(__hugepd(pud_val(*pud)))) {
> >   			if (pud_none_or_clear_bad(pud))
> > @@ -435,8 +437,8 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
> >   	if (end - 1 > ceiling - 1)
> >   		return;
> > -	pud = pud_offset(pgd, start);
> > -	pgd_clear(pgd);
> > +	pud = pud_offset(p4d, start);
> > +	p4d_clear(p4d);
> >   	pud_free_tlb(tlb, pud, start);
> >   	mm_dec_nr_puds(tlb->mm);
> >   }
> > @@ -449,6 +451,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> >   			    unsigned long floor, unsigned long ceiling)
> >   {
> >   	pgd_t *pgd;
> > +	p4d_t *p4d;
> >   	unsigned long next;
> >   	/*
> > @@ -471,10 +474,11 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> >   	do {
> >   		next = pgd_addr_end(addr, end);
> >   		pgd = pgd_offset(tlb->mm, addr);
> > +		p4d = p4d_offset(pgd, addr);
> >   		if (!is_hugepd(__hugepd(pgd_val(*pgd)))) {
> > -			if (pgd_none_or_clear_bad(pgd))
> > +			if (p4d_none_or_clear_bad(p4d))
> >   				continue;
> > -			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
> > +			hugetlb_free_pud_range(tlb, p4d, addr, next, floor, ceiling);
> >   		} else {
> >   			unsigned long more;
> >   			/*
> > @@ -487,7 +491,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> >   			if (more > next)
> >   				next = more;
> > -			free_hugepd_range(tlb, (hugepd_t *)pgd, PGDIR_SHIFT,
> > +			free_hugepd_range(tlb, (hugepd_t *)p4d, PGDIR_SHIFT,
> >   					  addr, next, floor, ceiling);
> >   		}
> >   	} while (addr = next, addr != end);
> > diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> > index db5664dde5ff..88e2e16380b5 100644
> > --- a/arch/powerpc/mm/kasan/kasan_init_32.c
> > +++ b/arch/powerpc/mm/kasan/kasan_init_32.c
> > @@ -36,7 +36,7 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
> >   	unsigned long k_cur, k_next;
> >   	pte_t *new = NULL;
> > -	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
> > +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(k_start), k_start), k_start), k_start);
> >   	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
> >   		k_next = pgd_addr_end(k_cur, k_end);
> > @@ -78,7 +78,7 @@ static int __init kasan_init_region(void *start, size_t size)
> >   	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
> >   	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
> > -		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
> > +		pmd_t *pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(k_cur), k_cur), k_cur), k_cur);
> >   		void *va = block + k_cur - k_start;
> >   		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
> > @@ -102,7 +102,7 @@ static void __init kasan_remap_early_shadow_ro(void)
> >   	kasan_populate_pte(kasan_early_shadow_pte, prot);
> >   	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
> > -		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
> > +		pmd_t *pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(k_cur), k_cur), k_cur), k_cur);
> >   		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
> >   		if ((pte_val(*ptep) & PTE_RPN_MASK) != pa)
> > @@ -201,7 +201,7 @@ void __init kasan_early_init(void)
> >   	unsigned long addr = KASAN_SHADOW_START;
> >   	unsigned long end = KASAN_SHADOW_END;
> >   	unsigned long next;
> > -	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> > +	pmd_t *pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(addr), addr), addr), addr);
> >   	BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
> > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > index ef7b1119b2e2..8262b384dcf3 100644
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -69,8 +69,8 @@ EXPORT_SYMBOL(kmap_prot);
> >   static inline pte_t *virt_to_kpte(unsigned long vaddr)
> >   {
> > -	return pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr),
> > -			vaddr), vaddr), vaddr);
> > +	return pte_offset_kernel(pmd_offset(pud_offset(p4d_offset(pgd_offset_k(vaddr),
> > +			vaddr), vaddr), vaddr), vaddr);
> >   }
> >   #endif
> > diff --git a/arch/powerpc/mm/nohash/40x.c b/arch/powerpc/mm/nohash/40x.c
> > index f348104eb461..7aaf7155e350 100644
> > --- a/arch/powerpc/mm/nohash/40x.c
> > +++ b/arch/powerpc/mm/nohash/40x.c
> > @@ -104,7 +104,7 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
> >   		pmd_t *pmdp;
> >   		unsigned long val = p | _PMD_SIZE_16M | _PAGE_EXEC | _PAGE_HWWRITE;
> > -		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> > +		pmdp = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(v), v), v), v);
> >   		*pmdp++ = __pmd(val);
> >   		*pmdp++ = __pmd(val);
> >   		*pmdp++ = __pmd(val);
> > @@ -119,7 +119,7 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
> >   		pmd_t *pmdp;
> >   		unsigned long val = p | _PMD_SIZE_4M | _PAGE_EXEC | _PAGE_HWWRITE;
> > -		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> > +		pmdp = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(v), v), v), v);
> >   		*pmdp = __pmd(val);
> >   		v += LARGE_PAGE_SIZE_4M;
> > diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
> > index 4637fdd469cf..77884e24281d 100644
> > --- a/arch/powerpc/mm/nohash/book3e_pgtable.c
> > +++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
> > @@ -73,6 +73,7 @@ static void __init *early_alloc_pgtable(unsigned long size)
> >   int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
> >   {
> >   	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> > @@ -80,7 +81,8 @@ int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
> >   	BUILD_BUG_ON(TASK_SIZE_USER64 > PGTABLE_RANGE);
> >   	if (slab_is_available()) {
> >   		pgdp = pgd_offset_k(ea);
> > -		pudp = pud_alloc(&init_mm, pgdp, ea);
> > +		p4dp = p4d_offset(pgdp, ea);
> > +		pudp = pud_alloc(&init_mm, p4dp, ea);
> >   		if (!pudp)
> >   			return -ENOMEM;
> >   		pmdp = pmd_alloc(&init_mm, pudp, ea);
> > @@ -91,13 +93,12 @@ int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
> >   			return -ENOMEM;
> >   	} else {
> >   		pgdp = pgd_offset_k(ea);
> > -#ifndef __PAGETABLE_PUD_FOLDED
> > -		if (pgd_none(*pgdp)) {
> > -			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
> > -			pgd_populate(&init_mm, pgdp, pudp);
> > +		p4dp = p4d_offset(pgdp, ea);
> > +		if (p4d_none(*p4dp)) {
> > +			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
> > +			p4d_populate(&init_mm, p4dp, pmdp);
> >   		}
> > -#endif /* !__PAGETABLE_PUD_FOLDED */
> > -		pudp = pud_offset(pgdp, ea);
> > +		pudp = pud_offset(p4dp, ea);
> >   		if (pud_none(*pudp)) {
> >   			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
> >   			pud_populate(&init_mm, pudp, pmdp);
> > diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> > index e3759b69f81b..c2499271f6c1 100644
> > --- a/arch/powerpc/mm/pgtable.c
> > +++ b/arch/powerpc/mm/pgtable.c
> > @@ -265,6 +265,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >   void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
> >   {
> >   	pgd_t *pgd;
> > +	p4d_t *p4d;
> >   	pud_t *pud;
> >   	pmd_t *pmd;
> > @@ -272,7 +273,9 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
> >   		return;
> >   	pgd = mm->pgd + pgd_index(addr);
> >   	BUG_ON(pgd_none(*pgd));
> > -	pud = pud_offset(pgd, addr);
> > +	p4d = p4d_offset(pgd, addr);
> > +	BUG_ON(p4d_none(*p4d));
> > +	pud = pud_offset(p4d, addr);
> >   	BUG_ON(pud_none(*pud));
> >   	pmd = pmd_offset(pud, addr);
> >   	/*
> > @@ -312,12 +315,13 @@ EXPORT_SYMBOL_GPL(vmalloc_to_phys);
> >   pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
> >   			bool *is_thp, unsigned *hpage_shift)
> >   {
> > -	pgd_t pgd, *pgdp;
> > +	pgd_t *pgdp;
> > +	p4d_t p4d, *p4dp;
> >   	pud_t pud, *pudp;
> >   	pmd_t pmd, *pmdp;
> >   	pte_t *ret_pte;
> >   	hugepd_t *hpdp = NULL;
> > -	unsigned pdshift = PGDIR_SHIFT;
> > +	unsigned pdshift;
> >   	if (hpage_shift)
> >   		*hpage_shift = 0;
> > @@ -325,24 +329,28 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
> >   	if (is_thp)
> >   		*is_thp = false;
> > -	pgdp = pgdir + pgd_index(ea);
> > -	pgd  = READ_ONCE(*pgdp);
> >   	/*
> >   	 * Always operate on the local stack value. This make sure the
> >   	 * value don't get updated by a parallel THP split/collapse,
> >   	 * page fault or a page unmap. The return pte_t * is still not
> >   	 * stable. So should be checked there for above conditions.
> > +	 * Top level is an exception because it is folded into p4d.
> >   	 */
> > -	if (pgd_none(pgd))
> > +	pgdp = pgdir + pgd_index(ea);
> > +	p4dp = p4d_offset(pgdp, ea);
> > +	p4d  = READ_ONCE(*p4dp);
> > +	pdshift = P4D_SHIFT;
> > +
> > +	if (p4d_none(p4d))
> >   		return NULL;
> > -	if (pgd_is_leaf(pgd)) {
> > -		ret_pte = (pte_t *)pgdp;
> > +	if (p4d_is_leaf(p4d)) {
> > +		ret_pte = (pte_t *)p4dp;
> >   		goto out;
> >   	}
> > -	if (is_hugepd(__hugepd(pgd_val(pgd)))) {
> > -		hpdp = (hugepd_t *)&pgd;
> > +	if (is_hugepd(__hugepd(p4d_val(p4d)))) {
> > +		hpdp = (hugepd_t *)&p4d;
> >   		goto out_huge;
> >   	}
> > @@ -352,7 +360,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
> >   	 * irq disabled
> >   	 */
> >   	pdshift = PUD_SHIFT;
> > -	pudp = pud_offset(&pgd, ea);
> > +	pudp = pud_offset(&p4d, ea);
> >   	pud  = READ_ONCE(*pudp);
> >   	if (pud_none(pud))
> > diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> > index 5fb90edd865e..5774d4bc94d0 100644
> > --- a/arch/powerpc/mm/pgtable_32.c
> > +++ b/arch/powerpc/mm/pgtable_32.c
> > @@ -63,7 +63,7 @@ int __ref map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
> >   	int err = -ENOMEM;
> >   	/* Use upper 10 bits of VA to index the first level map */
> > -	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
> > +	pd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), va), va);
> >   	/* Use middle 10 bits of VA to index the second-level map */
> >   	if (likely(slab_is_available()))
> >   		pg = pte_alloc_kernel(pd, va);
> > @@ -121,53 +121,24 @@ void __init mapin_ram(void)
> >   	}
> >   }
> > -/* Scan the real Linux page tables and return a PTE pointer for
> > - * a virtual address in a context.
> > - * Returns true (1) if PTE was found, zero otherwise.  The pointer to
> > - * the PTE pointer is unmodified if PTE is not found.
> > - */
> > -static int
> > -get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
> > -{
> > -        pgd_t	*pgd;
> > -	pud_t	*pud;
> > -        pmd_t	*pmd;
> > -        pte_t	*pte;
> > -        int     retval = 0;
> > -
> > -        pgd = pgd_offset(mm, addr & PAGE_MASK);
> > -        if (pgd) {
> > -		pud = pud_offset(pgd, addr & PAGE_MASK);
> > -		if (pud && pud_present(*pud)) {
> > -			pmd = pmd_offset(pud, addr & PAGE_MASK);
> > -			if (pmd_present(*pmd)) {
> > -				pte = pte_offset_map(pmd, addr & PAGE_MASK);
> > -				if (pte) {
> > -					retval = 1;
> > -					*ptep = pte;
> > -					if (pmdp)
> > -						*pmdp = pmd;
> > -					/* XXX caller needs to do pte_unmap, yuck */
> > -				}
> > -			}
> > -		}
> > -        }
> > -        return(retval);
> > -}
> > -
> >   static int __change_page_attr_noflush(struct page *page, pgprot_t prot)
> >   {
> >   	pte_t *kpte;
> >   	pmd_t *kpmd;
> > -	unsigned long address;
> > +	unsigned long address, va;
> >   	BUG_ON(PageHighMem(page));
> >   	address = (unsigned long)page_address(page);
> > +	va = address & PAGE_MASK;
> >   	if (v_block_mapped(address))
> >   		return 0;
> > -	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
> > +
> > +	kpmd = pmd_offset(pud_offset(p4d_offset(pgd_offset_k(va), va), va), va);
> > +	if (!pmd_present(*kpmd))
> >   		return -EINVAL;
> > +
> > +	kpte = pte_offset_map(kpmd, va);
> >   	__set_pte_at(&init_mm, address, kpte, mk_pte(page, prot), 0);
> >   	pte_unmap(kpte);
> > diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> > index e78832dce7bb..1f86a88fd4bb 100644
> > --- a/arch/powerpc/mm/pgtable_64.c
> > +++ b/arch/powerpc/mm/pgtable_64.c
> > @@ -101,13 +101,13 @@ EXPORT_SYMBOL(__pte_frag_size_shift);
> >   #ifndef __PAGETABLE_PUD_FOLDED
> >   /* 4 level page table */
> > -struct page *pgd_page(pgd_t pgd)
> > +struct page *p4d_page(p4d_t p4d)
> >   {
> > -	if (pgd_is_leaf(pgd)) {
> > -		VM_WARN_ON(!pgd_huge(pgd));
> > -		return pte_page(pgd_pte(pgd));
> > +	if (p4d_is_leaf(p4d)) {
> > +		VM_WARN_ON(!p4d_huge(p4d));
> > +		return pte_page(p4d_pte(p4d));
> >   	}
> > -	return virt_to_page(pgd_page_vaddr(pgd));
> > +	return virt_to_page(p4d_page_vaddr(p4d));
> >   }
> >   #endif
> > diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
> > index a07278027c6f..ac360ad865a8 100644
> > --- a/arch/powerpc/mm/ptdump/hashpagetable.c
> > +++ b/arch/powerpc/mm/ptdump/hashpagetable.c
> > @@ -417,9 +417,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> >   	}
> >   }
> > -static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> > +static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
> >   {
> > -	pud_t *pud = pud_offset(pgd, 0);
> > +	pud_t *pud = pud_offset(p4d, 0);
> >   	unsigned long addr;
> >   	unsigned int i;
> > @@ -431,6 +431,20 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> >   	}
> >   }
> > +static void walk_p4d(struct pg_state *st, pgd_t *pgd, unsigned long start)
> > +{
> > +	p4d_t *p4d = p4d_offset(pgd, 0);
> > +	unsigned long addr;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < PTRS_PER_P4D; i++, p4d++) {
> > +		addr = start + i * P4D_SIZE;
> > +		if (!p4d_none(*p4d))
> > +			/* p4d exists */
> > +			walk_pud(st, p4d, addr);
> > +	}
> > +}
> > +
> >   static void walk_pagetables(struct pg_state *st)
> >   {
> >   	pgd_t *pgd = pgd_offset_k(0UL);
> > @@ -445,7 +459,7 @@ static void walk_pagetables(struct pg_state *st)
> >   		addr = KERN_VIRT_START + i * PGDIR_SIZE;
> >   		if (!pgd_none(*pgd))
> >   			/* pgd exists */
> > -			walk_pud(st, pgd, addr);
> > +			walk_p4d(st, pgd, addr);
> >   	}
> >   }
> > diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> > index 206156255247..9d6256b61df3 100644
> > --- a/arch/powerpc/mm/ptdump/ptdump.c
> > +++ b/arch/powerpc/mm/ptdump/ptdump.c
> > @@ -277,9 +277,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> >   	}
> >   }
> > -static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> > +static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
> >   {
> > -	pud_t *pud = pud_offset(pgd, 0);
> > +	pud_t *pud = pud_offset(p4d, 0);
> >   	unsigned long addr;
> >   	unsigned int i;
> > @@ -304,11 +304,13 @@ static void walk_pagetables(struct pg_state *st)
> >   	 * the hash pagetable.
> >   	 */
> >   	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
> > -		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
> > -			/* pgd exists */
> > -			walk_pud(st, pgd, addr);
> > +		p4d_t *p4d = p4d_offset(pgd, 0);
> > +
> > +		if (!p4d_none(*p4d) && !p4d_is_leaf(*p4d))
> > +			/* p4d exists */
> > +			walk_pud(st, p4d, addr);
> >   		else
> > -			note_page(st, addr, 1, pgd_val(*pgd));
> > +			note_page(st, addr, 1, p4d_val(*p4d));
> >   	}
> >   }
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index 0ec9640335bb..3e29128c58cc 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> > @@ -3130,6 +3130,7 @@ static void show_pte(unsigned long addr)
> >   	struct task_struct *tsk = NULL;
> >   	struct mm_struct *mm;
> >   	pgd_t *pgdp, *pgdir;
> > +	p4d_t *p4dp;
> >   	pud_t *pudp;
> >   	pmd_t *pmdp;
> >   	pte_t *ptep;
> > @@ -3161,20 +3162,21 @@ static void show_pte(unsigned long addr)
> >   		pgdir = pgd_offset(mm, 0);
> >   	}
> > -	if (pgd_none(*pgdp)) {
> > -		printf("no linux page table for address\n");
> > +	p4dp = p4d_offset(pgdp, addr);
> > +
> > +	if (p4d_none(*p4dp)) {
> > +		printf("No valid P4D\n");
> >   		return;
> >   	}
> > -	printf("pgd  @ 0x%px\n", pgdir);
> > -
> > -	if (pgd_is_leaf(*pgdp)) {
> > -		format_pte(pgdp, pgd_val(*pgdp));
> > +	if (p4d_is_leaf(*p4dp)) {
> > +		format_pte(p4dp, p4d_val(*p4dp));
> >   		return;
> >   	}
> > -	printf("pgdp @ 0x%px = 0x%016lx\n", pgdp, pgd_val(*pgdp));
> > -	pudp = pud_offset(pgdp, addr);
> > +	printf("p4dp @ 0x%px = 0x%016lx\n", p4dp, p4d_val(*p4dp));
> > +
> > +	pudp = pud_offset(p4dp, addr);
> >   	if (pud_none(*pudp)) {
> >   		printf("No valid PUD\n");
> > 
> 
> 

-- 
Sincerely yours,
Mike.

