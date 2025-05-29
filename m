Return-Path: <linux-arch+bounces-12143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13771AC8381
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07641BA2950
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D9233D86;
	Thu, 29 May 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE8FafhO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C020C469;
	Thu, 29 May 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748553418; cv=none; b=uVjK1ilo1hlViR3XEbg698u5MPs/s3MGXyQtSY05YPa58eqPBJk0r/esdZ5Uf4hSEGu+1N0YFN7V2w0qS4yyDQec0X4tdJl8A/5JTy9uTd+fEHDSAJ0IRnW4Bh4VDYL6n9tuiN44v9K15XQtEjLZd4QXeiK7QzNyvE7m1PuH16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748553418; c=relaxed/simple;
	bh=XwSNpCLmOFYgZlT+vqB/zkYXZoNvF9LKBVo7R5SnQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKzyoZxXP13Kv9lVMHX4rafLlUBf+c1feBxn0HrVF0Pr15kH/ZtPZCRhFQzIx3OqGwancjwnwqGg3KH1KBhWX0WUN89G5AePD8MmDqCrwKAfRWnhvQ3JqZpqF7JdZ2xs1rR5cFobK2Qip3UFqbJOx95gKBcgnP1xUIIZMS9LhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE8FafhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1369DC4CEE7;
	Thu, 29 May 2025 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748553416;
	bh=XwSNpCLmOFYgZlT+vqB/zkYXZoNvF9LKBVo7R5SnQvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE8FafhOJkbO0j8ajuGRE3oOAuSmqOSe7+1Bbv1xaRWE+GEqFHoQqKjHSPvlNvh8X
	 xaUXj42tdidF41Kr/O4VBBHdBcT46ME5JSAvysORACebdBaYt/za2ZLB9918zp+HG/
	 MnTpyOhxty75uU+RXJ/hyhZ6ZnSbvFM0C/SEeS/SzucQNcldj5qInocL0jscgQrZRV
	 HhOFx1gcMCLB7GCwEsyACsRzhuz4ZFAVektyXrTVvZu3lyC0ag9CwrjioZ4ERbFnpv
	 2HihaHdw1NUs7EO0PJ+YiMAi46LzXEFvynTHxRPB6/YcS/xwivV8yxQqvqZb39Kokc
	 VTl+yzDZkdWRA==
Date: Thu, 29 May 2025 14:16:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
Message-ID: <20250529211639.GD23614@sol>
References: <20250428170040.423825-1-ebiggers@kernel.org>
 <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com>
 <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>

On Thu, May 29, 2025 at 01:14:31PM -0700, Linus Torvalds wrote:
> On Thu, 29 May 2025 at 10:37, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Long-term, I'd like to find a clean way to consolidate the library code for each
> > algorithm into a single module.
> 
> No, while I think the current situation isn't great, I think the "make
> it one single module" is even worse.
> 
> For most architectures - including s390 - you end up being in the
> situation that these kinds of hw accelerated crypto things depend on
> some CPU capability, and aren't necessarily statically always
> available.
> 
> So these things end up having stupid extra overhead due to having some
> conditional.
> 
> That extra overhead is then in turn minimized with tricks like static
> branches, but that's all just just piling more ugly hacks on top
> because it picked a bad choice to begin with.
> 
> So what's the *right* thing to do?
> 
> The right thing to do is to just link the right routine in the first
> place, and *not* have static branch hackery at all. Because you didn't
> need it.
> 
> And we already do runtime linking at module loading time. So if it's a
> module, if the hardware acceleration doesn't exist, the module load
> should just fail, and the loader should go on to load the next option.

So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
similar), the current behavior is that ext4.ko depends on the crc32c_arch()
symbol.  That causes crc32-x86.ko to be loaded, which then depends on the
crc32c_base() symbol as a fallback, which causes crc32.ko to be loaded too.  My
idea is to consolidate the two crc32 modules into one (they always go together,
after all), keeping the same symbols.  The main challenge is just the current
directory structure.

Your suggestion sounds like: ext4.ko would depend on the crc32c() symbol, which
would be defined in *both* crc32-x86.ko and crc32.ko.  The module loader would
try to load crc32-x86.ko first.  If the CPU does not support any of the x86
accelerated CRC32 code, then loading that module would fail.  The module loader
would then load crc32.ko instead.

Does any of the infrastructure to handle "this symbol is in multiple modules and
they must be loaded in this particular order" actually exist, though?

And how do we avoid the issues the crypto API often has where the accelerated
modules don't get loaded, causing slow generic code to unnecessarily be used?

IMO this sounds questionable compared to just using static keys and/or branches,
which we'd need anyway to support the non-modular case.

> Not any silly "one module to rule them all" hackery that only results
> in worse code. Just a simple "if this module loads successfully,
> you'll link the optimal hw acceleration".
> 
> Now, the problem with this all is the *non*modular case.
> 
> For modules, we already have the optimal solution in the form of
> init-module error handling and runtime linking.
> 
> So I think the module case is "solved" (except the solution is not
> what we actually do).
> 
> For the non-module case, the problem is that "I linked this
> unconditionally, and now it turns out I run on hardware that doesn't
> have the capability to run this".
> 
> And that's when you need to do things like static_call_update() to
> basically do runtime re-linking of a static decision.
> 
> And currently we very much do this wrong. See how s390 and x86-64 (and
> presumably others) basically have the *exact* same problems, but they
> then mix static branches and static calls (in the case of x86-64) and
> just have non-optimal code in general.
> 
> What I think the generic code should do (for the built-in case) is just have
> 
>         DEFINE_STATIC_CALL(sha256_blocks_fn, sha256_blocks_generic);
> 
> and do
> 
>         static_call(sha256_blocks_fn)(args..);
> 
> and then architecture code can do the static_call_update() to set
> their optimal version.
> 
> And yeah, we'd presumably need multiple versions, since there's the
> whole "is simd usable" thing. Although maybe that's going away?

Moving the static_call into the generic code might make sense.  I don't think
it's a win in all cases currently, though.  Only x86 and PPC32 actually have a
real static_call implementation; everywhere else it's an indirect call which is
slower than a static branch.  Also, some arch code is just usable
unconditionally without any CPU feature check, e.g. the MIPS ChaCha code.  That
doesn't use (or need to use) a static call or branch at all.

Also, while the centralized static_call would *allow* for the generic code to be
loaded while the arch code is not, in the vast majority of cases that would be a
bug, not a feature.  The generic crypto infrastructure has that bug, and this
has caused a huge amount of pain over the years.  People have to go out of the
way to ensure that the arch-optimized crypto code gets loaded.  And they often
forget, resulting in the slow generic code being used unnecessarily...

Making the arch-optimized code be loaded through a direct symbol dependency
solves that problem.

- Eric

