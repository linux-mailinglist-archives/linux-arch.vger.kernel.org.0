Return-Path: <linux-arch+bounces-2773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F386C6C9
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA522888FA
	for <lists+linux-arch@lfdr.de>; Thu, 29 Feb 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43F63CB5;
	Thu, 29 Feb 2024 10:24:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A360BA7;
	Thu, 29 Feb 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202292; cv=none; b=phWQ+yHtgnar1e7K2T7mAL2CNbieT8srYe4eYybTPl74ndI1dIc6SoKez2FTb62ZRHB8Jm/VATsTEXMFaxm5uEvkfQ61CwmqTIQGzaRzR6wxuCF0f4VL5AsYyKvn7jj094aGjM9A+V0lEUMZgZhQFa8PEJ6aayqWMK0m/W5sad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202292; c=relaxed/simple;
	bh=hjCiYmjmUqBlBGGPp3oOg+AOV4QZY5js4NzUUHbvtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpSpCL716rDR/Rk4lQFDYnYVRvB7PJJ1nnv8f8b6ypIdixJUDCLMPzcZGEyZifXjr3CZ+OLQ5AmEzrjD5U/eKEDGaGSImH8KK6eJigODk9q6Mgj+CXyPzzaETiG8K6YCpoJEpcj8OI7QHc6YiekXAct4cCJXIz0agyHuG7dHjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE5C433C7;
	Thu, 29 Feb 2024 10:24:45 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:24:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <ZeBbamDoHIxzzfof@arm.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <Zd27XtDg_NDzLXg-@arm.com>
 <20240228230616.GS13330@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228230616.GS13330@nvidia.com>

On Wed, Feb 28, 2024 at 07:06:16PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 27, 2024 at 10:37:18AM +0000, Catalin Marinas wrote:
> > On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> > > +/*
> > > + * This generates a memcpy that works on a from/to address which is aligned to
> > > + * bits. Count is in terms of the number of bits sized quantities to copy. It
> > > + * optimizes to use the STR groupings when possible so that it is WC friendly.
> > > + */
> > > +#define memcpy_toio_aligned(to, from, count, bits)                        \
> > > +	({                                                                \
> > > +		volatile u##bits __iomem *_to = to;                       \
> > > +		const u##bits *_from = from;                              \
> > > +		size_t _count = count;                                    \
> > > +		const u##bits *_end_from = _from + ALIGN_DOWN(_count, 8); \
> > > +                                                                          \
> > > +		for (; _from < _end_from; _from += 8, _to += 8)           \
> > > +			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> > > +		if ((_count % 8) >= 4) {                                  \
> > > +			__const_memcpy_toio_aligned##bits(_to, _from, 4); \
> > > +			_from += 4;                                       \
> > > +			_to += 4;                                         \
> > > +		}                                                         \
> > > +		if ((_count % 4) >= 2) {                                  \
> > > +			__const_memcpy_toio_aligned##bits(_to, _from, 2); \
> > > +			_from += 2;                                       \
> > > +			_to += 2;                                         \
> > > +		}                                                         \
> > > +		if (_count % 2)                                           \
> > > +			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > > +	})
> > 
> > Do we actually need all this if count is not constant? If it's not
> > performance critical anywhere, I'd rather copy the generic
> > implementation, it's easier to read.
> 
> Which generic version?

The current __iowriteXX_copy() in lib/iomap_copy.c (copy them over or
add some preprocessor reuse the generic functions).

> The point is to maximize WC effects with non-constant values, so I
> think we do need something like this. ie we can't just fall back to
> looping over 64 bit stores one at a time.

If that's a case you are also targeting and have seen it in practice,
that's fine. But I had the impression that you are mostly after the
constant count case which is already addressed by the other part of this
patch. For the non-constant case, we have a DGH only at the end of
whatever buffer was copied rather than after every 64-byte increments
you'd get for a count of 8.

> Most places I know about using this are performance paths, the entire
> iocopy infrastructure was introduced as an x86 performance
> optimization..

At least the x86 case makes sense even from a maintenance perspective,
it's just a much simpler "rep movsl". I just want to make sure we don't
over-complicate this code on arm64 unnecessarily.

-- 
Catalin

