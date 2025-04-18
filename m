Return-Path: <linux-arch+bounces-11449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F159A9349D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA407A8602
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902726B097;
	Fri, 18 Apr 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="kpcJ1aZe"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF1268C55;
	Fri, 18 Apr 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964749; cv=none; b=gDuErHtBI1GdifPRE0MwB0sZPNbTFY1lPrG6C+gxA0LMogAuaGrGDZDzKSPdPYVNLY60bUnsVDiHtxd+DhZB29+BZaduOPpDX+HYoEfOFCxe/txEgREnN5ULtbSumFgfOMh9GPkidUBGAfIqnQj0nRguf89F6nDXInXrhWZRUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964749; c=relaxed/simple;
	bh=s2IhmVKxZhm64Wc2L/816Yw4hfryYZJNu4rC36wz9FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAqkYGXjTB/is/n5wNCYUAAJjdduomW6N0yHwgHIEqDlJJwpXgAcwLb+DHF/S1Ses1VjtLaGNbhXYv3PAWL+TCInlCtB/e0N0K6jGREAxgm3B4JnUYqEW2kHyZT+L4fyhnYcE/eCx0ndUvcNZPlA30r+yP7wqesal51qKO8LoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=kpcJ1aZe; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hlkg+5jDRBY5wNNnTe1hqoMZ0WqQC2CXlXJOinsVxyU=; b=kpcJ1aZefOCOmEslLOYgO5//QM
	Ln6pMr5koiDKWOj7at3DmuXW/+yNTQNemE32nJCw0tUBk2lSSos3j+agdtU8LJ1QmGrITb33TVv2P
	ax7x7ihD9o/9/iRWIG6o5huDo+sjBvBM8N/+4rmITe3RGNDZD3kJRIZDt9wM6vSrDQAsM8CtmlaSX
	oieCkebA9MArb2/oiKMgpHGYdSRIx5EULaGWGCnkwKjcIqfjRnqi6KVnMh+uDMtW/pKGRh9+DYB8j
	6L7OlrJk5uGTHv5eg8RoWUkRMy9N+wd4fu7ENI0N1H5rEEfkOX/zcPw1G7vGUetKFspJKMJxaHYWr
	x44+Tchg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5h2a-00GhP1-29;
	Fri, 18 Apr 2025 16:25:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 16:25:40 +0800
Date: Fri, 18 Apr 2025 16:25:40 +0800
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
Message-ID: <aAIMhLD3UMM41JkT@gondor.apana.org.au>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
 <20250418033236.GB38960@quark.localdomain>
 <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>
 <20250418040931.GD38960@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418040931.GD38960@quark.localdomain>

On Thu, Apr 17, 2025 at 09:09:31PM -0700, Eric Biggers wrote:
>
> arch/$ARCH/lib/crypto/ is the "right" way to do it, mirroring lib/crypto/.  I
> was just hoping to avoid a 4-deep directory.  But we can do it.

You can do that in a follow-up, assuming nothing else pops for this
series.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

