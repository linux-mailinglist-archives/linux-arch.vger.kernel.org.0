Return-Path: <linux-arch+bounces-13019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75199B193F9
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 14:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B4F16C5EA
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60425334B;
	Sun,  3 Aug 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GaeQDCu9"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B210A48;
	Sun,  3 Aug 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222761; cv=none; b=HjjbJUNILcUhAaMYuniIP8jlncHEJerqaYKXs25KKF20fddLN52ZFcOV2cmkoXDy8zs8zJGfnuFIcNmGby8p0OsS6LLx2I7UVd1ZGOv9eWZrE0vCCyGoLDLpc4FZmnijjp667AVp+ELpeDL1DpurP01dxz3Agt6TDFac9HHzEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222761; c=relaxed/simple;
	bh=Vh0esj297xbhWoujFLjXOWf4MIrOQS6wuLPdWPc9ikc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvkZ0MMSSkANcMRVC1aqw2NYECgiag3UCyOReIjmBr/kgVmixq0kDJRzBsn6IJWcqOhOElkGMD4NUNLG7J4ue2dR6wNGAAzZKsfU9h8+BePNU/jPQtCI+78Fg5zZofpQQWi/EiJ8RbZSNgmAheXmlZJc4Pz4gCo+T2ugVyk14sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GaeQDCu9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4B0pN/JVFT6zpDZpE67T74gedNOFDRMip2sKdLIkDKM=; t=1754222757; x=1754827557; 
	b=GaeQDCu9IXHgJhbOBWzAeC963fo6uxcmpyiDahv48EszEO1qtZs9aVwnat+Rzy+qgNFdUvrEHnD
	8bftFC8Egzj/mrmo5aZ60LVQNwR3CDnbEDm5lxQlv6w/5OKPDwzZqqpAdVyermSKJA9q/SW57dimC
	X7VyWNIBaqoGTyd/UZpWlAPfz6p6QO3Zoa4zvRLBezpC2bcrYiUeu91gCxzcobAnp/1JmfPwUaU2J
	TXWzkJl/lhKtbccnT3INTx7dVvuZLyn1OVOg1lGEBcUzuQuwJOM7RK4jKou3fqr1DGuwzZXZm3VzT
	bLal7ggDO0lYk2cpYJrkF2Dr4yBlmlxIcfog==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uiXTF-000000038cX-25d4; Sun, 03 Aug 2025 14:05:45 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uiXTF-00000001t9E-0qh5; Sun, 03 Aug 2025 14:05:45 +0200
Message-ID: <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 25/36] sparc64: Implement the new page table range API
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S. Miller"	
 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson	
 <andreas@gaisler.com>, Rod Schnell <rods@mw-radio.com>, Sam James
 <sam@gentoo.org>,  Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Sun, 03 Aug 2025 14:05:44 +0200
In-Reply-To: <20230315051444.3229621-26-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
	 <20230315051444.3229621-26-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Matthew,

On Wed, 2023-03-15 at 05:14 +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().  Convert the PG_dcache_dirty flag from being
> per-page to per-folio.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/include/asm/cacheflush_64.h | 18 ++++--
>  arch/sparc/include/asm/pgtable_64.h    | 24 ++++++--
>  arch/sparc/kernel/smp_64.c             | 56 +++++++++++-------
>  arch/sparc/mm/init_64.c                | 78 +++++++++++++++-----------
>  arch/sparc/mm/tlb.c                    |  5 +-
>  5 files changed, 116 insertions(+), 65 deletions(-)
>=20
> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/=
asm/cacheflush_64.h
> index b9341836597e..a9a719f04d06 100644
> --- a/arch/sparc/include/asm/cacheflush_64.h
> +++ b/arch/sparc/include/asm/cacheflush_64.h
> @@ -35,20 +35,26 @@ void flush_icache_range(unsigned long start, unsigned=
 long end);
