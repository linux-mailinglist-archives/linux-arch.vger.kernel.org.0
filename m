Return-Path: <linux-arch+bounces-12021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4BABDE61
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE358C0E8E
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E392517A5;
	Tue, 20 May 2025 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB+bdiw7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D452505AC;
	Tue, 20 May 2025 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753616; cv=none; b=GKfJIhHIf7m0va3zZVmsGgPuiw1fYG3V1hRFjYafus99BeyWhCRBIxGhSi44wL1QUMsrYDYkyno4SUOb3ahoOyvjWxMAKYsirhhB7hW5Td6Aw1+d23gYjYoyyy51oVlD7W1t/ChdYUVuJU7c1OidRbX3gt/7WJynaCwjFWadpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753616; c=relaxed/simple;
	bh=5nGJFy6nrUZcxCfljXCPiovm3928lZBYOBaJ0nYBuCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ4iDNHN0mcy1YYgyjh3hVQlm74jAJwE2KFEfrQ0+f5op9sM+4d+Spqs2NWFBs2Qx54LDDW27Y7pnCdBot1qEqbE3z+8N89ADc5OfIfpJkjGo9XrqF0tLdFMMYjRB+BIKV+Z5k830jHJA03+4vRGGYXEXlDpPJrHtJ1s3Ap9l7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB+bdiw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF81C4CEE9;
	Tue, 20 May 2025 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747753615;
	bh=5nGJFy6nrUZcxCfljXCPiovm3928lZBYOBaJ0nYBuCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hB+bdiw7rCP7qDw3zQtwy4j4c+iRwFTXhAwiS0GR6EI0vt5TSEa/Ue9acRSsVDYHK
	 1QUyc4M92A7qAh3lKu9Wdq0ZngI9Rja7ZwHjKoDBpEZ+7AvyrCR2OZ1S1Oi86ITH/3
	 9iFBrQVJZcp5u1iAjw8HWXqgEdZxDorIpKZbxxZ5gOa3Yb4Ukn6oh71w+ii928ARhK
	 DBVK1fXfE6kvvmFgf4fxORsrMyCFETmSDWLp8g8TZOHRvcsR5p7t51MruLrBmFuMZL
	 OjBq1/S6DgxFwUGYU2jPhqJiA6EF+fp1num9ECQzvnkd+uIsNuowXLsuvbPgrQ6ljN
	 28GQznW2WhzaQ==
Date: Tue, 20 May 2025 18:06:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Pratyush Yadav <ptyadav@amazon.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
Message-ID: <aCyaiXO7nmjC3wWj@kernel.org>
References: <20250519171805.1288393-1-rppt@kernel.org>
 <aCw9mpmhx9SrL8Oy@localhost.localdomain>
 <d2751191-fc32-418a-8b62-dedab41d0615@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2751191-fc32-418a-8b62-dedab41d0615@redhat.com>

On Tue, May 20, 2025 at 11:14:28AM +0200, David Hildenbrand wrote:
> On 20.05.25 10:30, Oscar Salvador wrote:
> > On Mon, May 19, 2025 at 08:18:05PM +0300, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > Pratyush Yadav reports the following crash:
> > > 
> > >      ------------[ cut here ]------------
> > >      kernel BUG at arch/x86/mm/physaddr.c:23!
> > >      ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
> > >      CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
> > >      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > >      RIP: 0010:__phys_addr+0x58/0x60
> > >      Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> > >      RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
> > >      RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
> > >      RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
> > >      RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
> > >      R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
> > >      R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
> > >      FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> > >      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >      CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
> > >      Call Trace:
> > >       <TASK>
> > >       ? __cma_declare_contiguous_nid+0x6e/0x340
> > >       ? cma_declare_contiguous_nid+0x33/0x70
> > >       ? dma_contiguous_reserve_area+0x2f/0x70
> > >       ? setup_arch+0x6f1/0x870
> > >       ? start_kernel+0x52/0x4b0
> > >       ? x86_64_start_reservations+0x29/0x30
> > >       ? x86_64_start_kernel+0x7c/0x80
> > >       ? common_startup_64+0x13e/0x141
> > > 
> > >    The reason is that __cma_declare_contiguous_nid() does:
> > > 
> > >            highmem_start = __pa(high_memory - 1) + 1;
> > > 
> > >    If dma_contiguous_reserve_area() (or any other CMA declaration) is
> > >    called before free_area_init(), high_memory is uninitialized. Without
> > >    CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
> > >    highmem_start.
> > > 
> > > The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
> > > free_area_init()") moved initialization of high_memory after the call to
> > > dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
> > > architectures.
> > > 
> > > In the case CONFIG_HIGHMEM is enabled, some architectures that actually
> > > support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
> > > before a possible call to __cma_declare_contiguous_nid() and some
> > > initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
> > > xtensa) even before the commit e120d1bc12da so they are fine with using
> > > uninitialized value of high_memory.
> > > 
> > > And in the case CONFIG_HIGHMEM is disabled high_memory essentially becomes
> > > the first address after memory end, so instead of relying on high_memory to
> > > calculate highmem_start use memblock_end_of_DRAM() and eliminate the
> > > dependency of CMA area creation on high_memory in majority of
> > > configurations.
> > > 
> > > Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> > > Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > 
> > I will note though that it is a bit akward to have highmem involved here
> > when we might not have CONFIG_HIGHMEM enabled.
> > I get that for !CONFIG_HIGHMEM it is a no-op situation, but still I
> > wonder whether we could abstract that from this function.

Highmem is there for some time now (see f7426b983a6a ("mm: cma: adjust
address limit to avoid hitting low/high memory boundary"))
We might try abstracting it from that function but I'd prefer not doing it
that late in the release cycle.
 
> Same thought here.
> 
> Can't we do some IS_ENABLED(CONFIG_HIGHMEM) magic or similar to not even use
> that variable without CONFIG_HIGHMEM?

You mean highmem_start or high_memory?

high_memory is one of the ways to say "end of directly/linearly addressable
memory" and some other places in the kernel (outside arch) still use it
regardless of CONFIG_HIGHMEM.

And I don't think we have another way to say where directly addressable
memory ends, and this IMHO is something that should replace high_memory.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

