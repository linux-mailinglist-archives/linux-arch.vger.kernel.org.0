Return-Path: <linux-arch+bounces-8167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C126999E994
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851142825C2
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B41EF93E;
	Tue, 15 Oct 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbKbeUOf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C651EF934;
	Tue, 15 Oct 2024 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994754; cv=none; b=hZcFlURz83U4KycokIihpQC6oQkIO6JJbI3PSVq5aL3tCBUdG3be+s6HNMLusSUyhF1mjoyZfa6X6bCfTI/MXQ3gZjDK5hpGdH+IZvLLFIBnjbm97dDIezrQpoXMBoi8TCmZA4AsLT1Evh8YhcVodm761LwsrVmNwhsWRVdEUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994754; c=relaxed/simple;
	bh=h4+7by0rAf1o7D24l+y+0PKeuIiAXm/n19ReSlgbZAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7qIKT2jDM08UGP2TqZu8lv2lQL+tyC1Oh1uybYVQNjN0lgIfOlHx7XDJhEdX56Kn9lfDeK00xrkbUnYlLdoODUg9xujeRSvepTzlL8Rk3Pud+GFaGQbzQcEwSW2BlwFCVusYa8nyWvODCCjxebs08V/Uj4/P3kdlIlV38UglmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbKbeUOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0037C4CEC6;
	Tue, 15 Oct 2024 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728994753;
	bh=h4+7by0rAf1o7D24l+y+0PKeuIiAXm/n19ReSlgbZAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbKbeUOfn9nyDXrtBn7g19Dpfjiiw77gfgeY76w/MQudeJ+b61eaCe1lNNUr/wZsx
	 NPYYUCCNZqjY+e0FpiMV0ssGHtIM4kTnGCLC/d7Nkj7MozDRcNrxTwPsujBUIQd6dh
	 I7iGN20nS0P09TvQqbm0ZYkIwkbZECUW+yKmPcegYF8REA5wenOFpRoO2SVolOkynd
	 nTd0FKRDimQvqjAtQjL34RYpNOxdkS2f+FMd4CvvRoEYfynQsvPeYauSwnLRHBt0id
	 XBJTOVhu64U/+vudH7ZYapQVuQFYm6Y/c5zlyGCODMyTrwKlF3NtvOZ9lcr+LvwugG
	 ChpqrAC7oGC8A==
Date: Tue, 15 Oct 2024 15:15:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
	arnd@arndb.de, mcgrof@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, pasha.tatashin@soleen.com,
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 3/5] alloc_tag: populate memory for module tags as
 needed
Message-ID: <Zw5c3zjW4sUUmont@kernel.org>
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014203646.1952505-4-surenb@google.com>

On Mon, Oct 14, 2024 at 01:36:44PM -0700, Suren Baghdasaryan wrote:
> The memory reserved for module tags does not need to be backed by
> physical pages until there are tags to store there. Change the way
> we reserve this memory to allocate only virtual area for the tags
> and populate it with physical pages as needed when we load a module.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/execmem.h | 11 ++++++
>  include/linux/vmalloc.h |  9 +++++
>  lib/alloc_tag.c         | 84 +++++++++++++++++++++++++++++++++--------
>  mm/execmem.c            | 16 ++++++++
>  mm/vmalloc.c            |  4 +-
>  5 files changed, 106 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index 7436aa547818..a159a073270a 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -127,6 +127,17 @@ void *execmem_alloc(enum execmem_type type, size_t size);
>   */
>  void execmem_free(void *ptr);
>  
> +/**
> + * execmem_vmap - create virtual mapping for executable memory
> + * @type: type of the allocation
> + * @size: size of the virtual mapping in bytes
> + *
> + * Maps virtually contiguous area that can be populated with executable code.
> + *
> + * Return: the area descriptor on success or %NULL on failure.
> + */
> +struct vm_struct *execmem_vmap(enum execmem_type type, size_t size);
> +

I think it's better limit it to EXECMEM_MODULE_DATA

