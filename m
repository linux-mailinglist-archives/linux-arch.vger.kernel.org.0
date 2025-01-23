Return-Path: <linux-arch+bounces-9872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD65A1ABCF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 22:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E98188DDFF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86951BEF6F;
	Thu, 23 Jan 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kTmy5IUD"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B273DBB6
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667176; cv=none; b=oXOC6ZHzFJabvVVH8VYdGzd6W+N15o1QSj1x1NI+OnBR1yQerWOAhWCTXhFNyFTuvk9VkUIejV1/9RTZe3UcIiDMkFFJ6na9bGWKAIZPbGWMPASkhGqcS21uYrfjd49qhvV1mTLvHbR7TTyucdrJdE/Q3IYm3y0AUpSYXBoc/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667176; c=relaxed/simple;
	bh=4gqLO/KhcclRntG1aQsO9+6It59ZitRWBvujhur8+dE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUpweDpuPWWfpSBWgz9doDETlz0/386TgfK3vZIC0eKKwfMf7NzUOLxP1RHZTEXH3YLet7R8hvJqnnjfv0fWBEgSAcYVkjqJAYmhq01OadEH4EUGFoQkAyNAHl8B25HuVab9q/wtjJ0mlk74dJe700OUTBeRdnRsuT2F4wcutrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kTmy5IUD; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Jan 2025 21:19:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737667172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJFn4Dz4I4J//YPKVR1XgGUu4+tKSeCH0Rs85g4ayhM=;
	b=kTmy5IUD/twAkpjRZt4DcVZpZoeVa80RYz/k2/G/8NT33cYzTn1Xf5Bq5OX6bzNJLjwdaL
	NhE2lOafDS5TbPiYkFmVy8VCDbHf4SJcbaXNqvvmJfNQ1geCOmtMOML0a1CNIFFoX8Up9u
	56SzvtSTCiIVibvjQCxNcWlCuhQjfKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <Z5KyXrW1IXbWuvo-@google.com>
References: <20250123164358.2384447-1-roman.gushchin@linux.dev>
 <5bpibh7qkrcggyqsrathszfqrjckyaqspdons6cfkkyse4ub4b@2iu4sibbirxf>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bpibh7qkrcggyqsrathszfqrjckyaqspdons6cfkkyse4ub4b@2iu4sibbirxf>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 02:42:56PM -0500, Liam R. Howlett wrote:
> * Roman Gushchin <roman.gushchin@linux.dev> [250123 11:44]:
> > Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> > added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> > race between munmap() and unmap_mapping_range(). However it added some
> > overhead to other paths where tlb_vma_end() is used, but vmas are not
> > removed, e.g. madvise(MADV_DONTNEED).
> > 
> > Fix this by moving the tlb flush out of tlb_end_vma() into
> > free_pgtables(), somewhat similar to the stable version of the
> > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > for PFNMAP mappings before unlink_file_vma()").
> > 
> > Note, that if tlb->fullmm is set, no flush is required, as the whole
> > mm is about to be destroyed.
> > 
> > ---
> 
> Hugh didn't mean to add a ---, he meant to move the version info between
> the Cc list and the patch so that it's not in the git history.

Ah, ok, somehow it wasn't a problem previously for me, usually Andrew
was dropping the part while merging into the mm tree.
Thanks for clarifying.

> 
> You can find examples on the ML.
> 
> > 
> > v3:
> >   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
> > 
> > v2:
> >   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
> >   - added comments (by Peter Z.)
> >   - fixed the vma_pfn flag setting (by Hugh D.)
> > 
> 
> 
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Link: some email discussion url lore.kernel.org..

It was based on some non-public discussion unfortunately, so no lore link.

Thank you!

