Return-Path: <linux-arch+bounces-8189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955DF99F8BC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E2E2850C8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3F1FBF5C;
	Tue, 15 Oct 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZ2uVbbq"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629B1FBF47
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026536; cv=none; b=WW5TwVsmqaZ+n+438NPQNCT0pP2Ne+1LZunIsKPO/FfEy4VlXKTuTcfV0fJZC5DlNaFHGYgBbDyAjWKOnkXEel0nzN6ugZvv2YC3sOzqJ5Zz1SUbcsCe8bCDG4cTnVjzUAuf1mW41Yt+zZiirhxkUYTDhTbAZgxJ+7C/cIj3DnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026536; c=relaxed/simple;
	bh=kGiBdQ5J5H7gRrebhKiFtxxwc8DYEtmcnydecYzxn5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqAcgAcg02przzIEZWqZ6COhlIdlv/DD4GbJ6RzN1skINu6fXj0LTrPUip6RR6/Zo5Q3uTzEcTSnBxy50p24h0Ka/lZhHuuPFLudc+x/3FxdEWTdUT7cNYDYf9lBnLf9OjAvlVS+oi675/CYzxpORjaqH20A7YBDx+s1fH4cU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZ2uVbbq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 14:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729026530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSynVCGUx/bo0b2uALTE+vNPBiF1i+qQIdLst2WgqkE=;
	b=XZ2uVbbqJA7f6oIYdyRA5IQCTZBHNtxCKfVwUW+gGGJfh9UwP4wYoTAMO2wzcCxYKZ/UTZ
	TqXufj4xQgoGWWrVNAiLVaOi9ZUUGpGPRe360Wt+GJHPz9foOFziZzPW2LgDB1gmWtG1Wp
	OFWOS5TLcg1WIfDTJLPlkPjCZrOGd5Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kent.overstreet@linux.dev, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, vbabka@suse.cz, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/5] alloc_tag: load module tags into separate
 contiguous memory
Message-ID: <k4uejpziyyhcuozdpm6x6iy5zuugfhozilmgmjvo574yuq2oen@zvdoiqmk2mii>
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-3-surenb@google.com>
 <20241014165149.6adebbf38fdc0a1f79ded66b@linux-foundation.org>
 <CAJuCfpETusPzdjEg01zahF7NOStQJZmoM5Jabqd5tJpCCQrj2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpETusPzdjEg01zahF7NOStQJZmoM5Jabqd5tJpCCQrj2g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 07:10:56PM GMT, Suren Baghdasaryan wrote:
> On Mon, Oct 14, 2024 at 4:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 14 Oct 2024 13:36:43 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > When a module gets unloaded there is a possibility that some of the
> > > allocations it made are still used and therefore the allocation tags
> > > corresponding to these allocations are still referenced. As such, the
> > > memory for these tags can't be freed. This is currently handled as an
> > > abnormal situation and module's data section is not being unloaded.
> > > To handle this situation without keeping module's data in memory,
> > > allow codetags with longer lifespan than the module to be loaded into
> > > their own separate memory. The in-use memory areas and gaps after
> > > module unloading in this separate memory are tracked using maple trees.
> > > Allocation tags arrange their separate memory so that it is virtually
> > > contiguous and that will allow simple allocation tag indexing later on
> > > in this patchset. The size of this virtually contiguous memory is set
> > > to store up to 100000 allocation tags.
> > >
> > > ...
> > >
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -1254,22 +1254,17 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
> > >       return 0;
> > >  }
> > >
> > > -static void module_memory_free(struct module *mod, enum mod_mem_type type,
> > > -                            bool unload_codetags)
> > > +static void module_memory_free(struct module *mod, enum mod_mem_type type)
> > >  {
> > >       struct module_memory *mem = &mod->mem[type];
> > > -     void *ptr = mem->base;
> > >
> > >       if (mem->is_rox)
> > >               vfree(mem->rw_copy);
> > >
> > > -     if (!unload_codetags && mod_mem_type_is_core_data(type))
> > > -             return;
> > > -
> > > -     execmem_free(ptr);
> > > +     execmem_free(mem->base);
> > >  }
> >
> > The changes around here are dependent upon Mike's "module: make
> > module_memory_{alloc,free} more self-contained", which is no longer in
> > mm-unstable.  I assume Mike is working on a v2 so I'll park this series
> > for now.
> 
> Looks like the last update on Mike's patchset was back in May. Let me
> check with Mike if he is planning to get it out soon. I would like my
> patchset to get into 6.12 if possible.

6.12 or 6.13?

