Return-Path: <linux-arch+bounces-8663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3E9B3BD8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD001F22DEA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B91FBF7E;
	Mon, 28 Oct 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0EiKDuM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCC1FB8BF;
	Mon, 28 Oct 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147389; cv=none; b=IQSOdxnDj4gvD6r/q5yyS/wljDg5DIoczqWQ1JzotDhrbAteCT++GhkBfV8Aw1dbIgLGNlQ4Xgt1bLiacMzARoZVoDCEZfwOdUYRsaLFDJu2sm5iN1E5qA0RYHMt3R3xN26SxRo/5C/s8id+qDIu7oPdcH64B7DS7gns1/+NrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147389; c=relaxed/simple;
	bh=DvIG8mx5p4gCKLw8ZRT1/LltnEqZm/Gd53WmXTOYSkw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=tyCOahiBH4pj2AuN5G7cx/A6xHmxGqpgza6FcwohaO46LhhiwOJSeYBzqbdKdmeSAnmj/0Vp+hgHhUNMmkI7smg/pYOGxMJXlWk4K9aP7g6iqTaUBU9lRJlDPhkKoJAslEKohhNTl6KbDZevO4YV7GM56epWKD/3yDsqNyoV7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0EiKDuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C392C4CEC3;
	Mon, 28 Oct 2024 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147389;
	bh=DvIG8mx5p4gCKLw8ZRT1/LltnEqZm/Gd53WmXTOYSkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0EiKDuMVkS7JZALZ3DbgZSzw59nbwO5ITtPqKRGUgFdE0dK30C7n4ETZEdkxM2sw
	 jdQsc7rZP+lY9ARibRbsRi4qlj8MsN4IArboghaxpNresREY/APBIVN5ZOZrQFGOHS
	 iX27xJ2gI25iB9XeYjT2VQd8FQEYi3VfaOU8CGdLSw/pszg9bUr8BIpeU3/vG7iP1H
	 2j37eAorBEBKxeA8HjiGfs1Dw0DPXCWx48hi3NTt23plJkvmrmhWyGJmMXVwtUK7av
	 qdLcMe0dY25NCPI0OLj2lrzoedNYWzsKo6Ib3JwAj8mHJhiBDOsLaX3bXeECteLcAX
	 tRt2mapE3A/8A==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:29:44 +0200
Message-Id: <D57Q27X7GB4O.3P6DI32885K96@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
Cc: "Suren Baghdasaryan" <surenb@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Jann Horn" <jannh@google.com>, "David Hildenbrand"
 <david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 "Muchun Song" <muchun.song@linux.dev>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Helge Deller" <deller@gmx.de>,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, <linux-alpha@vger.kernel.org>,
 <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux-kselftest@vger.kernel.org>,
 "Sidhartha Kumar" <sidhartha.kumar@oracle.com>, "Jeff Xu"
 <jeffxu@chromium.org>, "Christoph Hellwig" <hch@infradead.org>,
 <linux-api@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
X-Mailer: aerc 0.18.2
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>

On Wed Oct 23, 2024 at 7:24 PM EEST, Lorenzo Stoakes wrote:
> The existing generic pagewalk logic permits the walking of page tables,
> invoking callbacks at individual page table levels via user-provided
> mm_walk_ops callbacks.
>
> This is useful for traversing existing page table entries, but precludes
> the ability to establish new ones.
>
> Existing mechanism for performing a walk which also installs page table
> entries if necessary are heavily duplicated throughout the kernel, each
> with semantic differences from one another and largely unavailable for us=
e
> elsewhere.
>
> Rather than add yet another implementation, we extend the generic pagewal=
k
> logic to enable the installation of page table entries by adding a new
> install_pte() callback in mm_walk_ops. If this is specified, then upon
> encountering a missing page table entry, we allocate and install a new on=
e
> and continue the traversal.
>
> If a THP huge page is encountered at either the PMD or PUD level we split
> it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
> otherwise if there is only an ops->install_pte(), we avoid the unnecessar=
y
> split.

Just for interest: does this mean that the operation is always
"destructive" (i.e. modifying state) even when install_pte() does not
do anything, i.e. does the split alway happen despite what the callback
does? Not really expert on this but this paragraph won't leave me
alone :-)

