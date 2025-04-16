Return-Path: <linux-arch+bounces-11417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0926A8B96B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Apr 2025 14:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77152188D155
	for <lists+linux-arch@lfdr.de>; Wed, 16 Apr 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27C70807;
	Wed, 16 Apr 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3V+osM/"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873B35971;
	Wed, 16 Apr 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807316; cv=none; b=Wu/eTG6daxLmLi5P08TG7H9Rc4wujyLuFTn6mvs35FpqczgWQVIU4Ch+GBGn8m32Fb+YcWB8ngXvanTAB+tGeN9VwuMP6F60pkDliOv5Vv/5etoFTFkVHz2gq05pN1bGcBebXyYp/qpQU0oFP+i1ivHSfmAMNKxxMwiwBnNkWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807316; c=relaxed/simple;
	bh=pds7ePBeyDPvnEG4ufC0ONRG4sCg4Kbal1yLbk+Kglo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9gipGTovqeVwLMijMiXkLXKj0TfDmj7RzKS4+EKIJCIcQ90vhDCUQRiLcTcAtxoOggt6s+jGTgQuvyntL1FsdPU2ogR3I5J0sLpoVLV2E43J8Mz1WN5WqZpTyAtVHRGcudz9v1EecgIv4gva/0kTUx9xL+BLc+2ZssFmUHikv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R3V+osM/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dwsf2a+LAeqnu6EO1zimyir940pvQziq2A6xZuIziWs=; b=R3V+osM/35c6CJLXnCxO9rd9YF
	mPiqXkqMd34Lab6bF4vHeTMnnRWggeMyYoYJgcXMTak/W8L4GOX5X+41Bg97VQCBU1VFdyQXzJZf+
	Ugzs/XZlXikcENVE6rB6BSLHNi+D0j1U+CEqU5OZRMIG1vqSsk2pgR604F7gPk053S5E5qvfr1O4+
	Ntzgzr3UxSgTaqeEo/eL29uL8JfDTkb9bC46fd/NM8j2h3qEYF8uOGnKa+TUqapFI+adgfZrQeFNe
	CUsVfEreUUwctEGkpq7AZUZBEo5LcLKd+VRU8hwv9tvlBOFHxmDkBUI01aiGO871cGgGA/ju//TQ/
	W9IZZ0SA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u525P-0000000A7kU-0pso;
	Wed, 16 Apr 2025 12:41:51 +0000
Date: Wed, 16 Apr 2025 13:41:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org
Subject: Re: Regression from a9b3c355c2e6 ("asm-generic: pgalloc: provide
 generic __pgd_{alloc,free}") with CONFIG_DEBUG_VM_PGFLAGS=y and Xen
Message-ID: <Z_-lj5kCg084MXRI@casper.infradead.org>
References: <202541612720-Z_-deOZTOztMXHBh-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202541612720-Z_-deOZTOztMXHBh-arkamar@atlas.cz>

On Wed, Apr 16, 2025 at 02:07:20PM +0200, Petr Vaněk wrote:
> I have discovered a regression introduced in commit a9b3c355c2e6
> ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}") [1,2] in
> kernel version 6.14. The problem occurs when the x86 kernel is
> configured with CONFIG_DEBUG_VM_PGFLAGS=y and is run as a PV Dom0 in Xen
> 4.19.1. During the startup, the kernel panics with the error log below.

You also have to have CONFIG_MITIGATION_PAGE_TABLE_ISOLATION enabled
to hit this problem, otherwise we allocate an order-0 page.

> The commit changed PGD allocation path.  In the new implementation
> _pgd_alloc allocates memory with __pgd_alloc, which indirectly calls 
> 
>   alloc_pages_noprof(gfp | __GFP_COMP, order);
> 
> This is in contrast to the old behavior, where __get_free_pages was
> used, which indirectly called
> 
>   alloc_pages_noprof(gfp_mask & ~__GFP_HIGHMEM, order);
> 
> The key difference is that the new allocator can return a compound page.
> When xen_pin_page is later called on such a page, it call
> TestSetPagePinned function, which internally uses the PF_NO_COMPOUND
> macro. This macro enforces VM_BUG_ON_PGFLAGS if PageCompound is true,
> triggering the panic when CONFIG_DEBUG_VM_PGFLAGS is enabled.

I suspect the right thing to do here is to change the PF_NO_COMPOUND to
PF_HEAD.  Probably for all of these:

/* Xen */
PAGEFLAG(Pinned, pinned, PF_NO_COMPOUND)
        TESTSCFLAG(Pinned, pinned, PF_NO_COMPOUND)
PAGEFLAG(SavePinned, savepinned, PF_NO_COMPOUND);
PAGEFLAG(Foreign, foreign, PF_NO_COMPOUND);
PAGEFLAG(XenRemapped, xen_remapped, PF_NO_COMPOUND)
        TESTCLEARFLAG(XenRemapped, xen_remapped, PF_NO_COMPOUND)

Could you give that a try?

