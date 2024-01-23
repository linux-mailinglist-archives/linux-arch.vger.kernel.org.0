Return-Path: <linux-arch+bounces-1489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5738839A64
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 21:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB62901A8
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3C210D;
	Tue, 23 Jan 2024 20:39:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628220F1;
	Tue, 23 Jan 2024 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042341; cv=none; b=TMf3+AA+jsblj8M5dTsw965VIb/B56yODi2zEho/3oqPF9A9I3zi77DcEBT3l55uwYstsOm0rqEf62S/HNoeWb1Cp7hoKpyAIdnF0mqh1BZYbsh9TFjDpj3AccnitmBk/8EgZYBNbRZOz6LyulCUTvhXpt4ZoAiunbpC70+lwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042341; c=relaxed/simple;
	bh=fq71BbN1ywaZ7F7VI6egXeKgKsL9xoL1DO3pGojEhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdH5OACgckD7mxnc+QJ5FKjBvlXfcc9511ELA1a8/og6bVBaL2Pi21fe4PiKKpic/1DsOZULRI6b8gd2KuZy9BL7NScina7l4TQLQjK84PPlM04ENOwi/SDaBc4B7QjeqIhDVk3LCQeFcXh4tWNS809WbkJMQC98ejzJ4iOABJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0E9C433F1;
	Tue, 23 Jan 2024 20:38:58 +0000 (UTC)
Date: Tue, 23 Jan 2024 20:38:55 +0000
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
Message-ID: <ZbAj34vdVuMrmdFD@arm.com>
References: <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>

(fixed Marc's email address)

On Wed, Jan 17, 2024 at 01:29:06PM +0000, Mark Rutland wrote:
> On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > > 
> > > > #define __raw_writeq __raw_writeq
> > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > {
> > > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > > }
> > > > 
> > > > Instead of
> > > > 
> > > > #define __raw_writeq __raw_writeq
> > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > {
> > > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > > }
> > > > 
> > > > ?? Like x86 has.
> > > 
> > > I believe this is for the same reason as doing so in all of our other IO
> > > accessors.
> > > 
> > > We've deliberately ensured that our IO accessors use a single base register
> > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > when reporting a stage-2 abort, which a hypervisor may use for
> > > emulating IO.
> > 
> > Wow, harming bare metal performace to accommodate imperfect emulation
> > sounds like a horrible reason :(
> 
> Having working functionality everywhere is a very good reason. :)
> 
> > So what happens with this patch where IO is done with STP? Are you
> > going to tell me I can't do it because of this?
> 
> I'm not personally going to make that judgement, but it's certainly something
> for Catalin and Will to consider (and I've added Marc in case he has any
> opinion).

Good point, I missed this part. We definitely can't use STP in the I/O
accessors, we'd have a big surprise when running the same code in a
guest with emulated I/O.

If eight STRs without other operations interleaved give us the
write-combining on most CPUs (with Normal NC), we should go with this
instead of STP.

-- 
Catalin

