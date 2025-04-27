Return-Path: <linux-arch+bounces-11607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60334A9DDFB
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 02:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9346C1A80B9D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69333227563;
	Sun, 27 Apr 2025 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LsUBruIG"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB01E7C34;
	Sun, 27 Apr 2025 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745713152; cv=none; b=epGwSS/irttZ4jE28UoCjVOOjJJGlGVw8iNH6S0UPh7uZONuqswcLsochfD0D6vEhlz3JSYcaeQngSAzINbEqlgxBIakeRy2LL4f2Vkvt7hwGqgVvtnXHCy8KpG7sxqv+KdbrNtfPBtTelcC8QFoLMhhNPHjRgnjkkrIyxW+rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745713152; c=relaxed/simple;
	bh=z2JnkUelGjwTsIo7Ko54jjxrEw1ldas4tF+vGGSGEUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghqUM/F2/GO2USFPh8CVapnEJFnxA4UDql55yssEWsEK58h3muHOyBM+eOUiAKTDyqFoqgCYX5vc/74silqqra2H319uODOvKPTF2yx1/7kLj4KDqHBVZeJ2gRy7GaYenI7LOvvJBXbKaToyW3fxA7fJKSysKCFOjeKg9PVaRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LsUBruIG; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qIc1CnqWjP+VDV+/eTU2C9hwQs+hAGsJroIHvnLDXc0=; b=LsUBruIGAs9uLBJRTk9h6fgdB0
	2xisb0QqkU5+qP/eEYOH3uvK2DCnuZkERHnCECKmdbX85eZlMfmPqVki9sSxjYrxdWFAhjUUMsUD3
	P2JtdRMdBzT9y1/R7BdqzGhm5+HW6Qeftz51Y5755VFfohf8/0ee7AMDCj9lJUk5Fsi5cY7ScWSiM
	wAarhpfnk8TKu4CA4qEF5xdYMq88s0cnneBOdtKkePk/L0Ss41Ue/EHUkeraGj4GuqVbngWnxOuPy
	zGJVAmP3Tblrt5KCk9xwxPfx3IMbexqk44KkQviPivswZwKydYQtt5WMVkj4AP4WS2Vj5Wn0x9m7M
	CuGifb1w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8pjU-001IyU-22;
	Sun, 27 Apr 2025 08:18:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 08:18:56 +0800
Date: Sun, 27 Apr 2025 08:18:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/13] crypto: x86/sha256 - implement library instead of
 shash
Message-ID: <aA138IKjqyZeQLgB@gondor.apana.org.au>
References: <20250426065041.1551914-12-ebiggers@kernel.org>
 <aAy6g3nblKtRj1l3@gondor.apana.org.au>
 <20250426180326.GA1184@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426180326.GA1184@sol.localdomain>

On Sat, Apr 26, 2025 at 11:03:26AM -0700, Eric Biggers wrote:
>
> The SHA-256 library functions currently work in any context, and this patch
> series preserves that behavior.  Changing that would be a separate change.

I've already removed the SIMD fallback path and your patch is
adding it back.

> But also as I've explained before, for the library API the performance benefit
> of removing the crypto_simd_usable() doesn't seem to be worth the footgun that
> would be introduced.  Your position is, effectively, that if someone calls one
> of the sha256*() functions from a hardirq, we should sometimes corrupt a random
> task's FPU registers.  That's a really bad bug that is very difficult to
> root-cause.  My position is that we should make it just work as expected.

kernel_fpu_begin already does a WARN_ON when called in hardirq
context and it can't safely use the FPU, there is no silent
corruption.

In fact if anything your patch is making the problem worse by
making a hardirq stochastically slow with no visible warnings
at all.

> Yes, no one *should* be doing SHA-256 in a hardirq.  But I don't think that
> means we should corrupt a random task's FPU registers if someone doesn't follow
> best practices, when we can easily make the API just work as expected.

If you really want to support this, do it in the FPU layer, not here.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

