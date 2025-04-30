Return-Path: <linux-arch+bounces-11750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FCAA40EB
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF401891CF1
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335919C54F;
	Wed, 30 Apr 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Vieyc26V"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE9320F;
	Wed, 30 Apr 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745980050; cv=none; b=chbfn+ciz2S/NNpeDQU7sWo5GQUL+1Mx96qwGD0KGtnJracKI9FTy3AdYEzbWx+7Ws+BHhC9bDaWW5lHDoQd1dZj4svPJh7BrlmkImHJkrFy+6ZQvM+nyL8LySUlsl7jM1h/f3xHRr30zCXwCoZHbLGbcr8RPDkMaeLEjEZMcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745980050; c=relaxed/simple;
	bh=MjSwpfkrbJam/CzzxFxRbha1wbLDcDn5jLZbOSmWQ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNh2/gfuWb7mRXT7x5F9yeaeHnoOBMOR+MoktakHUJxh4uvCv9oHI7s1fV/P1j9ViVJF8CRgNuFtwANlPLq0i6wf8sJv0lC49CQWOMfPq+oIA72LwJDq12Fb/ZjHkO/y/EcUKJikXEE+3K0H7S5db9rhlZQZRsKWKO/Zyc472aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Vieyc26V; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k4QjAmh83yMZNLzUuAj1J5f4WZGw3kbBWCArSRYks8c=; b=Vieyc26VLhqz4zWnYRj3rYoyQj
	H0zpuIjmCDGV04Csn9F7DAzFr4VMNjSPrC0ttYmpV9ePC4GcLW04Gh2LQ1DfIxlqp8R2aL3ipQgqS
	Hoxj4/7XIQ9SP8MYTw9J6YxFRkgAmoixnyakr025Cu5UwmrQd+FkzC7jHq9Sv7Lbup88SHAX/kJOO
	gCZMT32Dh2FRvOwZvUtHvMWVDl4ZzRtgK+7mmLDbkUAE5fgD6/s5zMPyYWMNXS2Dyy648liRupOcp
	RncktiF2kCxxXhDi4UksWk66YNHf90reaqkRJHJIrq0moVeglYppY4Tl1LsVfkb0I0T9xlkGgF+Dz
	KZjeX6Og==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9xAJ-0028rg-2e;
	Wed, 30 Apr 2025 10:27:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Apr 2025 10:27:15 +0800
Date: Wed, 30 Apr 2025 10:27:15 +0800
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
Subject: Re: [v3 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <aBGKg5bq0zLkhy3-@gondor.apana.org.au>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
 <20250429165749.GC1743@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429165749.GC1743@sol.localdomain>

On Tue, Apr 29, 2025 at 09:57:49AM -0700, Eric Biggers wrote:
>
> To be clear, the objections I have on your v2 patchset still hold.  Your
> unsolicited changes to my patches add unnecessary complexity and redundancy,
> make the crypto_shash API even harder to use correctly, and also break the build
> for several architectures.  If you're going to again use your maintainer
> privileges to push these out anyway over my objections, I'd appreciate it if you
> at least made your dubious changes as incremental patches using your own
> authorship so that they can be properly reviewed/blamed.

Well the main problem is that your patch introduces a regression
in the shash sha256 code by making its export format differ from
other shash sha256 implementations (e.g., padlock-sha).

So your first patch cannot stand as is.  What I could do is split up
the first patch so that the lib/crypto sha stuff goes in by itself
followed by a separate patch replacing the crypto/sha256 code.

> Please also note that I've sent a v4 which fixes the one real issue that my v1
> patchset had: https://lore.kernel.org/r/20250428170040.423825-1-ebiggers@kernel.org

Yes I've seen it but it still has the same issue of changing the
shash sha256 export format.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

