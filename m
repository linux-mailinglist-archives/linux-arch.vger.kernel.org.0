Return-Path: <linux-arch+bounces-11766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB6AA5957
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 03:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FB4A521E
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E621E9B0F;
	Thu,  1 May 2025 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="a/NlvQqO"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DB1CD0C;
	Thu,  1 May 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746062490; cv=none; b=S/c7VM3iGaHWonvmqkXKtUhGTs6rGNdwKBlbgZB9RpXBTUh4wyJHBcsQUR5NhrhqZZgmQI/i9H3HeR60DOUgINT1lT+etwNQTXmJmloTkIKYClfwa7ycqKLpU00kCpLISrtLK53WxQezDlPvLY3w+79Za9iqoP2z1a6Q+uQrJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746062490; c=relaxed/simple;
	bh=syWciCY1H3uMC0/UNA+XmiFwV9p5kn8EPe643q+zrnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvdd1KxQWo9UKDH41R3TU8hytOD8Y5qXYdqMeAEpHgLTzYixBZsWzy8fRD5i4FbNGSaW+kOnMpUN0RJvPQ+USF3/0saqwokfRgfJxTxTsNI3fpYkzvkAyjvZucyUiOYArNyXz4e/Dzqd6lsZXHBw6Yqd1N1gKoxbTzQNp4tbmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=a/NlvQqO; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NW5f/6zfXSJgSFBDpq9nG7FU/uxSqKRQHQ8TMd0Poy8=; b=a/NlvQqOeoRlesedjZn7kxOnFw
	uv4a9xzHl7D1VZeIL93rjMMAkhe5hxqE4x0m2n/FWDvbWRvtAX99hxnOhhW6vCIjzXO0BHZ3lqJM5
	RB9c0EnDFbkQGKZre/Y99u6FTj0aU0AbJGl20o5hnmiDJvj7wFkXsXvZtugU3t3vxsaSBA7xX9NFz
	wK8MiCgvwE6zOyaFZ4PnOSV/LXOZB/7xN/Nq+7ZCdajE/MnuryS2PJCBO8luW8qV3BFecbN+Fs9Ot
	Cw+tw3zJmJw9KzUB2KECxEtcp23uuxyS5Q/PBLXt9Z81aTgSodFT60Fy0hM+6eWtxA0rVUI0j3R7q
	BRzxY+2w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAIbz-002Qsc-2M;
	Thu, 01 May 2025 09:21:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 May 2025 09:21:15 +0800
Date: Thu, 1 May 2025 09:21:15 +0800
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
Message-ID: <aBLMi5XOQKJyJGu-@gondor.apana.org.au>
References: <cover.1745992998.git.herbert@gondor.apana.org.au>
 <20250430174543.GB1958@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430174543.GB1958@sol.localdomain>

On Wed, Apr 30, 2025 at 10:45:43AM -0700, Eric Biggers wrote:
>
> As for your sha256_finup "optimization", it's an interesting idea, but
> unfortunately it slightly slows down the common case which is count % 64 < 56,
> due to the unnecessary copy to the stack and the following zeroization.  In the
> uncommon case where count % 64 >= 56 you do get to pass nblocks=2 to
> sha256_blocks_*(), but ultimately SHA-256 is serialized block-by-block anyway,
> so it ends up being only slightly faster in that case, which again is the
> uncommon case.  So while it's an interesting idea, it doesn't seem to actually
> be better.  And the fact that that patch is also being used to submit unrelated,
> more dubious changes isn't very helpful, of course.

I'm more than willing to change sha256_finup if you can prove it
with real numbers that it is worse than the single-block version.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

