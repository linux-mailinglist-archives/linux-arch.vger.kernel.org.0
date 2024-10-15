Return-Path: <linux-arch+bounces-8157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF799DEB1
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043321C212FB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41F189BBF;
	Tue, 15 Oct 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTgoD2+B"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192E18A6A7;
	Tue, 15 Oct 2024 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974885; cv=none; b=Rx/8g6btT5cQJhRCQm+csf4YpagaQIF2FhjSPeP9HDy3zItisx64U13nsYZfPJ4T+BBhfo4oL7DSItcf2hct7DHbACKFbJSef91cIc3kWtShC/TejzyZzog02rx9mjFV/uJ+78V/NH6dbWjc/0cB8azXe6ZEneKzZ7XeEHNvAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974885; c=relaxed/simple;
	bh=R2XrxWe0JJv1rXeC6I10w0t3ORDb8GK4Aggx0/lsneI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJFog+CmCefFj8LAZd5rbkEVhVl385BPXXdbPQyEHngjX3U5fnA66KX8ZgH2Bs9kpm3jP9AsIKe94CDJvy7BxOLL46Wg6kF2GZV7bZXg2OLdFkW9+65ZsmlT4sACg9wFa4cpw8HqsWXHZcYtke+TjplWIqxx5EZCuX1FyZl69Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTgoD2+B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7iiE9GUgfXuXfxtqPW3tB//wah5VwkH8yVqAr4/1y8U=; b=aTgoD2+Bb+m04v8zcoDMfddmz1
	fFfhrKRsAXJQ/xGwQXmyIhe3IAozPFI1gUz4KTtCnFRKTM40NeBuHyAajek2QjisTcDPrKTfr2KrW
	RA18VZnyuKSdxpRME+B2o1aJc67S1B0AqISP66F5eBrLXaF/l859SSPRGqz+GQ8RhKC25/kswHkY6
	nPvUa1g7/Qaq3DTNW6jbjWGbaUQG0vFsTiY7HG1/IMQgS02FSHlyAlf4JIAswJKG+gecu4V0cQjAn
	d+KK8H5lTtf7sUGAX8F/CdBXOGxVG4wAF1gLw0n7xvpxg4ewXALZL5UjgjO+vtUZRKE2IkuSIeFGX
	+QwZfsaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0bLa-00000007FyT-26lU;
	Tue, 15 Oct 2024 06:47:58 +0000
Date: Mon, 14 Oct 2024 23:47:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [RFC PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Message-ID: <Zw4QHoPArxEQan0G@infradead.org>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Lorenzo,

sorry for only replying to this so late.

On Fri, Sep 27, 2024 at 01:51:11PM +0100, Lorenzo Stoakes wrote:
> The existing generic pagewalk logic permits the walking of page tables,
> invoking callbacks at individual page table levels via user-provided
> mm_walk_ops callbacks.
> 
> This is useful for traversing existing page table entries, but precludes
> the ability to establish new ones.
> 
> Existing mechanism for performing a walk which also installs page table
> entries if necessary are heavily duplicated throughout the kernel, each
> with semantic differences from one another and largely unavailable for use
> elsewhere.

I do like the idea of having common code for installing page tables!

Minor nits below:

> +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private)

It would be good to have a minimum level of documentation for this
function, including how it differs from walk_page_range and why
it should remain internal.

> +	/* For internal use only. */
> +	if (ops->install_pte)
> +		return -EINVAL;

And this should probably be expanded a bit, including that no exported
symbol should allow inserting arbitrary PTEs.  Maybe best done with
a helper to share that comment with the other places that have this
check.


