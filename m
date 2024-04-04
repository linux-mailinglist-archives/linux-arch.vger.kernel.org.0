Return-Path: <linux-arch+bounces-3456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3BC899182
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 00:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBED28651A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCBD6FE10;
	Thu,  4 Apr 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DJmiDZtT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257E286A6;
	Thu,  4 Apr 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270513; cv=none; b=s70UriHC+tGo7PIC586+kMUQL7x4AAv/HKT6zV28UxfLBTPC0d4/ltp6CxtB/DaHUfzv+QDJAcT+2P8wK2JCTBzmVU/rKAgAgm6zt1CJLY+3aUrd0bC6h0ve3TwALW1Silz/v4Gd66Gj5Tvk/QiGQ9G8r9AEryUmsE3x4x0k1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270513; c=relaxed/simple;
	bh=WxchYk7iOFEaVdROAH9qR3JO5cQ+eY2vs3aB2U8kcyA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JXs0qybqjq4/MGcoM3pGmsCT2/cN/2cuIv16ZVj+4uCTUQsZB/oeLfEl2bXoxyVTyARjG+6YbJLEK5bAvuGEndd9KiA+oy5Fb8aYhVrIwv+Z7lWEwI7LfTRALN2OSC4lDuUy3IF1anKsrT/mNAcr12eeoBY0O9B17gcv6WwQjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DJmiDZtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B4FC433C7;
	Thu,  4 Apr 2024 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712270512;
	bh=WxchYk7iOFEaVdROAH9qR3JO5cQ+eY2vs3aB2U8kcyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJmiDZtTAOAbNMoX64viWyqorfYleRZpTdeOScuJfhB7fHrUsgtkQLBS1Nt6GhjYB
	 YmI6GfafpeecNLQVDEJtxQkgxxNJ71KIxeMmVuDxohT+xw006Hk+bvFniIeaTQBWNQ
	 Y1qNJX1d42EjrfNnvlrxW0MEaQUlMewa8JJRd3dQ=
Date: Thu, 4 Apr 2024 15:41:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, joro@8bytes.org, will@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de,
 herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org,
 benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com,
 dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-Id: <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
In-Reply-To: <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
References: <20240404165404.3805498-1-surenb@google.com>
	<Zg7dmp5VJkm1nLRM@casper.infradead.org>
	<CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
	<CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
	<Zg8qstJNfK07siNn@casper.infradead.org>
	<jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > > Ironically, checkpatch generates warnings for these type casts:
> > > 
> > > WARNING: unnecessary cast may hide bugs, see
> > > http://c-faq.com/malloc/mallocnocast.html
> > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> > > GFP_KERNEL))
> > > 
> > > I guess I can safely ignore them in this case (since we cast to the
> > > expected type)?
> > 
> > I find ignoring checkpatch to be a solid move 99% of the time.
> > 
> > I really don't like the codetags.  This is so much churn, and it could
> > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
> > whether we wanted to profile this function or its caller.  vmalloc
> > has done it this way since 2008 (OK, using __builtin_return_address())
> > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> 
> Except you can't. We've been over this; using that approach for tracing
> is one thing, using it for actual accounting isn't workable.

I missed that.  There have been many emails.  Please remind us of the
reasoning here.


