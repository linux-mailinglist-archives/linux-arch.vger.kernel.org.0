Return-Path: <linux-arch+bounces-11442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C023BA9309A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CF71B62CFD
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F5202987;
	Fri, 18 Apr 2025 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ad2r1puG"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795511C831A;
	Fri, 18 Apr 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945707; cv=none; b=YqGcUzAhT9z8dskTtXNSsmoF9jnp8HF858yMhDtVcBXyGn+xK/76LEalHMXWUpIi8OrGy7KTnaZD7t6yz80H3P+5xn0McUpgBaMfVdKvLY9UyPK9YnDfGkgs9+DFF2/a3hdk/CSe3dvrvVWwcteVVPiZK607qgTbbF1DDxshGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945707; c=relaxed/simple;
	bh=DoSFlNVJWaKhB6ZrZkyvTYjAArw/STYlvQfauxosAXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ft+MaWpLebIz2KTSduqEA9XEYMMCV0aFfflljfTZ47KBiToxnDKKTx6tU9jyyVOP1VFZr1UYXp2nJD14x3I80vvSJvOquP8gCKskQttCKatrPoAziW/5fP95Ww4pFYNTdHN4d2QMlNIBgrQBxLxgs9BCUYaEe9pekOo1K3yOQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ad2r1puG; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cBam+4bEBq9fnDxk0jHRH2r9C5SS6Xd/ZiWHED3RBr8=; b=Ad2r1puGLU+Y1rwUeDUqRhU0qO
	F7pjd6bV7RlyG39Dh5jEkE+5Cipv8h36HNwxkd/OFyixIJ6MxLwR9Lt/xnU3YlHz/ccXTGPXLJ11z
	kX3xxqCi5uGmCYV3AHyIGc+2fpgfU0xkYxttXTLSSQsa6Jc5ReCdOCQ9EshaKh69QTcEXZ2QH0dKa
	OCpbpHKL9L5fZR/YOyt7Z/zLu4/L+bkrOc8irkMvNXS8hOyxoLHQDiLQZthliGKqYzCqrgP19jXwn
	M9Ki5L0y6D3/MVduXxafDI2dZEU2TwnJJVwxN+sGp+xGVKV7/8ahMXvoJGkt55Cxb+uJ6YEljyPno
	EUy5oI0Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5c5Q-00GeUL-2y;
	Fri, 18 Apr 2025 11:08:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 11:08:16 +0800
Date: Fri, 18 Apr 2025 11:08:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <aAHCIL_sYIS_1JQH@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417182623.67808-2-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 25ed6f1a7c7a..86fcce738887 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1753,5 +1753,7 @@ config ARCH_HIBERNATION_POSSIBLE
>        bool
>        depends on MMU
>        default y if ARCH_SUSPEND_POSSIBLE
> 
> endmenu
> +
> +source "arch/arm/crypto/Kconfig"

...

> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 9322e42e562d..cad71f32e1e3 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1424,13 +1424,10 @@ endmenu
> 
> config CRYPTO_HASH_INFO
>        bool
> 
> if !KMSAN # avoid false positives from assembly
> -if ARM
> -source "arch/arm/crypto/Kconfig"
> -endif

So this removes the KMSAN check.  Is it still needed or not?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

