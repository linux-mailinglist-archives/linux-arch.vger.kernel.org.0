Return-Path: <linux-arch+bounces-11446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A9A930E2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52241B6270E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096EE2517B9;
	Fri, 18 Apr 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Sw/SPaiI"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464077E0FF;
	Fri, 18 Apr 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947533; cv=none; b=cuiA0GHlOInd0BZItj9bhWFQEcnarY+9Wr2A1YU/2+p+fG9RSgFd1MB1bHxg7Y4l6MaKLYKMTWmfNex0wnhhWFKeaLMceCawbnOuQOCCwhcLJZQbnPSLxuZnYBJnFB7U1SCJX6vFMN/q+8Iu2l8JdkwZ0npqFNgP9JExq9zFJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947533; c=relaxed/simple;
	bh=CJcPXGX8c/TllH/WpTkXAI7WyMoePHD4KFWUv6KlXdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTRG7QWEni1u52gW37BpekYo0ucGt9UhpAZ9WwJGAaJeUJym3dtlSAAUzmAwnQpftGGxXaEydko8NfniVxmg1jZBa0zeVp+x6CQuKZwZ5PdVwAjMocQKICEIGlgAdazauGQ3m9OSzitMyU8xlTyXumEKPpA6N0VzeoGmlFdlN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Sw/SPaiI; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B5FIE5cHQYuMr1+LHfbtaiLujfedpAMdrckiF6Jw7wE=; b=Sw/SPaiIwN2XkEd3xx63jQvQU8
	6GooV8x5tQUoq0lZci9EL+Z/URNL5NnWrKhvkqhVIkw/wqqBHP0/AcSjEFSPQ08OCbpdQEziW4WA1
	BjhVGq+q4PPss7KWlPRXKYTEX7bm8DfxuHlxraHZYmYNuv0dCNhAsAPT6Kl1rqkEhAWv1Dg+1HRTK
	VrGJtSoHwAef6a+FxsIYM42MFza4Tcqt3RNsgJYu+qCX0A3O1uCxjhZ7cQLllWj6ZiWPQerfPZHPk
	ZzmdOqQcktgF3XJAIgaS7LwiTpMmJyNHj8iMjo5PylXrBp3FZ7Qk+tnZJ9BoNz2srhcV4TEiX1GCE
	b//mLDQQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5cYw-00Geir-1h;
	Fri, 18 Apr 2025 11:38:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 11:38:46 +0800
Date: Fri, 18 Apr 2025 11:38:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
 <20250418033236.GB38960@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418033236.GB38960@quark.localdomain>

On Thu, Apr 17, 2025 at 08:32:36PM -0700, Eric Biggers wrote:
>
> I don't think that would be better.  The 'if' would be up to 400 lines long, and
> it would be easy for people to miss the context when editing the file.

We should separate the symbols for Crypto API options and the library
options.  If you're worried about people missing the if statement,
how about splitting the file into two? One for Crypto API symbols
and one for the library symbols.

In fact we could move the library files into a different directory,
e.g., arch/x86/crypto/lib or arch/x86/lib/crypto.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

