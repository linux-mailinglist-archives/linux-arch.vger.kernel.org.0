Return-Path: <linux-arch+bounces-3455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F398489916E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 00:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6BA1F26A18
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 22:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625E70CDE;
	Thu,  4 Apr 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAUxTGyw"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECD6F505;
	Thu,  4 Apr 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270329; cv=none; b=ptCzTbSzd9VOSAWmpVIpmY0Ybr2AoGm3MjbDO0PKTIcUEtRDwoNvqjWJNIkSkamvLPg3h/8VRGbaoxGywmzgqsjQ+DhhKshgdHBeSfhypA+DkCmwvZR/EOXPo1LVK3zxI1e5+/f4gIuMDwa/52kuxwwxf2oxhGpcQeOsj1MFKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270329; c=relaxed/simple;
	bh=5V6KdJOeWNM6RltGMxp3KI42sNBK0iidSHrpwfSYyXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeW7IEm2NG+8jjz6ju24hrs5h+72zQnFPlDwSgQ1uTmxYR+Dwg6V9WK9OZvMEhcxC97WaWFUiC/fygzGrw4SkWtp3VFpMuyyq6JyU/IIZ2Pi8jKIFCwORuf5G1lCwsoSwCEO1y08jjW8s62N7LFwmY5f99H1A6fL4T6hmPiGIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAUxTGyw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 18:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712270325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqILBVwfm/nA4Dp8fGsnDYqiRoHSDvITblhlFgVtQ+U=;
	b=SAUxTGywnGO9lMg36Yb2FwCo9q4MLPvWVKliB8A6cH5w/sjrb/WdTd6Umo4zcLkMSBRK1Q
	BE0UEDKEnFkNBgE9qd83+0tLNc30wXqJ2yWdjs62ognxJed0Ch4bu2Pl0Pyyj1mKJMqNpR
	JfY1MW4y033OYjfXMya1y+rxPLYogzs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	joro@8bytes.org, will@kernel.org, trond.myklebust@hammerspace.com, 
	anna@kernel.org, arnd@arndb.de, herbert@gondor.apana.org.au, davem@davemloft.net, 
	jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg8qstJNfK07siNn@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > Ironically, checkpatch generates warnings for these type casts:
> > 
> > WARNING: unnecessary cast may hide bugs, see
> > http://c-faq.com/malloc/mallocnocast.html
> > #425: FILE: include/linux/dma-fence-chain.h:90:
> > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> > GFP_KERNEL))
> > 
> > I guess I can safely ignore them in this case (since we cast to the
> > expected type)?
> 
> I find ignoring checkpatch to be a solid move 99% of the time.
> 
> I really don't like the codetags.  This is so much churn, and it could
> all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
> whether we wanted to profile this function or its caller.  vmalloc
> has done it this way since 2008 (OK, using __builtin_return_address())
> and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.

Except you can't. We've been over this; using that approach for tracing
is one thing, using it for actual accounting isn't workable.

