Return-Path: <linux-arch+bounces-11611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B3A9DE4D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D37B17FEE4
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342EA17C91;
	Sun, 27 Apr 2025 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="O/r0niVz"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1421D530;
	Sun, 27 Apr 2025 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716658; cv=none; b=ptsgYjIpVeoxJOTvg/65h5c72n/NbC9kbL5RublwP9hmY2+6I93IqhAv+/DlqVEFxBlbiIUlaiMjwpoeuJ2P+4P0EV51Ahp7jBrOqsqbzosv9uBYwyxhrErxCFgK8Cuc1yqSn2I7oQEOP2lWvnIq0CIoYfjHEJkzDeuY9fatLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716658; c=relaxed/simple;
	bh=NyBiYrI5sEBd28szyTzUDbHC5aHUY2hM033mtWjpPUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdPkiKqCuI51Bwb4HM3ioeYx/Os3uBsCLBzsmteY+nbdu/JSczIc/rkNBtV5xkGB2yWJEAVi7pGd7lelKehmaraIs5wejaeA4FHouK9M8QzIIqUQ4eYkx026lDoZgsSm8CTF05z6fvhX+uMRikhpAkSRnCH3vAQX8rDh+8nZlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=O/r0niVz; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3F7iDEdSRBB2mSL+5QpO5w6bndUe8WQsHE1GcHOmdVw=; b=O/r0niVzoyOPfmEco/LPho1OAX
	gGXZ6INsJ4cKg8F+kqhcLeP1EXxcw67SKKTXtAYghFdkrDnWzOKvFToEc+FXMWFz+W5Kfn0d6Ha1v
	nmJArGe4ph0x2aoDazE7UTjfa1YdP1htxevT63zScgCUYo+6c0dDx1v7WR+XB7TEo9exFgzd5VNqd
	r0TVQdHeibdui8OTBHi7kfB5aY9rOS8YEXOKtdp1R5EKYF+U1zPv4G9zi4m+ESO/9A2yInPbZc+Gt
	hMr4wQQDBJIVBcyMMzH9rW+cWwtPJNGXlJWOdNbe5szGd3MGES9JjNOr8P/cWSx2hg8/c8kMhmAzz
	WlEHOoKg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8qe8-001JTp-1j;
	Sun, 27 Apr 2025 09:17:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 09:17:28 +0800
Date: Sun, 27 Apr 2025 09:17:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/13] crypto: sha256 - support arch-optimized lib and
 expose through shash
Message-ID: <aA2FqGSHWNO8cRLD@gondor.apana.org.au>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
 <20250427011228.GC68006@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427011228.GC68006@quark>

On Sat, Apr 26, 2025 at 06:12:28PM -0700, Eric Biggers wrote:
>
> No, that would be silly.  I'm not doing that.  The full update including the
> partial block handling is already needed in the library.  There is no need to
> implement it again at the shash level.

shash implements a lot more algorithms than the lib/crypto interface.
If you won't do this then I'll just do it instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

