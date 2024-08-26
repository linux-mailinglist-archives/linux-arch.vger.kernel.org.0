Return-Path: <linux-arch+bounces-6633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FD95FB10
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27BC285A7C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4D1990D9;
	Mon, 26 Aug 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a+ejTlCm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E5199381;
	Mon, 26 Aug 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705750; cv=none; b=U/IyCrK4T1//1cHsHguq7QFytDOjbE6yVyYDA8t2tnT3P2zkDRdB7mj8eDKjbYnLJoLrpoNjNiONFWm2xjLz7Dcz8fv1YRD5rK9uiDCVUzzfXaUVgbZbpyrcW3/90HiXraxd3b0XNWdGEbD1UMW6jxCoGd5JV4deXvwaFSp3epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705750; c=relaxed/simple;
	bh=REdH2NWYa0AEyp+TtawXjXJLttUHJsFI3iC/t4kvJ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfIb0GHnzscYLGOorxKnLSHSjqgtNHZqOWSacTAVKh5F2L/MOOKz3Fcx+WVcxnGnFYq8PX0IpYoEsKNjqz4UHC3VGlozKNSg/Yo4P+z+yTufcve2hGFQF1UBzWijutFdwAZUhW+Zd3Fb01aWuGr5ZuVGFMLTiH/mwBejdy/+PwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=a+ejTlCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA6C8B7C0;
	Mon, 26 Aug 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a+ejTlCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724705747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAePswJ3y/dZTDiMB/nIlWVQ8Tk8o3aSAoN0mi4bj30=;
	b=a+ejTlCm47r/OWEzlEZvwwmAqQgUvHsGwx1r2J5647/0aZl33cyMdKcTob/83hMf/wbGKN
	9MJQqo/UFh3O7WlAf0JyBvmouSXNG6fZWKUqax0jUVkfFqL9wm8k3tVIUKPHzsGPHBnO+L
	h5S0+aBInmdmGOFhoK3WIHNIO6t9mwc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 30363203 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 20:55:47 +0000 (UTC)
Date: Mon, 26 Aug 2024 22:55:41 +0200
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
Message-ID: <ZszrzRbL-eks6A3I@zx2c4.com>
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

On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> +{
> +	register long int x8 asm ("x8") = __NR_getrandom;
> +	register long int x0 asm ("x0") = (long int) buffer;
> +	register long int x1 asm ("x1") = (long int) len;
> +	register long int x2 asm ("x2") = (long int) flags;
> +
> +	asm ("svc 0" : "=r"(x0) : "r"(x8), "0"(x0), "r"(x1), "r"(x2));
> +
> +	return x0;
> +}

More generally, it might be best to follow the format used by
arch/arm64/include/asm/vdso/gettimeofday.h.