>  void __flush_icache_page(unsigned long);
> =20
>  void __flush_dcache_page(void *addr, int flush_icache);
> -void flush_dcache_page_impl(struct page *page);
> +void flush_dcache_folio_impl(struct folio *folio);
>  #ifdef CONFIG_SMP
> -void smp_flush_dcache_page_impl(struct page *page, int cpu);
> -void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
> +void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
> +void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
>  #else
> -#define smp_flush_dcache_page_impl(page,cpu) flush_dcache_page_impl(page=
)
> -#define flush_dcache_page_all(mm,page) flush_dcache_page_impl(page)
> +#define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(=
folio)
> +#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
>  #endif
> =20
>  void __flush_dcache_range(unsigned long start, unsigned long end);
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -void flush_dcache_page(struct page *page);
> +void flush_dcache_folio(struct folio *folio);
> +#define flush_dcache_folio flush_dcache_folio
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
> =20
>  #define flush_icache_page(vma, pg)	do { } while(0)
> +#define flush_icache_pages(vma, pg, nr)	do { } while(0)
> =20
>  void flush_ptrace_access(struct vm_area_struct *, struct page *,
>  			 unsigned long uaddr, void *kaddr,
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index 2dc8d4641734..49c37000e1b1 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -911,8 +911,19 @@ static inline void __set_pte_at(struct mm_struct *mm=
, unsigned long addr,
>  	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm, PAGE_SHIFT);
>  }
> =20
> -#define set_pte_at(mm,addr,ptep,pte)	\
> -	__set_pte_at((mm), (addr), (ptep), (pte), 0)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	for (;;) {
> +		__set_pte_at(mm, addr, ptep, pte, 0);
> +		if (--nr =3D=3D 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) +=3D PAGE_SIZE;
> +		addr +=3D PAGE_SIZE;
> +	}
> +}
> +#define set_ptes set_ptes
> =20
>  #define pte_clear(mm,addr,ptep)		\
>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
> @@ -931,8 +942,8 @@ static inline void __set_pte_at(struct mm_struct *mm,=
 unsigned long addr,
>  									\
>  		if (pfn_valid(this_pfn) &&				\
>  		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
> -			flush_dcache_page_all(current->mm,		\
> -					      pfn_to_page(this_pfn));	\
> +			flush_dcache_folio_all(current->mm,		\
> +				page_folio(pfn_to_page(this_pfn)));	\
>  	}								\
>  	newpte;								\
>  })
> @@ -947,7 +958,10 @@ struct seq_file;
>  void mmu_info(struct seq_file *);
> =20
>  struct vm_area_struct;
> -void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
> +void update_mmu_cache_range(struct vm_area_struct *, unsigned long addr,
> +		pte_t *ptep, unsigned int nr);
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr=
,
>  			  pmd_t *pmd);
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index a55295d1b924..90ef8677ac89 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -921,20 +921,26 @@ extern unsigned long xcall_flush_dcache_page_cheeta=
h;
>  #endif
>  extern unsigned long xcall_flush_dcache_page_spitfire;
> =20
> -static inline void __local_flush_dcache_page(struct page *page)
> +static inline void __local_flush_dcache_folio(struct folio *folio)
>  {
> +	unsigned int i, nr =3D folio_nr_pages(folio);
> +
>  #ifdef DCACHE_ALIASING_POSSIBLE
> -	__flush_dcache_page(page_address(page),
> +	for (i =3D 0; i < nr; i++)
> +		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
>  			    ((tlb_type =3D=3D spitfire) &&
> -			     page_mapping_file(page) !=3D NULL));
> +			     folio_flush_mapping(folio) !=3D NULL));
>  #else
> -	if (page_mapping_file(page) !=3D NULL &&
> -	    tlb_type =3D=3D spitfire)
> -		__flush_icache_page(__pa(page_address(page)));
> +	if (folio_flush_mapping(folio) !=3D NULL &&
> +	    tlb_type =3D=3D spitfire) {
> +		unsigned long pfn =3D folio_pfn(folio)
> +		for (i =3D 0; i < nr; i++)
> +			__flush_icache_page((pfn + i) * PAGE_SIZE);
> +	}
>  #endif
>  }
> =20
> -void smp_flush_dcache_page_impl(struct page *page, int cpu)
> +void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
>  {
>  	int this_cpu;
> =20
> @@ -948,14 +954,14 @@ void smp_flush_dcache_page_impl(struct page *page, =
int cpu)
>  	this_cpu =3D get_cpu();
> =20
>  	if (cpu =3D=3D this_cpu) {
> -		__local_flush_dcache_page(page);
> +		__local_flush_dcache_folio(folio);
>  	} else if (cpu_online(cpu)) {
> -		void *pg_addr =3D page_address(page);
> +		void *pg_addr =3D folio_address(folio);
>  		u64 data0 =3D 0;
> =20
>  		if (tlb_type =3D=3D spitfire) {
>  			data0 =3D ((u64)&xcall_flush_dcache_page_spitfire);
> -			if (page_mapping_file(page) !=3D NULL)
> +			if (folio_flush_mapping(folio) !=3D NULL)
>  				data0 |=3D ((u64)1 << 32);
>  		} else if (tlb_type =3D=3D cheetah || tlb_type =3D=3D cheetah_plus) {
>  #ifdef DCACHE_ALIASING_POSSIBLE
> @@ -963,18 +969,23 @@ void smp_flush_dcache_page_impl(struct page *page, =
int cpu)
>  #endif
>  		}
>  		if (data0) {
> -			xcall_deliver(data0, __pa(pg_addr),
> -				      (u64) pg_addr, cpumask_of(cpu));
> +			unsigned int i, nr =3D folio_nr_pages(folio);
> +
> +			for (i =3D 0; i < nr; i++) {
> +				xcall_deliver(data0, __pa(pg_addr),
> +					      (u64) pg_addr, cpumask_of(cpu));
>  #ifdef CONFIG_DEBUG_DCFLUSH
> -			atomic_inc(&dcpage_flushes_xcall);
> +				atomic_inc(&dcpage_flushes_xcall);
>  #endif
> +				pg_addr +=3D PAGE_SIZE;
> +			}
>  		}
>  	}
> =20
>  	put_cpu();
>  }
> =20
> -void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
> +void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>  {
>  	void *pg_addr;
>  	u64 data0;
> @@ -988,10 +999,10 @@ void flush_dcache_page_all(struct mm_struct *mm, st=
ruct page *page)
>  	atomic_inc(&dcpage_flushes);
>  #endif
>  	data0 =3D 0;
> -	pg_addr =3D page_address(page);
> +	pg_addr =3D folio_address(folio);
>  	if (tlb_type =3D=3D spitfire) {
>  		data0 =3D ((u64)&xcall_flush_dcache_page_spitfire);
> -		if (page_mapping_file(page) !=3D NULL)
> +		if (folio_flush_mapping(folio) !=3D NULL)
>  			data0 |=3D ((u64)1 << 32);
>  	} else if (tlb_type =3D=3D cheetah || tlb_type =3D=3D cheetah_plus) {
>  #ifdef DCACHE_ALIASING_POSSIBLE
> @@ -999,13 +1010,18 @@ void flush_dcache_page_all(struct mm_struct *mm, s=
truct page *page)
>  #endif
>  	}
>  	if (data0) {
> -		xcall_deliver(data0, __pa(pg_addr),
> -			      (u64) pg_addr, cpu_online_mask);
> +		unsigned int i, nr =3D folio_nr_pages(folio);
> +
> +		for (i =3D 0; i < nr; i++) {
> +			xcall_deliver(data0, __pa(pg_addr),
> +				      (u64) pg_addr, cpu_online_mask);
>  #ifdef CONFIG_DEBUG_DCFLUSH
> -		atomic_inc(&dcpage_flushes_xcall);
> +			atomic_inc(&dcpage_flushes_xcall);
>  #endif
> +			pg_addr +=3D PAGE_SIZE;
> +		}
>  	}
> -	__local_flush_dcache_page(page);
> +	__local_flush_dcache_folio(folio);
> =20
>  	preempt_enable();
>  }
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 04f9db0c3111..ab9aacbaf43c 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -195,21 +195,26 @@ atomic_t dcpage_flushes_xcall =3D ATOMIC_INIT(0);
>  #endif
>  #endif
> =20
> -inline void flush_dcache_page_impl(struct page *page)
> +inline void flush_dcache_folio_impl(struct folio *folio)
>  {
> +	unsigned int i, nr =3D folio_nr_pages(folio);
> +
>  	BUG_ON(tlb_type =3D=3D hypervisor);
>  #ifdef CONFIG_DEBUG_DCFLUSH
>  	atomic_inc(&dcpage_flushes);
>  #endif
> =20
>  #ifdef DCACHE_ALIASING_POSSIBLE
> -	__flush_dcache_page(page_address(page),
> -			    ((tlb_type =3D=3D spitfire) &&
> -			     page_mapping_file(page) !=3D NULL));
> +	for (i =3D 0; i < nr; i++)
> +		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
> +				    ((tlb_type =3D=3D spitfire) &&
> +				     folio_flush_mapping(folio) !=3D NULL));
>  #else
> -	if (page_mapping_file(page) !=3D NULL &&
> -	    tlb_type =3D=3D spitfire)
> -		__flush_icache_page(__pa(page_address(page)));
> +	if (folio_flush_mapping(folio) !=3D NULL &&
> +	    tlb_type =3D=3D spitfire) {
> +		for (i =3D 0; i < nr; i++)
> +			__flush_icache_page((pfn + i) * PAGE_SIZE);
> +	}
>  #endif
>  }
> =20
> @@ -218,10 +223,10 @@ inline void flush_dcache_page_impl(struct page *pag=
e)
>  #define PG_dcache_cpu_mask	\
>  	((1UL<<ilog2(roundup_pow_of_two(NR_CPUS)))-1UL)
> =20
> -#define dcache_dirty_cpu(page) \
> -	(((page)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
> +#define dcache_dirty_cpu(folio) \
> +	(((folio)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
> =20
> -static inline void set_dcache_dirty(struct page *page, int this_cpu)
> +static inline void set_dcache_dirty(struct folio *folio, int this_cpu)
>  {
>  	unsigned long mask =3D this_cpu;
>  	unsigned long non_cpu_bits;
> @@ -238,11 +243,11 @@ static inline void set_dcache_dirty(struct page *pa=
ge, int this_cpu)
>  			     "bne,pn	%%xcc, 1b\n\t"
>  			     " nop"
>  			     : /* no outputs */
> -			     : "r" (mask), "r" (non_cpu_bits), "r" (&page->flags)
> +			     : "r" (mask), "r" (non_cpu_bits), "r" (&folio->flags)
>  			     : "g1", "g7");
>  }
> =20
> -static inline void clear_dcache_dirty_cpu(struct page *page, unsigned lo=
ng cpu)
> +static inline void clear_dcache_dirty_cpu(struct folio *folio, unsigned =
long cpu)
>  {
>  	unsigned long mask =3D (1UL << PG_dcache_dirty);
> =20
> @@ -260,7 +265,7 @@ static inline void clear_dcache_dirty_cpu(struct page=
 *page, unsigned long cpu)
>  			     " nop\n"
>  			     "2:"
>  			     : /* no outputs */
> -			     : "r" (cpu), "r" (mask), "r" (&page->flags),
> +			     : "r" (cpu), "r" (mask), "r" (&folio->flags),
>  			       "i" (PG_dcache_cpu_mask),
>  			       "i" (PG_dcache_cpu_shift)
>  			     : "g1", "g7");
> @@ -284,9 +289,10 @@ static void flush_dcache(unsigned long pfn)
> =20
>  	page =3D pfn_to_page(pfn);
>  	if (page) {
> +		struct folio *folio =3D page_folio(page);
>  		unsigned long pg_flags;
> =20
> -		pg_flags =3D page->flags;
> +		pg_flags =3D folio->flags;
>  		if (pg_flags & (1UL << PG_dcache_dirty)) {
>  			int cpu =3D ((pg_flags >> PG_dcache_cpu_shift) &
>  				   PG_dcache_cpu_mask);
> @@ -296,11 +302,11 @@ static void flush_dcache(unsigned long pfn)
>  			 * in the SMP case.
>  			 */
>  			if (cpu =3D=3D this_cpu)
> -				flush_dcache_page_impl(page);
> +				flush_dcache_folio_impl(folio);
>  			else
> -				smp_flush_dcache_page_impl(page, cpu);
> +				smp_flush_dcache_folio_impl(folio, cpu);
> =20
> -			clear_dcache_dirty_cpu(page, cpu);
> +			clear_dcache_dirty_cpu(folio, cpu);
> =20
>  			put_cpu();
>  		}
> @@ -388,12 +394,14 @@ bool __init arch_hugetlb_valid_size(unsigned long s=
ize)
>  }
>  #endif	/* CONFIG_HUGETLB_PAGE */
> =20
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,=
 pte_t *ptep)
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long ad=
dress,
> +		pte_t *ptep, unsigned int nr)
>  {
>  	struct mm_struct *mm;
>  	unsigned long flags;
>  	bool is_huge_tsb;
>  	pte_t pte =3D *ptep;
> +	unsigned int i;
> =20
>  	if (tlb_type !=3D hypervisor) {
>  		unsigned long pfn =3D pte_pfn(pte);
> @@ -440,15 +448,21 @@ void update_mmu_cache(struct vm_area_struct *vma, u=
nsigned long address, pte_t *
>  		}
>  	}
>  #endif
> -	if (!is_huge_tsb)
> -		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
> -					address, pte_val(pte));
> +	if (!is_huge_tsb) {
> +		for (i =3D 0; i < nr; i++) {
> +			__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
> +						address, pte_val(pte));
> +			address +=3D PAGE_SIZE;
> +			pte_val(pte) +=3D PAGE_SIZE;
> +		}
> +	}
> =20
>  	spin_unlock_irqrestore(&mm->context.lock, flags);
>  }
> =20
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>  {
> +	unsigned long pfn =3D folio_pfn(folio);
>  	struct address_space *mapping;
>  	int this_cpu;
> =20
> @@ -459,35 +473,35 @@ void flush_dcache_page(struct page *page)
>  	 * is merely the zero page.  The 'bigcore' testcase in GDB
>  	 * causes this case to run millions of times.
>  	 */
> -	if (page =3D=3D ZERO_PAGE(0))
> +	if (is_zero_pfn(pfn))
>  		return;
> =20
>  	this_cpu =3D get_cpu();
> =20
> -	mapping =3D page_mapping_file(page);
> +	mapping =3D folio_flush_mapping(folio);
>  	if (mapping && !mapping_mapped(mapping)) {
> -		int dirty =3D test_bit(PG_dcache_dirty, &page->flags);
> +		bool dirty =3D test_bit(PG_dcache_dirty, &folio->flags);
>  		if (dirty) {
> -			int dirty_cpu =3D dcache_dirty_cpu(page);
> +			int dirty_cpu =3D dcache_dirty_cpu(folio);
> =20
>  			if (dirty_cpu =3D=3D this_cpu)
>  				goto out;
> -			smp_flush_dcache_page_impl(page, dirty_cpu);
> +			smp_flush_dcache_folio_impl(folio, dirty_cpu);
>  		}
> -		set_dcache_dirty(page, this_cpu);
> +		set_dcache_dirty(folio, this_cpu);
>  	} else {
>  		/* We could delay the flush for the !page_mapping
>  		 * case too.  But that case is for exec env/arg
>  		 * pages and those are %99 certainly going to get
>  		 * faulted into the tlb (and thus flushed) anyways.
>  		 */
> -		flush_dcache_page_impl(page);
> +		flush_dcache_folio_impl(folio);
>  	}
> =20
>  out:
>  	put_cpu();
>  }
> -EXPORT_SYMBOL(flush_dcache_page);
> +EXPORT_SYMBOL(flush_dcache_folio);
> =20
>  void __kprobes flush_icache_range(unsigned long start, unsigned long end=
)
>  {
> @@ -2280,10 +2294,10 @@ void __init paging_init(void)
>  	setup_page_offset();
> =20
>  	/* These build time checkes make sure that the dcache_dirty_cpu()
> -	 * page->flags usage will work.
> +	 * folio->flags usage will work.
>  	 *
>  	 * When a page gets marked as dcache-dirty, we store the
> -	 * cpu number starting at bit 32 in the page->flags.  Also,
> +	 * cpu number starting at bit 32 in the folio->flags.  Also,
>  	 * functions like clear_dcache_dirty_cpu use the cpu mask
>  	 * in 13-bit signed-immediate instruction fields.
>  	 */
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 9a725547578e..3fa6a070912d 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -118,6 +118,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned lon=
g vaddr,
>  		unsigned long paddr, pfn =3D pte_pfn(orig);
>  		struct address_space *mapping;
>  		struct page *page;
> +		struct folio *folio;
> =20
>  		if (!pfn_valid(pfn))
>  			goto no_cache_flush;
> @@ -127,13 +128,13 @@ void tlb_batch_add(struct mm_struct *mm, unsigned l=
ong vaddr,
>  			goto no_cache_flush;
> =20
>  		/* A real file page? */
> -		mapping =3D page_mapping_file(page);
> +		mapping =3D folio_flush_mapping(folio);
>  		if (!mapping)
>  			goto no_cache_flush;
> =20
>  		paddr =3D (unsigned long) page_address(page);
>  		if ((paddr ^ vaddr) & (1 << 13))
> -			flush_dcache_page_all(mm, page);
> +			flush_dcache_folio_all(mm, folio);
>  	}
> =20
>  no_cache_flush:

This change broke the kernel on sun4u SPARC systems. This has been observed=
 on a Sun Netra 240.

During boot, the kernel crashes with:

[   25.855163] Unable to handle kernel NULL pointer dereference
[   25.929588] tsk->{mm,active_mm}->context =3D 0000000000000001
[   26.002772] tsk->{mm,active_mm}->pgd =3D fff00000001bc000
[   26.071405]               \|/ ____ \|/
[   26.071405]               "@'/ .. \`@"
[   26.071405]               /_| \__/ |_\
[   26.071405]                  \__U_/
[   26.264705] modprobe(33): Oops [#1]
[   26.310445] CPU: 0 PID: 33 Comm: modprobe Not tainted 6.5.0-rc4+ #16
[   26.393937] TSTATE: 0000004411001601 TPC: 0000000000452a28 TNPC: 0000000=
000452a2c Y: 00000008    Not tainted
[   26.523184] TPC: <tlb_batch_add+0x108/0x1a0>
[   26.579221] g0: ace36c1f2cee4067 g1: 0000000000000028 g2: 00000000000a01=
0c g3: 000c000000000000
[   26.693607] g4: fff0000001947000 g5: 0000000000000000 g6: fff00000019480=
00 g7: fff000023fe33f00
[   26.807978] o0: fff000000738fff8 o1: 000007feffffe000 o2: fff000000194b7=
88 o3: 0000000000e3c038
[   26.922356] o4: ffffffffffffffff o5: 0000000000e3c038 sp: fff000000194ae=
e1 ret_pc: 000000000065d194
[   27.041302] RPC: <__pte_offset_map_lock+0x14/0x60>
[   27.104203] l0: fff000000194b860 l1: 0000000000000001 l2: 00000000000000=
00 l3: fff000000194b850
[   27.218583] l4: 0000000000002000 l5: 00000000001010f8 l6: 00000000000000=
02 l7: 0000000000000040
[   27.332959] i0: fff000000194e400 i1: 000007feffffe000 i2: 000c0000048575=
88 i3: 80000002026d3fb2
[   27.447334] i4: 0000000000000000 i5: 000000000000000d i6: fff000000194af=
91 i7: 0000000000659110
[   27.561709] I7: <change_protection+0x910/0xe00>
[   27.621178] Call Trace:
[   27.653202] [<0000000000659110>] change_protection+0x910/0xe00
[   27.729838] [<00000000006596f4>] mprotect_fixup+0xf4/0x2c0
[   27.801892] [<00000000006c754c>] setup_arg_pages+0x12c/0x2c0
[   27.876237] [<0000000000737d80>] load_elf_binary+0x360/0x1380
[   27.951722] [<00000000006c8564>] bprm_execve+0x1e4/0x560
[   28.021493] [<00000000006c8e8c>] kernel_execve+0x14c/0x200
[   28.093548] [<000000000047f6e8>] call_usermodehelper_exec_async+0xa8/0x1=
40
[   28.183906] [<0000000000405fc8>] ret_from_fork+0x1c/0x2c
[   28.253672] [<0000000000000000>] 0x0
[   28.300568] Disabling lock debugging due to kernel taint
[   28.370336] Caller[0000000000659110]: change_protection+0x910/0xe00
[   28.452686] Caller[00000000006596f4]: mprotect_fixup+0xf4/0x2c0
[   28.530461] Caller[00000000006c754c]: setup_arg_pages+0x12c/0x2c0
[   28.610524] Caller[0000000000737d80]: load_elf_binary+0x360/0x1380
[   28.691730] Caller[00000000006c8564]: bprm_execve+0x1e4/0x560
[   28.767218] Caller[00000000006c8e8c]: kernel_execve+0x14c/0x200
[   28.844993] Caller[000000000047f6e8]: call_usermodehelper_exec_async+0xa=
8/0x140
[   28.941071] Caller[0000000000405fc8]: ret_from_fork+0x1c/0x2c
[   29.016554] Caller[0000000000000000]: 0x0
[   29.069167] Instruction DUMP:
[   29.069169]  80886001=20
[   29.108052]  126fffc8=20
[   29.138932]  01000000=20
[   29.169815] <c2582000>
[   29.200697]  83307013=20
[   29.231578]  80886001=20
[   29.262458]  02680007=20
[   29.293338]  01000000=20
[   29.324223]  c2582000=20
[   29.355102]

This crash is not observed on sun4v systems.

Any idea what could be the fix?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

