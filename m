Return-Path: <linux-arch+bounces-2502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E224B85C09C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC0286699
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01328762FB;
	Tue, 20 Feb 2024 16:03:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E564762E6;
	Tue, 20 Feb 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444995; cv=none; b=UHnqUVy6m3ujfSYRjLQf4X21aA/UQdXQ9wyFOjFgzzJsUkniHWujpym//d5hjY0uI8aE7ly4QDO3EOAiUHChkUEuqVThH6AJciYoenfwmYVqGNMtc7NZSAqgqwGEvVTJjzSLZbdG+2Jb8Q3H+e2VvyPiNH6IWWZymeTKn/fTgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444995; c=relaxed/simple;
	bh=p3HCnuUUs6C/TGyrIeEpBxQfcIdcr5XT+JJjYMmCPNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw6Z8bYKaJWG0ptjJRhpbRUb9PIZ4VNlHByzA1uMjnqPbXf3R1C2gbIbX6+xY50uYtWJtj0nqpO0rVUupM/3P+ejYU9bOTvCVolANbPV0HehSJdeUYWPAH+Uj5xCmZOsrMyQlyJ0BsmIAYg+2mWT4nAvoJEjR18a3TWUlHVf8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8333FEC;
	Tue, 20 Feb 2024 08:03:51 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C114D3F762;
	Tue, 20 Feb 2024 08:03:08 -0800 (PST)
Date: Tue, 20 Feb 2024 16:03:06 +0000
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
Message-ID: <ZdTNOq9BoOoKo8bZ@raptor>
References: <ZdSMbjGf2Fj98diT@raptor>
 <70d77490-9036-48ac-afc9-4b976433070d@redhat.com>
 <ZdSojvNyaqli2rWE@raptor>
 <e0b7c884-4345-44b1-b8c0-2711a28a980e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b7c884-4345-44b1-b8c0-2711a28a980e@redhat.com>

Hi,

On Tue, Feb 20, 2024 at 03:07:22PM +0100, David Hildenbrand wrote:
> > > 
> > > With large folios in place, we'd likely want to investigate not working on
> > > individual pages, but on (possibly large) folios instead.
> > 
> > Yes, that would be interesting. Since the backend has no way of controlling
> > what tag storage page will be needed for tags, and subsequently dropped
> > from the cache, we would have to figure out what to do if one of the pages
> > that is part of a large folio is dropped. The easiest solution that I can
> > see is to remove the entire folio from the cleancache, but that would mean
> > also dropping the rest of the pages from the folio unnecessarily.
> 
> Right, but likely that won't be an issue. Things get interesting when
> thinking about an efficient allocation approach.

Indeed.

> 
> > 
> > > 
> > > > 
> > > > I believe this is a very good fit for tag storage reuse, because it allows
> > > > tag storage to be allocated even in atomic contexts, which enables MTE in
> > > > the kernel. As a bonus, all of the changes to MM from the current approach
> > > > wouldn't be needed, as tag storage allocation can be handled entirely in
> > > > set_ptes_at(), copy_*highpage() or arch_swap_restore().
> > > > 
> > > > Is this a viable approach that would be upstreamable? Are there other
> > > > solutions that I haven't considered? I'm very much open to any alternatives
> > > > that would make tag storage reuse viable.
> > > 
> > > As raised recently, I had similar ideas with something like virtio-mem in
> > > the past (wanted to call it virtio-tmem back then), but didn't have time to
> > > look into it yet.
> > > 
> > > I considered both, using special device memory as "cleancache" backend, and
> > > using it as backend storage for something similar to zswap. We would not
> > > need a memmap/"struct page" for that special device memory, which reduces
> > > memory overhead and makes "adding more memory" a more reliable operation.
> > 
> > Hm... this might not work with tag storage memory, the kernel needs to
> > perform cache maintenance on the memory when it transitions to and from
> > storing tags and storing data, so the memory must be mapped by the kernel.
> 
> The direct map will definitely be required I think (copy in/out data). But
> memmap for tag memory will likely not be required. Of course, it depends how
> to manage tag storage. Likely we have to store some metadata, hopefully we
> can avoid the full memmap and just use something else.

So I guess instead of ZONE_DEVICE I should try to use arch_add_memory()
directly? That has the limitation that it cannot be used by a driver
(symbol not exported to modules).

Thanks,
Alex

