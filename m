Return-Path: <linux-arch+bounces-3462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B226A899D52
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A430B2374D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE616C879;
	Fri,  5 Apr 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5ed4rhu"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A216C86E;
	Fri,  5 Apr 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321074; cv=none; b=JL6CT3KnKeEHQEfUDLZpGx4hrZTfnu9yatKQJdugl4O9oXRaON1vNF059dJPZYPpv/YIZN+M7QZHFJXHwQMSORLbolxKO4/DVUsYGXROFRSpLj7rWXSt9qgjhc7ujyNQCMsnoD5zHdR7mtVMZFkR4hAUuRnHkTbVxjjR/9L39GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321074; c=relaxed/simple;
	bh=hmp72QspsqQzNfL1h/lUM6waz79GdMoYXwuNVIfb0JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+/SOHK1mX6+y2umx4fy3toiLkcR++8j+vPQejn8S78/hrqGZ1L5wqrbTKXfwMwmUboGz2Q58qXASnl6jSwA/c8173nv9BJeFTDOThPQMvvyQ34LgwWG7FosT75riNskYp3XtF27MUievFsJkkXhtVszwfk9W/6b4Aa/7gyk32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u5ed4rhu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eeNIVwqmbnOxALTxtADLGm9TG4sDVgGYt1HYshiYKqc=; b=u5ed4rhuZriAmkiqPN+PL+siyW
	LqRb4vlEwDanh3tAUYLOdMIV7AkIlisbY/us6TAVJuto+5fuwLvpi9TPIrnjWbaPPJNccNZW+iz9n
	CE7C1RkLY5MAKN+mK5a2RxNIgLnodNe3aX7iDp0V7aCmr5P/N6ISdHIVtmL/cESx2/auaAWvOPmPb
	KuyRV5Y+LQqQCk5pQAdOvh7O24Xw0aWYZroHPNWg+x3RZAuUdwa4MbZzNihetVBFDxn0z1t842ZIz
	FOV6F7MyMIx1gNWKJJYhVEkf93kF4Zc6qtlbIo+KLHjWxeAtAZV2JO/tPX3rOWtiHHQwKzPY7f2Nl
	e0gCTrgg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsivU-0000000AUMn-1hDK;
	Fri, 05 Apr 2024 12:44:12 +0000
Date: Fri, 5 Apr 2024 13:44:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, joro@8bytes.org,
	will@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
	arnd@arndb.de, herbert@gondor.apana.org.au, davem@davemloft.net,
	jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu,
	jack@suse.com, dennis@kernel.org, tj@kernel.org, cl@linux.com,
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <Zg_yHGKpw4HJHdpb@casper.infradead.org>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org>
 <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
 <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>

On Thu, Apr 04, 2024 at 07:00:51PM -0400, Kent Overstreet wrote:
> On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> > On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > > > > Ironically, checkpatch generates warnings for these type casts:
> > > > > 
> > > > > WARNING: unnecessary cast may hide bugs, see
> > > > > http://c-faq.com/malloc/mallocnocast.html
> > > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> > > > > GFP_KERNEL))
> > > > > 
> > > > > I guess I can safely ignore them in this case (since we cast to the
> > > > > expected type)?
> > > > 
> > > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > > 
> > > > I really don't like the codetags.  This is so much churn, and it could
> > > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
> > > > whether we wanted to profile this function or its caller.  vmalloc
> > > > has done it this way since 2008 (OK, using __builtin_return_address())
> > > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > > 
> > > Except you can't. We've been over this; using that approach for tracing
> > > is one thing, using it for actual accounting isn't workable.
> > 
> > I missed that.  There have been many emails.  Please remind us of the
> > reasoning here.
> 
> I think it's on the other people claiming 'oh this would be so easy if
> you just do it this other way' to put up some code - or at least more
> than hot takes.

Well, /proc/vmallocinfo exists, and has existed since 2008, so this is
slightly more than a "hot take".

> But, since you asked - one of the main goals of this patchset was to be
> fast enough to run in production, and if you do it by return address
> then you've added at minimum a hash table lookup to every allocate and
> free; if you do that, running it in production is completely out of the
> question.

And yet vmalloc doesn't do that.

> Besides that - the issues with annotating and tracking the correct
> callsite really don't go away, they just shift around a bit. It's true
> that the return address approach would be easier initially, but that's
> not all we're concerned with; we're concerned with making sure
> allocations get accounted to the _correct_ callsite so that we're giving
> numbers that you can trust, and by making things less explicit you make
> that harder.

I'm not convinced that _THIS_IP_ is less precise than a codetag.  They
do essentially the same thing, except that codetags embed the source
location in the file while _THIS_IP_ requires a tool like faddr2line
to decode kernel_clone+0xc0/0x430 into a file + line number.

> This is all stuff that I've explained before; let's please dial back on
> the whining - or I'll just bookmark this for next time...

Please stop mischaracterising serious thoughtful criticism as whining.
I don't understand what value codetags bring over using _THIS_IP_ and
_RET_IP_ and you need to explain that.

