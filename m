Return-Path: <linux-arch+bounces-536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B137FD254
	for <lists+linux-arch@lfdr.de>; Wed, 29 Nov 2023 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037291C20CF8
	for <lists+linux-arch@lfdr.de>; Wed, 29 Nov 2023 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764D14017;
	Wed, 29 Nov 2023 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DuWrSyTL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F31A5;
	Wed, 29 Nov 2023 01:22:09 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231129092207epoutp0349785934307c24d34c3d7116c05a60df~cDZ0nRvmd1512115121epoutp031;
	Wed, 29 Nov 2023 09:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231129092207epoutp0349785934307c24d34c3d7116c05a60df~cDZ0nRvmd1512115121epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701249727;
	bh=djxFfe2UUjmCn0d0Tv91ov/Tu2cEgO6ZCjTHEc0ZOLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DuWrSyTL+9CuCL/ygNvlyr4pTDXsvSWXBZTRXJfVOssTsB+nzL3sr9qskqeqg4AUt
	 8V6FPYw5mh7ZM6SqBbv8tV+9fdvAuCLRnyLty4vgTxMBfogsWn9+erYG+za01wH/Jl
	 SChNBXtv5I5FcEstMahgx+LHeeC6wq/aUyLWYMXA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231129092207epcas2p31dce9553783ab44712383937c8009c9d~cDZ0aP7Zx0786507865epcas2p3R;
	Wed, 29 Nov 2023 09:22:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SgDNv0PY2z4x9QB; Wed, 29 Nov
	2023 09:22:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.54.09607.EB207656; Wed, 29 Nov 2023 18:22:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231129092206epcas2p300f71058467dbffcd46d02b7a938bd0a~cDZzZCRNj0512805128epcas2p34;
	Wed, 29 Nov 2023 09:22:06 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231129092206epsmtrp1df9d539cc950d879de1b7f9c92e0b3cc~cDZzTPH5I2616726167epsmtrp1c;
	Wed, 29 Nov 2023 09:22:06 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-8e-656702be3136
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.9D.07368.EB207656; Wed, 29 Nov 2023 18:22:06 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231129092206epsmtip16f96f60be85046f00315d9f84473022e~cDZy9HP332678126781epsmtip1Q;
	Wed, 29 Nov 2023 09:22:06 +0000 (GMT)
Date: Wed, 29 Nov 2023 18:10:40 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 16/27] arm64: mte: Manage tag storage on page
 allocation
