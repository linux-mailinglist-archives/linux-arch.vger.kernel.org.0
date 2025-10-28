Return-Path: <linux-arch+bounces-14379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE6C146DD
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 12:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB07467019
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E83090DD;
	Tue, 28 Oct 2025 11:44:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E12E6127;
	Tue, 28 Oct 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651845; cv=none; b=hOzKifNHqcI5LH7OCB++dPID9YM6b3/ew/gW0uAt6XK1vW2CXBlz0i7Zw34ESGHS+Hk4Y1vAMNBoOuZB1DW+XSZFRk9FONOrF2pj3FT8vUxDlfnDo6SRdhpzrX6SEpWXNwrxFphNBd5W9qcC402wLEZxgru+QiZLx5oNjC7RDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651845; c=relaxed/simple;
	bh=q+opiOP6UNwKZqlNXmeNSX26KIFQVHSi9SmtYMBqeKo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EctLu5MsuLimvMBT87YdGgIVGda7oUBi5x/5lT+ysjr+QirSaQhQJVR/nzy7MyHv+peMIaKxfBldYtj2tFKRx8mxjshPzBmCKBx8R5EgZiV1M6p7QoaxlbksR7y8Rvpe41ZOMqlxwa4rCEZFsOW2GcMucFbK6QeF9/OuftZ1h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwpMp484kz6L4yt;
	Tue, 28 Oct 2025 19:40:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FC4C1400D3;
	Tue, 28 Oct 2025 19:43:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 11:43:50 +0000
Date: Tue, 28 Oct 2025 11:43:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Conor Dooley <conor@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Linux-Arch <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, Dan Williams
	<dan.j.williams@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, James Morse <james.morse@arm.com>, Will
 Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	<linuxarm@huawei.com>, Yushan Wang <wangyushan12@huawei.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Dave Jiang"
	<dave.jiang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Linus Walleij
	<linus.walleij@linaro.org>, Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Message-ID: <20251028114348.000006ed@huawei.com>
In-Reply-To: <fe57097b-1817-4428-9940-477c3f36cafb@app.fastmail.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
	<20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
	<20251022-harsh-juggling-2d4778b0649e@spud>
	<20251023174026.00005b42@huawei.com>
	<fe57097b-1817-4428-9940-477c3f36cafb@app.fastmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 10:44:03 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Oct 23, 2025, at 18:40, Jonathan Cameron wrote:
