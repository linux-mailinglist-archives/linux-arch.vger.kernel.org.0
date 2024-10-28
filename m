Return-Path: <linux-arch+bounces-8666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A599B3C20
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C5F1F22D54
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACE1C3F10;
	Mon, 28 Oct 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHXqyY24"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707B18D649;
	Mon, 28 Oct 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148330; cv=none; b=IJxZssee116eawPBdygnqjzpBO2BMVwjKR8I1QYE5nc7RiAVw/a663B+Gdg/lfKVIllcuVGbMlBC5Nw7qPbUkA8GO1ieB/zngYPmrYd2rSRoi8kbZ9wxIHUwE9weYNgylJ1X4qWsZUvGKwTcDqq2Au7yuzQxtuh7p//Jm3kIghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148330; c=relaxed/simple;
	bh=aaIPPFaPZSsOgsVJW6n+iBEeGJkAyi1OUkgKKwtKqMM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UL3+HCPw78pWRnrDYQ7KIZEnc1ufVG/iqHGOVkRVim+Y0E3x4NnrIzyJYJsTqBDgwP5yk28p6U1a9Vg2YFmDyGbbuvQMXgyVSodo7UY6+6lNPkpH6BaMNqa/wr4FqsVEd85NH1Ywe0JdJG1TQYEUMRqR3I+ZT82OFaE0xxFqhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHXqyY24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0DCC4CEC3;
	Mon, 28 Oct 2024 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148330;
	bh=aaIPPFaPZSsOgsVJW6n+iBEeGJkAyi1OUkgKKwtKqMM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=dHXqyY24b6DyRmb+UsPCKjIArBlee7N1lWmLQjsVcbgOAEzwC4VwP9Ycv06ieBQKN
	 L1SI8nbEThRTIRLzy1b4aXpOc3ykEItYFIm3mtJhYCSEOXUJp/3bNghRt3yT7xjA88
	 vLICHidCv2Q3dqa1+Z3959+8PtePwJ/x01YfLgvtzaNexh9oVfxHqh0lMiUPVHgxt5
	 F0UiIprzEVbm5NC3j10215pnLjjVA+23G9GfZyBtIEsRBtbGplK7jAPr9c192R7HgP
	 BtlmeV+rW7nLAc2cQn+Lrxy5SSvmYfZ8yjkoJZnV+yMkdmusXA+g0mvFmyvaIAYhWj
	 R87gxRiAYapYQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:45:26 +0200
Message-Id: <D57QE8G8Z274.F911DRNX0H02@kernel.org>
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
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>

On Wed Oct 23, 2024 at 7:24 PM EEST, Lorenzo Stoakes wrote:
> Implement a new lightweight guard page feature, that is regions of userla=
nd
> virtual memory that, when accessed, cause a fatal signal to arise.
>
> Currently users must establish PROT_NONE ranges to achieve this.

A bit off-topic but other hack with PROT_NONE is to allocate naturally
aligned ranges:

1. mmap() of 2*N size with PROT_NONE.
2. mmap(MAP_FIXED) of N size from that range.