Message-ID: <20231129091040.GC2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231119165721.9849-17-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+69vfdKUndXfBxroqxEDExr61p7MOKmY8tN3APnjI6ZYUNv
	ioE+1hYDukVcUGtlvIwDCnMQHaCr1rQwO6HV8cbHppJixsMHLxEFRn0sQIS1Xl3873O+v9/3
	/M75/fKjcdF1Skzv0ls4k16dJiHDiN8ao5UrfZiWk1WcQ6jM6SBR0akOEvnaktHzwhYK3ez3
	B6UH+wk0XpkD0FPnFI4G82tx9Ef5GIEGA7kEuuOrwlBv3jECnR8axdBITSOBrBeeEsjV3ylA
	9d52AnVcKCPRbcesADU5rxHo97J2ATo6NgTQiaoodPNSOYaOTT4iUV7PLRK1/nAJQz7rXSyY
	ex5D+5vGSVTS3Q2QtekZjrwzkwSqbf6XQtk9SvT3L+eo95exjuMOwE5PFQI229dFseWudDa7
	aVTAuqtjWNfpwyTrChRSbE9nPcm2FU8TbEXWMZx1n9zHDrtLADvu85Os+8pe9rFrSQKTmLou
	hVNrOFMEp082aHbptXGSTVuSPkhSrpHJV8pjkUoSoVfruDhJ/McJKz/alRZspiRitzotPSgl
	qM1myar160yGdAsXkWIwW+IknFGTZlQZpWa1zpyu10r1nGWtXCZbrQwm7kxNcT8rpoxeG8jI
	zn+MZwG30Qbm0JBRwFOz7YQNhNEixgNgYasf4w8BAEcGhqhQloh5BmDXaNQrR3/tmZe6F8CW
	77/jDYMAdp/7lQwFCGYZbC4dASEmmeWwrabyBc9jVsG+2pAeRuPMZRL2ll7FQoFwZis8fesO
	bgM0LWSksHr87ZAsZN6C7SUDRIjnMOuh97JfEPJCJjcMeg7nglA+ZOLhjwcB/7hwONJaQ/Es
	hg/yDr7kVNg7kU/ybIFnr2a91N+F9qFDL7w4kwK7js5g/JWRsKmL4OW50Nr4nOJlIbQeFPHO
	SHix8jjB8yLYd+aQgGcWzngqKb4lTQBWDRVQ+WCJ/bXf2F+rxvMKWF4XIO3BEjizGFbN0DxG
	Q+eFVeVAcBos4IxmnZYzrzYq/p9vskHnAi9WK4b1gNLRf6QNAKNBA4A0LpknlE4kcyKhRp25
	hzMZkkzpaZy5ASiDoynAxfOTDcHd1FuS5IpYmWLNGrlqtVKmkiwU3j7wk0bEaNUWLpXjjJzp
	lQ+j54izsL33An68+SberVobUOyk723MoRWbT1i6d9AZX8V3vlN/2dMRXbbbm7izzrAg99Ce
	ZcW02Oyo3kd/OV2EBjqmJrZ5NF9fjd14JFEpWfi57rrwM3t47s/SuMUzPrFQNr7BFtAO37Dv
	rTvwV1SPCV96auCSNTMW/zT/LP7NJ5X+KyC+ufHemycr8C2t9+Ov7aiumipNVqywOpfOd3xY
	Er41dvs2e13me5MPl1qyN2Us3h8jnJ28+IZuJKFvs0WWZfDHCUTOoYa8BM+j7es2PHnyxY3W
	uTmqPLxIkWI7cj0yqjj6juv4sGv5WC/z8Nu7i/4syMdn61uKcpjbWk1t5/L7keoCpYQwp6jl
	MbjJrP4PPp84yuMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/s8z549W+16GFZfwJvXFO3mNSGp+2gceXbZIxXXRcrBndEO
	nkOSjbVBPygPqBWEhAqSbJJsGUzHEh0sUmDhGAYR/8wDUiZ4DbzEYDklg+mMwXX53+te7/f7
	Pv98GFL6tSCWydcU8TqNqkBOi6kf+uSyZ1xEHp9gPBwNjW12Go6eukSDayAH7tdeFILXP7Kk
	bpRTEGipRjDftkjC9CEnCRfMcxRMB2somHRZCbh6sJ6CzuuzBMx09FFQeX6eAod/VADdPYMU
	XDrfSMOE/YEAPG3DFJxrHBRA3dx1BCes68HbayagfuFPGg76xmj4+ateAlyV14ilbicB5Z4A
	DcbxcQSVnr9J6AkvUODsvysEg+85uNx8RrgtnrMftyMutFiLOIPripAzO4o5g2dWwLWfVHAO
	25c05wjWCjnfaDfNDTSEKM5SVk9y7d+Vcn+0GxEXcI3QXPvQx9xth+wNNkucnMsX5L/P6zal
	vCPee+SvUaS9X4E+HP7psTJUralCIgazSdjv/F4YYSnbhfCJeztWfAw23R4kVjgaTxo8giok
	Xur4Eb45UIMiAcXG4/5jM8tMsxvwQEfLMq9iN+HfnREvZkj2VxrXtJoEkSCa3YVtY5NkFWIY
	CavEJwNPrRz2IPxFFY6whI3Cg8YpKsIkq8C/hW8QkTrJxmFrmIloEZuCe34ZERxCrOmhhemh
	hen/hRmRNhTDa/XqPHVOojZRw3+g1KvU+mJNnjKnUO1Ay6+jePpHNNEUVroRwSA3wgwpXyVR
	3srhpZJc1UclvK4wW1dcwOvdKI6h5E9KEhuO5UrZPFURv4/ntbzuv5RgRLFlxNrsJ2SpdrXq
	zoPmNWtWby2eOH2qKOHdONcCWThs67KWM95p77mdQ7sVwbPqkgmMkt3XmC3W2agXK652jm7J
	qG7ek5pV592+Tv78ImwrsXPBXfvvFnJ9Tb7Uocx6Kv2AYn2LO23ss5ZGw4J4UdHacfHAJxn+
	2LVzhm+bP2+49834o1qvpCY9PylZ/vJLlqKN/0zaHhe9yeAjsoy35m+GbJtffaS7zOLruqM4
	WvpK9+pMC2yPSwjxUwUV763bEJMlE73gvrz12bA6P01jQTOlgXSqVRo1b76VNRW/b3Pd7v4L
	itCnmfDa4VTtxv3l2b07gilNvuDbx5OSnEqj6fUrO9PklH6vKlFB6vSqfwGtSHvfqQMAAA==
