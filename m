Return-Path: <linux-arch+bounces-6825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F356B9650E5
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2781285837
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252731662F1;
	Thu, 29 Aug 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vv8R8Q3z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A73156F41;
	Thu, 29 Aug 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964386; cv=none; b=WZeZ7o9qr5YrUwM8hZDsNEqU0Wrh7M9mX1lM0Ba2Mpl0HXl7SDtPjQTqgOBxN1xEIar+iNqFox67L6OIPem4e2gGeLu/taE8i2zxNa3+Y+xgXbjUyA/3nij9Rcx2wWIAbhmyFmPv2I6c60se1jDWNo/Qc+wZSsezsn5Gam8eSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964386; c=relaxed/simple;
	bh=sz6bfXs+WP0Ejzb1cu2NDB1RHCuklbR3uaZZtR0pUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2l/UWPhafFrO0x5AKqZrDVJ+31xFbvHuSWCD5hmvZAk5ar3KsAeqDnpHllTf2BmyKs+yyAqet2zuZ01Q+2sDAOE8EXT6DERbh/S1DAIlj9eGK+aG4lUMFp66oy9tiXjiwHtA+5WfBclbFIhB8SJFJ7DXcqYzjQID1qjyXjI79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Vv8R8Q3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35297C4CEC1;
	Thu, 29 Aug 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vv8R8Q3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724964382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzYDFZGf2D5cZoFoVdkeZRMawcANUGavo1EP8gkyRN0=;
	b=Vv8R8Q3z+7wPzTo9eIO+3m5iei8oI72IZPwUa8plD03Ut0uV8cLK836ZWfGlhCUOeSA201
	mD56+sbS0UJOQuJe4YO93tBXgz2Qfy77h0SrQhS7kGLLr9qzCurqHPt6FMKwx8RN+5Q5cG
	S9Mf7yO4HBoYD07/Fv9N092aS0vlU8A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2ad44a09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 20:46:22 +0000 (UTC)
Date: Thu, 29 Aug 2024 22:46:17 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtDeGbgdpeI082i6@zx2c4.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>

Hi Catalin, Will, Adhemerval,

On Thu, Aug 29, 2024 at 08:17:14PM +0000, Adhemerval Zanella wrote:
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data.
> 
> The vDSO function requires a ChaCha20 implementation that does not
> write to the stack, and that can do an entire ChaCha20 permutation.
> The one provided is based on the current chacha-neon-core.S and uses NEON
> on the permute operation. The fallback for chips that do not support
> NEON issues the syscall.
> 
> This also passes the vdso_test_chacha test along with
> vdso_test_getrandom. The vdso_test_getrandom bench-single result on
> Neoverse-N1 shows:
> 
>    vdso: 25000000 times in 0.746506464 seconds
>    libc: 25000000 times in 8.849179444 seconds
> syscall: 25000000 times in 8.818726425 seconds

Aside from the big endian concerns we discussed on IRC, this is looking
fine to me, and I'd like to get some variant of this queued up in my
random.git tree for 6.12 soon.

But first, Catalin or Will -- could one of you take a look and provide
your Acked-by for that, if the patch looks good to you?

Thanks,
Jason