>
> We do not support hugetlb at this stage.
>
> If this function returns an error, or an allocation fails during the
> operation, we abort the operation altogether. It is up to the caller to
> deal appropriately with partially populated page table ranges.
>
> If install_pte() is defined, the semantics of pte_entry() change - this
> callback is then only invoked if the entry already exists. This is a usef=
ul
> property, as it allows a caller to handle existing PTEs while installing
> new ones where necessary in the specified range.
>
> If install_pte() is not defined, then there is no functional difference t=
o
> this patch, so all existing logic will work precisely as it did before.
>
> As we only permit the installation of PTEs where a mapping does not alrea=
dy
> exist there is no need for TLB management, however we do invoke
> update_mmu_cache() for architectures which require manual maintenance of
> mappings for other CPUs.
>
> We explicitly do not allow the existing page walk API to expose this
> feature as it is dangerous and intended for internal mm use only. Therefo=
re
> we provide a new walk_page_range_mm() function exposed only to
> mm/internal.h.
>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/pagewalk.h |  18 +++-
>  mm/internal.h            |   6 ++
>  mm/pagewalk.c            | 227 +++++++++++++++++++++++++++------------
>  3 files changed, 182 insertions(+), 69 deletions(-)
>
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index f5eb5a32aeed..9700a29f8afb 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -25,12 +25,15 @@ enum page_walk_lock {
>   *			this handler is required to be able to handle
>   *			pmd_trans_huge() pmds.  They may simply choose to
>   *			split_huge_page() instead of handling it explicitly.
> - * @pte_entry:		if set, called for each PTE (lowest-level) entry,
> - *			including empty ones
> + * @pte_entry:		if set, called for each PTE (lowest-level) entry
> + *			including empty ones, except if @install_pte is set.
> + *			If @install_pte is set, @pte_entry is called only for
> + *			existing PTEs.
>   * @pte_hole:		if set, called for each hole at all levels,
>   *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
>   *			Any folded depths (where PTRS_PER_P?D is equal to 1)
> - *			are skipped.
> + *			are skipped. If @install_pte is specified, this will
> + *			not trigger for any populated ranges.
>   * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
>   *			function is called with the vma lock held, in order to
>   *			protect against a concurrent freeing of the pte_t* or
> @@ -51,6 +54,13 @@ enum page_walk_lock {
>   * @pre_vma:            if set, called before starting walk on a non-nul=
l vma.
>   * @post_vma:           if set, called after a walk on a non-null vma, p=
rovided
>   *                      that @pre_vma and the vma walk succeeded.
> + * @install_pte:        if set, missing page table entries are installed=
 and
> + *                      thus all levels are always walked in the specifi=
ed
> + *                      range. This callback is then invoked at the PTE =
level
> + *                      (having split any THP pages prior), providing th=
e PTE to
> + *                      install. If allocations fail, the walk is aborte=
d. This
> + *                      operation is only available for userland memory.=
 Not
> + *                      usable for hugetlb ranges.

Given that especially walk_page_range_novma() has bunch of call sites,
it would not hurt to mention here simply that only for mm-internal use
with not much other explanation.=20

>   *
>   * p?d_entry callbacks are called even if those levels are folded on a
>   * particular architecture/configuration.
> @@ -76,6 +86,8 @@ struct mm_walk_ops {
>  	int (*pre_vma)(unsigned long start, unsigned long end,
>  		       struct mm_walk *walk);
>  	void (*post_vma)(struct mm_walk *walk);
> +	int (*install_pte)(unsigned long addr, unsigned long next,
> +			   pte_t *ptep, struct mm_walk *walk);
>  	enum page_walk_lock walk_lock;
>  };
> =20
> diff --git a/mm/internal.h b/mm/internal.h
> index 508f7802dd2b..fb1fb0c984e4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
>  #include <linux/pagemap.h>
> +#include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> @@ -1451,4 +1452,9 @@ static inline void accept_page(struct page *page)
>  }
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
> =20
> +/* pagewalk.c */
> +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private);
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 5f9f01532e67..f3cbad384344 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -3,9 +3,14 @@
>  #include <linux/highmem.h>
>  #include <linux/sched.h>
>  #include <linux/hugetlb.h>
> +#include <linux/mmu_context.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> =20
> +#include <asm/tlbflush.h>
> +
> +#include "internal.h"
> +
>  /*
>   * We want to know the real level where a entry is located ignoring any
>   * folding of levels which may be happening. For example if p4d is folde=
d then
> @@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned l=
ong addr,
>  	int err =3D 0;
> =20
>  	for (;;) {
> -		err =3D ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> -		if (err)
> -		       break;
> +		if (ops->install_pte && pte_none(ptep_get(pte))) {
> +			pte_t new_pte;
> +
> +			err =3D ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> +					       walk);
> +			if (err)
> +				break;
> +
> +			set_pte_at(walk->mm, addr, pte, new_pte);
> +			/* Non-present before, so for arches that need it. */
> +			if (!WARN_ON_ONCE(walk->no_vma))
> +				update_mmu_cache(walk->vma, addr, pte);
> +		} else {
> +			err =3D ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> +			if (err)
> +				break;
> +		}
>  		if (addr >=3D end - PAGE_SIZE)
>  			break;
>  		addr +=3D PAGE_SIZE;
> @@ -89,11 +108,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long =
addr, unsigned long end,
>  again:
>  		next =3D pmd_addr_end(addr, end);
>  		if (pmd_none(*pmd)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err =3D __pte_alloc(walk->mm, pmd);
> +			else if (ops->pte_hole)
>  				err =3D ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
> =20
>  		walk->action =3D ACTION_SUBTREE;
> @@ -109,18 +131,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long=
 addr, unsigned long end,
> =20
>  		if (walk->action =3D=3D ACTION_AGAIN)
>  			goto again;
> -
> -		/*
> -		 * Check this here so we only break down trans_huge
> -		 * pages when we _need_ to
> -		 */
> -		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
> -		    walk->action =3D=3D ACTION_CONTINUE ||
> -		    !(ops->pte_entry))
> +		if (walk->action =3D=3D ACTION_CONTINUE)
>  			continue;
> +		if (!ops->install_pte && !ops->pte_entry)
> +			continue; /* Nothing to do. */
> +		if (!ops->pte_entry && ops->install_pte &&
> +		    pmd_present(*pmd) &&
> +		    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
> +			continue; /* Avoid unnecessary split. */
> =20
>  		if (walk->vma)
>  			split_huge_pmd(walk->vma, pmd, addr);
> +		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
> +			continue; /* Nothing to do. */
> =20
>  		err =3D walk_pte_range(pmd, addr, next, walk);
>  		if (err)
> @@ -148,11 +171,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
>   again:
>  		next =3D pud_addr_end(addr, end);
>  		if (pud_none(*pud)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err =3D __pmd_alloc(walk->mm, pud, addr);
> +			else if (ops->pte_hole)
>  				err =3D ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
> =20
>  		walk->action =3D ACTION_SUBTREE;
> @@ -164,14 +190,20 @@ static int walk_pud_range(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
> =20
>  		if (walk->action =3D=3D ACTION_AGAIN)
>  			goto again;
> -
> -		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
> -		    walk->action =3D=3D ACTION_CONTINUE ||
> -		    !(ops->pmd_entry || ops->pte_entry))
> +		if (walk->action =3D=3D ACTION_CONTINUE)
>  			continue;
> +		if (!ops->install_pte && !ops->pte_entry && !ops->pmd_entry)
> +			continue;  /* Nothing to do. */
> +		if (!ops->pmd_entry && !ops->pte_entry && ops->install_pte &&
> +		    pud_present(*pud) &&
> +		    (pud_trans_huge(*pud) || pud_devmap(*pud)))
> +			continue; /* Avoid unnecessary split. */
> =20
>  		if (walk->vma)
>  			split_huge_pud(walk->vma, pud, addr);
> +		else if (pud_leaf(*pud) || !pud_present(*pud))
> +			continue; /* Nothing to do. */
> +
>  		if (pud_none(*pud))
>  			goto again;
> =20
> @@ -196,18 +228,22 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long=
 addr, unsigned long end,
>  	do {
>  		next =3D p4d_addr_end(addr, end);
>  		if (p4d_none_or_clear_bad(p4d)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err =3D __pud_alloc(walk->mm, p4d, addr);
> +			else if (ops->pte_hole)
>  				err =3D ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>  		if (ops->p4d_entry) {
>  			err =3D ops->p4d_entry(p4d, addr, next, walk);
>  			if (err)
>  				break;
>  		}
> -		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
> +		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry ||
> +		    ops->install_pte)
>  			err =3D walk_pud_range(p4d, addr, next, walk);
>  		if (err)
>  			break;
> @@ -231,18 +267,22 @@ static int walk_pgd_range(unsigned long addr, unsig=
ned long end,
>  	do {
>  		next =3D pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err =3D __p4d_alloc(walk->mm, pgd, addr);
> +			else if (ops->pte_hole)
>  				err =3D ops->pte_hole(addr, next, 0, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>  		if (ops->pgd_entry) {
>  			err =3D ops->pgd_entry(pgd, addr, next, walk);
>  			if (err)
>  				break;
>  		}
> -		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_ent=
ry)
> +		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
> +		    ops->pte_entry || ops->install_pte)
>  			err =3D walk_p4d_range(pgd, addr, next, walk);
>  		if (err)
>  			break;
> @@ -334,6 +374,11 @@ static int __walk_page_range(unsigned long start, un=
signed long end,
>  	int err =3D 0;
>  	struct vm_area_struct *vma =3D walk->vma;
>  	const struct mm_walk_ops *ops =3D walk->ops;
> +	bool is_hugetlb =3D is_vm_hugetlb_page(vma);
> +
> +	/* We do not support hugetlb PTE installation. */
> +	if (ops->install_pte && is_hugetlb)
> +		return -EINVAL;
> =20
>  	if (ops->pre_vma) {
>  		err =3D ops->pre_vma(start, end, walk);
> @@ -341,7 +386,7 @@ static int __walk_page_range(unsigned long start, uns=
igned long end,
>  			return err;
>  	}
> =20
> -	if (is_vm_hugetlb_page(vma)) {
> +	if (is_hugetlb) {
>  		if (ops->hugetlb_entry)
>  			err =3D walk_hugetlb_range(start, end, walk);
>  	} else
> @@ -380,47 +425,14 @@ static inline void process_vma_walk_lock(struct vm_=
area_struct *vma,
>  #endif
>  }
> =20
> -/**
> - * walk_page_range - walk page table with caller specific callbacks
> - * @mm:		mm_struct representing the target process of page table walk
> - * @start:	start address of the virtual address range
> - * @end:	end address of the virtual address range
> - * @ops:	operation to call during the walk
> - * @private:	private data for callbacks' usage
> - *
> - * Recursively walk the page table tree of the process represented by @m=
m
> - * within the virtual address range [@start, @end). During walking, we c=
an do
> - * some caller-specific works for each entry, by setting up pmd_entry(),
> - * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of =
these
> - * callbacks, the associated entries/pages are just ignored.
> - * The return values of these callbacks are commonly defined like below:
> - *
> - *  - 0  : succeeded to handle the current entry, and if you don't reach=
 the
> - *         end address yet, continue to walk.
> - *  - >0 : succeeded to handle the current entry, and return to the call=
er
> - *         with caller specific value.
> - *  - <0 : failed to handle the current entry, and return to the caller
> - *         with error code.
> - *
> - * Before starting to walk page table, some callers want to check whethe=
r
> - * they really want to walk over the current vma, typically by checking
> - * its vm_flags. walk_page_test() and @ops->test_walk() are used for thi=
s
> - * purpose.
> - *
> - * If operations need to be staged before and committed after a vma is w=
alked,
> - * there are two callbacks, pre_vma() and post_vma(). Note that post_vma=
(),
> - * since it is intended to handle commit-type operations, can't return a=
ny
> - * errors.
> - *
> - * struct mm_walk keeps current values of some common data like vma and =
pmd,
> - * which are useful for the access from callbacks. If you want to pass s=
ome
> - * caller-specific data to callbacks, @private should be helpful.
> +/*
> + * See the comment for walk_page_range(), this performs the heavy liftin=
g of the
> + * operation, only sets no restrictions on how the walk proceeds.
>   *
> - * Locking:
> - *   Callers of walk_page_range() and walk_page_vma() should hold @mm->m=
map_lock,
> - *   because these function traverse vma list and/or access to vma's dat=
a.
> + * We usually restrict the ability to install PTEs, but this functionali=
ty is
> + * available to internal memory management code and provided in mm/inter=
nal.h.
>   */
> -int walk_page_range(struct mm_struct *mm, unsigned long start,
> +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private)
>  {
> @@ -479,6 +491,80 @@ int walk_page_range(struct mm_struct *mm, unsigned l=
ong start,
>  	return err;
>  }
> =20
> +/*
> + * Determine if the walk operations specified are permitted to be used f=
or a
> + * page table walk.
> + *
> + * This check is performed on all functions which are parameterised by w=
alk
> + * operations and exposed in include/linux/pagewalk.h.
> + *
> + * Internal memory management code can use the walk_page_range_mm() func=
tion to
> + * be able to use all page walking operations.
> + */
> +static bool check_ops_valid(const struct mm_walk_ops *ops)
> +{
> +	/*
> +	 * The installation of PTEs is solely under the control of memory
> +	 * management logic and subject to many subtle locking, security and
> +	 * cache considerations so we cannot permit other users to do so, and
> +	 * certainly not for exported symbols.
> +	 */
> +	if (ops->install_pte)
> +		return false;
> +
> +	return true;

or "return !!(ops->install_pte);"

> +}

Alternatively one could consider defining "struct mm_walk_internal_ops",
which would be only available in internal.h but I guess there is good
reasons to do it way it is.

> +
> +/**
> + * walk_page_range - walk page table with caller specific callbacks
> + * @mm:		mm_struct representing the target process of page table walk
> + * @start:	start address of the virtual address range
> + * @end:	end address of the virtual address range
> + * @ops:	operation to call during the walk
> + * @private:	private data for callbacks' usage
> + *
> + * Recursively walk the page table tree of the process represented by @m=
m
> + * within the virtual address range [@start, @end). During walking, we c=
an do
> + * some caller-specific works for each entry, by setting up pmd_entry(),
> + * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of =
these
> + * callbacks, the associated entries/pages are just ignored.
> + * The return values of these callbacks are commonly defined like below:
> + *
> + *  - 0  : succeeded to handle the current entry, and if you don't reach=
 the
> + *         end address yet, continue to walk.
> + *  - >0 : succeeded to handle the current entry, and return to the call=
er
> + *         with caller specific value.
> + *  - <0 : failed to handle the current entry, and return to the caller
> + *         with error code.
> + *
> + * Before starting to walk page table, some callers want to check whethe=
r
> + * they really want to walk over the current vma, typically by checking
> + * its vm_flags. walk_page_test() and @ops->test_walk() are used for thi=
s
> + * purpose.
> + *
> + * If operations need to be staged before and committed after a vma is w=
alked,
> + * there are two callbacks, pre_vma() and post_vma(). Note that post_vma=
(),
> + * since it is intended to handle commit-type operations, can't return a=
ny
> + * errors.
> + *
> + * struct mm_walk keeps current values of some common data like vma and =
pmd,
> + * which are useful for the access from callbacks. If you want to pass s=
ome
> + * caller-specific data to callbacks, @private should be helpful.
> + *
> + * Locking:
> + *   Callers of walk_page_range() and walk_page_vma() should hold @mm->m=
map_lock,
> + *   because these function traverse vma list and/or access to vma's dat=
a.
> + */
> +int walk_page_range(struct mm_struct *mm, unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private)
> +{
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> +
> +	return walk_page_range_mm(mm, start, end, ops, private);
> +}
> +
>  /**
>   * walk_page_range_novma - walk a range of pagetables not backed by a vm=
a
>   * @mm:		mm_struct representing the target process of page table walk
> @@ -494,7 +580,7 @@ int walk_page_range(struct mm_struct *mm, unsigned lo=
ng start,
>   * walking the kernel pages tables or page tables for firmware.
>   *
>   * Note: Be careful to walk the kernel pages tables, the caller may be n=
eed to
> - * take other effective approache (mmap lock may be insufficient) to pre=
vent
> + * take other effective approaches (mmap lock may be insufficient) to pr=
event
>   * the intermediate kernel page tables belonging to the specified addres=
s range
>   * from being freed (e.g. memory hot-remove).
>   */
> @@ -513,6 +599,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsig=
ned long start,
> =20
>  	if (start >=3D end || !walk.mm)
>  		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> =20
>  	/*
>  	 * 1) For walking the user virtual address space:
> @@ -556,6 +644,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, u=
nsigned long start,
>  		return -EINVAL;
>  	if (start < vma->vm_start || end > vma->vm_end)
>  		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> =20
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
>  	process_vma_walk_lock(vma, ops->walk_lock);
> @@ -574,6 +664,8 @@ int walk_page_vma(struct vm_area_struct *vma, const s=
truct mm_walk_ops *ops,
> =20
>  	if (!walk.mm)
>  		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> =20
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
>  	process_vma_walk_lock(vma, ops->walk_lock);
> @@ -623,6 +715,9 @@ int walk_page_mapping(struct address_space *mapping, =
pgoff_t first_index,
>  	unsigned long start_addr, end_addr;
>  	int err =3D 0;
> =20
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> +
>  	lockdep_assert_held(&mapping->i_mmap_rwsem);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
>  				  first_index + nr - 1) {

So I took a random patch set in order to learn how to compile Fedora Ark
kernel out of any upstream tree (mm in this case), thus making noise
here.

With this goal, which mainly to be able to do such thing once or twice
per release cycle:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

