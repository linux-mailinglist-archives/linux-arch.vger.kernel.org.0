Return-Path: <linux-arch+bounces-2499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBC85BD1F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B61C20C2E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA56A320;
	Tue, 20 Feb 2024 13:26:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F96A00F;
	Tue, 20 Feb 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435609; cv=none; b=CXT6YcI1JeGKTaTZw0hSTosEOBhyb9dZL4RJGo+de7NtaM5JzLa4Xl20AFEoFa1eME+XxL9iqpyQDjGhpVsshGN8zEZjyMq4sqMjJpti8qXCXmBipBS0WC6qy8nT87oe86iVq6FIm7f25gLHTlvt3tH5GTVX2l1fVeIw6Kv7leM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435609; c=relaxed/simple;
	bh=1gXn0GrJBmEJMZAt2/PxNJ4nlOduqIj5XfvUP5zfb6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo9iiSMZ+rthZDpD1fIWqp3B7jGun2Jc2PWqFZqyjtmBowzzrRrIjJ9xHxMYBspT3qKVO7KJYzZGJaJgpJzBmNmEA+xXnqzJeK4vQxwmY5/rcnB014qR6ZbPuddvfN6HQIwcpvqC5pI1jOhT05KzeumQ0aArF2u0aEXx0kGSZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1647EFEC;
	Tue, 20 Feb 2024 05:27:26 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09743F73F;
	Tue, 20 Feb 2024 05:26:41 -0800 (PST)
Date: Tue, 20 Feb 2024 13:26:38 +0000
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
	linux-mm@kvack.org
Subject: Re: arm64 MTE tag storage reuse - alternatives to MIGRATE_CMA
Message-ID: <ZdSojvNyaqli2rWE@raptor>
References: <ZdSMbjGf2Fj98diT@raptor>
 <70d77490-9036-48ac-afc9-4b976433070d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d77490-9036-48ac-afc9-4b976433070d@redhat.com>

Hi David,

On Tue, Feb 20, 2024 at 01:05:42PM +0100, David Hildenbrand wrote:
> On 20.02.24 12:26, Alexandru Elisei wrote:
> > Hello,
> > 
> 
> Hi!
> 
> > This is a request to discuss alternatives to the current approach for
> > reusing the MTE tag storage memory for data allocations [1]. Each iteration
> > of the series uncovered new issues, the latest being that memory allocation
> > is being performed in atomic contexts [2]; I would like to start a
> > discussion regarding possible alternative, which would integrate better
> > with the memory management code.
> > 
> > This is a high level overview of the current approach:
> > 
> >   * Tag storage pages are put on the MIGRATE_CMA lists, meaning they can be
> >     used for data allocations like (almost) any other page in the system.
> > 
> >   * When a page is allocated as tagged, the corresponding tag storage is
> >     also allocated.
> > 
> >   * There's a static relationship between a page and the location in memory
> >     where its tags are stored. Because of this, if the corresponding tag
> >     storage is used for data, the tag storage page is migrated.
> > 
> > Although this is the most generic approach because tag storage pages are
> > treated like normal pages, it has some disadvantages:
> > 
> >   * HW KASAN (MTE in the kernel) cannot be used. The kernel allocates memory
> >     in atomic context, where migration is not possible.
> > 
> >   * Tag storage pages cannot be themselves tagged, and this means that all
> >     CMA pages, even those which aren't tag storage, cannot be used for
> >     tagged allocations.
> > 
> >   * Page migration is costly, and a process that uses MTE can experience
> >     measurable slowdowns if the tag storage it requires is in use for data.
> >     There might be ways to reduce this cost (by reducing the likelihood that
> >     tag storage pages are allocated), but it cannot be completely
> >     eliminated.
> > 
> >   * Worse yet, a userspace process can use a tag storage page in such a way
> >     that migration is effectively impossible [3],[4].  A malicious process
> >     can make use of this to prevent the allocation of tag storage for other
> >     processes in the system, leading to a degraded experience for the
> >     affected processes. Worst case scenario, progress becomes impossible for
> >     those processes.
> > 
> > One alternative approach I'm looking at right now is cleancache. Cleancache
> > was removed in v5.17 (commit 0a4ee518185e) because the only backend, the
> > tmem driver, had been removed earlier (in v5.3, commit 814bbf49dcd0).
> > 
> > With this approach, MTE tag storage would be implemented as a driver
> > backend for cleancache. When a tag storage page is needed for storing tags,
> > the page would simply be dropped from the cache (cleancache_get_page()
> > returns -1).
> 
> With large folios in place, we'd likely want to investigate not working on
> individual pages, but on (possibly large) folios instead.

