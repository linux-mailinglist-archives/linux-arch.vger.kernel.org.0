Return-Path: <linux-arch+bounces-12132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D079AC804B
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DE8188D4EF
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53A22CBEE;
	Thu, 29 May 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/Ewa8cH"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18262222CB;
	Thu, 29 May 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532548; cv=none; b=XQtg0tc/4sl8fHmiVppxVmGFpivj5FdKE062EWUDZejJMe3M6J8ZQQkQ4mF23E5uJnBEsv8WXD0Zkf6yDDCw4egRHyfq8wp+vDM31PrQwZyRBC2JFkfiJo27TghOmzotZ/lBxeqB82MjTifg+wdbydP+3hSAayTi4iMw2NXAef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532548; c=relaxed/simple;
	bh=T3kf1bylpivmvvNZAoeowa/ONY5r0UXNar+dX11WCQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrMHjF/PIV/dbP7G/8fXhFCGOxq9VJzrx0XpfBQh+j3jX6XwlurcPXnt0bunzpyHb08C4gSc7Q2XI32ifdJTmcC2ZCduJ3LVFSXf2OYSvIIs/QmdZQhODl96jr9ukN8ZAdVCyWJVQ8KeUxq0kfJznKEgQJ5tgU8RU0oJDP4GzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J/Ewa8cH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJZLfn4ZaURESqFeVB+O8o84gVldERzJFI4UXR2X8FE=; b=J/Ewa8cHz3ojyuCXZY3B0cH6k6
	OQytojKqmoTlAVSIwnRF5HkInw/RCdeII+NcbMEIpG9al1SfaLTVy24914xVsA2NZGhu9QdhrirfB
	GKc/o5bqQRxYrsJ27ed+JgDab6jbhzjmKUJMoko/EuYgVYql+0YAYoHAoR9BFfnInFhK/HUJ9QGEl
	0uSfzFmehqagP3urQKcSLIoKLcmDaMEW8Mzui+I5IfonjHsVi6J6JD1+vnqRcw8wZicD54FcurzVx
	67ErSZTY9xOMM1GxUJWLVVMxJYf4+CijjF7gZPJfFgJBskMX/F+gZgAz3O3V1cl4AcKPFUuLV2kQz
	dZWZT7gw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKfBW-0000000EsXB-3Mi0;
	Thu, 29 May 2025 15:28:46 +0000
Date: Thu, 29 May 2025 16:28:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
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
Message-ID: <aDh9LtSLCiTLjg2X@casper.infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>

On Thu, May 29, 2025 at 03:43:26PM +0100, Lorenzo Stoakes wrote:
> After discussions in various threads (Usama's series adding a new prctl()
> in [0], and a proposal to adapt process_madvise() to do the same -
> conception in [1] and RFC in [2]), it seems fairly clear that it would make
> sense to explore a dedicated API to explicitly allow for actions which
> affect the virtual address space as a whole.
> 
> Also, Barry is implementing a feature (currently under RFC) which could
> additionally make use of this API (see [3]).

I think the reason that you're having trouble coming up with a good
place to put these ideas is because they are all bad ideas.  Do none of
them.  Problem solved.

People should put more effort into allocating THPs automatically and
monitoring where they're helping performance and where they're hurting
performance, instead of coming up with these baroque reasons to blame
the sysadmin for not having tweaked some magic knob.

Barry's problem is that we're all nervous about possibly regressing
performance on some unknown workloads.  Just try Barry's proposal, see
if anyone actually compains or if we're just afraid of our own shadows.


