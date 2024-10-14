Return-Path: <linux-arch+bounces-8124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65F99DA53
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B271E1C21224
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C9171E6E;
	Mon, 14 Oct 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y763ME0M"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F71E4A6;
	Mon, 14 Oct 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949911; cv=none; b=WmOBSkXefdENHRbcvRNSRBdlD3jx0NhNMR6gAdFKQJ+HbUMPllprkesKI86hMDNLeoL2CTEbI0SO9lhFqW6JHLE7/hqVV0grjngxqNLnl3WeicGpz7LYfYU2kQE/apZ1xg27z2799Wl9nnM60Y7Gks/22i53dPjVAQ/Z/5zaYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949911; c=relaxed/simple;
	bh=KgzcYqc6OO3pPM2hE/qABbrdsOC02YOymz+D9PyZLYU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t47i4rgbTRUC6F6G4JDzLNVMKvjzKI9e8zrmYabUHtgPKLA9NqOs9mUATiuvsl7lN7sE8UIvQqhpEPlurkPznUJ7nY37R74d+J8ryjLy+rdU7sfvSLcDhJALt2FddJiw8kKUmrrxlOySDSJmrxKCSNKLTYbut/I6mYQ3qe9Hyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y763ME0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F9BC4CEC3;
	Mon, 14 Oct 2024 23:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728949911;
	bh=KgzcYqc6OO3pPM2hE/qABbrdsOC02YOymz+D9PyZLYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y763ME0Mn/BHTBBvI/yRtJ0VvlbBiA8zFXkt99wodSbTyE0cwElsvzJV4z8mGRm1b
	 l4gQnpIK9Ujvb55nlE5zoNHwY/+AncYm50laP+SHzxuvUCYtniteKU42ECI5PBbHHh
	 tiZDckT6VbsK7j2bTcAAmwIz1+mcqm9EQ1TfDWkM=
Date: Mon, 14 Oct 2024 16:51:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
 mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com,
 tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com,
 ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
 jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
 rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/5] alloc_tag: load module tags into separate
 contiguous memory
Message-Id: <20241014165149.6adebbf38fdc0a1f79ded66b@linux-foundation.org>
In-Reply-To: <20241014203646.1952505-3-surenb@google.com>
References: <20241014203646.1952505-1-surenb@google.com>
	<20241014203646.1952505-3-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 13:36:43 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

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
> to store up to 100000 allocation tags.
> 
> ...
>
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1254,22 +1254,17 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	return 0;
>  }
>  
> -static void module_memory_free(struct module *mod, enum mod_mem_type type,
> -			       bool unload_codetags)
> +static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
>  	struct module_memory *mem = &mod->mem[type];
> -	void *ptr = mem->base;
>  
>  	if (mem->is_rox)
>  		vfree(mem->rw_copy);
>  
> -	if (!unload_codetags && mod_mem_type_is_core_data(type))
> -		return;
> -
> -	execmem_free(ptr);
> +	execmem_free(mem->base);
>  }

The changes around here are dependent upon Mike's "module: make
module_memory_{alloc,free} more self-contained", which is no longer in
mm-unstable.  I assume Mike is working on a v2 so I'll park this series
for now.

