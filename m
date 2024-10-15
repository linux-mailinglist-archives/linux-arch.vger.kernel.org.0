Return-Path: <linux-arch+bounces-8148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F5399DBCA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF101C237B9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2108136E3F;
	Tue, 15 Oct 2024 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SeEYUOzS"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB390231C83;
	Tue, 15 Oct 2024 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956446; cv=none; b=a7KP1Ptt9PeFh7kTVcuCNq0X2SD2kegc+nMJ8QshiwCS/ebUi1x7c8hg7Osqhkh02KBHX6uA0LIl7kam4UqxGbMviyfa2koplQ6f6Av0U51Ty2FOdbJ+Vxj0hJlLhv5MDcNQ71bKs6vNHSHlNi0L657SVmoazuw78TLFsNgD7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956446; c=relaxed/simple;
	bh=5Y6P3r7lGQ0FUFEUbLl6wZzzcLKJ72EWtvdXrw4jLNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyPAMi7ifI1Im2yQ2seRKMIS2InmALuxBnuLmP8t8+d4aBuFBm+5UvkmgSE1CWnQfyDf/DOiNm3E6Z4cWWj2mP42lY3Jn8iyNxhh4nP7sSv3+Wal0re9GcQFC2f/2Lee10QgFuQpEAxbpk9qkZpnZDCa3YUzooiQIO7kYLU47RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SeEYUOzS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gL9eg7AaSPXqzlXNIhBfZZxk+kS0I3YiOjFS+/uT7A8=; b=SeEYUOzSZyOqn7LIjB4X9+wHY5
	YIzZrSCOQkjE+WyPlKKBnGsEZvyVSoAkqYO6CHYoJp6rJI7ild63hVYGcQjvH2EeUEckgfuKHj6bQ
	EA8LnAU1v6aT56qTf+iIJhuVEve5OodtWcYWMrvSRRh38aJH811muk7lakYjsir1UjQJayTVmFE0f
	8ja8caoySLSqXyGTK2uoW5LwwIyM8PaJubNm3SE4NQH2gLYIpbDP+PJbedEZMQbCdssa7OF95EpBw
	NEcRO7I1CijWlAzjBzQVqXMHYw8VbE1KH5bpXaOWMtP2/ZLBDckOgKxFA9yBRLAw5/D3b3iJ7um06
	rdWHUA0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0WXn-00000003Oqq-1E82;
	Tue, 15 Oct 2024 01:40:15 +0000
Date: Tue, 15 Oct 2024 02:40:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <Zw3H_7mlrqxRwz_H@casper.infradead.org>
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
 <ba888da6-cd45-41b6-9d97-8292474d3ce6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba888da6-cd45-41b6-9d97-8292474d3ce6@nvidia.com>

On Mon, Oct 14, 2024 at 05:03:32PM -0700, John Hubbard wrote:
> > > Or better yet, *always* fall back to page_ext, thus leaving the
> > > scarce and valuable page flags available for other features?
> > > 
> > > Sorry Suren, to keep coming back to this suggestion, I know
> > > I'm driving you crazy here! But I just keep thinking it through
> > > and failing to see why this feature deserves to consume so
> > > many page flags.
> > 
> > I think we already always use page_ext today. My understanding is that
> > the purpose of this series is to give the option to avoid using
> > page_ext if there are enough unused page flags anyway, which reduces
> > memory waste and improves performance.
> > 
> > My question is just why not have that be the default behavior with a
> > config option, use page flags if there are enough unused bits,
> > otherwise use page_ext.
> 
> I agree that if you're going to implement this feature at all, then
> keying off of CONFIG_MEM_ALLOC_PROFILING seems sufficient, and no
> need to add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS on top of that.

Maybe the right idea is to use all the bits which are unused in this
configuration for the first N callsites, then use page_ext for all the
ones larger than N.  It doesn't save any memory, but it does have the
performance improvement.

