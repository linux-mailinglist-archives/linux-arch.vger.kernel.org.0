Return-Path: <linux-arch+bounces-6659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E36960C31
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A321C2879BB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ACA1C32E8;
	Tue, 27 Aug 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q+geZFdb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F61A00EE;
	Tue, 27 Aug 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765671; cv=none; b=gks1tWhzz/2aD27bUnCXJPrrDmjq+1XkysCFoAXNO9sFgU+lK78Pbq2kRALGH3oZJG9Wmg5pWkGq9MxXbkdGUQkHnduWKOoVS65m1n+pDSceBQGT/zNYBt9tQ6+Nw/sEOMVVyjcmfJVBZpcN28MmhZWk05uZIAQDQBcHu9CEZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765671; c=relaxed/simple;
	bh=G5clD8Optkw0MoCKh+T6nncwLBMLnao15yzQVBD2UyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUgxRKsKAp9+VMo2CEOtfZ4ijuBQU4DOdVsUkFniRaPuBGowaQH+67UcM8ZGExZ2pl6eqrzcs17eA2NuaIuU4fFalhuxb2KpQ572vJ7LZkqMeT2jYDsWS/OE/g+n50H5sdmLRoTb60LjNCnqWCil4Mpqb9Xn5TdvSZJwfLTGa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Q+geZFdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD927C61043;
	Tue, 27 Aug 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q+geZFdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724765667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXX7f47ZGvyfYVfZTOAIbEyIBS+BUEfdrN8TErecN44=;
	b=Q+geZFdbPMu7rSZ4x8XhBI4emfB05hMJcMdYsIGhwHySfBuHbhdQr8L55m3dY5D3kJEzXd
	1YJpYekLGGYWUybW4PeWnwrvH6WzgSzJPBtTG0hH7DR9g0l0QYuXiB6uOxnjOHQtPG3Wgd
	CpSHTbxThM8qNcQH4G5T7vaDXFDcjMs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 764f8b54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 13:34:26 +0000 (UTC)
Date: Tue, 27 Aug 2024 15:34:20 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Zs3V3FYwz57tyGgp@zx2c4.com>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <ZszlGPqfrULzi3KG@zx2c4.com>
 <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd3cd385-131a-43b2-8ce9-05547a4f2d1d@linaro.org>

On Tue, Aug 27, 2024 at 10:17:18AM -0300, Adhemerval Zanella Netto wrote:
> 
> 
> On 26/08/24 17:27, Jason A. Donenfeld wrote:
> > Hi Adhemerval,
> > 
> > Thanks for posting this! Exciting to have it here.
> > 
> > Just some small nits for now:
> > 
> > On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
> >> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> >> +{
> >> +	register long int x8 asm ("x8") = __NR_getrandom;
> >> +	register long int x0 asm ("x0") = (long int) buffer;
> >> +	register long int x1 asm ("x1") = (long int) len;
> >> +	register long int x2 asm ("x2") = (long int) flags;
> > 
> > Usually it's written just as `long` or `unsigned long`, and likewise
> > with the cast. Also, no space after the cast.
> 
> Ack.
> 
> > 
> >> +#define __VDSO_RND_DATA_OFFSET  480
> > 
> > This is the size of the data currently there?
> 
> Yes, I used the same strategy x86 did.
> 
> > 
> >>  #include <asm/page.h>
> >>  #include <asm/vdso.h>
> >>  #include <asm-generic/vmlinux.lds.h>
> >> +#include <vdso/datapage.h>
> >> +#include <asm/vdso/vsyscall.h>
> > 
> > Possible to keep the asm/ together?
> 
> Ack.
> 
> > 
> >> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> >> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
> > 
> > nonnce -> nonce
> 
> Ack.
> 
> > 
> >> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> >> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
> >>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
> >>  
> >>  TEST_GEN_PROGS := vdso_test_gettimeofday
> >> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> >>  TEST_GEN_PROGS += vdso_standalone_test_x86
> >>  endif
> >>  TEST_GEN_PROGS += vdso_test_correctness
> >> -ifeq ($(uname_M),x86_64)
> >> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
> >>  TEST_GEN_PROGS += vdso_test_getrandom
> >>  ifneq ($(SODIUM),)
> >>  TEST_GEN_PROGS += vdso_test_chacha
> > 
> > You'll need to add the symlink to get the chacha selftest running:
> > 
> >   $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
> >   $ git add tools/arch/arm64/vdso
> > 
> > Also, can you confirm that the chacha selftest runs and works?
> 
> Yes, last time I has to built it manually since the Makefile machinery seem 
> to be broken even on x86_64.  In a Ubuntu vm I have:
> 
> tools/testing/selftests/vDSO$ make
>   CC       vdso_test_gettimeofday
>   CC       vdso_test_getcpu
>   CC       vdso_test_abi
>   CC       vdso_test_clock_getres
>   CC       vdso_standalone_test_x86
>   CC       vdso_test_correctness
>   CC       vdso_test_getrandom
>   CC       vdso_test_chacha
> In file included from /home/azanella/Projects/linux/linux-git/include/linux/limits.h:7,
>                  from /usr/include/x86_64-linux-gnu/bits/local_lim.h:38,
>                  from /usr/include/x86_64-linux-gnu/bits/posix1_lim.h:161,
>                  from /usr/include/limits.h:195,
>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:205,
>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/syslimits.h:7,
>                  from /usr/lib/gcc/x86_64-linux-gnu/13/include/limits.h:34,
>                  from /usr/include/sodium/export.h:7,
>                  from /usr/include/sodium/crypto_stream_chacha20.h:14,
>                  from vdso_test_chacha.c:6:
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
>    99 | # if INT_MAX == 32767
>       |      ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
>   102 | #  if INT_MAX == 2147483647
>       |       ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
>   126 | # if LONG_MAX == 2147483647
>       |      ^~~~~~~~
> make: *** [../lib.mk:222: /home/azanella/Projects/linux/linux-git/tools/testing/selftests/vDSO/vdso_test_chacha] Error 1

You get that even with the latest random.git? I thought Christophe's
patch fixed that, but maybe not and I should just remove the dependency
on the sodium header instead.

Jason