>  /**
>   * execmem_update_copy - copy an update to executable memory
>   * @dst:  destination address to update
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 9a012cd4fad2..9d64cc6f24d1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -202,6 +202,9 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
>  extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
>  							unsigned long pgoff);
>  
> +int vmap_pages_range(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages, unsigned int page_shift);
> +
>
>  /*
>   * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
>   * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> @@ -239,6 +242,12 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
>  					unsigned long flags,
>  					unsigned long start, unsigned long end,
>  					const void *caller);
> +struct vm_struct *__get_vm_area_node(unsigned long size,
> +				     unsigned long align, unsigned long shift,
> +				     unsigned long flags, unsigned long start,
> +				     unsigned long end, int node, gfp_t gfp_mask,
> +				     const void *caller);
> +

This is not used outside mm/, let's put it into mm/internal.h

>  void free_vm_area(struct vm_struct *area);
>  extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index b10e7f17eeda..648f32d52b8d 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -8,6 +8,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_buf.h>
>  #include <linux/seq_file.h>
> +#include <linux/vmalloc.h>
>  
>  static struct codetag_type *alloc_tag_cttype;
>  
> @@ -153,6 +154,7 @@ static void __init procfs_init(void)
>  #ifdef CONFIG_MODULES
>  
>  static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
> +static struct vm_struct *vm_module_tags;
>  /* A dummy object used to indicate an unloaded module */
>  static struct module unloaded_mod;
>  /* A dummy object used to indicate a module prepended area */
> @@ -195,6 +197,25 @@ static void clean_unused_module_areas_locked(void)
>  	}
>  }
>  
> +static int vm_module_tags_grow(unsigned long addr, unsigned long bytes)
> +{
> +	struct page **next_page = vm_module_tags->pages + vm_module_tags->nr_pages;
> +	unsigned long more_pages = ALIGN(bytes, PAGE_SIZE) >> PAGE_SHIFT;
> +	unsigned long nr;
> +
> +	nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
> +					 NUMA_NO_NODE, more_pages, next_page);
> +	if (nr != more_pages)
> +		return -ENOMEM;
> +
> +	vm_module_tags->nr_pages += nr;
> +	if (vmap_pages_range(addr, addr + (nr << PAGE_SHIFT),
> +			     PAGE_KERNEL, next_page, PAGE_SHIFT) < 0)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static void *reserve_module_tags(struct module *mod, unsigned long size,
>  				 unsigned int prepend, unsigned long align)
>  {
> @@ -202,7 +223,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  	MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
>  	bool cleanup_done = false;
>  	unsigned long offset;
> -	void *ret;
> +	void *ret = NULL;
>  
>  	/* If no tags return NULL */
>  	if (size < sizeof(struct alloc_tag))
> @@ -239,7 +260,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  		goto repeat;
>  	} else {
>  		ret = ERR_PTR(-ENOMEM);
> -		goto out;
> +		goto unlock;
>  	}
>  
>  found:
> @@ -254,7 +275,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  		mas_store(&mas, &prepend_mod);
>  		if (mas_is_err(&mas)) {
>  			ret = ERR_PTR(xa_err(mas.node));
> -			goto out;
> +			goto unlock;
>  		}
>  		mas.index = offset;
>  		mas.last = offset + size - 1;
> @@ -263,7 +284,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  			ret = ERR_PTR(xa_err(mas.node));
>  			mas.index = pad_start;
>  			mas_erase(&mas);
> -			goto out;
> +			goto unlock;
>  		}
>  
>  	} else {
> @@ -271,18 +292,33 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  		mas_store(&mas, mod);
>  		if (mas_is_err(&mas)) {
>  			ret = ERR_PTR(xa_err(mas.node));
> -			goto out;
> +			goto unlock;
>  		}
>  	}
> +unlock:
> +	mas_unlock(&mas);
> +	if (IS_ERR(ret))
> +		return ret;
>  
> -	if (module_tags.size < offset + size)
> -		module_tags.size = offset + size;
> +	if (module_tags.size < offset + size) {
> +		unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
>  
> -	ret = (struct alloc_tag *)(module_tags.start_addr + offset);
> -out:
> -	mas_unlock(&mas);
> +		module_tags.size = offset + size;
> +		if (phys_size < module_tags.size) {
> +			int grow_res;
> +
> +			grow_res = vm_module_tags_grow(module_tags.start_addr + phys_size,
> +						       module_tags.size - phys_size);
> +			if (grow_res) {
> +				static_branch_disable(&mem_alloc_profiling_key);
> +				pr_warn("Failed to allocate tags memory for module %s. Memory profiling is disabled!\n",
> +					mod->name);
> +				return ERR_PTR(grow_res);
> +			}
> +		}
> +	}

The diff for reserve_module_tags() is hard to read, and the function itself
becomes really complex to follow with all the gotos back and forth.
Maybe it's possible to split out some parts of it as helpers?

> -	return ret;
> +	return (struct alloc_tag *)(module_tags.start_addr + offset);
>  }
>  

-- 
Sincerely yours,
Mike.

