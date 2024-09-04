Return-Path: <linux-arch+bounces-6996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841496AE80
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 04:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024E71F259A2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 02:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA8BE49;
	Wed,  4 Sep 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azOYGspa"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C493399B;
	Wed,  4 Sep 2024 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416361; cv=none; b=kk9oJxsSipha/U8Zl+pu82aectja2796SBg7u3zyWeMQOVr6UZOhS+hwcDLwHGcblVHaEbbjT2ktoyOxMqj5Z8ajExEtV50A/c21e8M9PkYbcLd7FgvMlE2yRUZhlgYc6fwKCBAiwryBocsIbmnPkxEc3L07pKeCV7YWBkdXHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416361; c=relaxed/simple;
	bh=gSabBWi1vveFNzLNFJpyBoEyNNb2x9QETHl00kGLtts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfwgQidQ9xwCbmbTMhJkjyWoPpUAgc1iwCJoDto6/in+h3rd+ImlKimW7YsQTqLu/8xYGAcG5RbtvoKTAVfcUqSTqXMflqncW6e6vF3yX+hXH/jGzCCfKuKfjxADojpsmraRHJEjpHUJe+eYoNCKWJJisurPa/2fU1kpWIk8lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azOYGspa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hudg4wTn3S6fTCVxJXSsiGgJOJdnBhq2fGUxC3Vgq+E=; b=azOYGspawLQvfV4H2cGn1/y3TB
	OBC/1ZgUpyR2OhYvBSQoX8xZegVkVaMVleDX12C7ZIAB7nOCGhVpgjsVvPL9301w8odnj2OjT28yo
	vLbynUWcur7KVvVnpeSTHcc+TcgBEfZKIAxXyR+YvoSQWArda/ZUVXhvX+cZVUoFyy5d4qoyTTSrA
	TiUoedQoOwaGZ5z0tbiiFF1M02hYCZpSn0bz0oxHKjQz7muNf9tVTtDD9lrzlLgsCojBsqS/69QpP
	v733XjZo+P6fAWnAAKsCrAL09mgJmCr6PXP2gaP0NI0Ttr8FBbzpc5IWVXKwy2e0GGLG19GxXPCl1
	R2gtkGyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1slfbc-00000000D4M-2NwD;
	Wed, 04 Sep 2024 02:18:48 +0000
Date: Wed, 4 Sep 2024 03:18:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, dave@stgolabs.net,
	liam.howlett@oracle.com, pasha.tatashin@soleen.com,
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com,
	kaleshsingh@google.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>

On Tue, Sep 03, 2024 at 06:25:52PM -0700, John Hubbard wrote:
> The more I read this story, the clearer it becomes that this should be
> entirely done by the build system: set it, or don't set it, automatically.
> 
> And if you can make it not even a kconfig item at all, that's probably even
> better.
> 
> And if there is no way to set it automatically, then that probably means
> that the feature is still too raw to unleash upon the world.

I'd suggest that this implementation is just too whack.

What if you use a maple tree for this?  For each allocation range, you
can store a pointer to a tag instead of storing an index in each folio.

