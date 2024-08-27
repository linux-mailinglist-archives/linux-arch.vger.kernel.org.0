Return-Path: <linux-arch+bounces-6652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF709604E5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8932831ED
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B8198A19;
	Tue, 27 Aug 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D1/WZsrs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3C1EEE0;
	Tue, 27 Aug 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748833; cv=none; b=F0Pjn1J4lTomXyYIYyc+XYJik9/BwGyMtS9C3Ew/M3xGFlJ4o0ujoBT9fEB1D4iF92IJyYpApy+7tinfaLER5ArMnf69mFWAosZ/VpInJH/U5rXGY8R7Owej8La8aDgGXUoYIGJRWMQ8rWmpRjdFcAvkctITGgmk5XBJMcGODD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748833; c=relaxed/simple;
	bh=uJh1BECLYykryv2qkUmuuEWHi81HJAVxT6K2ErkpGBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/umhVVogkXmL4DohR93571eBQydtSr5hdBWur6wQzrY1J2tj7Ud2SoSXPTca23Bx7F6wrgEVixKpxJCcCCPPKl9coR/OsmERdojzKu/8ZGdNr0NyOGywViuRQEXPdxsNUPBPKGXleFY2fFpS1fTt4fc4sfYS+pzPa0a5r2MwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=D1/WZsrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2810FC8B7A1;
	Tue, 27 Aug 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D1/WZsrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724748829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hhZkFRC4BoRf7DDoYQ5LMerp2DKl7zuwL0hrKx7OfYM=;
	b=D1/WZsrsVBICInECxaAzM5ZzLnpcUbffHSeTWi1jkL1GMpaIbPFop5qpynTi5PTWOs31yJ
	r4mn5bQmbf/biAOcwdYkekFC9FzuPx8Hk3lNftQPPRwYnYoE7iNviSJlmUQCVdXagvnCrc
	r/hXqQrO7oZDFWP5u9smem6JjbbRGfs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 318679ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 08:53:49 +0000 (UTC)
Date: Tue, 27 Aug 2024 10:53:44 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Zs2UGH6xjJmis5XD@zx2c4.com>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu>

On Tue, Aug 27, 2024 at 10:46:21AM +0200, Christophe Leroy wrote:
> > +/**
> > + * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
> > + * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
> > + * @key:	32-byte input key.
> > + * @counter:	8-byte counter, read on input and updated on return.
> > + * @nblocks:	Number of blocks to generate.
> > + *
> > + * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
> > + * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
> > + * leaking into forked child processes.
> > + */
> > +extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
> 
> For Jason: We all redefine this prototype, should we have it in a 
> central place, or do you expect some architecture to provide some static 
> inline for it ?

Given the doc comment and such, that would be nice. But I didn't see a
straight forward way of doing that when I tried before. If you want to
try and send another fixup commit, that'd be welcomed.

> > +#define __VDSO_RND_DATA_OFFSET  480
> > +
> 
> How is this offset calculated or defined ? What happens if the other 
> structures grow ? Could you use some sizeof(something) instead of 
> something from asm-offsets if you also need it in ASM ?

FYI, there's a similar static calculation like this in the x86 code:

+#if !defined(_SINGLE_DATA)
+#define _SINGLE_DATA
+DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+#endif

> >   uname_M := $(shell uname -m 2>/dev/null || echo not)
> > -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> > +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
> 
> >   SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
> >   
> >   TEST_GEN_PROGS := vdso_test_gettimeofday
> > @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> >   TEST_GEN_PROGS += vdso_standalone_test_x86
> >   endif
> >   TEST_GEN_PROGS += vdso_test_correctness
> > -ifeq ($(uname_M),x86_64)
> > +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
> 
> Does that work for you when you cross-compile ? For powerpc when I cross 
> compile I still get the x86_64 from uname_M here, which is unexpected.

That sounds like a legitimate bug you're pointing out, but not one with
Adhemerval's code, right? Rather, it's something to be fixed inside of
these self tests as a whole?

Jason