X-CMS-MailID: 20231129092206epcas2p300f71058467dbffcd46d02b7a938bd0a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_37b70_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165906epcas2p4c6691d274bec428329b193b99119a8d1
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165906epcas2p4c6691d274bec428329b193b99119a8d1@epcas2p4.samsung.com>
	<20231119165721.9849-17-alexandru.elisei@arm.com>

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_37b70_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Nov 19, 2023 at 04:57:10PM +0000, Alexandru Elisei wrote:
> Reserve tag storage for a tagged page by migrating the contents of the tag
> storage (if in use for data) and removing the tag storage pages from the
> page allocator by calling alloc_contig_range().
> 
> When all the associated tagged pages have been freed, return the tag
> storage pages back to the page allocator, where they can be used again for
> data allocations.
> 
> Tag storage pages cannot be tagged, so disallow allocations from
> MIGRATE_CMA when the allocation is tagged.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/include/asm/mte.h             |  16 +-
>  arch/arm64/include/asm/mte_tag_storage.h |  45 +++++
>  arch/arm64/include/asm/pgtable.h         |  27 +++
>  arch/arm64/kernel/mte_tag_storage.c      | 241 +++++++++++++++++++++++
>  fs/proc/page.c                           |   1 +
>  include/linux/kernel-page-flags.h        |   1 +
>  include/linux/page-flags.h               |   1 +
>  include/trace/events/mmflags.h           |   3 +-
>  mm/huge_memory.c                         |   1 +
>  9 files changed, 333 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 8034695b3dd7..6457b7899207 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -40,12 +40,24 @@ void mte_free_tag_buf(void *buf);
>  #ifdef CONFIG_ARM64_MTE
>  
>  /* track which pages have valid allocation tags */
> -#define PG_mte_tagged	PG_arch_2
> +#define PG_mte_tagged		PG_arch_2
>  /* simple lock to avoid multiple threads tagging the same page */
> -#define PG_mte_lock	PG_arch_3
> +#define PG_mte_lock		PG_arch_3
> +/* Track if a tagged page has tag storage reserved */
> +#define PG_tag_storage_reserved	PG_arch_4
> +
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +extern bool page_tag_storage_reserved(struct page *page);
> +#endif
>  
>  static inline void set_page_mte_tagged(struct page *page)
>  {
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +	/* Open code mte_tag_storage_enabled() */
> +	WARN_ON_ONCE(static_branch_likely(&tag_storage_enabled_key) &&
> +		     !page_tag_storage_reserved(page));
> +#endif
>  	/*
>  	 * Ensure that the tags written prior to this function are visible
>  	 * before the page flags update.
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> index 8f86c4f9a7c3..cab033b184ab 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -5,11 +5,56 @@
>  #ifndef __ASM_MTE_TAG_STORAGE_H
>  #define __ASM_MTE_TAG_STORAGE_H
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/mm_types.h>
> +
> +#include <asm/mte.h>
> +
>  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +
> +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +
> +static inline bool tag_storage_enabled(void)
> +{
> +	return static_branch_likely(&tag_storage_enabled_key);
> +}
> +
> +static inline bool alloc_requires_tag_storage(gfp_t gfp)
> +{
> +	return gfp & __GFP_TAGGED;
> +}
> +
>  void mte_tag_storage_init(void);
> +
> +int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
> +void free_tag_storage(struct page *page, int order);
> +
> +bool page_tag_storage_reserved(struct page *page);
>  #else
> +static inline bool tag_storage_enabled(void)
> +{
> +	return false;
> +}
> +static inline bool alloc_requires_tag_storage(struct page *page)
> +{
> +	return false;
> +}
>  static inline void mte_tag_storage_init(void)
>  {
>  }
> +static inline int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> +{
> +	return 0;
> +}
> +static inline void free_tag_storage(struct page *page, int order)
> +{
> +}
> +static inline bool page_tag_storage_reserved(struct page *page)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
> +
> +#endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_MTE_TAG_STORAGE_H  */
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index cd5dacd1be3a..20e8de853f5d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -10,6 +10,7 @@
>  
>  #include <asm/memory.h>
>  #include <asm/mte.h>
> +#include <asm/mte_tag_storage.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/pgtable-prot.h>
>  #include <asm/tlbflush.h>
> @@ -1063,6 +1064,32 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  		mte_restore_page_tags_by_swp_entry(entry, &folio->page);
>  }
>  
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +
> +#define __HAVE_ARCH_PREP_NEW_PAGE
> +static inline int arch_prep_new_page(struct page *page, int order, gfp_t gfp)
> +{
> +	if (tag_storage_enabled() && alloc_requires_tag_storage(gfp))
> +		return reserve_tag_storage(page, order, gfp);
> +	return 0;
> +}
> +
> +#define __HAVE_ARCH_FREE_PAGES_PREPARE
> +static inline void arch_free_pages_prepare(struct page *page, int order)
> +{
> +	if (tag_storage_enabled() && page_mte_tagged(page))
> +		free_tag_storage(page, order);
> +}
> +
> +#define __HAVE_ARCH_ALLOC_CMA
> +static inline bool arch_alloc_cma(gfp_t gfp_mask)
> +{
> +	if (tag_storage_enabled() && alloc_requires_tag_storage(gfp_mask))
> +		return false;
> +	return true;
> +}
> +
> +#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
>  #endif /* CONFIG_ARM64_MTE */
>  
>  #define __HAVE_ARCH_CALC_VMA_GFP
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> index fd63430d4dc0..9f8ef3116fc3 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -11,12 +11,18 @@
>  #include <linux/of_device.h>
>  #include <linux/of_fdt.h>
>  #include <linux/pageblock-flags.h>
> +#include <linux/page-flags.h>
> +#include <linux/page_owner.h>
>  #include <linux/range.h>
> +#include <linux/sched/mm.h>
>  #include <linux/string.h>
> +#include <linux/vm_event_item.h>
>  #include <linux/xarray.h>
>  
>  #include <asm/mte_tag_storage.h>
>  
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +
>  struct tag_region {
>  	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
>  	struct range tag_range;	/* Tag storage memory, in PFNs. */
> @@ -28,6 +34,31 @@ struct tag_region {
>  static struct tag_region tag_regions[MAX_TAG_REGIONS];
>  static int num_tag_regions;
>  
> +/*
> + * A note on locking. Reserving tag storage takes the tag_blocks_lock mutex,
> + * because alloc_contig_range() might sleep.
> + *
> + * Freeing tag storage takes the xa_lock spinlock with interrupts disabled
> + * because pages can be freed from non-preemptible contexts, including from an
> + * interrupt handler.
> + *
> + * Because tag storage can be freed from interrupt contexts, the xarray is
> + * defined with the XA_FLAGS_LOCK_IRQ flag to disable interrupts when calling
> + * xa_store(). This is done to prevent a deadlock with free_tag_storage() being
> + * called from an interrupt raised before xa_store() releases the xa_lock.
> + *
> + * All of the above means that reserve_tag_storage() cannot run concurrently
> + * with itself (no concurrent insertions), but it can run at the same time as
> + * free_tag_storage(). The first thing that reserve_tag_storage() does after
> + * taking the mutex is increase the refcount on all present tag storage blocks
> + * with the xa_lock held, to serialize against freeing the blocks. This is an
> + * optimization to avoid taking and releasing the xa_lock after each iteration
> + * if the refcount operation was moved inside the loop, where it would have had
> + * to be executed for each block.
> + */
> +static DEFINE_XARRAY_FLAGS(tag_blocks_reserved, XA_FLAGS_LOCK_IRQ);
> +static DEFINE_MUTEX(tag_blocks_lock);
> +
>  static int __init tag_storage_of_flat_get_range(unsigned long node, const __be32 *reg,
>  						int reg_len, struct range *range)
>  {
> @@ -368,3 +399,213 @@ static int __init mte_tag_storage_activate_regions(void)
>  	return ret;
>  }
>  arch_initcall(mte_tag_storage_activate_regions);
> +
> +static void page_set_tag_storage_reserved(struct page *page, int order)
> +{
> +	int i;
> +
> +	for (i = 0; i < (1 << order); i++)
> +		set_bit(PG_tag_storage_reserved, &(page + i)->flags);
> +}
> +
> +static void block_ref_add(unsigned long block, struct tag_region *region, int order)
> +{
> +	int count;
> +
> +	count = min(1u << order, 32 * region->block_size);
> +	page_ref_add(pfn_to_page(block), count);
> +}
> +
> +static int block_ref_sub_return(unsigned long block, struct tag_region *region, int order)
> +{
> +	int count;
> +
> +	count = min(1u << order, 32 * region->block_size);
> +	return page_ref_sub_return(pfn_to_page(block), count);
> +}
> +
> +static bool tag_storage_block_is_reserved(unsigned long block)
> +{
> +	return xa_load(&tag_blocks_reserved, block) != NULL;
> +}
> +
> +static int tag_storage_reserve_block(unsigned long block, struct tag_region *region, int order)
> +{
> +	int ret;
> +
> +	ret = xa_err(xa_store(&tag_blocks_reserved, block, pfn_to_page(block), GFP_KERNEL));
> +	if (!ret)
> +		block_ref_add(block, region, order);
> +
> +	return ret;
> +}
> +
> +static int order_to_num_blocks(int order)
> +{
> +	return max((1 << order) / 32, 1);
> +}
> +
> +static int tag_storage_find_block_in_region(struct page *page, unsigned long *blockp,
> +					    struct tag_region *region)
> +{
> +	struct range *tag_range = &region->tag_range;
> +	struct range *mem_range = &region->mem_range;
> +	u64 page_pfn = page_to_pfn(page);
> +	u64 block, block_offset;
> +
> +	if (!(mem_range->start <= page_pfn && page_pfn <= mem_range->end))
> +		return -ERANGE;
> +
> +	block_offset = (page_pfn - mem_range->start) / 32;
> +	block = tag_range->start + rounddown(block_offset, region->block_size);
> +
> +	if (block + region->block_size - 1 > tag_range->end) {
> +		pr_err("Block 0x%llx-0x%llx is outside tag region 0x%llx-0x%llx\n",
> +			PFN_PHYS(block), PFN_PHYS(block + region->block_size),
> +			PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end));
> +		return -ERANGE;
> +	}
> +	*blockp = block;
> +
> +	return 0;
> +
> +}
> +
> +static int tag_storage_find_block(struct page *page, unsigned long *block,
> +				  struct tag_region **region)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < num_tag_regions; i++) {
> +		ret = tag_storage_find_block_in_region(page, block, &tag_regions[i]);
> +		if (ret == 0) {
> +			*region = &tag_regions[i];
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +bool page_tag_storage_reserved(struct page *page)
> +{
> +	return test_bit(PG_tag_storage_reserved, &page->flags);
> +}
> +
> +int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> +{
> +	unsigned long start_block, end_block;
> +	struct tag_region *region;
> +	unsigned long block;
> +	unsigned long flags;
> +	unsigned int tries;
> +	int ret = 0;
> +
> +	VM_WARN_ON_ONCE(!preemptible());
> +
> +	if (page_tag_storage_reserved(page))
> +		return 0;
> +
> +	/*
> +	 * __alloc_contig_migrate_range() ignores gfp when allocating the
> +	 * destination page for migration. Regardless, massage gfp flags and
> +	 * remove __GFP_TAGGED to avoid recursion in case gfp stops being
> +	 * ignored.
> +	 */
> +	gfp &= ~__GFP_TAGGED;
> +	if (!(gfp & __GFP_NORETRY))
> +		gfp |= __GFP_RETRY_MAYFAIL;
> +
> +	ret = tag_storage_find_block(page, &start_block, &region);
> +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> +		return 0;
> +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> +

Hello.

If the page size is 4K,  block size is 2 (block size bytes 8K), and order is 6,
then we need 2 pages for the tag. However according to the equation, order_to_num_blocks
is 2 and block_size is also 2, so end block will be incremented by 4.

However we actually only need 8K of tag, right for 256K ?
Could you explain order_to_num_blocks * region->block_size more detail ?

Thanks,
Regards.

> +	mutex_lock(&tag_blocks_lock);
> +
> +	/* Check again, this time with the lock held. */
> +	if (page_tag_storage_reserved(page))
> +		goto out_unlock;
> +
> +	/* Make sure existing entries are not freed from out under out feet. */
> +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> +	for (block = start_block; block < end_block; block += region->block_size) {
> +		if (tag_storage_block_is_reserved(block))
> +			block_ref_add(block, region, order);
> +	}
> +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +
> +	for (block = start_block; block < end_block; block += region->block_size) {
> +		/* Refcount incremented above. */
> +		if (tag_storage_block_is_reserved(block))
> +			continue;
> +
> +		tries = 3;
> +		while (tries--) {
> +			ret = alloc_contig_range(block, block + region->block_size, MIGRATE_CMA, gfp);
> +			if (ret == 0 || ret != -EBUSY)
> +				break;
> +		}
> +
> +		if (ret)
> +			goto out_error;
> +
> +		ret = tag_storage_reserve_block(block, region, order);
> +		if (ret) {
> +			free_contig_range(block, region->block_size);
> +			goto out_error;
> +		}
> +
> +		count_vm_events(CMA_ALLOC_SUCCESS, region->block_size);
> +	}
> +
> +	page_set_tag_storage_reserved(page, order);
> +out_unlock:
> +	mutex_unlock(&tag_blocks_lock);
> +
> +	return 0;
> +
> +out_error:
> +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> +	for (block = start_block; block < end_block; block += region->block_size) {
> +		if (tag_storage_block_is_reserved(block) &&
> +		    block_ref_sub_return(block, region, order) == 1) {
> +			__xa_erase(&tag_blocks_reserved, block);
> +			free_contig_range(block, region->block_size);
> +		}
> +	}
> +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +
> +	mutex_unlock(&tag_blocks_lock);
> +
> +	count_vm_events(CMA_ALLOC_FAIL, region->block_size);
> +
> +	return ret;
> +}
> +
> +void free_tag_storage(struct page *page, int order)
> +{
> +	unsigned long block, start_block, end_block;
> +	struct tag_region *region;
> +	unsigned long flags;
> +	int ret;
> +
> +	ret = tag_storage_find_block(page, &start_block, &region);
> +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> +		return;
> +
> +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> +
> +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> +	for (block = start_block; block < end_block; block += region->block_size) {
> +		if (WARN_ONCE(!tag_storage_block_is_reserved(block),
> +		    "Block 0x%lx is not reserved for pfn 0x%lx", block, page_to_pfn(page)))
> +			continue;
> +
> +		if (block_ref_sub_return(block, region, order) == 1) {
> +			__xa_erase(&tag_blocks_reserved, block);
> +			free_contig_range(block, region->block_size);
> +		}
> +	}
> +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +}
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 195b077c0fac..e7eb584a9234 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -221,6 +221,7 @@ u64 stable_page_flags(struct page *page)
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>  	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
>  	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
> +	u |= kpf_copy_bit(k, KPF_ARCH_4,	PG_arch_4);
>  #endif
>  
>  	return u;
> diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
> index 859f4b0c1b2b..4a0d719ffdd4 100644
> --- a/include/linux/kernel-page-flags.h
> +++ b/include/linux/kernel-page-flags.h
> @@ -19,5 +19,6 @@
>  #define KPF_SOFTDIRTY		40
>  #define KPF_ARCH_2		41
>  #define KPF_ARCH_3		42
> +#define KPF_ARCH_4		43
>  
>  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a88e64acebfe..7915165a51bd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,7 @@ enum pageflags {
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>  	PG_arch_2,
>  	PG_arch_3,
> +	PG_arch_4,
>  #endif
>  	__NR_PAGEFLAGS,
>  
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 6ca0d5ed46c0..ba962fd10a2c 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -125,7 +125,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)						\
>  IF_HAVE_PG_IDLE(idle)							\
>  IF_HAVE_PG_IDLE(young)							\
>  IF_HAVE_PG_ARCH_X(arch_2)						\
> -IF_HAVE_PG_ARCH_X(arch_3)
> +IF_HAVE_PG_ARCH_X(arch_3)						\
> +IF_HAVE_PG_ARCH_X(arch_4)
>  
>  #define show_page_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",				\
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f31f02472396..9beead961a65 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2474,6 +2474,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>  			 (1L << PG_arch_2) |
>  			 (1L << PG_arch_3) |
> +			 (1L << PG_arch_4) |
>  #endif
>  			 (1L << PG_dirty) |
>  			 LRU_GEN_MASK | LRU_REFS_MASK));
> -- 
> 2.42.1
> 
> 

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_37b70_
Content-Type: text/plain; charset="utf-8"


------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_37b70_--

