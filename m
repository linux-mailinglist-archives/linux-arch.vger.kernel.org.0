Return-Path: <linux-arch+bounces-1511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97783A80C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CC01F2360A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482361AAB1;
	Wed, 24 Jan 2024 11:38:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A21B801;
	Wed, 24 Jan 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096294; cv=none; b=V/LO5Dc+mSDr9PjpKTHI4qkqqpCXqVKikyEI1kvjVDK8zChgINPYDZjPHbbmUqf47AtnrJr3IrKF0GiPSthw9P2NS4k6CIwD8vc8qGcoAAVTOGcK7smGd7vHubSxXdYHwyHAiBEFAdxvgpOAXttO82zC1536C1dPbQkZlY5h+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096294; c=relaxed/simple;
	bh=rGi5VSWqsbwT+MYHargPy39iHlfOzSbVYABYIYt8lQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMRrLpD1Ef/AHJDQKQsbt+M+UYQNoij2pNyDi61KORbxgsJi+3BHDViGDOw2RJJw1bxILUwy4NkpcHvHpmgkTJEklQ5mOQKxIhWImQyCrBTkgkIPsA7zTliwbTef0MIpUi9z0F119Z1FtncrBRqu6+rS7oLnlYQgEPx7JF8O854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B1B1FB;
	Wed, 24 Jan 2024 03:38:56 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA85A3F762;
	Wed, 24 Jan 2024 03:38:09 -0800 (PST)
Date: Wed, 24 Jan 2024 11:38:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
References: <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbAj34vdVuMrmdFD@arm.com>

On Tue, Jan 23, 2024 at 08:38:55PM +0000, Catalin Marinas wrote:
> (fixed Marc's email address)
> 
> On Wed, Jan 17, 2024 at 01:29:06PM +0000, Mark Rutland wrote:
> > On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > > > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > > > 
> > > > > #define __raw_writeq __raw_writeq
> > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > {
> > > > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > > > }
> > > > > 
> > > > > Instead of
> > > > > 
> > > > > #define __raw_writeq __raw_writeq
> > > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > > {
> > > > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > > > }
> > > > > 
> > > > > ?? Like x86 has.
> > > > 
> > > > I believe this is for the same reason as doing so in all of our other IO
> > > > accessors.
> > > > 
> > > > We've deliberately ensured that our IO accessors use a single base register
> > > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > > when reporting a stage-2 abort, which a hypervisor may use for
> > > > emulating IO.
> > > 
> > > Wow, harming bare metal performace to accommodate imperfect emulation
> > > sounds like a horrible reason :(
> > 
> > Having working functionality everywhere is a very good reason. :)
> > 
> > > So what happens with this patch where IO is done with STP? Are you
> > > going to tell me I can't do it because of this?
> > 
> > I'm not personally going to make that judgement, but it's certainly something
> > for Catalin and Will to consider (and I've added Marc in case he has any
> > opinion).
> 
> Good point, I missed this part. We definitely can't use STP in the I/O
> accessors, we'd have a big surprise when running the same code in a
> guest with emulated I/O.

Just to be clear, that means we should drop this patch ("arm64/io: add
memcpy_toio_64") for now, right?

It would be helpful if we could explciitly say so in direct reply to that:

  https://lore.kernel.org/linux-arm-kernel/c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org/

... to avoid any confusion there.
  
> If eight STRs without other operations interleaved give us the
> write-combining on most CPUs (with Normal NC), we should go with this
> instead of STP.

Agreed; I've sent out a patch to allow the offset addressing at:

  https://lore.kernel.org/linux-arm-kernel/20240124111259.874975-1-mark.rutland@arm.com/

... and it should be possible to build atop that to use eight STRs.

Mark.

