Return-Path: <linux-arch+bounces-11616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E5A9DF11
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 07:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4B46188B
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387DE1FBEA9;
	Sun, 27 Apr 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="dGnaoUBg"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEA7E9;
	Sun, 27 Apr 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745731287; cv=none; b=CvGc/rYXqdv1eU+bFEFeKa5iyyjpDqnhmpt3fC5KK0zUBu/70cUMYEJJfe1YTmt9x4+vWDUO1Se8y4kSrXCzjAvkFuqtwm+afJ/uHrJmZMoS9wNACuugNNHx5mLIhxvXIQwafPq5f0js21G+uz/oUFhOqYoW3snufS7FoTi8CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745731287; c=relaxed/simple;
	bh=uT6wQrZz+Og81uIA0fnWp17n5iisubP/qNtIyRxnCXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQyVu+5FpL43AVu8FsRCARLLdvbP6bvvwSNzMWctxRskqFXgzEnU8v2ryoKtu1ttruwDr4HjmuVJF7GIIxLkVTpAe3hK/GQAh0i0FkmE5gXxoEAVO2eMtrE1DLyc+tQRbWP5UcigLCeKTsGjrkJMBrEfiEtw4kw9b5iefsG0IGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=dGnaoUBg; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pl2+iJoLEKyoEY1+QMbzNQxE4vs1/OpqeGo2MbFswoc=; b=dGnaoUBgwG+MFM/UgCXPevwWE5
	1SBPXmQTDAAc/9iOYOSD/BlyZtCEk3qq8qm0xiPTxGOsP0Dv0Cw7NIlflY5pITkraHSwdkFx7tBEu
	kNOVMTuERLnZjhJ97P/WUb5iDMqM7BFVuNjR2p1i8CPh29AUn0QzldJUQHx63UY9Gtj4dZFw+4J60
	7EAM3fs081VqfaaOkty5cnDU3lpHYiWRncdhaPEG3RRHmegrSfjx8TOlUtTKeao0saw22Kz+s2kbK
	iDNll0edL8bDHDIHJMTq0JiEhdzcGql3p4Was7EPbmHmk5EEwlBqueiaFepnGV2nfCTSxBFlxEi4C
	UTWU99PQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8uRz-001KyE-1U;
	Sun, 27 Apr 2025 13:21:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 13:21:11 +0800
Date: Sun, 27 Apr 2025 13:21:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 11/13] crypto: x86/sha256 - implement library instead of
 shash
Message-ID: <aA2-x-grUfoulkDf@gondor.apana.org.au>
References: <20250426065041.1551914-1-ebiggers@kernel.org>
 <20250426065041.1551914-12-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426065041.1551914-12-ebiggers@kernel.org>

On Fri, Apr 25, 2025 at 11:50:37PM -0700, Eric Biggers wrote:
>
> +void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
> +			const u8 *data, size_t nblocks)
> +{
> +	if (static_branch_likely(&have_sha256_x86) && crypto_simd_usable()) {
> +		kernel_fpu_begin();
> +		static_call(sha256_blocks_x86)(state, data, nblocks);
> +		kernel_fpu_end();
> +	} else {
> +		sha256_blocks_generic(state, data, nblocks);
> +	}
> +}
> +EXPORT_SYMBOL(sha256_blocks_arch);

Because of the back-reference to sha256_blocks_generic, I get
this with a fully modular build:

depmod: ERROR: Cycle detected: libsha256 -> sha256_x86_64 -> libsha256
depmod: ERROR: Found 2 modules in dependency cycles!

I'm going to split libsha256 up into the block function and the
lib API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

