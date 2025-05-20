Return-Path: <linux-arch+bounces-12004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD243ABCEB6
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98D97A9E11
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 05:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F5C1BD9F0;
	Tue, 20 May 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3rxvZE0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE05A94F;
	Tue, 20 May 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719926; cv=none; b=iAmzPDiZWZHQg2gslDz+iUARntF+P/6C/YADAqxr2IrGVBQPkamNsSZxLNyXeQP1yWkgPRRk2kyejBbfloniLJ3crbU89eyuOEp+s84MqvjjGCx5oFPpGrGbNQLgBIsAAksB5U9OAboqdL7k80jlY2PHNs4jYVLcfxTvi6i5k8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719926; c=relaxed/simple;
	bh=+bJKdW5iBH+ghni1OE0QBKQkJ9VoNQpI4KmFBCX+PHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9e235hGQ/LRW6W+1Zq5zdYxDrnyvUqz/zxJqm1kRaDY/bsNMzBj2NYRt1G8wtIegX290MrQJzgzFyAErSCrfGEBuY3/QefpdHHtSv7r5qCqrRIJikdoWB2kLkkHOm65wyNj7UEjS62eWE+tQzNIsDrg1Zi3UzSFVPo1Gr2DqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3rxvZE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECDCC4CEE9;
	Tue, 20 May 2025 05:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747719926;
	bh=+bJKdW5iBH+ghni1OE0QBKQkJ9VoNQpI4KmFBCX+PHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3rxvZE0IfpB1gNNoJPdeJGOMTQDaGtK413qkRrEa5anz0fH9bwcteqlRFt0iqvHn
	 qne8O4ZZ3YptqI/eUjOKCAF8PpL42vf+nao/d1L75vuhtXC4GZCYFMlz5pMKffL6vi
	 U3k52lu8N5GSqbonKUiAH9FVcxzA6KQGdHD4m4DJfAhATy5QTA/3Kr7z2748LInkMc
	 Qz2ZBbbkykgJD63A9mW5pWyLl2BVssGfXm3xYJ8XDD2Yu2SMny/P27ssijcyNhsSkI
	 3c6EmZlXd3WH8nF36ZteE1tV3pdzAStoubOwaY5F8Y1EXRFPbuxR19Kp8qRR7MPYAA
	 3PWsHSMP+hwNg==
Date: Tue, 20 May 2025 08:45:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
Message-ID: <aCwW70QKGFtXVxEH@kernel.org>
References: <20250519171805.1288393-1-rppt@kernel.org>
 <mafs0plg4tgee.fsf@amazon.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0plg4tgee.fsf@amazon.de>

On Mon, May 19, 2025 at 11:55:05PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Mon, May 19 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Pratyush Yadav reports the following crash:
> >
> >     ------------[ cut here ]------------
> >     kernel BUG at arch/x86/mm/physaddr.c:23!
> >     ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
> >     CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> >     RIP: 0010:__phys_addr+0x58/0x60
> >     Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> >     RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
> >     RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
> >     RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
> >     RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
> >     R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
> >     R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
> >     FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
> >     Call Trace:
> >      <TASK>
> >      ? __cma_declare_contiguous_nid+0x6e/0x340
> >      ? cma_declare_contiguous_nid+0x33/0x70
> >      ? dma_contiguous_reserve_area+0x2f/0x70
> >      ? setup_arch+0x6f1/0x870
> >      ? start_kernel+0x52/0x4b0
> >      ? x86_64_start_reservations+0x29/0x30
> >      ? x86_64_start_kernel+0x7c/0x80
> >      ? common_startup_64+0x13e/0x141
> >
> >   The reason is that __cma_declare_contiguous_nid() does:
> >
> >           highmem_start = __pa(high_memory - 1) + 1;
> >
> >   If dma_contiguous_reserve_area() (or any other CMA declaration) is
> >   called before free_area_init(), high_memory is uninitialized. Without
> >   CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
> >   highmem_start.
> >
> > The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
> > free_area_init()") moved initialization of high_memory after the call to
> > dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
> > architectures.
> >
> > In the case CONFIG_HIGHMEM is enabled, some architectures that actually
> > support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
> > before a possible call to __cma_declare_contiguous_nid() and some
> > initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
> > xtensa) even before the commit e120d1bc12da so they are fine with using
> > uninitialized value of high_memory.
> 
> I don't know if they are fine or they haven't realized this is a bug
> yet.

For those that initialized high_memory in their mem_init() it would have
been a bug quite some time.

> Either way, this patch fixes the crash for me on x86_64, restores how it
> should behave, and doesn't seem to make anything worse, so:
> 
> Tested-by: Pratyush Yadav <ptyadav@amazon.de>

Thanks!
 
> Thanks for fixing this!
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

