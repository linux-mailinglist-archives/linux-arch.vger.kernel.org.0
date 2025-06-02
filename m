Return-Path: <linux-arch+bounces-12183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED2ACBAB0
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486BC1894772
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27122A1D4;
	Mon,  2 Jun 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fx2S/uS+"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3628226883;
	Mon,  2 Jun 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887329; cv=none; b=I4pInAnRnwtAZ6j0XBx4SGjxyYebCksD4XhTnGy9CYsHnyaCK1/AgOel+Du7HfB3DyQ05Nx5L0INR63F1EBA8wvnXdd17lq+HfDAbHVql6u/w6qQC4WYgiaQ65JkR0j6n0Zv2WEG22pf2xTj1zxh/qgJpH6DQYlJptMtqRNuRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887329; c=relaxed/simple;
	bh=pOc3AcH/2AmOYYaA/MuepE9mCfFaDPRN6va86H/6318=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdUpaX+Usk6jjpd1v49xMj6LOsOAQ3enWolgQ0ltXHO7bcYiX3YLrtnsJ3elh2JD42Is+XF92a/PRGTZl6rES0Qw/WmRg2wbeZKx0rZxMrrQCJOaaAE5C+6Hv8/HSKz1SbdVGJ3yS6lASX4Tt3p7xsjR2IZ97UNbkxuS5e8024E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fx2S/uS+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wNLQufEp1rJXsH/GI5NA0ro279s3D/mfj5DLODR5rBg=; b=fx2S/uS+FrK8cpSVxGwbBq0XeR
	6QGGYf/wYPYmAT6H9FqucyWErsUWDjNoaJYY0TmVMu1wN5uOALwGSRHjeQcxjFbOVlBRhQxHrSPZn
	iXKD52YYUfKrIpOP63a06xbO3BjEn2VM8KJWUMeNWEArkC4Z30HNcmZWRymX+s/rPUcR/K6S2qMPt
	GGn7/NirTXLYAfJq3VYXkfTayEnYr/BYgPXGPeb15qrihHEUZoMlHCvhYVd3LdPPxk0MGja3jS/i8
	NU2iz6hnAnBwYkd4XAGRjDhppFLeT2AOVgKsm/NuD4wdRC4Kpz49p6ePiVaJumtrxjIp8LinLuYms
	dhWV0ZTw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM9Tw-00000001C7d-2dSv;
	Mon, 02 Jun 2025 18:01:56 +0000
Date: Mon, 2 Jun 2025 19:01:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <aD3nFMS9kWHp7a4F@casper.infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529211423.GA1271329@cmpxchg.org>

On Thu, May 29, 2025 at 05:14:23PM -0400, Johannes Weiner wrote:
> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > Barry's problem is that we're all nervous about possibly regressing
> > performance on some unknown workloads.  Just try Barry's proposal, see
> > if anyone actually compains or if we're just afraid of our own shadows.
> 
> I actually explained why I think this is a terrible idea. But okay, I
> tried the patch anyway.

Sorry, I must've missed that one ;-(

> This is 'git log' on a hot kernel repo after a large IO stream:
> 
>                                      VANILLA                      BARRY
> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> 
> Clearly we can't generally ignore page cache hits just because the
> mmaps() are intermittent.
> 
> The whole point is to cache across processes and their various
> apertures into a common, long-lived filesystem space.
> 
> Barry knows something about the relationship between certain processes
> and certain files that he could exploit with MADV_COLD-on-exit
> semantics. But that's not something the kernel can safely assume. Not
> without defeating the page cache for an entire class of file accesses.

So what about distinguishing between exited-normally processes (ie git
log) vs killed-by-oom processes (ie Barry's usecase)?  Update the
referenced bit in the first case and not the second?

