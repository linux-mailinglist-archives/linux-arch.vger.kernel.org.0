Return-Path: <linux-arch+bounces-1510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081E83A7E4
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD324287FE1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532518EAD;
	Wed, 24 Jan 2024 11:32:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663117C77;
	Wed, 24 Jan 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095926; cv=none; b=jPM38Ds7A/kqxdQBXLbPFJhiyX/4hmWLyR/iHX4SBCQbcHOLrB2x/nOqQIADrANkn2Dhi4oB9BepRrci0eMpMd0am6PKpjUcZNwkDIM+z7P2e9yhD6gJggXSZQQGc/UI2beBMiKOCfRLDEmfBX4Uvt+aEo4hKIHuLV/FmygoTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095926; c=relaxed/simple;
	bh=EgKNRHpOgWf+/qADHiXv5UiBNLZ0Z100rmFMo//cXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6HOtyy332X80zUzKvRaHWCck3YNVUo+JmL09RjHenw2YNveVmlHya6a8zJ9ppUeNI5E8FQCZ3ko6x5kSuEfPeuXpMuVVuuB2IQx0CIA3WCpGZbGZ2qrDLgBDNWTefmgWAG+SkN1TzbbIi9G+duA9VphTHvDhVC40l5Y5yMp+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152841FB;
	Wed, 24 Jan 2024 03:32:49 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF243F762;
	Wed, 24 Jan 2024 03:32:02 -0800 (PST)
Date: Wed, 24 Jan 2024 11:31:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZbD1LT58ENj_dtj4@FVFF77S0Q05N.cambridge.arm.com>
References: <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <ZaffFMJy8cHOvtu8@FVFF77S0Q05N.cambridge.arm.com>
 <20240117152822.GI734935@nvidia.com>
 <20240117160528.GA3398@willie-the-truck>
 <20240118161843.GN734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118161843.GN734935@nvidia.com>

On Thu, Jan 18, 2024 at 12:18:43PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 04:05:29PM +0000, Will Deacon wrote:
> > On Wed, Jan 17, 2024 at 11:28:22AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 17, 2024 at 02:07:16PM +0000, Mark Rutland wrote:
> > > 
> > > > > I believe this is for the same reason as doing so in all of our other IO
> > > > > accessors.
> > > > > 
> > > > > We've deliberately ensured that our IO accessors use a single base register
> > > > > with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
> > > > > when reporting a stage-2 abort, which a hypervisor may use for emulating IO.
> > > > 
> > > > FWIW, IIUC the immediate-offset forms *without* writeback can still be reported
> > > > usefully in ESR_ELx, so I believe that we could use the "o" constraint for the
> > > > __raw_write*() functions, e.g.
> > > > 
> > > > static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> > > > {
> > > > 	asm volatile("str %x0, %1" : : "rZ" (val), "o" (*(volatile u64 *)addr));
> > > > }
> > > 
> > > "o" works well in the same simple memcpy loop:
> > > 
> > >         add     x2, x1, w2, uxtw 3
> > >         cmp     x1, x2
> > >         bcs     .L1
> > > .L3:
> > >         ldp     x10, x9, [x1]
> > >         ldp     x8, x7, [x1, 16]
> > >         ldp     x6, x5, [x1, 32]
> > >         ldp     x4, x3, [x1, 48]
> > >         str x10, [x0]
> > >         str x9, [x0, 8]
> > >         str x8, [x0, 16]
> > >         str x7, [x0, 24]
> > >         str x6, [x0, 32]
> > >         str x5, [x0, 40]
> > >         str x4, [x0, 48]
> > >         str x3, [x0, 56]
> > >         add     x1, x1, 64
> > >         add     x0, x0, 64
> > >         cmp     x2, x1
> > >         bhi     .L3
> > > .L1:
> > >         ret
> > > 
> > > Seems intersting to pursue?
> > 
> > I've seen the compiler struggle with plain "o" in the past ("Impossible
> > constraint in asm") so we might want "Qo" if we go down this route.
> 
> I'll stick a patch in 0-day and lets see if there are explosions. "Qo"
> generates the same assembly.
> 
> So to summarize:
>  - We don't like "m" because something about virtualization
>    traps breaks with post/pre indexed forms like:
>      str x1, [x0, 8]!
>    And "m" will allow the compiler to emit that. 
>  - o selects only base register plus offset so it is OK
>  - Q allows base register only (no offset) on some compilers that
>    won't allow o for 0 offset
>  - read side stays at 'r' due to an alternates errata workaround
>    requiring ldar which doesn't accept the same effective address
>    as ldr.

FWIW I've sent a patch out with a commit message describing all of the above
(with you, Catalin, Marc, and Will Cc'd). It hasn't appeared on lore yet, but
it should eventually show up at:

  https://lore.kernel.org/linux-arm-kernel/20240124111259.874975-1-mark.rutland@arm.com/

Mark.

