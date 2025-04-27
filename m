Return-Path: <linux-arch+bounces-11632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC1A9E307
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C85A29F7
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D13FFD;
	Sun, 27 Apr 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LB/WZAlf"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E433EA;
	Sun, 27 Apr 2025 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757716; cv=none; b=nXjhFm65rCTuvbs9lo+nBI35xbVdXcPeYsqqcg8edbxbXxEP2OP2rD9RNVYmKeDJ2wtSinwvkeWcMr7Cz0JW2rCOj1jLa3f+hdLnDRoqXuaF2R6s8dfsb+6RTje7P5+Y+aLV5k3dRq5g0fSh8vrIBUWzz6CAQHub2k4ajMevzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757716; c=relaxed/simple;
	bh=HlWSQte4tLw9PjoHfjPm7m9bE0tjBHVsK0uKDx2ObhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvUaF4m2oTQpVGzrX+4W+l/Y4OC4+CW1ERjThOWr/pXA+Pd0rMvQpiwuQWivU6km76GsC0LjZMntPt6LyRfyqoUNyPanTBO1D92HBouLhxqM0p+/JYh8KREN8f/PoNbyd7Xwdnbw89311fOrCsaQ4WesozgztXhl+wxIqsJdY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LB/WZAlf; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8B83JaeVQLHgFCWXWffwqUb0JmXK1uEo4GZHcdcva+Y=; b=LB/WZAlfGOzyKCTr/sq7hB3Rdp
	87DGEL/SX99F82X/5S3CEt+KMPNil4eQ5XKn9HKMnUxA4cfDf2PrRlmreWsvqfNqxji0Ahm+IqUQd
	wXdO33aEhGmFBOIXuWpE+8bZioYkuicGAN5B/jPJ2fK2P8K9cQiDFC/DlSxp1X3SHny4nVm15XAer
	aSB48aWcfnwfs22dSqJc1WnuG99u9FTL86VXIeZNZAw4NPoARt7CX+u2bzA4RtU1Kraqbddk4uCU/
	yAMqvxfq3a/ZkqN2tSwmIOwRD7TQsIjCpK6QaSzQIFGD7u7OUwRc33CrLVfbIPdhLP99OmnTsWDY/
	Uek3AdhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u91KE-001OSo-2c;
	Sun, 27 Apr 2025 20:41:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 20:41:38 +0800
Date: Sun, 27 Apr 2025 20:41:38 +0800
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
Message-ID: <aA4mAlozk3RvxvTe@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
 <20250427123514.GA1161@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427123514.GA1161@quark>

On Sun, Apr 27, 2025 at 05:35:14AM -0700, Eric Biggers wrote:
>
> Well, barely a day and you've already ruined my patch series.  Now instead of a
> clean design where the crypto_shash API is built on top of the normal library
> API (sha256_update() etc.), there's now a special low-level API
> "sha256_choose_blocks()" just for shash that it's built on top of instead, for
> no good reason.  You're also still pushing your broken BLOCK_HASH_UPDATE_BLOCKS
> macro that doesn't work with size_t, and putting my name on your broken code
> that uses it.

Your design is unacceptable because you're forcing the partial block
handling on shash where it's not needed, just as you're forcing the
hardirq support on everything.

I'll take your point about size_t and update the BLOCK_HASH helper.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

