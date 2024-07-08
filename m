Return-Path: <linux-arch+bounces-5317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F2F92A585
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 17:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E51F21D04
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5C143896;
	Mon,  8 Jul 2024 15:21:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55A76035;
	Mon,  8 Jul 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452072; cv=none; b=Dg+Ht9Xy4l4DFw2CYxkg/ODqnoqxfJxlI6PhOdBjYN3dMQf4aSo04eYweWTkrmO9Y+Li86ZFD+q7sNzTubVIDlBhZTsPdp+yXSedwmHPtZ3sffkhQjuZZ5orQIfl/5bL4hwu9u7x3DrUgDiHewpg5PoioiLbNPjCCD1KKKp/gqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452072; c=relaxed/simple;
	bh=fuX5DWI5ydZbydwfdkBlHIyt+NlNGDJjTXsUTArm8as=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I6XgS2B7VPQSGNWIslsBjK4FXJEJEQrARXDRC5BFoeM6xnuAi9xaPUIV/1GxUux2cEnhG65LM/IS7LBbgoUYvXfF3eCkjDFaWrPX5QqLYs2pZGPfnk70yjkx4B2omTpZ0zVCx0DX7eJrpS2GMUEbMfVzXbDLb4Q2bPhWsdyn2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2101042;
	Mon,  8 Jul 2024 08:21:33 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170663F641;
	Mon,  8 Jul 2024 08:21:05 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:21:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Message-ID: <ZowD3LQT_KTz2g4X@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>

On Fri, Jul 05, 2024 at 10:58:29AM -0700, Linus Torvalds wrote:
> On Fri, 5 Jul 2024 at 04:25, Will Deacon <will@kernel.org> wrote:
> >
> > we'd probably want to use an address that lives between the two TTBRs
> > (i.e. in the "guard region" you mentioned above), just in case somebody
> > has fscked around with /proc/sys/vm/mmap_min_addr.
> 
> Yes, I don't want to use a NULL pointer and rely on mmap_min_addr.
> 
> For x86-64, we have two "guard regions" that can be used to generate
> an address that is guaranteed to fault:
> 
>  - the kernel always lives in the "top bit set" part of the address
> space (and any address tagging bits don't touch that part), and does
> not map the highest virtual address because that's used for error
> pointers, so the "all bits set" address always faults

The same should be true on arm64, though I'm not immediately sure if we
explicitly reserve that VA region -- if we don't, then we should.

>  - the region between valid user addresses and kernel addresses is
> also always going to fault, and we don't have them adjacent to each
> other (unlike, for example, 32-bit i386, where the kernel address
> space is directly adjacent to the top of user addresses)

Today we have a gap between the TTBR0 and TTBR1 VA ranges in all
configurations, but in future (with the new FEAT_D128 page table format)
we will have configurations where there's no gap between the two ranges.

> So on x86-64, the simple solution is to just say "we know if the top
> bit is clear, it cannot ever touch kernel code, and if the top bit is
> set we have to make the address fault". So just duplicating the top
> bit (with an arithmetic shift) and or'ing it with the low bits, we get
> exactly what we want.
> 
> But my knowledge of arm64 is weak enough that while I am reading
> assembly language and I know that instead of the top bit, it's bit55,
> I don't know what the actual rules for the translation table registers
> are.
> 
> If the all-bits-set address is guaranteed to always trap, then arm64
> could just use the same thing x86 does (just duplicating bit 55
> instead of the sign bit)?

I think something of that shape can work (see below). There are a couple
of things that make using all-ones unsafe:

1) Non-faulting parts of a misaligned load/store can occur *before* the
   fault is raised. If you have two pages where one of which is writable
   and the other of which is not writeable (in either order), a store
   which straddles those pages can write to the writeable page before
   raising a fault on the non-writeable page.

   I've seen this behaviour on real HW, and IIUC this is fairly common.

2) Loads/stores which wrap past 0xFFFF_FFFF_FFFF_FFFF access bytes at
   UNKNOWN addresses. An N-byte store at 0xFFFF_FFFF_FFFF_FFFF may write
   to N-1 bytes at an arbitrary address which is not
   0x0000_0000_0000_0000.

   In the latest ARM ARM (K.a), this is described tersely in section
   K1.2.9 "Out of range virtual address".

   That can be found at:

   https://developer.arm.com/documentation/ddi0487/ka/?lang=en

   I'm aware of implementation styles where that address is not zero and
   can be a TTBR1 (kernel) address.

Given that, we'd need to avoid all-ones, but provided we know that the
first access using the pointer will be limited to PAGE_SIZE bytes past
the pointer, we could round down the bad pointer to be somewhere within
the error pointer page, e.g.

	SBFX <mask>, <ptr>, #55, #1
	ORR  <ptr>, <ptr>, <mask>
	BIC <ptr>, <ptr>, <mask>, lsr #(64 - PAGE_SHIFT)

That last `BIC` instructions is "BIt Clear" AKA "AND NOT". When bit 55
is one that will clear the lower bits to round down to a page boundary,
and when bit 55 is zero it will have no effect (as it'll be an AND with
all-ones).

Thanks,
Mark.