Yes, that would be interesting. Since the backend has no way of controlling
what tag storage page will be needed for tags, and subsequently dropped
from the cache, we would have to figure out what to do if one of the pages
that is part of a large folio is dropped. The easiest solution that I can
see is to remove the entire folio from the cleancache, but that would mean
also dropping the rest of the pages from the folio unnecessarily.

> 
> > 
> > I believe this is a very good fit for tag storage reuse, because it allows
> > tag storage to be allocated even in atomic contexts, which enables MTE in
> > the kernel. As a bonus, all of the changes to MM from the current approach
> > wouldn't be needed, as tag storage allocation can be handled entirely in
> > set_ptes_at(), copy_*highpage() or arch_swap_restore().
> > 
> > Is this a viable approach that would be upstreamable? Are there other
> > solutions that I haven't considered? I'm very much open to any alternatives
> > that would make tag storage reuse viable.
> 
> As raised recently, I had similar ideas with something like virtio-mem in
> the past (wanted to call it virtio-tmem back then), but didn't have time to
> look into it yet.
> 
> I considered both, using special device memory as "cleancache" backend, and
> using it as backend storage for something similar to zswap. We would not
> need a memmap/"struct page" for that special device memory, which reduces
> memory overhead and makes "adding more memory" a more reliable operation.

Hm... this might not work with tag storage memory, the kernel needs to
perform cache maintenance on the memory when it transitions to and from
storing tags and storing data, so the memory must be mapped by the kernel.

> 
> Using it as "cleancache" backend does make some things a lot easier.
> 
> The idea would be to provide a variable amount of additional memory to a VM,
> that can be reclaimed easily and reliably on demand.
> 
> The details are a bit more involved, but in essence, imagine a special
> physical memory region that is provided by a the hypervisor via a device to
> the VM. A virtio device "owns" that region and the driver manages it, based
> on requests from the hypervisor.
> 
> Similar to virtio-mem, there are ways for the hypervisor to request changes
> to the memory consumption of a device (setting the requested size). So when
> requested to consume less, clean pagecache pages can be dropped and the
> memory can be handed back to the hypervisor.
> 
> Of course, likely we would want to consider using "slower" memory in the
> hypervisor to back such a device.

I'm not sure how useful that will be with tag storage reuse. KVM must
assume that **all** the memory that the guest uses is tagged and it needs
tag storage allocated (it's a known architectural limitation), so that will
leave even less tag storage memory to distribute between the host and the
guest(s).

Adding to that, at the moment Android is going to be the major (only?) user
of tag storage reuse, and as far as I know pKVM is more restrictive with
regards to the emulated devices and the memory that is shared between
guests and the host.

> 
> I also thought about better integrating memory reclaim in the hypervisor,
> similar to "MADV_FREE" semantic way. One idea I had was that the memory
> provided by the device might have "special" semantics (as if the memory is
> always marked MADV_FREE), whereby the hypervisor could reclaim+discard any
> memory in that region any time, and the driver would have ways to get
> notified about that, or detect that reclaim happened.
> 
> I learned that there are cases where data that is significantly larger than
> main memory might be read repeatedly. As long as there is free memory in the
> hypervisor, it could be used as a cache for clean pagecache pages. In
> contrast to memory ballonning + virtio-mem, that memory can be easily and
> reliably reclaimed. And reclaiming that memory cannot really hurt the VM, it
> would only affect performance.
> 
> Long story short: what I had in mind would require similar hooks (again).
> 
> In contrast to tmem, with arm64 MTE we could get an actual supported
> cleancache backend fairly easily. I recall that tmem was abandoned in XEN
> and never really reached production quality.

Yes, that was also my impression after reading commit 814bbf49dcd0 ("xen:
remove tmem driver").

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

