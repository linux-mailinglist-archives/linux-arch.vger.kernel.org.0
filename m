Return-Path: <linux-arch+bounces-6632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459095FA97
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 22:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41AC1C21C0C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200A199EA1;
	Mon, 26 Aug 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="caZGUDrc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7158199397;
	Mon, 26 Aug 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704036; cv=none; b=px0NUX3zMqQu94yJK81ecYqNwtwfGz4iRVGBFtHQufbHBLRK3GWl0PasL7/yaWB3Nududa2i4prxzkZ1/NV0YtuF3WGqElumhq0/0PHFxzVjxH3R+LAHjSyic+rxDdilvRdX6EeWJZ1YB1RF0umfOlGOgmggZhRobnRg+axuZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704036; c=relaxed/simple;
	bh=FX345O6/JguLTF/FT4gs65xFBa2XvRMMwKnsN9PxgBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3+v2hNgT3RzxcjZQLa26bTuwKW+0sZaDIT6JC3Rg8uyoK6g7E1mO+jrLqyFz9rzbCB6u6AhZo0HJeE5PGn/fvKC/Sw3K6gYPFjMmluxM1kke5/CVNvBE1JvHRtzKBTz1VRdhB/Gxdtx8vRwVr6kcaG/8LMzW9PTmf6IPS2NjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=caZGUDrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D155C4DDF9;
	Mon, 26 Aug 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="caZGUDrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724704032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FEe3aKLdWuHYLE28CB3LaS38AzrFR6662Em9zizChs=;
	b=caZGUDrcn0gM8EL2MoGDV3cY3R3BGbgE+fhBXHKdGCtNPEsd9PwDV5a/S6A884nQ31c+Om
	rWKCQc9OQesSRecgUtNOhPJSWjAXeE4CaodO1T3DJ6Xu1XYG2q6jTeiSqBImGkUE2Mu8ug
	sTfJRxd05byZW0MfbngTj2GJVTxpdR4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5e04d8d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 20:27:11 +0000 (UTC)
Date: Mon, 26 Aug 2024 22:27:04 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZszlGPqfrULzi3KG@zx2c4.com>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826181059.111536-1-adhemerval.zanella@linaro.org>

Hi Adhemerval,

Thanks for posting this! Exciting to have it here.

Just some small nits for now:

On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> +{
> +	register long int x8 asm ("x8") = __NR_getrandom;
> +	register long int x0 asm ("x0") = (long int) buffer;
> +	register long int x1 asm ("x1") = (long int) len;
> +	register long int x2 asm ("x2") = (long int) flags;

Usually it's written just as `long` or `unsigned long`, and likewise
with the cast. Also, no space after the cast.

> +#define __VDSO_RND_DATA_OFFSET  480

This is the size of the data currently there?

>  #include <asm/page.h>
>  #include <asm/vdso.h>
>  #include <asm-generic/vmlinux.lds.h>
> +#include <vdso/datapage.h>
> +#include <asm/vdso/vsyscall.h>

Possible to keep the asm/ together?

> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes

nonnce -> nonce

> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>  
>  TEST_GEN_PROGS := vdso_test_gettimeofday
> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>  TEST_GEN_PROGS += vdso_standalone_test_x86
>  endif
>  TEST_GEN_PROGS += vdso_test_correctness
> -ifeq ($(uname_M),x86_64)
> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>  TEST_GEN_PROGS += vdso_test_getrandom
>  ifneq ($(SODIUM),)
>  TEST_GEN_PROGS += vdso_test_chacha

You'll need to add the symlink to get the chacha selftest running:

  $ ln -s ../../../arch/arm64/kernel/vdso tools/arch/arm64/vdso
  $ git add tools/arch/arm64/vdso

Also, can you confirm that the chacha selftest runs and works?

Jason

