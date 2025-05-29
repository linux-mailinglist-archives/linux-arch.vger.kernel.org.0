Return-Path: <linux-arch+bounces-12137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF55AC8201
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 20:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C371A1C03BC3
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DE22FE0D;
	Thu, 29 May 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4O80ONX"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7E13AC1;
	Thu, 29 May 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542448; cv=none; b=N111FsRrPrmIFM6ln+Pw6fhvgdlWVNHz3p0uzEm06WIRgCLqYv/MnNY+J0Ui6HX0+g/6AV78t6mpMoRS3bZHgj9B8K48L7RqgAW3Nan0ZK9uoxxRxg02AjYpobPsu3WqTTpNffP/fPRNloUdAs5/eVrdHsT5N+lduPaWp0eo+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542448; c=relaxed/simple;
	bh=6O2VD6LXcRM/QwPKUe63xCyjwAs/FrdfI3pExnZTb14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO4CWQVdbTq+i0+bzoxiNGqvsBCDNfcQkDnbnbfOw9osUhlXQ778UWhivmz6bPVY3Op1kHJhIAk858HADJEUGqXoLGZgh8I7ZkFSK51Lwt3kbpiLSwZ+1wAbN2+59go24bUt9BDTj622QWiOzIhuHfIb6LevsM8UWQlZDjuplv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A4O80ONX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JsHVVGE7ieSHfCbQBVFyFeTA0LwLqupquZVk14tO7oA=; b=A4O80ONX6IHwk3u4GHiU4vvuRp
	l74f6fcZygTPkGEitrjnrrS1bZlJ/L7suMys+yaEDzTZ9MHINyOmfMRGAMwXtlGzgECZMEUH+2rGd
	pz3o8QwO38kr5QQmKrD23Ec83ZQEBQ6DhD315iQZoLqAohU8XaL8ary0zSgeVs/txpFflKzWQsayL
	kQlnSWT99/SM8WoKyNmFQwn+TGivm6T8r1kWBj5tF78uGkmoltkyDYeFhqdC4LZ7Tq2FP+CP2tTn6
	16AHInBnbO6vT5bOJZoPChoZs0IMncGgoLdoJWQ8J6wM+EtoYULvfoxosK/vBxm9bD/zS4vixdBr7
	zTWX7t5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKhlO-0000000F03Z-04m6;
	Thu, 29 May 2025 18:13:58 +0000
Date: Thu, 29 May 2025 19:13:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <aDij5brAsGJVHCFK@casper.infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <c7fqqny5yv7smhxnxe5o4rc2wepmc6uei76teymfhxoana34nk@sfqnc2qclf23>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fqqny5yv7smhxnxe5o4rc2wepmc6uei76teymfhxoana34nk@sfqnc2qclf23>

On Thu, May 29, 2025 at 10:54:34AM -0700, Shakeel Butt wrote:
> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > People should put more effort into allocating THPs automatically and
> > monitoring where they're helping performance and where they're hurting
> > performance,
> 
> Can you please expand on people putting more effort? Is it about
> workloads or maybe malloc implementations (tcmalloc, jemalloc) being
> more intelligent in managing their allocations/frees to keep more used
> memory in hugepage aligned regions? And conveying to kernel which
> regions they prefer hugepage backed and which they do not? Or something
> else?

We need infrastructure inside the kernel to monitor whether a task is
making effective use of the THPs that it has, and if it's not then move
those THPs over to where they will be better used.

I don't necessarily object to userspace giving hints like "I think I'm
going to use all of this 20MB region quite heavily", but the kernel should
treat those hints with the appropriate skepticism, otherwise it's just
a turbo button that nobody would ever _not_ press.

> > instead of coming up with these baroque reasons to blame
> > the sysadmin for not having tweaked some magic knob.
> 
> To me this is not about blaming sysadmin but more about sysadmin wanting
> more fine grained control on THP allocation policies for different
> workloads running in a multi-tenant environment.

That's the same thing.  Linux should be auto-tuning, not relying on some
omniscient sysadmin to fix it up.

