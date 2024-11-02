Return-Path: <linux-arch+bounces-8780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1C9BA16C
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3117BB21367
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E819DFAC;
	Sat,  2 Nov 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlpVtnzW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0B18A950;
	Sat,  2 Nov 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730565368; cv=none; b=l2OXKLCa9yCRYOglaZpcdTqMTq2Pxqc3c40MK6Nnhk5VlFRgZbEM/kpuf2nlV9TLmZRU7siiUZ2uDu001tVnzQB0RFykd3X8RFFMCvownrkuxnKOVtezqU+8HCE+yKJUaF6vE4G/s3qJ0HbK52c0/n7B9AqdLlSkrGrmS2LU6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730565368; c=relaxed/simple;
	bh=efn4VpG7p6xFb/S4X3ANPIQCQKp6IXfEyCLH0VWZIIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev5J0oIUoSY/6WxsGUBHCvomg4cp0QA1zzOyF6f6HPcwDyby8XlyttwgcHVmF99XN3ghSnQF1rvyZfgn3xLMAZd2AVj4fMqQYxE2Z/Jo3DAfbGedL5YSMeOM/3vR7f/QoehSBaPfHlJ47Q5DHrx2TOx/fM4Unm6co0duft/zO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlpVtnzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD1C4CEC3;
	Sat,  2 Nov 2024 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730565367;
	bh=efn4VpG7p6xFb/S4X3ANPIQCQKp6IXfEyCLH0VWZIIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlpVtnzWd/zB5XmFf980RxtRY6lt695NC4d5DAQWzdJq8P9d/vTpUIa9uhRZxXlNg
	 V1d2QzYc2hobwbFxK4fWDOeUmxR84BXOCx0bbPmSs0eqzXhWKKg5gbNDPcqLKd+ItV
	 0pXNaQHtN/eHmbiDg0Z7SgO8wxZv7vCv329kh8IFtCEPWR/9ZVZ4PS1sF2pFzadm7O
	 KR046MH/33qcHZt/KH+f3V2nu048roFu5R/+fD2mNhDgdzzAq87Tul2/R4s/yR1t+w
	 9f2q8hLJXw4bMrhpexvm+tOdexgGWME42h9ZVxDY348o62nZnpHwJGFG+M9IE+WQFR
	 2wSFp9BrXYOKQ==
Date: Sat, 2 Nov 2024 09:36:05 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
Message-ID: <20241102163605.GA28213@sol.localdomain>
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
 <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
 <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
 <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
 <ZyYIO6RpjTFteaxH@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyYIO6RpjTFteaxH@gondor.apana.org.au>

On Sat, Nov 02, 2024 at 07:08:43PM +0800, Herbert Xu wrote:
> On Sat, Nov 02, 2024 at 12:05:01PM +0100, Ard Biesheuvel wrote:
> >
> > The only issue resulting from *not* taking this patch is that btrfs
> > may misidentify the CRC32 implementation as being 'slow' and take an
> > alternative code path, which does not necessarily result in worse
> > performance.
> 
> If we were removing crc32* (or at least crc32*-arch) from the Crypto
> API then these patches would be redundant.  But if we're keeping them
> because btrfs uses them then we should definitely make crc32*-arch
> do the right thing.  IOW they should not be registered if they're
> the same as crc32*-generic.
> 
> Thanks,

I would like to eventually remove crc32 and crc32c from the crypto API, but it
will take some time to get all the users converted.  If there are AF_ALG users
it could even be impossible, though the usual culprit, iwd, doesn't appear to
use any CRCs, so hopefully we are fine there.

I will plan to keep this patch, but change it to use a crc32_optimizations()
function instead which was Ard's first suggestion.

I don't think Ard's static_call suggestion would work as-is, since considering
the following:

    static inline u32 __pure crc32_le(u32 crc, const u8 *p, size_t len)
    {
            if (IS_ENABLED(CONFIG_CRC32_ARCH))
                    return static_call(crc32_le_arch)(crc, p, len);
            return crc32_le_base(crc, p, len);
    }

... the 'static_call(crc32_le_arch)(crc, p, len)' will be inlined into every
user, which could be a loadable module which gets loaded after crc32-${arch}.ko.
And AFAIK, static calls in that module won't be updated in that case.

That could be avoided by making crc32_le() a non-inline function in lib/crc32.c,
so the static call would only be in that one place.  That has the slight
disadvantage that it would introduce an extra jump into the common case where
the optimized function is enabled.  Considering that some users are passing
small amounts of data into the CRC functions (e.g., 4 bytes), I would like to
minimize the overhead as much as possible.

It could also be avoided by making CRC32 and CRC32_ARCH bool rather than
tristate.  I would prefer not to do that, since there can be situations where
only loadable modules need these functions so they should not have to be built
into the core kernel.

So I plan to go with the crc32_optimizations() solution in v3.

- Eric

