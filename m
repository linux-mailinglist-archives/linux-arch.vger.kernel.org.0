Return-Path: <linux-arch+bounces-1390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBF830717
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F12E1C218DE
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DB1EB52;
	Wed, 17 Jan 2024 13:29:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792D1EB4D;
	Wed, 17 Jan 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498156; cv=none; b=CONC88Acykk7MV4ZzprX7BRtA77+Zwy/nrKeqTyZpZu4NNqpiMk0Tuq+kHMnW498VtPH3oOVv/QR01Nwqtc/n1rPKrfsvav7l/fZoNZf8L+bpJ3pFMAwVHH9zyAfrTaxPd0t6NXqjPZVeX6P3q67mUCzyrI6DxuCBHOAUujiX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498156; c=relaxed/simple;
	bh=wmftHWH3KaorsSLrZIoCv5IVtznzJwlxmULTp1hsZw8=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=kpxbL2wG/CVS0PsLho/k7whTdLlT5m1Pqao2ITKNVjXsMh7GdDeA6J9SDIhCTuMArdJbH0AamC6t5QW8ReTvLFZaUVm3gOQ4yFx0DWdwjcdpH+IQR0v0abv+ko+rNm0Bwi5int/a3WcnVSA0u/TiqBINgj6jr1KVC1KXQhaWPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C492B11FB;
	Wed, 17 Jan 2024 05:30:00 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC4F3F766;
	Wed, 17 Jan 2024 05:29:12 -0800 (PST)
Date: Wed, 17 Jan 2024 13:29:06 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.or>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
References: <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117123618.GD734935@nvidia.com>

On Wed, Jan 17, 2024 at 08:36:18AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 12:30:00PM +0000, Mark Rutland wrote:
> > On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> > > Hey Catalin,
> > > 
> > > I'm just revising this and I'm wondering if you know why ARM64 has this:
> > > 
> > > #define __raw_writeq __raw_writeq
> > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > {
> > > 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > > }
> > > 
> > > Instead of
> > > 
> > > #define __raw_writeq __raw_writeq
> > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > {
> > > 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> > > }
> > > 
> > > ?? Like x86 has.
> > 
> > I believe this is for the same reason as doing so in all of our other IO
> > accessors.
> > 
> > We've deliberately ensured that our IO accessors use a single base register
> > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > when reporting a stage-2 abort, which a hypervisor may use for
> > emulating IO.
> 
> Wow, harming bare metal performace to accommodate imperfect emulation
> sounds like a horrible reason :(

Having working functionality everywhere is a very good reason. :)

> So what happens with this patch where IO is done with STP? Are you
> going to tell me I can't do it because of this?

I'm not personally going to make that judgement, but it's certainly something
for Catalin and Will to consider (and I've added Marc in case he has any
opinion).

Mark.

