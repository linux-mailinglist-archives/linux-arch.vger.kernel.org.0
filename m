Return-Path: <linux-arch+bounces-11613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9DA9DE80
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3E31A82C11
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE161F37D3;
	Sun, 27 Apr 2025 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="j7FUrS/b"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EC2B9BC;
	Sun, 27 Apr 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745718774; cv=none; b=hJpq+7ZhPzwHXiEOQB9v8lqaBklcN7mq43s8NYbbS1XNLOOXaDyVLmP8oV+ReUe/56T7/mauyBhTxF9mQCTQBqeIoIeokS5LTAC9TTKbUo/qri/AITMxYCJxEk7RDMTP1sqZSgdeN1zx1//D9f1u7MTz0tvWyd2UgCar8GBX9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745718774; c=relaxed/simple;
	bh=/ZMDG8ZBbSQryDfIz5EvLOmyJpn+DHCHnF8TLOj2oHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnVEGp1wKDXgckxJVC5mnR3y+hFV/9qwgJsoPsEq9BaKHsfwchkiZZxe1n4PwcmPoNFQUFGo63PGJHGOiXv0NwAkKctPh7hBv7Oe0EXjU4HKlxXaeXyr48DjggaRD8sHObLPWsiqetaHT3+PkVgiRQ3Smh3f6cS4SKEsGm2uK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=j7FUrS/b; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Zwo3jEIV5k/S6BSvnMP3awGiGO3YuYSgcBWh6GzkBJQ=; b=j7FUrS/bY4ibLdXLkJxLUn+ap5
	YhYCpvwpzWdwYop+FOw+Y1rOXudXjrwxEmnvmuQoFhLfW/xwyB50Gj6j035cgOlkI2pmok7ipo2yH
	25crQAk4HTUDesTLMo7qHFGYzbAASFxvnGQgg1Yx5fJujYLkrX8wcSZOOx/WstQN0ioo/Yu8kjWRX
	y9Efcu9GP9BIzj65j++fzzaDauW3eyZ5HRZghn2s7hWiTSLsZpnyu/fgvMYsmPtHmO1P6YKr9X6Fh
	F0mWE3mIuF/Q39gr1a+q4vMiZIu/8G4U/MEIKnjcDFpzIhveaSK5y3NMx6iD7OCc6Ph2xD56WW+5t
	Vjg6IEZw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8rCE-001JpW-2y;
	Sun, 27 Apr 2025 09:52:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 09:52:42 +0800
Date: Sun, 27 Apr 2025 09:52:42 +0800
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
Message-ID: <aA2N6oJ9fQYQUtD4@gondor.apana.org.au>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
 <20250427011228.GC68006@quark>
 <aA2FqGSHWNO8cRLD@gondor.apana.org.au>
 <20250427015041.GF68006@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427015041.GF68006@quark>

On Sat, Apr 26, 2025 at 06:50:41PM -0700, Eric Biggers wrote:
>
> But this one does have a lib/crypto/ interface now.  There's no reason not to
> use it here.

I need to maintain a consistent export format between shash and
ahash, and the easiest way to do that is to use the shash partial
block handling.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