>
> However this is very costly memory-wise - we need a VMA for each and ever=
y
> one of these regions AND they become unmergeable with surrounding VMAs.
>
> In addition repeated mmap() calls require repeated kernel context switche=
s
> and contention of the mmap lock to install these ranges, potentially also
> having to unmap memory if installed over existing ranges.
>
> The lightweight guard approach eliminates the VMA cost altogether - rathe=
r
> than establishing a PROT_NONE VMA, it operates at the level of page table
> entries - establishing PTE markers such that accesses to them cause a fau=
lt
> followed by a SIGSGEV signal being raised.
>
> This is achieved through the PTE marker mechanism, which we have already
> extended to provide PTE_MARKER_GUARD, which we installed via the generic
> page walking logic which we have extended for this purpose.
>
> These guard ranges are established with MADV_GUARD_INSTALL. If the range =
in
> which they are installed contain any existing mappings, they will be
> zapped, i.e. free the range and unmap memory (thus mimicking the behaviou=
r
> of MADV_DONTNEED in this respect).
>
> Any existing guard entries will be left untouched. There is therefore no
> nesting of guarded pages.
>
> Guarded ranges are NOT cleared by MADV_DONTNEED nor MADV_FREE (in both
> instances the memory range may be reused at which point a user would expe=
ct
> guards to still be in place), but they are cleared via MADV_GUARD_REMOVE,
> process teardown or unmapping of memory ranges.
>
> The guard property can be removed from ranges via MADV_GUARD_REMOVE. The
> ranges over which this is applied, should they contain non-guard entries,
> will be untouched, with only guard entries being cleared.
>
> We permit this operation on anonymous memory only, and only VMAs which ar=
e
> non-special, non-huge and not mlock()'d (if we permitted this we'd have t=
o
> drop locked pages which would be rather counterintuitive).
>
> Racing page faults can cause repeated attempts to install guard pages tha=
t
> are interrupted, result in a zap, and this process can end up being
> repeated. If this happens more than would be expected in normal operation=
,
> we rescind locks and retry the whole thing, which avoids lock contention =
in
> this scenario.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/alpha/include/uapi/asm/mman.h     |   3 +
>  arch/mips/include/uapi/asm/mman.h      |   3 +
>  arch/parisc/include/uapi/asm/mman.h    |   3 +
>  arch/xtensa/include/uapi/asm/mman.h    |   3 +
>  include/uapi/asm-generic/mman-common.h |   3 +
>  mm/internal.h                          |   6 +
>  mm/madvise.c                           | 225 +++++++++++++++++++++++++
>  mm/mseal.c                             |   1 +
>  8 files changed, 247 insertions(+)
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi=
/asm/mman.h
> index 763929e814e9..1e700468a685 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -78,6 +78,9 @@
> =20
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> =20
> +#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
> +#define MADV_GUARD_REMOVE 103		/* unguard range */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
> =20
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/a=
sm/mman.h
> index 9c48d9a21aa0..b700dae28c48 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -105,6 +105,9 @@
> =20
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> =20
> +#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
> +#define MADV_GUARD_REMOVE 103		/* unguard range */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
> =20
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/ua=
pi/asm/mman.h
> index 68c44f99bc93..b6a709506987 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -75,6 +75,9 @@
>  #define MADV_HWPOISON     100		/* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> =20
> +#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
> +#define MADV_GUARD_REMOVE 103		/* unguard range */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
> =20
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/ua=
pi/asm/mman.h
> index 1ff0c858544f..99d4ccee7f6e 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -113,6 +113,9 @@
> =20
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> =20
> +#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
> +#define MADV_GUARD_REMOVE 103		/* unguard range */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
> =20
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-ge=
neric/mman-common.h
> index 6ce1f1ceb432..1ea2c4c33b86 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -79,6 +79,9 @@
> =20
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
> =20
> +#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
> +#define MADV_GUARD_REMOVE 103		/* unguard range */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
> =20
> diff --git a/mm/internal.h b/mm/internal.h
> index fb1fb0c984e4..fcf08b5e64dc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -423,6 +423,12 @@ extern unsigned long highest_memmap_pfn;
>   */
>  #define MAX_RECLAIM_RETRIES 16
> =20
> +/*
> + * Maximum number of attempts we make to install guard pages before we g=
ive up
> + * and return -ERESTARTNOINTR to have userspace try again.
> + */
> +#define MAX_MADVISE_GUARD_RETRIES 3
> +
>  /*
>   * in mm/vmscan.c:
>   */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e871a72a6c32..48eba25e25fe 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -60,6 +60,8 @@ static int madvise_need_mmap_write(int behavior)
>  	case MADV_POPULATE_READ:
>  	case MADV_POPULATE_WRITE:
>  	case MADV_COLLAPSE:
> +	case MADV_GUARD_INSTALL:
> +	case MADV_GUARD_REMOVE:
>  		return 0;
>  	default:
>  		/* be safe, default to 1. list exceptions explicitly */
> @@ -1017,6 +1019,214 @@ static long madvise_remove(struct vm_area_struct =
*vma,
>  	return error;
>  }
> =20
> +static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_lo=
cked)
> +{
> +	vm_flags_t disallowed =3D VM_SPECIAL | VM_HUGETLB;
> +
> +	/*
> +	 * A user could lock after setting a guard range but that's fine, as
> +	 * they'd not be able to fault in. The issue arises when we try to zap
> +	 * existing locked VMAs. We don't want to do that.
> +	 */
> +	if (!allow_locked)
> +		disallowed |=3D VM_LOCKED;
> +
> +	if (!vma_is_anonymous(vma))
> +		return false;
> +
> +	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) !=3D VM_MAYWRITE)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool is_guard_pte_marker(pte_t ptent)
> +{
> +	return is_pte_marker(ptent) &&
> +		is_guard_swp_entry(pte_to_swp_entry(ptent));
> +}
> +
> +static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t pudval =3D pudp_get(pud);
> +
> +	/* If huge return >0 so we abort the operation + zap. */
> +	return pud_trans_huge(pudval) || pud_devmap(pudval);
> +}
> +
> +static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t pmdval =3D pmdp_get(pmd);
> +
> +	/* If huge return >0 so we abort the operation + zap. */
> +	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
> +}
> +
> +static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t pteval =3D ptep_get(pte);
> +	unsigned long *nr_pages =3D (unsigned long *)walk->private;
> +
> +	/* If there is already a guard page marker, we have nothing to do. */
> +	if (is_guard_pte_marker(pteval)) {
> +		(*nr_pages)++;
> +
> +		return 0;
> +	}
> +
> +	/* If populated return >0 so we abort the operation + zap. */
> +	return 1;
> +}
> +
> +static int guard_install_set_pte(unsigned long addr, unsigned long next,
> +				 pte_t *ptep, struct mm_walk *walk)
> +{
> +	unsigned long *nr_pages =3D (unsigned long *)walk->private;
> +
> +	/* Simply install a PTE marker, this causes segfault on access. */
> +	*ptep =3D make_pte_marker(PTE_MARKER_GUARD);
> +	(*nr_pages)++;
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops guard_install_walk_ops =3D {
> +	.pud_entry		=3D guard_install_pud_entry,
> +	.pmd_entry		=3D guard_install_pmd_entry,
> +	.pte_entry		=3D guard_install_pte_entry,
> +	.install_pte		=3D guard_install_set_pte,
> +	.walk_lock		=3D PGWALK_RDLOCK,
> +};
> +
> +static long madvise_guard_install(struct vm_area_struct *vma,
> +				 struct vm_area_struct **prev,
> +				 unsigned long start, unsigned long end)
> +{
> +	long err;
> +	int i;
> +
> +	*prev =3D vma;
> +	if (!is_valid_guard_vma(vma, /* allow_locked =3D */false))
> +		return -EINVAL;
> +
> +	/*
> +	 * If we install guard markers, then the range is no longer
> +	 * empty from a page table perspective and therefore it's
> +	 * appropriate to have an anon_vma.
> +	 *
> +	 * This ensures that on fork, we copy page tables correctly.
> +	 */
> +	err =3D anon_vma_prepare(vma);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Optimistically try to install the guard marker pages first. If any
> +	 * non-guard pages are encountered, give up and zap the range before
> +	 * trying again.
> +	 *
> +	 * We try a few times before giving up and releasing back to userland t=
o
> +	 * loop around, releasing locks in the process to avoid contention. Thi=
s
> +	 * would only happen if there was a great many racing page faults.
> +	 *
> +	 * In most cases we should simply install the guard markers immediately
> +	 * with no zap or looping.
> +	 */
> +	for (i =3D 0; i < MAX_MADVISE_GUARD_RETRIES; i++) {
> +		unsigned long nr_pages =3D 0;
> +
> +		/* Returns < 0 on error, =3D=3D 0 if success, > 0 if zap needed. */
> +		err =3D walk_page_range_mm(vma->vm_mm, start, end,
> +					 &guard_install_walk_ops, &nr_pages);
> +		if (err < 0)
> +			return err;
> +
> +		if (err =3D=3D 0) {
> +			unsigned long nr_expected_pages =3D PHYS_PFN(end - start);
> +
> +			VM_WARN_ON(nr_pages !=3D nr_expected_pages);
> +			return 0;
> +		}
> +
> +		/*
> +		 * OK some of the range have non-guard pages mapped, zap
> +		 * them. This leaves existing guard pages in place.
> +		 */
> +		zap_page_range_single(vma, start, end - start, NULL);
> +	}
> +
> +	/*
> +	 * We were unable to install the guard pages due to being raced by page
> +	 * faults. This should not happen ordinarily. We return to userspace an=
d
> +	 * immediately retry, relieving lock contention.
> +	 */
> +	return -ERESTARTNOINTR;
> +}
> +
> +static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
> +				  unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t pudval =3D pudp_get(pud);
> +
> +	/* If huge, cannot have guard pages present, so no-op - skip. */
> +	if (pud_trans_huge(pudval) || pud_devmap(pudval))
> +		walk->action =3D ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
> +				  unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t pmdval =3D pmdp_get(pmd);
> +
> +	/* If huge, cannot have guard pages present, so no-op - skip. */
> +	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
> +		walk->action =3D ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
> +				  unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t ptent =3D ptep_get(pte);
> +
> +	if (is_guard_pte_marker(ptent)) {
> +		/* Simply clear the PTE marker. */
> +		pte_clear_not_present_full(walk->mm, addr, pte, false);
> +		update_mmu_cache(walk->vma, addr, pte);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops guard_remove_walk_ops =3D {
> +	.pud_entry		=3D guard_remove_pud_entry,
> +	.pmd_entry		=3D guard_remove_pmd_entry,
> +	.pte_entry		=3D guard_remove_pte_entry,
> +	.walk_lock		=3D PGWALK_RDLOCK,
> +};
> +
> +static long madvise_guard_remove(struct vm_area_struct *vma,
> +				 struct vm_area_struct **prev,
> +				 unsigned long start, unsigned long end)
> +{
> +	*prev =3D vma;
> +	/*
> +	 * We're ok with removing guards in mlock()'d ranges, as this is a
> +	 * non-destructive action.
> +	 */
> +	if (!is_valid_guard_vma(vma, /* allow_locked =3D */true))
> +		return -EINVAL;
> +
> +	return walk_page_range(vma->vm_mm, start, end,
> +			       &guard_remove_walk_ops, NULL);
> +}
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with i=
ts own
> @@ -1098,6 +1308,10 @@ static int madvise_vma_behavior(struct vm_area_str=
uct *vma,
>  		break;
>  	case MADV_COLLAPSE:
>  		return madvise_collapse(vma, prev, start, end);
> +	case MADV_GUARD_INSTALL:
> +		return madvise_guard_install(vma, prev, start, end);
> +	case MADV_GUARD_REMOVE:
> +		return madvise_guard_remove(vma, prev, start, end);
>  	}
> =20
>  	anon_name =3D anon_vma_name(vma);
> @@ -1197,6 +1411,8 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DODUMP:
>  	case MADV_WIPEONFORK:
>  	case MADV_KEEPONFORK:
> +	case MADV_GUARD_INSTALL:
> +	case MADV_GUARD_REMOVE:
>  #ifdef CONFIG_MEMORY_FAILURE
>  	case MADV_SOFT_OFFLINE:
>  	case MADV_HWPOISON:
> @@ -1490,6 +1706,15 @@ static ssize_t vector_madvise(struct mm_struct *mm=
, struct iov_iter *iter,
>  	while (iov_iter_count(iter)) {
>  		ret =3D do_madvise(mm, (unsigned long)iter_iov_addr(iter),
>  				 iter_iov_len(iter), behavior);
> +		/*
> +		 * We cannot return this, as we instead return the number of
> +		 * successful operations. Since all this would achieve in a
> +		 * single madvise() invocation is to re-enter the syscall, and
> +		 * we have already rescinded locks, it should be no problem to
> +		 * simply try again.
> +		 */
> +		if (ret =3D=3D -ERESTARTNOINTR)
> +			continue;
>  		if (ret < 0)
>  			break;
>  		iov_iter_advance(iter, iter_iov_len(iter));
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..81d6e980e8a9 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
>  	case MADV_REMOVE:
>  	case MADV_DONTFORK:
>  	case MADV_WIPEONFORK:
> +	case MADV_GUARD_INSTALL:
>  		return true;
>  	}
> =20

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

