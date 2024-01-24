Return-Path: <linux-arch+bounces-1522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843D83AFBC
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 18:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2131928CD25
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C186135;
	Wed, 24 Jan 2024 17:22:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53C7F7C4;
	Wed, 24 Jan 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116931; cv=none; b=rfDPAmaj1SN0xGkjEb9LtL7uNgiYXJij9QwQN2YtVJD8gig+y0OtbmFFYSuqzDLWAdfspr9S6sNe82b7g3E+k5EYt5n9T/lo8WLZaJUyelKjiy/bYpTTX++Y8BzSo21cl7D0zWqM1ItjvmesPtW31/gDqLTfJ8phAQsDv8nDenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116931; c=relaxed/simple;
	bh=S1PhJcaN20LtKXfwXDa/CLbEgNUETEehcQgb+fXeUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzA3wPxPaUx019Me2QrBdVZNElSm+7Y4+t1wTEZRqp3/5CxAOxlrRCu/TQfDpo7kuVBKca8/lnm9Dkxv49e6th0Ddz68+89D3UwJQKrEeJ7UqqFabDbKHypPBGLlLz8m1rJeBPYaaM6vKYb9p0mlWamEUuYeQmNbZdjzq0NNc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE2AC433F1;
	Wed, 24 Jan 2024 17:22:08 +0000 (UTC)
Date: Wed, 24 Jan 2024 17:22:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZbFHPTUaBmbHYnwx@arm.com>
References: <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
 <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
 <20240117123618.GD734935@nvidia.com>
 <ZafWIsrjvk--JdDn@FVFF77S0Q05N.cambridge.arm.com>
 <ZbAj34vdVuMrmdFD@arm.com>
 <ZbD2n-BKGbDgMfsB@FVFF77S0Q05N.cambridge.arm.com>
 <ZbEFPbT7vl6HN4lk@arm.com>
 <20240124132719.GF1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124132719.GF1455070@nvidia.com>

On Wed, Jan 24, 2024 at 09:27:19AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 24, 2024 at 12:40:29PM +0000, Catalin Marinas wrote:
> 
> > > Just to be clear, that means we should drop this patch ("arm64/io: add
> > > memcpy_toio_64") for now, right?
> > 
> > In its current form yes, but that doesn't mean that memcpy_toio_64()
> > cannot be reworked differently.
> 
> I gave up on touching memcpy_toio_64(), it doesn't work very well
> because of the weak alignment
> 
> Instead I followed your suggestion to fix __iowrite64_copy()

I forgot the details. Was it to introduce an __iowrite512_copy()
function or to simply use __iowrite64_copy() with a count of 8?

> There are only a couple of places that use this API:
[...]
> __iowrite64_copy() has a sufficient API that the compiler can inline
> the STP block as this patch did.
> 
> I experimented with having memcpy_toio_64() invoke __iowrite64_copy(),
> but it did not look very nice. Maybe there is a possible performance
> win there, I don't know.

Just invoking __iowrite64_copy() with a count of 8 wouldn't work well
even if we have the writeq generating STR with an offset (well, it also
increments the pointers, so I don't think Mark's optimisation would
help). The copy implies loads and these would be interleaved with stores
and potentially get in the way of write combining. An
__iowrite512_copy() or maybe even an optimised __iowrite64_copy() for
count 8 could do the loads first followed by the stores. You can use a
special path in __iowrite64_copy() with __builtin_contant_p().

You can try with an arm64 specific __iowrite64_copy() and see how it
goes (together with Mark's patch):

void __iowrite64_copy(void __iomem *to, const void *from,
		      size_t count)
{
	u64 __iomem *dst = to;
	const u64 *src = from;
	const u64 *end = src + count;

	/*
	 * Try a 64-byte write, the CPUs tend to write-combine them.
	 */
	if (__builtin_contant_p(count) && count == 8) {
		__raw_writeq(*src, dst);
		__raw_writeq(*(src + 1), dst + 1);
		__raw_writeq(*(src + 2), dst + 2);
		__raw_writeq(*(src + 3), dst + 3);
		__raw_writeq(*(src + 4), dst + 4);
		__raw_writeq(*(src + 5), dst + 5);
		__raw_writeq(*(src + 6), dst + 6);
		__raw_writeq(*(src + 7), dst + 7);
		return;
	}

	while (src < end)
		__raw_writeq(*src++, dst++);
}
EXPORT_SYMBOL_GPL(__iowrite64_copy);

What we don't have is inlining of __iowrite64_copy() but if we need that
we can move away from a weak symbol to a static inline.

Give this a go and see if it you get write-combining in your hardware.
If the loads interleaves with stores get in the way, maybe we can resort
to inline asm.

-- 
Catalin

