Return-Path: <linux-arch+bounces-11768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E20AA5A84
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AB87AABEA
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F438261589;
	Thu,  1 May 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ORsTUm+3"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEE2609F5;
	Thu,  1 May 2025 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746076760; cv=none; b=pidi2MtsVe2cL5d4bjJc5MLXnZ3D7bDTOtOzPeLt9neG53yW8lzxiEdL/nkdGwgMBlZXHExMBRckl65a2G+ZPZPqbMZqyWVGhe/tzMuwSm1Ffh5G0s7LSQXVUTAwrKS1VxacTrq4t5/WsqwmsrUcB7y1XqTrsoXDLmuTYkGkEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746076760; c=relaxed/simple;
	bh=kB2nu9oQJWAumIVhwpNu9VX/9t+OVZ610msYAY5hvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSu7cagTTZdJAFXavms4C1cqt3I3PVYZvjKjl90Jripw2Nf+fvUkqOIQLP8hOIwKQ6MOlKBbVE6RjY9Ib3JJF0eJnMyNrOSHE14OFfK2Gz3Ntk3W8ww8WhdsSBQz5e0KmkTp4DcHbBkUAegPJ0l3nu0pj7PJz/yTa0XFegvC6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ORsTUm+3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9t5+R7MBB1CitzsoU7qrOUojn4639+WchyM4zx0d4j4=; b=ORsTUm+3tDs7MqOLXniwLbTENu
	6p8Ijou3tB4FtepjWe3F1A6W8IvySh95cZdbo6AzTOgys1fAFOnLjgZl/ixeJAU3uP78oydLi8D//
	yAax6cWpNxoAHYpOezO8beaYeuGHP68V4qdyQTdAirltbeZ3K5W1HWRLRdTu1DRHvIhqGACuMLtsD
	L4/ELm9xRzxjZE9uSzRBsLPKu384XEncFgdp8RWbWcWOQIo8DOJNbz9+cCdkKdgpDc51jJ2r9y5VI
	V7Wcl+IDdkPoN5XAqV8kKx2r8DlOwoCrwVYtmf6WPYNYB7nm6jKdpr5Y35dDNgam3PekRDwUujufp
	tuz3w6FQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAMK4-002SVz-1M;
	Thu, 01 May 2025 13:19:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 May 2025 13:19:00 +0800
Date: Thu, 1 May 2025 13:19:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/12] crypto: sha256 - Use partial block API
Message-ID: <aBMERARvCQsl-5iN@gondor.apana.org.au>
References: <cover.1745992998.git.herbert@gondor.apana.org.au>
 <20250430174543.GB1958@sol.localdomain>
 <aBLMi5XOQKJyJGu-@gondor.apana.org.au>
 <20250501022617.GA65059@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501022617.GA65059@sol.localdomain>

On Wed, Apr 30, 2025 at 07:26:17PM -0700, Eric Biggers wrote:
>
> Interesting approach -- pushing out misguided optimizations without data, then
> demanding data for them to be reverted.  It's obviously worse for
> len % 64 < 56 for the reason I gave, so this is a waste of time IMO.  But since
> you're insisting on data anyway, here are some quick benchmarks on AMD Zen 5
> (not going to bother formatting into a table):
> 
> Before your finup "optimization":

Thanks, I'll revert to the single-block version.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

