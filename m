Return-Path: <linux-arch+bounces-11635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFFA9E36A
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83DF175226
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246BFBF6;
	Sun, 27 Apr 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Y5RhSc5/"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC233EA;
	Sun, 27 Apr 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745762839; cv=none; b=u40P6P84ALqjktV02W0Aw7SADOebeuzPqskWpYVKqS/kUi+XNu15Rx5x3XO0/exyyAugz/winv5D4W2cJV42xIHtpd5ozHdYl3OHz78+/nu6fqXDOMnCil9kmwGJ4aqS0N0GeflzkJNL9XYAEvpgHkZcENiPN+abCwWsJIAgc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745762839; c=relaxed/simple;
	bh=1Xn31aUEL7UCLpME3athNyqhY+EDxL95zDk5CYxrO6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k36byUii5Murl5VFV6JVp+70j9WEZR3PvPHr/mno4Qh4ZyhpOHwlc30LG+Cd89gHZC8BD2nP5en+lsd/jwEs4WuIYWZjeH3U8TORrjDhgoO8sPTS9fN/HT8Yp4f+mp5rhpQAphbmLaBnADP/Ell+LMxS1YiheS9mm18UpRY/PFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Y5RhSc5/; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bjaQCYAZZv7TZCyYcpymHM3x4tGRpcCplG+gYWSYS9Y=; b=Y5RhSc5/FybI7zmz9SHjUsOJyt
	6y13MP9+31En+C9RdXh+jvvPfmcEs8+ugf/lrbM+EuMyfHqK2AbcS8TSq6nIW/o0J5hLQbnKW2dwO
	5PDPeGJ0dMiB+I1jO7FLhSzAAUHoGPP0xtZH8fUgS54mB21PslHj4y/wIynDPQmglvHJFPSzYGQUS
	e6SLa2lor/mFtkN8PODNuoz4j9cgiiqr6ML354CiGk2KNJSUINJ8HzdvV/YfmSH+b2/2lTMTZ+f9n
	8+V6BnpZAT4ZOKXfyim5oaRqg6ehnl6jo5JsXrJNniEO3jfXP0RfbAfbnaxToW16RVxQ/wE8t43b+
	zz+/7N0Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u92ev-001PEG-1R;
	Sun, 27 Apr 2025 22:07:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 22:07:05 +0800
Date: Sun, 27 Apr 2025 22:07:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v2 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <aA46Cfr7p6dMXwvU@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
 <20250427123514.GA1161@quark>
 <aA4mAlozk3RvxvTe@gondor.apana.org.au>
 <20250427125641.GB1161@quark>
 <20250427131138.GC1161@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427131138.GC1161@quark>

On Sun, Apr 27, 2025 at 06:11:38AM -0700, Eric Biggers wrote:
>
> By the way, as I mentioned in my cover letter:
> 
>     For now the SHA-256 library is well-covered by the crypto_shash
>     self-tests, but I plan to add a test for the library directly later.
> 
> But due to your gratuitous changes where crypto_shash is no longer built on top
> of the normal SHA-256 library API, that's no longer the case.
> 
> So while I do still plan to add a SHA-256 library test anyway, I don't see the
> reason for not also making crypto_shash just do the right thing.

OK at least this objection makes sense.

I'll add an additional sha256 shash implementation that wraps
around the lib/sha256 interface so we don't lose that testing
coverage.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

