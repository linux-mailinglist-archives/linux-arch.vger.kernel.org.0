Return-Path: <linux-arch+bounces-5315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D271292A418
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC8284A9E
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9913A3FF;
	Mon,  8 Jul 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKOWXfac"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425171B970;
	Mon,  8 Jul 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446769; cv=none; b=ptERqDGIdB4ar3tij/E80ApKJn6Y8NS3q3urYawBrN6RgTe8vSJRRdTWXE6vyacqf8T/EiyfhxSxkE81uFyedKgXqixttjS7On2eu0i3Z0GMK1wrVX1Gj9kTtMOHcNKZa7EDHW+WImHtbRhfNLbDl7/yd4zSF1Ob1qt6gNpbw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446769; c=relaxed/simple;
	bh=qJjk7aS0JUEnJMP/IcWZ9dq3cQUIML8i3O7nI1+q8P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCiBVYKlwKNhl79kz/xBHOr1c+ew5JkbKshAYgosofkT9XY3+ecAvBGowQIO7huu7NQBCsqygQUa9mp7+ZfGb+2freNuSaFz7AFNPgF2v5mORRAz3vLgmvb5AbgrZq1LGTx44obXErizXmlw9UKsE/rRNUf+hkFfVjtY+tk2HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKOWXfac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227D1C116B1;
	Mon,  8 Jul 2024 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446769;
	bh=qJjk7aS0JUEnJMP/IcWZ9dq3cQUIML8i3O7nI1+q8P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKOWXfacIrPrjs2mon60OPe2CAMWqCusXuoaliTMaI325BnUCgl9hc5oob0h09FWR
	 jjyYxiEvlkELFtVjm3YJU1WlPCoh83j+jZ3xL17MvSOcVW9HLkTGyWCkOGyyuJNbPG
	 53WtcqAy993FpNvze6amPwB5XEsLsaseHL3faBpjJzL/r8PubXnVB0NxZdPUqVI8Wc
	 BtsebfusN4LQesQR3TIag4Qn6NyXu5p3FRSwshiI/UdqC3n3I5/f5IWcD6ZKxMSzjd
	 xtCj7BiwoBSqIwzBezL+Icfwn7CMdzDoxdQJse5tTXiKBtJS3JElicOHs98XHSTfo3
	 Xf+TLZJmO4kyw==
Date: Mon, 8 Jul 2024 14:52:43 +0100
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
Message-ID: <20240708135243.GA11898@willie-the-truck>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com>
 <20240705112502.GC9231@willie-the-truck>
 <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

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
> 
>  - the region between valid user addresses and kernel addresses is
> also always going to fault, and we don't have them adjacent to each
> other (unlike, for example, 32-bit i386, where the kernel address
> space is directly adjacent to the top of user addresses)

I think we're very similar on arm64. The kernel lives at the top (i.e.
virtual address space descends below 0) and is mapped by TTBR1.
Userspace lives at the bottom (i.e. virtual address space ascends from
0) and is mapped by TTBR0. There's an unaddressable gap in the middle
and it's bit 55 of the address which determines user vs kernel (well, it
selects the TTBR to be precise).

The kernel doesn't map the top 8MiB of its VA space, although talking to
Mark, it sounds like we might not be as robust as x86 if there's a stray
dereference of an unaligned error pointer that straddles 0. He can
elaborate, but we probably can't rely on a pointer of all-ones faulting
safely for the same reason.

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

Perhaps we could just force accesses with bit 55 set to the address
'1UL << 55'? That should sit slap bang in the middle of the guard
region between the TTBRs and I think it would resolve any issues we may
have with wrapping. It still means effectively reverting 2305b809be93
("arm64: uaccess: simplify uaccess_mask_ptr()"), though.

Dunno. Mark, Catalin, what do you guys reckon?

Will

