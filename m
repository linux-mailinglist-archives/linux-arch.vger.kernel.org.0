Return-Path: <linux-arch+bounces-2506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE2785C188
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ABF282DF8
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD52E84E;
	Tue, 20 Feb 2024 16:36:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645B2C856;
	Tue, 20 Feb 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446973; cv=none; b=rtK9Tr2YP++XtSFpm1MRcKvW4KjUxBTKX8vj2XYF0DoMuConCW6kncQBU80nhoRG71o4L6iOeBnQxYGHm2oGSGiCHb+A8IW8qbRYxC2LMDAI7HskxTvx5qFv/NEaor/KIEYG5+IrEVi2SprKj7kF7wsQ6V095B55txbOeuFyJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446973; c=relaxed/simple;
	bh=MfRrDubXEVjaGcbYyk2dr+f/x8bO34rZrjgFdcLHTmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uuy0NPkbHX9cDZlYoiL07sGB+2+OyL7ZBqmmtinuvy4AiX2ZNIjZGShDoH6vaDpZbVaMdWY/pPqmmCVsC7ihEGVli31ikHZIHB/mgYFiKGiYddKtVRQg6IeL4LUplQsZrM1pcoj5MC3sBtp3RDgAdBWdMw0zPhLJfCW3vLSNPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F848FEC;
	Tue, 20 Feb 2024 08:36:49 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E3A3F762;
	Tue, 20 Feb 2024 08:36:06 -0800 (PST)
Date: Tue, 20 Feb 2024 16:36:03 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, pcc@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, rppt@kernel.org, akpm@linux-foundation.org,
	peterz@infradead.org, konrad.wilk@oracle.com, willy@infradead.org,
	jgross@suse.com, hch@lst.de, geert@linux-m68k.org,
	vitaly.wool@konsulko.com, ddstreet@ieee.org, sjenning@redhat.com,
	hughd@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, alexandru.elisei@arm.com
Subject: Re: arm64 MTE tag storage reuse - alternatives to MIGRATE_CMA
Message-ID: <ZdTU80xGHgpeGwk9@raptor>
References: <ZdSMbjGf2Fj98diT@raptor>
 <70d77490-9036-48ac-afc9-4b976433070d@redhat.com>
 <ZdSojvNyaqli2rWE@raptor>
 <e0b7c884-4345-44b1-b8c0-2711a28a980e@redhat.com>
 <ZdTNOq9BoOoKo8bZ@raptor>
 <b10d52ba-4a8d-43bd-96c1-cde848bec143@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10d52ba-4a8d-43bd-96c1-cde848bec143@redhat.com>

Hi,

On Tue, Feb 20, 2024 at 05:16:26PM +0100, David Hildenbrand wrote:
> > > > > > I believe this is a very good fit for tag storage reuse, because it allows
> > > > > > tag storage to be allocated even in atomic contexts, which enables MTE in
> > > > > > the kernel. As a bonus, all of the changes to MM from the current approach
> > > > > > wouldn't be needed, as tag storage allocation can be handled entirely in
> > > > > > set_ptes_at(), copy_*highpage() or arch_swap_restore().
> > > > > > 
> > > > > > Is this a viable approach that would be upstreamable? Are there other
> > > > > > solutions that I haven't considered? I'm very much open to any alternatives
> > > > > > that would make tag storage reuse viable.
> > > > > 
> > > > > As raised recently, I had similar ideas with something like virtio-mem in
> > > > > the past (wanted to call it virtio-tmem back then), but didn't have time to
> > > > > look into it yet.
> > > > > 
> > > > > I considered both, using special device memory as "cleancache" backend, and
> > > > > using it as backend storage for something similar to zswap. We would not
> > > > > need a memmap/"struct page" for that special device memory, which reduces
> > > > > memory overhead and makes "adding more memory" a more reliable operation.
> > > > 
> > > > Hm... this might not work with tag storage memory, the kernel needs to
> > > > perform cache maintenance on the memory when it transitions to and from
> > > > storing tags and storing data, so the memory must be mapped by the kernel.
> > > 
> > > The direct map will definitely be required I think (copy in/out data). But
> > > memmap for tag memory will likely not be required. Of course, it depends how
> > > to manage tag storage. Likely we have to store some metadata, hopefully we
> > > can avoid the full memmap and just use something else.
> > 
> > So I guess instead of ZONE_DEVICE I should try to use arch_add_memory()
> > directly? That has the limitation that it cannot be used by a driver
> > (symbol not exported to modules).
> You can certainly start with something simple, and we can work on removing
> that memmap allocation later.
> 
> Maybe we have to expose new primitives in the context of such drivers.
> arch_add_memory() likely also doesn't do what you need.
> 
> I recall that we had a way of only messing with the direct map.
> 
> Last time I worked with that was in the context of memtrace
> (arch/powerpc/platforms/powernv/memtrace.c)
> 
> There, we call arch_create_linear_mapping()/arch_remove_linear_mapping().
> 
> ... and now my memory comes back: we never finished factoring out
> arch_create_linear_mapping/arch_remove_linear_mapping so they would be
> available on all architectures.
> 
> 
> Your driver will be very arm64 specific, so doing it in an arm64-special way
> might be good enough initially. For example, the arm64-core could detect
> that special memory region and just statically prepare the direct map and
> not expose the memory to the buddy/allocate a memmap. Similar to how we
> handle the crashkernel/kexec IIRC (we likely do not have a direct map for
> that, though; ).
> 
> [I was also wondering if we could simply dynamically map/unmap when required
> so you can just avoid creating the entire direct map; might bot be the best
> approach performance-wise, though]
> 
> There are a bunch of details to be sorted out, but I don't consider the
> directmap/memmap side of things a big problem.

Sounds reasonable, thank you for the feedback!

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

