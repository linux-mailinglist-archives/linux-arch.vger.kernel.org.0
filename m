Return-Path: <linux-arch+bounces-1512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187E83AA06
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B088EB27E78
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130D7764A;
	Wed, 24 Jan 2024 12:40:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24F77644;
	Wed, 24 Jan 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100034; cv=none; b=gEEm2nJZE6iUeUd6xqfONCXdHmyQp8/lyLTUrEj1djw2dpxuAGTkjA9N8G4Jl8R8Gepk32gCNBwo0Gr46waKmaAW4noV/kw2pIsDrpXxUDdWhOapQ2VJThhm1ly2nnEBBVlJNjmklH3nNNa11uivjW7rChG0YlvnV7h8ZFhwgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100034; c=relaxed/simple;
	bh=wo6XsibLwOR+jd/QsfUwpxOLmx80ZVdBfq6Q0z9wqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gORYCSOTLPg8DjcqcuUvUJsTAt+PAJhjCVkZ1EOhNpagIa62cermy0cUqTwigLLVbf8rQ+IFHqXJncmIuRxtfWC4rAtVFLxpYDtMM2PL1xjQdgsjLP7wlWOtHcDuPHTwdDL3gavYCFeW4wRgVXBvNSj+xr22w4Q6glECwtab0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2EFC433C7;
	Wed, 24 Jan 2024 12:40:31 +0000 (UTC)
Date: Wed, 24 Jan 2024 12:40:29 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZbEFPbT7vl6HN4lk@arm.com>
References: <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>

On Wed, Jan 24, 2024 at 11:38:07AM +0000, Mark Rutland wrote:
> On Tue, Jan 23, 2024 at 08:38:55PM +0000, Catalin Marinas wrote:
> > > On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > > > > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > > > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > > > > 
> > > > > > #define __raw_writeq __raw_writeq
> > > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > > {
> > > > > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > > > > }
> > > > > > 
> > > > > > Instead of
> > > > > > 
> > > > > > #define __raw_writeq __raw_writeq
> > > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > > {
> > > > > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > > > > }
> > > > > > 
> > > > > > ?? Like x86 has.
> > > > > 
> > > > > I believe this is for the same reason as doing so in all of our other IO
> > > > > accessors.
> > > > > 
> > > > > We've deliberately ensured that our IO accessors use a single base register
> > > > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > > > when reporting a stage-2 abort, which a hypervisor may use for
> > > > > emulating IO.
> > > > 
> > > > Wow, harming bare metal performace to accommodate imperfect emulation
> > > > sounds like a horrible reason :(
> > > 
> > > Having working functionality everywhere is a very good reason. :)
> > > 
> > > > So what happens with this patch where IO is done with STP? Are you
> > > > going to tell me I can't do it because of this?
> > > 
> > > I'm not personally going to make that judgement, but it's certainly something
> > > for Catalin and Will to consider (and I've added Marc in case he has any
> > > opinion).
> > 
> > Good point, I missed this part. We definitely can't use STP in the I/O
> > accessors, we'd have a big surprise when running the same code in a
> > guest with emulated I/O.
> 
> Just to be clear, that means we should drop this patch ("arm64/io: add
> memcpy_toio_64") for now, right?

In its current form yes, but that doesn't mean that memcpy_toio_64()
cannot be reworked differently.

> It would be helpful if we could explciitly say so in direct reply to that:
> 
>   https://lore.kernel.org/linux-arm-kernel/c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org/
> 
> ... to avoid any confusion there.

I will.

> > If eight STRs without other operations interleaved give us the
> > write-combining on most CPUs (with Normal NC), we should go with this
> > instead of STP.
> 
> Agreed; I've sent out a patch to allow the offset addressing at:
> 
>   https://lore.kernel.org/linux-arm-kernel/20240124111259.874975-1-mark.rutland@arm.com/
> 
> ... and it should be possible to build atop that to use eight STRs.

That's great, thanks.

-- 
Catalin

