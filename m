Return-Path: <linux-arch+bounces-3725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2B8A6D12
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA6B28150C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7B12D1FD;
	Tue, 16 Apr 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrBFH7Ff";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uX8Px8p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrBFH7Ff";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uX8Px8p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8412CDB2;
	Tue, 16 Apr 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275757; cv=none; b=LrnDkV84QBUEEvAsNmBZRT1mIqq0bAGWgW30TiILHNmS3GPas1s3KQoxkHQH7sRXYX4FZIje//t2frDhqYLlWZJks3hvppZI+epuuGgtJdRCNN08maWtd6QaZfhWeRMCQhPfn1ms+ASP7tNa1384dkNl4q3FhpdeyRCmvk/qG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275757; c=relaxed/simple;
	bh=PZMDF08NZ/CEG7c+hAV1JQtBfqNUDB5b6QM7aBV6M8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCLku5iYETw+ZwSJr3u3ML6htDm0QYJy0Z0OCwATjHsqkJPF1cZh0pvj7Ta9CDK3oSbup3vS1o35EOnOyT9+SeciqLj/45tV6Imri5OAXB9z8OsBSPZ/d2jYBTcB6E5xk8aV4daHujcR+CsPxbD+pBhSiho9D7FqVqeSRlR1ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrBFH7Ff; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uX8Px8p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrBFH7Ff; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uX8Px8p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 593C337BC6;
	Tue, 16 Apr 2024 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713275752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/n3iPopAe9FbTV5rXIeDd3PGXaTl8QeOBpHbbctfl4=;
	b=PrBFH7FfpR5Z/MYQ4uIUlM/BEKiok2Z0vdetj9qC+BHPOx6L3HQwa2aK9llY69i2MXwx6P
	pbdSL0PA2ph8KLYLbXdm2ngPc66hYO5AObP5t0Hm+5AI6OfTNhGjoV+Sw1xr0FsQTI4dy6
	G1WddM+lwZbDYF/iUo1hrWNeleWvrFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713275752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/n3iPopAe9FbTV5rXIeDd3PGXaTl8QeOBpHbbctfl4=;
	b=/uX8Px8pfMSmVdiPu96v/zeC3WTqTBnubko4PYTM93XFNCtBHSj+bPG1nwGhHuqHV3EcMW
	5+sgGOGQ8avtnuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713275752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/n3iPopAe9FbTV5rXIeDd3PGXaTl8QeOBpHbbctfl4=;
	b=PrBFH7FfpR5Z/MYQ4uIUlM/BEKiok2Z0vdetj9qC+BHPOx6L3HQwa2aK9llY69i2MXwx6P
	pbdSL0PA2ph8KLYLbXdm2ngPc66hYO5AObP5t0Hm+5AI6OfTNhGjoV+Sw1xr0FsQTI4dy6
	G1WddM+lwZbDYF/iUo1hrWNeleWvrFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713275752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/n3iPopAe9FbTV5rXIeDd3PGXaTl8QeOBpHbbctfl4=;
	b=/uX8Px8pfMSmVdiPu96v/zeC3WTqTBnubko4PYTM93XFNCtBHSj+bPG1nwGhHuqHV3EcMW
	5+sgGOGQ8avtnuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC9213931;
	Tue, 16 Apr 2024 13:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F9BVDmiDHmZIZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Apr 2024 13:55:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCF6BA082E; Tue, 16 Apr 2024 15:55:51 +0200 (CEST)
Date: Tue, 16 Apr 2024 15:55:51 +0200
From: Jan Kara <jack@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	joro@8bytes.org, will@kernel.org, trond.myklebust@hammerspace.com,
	anna@kernel.org, arnd@arndb.de, herbert@gondor.apana.org.au,
	davem@davemloft.net, jikos@kernel.org,
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com,
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	kent.overstreet@linux.dev
Subject: Re: [PATCH v2 1/1] mm: change inlined allocation helpers to account
 at the call site
Message-ID: <20240416135551.jc2q5ps2cylsr44s@quack3>
References: <20240415020731.1152108-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415020731.1152108-1-surenb@google.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLj6phwcdhphrxdye3znxh4wb5)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Sun 14-04-24 19:07:31, Suren Baghdasaryan wrote:
> Main goal of memory allocation profiling patchset is to provide accounting
> that is cheap enough to run in production. To achieve that we inject
> counters using codetags at the allocation call sites to account every time
> allocation is made. This injection allows us to perform accounting
> efficiently because injected counters are immediately available as opposed
> to the alternative methods, such as using _RET_IP_, which would require
> counter lookup and appropriate locking that makes accounting much more
> expensive. This method requires all allocation functions to inject
> separate counters at their call sites so that their callers can be
> individually accounted. Counter injection is implemented by allocation
> hooks which should wrap all allocation functions.
> 
> Inlined functions which perform allocations but do not use allocation
> hooks are directly charged for the allocations they perform. In most
> cases these functions are just specialized allocation wrappers used
> from multiple places to allocate objects of a specific type. It would
> be more useful to do the accounting at their call sites instead.
> Instrument these helpers to do accounting at the call site. Simple
> inlined allocation wrappers are converted directly into macros. More
> complex allocators or allocators with documentation are converted into
> _noprof versions and allocation hooks are added. This allows memory
> allocation profiling mechanism to charge allocations to the callers
> of these functions.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