> > On Wed, 22 Oct 2025 21:47:21 +0100 Conor Dooley <conor@kernel.org> wrote:  
> 
> > On CXL discord, some reasonable doubts were expressed about justifying
> > this to Linus via CXL. Which is fair given tiny overlap from a 'where
> > the code is' point of view and also it seems I went too far in trying to
> > avoid people interpreting this as affecting x86 systems (see earlier
> > versions for how my badly scoped cover letter distracted from what this
> > was doing) and focus in on what was specifically being enabled rather
> > than the generic bit. Hence it mentions arm64 only right now and right
> > at the top of the cover letter.
> >
> > Given it's not Arm architecture (hence just one Kconfig line in Arm
> > specific code) I guess alternative is back to drivers/cache and Conor which
> > I see goes via SoC (so +CC SoC tree maintainers).  
> 
> I tried to understand the driver from the cover letter and the
> implementation, but I think I still have some fundamental questions
> about which parts of the system require this for coherency with
> one another.
> 
> drivers/cache/* is about keeping coherency between DMA masters
> that lack support for snooping the CPU caches on low-end SoCs.
> Does the new code fit into the same category?

Hi Arnd,

Sort of if you squint a bit.  The biggest difference is every architecture
has to do something explicit and often that's different from what it would
do for local (same host) non coherent DMA. In some cases it's a CPU
instruction (x86 - which this patch set doesn't touch) in others an MMIO
interface (all known arm64 implementations today).

The closest to your question that this comes is if we do end up using this
for the multi host non-coherent shared memory case.

Before I expand on this, note it is very doubtful this use case
of the patch set here will be realized as the performance will
be terrible unless the change of ownership is very very rare.

In that case you could conceive of it being a bit like two symmetric
DMA masters combined with CPUs. From viewpoint of each host the other one
is the DMA master that doesn't support snooping.
 
View from Host A... Host B looks like non coherent DMA
 ________                            ________
|        |                          |        |
| Host A |                          | Host B |
|  CPU   |---------- MEM -----------|  (CPU) |
| (DMA)  |                          |  DMA   | 
|________|                          |________|

View from Host B... Host A looks like non coherent DMA
 ________                            ________
|        |                          |        |
| Host A |                          | Host B |
| (CPU)  |---------- MEM -----------|  CPU   |
|  DMA   |                          | (DMA)  | 
|________|                          |________|

In my opinion, new architecture is needed to make fine grained sharing
without hardware coherency viable. Note that CXL supports fully hardware
coherent multi host shared memory which resolves that problem but doesn't
cover the hotplug aspect as the device won't flush out lines it never
knew the host cached (before it was hot plugged!)

Use case that matters is much closer to flushing because memory hotplug
occurred - something hosts presumably do, but hide in firmware when it's
physical DDR hotplug).  Arguably you could conceive of persistent memory
hotplug as being non coherent DMA done by some host at an earlier time
that is then exposed to the local host by the hotplug event.   Kind of
a stretch though.

> Or is this about flushing cacheable mappings on CXL devices
> that are mapped as MMIO into the CPU physical address space,
> which sounds like it would be out of scope for drivers/cache?

Not MMIO. The memory in question is mapped as normal RAM - just the same
as DDR DIMM or similar.

As above, the easiest thing to think of it is as is memory hotplug where
the memory may contain data (so could think of it as similar to
hotplugging possibly persistent memory).

Before the memory is there you can be served zeros (or poison) and when
the memory is plugged in you need to make sure those zeros are not in
cache.  More complex sequences of removing memory then putting other
memory back at the same PA are covered as well.

> 
> If it's the first of those two scenarios, we may want to
> generalize the existing riscv_nonstd_cache_ops structure into
> something that can be used across architectures.

There are some strong similarities, hence very similar function prototype
for wbinv().  We could generalize that infrastructure and a) make it handle
multiple (heterogeneous) flushing agents b) polling for completion c)
late arrival of those agents which is a problem for anything that can't
be made to wait by user space (not a problem for use cases I need this
for, userspace is always in the loop for policy decisions anyway).

The hard part would be that we'd have to add infrastructure to distinguish
when the operation should be called and that the level of flush will be
dependent on that.  An example is the use of the riscv ops in
arch_invalidate_pmem(). That's used for clearing poison for example.

On x86 the implementation of that is clflush_cache_range() whereas today
the implementation we are replacing here is the much heavier WBINVD
(whether we could use clflush is an open question that was discussed in
earlier versions of this patch set - not in scope here though).
On arm64 for this case today dcache_inval_poc() is enough as long as
we are dealing with a single host (as those code paths are). If this
flush did go far enough I believe a secondary issue is we would have to
jump through hoops to create a temporary VA to PA mapping to memory
that doesn't actually exist at some points in time where we flush/

On arm64 at least, the Point of Coherence is currently a single host thing
so not guaranteed to write far enough for the 'hotplug' of memory case
(and does not do so on some existing hardware as for fully coherent
single hosts this is a noop).

Also the DMA use cases of the existing riscv ops are not applicable here
at all as when DMA is going on we'd better be sure the memory remains
available and doesn't need any flushes.

Longer term I can see we might want to combine the two approaches or
(this patch set and the existing riscv specific infrastructure), but
I have little idea on how to do that with the usecases we have
visibility of today.  This stuff is all in kernel so I'm not that worried
about getting everything perfect first time.

The drivers/cache placement was mostly about finding a place where
we'd naturally see exactly the sort of overlap you've drawn attention to.

Thanks,

Jonathan

> 
>      Arnd


