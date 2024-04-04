Return-Path: <linux-arch+bounces-3454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8581A89915C
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 00:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F9C1C22297
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D856F06B;
	Thu,  4 Apr 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Te+feZmU"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EE286A6;
	Thu,  4 Apr 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270021; cv=none; b=h7W6eM99xtrLLTEpNVKaYbmB7AOOftNStPdl94cGBofa4R29drDFTJqTdbImjnb6aFxSA8wpucP1kVuDwQRDLmapxcdv4eO2JqLei83gEcqVZzHnPlA50ou99ZDWiMfEKYerZUGUVaSle0W0PTPFcCtgsAc7iIccmrCas8RKnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270021; c=relaxed/simple;
	bh=32pXzlKjGDShLM9eqF5c6ZAKQrHUUZ/CsdUkSBn4u7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlhU497iuICZW26p38Wfh3PwjF9fLFdM9jBMDkrJ9vIFpaWPShAZqQ48ArSa1R9z+rr0hEIbIavFfsDtOyZ2v+n1AKPjmjeIM8Uxr/pOLNUVFsoKOesEWV8ZvjDawwYc2MkZJZ04AqGIkm7CreduXAUVu0GAHg0AEbeg6aej50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Te+feZmU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=75VsQ8F7/H5KCW5vqBNrslkQ11lt96phTDSmVee/O9I=; b=Te+feZmUkMzP94t2sItXjVWR5n
	UxqmPQpg1gH24py6VHZcp2Yzrj1xtO40Oy9nQUk/SjHo1dw0m+owjkqZGpr4mxYxKmnwmdMjKSARP
	PbPDBDjLGS/fO1KlJ/O15LF6KM0e1lNhDFdxUyeNlYmLmMRyZYt3Sb8nM6EsEN6Jb1ESmpoOUy/w7
	zYZHPZ18PCnhDFfTlWkNlW8ibXtgOZvrCOq9ZiP8ZQw4feDaJphjSp942UnkuWrE0lUuvtUoTrRXN
	0PeZviuO5MSV5ayE1r4TbxsnAojnzcKvwsJPAUPxosKblk92mi9rZW5UXmhFVDP1h8SdLCPdpocoQ
	pKS100xA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsVe6-000000092fK-1nQF;
	Thu, 04 Apr 2024 22:33:22 +0000
Date: Thu, 4 Apr 2024 23:33:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, joro@8bytes.org, will@kernel.org,
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de,
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org,
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
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <Zg8qstJNfK07siNn@casper.infradead.org>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>

On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> Ironically, checkpatch generates warnings for these type casts:
> 
> WARNING: unnecessary cast may hide bugs, see
> http://c-faq.com/malloc/mallocnocast.html
> #425: FILE: include/linux/dma-fence-chain.h:90:
> + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> GFP_KERNEL))
> 
> I guess I can safely ignore them in this case (since we cast to the
> expected type)?

I find ignoring checkpatch to be a solid move 99% of the time.

I really don't like the codetags.  This is so much churn, and it could
all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
whether we wanted to profile this function or its caller.  vmalloc
has done it this way since 2008 (OK, using __builtin_return_address())
and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.