for the jbd2 bits.

								Honza

> ---
> Changes since v1 [1]:
> - Added explicit type casts in macro replacements to force type checks,
> per Matthew Wilcox
> - Expanded the changelog to explain the reasons codetags are used and
> this change is neeed, per Jan Kara
> 
> [1] https://lore.kernel.org/all/20240404165404.3805498-1-surenb@google.com/
> 
>  drivers/iommu/amd/amd_iommu.h           |  5 ++--
>  fs/nfs/iostat.h                         |  5 +---
>  include/acpi/platform/aclinuxex.h       | 19 +++++---------
>  include/asm-generic/pgalloc.h           | 35 +++++++++++++++----------
>  include/crypto/hash.h                   |  7 ++---
>  include/crypto/internal/acompress.h     |  5 ++--
>  include/crypto/skcipher.h               |  7 ++---
>  include/linux/bpf.h                     | 33 ++++++-----------------
>  include/linux/bpfptr.h                  |  5 ++--
>  include/linux/dma-fence-chain.h         |  6 ++---
>  include/linux/hid_bpf.h                 |  6 ++---
>  include/linux/jbd2.h                    | 12 +++------
>  include/linux/mm.h                      |  5 ++--
>  include/linux/mm_types.h                |  5 ++--
>  include/linux/percpu.h                  |  3 +++
>  include/linux/ptr_ring.h                | 28 +++++++++++---------
>  include/linux/skb_array.h               | 19 ++++++++------
>  include/linux/skbuff.h                  | 20 ++++++--------
>  include/linux/skmsg.h                   |  8 +++---
>  include/linux/slab.h                    |  5 ++++
>  include/linux/sockptr.h                 | 10 ++++---
>  include/net/netlabel.h                  | 16 ++++++-----
>  include/net/netlink.h                   |  5 ++--
>  include/net/request_sock.h              |  5 ++--
>  include/net/tcx.h                       |  5 ++--
>  net/sunrpc/auth_gss/auth_gss_internal.h |  6 +++--
>  26 files changed, 142 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index f482aab420f7..52575ba9a141 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -134,13 +134,14 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
>  	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
>  }
>  
> -static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
> +static inline void *alloc_pgtable_page_noprof(int nid, gfp_t gfp)
>  {
>  	struct page *page;
>  
> -	page = alloc_pages_node(nid, gfp | __GFP_ZERO, 0);
> +	page = alloc_pages_node_noprof(nid, gfp | __GFP_ZERO, 0);
>  	return page ? page_address(page) : NULL;
>  }
> +#define alloc_pgtable_page(...)	alloc_hooks(alloc_pgtable_page_noprof(__VA_ARGS__))
>  
>  /*
>   * This must be called after device probe completes. During probe
> diff --git a/fs/nfs/iostat.h b/fs/nfs/iostat.h
> index 5aa776b5a3e7..b17a9eb9b148 100644
> --- a/fs/nfs/iostat.h
> +++ b/fs/nfs/iostat.h
> @@ -46,10 +46,7 @@ static inline void nfs_add_stats(const struct inode *inode,
>  	nfs_add_server_stats(NFS_SERVER(inode), stat, addend);
>  }
>  
> -static inline struct nfs_iostats __percpu *nfs_alloc_iostats(void)
> -{
> -	return alloc_percpu(struct nfs_iostats);
> -}
> +#define nfs_alloc_iostats()	alloc_percpu(struct nfs_iostats)
>  
>  static inline void nfs_free_iostats(struct nfs_iostats __percpu *stats)
>  {
> diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
> index 600d4e2641da..62cac266a1c8 100644
> --- a/include/acpi/platform/aclinuxex.h
> +++ b/include/acpi/platform/aclinuxex.h
> @@ -47,26 +47,19 @@ acpi_status acpi_os_terminate(void);
>   * However, boot has  (system_state != SYSTEM_RUNNING)
>   * to quiet __might_sleep() in kmalloc() and resume does not.
>   */
> -static inline void *acpi_os_allocate(acpi_size size)
> -{
> -	return kmalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
> -}
> +#define acpi_os_allocate(_size)	\
> +		kmalloc(_size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
>  
> -static inline void *acpi_os_allocate_zeroed(acpi_size size)
> -{
> -	return kzalloc(size, irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
> -}
> +#define acpi_os_allocate_zeroed(_size)	\
> +		kzalloc(_size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
>  
>  static inline void acpi_os_free(void *memory)
>  {
>  	kfree(memory);
>  }
>  
> -static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
> -{
> -	return kmem_cache_zalloc(cache,
> -				 irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
> -}
> +#define acpi_os_acquire_object(_cache)	\
> +		kmem_cache_zalloc(_cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
>  
>  static inline acpi_thread_id acpi_os_get_thread_id(void)
>  {
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 879e5f8aa5e9..7c48f5fbf8aa 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -16,15 +16,16 @@
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
> +static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  {
> -	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL &
> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
>  			~__GFP_HIGHMEM, 0);
>  
>  	if (!ptdesc)
>  		return NULL;
>  	return ptdesc_address(ptdesc);
>  }
> +#define __pte_alloc_one_kernel(...)	alloc_hooks(__pte_alloc_one_kernel_noprof(__VA_ARGS__))
>  
>  #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
>  /**
> @@ -33,10 +34,11 @@ static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> +static inline pte_t *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  {
> -	return __pte_alloc_one_kernel(mm);
> +	return __pte_alloc_one_kernel_noprof(mm);
>  }
> +#define pte_alloc_one_kernel(...)	alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>  #endif
>  
>  /**
> @@ -61,11 +63,11 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   *
>   * Return: `struct page` referencing the ptdesc or %NULL on error
>   */
> -static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
> +static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
>  {
>  	struct ptdesc *ptdesc;
>  
> -	ptdesc = pagetable_alloc(gfp, 0);
> +	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
>  	if (!pagetable_pte_ctor(ptdesc)) {
> @@ -75,6 +77,7 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
>  
>  	return ptdesc_page(ptdesc);
>  }
> +#define __pte_alloc_one(...)	alloc_hooks(__pte_alloc_one_noprof(__VA_ARGS__))
>  
>  #ifndef __HAVE_ARCH_PTE_ALLOC_ONE
>  /**
> @@ -85,10 +88,11 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
>   *
>   * Return: `struct page` referencing the ptdesc or %NULL on error
>   */
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> +static inline pgtable_t pte_alloc_one_noprof(struct mm_struct *mm)
>  {
> -	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
> +	return __pte_alloc_one_noprof(mm, GFP_PGTABLE_USER);
>  }
> +#define pte_alloc_one(...)	alloc_hooks(pte_alloc_one_noprof(__VA_ARGS__))
>  #endif
>  
>  /*
> @@ -124,14 +128,14 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> +static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct ptdesc *ptdesc;
>  	gfp_t gfp = GFP_PGTABLE_USER;
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	ptdesc = pagetable_alloc(gfp, 0);
> +	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
>  	if (!pagetable_pmd_ctor(ptdesc)) {
> @@ -140,6 +144,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  	}
>  	return ptdesc_address(ptdesc);
>  }
> +#define pmd_alloc_one(...)	alloc_hooks(pmd_alloc_one_noprof(__VA_ARGS__))
>  #endif
>  
>  #ifndef __HAVE_ARCH_PMD_FREE
> @@ -157,7 +162,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
>  
> -static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> +static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
>  {
>  	gfp_t gfp = GFP_PGTABLE_USER;
>  	struct ptdesc *ptdesc;
> @@ -166,13 +171,14 @@ static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  		gfp = GFP_PGTABLE_KERNEL;
>  	gfp &= ~__GFP_HIGHMEM;
>  
> -	ptdesc = pagetable_alloc(gfp, 0);
> +	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
>  
>  	pagetable_pud_ctor(ptdesc);
>  	return ptdesc_address(ptdesc);
>  }
> +#define __pud_alloc_one(...)	alloc_hooks(__pud_alloc_one_noprof(__VA_ARGS__))
>  
>  #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
>  /**
> @@ -184,10 +190,11 @@ static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> +static inline pud_t *pud_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
>  {
> -	return __pud_alloc_one(mm, addr);
> +	return __pud_alloc_one_noprof(mm, addr);
>  }
> +#define pud_alloc_one(...)	alloc_hooks(pud_alloc_one_noprof(__VA_ARGS__))
>  #endif
>  
>  static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 5d61f576cfc8..e5181cc9b7c5 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -578,19 +578,20 @@ static inline void ahash_request_set_tfm(struct ahash_request *req,
>   *
>   * Return: allocated request handle in case of success, or NULL if out of memory
>   */
> -static inline struct ahash_request *ahash_request_alloc(
> +static inline struct ahash_request *ahash_request_alloc_noprof(
>  	struct crypto_ahash *tfm, gfp_t gfp)
>  {
>  	struct ahash_request *req;
>  
> -	req = kmalloc(sizeof(struct ahash_request) +
> -		      crypto_ahash_reqsize(tfm), gfp);
> +	req = kmalloc_noprof(sizeof(struct ahash_request) +
> +			     crypto_ahash_reqsize(tfm), gfp);
>  
>  	if (likely(req))
>  		ahash_request_set_tfm(req, tfm);
>  
>  	return req;
>  }
> +#define ahash_request_alloc(...)	alloc_hooks(ahash_request_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * ahash_request_free() - zeroize and free the request data structure
> diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
> index 4ac46bafba9d..2a67793f52ad 100644
> --- a/include/crypto/internal/acompress.h
> +++ b/include/crypto/internal/acompress.h
> @@ -69,15 +69,16 @@ static inline void acomp_request_complete(struct acomp_req *req,
>  	crypto_request_complete(&req->base, err);
>  }
>  
> -static inline struct acomp_req *__acomp_request_alloc(struct crypto_acomp *tfm)
> +static inline struct acomp_req *__acomp_request_alloc_noprof(struct crypto_acomp *tfm)
>  {
>  	struct acomp_req *req;
>  
> -	req = kzalloc(sizeof(*req) + crypto_acomp_reqsize(tfm), GFP_KERNEL);
> +	req = kzalloc_noprof(sizeof(*req) + crypto_acomp_reqsize(tfm), GFP_KERNEL);
>  	if (likely(req))
>  		acomp_request_set_tfm(req, tfm);
>  	return req;
>  }
> +#define __acomp_request_alloc(...)	alloc_hooks(__acomp_request_alloc_noprof(__VA_ARGS__))
>  
>  static inline void __acomp_request_free(struct acomp_req *req)
>  {
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index c8857d7bdb37..6c5330e316b0 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -861,19 +861,20 @@ static inline struct skcipher_request *skcipher_request_cast(
>   *
>   * Return: allocated request handle in case of success, or NULL if out of memory
>   */
> -static inline struct skcipher_request *skcipher_request_alloc(
> +static inline struct skcipher_request *skcipher_request_alloc_noprof(
>  	struct crypto_skcipher *tfm, gfp_t gfp)
>  {
>  	struct skcipher_request *req;
>  
> -	req = kmalloc(sizeof(struct skcipher_request) +
> -		      crypto_skcipher_reqsize(tfm), gfp);
> +	req = kmalloc_noprof(sizeof(struct skcipher_request) +
> +			     crypto_skcipher_reqsize(tfm), gfp);
>  
>  	if (likely(req))
>  		skcipher_request_set_tfm(req, tfm);
>  
>  	return req;
>  }
> +#define skcipher_request_alloc(...)	alloc_hooks(skcipher_request_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * skcipher_request_free() - zeroize and free request data structure
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f20f62f9d63..a63fa48ab80d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2230,31 +2230,14 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
>  void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
>  				    size_t align, gfp_t flags);
>  #else
> -static inline void *
> -bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
> -		     int node)
> -{
> -	return kmalloc_node(size, flags, node);
> -}
> -
> -static inline void *
> -bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
> -{
> -	return kzalloc(size, flags);
> -}
> -
> -static inline void *
> -bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size, gfp_t flags)
> -{
> -	return kvcalloc(n, size, flags);
> -}
> -
> -static inline void __percpu *
> -bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
> -		     gfp_t flags)
> -{
> -	return __alloc_percpu_gfp(size, align, flags);
> -}
> +#define bpf_map_kmalloc_node(_map, _size, _flags, _node)	\
> +		kmalloc_node(_size, _flags, _node)
> +#define bpf_map_kzalloc(_map, _size, _flags)			\
> +		kzalloc(_size, _flags)
> +#define bpf_map_kvcalloc(_map, _n, _size, _flags)		\
> +		kvcalloc(_n, _size, _flags)
> +#define bpf_map_alloc_percpu(_map, _size, _align, _flags)	\
> +		__alloc_percpu_gfp(_size, _align, _flags)
>  #endif
>  
>  static inline int
> diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
> index 79b2f78eec1a..1af241525a17 100644
> --- a/include/linux/bpfptr.h
> +++ b/include/linux/bpfptr.h
> @@ -65,9 +65,9 @@ static inline int copy_to_bpfptr_offset(bpfptr_t dst, size_t offset,
>  	return copy_to_sockptr_offset((sockptr_t) dst, offset, src, size);
>  }
>  
> -static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
> +static inline void *kvmemdup_bpfptr_noprof(bpfptr_t src, size_t len)
>  {
> -	void *p = kvmalloc(len, GFP_USER | __GFP_NOWARN);
> +	void *p = kvmalloc_noprof(len, GFP_USER | __GFP_NOWARN);
>  
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> @@ -77,6 +77,7 @@ static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
>  	}
>  	return p;
>  }
> +#define kvmemdup_bpfptr(...)	alloc_hooks(kvmemdup_bpfptr_noprof(__VA_ARGS__))
>  
>  static inline long strncpy_from_bpfptr(char *dst, bpfptr_t src, size_t count)
>  {
> diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
> index 4bdf0b96da28..ad9e2506c2f4 100644
> --- a/include/linux/dma-fence-chain.h
> +++ b/include/linux/dma-fence-chain.h
> @@ -86,10 +86,8 @@ dma_fence_chain_contained(struct dma_fence *fence)
>   *
>   * Returns a new struct dma_fence_chain object or NULL on failure.
>   */
> -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> -{
> -	return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> -};
> +#define dma_fence_chain_alloc()	\
> +		((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL))
>  
>  /**
>   * dma_fence_chain_free
> diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> index 7118ac28d468..ca70eeb6393e 100644
> --- a/include/linux/hid_bpf.h
> +++ b/include/linux/hid_bpf.h
> @@ -149,10 +149,8 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
>  static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
>  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
>  static inline void hid_bpf_device_init(struct hid_device *hid) {}
> -static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
> -{
> -	return kmemdup(rdesc, *size, GFP_KERNEL);
> -}
> +#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size)	\
> +		((u8 *)kmemdup(_rdesc, *(_size), GFP_KERNEL))
>  
>  #endif /* CONFIG_HID_BPF */
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 971f3e826e15..9512fe332668 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1586,10 +1586,8 @@ void jbd2_journal_put_journal_head(struct journal_head *jh);
>   */
>  extern struct kmem_cache *jbd2_handle_cache;
>  
> -static inline handle_t *jbd2_alloc_handle(gfp_t gfp_flags)
> -{
> -	return kmem_cache_zalloc(jbd2_handle_cache, gfp_flags);
> -}
> +#define jbd2_alloc_handle(_gfp_flags)	\
> +		((handle_t *)kmem_cache_zalloc(jbd2_handle_cache, _gfp_flags))
>  
>  static inline void jbd2_free_handle(handle_t *handle)
>  {
> @@ -1602,10 +1600,8 @@ static inline void jbd2_free_handle(handle_t *handle)
>   */
>  extern struct kmem_cache *jbd2_inode_cache;
>  
> -static inline struct jbd2_inode *jbd2_alloc_inode(gfp_t gfp_flags)
> -{
> -	return kmem_cache_alloc(jbd2_inode_cache, gfp_flags);
> -}
> +#define jbd2_alloc_inode(_gfp_flags)	\
> +		((struct jbd2_inode *)kmem_cache_alloc(jbd2_inode_cache, _gfp_flags))
>  
>  static inline void jbd2_free_inode(struct jbd2_inode *jinode)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 07c73451d42f..d261e45bb29b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2899,12 +2899,13 @@ static inline bool pagetable_is_reserved(struct ptdesc *pt)
>   *
>   * Return: The ptdesc describing the allocated page tables.
>   */
> -static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> +static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
>  {
> -	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> +	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
>  
>  	return page_ptdesc(page);
>  }
> +#define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * pagetable_free - Free pagetables
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c432add95913..db0adf5721cc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1167,14 +1167,15 @@ static inline void mm_init_cid(struct mm_struct *mm)
>  	cpumask_clear(mm_cidmask(mm));
>  }
>  
> -static inline int mm_alloc_cid(struct mm_struct *mm)
> +static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
>  {
> -	mm->pcpu_cid = alloc_percpu(struct mm_cid);
> +	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
>  	if (!mm->pcpu_cid)
>  		return -ENOMEM;
>  	mm_init_cid(mm);
>  	return 0;
>  }
> +#define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
>  
>  static inline void mm_destroy_cid(struct mm_struct *mm)
>  {
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 13a82f11e4fd..03053de557cf 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -151,6 +151,9 @@ extern size_t pcpu_alloc_size(void __percpu *__pdata);
>  #define alloc_percpu(type)						\
>  	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
>  						__alignof__(type))
> +#define alloc_percpu_noprof(type)					\
> +	((typeof(type) __percpu *)pcpu_alloc_noprof(sizeof(type),	\
> +					__alignof__(type), false, GFP_KERNEL))
>  
>  extern void free_percpu(void __percpu *__pdata);
>  
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 808f9d3ee546..fd037c127bb0 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -464,11 +464,11 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  /* Not all gfp_t flags (besides GFP_KERNEL) are allowed. See
>   * documentation for vmalloc for which of them are legal.
>   */
> -static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
> +static inline void **__ptr_ring_init_queue_alloc_noprof(unsigned int size, gfp_t gfp)
>  {
>  	if (size > KMALLOC_MAX_SIZE / sizeof(void *))
>  		return NULL;
> -	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
> +	return kvmalloc_array_noprof(size, sizeof(void *), gfp | __GFP_ZERO);
>  }
>  
>  static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
> @@ -484,9 +484,9 @@ static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
>  		r->batch = 1;
>  }
>  
> -static inline int ptr_ring_init(struct ptr_ring *r, int size, gfp_t gfp)
> +static inline int ptr_ring_init_noprof(struct ptr_ring *r, int size, gfp_t gfp)
>  {
> -	r->queue = __ptr_ring_init_queue_alloc(size, gfp);
> +	r->queue = __ptr_ring_init_queue_alloc_noprof(size, gfp);
>  	if (!r->queue)
>  		return -ENOMEM;
>  
> @@ -497,6 +497,7 @@ static inline int ptr_ring_init(struct ptr_ring *r, int size, gfp_t gfp)
>  
>  	return 0;
>  }
> +#define ptr_ring_init(...)	alloc_hooks(ptr_ring_init_noprof(__VA_ARGS__))
>  
>  /*
>   * Return entries into ring. Destroy entries that don't fit.
> @@ -587,11 +588,11 @@ static inline void **__ptr_ring_swap_queue(struct ptr_ring *r, void **queue,
>   * In particular if you consume ring in interrupt or BH context, you must
>   * disable interrupts/BH when doing so.
>   */
> -static inline int ptr_ring_resize(struct ptr_ring *r, int size, gfp_t gfp,
> +static inline int ptr_ring_resize_noprof(struct ptr_ring *r, int size, gfp_t gfp,
>  				  void (*destroy)(void *))
>  {
>  	unsigned long flags;
> -	void **queue = __ptr_ring_init_queue_alloc(size, gfp);
> +	void **queue = __ptr_ring_init_queue_alloc_noprof(size, gfp);
>  	void **old;
>  
>  	if (!queue)
> @@ -609,6 +610,7 @@ static inline int ptr_ring_resize(struct ptr_ring *r, int size, gfp_t gfp,
>  
>  	return 0;
>  }
> +#define ptr_ring_resize(...)	alloc_hooks(ptr_ring_resize_noprof(__VA_ARGS__))
>  
>  /*
>   * Note: producer lock is nested within consumer lock, so if you
> @@ -616,21 +618,21 @@ static inline int ptr_ring_resize(struct ptr_ring *r, int size, gfp_t gfp,
>   * In particular if you consume ring in interrupt or BH context, you must
>   * disable interrupts/BH when doing so.
>   */
> -static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
> -					   unsigned int nrings,
> -					   int size,
> -					   gfp_t gfp, void (*destroy)(void *))
> +static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
> +						  unsigned int nrings,
> +						  int size,
> +						  gfp_t gfp, void (*destroy)(void *))
>  {
>  	unsigned long flags;
>  	void ***queues;
>  	int i;
>  
> -	queues = kmalloc_array(nrings, sizeof(*queues), gfp);
> +	queues = kmalloc_array_noprof(nrings, sizeof(*queues), gfp);
>  	if (!queues)
>  		goto noqueues;
>  
>  	for (i = 0; i < nrings; ++i) {
> -		queues[i] = __ptr_ring_init_queue_alloc(size, gfp);
> +		queues[i] = __ptr_ring_init_queue_alloc_noprof(size, gfp);
>  		if (!queues[i])
>  			goto nomem;
>  	}
> @@ -660,6 +662,8 @@ static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
>  noqueues:
>  	return -ENOMEM;
>  }
> +#define ptr_ring_resize_multiple(...) \
> +		alloc_hooks(ptr_ring_resize_multiple_noprof(__VA_ARGS__))
>  
>  static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
>  {
> diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
> index e2d45b7cb619..926496c9cc9c 100644
> --- a/include/linux/skb_array.h
> +++ b/include/linux/skb_array.h
> @@ -177,10 +177,11 @@ static inline int skb_array_peek_len_any(struct skb_array *a)
>  	return PTR_RING_PEEK_CALL_ANY(&a->ring, __skb_array_len_with_tag);
>  }
>  
> -static inline int skb_array_init(struct skb_array *a, int size, gfp_t gfp)
> +static inline int skb_array_init_noprof(struct skb_array *a, int size, gfp_t gfp)
>  {
> -	return ptr_ring_init(&a->ring, size, gfp);
> +	return ptr_ring_init_noprof(&a->ring, size, gfp);
>  }
> +#define skb_array_init(...)	alloc_hooks(skb_array_init_noprof(__VA_ARGS__))
>  
>  static void __skb_array_destroy_skb(void *ptr)
>  {
> @@ -198,15 +199,17 @@ static inline int skb_array_resize(struct skb_array *a, int size, gfp_t gfp)
>  	return ptr_ring_resize(&a->ring, size, gfp, __skb_array_destroy_skb);
>  }
>  
> -static inline int skb_array_resize_multiple(struct skb_array **rings,
> -					    int nrings, unsigned int size,
> -					    gfp_t gfp)
> +static inline int skb_array_resize_multiple_noprof(struct skb_array **rings,
> +						   int nrings, unsigned int size,
> +						   gfp_t gfp)
>  {
>  	BUILD_BUG_ON(offsetof(struct skb_array, ring));
> -	return ptr_ring_resize_multiple((struct ptr_ring **)rings,
> -					nrings, size, gfp,
> -					__skb_array_destroy_skb);
> +	return ptr_ring_resize_multiple_noprof((struct ptr_ring **)rings,
> +					       nrings, size, gfp,
> +					       __skb_array_destroy_skb);
>  }
> +#define skb_array_resize_multiple(...)	\
> +		alloc_hooks(skb_array_resize_multiple_noprof(__VA_ARGS__))
>  
>  static inline void skb_array_cleanup(struct skb_array *a)
>  {
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9d24aec064e8..b72920c9887b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3371,7 +3371,7 @@ void __napi_kfree_skb(struct sk_buff *skb, enum skb_drop_reason reason);
>   *
>   * %NULL is returned if there is no free memory.
>  */
> -static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
> +static inline struct page *__dev_alloc_pages_noprof(gfp_t gfp_mask,
>  					     unsigned int order)
>  {
>  	/* This piece of code contains several assumptions.
> @@ -3384,13 +3384,11 @@ static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
>  	 */
>  	gfp_mask |= __GFP_COMP | __GFP_MEMALLOC;
>  
> -	return alloc_pages_node(NUMA_NO_NODE, gfp_mask, order);
> +	return alloc_pages_node_noprof(NUMA_NO_NODE, gfp_mask, order);
>  }
> +#define __dev_alloc_pages(...)	alloc_hooks(__dev_alloc_pages_noprof(__VA_ARGS__))
>  
> -static inline struct page *dev_alloc_pages(unsigned int order)
> -{
> -	return __dev_alloc_pages(GFP_ATOMIC | __GFP_NOWARN, order);
> -}
> +#define dev_alloc_pages(_order) __dev_alloc_pages(GFP_ATOMIC | __GFP_NOWARN, _order)
>  
>  /**
>   * __dev_alloc_page - allocate a page for network Rx
> @@ -3400,15 +3398,13 @@ static inline struct page *dev_alloc_pages(unsigned int order)
>   *
>   * %NULL is returned if there is no free memory.
>   */
> -static inline struct page *__dev_alloc_page(gfp_t gfp_mask)
> +static inline struct page *__dev_alloc_page_noprof(gfp_t gfp_mask)
>  {
> -	return __dev_alloc_pages(gfp_mask, 0);
> +	return __dev_alloc_pages_noprof(gfp_mask, 0);
>  }
> +#define __dev_alloc_page(...)	alloc_hooks(__dev_alloc_page_noprof(__VA_ARGS__))
>  
> -static inline struct page *dev_alloc_page(void)
> -{
> -	return dev_alloc_pages(0);
> -}
> +#define dev_alloc_page()	dev_alloc_pages(0)
>  
>  /**
>   * dev_page_is_reusable - check whether a page can be reused for network Rx
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index e65ec3fd2799..78efc5b20284 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -410,11 +410,9 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock);
>  int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>  			 struct sk_msg *msg);
>  
> -static inline struct sk_psock_link *sk_psock_init_link(void)
> -{
> -	return kzalloc(sizeof(struct sk_psock_link),
> -		       GFP_ATOMIC | __GFP_NOWARN);
> -}
> +#define sk_psock_init_link()	\
> +		((struct sk_psock_link *)kzalloc(sizeof(struct sk_psock_link),	\
> +						 GFP_ATOMIC | __GFP_NOWARN))
>  
>  static inline void sk_psock_free_link(struct sk_psock_link *link)
>  {
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c0be1cd03cf6..4cc37ef22aae 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -744,6 +744,9 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
>   */
>  #define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
>  
> +#define kmalloc_track_caller_noprof(...)	\
> +		kmalloc_node_track_caller_noprof(__VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
> +
>  static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
>  							  int node)
>  {
> @@ -781,6 +784,7 @@ extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_si
>  #define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
>  
>  #define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
> +#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
>  #define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
>  
>  #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
> @@ -797,6 +801,7 @@ static inline __alloc_size(1, 2) void *kvmalloc_array_noprof(size_t n, size_t si
>  
>  #define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
>  #define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__GFP_ZERO)
> +#define kvcalloc_noprof(_n, _size, _flags)	kvmalloc_array_noprof(_n, _size, _flags|__GFP_ZERO)
>  
>  extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
>  		      __realloc_size(3);
> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> index 307961b41541..ba703b22e7d8 100644
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -92,9 +92,9 @@ static inline int copy_to_sockptr(sockptr_t dst, const void *src, size_t size)
>  	return copy_to_sockptr_offset(dst, 0, src, size);
>  }
>  
> -static inline void *memdup_sockptr(sockptr_t src, size_t len)
> +static inline void *memdup_sockptr_noprof(sockptr_t src, size_t len)
>  {
> -	void *p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
> +	void *p = kmalloc_track_caller_noprof(len, GFP_USER | __GFP_NOWARN);
>  
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> @@ -104,10 +104,11 @@ static inline void *memdup_sockptr(sockptr_t src, size_t len)
>  	}
>  	return p;
>  }
> +#define memdup_sockptr(...)	alloc_hooks(memdup_sockptr_noprof(__VA_ARGS__))
>  
> -static inline void *memdup_sockptr_nul(sockptr_t src, size_t len)
> +static inline void *memdup_sockptr_nul_noprof(sockptr_t src, size_t len)
>  {
> -	char *p = kmalloc_track_caller(len + 1, GFP_KERNEL);
> +	char *p = kmalloc_track_caller_noprof(len + 1, GFP_KERNEL);
>  
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> @@ -118,6 +119,7 @@ static inline void *memdup_sockptr_nul(sockptr_t src, size_t len)
>  	p[len] = '\0';
>  	return p;
>  }
> +#define memdup_sockptr_nul(...)	alloc_hooks(memdup_sockptr_nul_noprof(__VA_ARGS__))
>  
>  static inline long strncpy_from_sockptr(char *dst, sockptr_t src, size_t count)
>  {
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index f3ab0b8a4b18..c31bd96dafdb 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -274,15 +274,17 @@ struct netlbl_calipso_ops {
>   * on success, NULL on failure.
>   *
>   */
> -static inline struct netlbl_lsm_cache *netlbl_secattr_cache_alloc(gfp_t flags)
> +static inline struct netlbl_lsm_cache *netlbl_secattr_cache_alloc_noprof(gfp_t flags)
>  {
>  	struct netlbl_lsm_cache *cache;
>  
> -	cache = kzalloc(sizeof(*cache), flags);
> +	cache = kzalloc_noprof(sizeof(*cache), flags);
>  	if (cache)
>  		refcount_set(&cache->refcount, 1);
>  	return cache;
>  }
> +#define netlbl_secattr_cache_alloc(...)	\
> +		alloc_hooks(netlbl_secattr_cache_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * netlbl_secattr_cache_free - Frees a netlbl_lsm_cache struct
> @@ -311,10 +313,11 @@ static inline void netlbl_secattr_cache_free(struct netlbl_lsm_cache *cache)
>   * on failure.
>   *
>   */
> -static inline struct netlbl_lsm_catmap *netlbl_catmap_alloc(gfp_t flags)
> +static inline struct netlbl_lsm_catmap *netlbl_catmap_alloc_noprof(gfp_t flags)
>  {
> -	return kzalloc(sizeof(struct netlbl_lsm_catmap), flags);
> +	return kzalloc_noprof(sizeof(struct netlbl_lsm_catmap), flags);
>  }
> +#define netlbl_catmap_alloc(...)	alloc_hooks(netlbl_catmap_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * netlbl_catmap_free - Free a LSM secattr catmap
> @@ -376,10 +379,11 @@ static inline void netlbl_secattr_destroy(struct netlbl_lsm_secattr *secattr)
>   * pointer on success, or NULL on failure.
>   *
>   */
> -static inline struct netlbl_lsm_secattr *netlbl_secattr_alloc(gfp_t flags)
> +static inline struct netlbl_lsm_secattr *netlbl_secattr_alloc_noprof(gfp_t flags)
>  {
> -	return kzalloc(sizeof(struct netlbl_lsm_secattr), flags);
> +	return kzalloc_noprof(sizeof(struct netlbl_lsm_secattr), flags);
>  }
> +#define netlbl_secattr_alloc(...)	alloc_hooks(netlbl_secattr_alloc_noprof(__VA_ARGS__))
>  
>  /**
>   * netlbl_secattr_free - Frees a netlbl_lsm_secattr struct
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index c19ff921b661..972b5484fa6f 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1891,10 +1891,11 @@ static inline struct nla_bitfield32 nla_get_bitfield32(const struct nlattr *nla)
>   * @src: netlink attribute to duplicate from
>   * @gfp: GFP mask
>   */
> -static inline void *nla_memdup(const struct nlattr *src, gfp_t gfp)
> +static inline void *nla_memdup_noprof(const struct nlattr *src, gfp_t gfp)
>  {
> -	return kmemdup(nla_data(src), nla_len(src), gfp);
> +	return kmemdup_noprof(nla_data(src), nla_len(src), gfp);
>  }
> +#define nla_memdup(...)	alloc_hooks(nla_memdup_noprof(__VA_ARGS__))
>  
>  /**
>   * nla_nest_start_noflag - Start a new level of nested attributes
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 004e651e6067..29495c331d20 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -127,12 +127,12 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
>  }
>  
>  static inline struct request_sock *
> -reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
> +reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
>  	    bool attach_listener)
>  {
>  	struct request_sock *req;
>  
> -	req = kmem_cache_alloc(ops->slab, GFP_ATOMIC | __GFP_NOWARN);
> +	req = kmem_cache_alloc_noprof(ops->slab, GFP_ATOMIC | __GFP_NOWARN);
>  	if (!req)
>  		return NULL;
>  	req->rsk_listener = NULL;
> @@ -157,6 +157,7 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
>  
>  	return req;
>  }
> +#define reqsk_alloc(...)	alloc_hooks(reqsk_alloc_noprof(__VA_ARGS__))
>  
>  static inline void __reqsk_free(struct request_sock *req)
>  {
> diff --git a/include/net/tcx.h b/include/net/tcx.h
> index 04be9377785d..72a3e75e539f 100644
> --- a/include/net/tcx.h
> +++ b/include/net/tcx.h
> @@ -75,9 +75,9 @@ tcx_entry_fetch(struct net_device *dev, bool ingress)
>  		return rcu_dereference_rtnl(dev->tcx_egress);
>  }
>  
> -static inline struct bpf_mprog_entry *tcx_entry_create(void)
> +static inline struct bpf_mprog_entry *tcx_entry_create_noprof(void)
>  {
> -	struct tcx_entry *tcx = kzalloc(sizeof(*tcx), GFP_KERNEL);
> +	struct tcx_entry *tcx = kzalloc_noprof(sizeof(*tcx), GFP_KERNEL);
>  
>  	if (tcx) {
>  		bpf_mprog_bundle_init(&tcx->bundle);
> @@ -85,6 +85,7 @@ static inline struct bpf_mprog_entry *tcx_entry_create(void)
>  	}
>  	return NULL;
>  }
> +#define tcx_entry_create(...)	alloc_hooks(tcx_entry_create_noprof(__VA_ARGS__))
>  
>  static inline void tcx_entry_free(struct bpf_mprog_entry *entry)
>  {
> diff --git a/net/sunrpc/auth_gss/auth_gss_internal.h b/net/sunrpc/auth_gss/auth_gss_internal.h
> index c53b329092d4..4ebc1b7043d9 100644
> --- a/net/sunrpc/auth_gss/auth_gss_internal.h
> +++ b/net/sunrpc/auth_gss/auth_gss_internal.h
> @@ -23,7 +23,7 @@ simple_get_bytes(const void *p, const void *end, void *res, size_t len)
>  }
>  
>  static inline const void *
> -simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
> +simple_get_netobj_noprof(const void *p, const void *end, struct xdr_netobj *dest)
>  {
>  	const void *q;
>  	unsigned int len;
> @@ -35,7 +35,7 @@ simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
>  	if (unlikely(q > end || q < p))
>  		return ERR_PTR(-EFAULT);
>  	if (len) {
> -		dest->data = kmemdup(p, len, GFP_KERNEL);
> +		dest->data = kmemdup_noprof(p, len, GFP_KERNEL);
>  		if (unlikely(dest->data == NULL))
>  			return ERR_PTR(-ENOMEM);
>  	} else
> @@ -43,3 +43,5 @@ simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
>  	dest->len = len;
>  	return q;
>  }
> +
> +#define simple_get_netobj(...)	alloc_hooks(simple_get_netobj_noprof(__VA_ARGS__))
> 
> base-commit: 3aec6b2b34e219898883d1e9ea7e911b4d3762a9
> -- 
> 2.44.0.683.g7961c838ac-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

