Return-Path: <linux-arch+bounces-6368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9768E958571
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 13:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB11F21D73
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13ED18DF84;
	Tue, 20 Aug 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NP8bQsKX"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1218DF80
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152223; cv=none; b=KzeinPK0yd5fi0Jlyr9TPsGCVJPwhrBb2jk7n7NoNZD2nyLYYLEYH3/9cOhgEPALWbZtrHci+K9tBKahOUwlMzUTtFjAoiGZMK9kVlEI6tUSmdmrIcQlTtO2bPVsG5PftPzgm9oVi6S96HcM83pddqrfjm3QuowuxdQXIApYhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152223; c=relaxed/simple;
	bh=P+vTiQNfxpFCjYYg0es8JH75oId7BoY89LGYmb3nA18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYzpr09PqtvSvb72FDsdBcWZQogFmfv4IH35ej/yu/G5JL6AhTTbT6IFMZcwF72ZpWrtzbi2gGeIw9qBmj4Qj5+2F1RKU1kH8Y3dK2V+gkhcNxQBtuQMdcKpmarfLv3VL2Sz3T4c7n7ONl1EBNjD6dB7TI40yiBoOtGVwaJY2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NP8bQsKX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 07:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724152217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrvRMz+I1gRJfeA35OXeWpHMimIWlbjsoNl2/JOsDPI=;
	b=NP8bQsKXUU0lsovxuRtz0Ny98VqZ6sb3M0pF7We+DamT+Nkxzg+jEfcz/+so+XoYucaCwl
	HyHe1BH61bKKin9KYl5it34q73DaQAIAISB/XzkwT6U1NBU4njeT6fpwDxpd4AvPofWpZ/
	OMZcGIne2AwXUUICsUeUxK7QRHF+ObM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/5] alloc_tag: load module tags into separate continuous
 memory
Message-ID: <sf7siu4vxwnz2lrcspxetmzabajfvebb47htjsrh7mmdoed73i@wivswoh55dfv>
References: <20240819151512.2363698-1-surenb@google.com>
 <20240819151512.2363698-2-surenb@google.com>
 <ZsRCAy5cCp0Ig3I/@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsRCAy5cCp0Ig3I/@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 20, 2024 at 10:13:07AM GMT, Mike Rapoport wrote:
> On Mon, Aug 19, 2024 at 08:15:07AM -0700, Suren Baghdasaryan wrote:
> > When a module gets unloaded there is a possibility that some of the
> > allocations it made are still used and therefore the allocation tags
> > corresponding to these allocations are still referenced. As such, the
> > memory for these tags can't be freed. This is currently handled as an
> > abnormal situation and module's data section is not being unloaded.
> > To handle this situation without keeping module's data in memory,
> > allow codetags with longer lifespan than the module to be loaded into
> > their own separate memory. The in-use memory areas and gaps after
> > module unloading in this separate memory are tracked using maple trees.
> > Allocation tags arrange their separate memory so that it is virtually
> > contiguous and that will allow simple allocation tag indexing later on
> > in this patchset. The size of this virtually contiguous memory is set
> > to store up to 100000 allocation tags and max_module_alloc_tags kernel
> > parameter is introduced to change this size.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   4 +
> >  include/asm-generic/codetag.lds.h             |  19 ++
> >  include/linux/alloc_tag.h                     |  13 +-
> >  include/linux/codetag.h                       |  35 ++-
> >  kernel/module/main.c                          |  67 +++--
> >  lib/alloc_tag.c                               | 245 ++++++++++++++++--
> >  lib/codetag.c                                 | 101 +++++++-
> >  scripts/module.lds.S                          |   5 +-
> >  8 files changed, 429 insertions(+), 60 deletions(-)
>  
> ...
> 
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index c2a579ccd455..c4a3dd60205e 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -35,8 +35,13 @@ struct codetag_type_desc {
> >  	size_t tag_size;
> >  	void (*module_load)(struct codetag_type *cttype,
> >  			    struct codetag_module *cmod);
> > -	bool (*module_unload)(struct codetag_type *cttype,
> > +	void (*module_unload)(struct codetag_type *cttype,
> >  			      struct codetag_module *cmod);
> > +	void (*module_replaced)(struct module *mod, struct module *new_mod);
> > +	bool (*needs_section_mem)(struct module *mod, unsigned long size);
> > +	void *(*alloc_section_mem)(struct module *mod, unsigned long size,
> > +				   unsigned int prepend, unsigned long align);
> > +	void (*free_section_mem)(struct module *mod, bool unused);
> >  };
> >  
> >  struct codetag_iterator {
> > @@ -71,11 +76,31 @@ struct codetag_type *
> >  codetag_register_type(const struct codetag_type_desc *desc);
> >  
> >  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
> > +
> > +bool codetag_needs_module_section(struct module *mod, const char *name,
> > +				  unsigned long size);
> > +void *codetag_alloc_module_section(struct module *mod, const char *name,
> > +				   unsigned long size, unsigned int prepend,
> > +				   unsigned long align);
> > +void codetag_free_module_sections(struct module *mod);
> > +void codetag_module_replaced(struct module *mod, struct module *new_mod);
> >  void codetag_load_module(struct module *mod);
> > -bool codetag_unload_module(struct module *mod);
> > -#else
> > +void codetag_unload_module(struct module *mod);
> > +
> > +#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> > +
> > +static inline bool
> > +codetag_needs_module_section(struct module *mod, const char *name,
> > +			     unsigned long size) { return false; }
> > +static inline void *
> > +codetag_alloc_module_section(struct module *mod, const char *name,
> > +			     unsigned long size, unsigned int prepend,
> > +			     unsigned long align) { return NULL; }
> > +static inline void codetag_free_module_sections(struct module *mod) {}
> > +static inline void codetag_module_replaced(struct module *mod, struct module *new_mod) {}
> >  static inline void codetag_load_module(struct module *mod) {}
> > -static inline bool codetag_unload_module(struct module *mod) { return true; }
> > -#endif
> > +static inline void codetag_unload_module(struct module *mod) {}
> > +
> > +#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> 
> Maybe I'm missing something, but can't alloc_tag::module_unload() just copy
> the tags that cannot be freed somewhere outside of module sections and then
> free the module?
> 
> The heavy lifting would be localized to alloc_tags rather than spread all
> over.

The reason they can't be freed is because they're referenced by
slab/page allocatons - can't move them either.

