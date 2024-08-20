Return-Path: <linux-arch+bounces-6366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE25957F2A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D291F21B71
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC116C86B;
	Tue, 20 Aug 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz+4Mc8a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4B152165;
	Tue, 20 Aug 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138011; cv=none; b=jHy2MQdHKcTY6C78okmBUsyJ2bshsEtf0iDLGxUqk8FM+KVvKoHQrH4rBvcZZPGaHXieKR3eliQCoqE852mKjG8UAyC+c2VG2lR5pJya57wtUi7ezLzdoM2vMjHKp4FDdUNlUzj6AXGX/dfhTpzQzmwWTrqwIAjcctSaA+sYbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138011; c=relaxed/simple;
	bh=P4Xoto1kb9GxBJ4mRYqIpsziqZnk0OuzLbdWEFfVZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOsgOHzJf4Y9RKab8NWfzx65+o6g/pAqOUtGqLyn6IwbAdUtm2y/BxTNMyQHHsR6qhIV4ahNeZsFzTmg3SmrcAHDEV71oOyFNGunYAlybuAO3+QtNzsgWbm6d9o51TxaYmf0w6OFBF7fTgFnsGym0+ct2ss0oqiCNl/ymPY9/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz+4Mc8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD46C4AF09;
	Tue, 20 Aug 2024 07:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724138010;
	bh=P4Xoto1kb9GxBJ4mRYqIpsziqZnk0OuzLbdWEFfVZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gz+4Mc8a6bR73MyttJH1WKF45lDJDtOwWsfsUBDrK6xUysURbUJcwEvyW17ferVr5
	 b8xWmLKE7Hw4lwwchPrCzinppb3/s7DNzQ56UV9asRxSibNosq/tQewjQ3NGlt8BHu
	 E6TvIE+cC6ndzeFv7iv4yn4hz/XWioUueUZubt9uGQyeRDQbWlHPl3xI778KnsjJVL
	 oNalnsafluqag/HrQfU/xgw9mSUC1vUKX0nZFB5Ej0ZbSGOOkLPNT02Hw9OSAe/CRR
	 3Jb8vTiQ1oDNQjqzfk4bqcsSrAHxtXvU2dsPRiqgjmvF7bsdLFIanOAfCPEx5gavMS
	 asTEvBA/nwoLg==
Date: Tue, 20 Aug 2024 10:13:07 +0300
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
Subject: Re: [PATCH 1/5] alloc_tag: load module tags into separate continuous
 memory
Message-ID: <ZsRCAy5cCp0Ig3I/@kernel.org>
References: <20240819151512.2363698-1-surenb@google.com>
 <20240819151512.2363698-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819151512.2363698-2-surenb@google.com>

On Mon, Aug 19, 2024 at 08:15:07AM -0700, Suren Baghdasaryan wrote:
> When a module gets unloaded there is a possibility that some of the
> allocations it made are still used and therefore the allocation tags
> corresponding to these allocations are still referenced. As such, the
> memory for these tags can't be freed. This is currently handled as an
> abnormal situation and module's data section is not being unloaded.
> To handle this situation without keeping module's data in memory,
> allow codetags with longer lifespan than the module to be loaded into
> their own separate memory. The in-use memory areas and gaps after
> module unloading in this separate memory are tracked using maple trees.
> Allocation tags arrange their separate memory so that it is virtually
> contiguous and that will allow simple allocation tag indexing later on
> in this patchset. The size of this virtually contiguous memory is set
> to store up to 100000 allocation tags and max_module_alloc_tags kernel
> parameter is introduced to change this size.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  include/asm-generic/codetag.lds.h             |  19 ++
>  include/linux/alloc_tag.h                     |  13 +-
>  include/linux/codetag.h                       |  35 ++-
>  kernel/module/main.c                          |  67 +++--
>  lib/alloc_tag.c                               | 245 ++++++++++++++++--
>  lib/codetag.c                                 | 101 +++++++-
>  scripts/module.lds.S                          |   5 +-
>  8 files changed, 429 insertions(+), 60 deletions(-)
 
...

> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index c2a579ccd455..c4a3dd60205e 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -35,8 +35,13 @@ struct codetag_type_desc {
>  	size_t tag_size;
>  	void (*module_load)(struct codetag_type *cttype,
>  			    struct codetag_module *cmod);
> -	bool (*module_unload)(struct codetag_type *cttype,
> +	void (*module_unload)(struct codetag_type *cttype,
>  			      struct codetag_module *cmod);
> +	void (*module_replaced)(struct module *mod, struct module *new_mod);
> +	bool (*needs_section_mem)(struct module *mod, unsigned long size);
> +	void *(*alloc_section_mem)(struct module *mod, unsigned long size,
> +				   unsigned int prepend, unsigned long align);
> +	void (*free_section_mem)(struct module *mod, bool unused);
>  };
>  
>  struct codetag_iterator {
> @@ -71,11 +76,31 @@ struct codetag_type *
>  codetag_register_type(const struct codetag_type_desc *desc);
>  
>  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
> +
> +bool codetag_needs_module_section(struct module *mod, const char *name,
> +				  unsigned long size);
> +void *codetag_alloc_module_section(struct module *mod, const char *name,
> +				   unsigned long size, unsigned int prepend,
> +				   unsigned long align);
> +void codetag_free_module_sections(struct module *mod);
> +void codetag_module_replaced(struct module *mod, struct module *new_mod);
>  void codetag_load_module(struct module *mod);
> -bool codetag_unload_module(struct module *mod);
> -#else
> +void codetag_unload_module(struct module *mod);
> +
> +#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> +
> +static inline bool
> +codetag_needs_module_section(struct module *mod, const char *name,
> +			     unsigned long size) { return false; }
> +static inline void *
> +codetag_alloc_module_section(struct module *mod, const char *name,
> +			     unsigned long size, unsigned int prepend,
> +			     unsigned long align) { return NULL; }
> +static inline void codetag_free_module_sections(struct module *mod) {}
> +static inline void codetag_module_replaced(struct module *mod, struct module *new_mod) {}
>  static inline void codetag_load_module(struct module *mod) {}
> -static inline bool codetag_unload_module(struct module *mod) { return true; }
> -#endif
> +static inline void codetag_unload_module(struct module *mod) {}
> +
> +#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */

Maybe I'm missing something, but can't alloc_tag::module_unload() just copy
the tags that cannot be freed somewhere outside of module sections and then
free the module?

The heavy lifting would be localized to alloc_tags rather than spread all
over.

-- 
Sincerely yours,
Mike.

