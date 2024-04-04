Return-Path: <linux-arch+bounces-3457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A56A8991BA
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F128580F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D0137C24;
	Thu,  4 Apr 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RjT1djYl"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC76F099
	for <linux-arch@vger.kernel.org>; Thu,  4 Apr 2024 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271663; cv=none; b=TGRvT+cI+G02Is9soo22HK+Km69iSHcAZ/4imvavjEipX4VKYoAvI9i5tUTVYgd1NOmoOrBZBt3FXJ8k9Kr1hBvaHZc8CBOLn2XBWCGNLqcOGYy6a+PngZDQWmj+Ar7jXkVntaNeYzkS5CqZ3/z8GpP5rtKmCMoxQUI1uG+waa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271663; c=relaxed/simple;
	bh=7HXE5M3oO4PodeStVnSZa8DXP/cTOPjYZEumGvFvNpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiNhUZCHB7mEe7PSVvkGgaUVJ5PVg/u75rOz6gag/kV6gyQ8T+0nrxg1/vy3e00d1W/OwFFMgX7tLzGu9Y16YvUNaymtuk10T9DcitCWf5j4hq++fGJQTIq4VogpVosNlLuaP4Ynhp9DczXDoMZfntK2alrHZTYLZco60Wbyoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RjT1djYl; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 19:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712271659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHLNB8rkpoKwDhM7NRf7iWUfLDgvBLjzklimu7mkdKs=;
	b=RjT1djYlTZqBwHogqp4zy40F3SqAdaK+3oWOfGDaM6L3NSOO4dCastLQfuNaOlT1Dgo7Wv
	i9k29lxad1FbeHT3aK6BLtfd8jnI/QWfQOgpcP7kCCmnpZ6YfJaUcPMAV7nzKK1Ptjb3Iu
	+YlbAoFGlEHtL49GVJGZLcl1jqHQD6A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, joro@8bytes.org, will@kernel.org, 
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de, herbert@gondor.apana.org.au, 
	davem@davemloft.net, jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu, 
	jack@suse.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, 
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org>
 <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > > > Ironically, checkpatch generates warnings for these type casts:
> > > > 
> > > > WARNING: unnecessary cast may hide bugs, see
> > > > http://c-faq.com/malloc/mallocnocast.html
> > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> > > > GFP_KERNEL))
> > > > 
> > > > I guess I can safely ignore them in this case (since we cast to the
> > > > expected type)?
> > > 
> > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > 
> > > I really don't like the codetags.  This is so much churn, and it could
> > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
> > > whether we wanted to profile this function or its caller.  vmalloc
> > > has done it this way since 2008 (OK, using __builtin_return_address())
> > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > 
> > Except you can't. We've been over this; using that approach for tracing
> > is one thing, using it for actual accounting isn't workable.
> 
> I missed that.  There have been many emails.  Please remind us of the
> reasoning here.

I think it's on the other people claiming 'oh this would be so easy if
you just do it this other way' to put up some code - or at least more
than hot takes.

But, since you asked - one of the main goals of this patchset was to be
fast enough to run in production, and if you do it by return address
then you've added at minimum a hash table lookup to every allocate and
free; if you do that, running it in production is completely out of the
question.

Besides that - the issues with annotating and tracking the correct
callsite really don't go away, they just shift around a bit. It's true
that the return address approach would be easier initially, but that's
not all we're concerned with; we're concerned with making sure
allocations get accounted to the _correct_ callsite so that we're giving
numbers that you can trust, and by making things less explicit you make
that harder.

Additionally: the alloc_hooks() macro is for more than this. It's also
for more usable fault injection - remember every thread we have where
people are begging for every allocation to be __GFP_NOFAIL - "oh, error
paths are hard to test, let's just get rid of them" - never mind that
actually do have to have error paths - but _per callsite_ selectable
fault injection will actually make it practical to test memory error
paths.

And Kees working on stuff that'll make use of the alloc_hooks() macro
for segregating kmem_caches.

This is all stuff that I've explained before; let's please dial back on
the whining - or I'll just bookmark this for next time...

