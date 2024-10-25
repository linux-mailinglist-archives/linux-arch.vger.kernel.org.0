Return-Path: <linux-arch+bounces-8578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DC9B119B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B712F282E98
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF351B21B1;
	Fri, 25 Oct 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui6KR0kd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E1217F4C;
	Fri, 25 Oct 2024 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891965; cv=none; b=LAHP55paYZmDyzQ4gd3K408NnPAh+izMouT/QUmNlWjF9aL/MAiqOMO6er0faQ2SwrBJQCM6wgnk8txUfgET6CcKkdLEN7G5HQJ9QmSrEE4NegOsZTLszcy1NuLk619UGUK9XrYTXmdmZ5i7s9vaEj0udFP88Egp4onHk6X6QXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891965; c=relaxed/simple;
	bh=karHkl1P4MymVDmMVIm5W0oSGt8WGS2RI4WaZcDwTEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU5U0MzS5jL5uFxtZ2NgdRNtz4C+pso7HBPQi8kFpNn6T0MfbqpiaPD5SAR+lpUY1BEV5wb1PCv9Eby76P9vDxWoYRlraMsbOuZcbi0A8okrFvxA5uFe2p0ZFCyOK9hy6Nns2HF/pL5RP+s0SDl13MjMOuOa6Js+xqSocK6LNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui6KR0kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6D5C4CEC3;
	Fri, 25 Oct 2024 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729891964;
	bh=karHkl1P4MymVDmMVIm5W0oSGt8WGS2RI4WaZcDwTEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ui6KR0kdPRYlpScOp15X+unLeIAbNEI3oGX0lXMaIurlD0BJ0jl9m7sv68bFBvJ8X
	 CgmQy4NmGULJhNReu42xHOOaMDZWh8rDiJMHw/GnKiiye07KV68euQMU+mVNPy6Dh5
	 q+2Nla53/DZid3rdBbpBsYfaayka1Upsz7x35RnBCM/7/4Qef0Iy4By75QnYsA9YNP
	 PwOXPfwaV3rNp69SYU+sRoFrITlEHpzt+P0+Cem8hn3H149Vz/ognobz0PrT4BXTc/
	 bchtyRCSYWd93GuJXbMaRcdctbFVLfRi2xAODovc57JIf5w8iiwde7M2cD6qqrEeer
	 AmGpk7Tij3AcQ==
Date: Fri, 25 Oct 2024 21:32:43 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 03/18] lib/crc32: expose whether the lib is really
 optimized at runtime
Message-ID: <20241025213243.GA2637569@google.com>
References: <20241025191454.72616-1-ebiggers@kernel.org>
 <20241025191454.72616-4-ebiggers@kernel.org>
 <CAMj1kXFoer+_yZJWtqBVYfYnzqL9X9bbBRomCL3LDqRcYJ6njQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFoer+_yZJWtqBVYfYnzqL9X9bbBRomCL3LDqRcYJ6njQ@mail.gmail.com>

On Fri, Oct 25, 2024 at 10:32:14PM +0200, Ard Biesheuvel wrote:
> On Fri, 25 Oct 2024 at 21:15, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Make the CRC32 library export some flags that indicate which CRC32
> > functions are actually executing optimized code at runtime.  Set these
> > correctly from the architectures that implement the CRC32 functions.
> >
> > This will be used to determine whether the crc32[c]-$arch shash
> > algorithms should be registered in the crypto API.  btrfs could also
> > start using these flags instead of the hack that it currently uses where
> > it parses the crypto_shash_driver_name.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  arch/arm64/lib/crc32-glue.c  | 15 +++++++++++++++
> >  arch/riscv/lib/crc32-riscv.c | 15 +++++++++++++++
> >  include/linux/crc32.h        | 15 +++++++++++++++
> >  lib/crc32.c                  |  5 +++++
> >  4 files changed, 50 insertions(+)
> >
> ...
> > diff --git a/include/linux/crc32.h b/include/linux/crc32.h
> > index 58c632533b08..bf26d454b60d 100644
> > --- a/include/linux/crc32.h
> > +++ b/include/linux/crc32.h
> > @@ -35,10 +35,25 @@ static inline u32 __pure __crc32c_le(u32 crc, const u8 *p, size_t len)
> >         if (IS_ENABLED(CONFIG_CRC32_ARCH))
> >                 return crc32c_le_arch(crc, p, len);
> >         return crc32c_le_base(crc, p, len);
> >  }
> >
> > +/*
> > + * crc32_optimizations contains flags that indicate which CRC32 library
> > + * functions are using architecture-specific optimizations.  Unlike
> > + * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
> > + * variants and also whether any needed CPU features are available at runtime.
> > + */
> > +#define CRC32_LE_OPTIMIZATION  BIT(0) /* crc32_le() is optimized */
> > +#define CRC32_BE_OPTIMIZATION  BIT(1) /* crc32_be() is optimized */
> > +#define CRC32C_OPTIMIZATION    BIT(2) /* __crc32c_le() is optimized */
> > +#if IS_ENABLED(CONFIG_CRC32_ARCH)
> > +extern u32 crc32_optimizations;
> > +#else
> > +#define crc32_optimizations 0
> > +#endif
> > +
> 
> Wouldn't it be cleaner to add a new library function for this, instead
> of using a global variable?

The architecture crc32 modules need to be able to write to this.  There could be
a setter function and a getter function, but just using a variable is simpler.

- Eric

