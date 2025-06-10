Return-Path: <linux-arch+bounces-12327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15660AD42AB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1E6189F7AD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248C261575;
	Tue, 10 Jun 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaI2+LQh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602D218E9F;
	Tue, 10 Jun 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582753; cv=none; b=Y9d2AOnjpwkR3Ix4TRd7fzgyUqliv2eVB1Y8TNcPiCMjO9ngEfGGkRHPqyQoVrLSSK0JyXMZoK4Qeewr7RWMxr9O6VJ9U6ZLDZ86qSsbnauB++WCR7OYEpMA0Rn0spbbrBl3y4Orh5RbMBDdsJ15Uf61XNx9wkug5x7S/Fs55Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582753; c=relaxed/simple;
	bh=eJzXTcGjqeHES133w/mCLelMBBcBENx890a5ygHX1H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHaF+aoyjaDEUgviO+ViaLFYIjW1ccVLgCGid33HWm5HPCE1FdWYH/8fpGEE1roEol8pE42FfmCznR76nWwWbh0BL6mTU/effjRQ7BcyKUEc/Yt1Zn7k/PmnExZHo9YDcAb4M5zMq1oDIn9TSvsQ4dSkDlf5KMR7NzIF/pZNuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaI2+LQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FAEC4CEED;
	Tue, 10 Jun 2025 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582752;
	bh=eJzXTcGjqeHES133w/mCLelMBBcBENx890a5ygHX1H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaI2+LQhuUUCHinnXIKNJGDX1SFqmIEkgM49ZG9mFtgdSJtyidxE5kSPaTUdtIRoe
	 x8gwG8h5JFpcv2x49bFujV90PS+vJ0dv/ZdkpuflWTUErcb97YgGQv2W6l9qVPbl16
	 v8SyhbEe0m3HO6534SqykjGShxll+Ne/4t8f1iJYheRExnhSX55A4hNPQKnkRcYq5L
	 hc0Tmlxcb6hRLqfqF7Unr6UlRwwPll4NW5PiZ7zHf35KF4TOdiyOcT86XrweAAiuH8
	 NHMgbbCpwoQbMy2vS7ZoKum77mLaoScoDb3mUTDNNDNTl+qp1ZRyBmI7CkispOKzd9
	 LnPbDInTrzhvw==
Date: Tue, 10 Jun 2025 12:12:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <20250610191208.GD1649@sol>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <aETPdvg8qXv18MDu@zx2c4.com>
 <20250608234817.GG1259@sol>
 <aEhtyvBajGE80_2Z@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhtyvBajGE80_2Z@zx2c4.com>

On Tue, Jun 10, 2025 at 11:39:22AM -0600, Jason A. Donenfeld wrote:
> On Sun, Jun 08, 2025 at 04:48:17PM -0700, Eric Biggers wrote:
> > On Sat, Jun 07, 2025 at 05:47:02PM -0600, Jason A. Donenfeld wrote:
> > > On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:
> > > > Having arch-specific code outside arch/ was somewhat controversial when
> > > > Zinc proposed it back in 2018.  But I don't think the concerns are
> > > > warranted.  It's better from a technical perspective, as it enables the
> > > > improvements mentioned above.  This model is already successfully used
> > > > in other places in the kernel such as lib/raid6/.  The community of each
> > > > architecture still remains free to work on the code, even if it's not in
> > > > arch/.  At the time there was also a desire to put the library code in
> > > > the same files as the old-school crypto API, but that was a mistake; now
> > > > that the library is separate, that's no longer a constraint either.
> > > 
> > > I can't express how happy I am to see this revived. It's clearly the
> > > right way forward and makes it a lot simpler for us to dispatch to
> > > various arch implementations and also is organizationally simpler.
> > > 
> > > Jason
> > 
> > Thanks!  Can I turn that into an Acked-by?
> 
> Took me a little while longer to fully review it. Sure,
> 
>     Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Side note: I wonder about eventually turning some of the static branches
> into static calls.

Yes, Linus was wondering the same thing earlier.  It does run into a couple
issues.  First, only x86 and powerpc implement static_call properly; everywhere
else it's just an indirect call.  Second, there's often some code shared above
the level at which we'd like to do the dispatch.  For example, consider crc32_le
on x86.  If we expand the CRC_PCLMUL macro and inline crc32_le_arch and
crc32_le_base as the compiler does, crc32_le ends up as:

    u32 crc32_le(u32 crc, const u8 *p, size_t len)
    {
            if (len >= 16 && static_branch_likely(&have_pclmulqdq) &&
                crypto_simd_usable()) {
                    const void *consts_ptr;

                    consts_ptr = crc32_lsb_0xedb88320_consts.fold_across_128_bits_consts;
                    kernel_fpu_begin();
                    crc = static_call(crc32_lsb_pclmul)(crc, p, len, consts_ptr);
                    kernel_fpu_end();
                    return crc;
            }
            while (len--)
                    crc = (crc >> 8) ^ crc32table_le[(crc & 255) ^ *p++];
            return crc;
    }

The existing static_call selects between 3 different assembly functions, all of
which require a kernel-mode FPU section and only support len >= 16.

We could instead unconditionally do a static_call upon entry to the function,
with 4 possible targets.  But then we'd have to duplicate the kernel FPU
begin/end sequence in 3 different functions.  Also, it would add an extra
function call for the case where 'len < 16', which is a common case and is
exactly the case where per-call overhead matters the most.

However, if we could actually inline the static call into the *callers* of
crc32_le(), that would make it more worthwhile.  I'm not sure that's possible,
though, especially considering that this code is tristate.

Anyway, this is tangential to this patchset.  Though the new way the code is
organized does make it more feasible to have e.g. a centralized static_call in
the future if we choose to go in that direction.

- Eric

