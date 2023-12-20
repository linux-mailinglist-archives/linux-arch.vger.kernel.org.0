Return-Path: <linux-arch+bounces-1142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F0819F8A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 14:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BFD1C2286C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1F347A2;
	Wed, 20 Dec 2023 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geH8Po+2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93934540;
	Wed, 20 Dec 2023 13:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19026C433C7;
	Wed, 20 Dec 2023 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703077797;
	bh=kNBcPwaMlCBZq05QdM/ZhosCOAELdn7NQH61Zm2JFdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geH8Po+2xTzfgztalOer3avEmmYlxn/45tUCRRhRPkul1OdegcfPNbzZr3tlUU9gL
	 Gr9cAMJrqZuYg4ZXywlT8vSMjii9EQa5EbRzNrvsitbUMRrwbGZ+Vs5h7oma4+HXCX
	 Y6lx9NhOjzB4pblu7fVu8HdFsBrqgIGPmNWbmGUcFzrh5wBtM9iKG3YDgpGMKzvzlh
	 8vB2ywPk0x3h2DIr7Fq1JC41iWIBZuH9vX9FxlyK05Uq+uzcK1I4v29L51UH7MToRn
	 KnLrmtlosx1RWynwXEXaab9s09kXI2/VKwn3Z8VcssHKf3wD1CPcmCmEDqkbqzUfsQ
	 heTJfZCiYSM3Q==
Date: Wed, 20 Dec 2023 20:57:20 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [External] [PATCH 2/4] riscv: tlb: convert __p*d_free_tlb() to
 inline functions
Message-ID: <ZYLksMHfzH1usBAb@xhacker>
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-3-jszhang@kernel.org>
 <CAEEQ3wn6j0N-NSQjEqE8Ee9dGzGMJJ4CW2Yhw_njAaOgR8G_eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wn6j0N-NSQjEqE8Ee9dGzGMJJ4CW2Yhw_njAaOgR8G_eQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 10:59:22AM +0800, yunhui cui wrote:
> Hi Jisheng,

Hi,

> 
> On Wed, Dec 20, 2023 at 2:04 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > This is to prepare for enabling MMU_GATHER_RCU_TABLE_FREE.
> > No functionality changes.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgalloc.h | 54 +++++++++++++++++++-------------
> >  1 file changed, 32 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> > index a12fb83fa1f5..3c5e3bd15f46 100644
> > --- a/arch/riscv/include/asm/pgalloc.h
> > +++ b/arch/riscv/include/asm/pgalloc.h
> > @@ -95,13 +95,16 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
> >                 __pud_free(mm, pud);
> >  }
> >
> > -#define __pud_free_tlb(tlb, pud, addr)                                 \
> > -do {                                                                   \
> > -       if (pgtable_l4_enabled) {                                       \
> > -               pagetable_pud_dtor(virt_to_ptdesc(pud));                \
> > -               tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));     \
> > -       }                                                               \
> > -} while (0)
> > +static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> > +                                 unsigned long addr)
> > +{
> > +       if (pgtable_l4_enabled) {
> > +               struct ptdesc *ptdesc = virt_to_ptdesc(pud);
> > +
> > +               pagetable_pud_dtor(ptdesc);
> > +               tlb_remove_page_ptdesc(tlb, ptdesc);
> > +       }
> > +}
> >
> >  #define p4d_alloc_one p4d_alloc_one
> >  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
> > @@ -130,11 +133,12 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
> >                 __p4d_free(mm, p4d);
> >  }
> >
> > -#define __p4d_free_tlb(tlb, p4d, addr)                                 \
> > -do {                                                                   \
> > -       if (pgtable_l5_enabled)                                         \
> > -               tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));     \
> > -} while (0)
> > +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> > +                                 unsigned long addr)
> > +{
> > +       if (pgtable_l5_enabled)
> > +               tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
> > +}
> >  #endif /* __PAGETABLE_PMD_FOLDED */
> >
> >  static inline void sync_kernel_mappings(pgd_t *pgd)
> > @@ -159,19 +163,25 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >
> >  #ifndef __PAGETABLE_PMD_FOLDED
> >
> > -#define __pmd_free_tlb(tlb, pmd, addr)                         \
> > -do {                                                           \
> > -       pagetable_pmd_dtor(virt_to_ptdesc(pmd));                \
> > -       tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));     \
> > -} while (0)
> > +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> > +                                 unsigned long addr)
> > +{
> > +       struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
> > +
> > +       pagetable_pmd_dtor(ptdesc);
> > +       tlb_remove_page_ptdesc(tlb, ptdesc);
> > +}
> >
> >  #endif /* __PAGETABLE_PMD_FOLDED */
> >
> > -#define __pte_free_tlb(tlb, pte, buf)                  \
> > -do {                                                   \
> > -       pagetable_pte_dtor(page_ptdesc(pte));           \
> > -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
> > -} while (0)
> > +static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> > +                                 unsigned long addr)
> > +{
> > +       struct ptdesc *ptdesc = page_ptdesc(pte);
> > +
> > +       pagetable_pte_dtor(ptdesc);
> > +       tlb_remove_page_ptdesc(tlb, ptdesc);
> > +}
> >  #endif /* CONFIG_MMU */
> >
> >  #endif /* _ASM_RISCV_PGALLOC_H */
> > --
> > 2.40.0
> >
> 
> Why is it necessary to convert to inline functions?

Hmm, it's not necessary but a plus, the inline version's readability and
maintainability is better than macros

Regards

