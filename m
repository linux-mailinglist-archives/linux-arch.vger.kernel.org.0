Return-Path: <linux-arch+bounces-11448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671BEA93116
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 06:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1943C19E509C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBF1CEADB;
	Fri, 18 Apr 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvEGyPSl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91494262A6;
	Fri, 18 Apr 2025 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949375; cv=none; b=q5iMu7Og8Wp0KlwvEPs8EarGrIejTvvwXLXEmRVRboQfa5ELWCl+UbkrcVtBizAlDft/jFVdhMqcwhxnFOCmQKY6/R3G8tlOp1RTE7wYTvHdVv+KEgECIvj7s+nQx2/SK8mO6Ar8uPTC4uxdU13Ib0BN7YOj4cmPHYv/OPFxrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949375; c=relaxed/simple;
	bh=X9HWpDJKGelzlCUQTDiF/+gV2vBAm2QsT8zUpHUuxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsMJNYaPFNxHb7DxClu0ztHYKNM2JUKqm0mAAgGZR+8LzVvQrz0gF/2eHUHwY3aMNttTxSLNnyBWJZ4C1UyJAvAgCeC2lurndG6I4M5WGZr42F99JJ4SXaNSJEbSdeGxkpJ7vohvIxjlaut18odHL6n4PPjsRWjlpnfughPgaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvEGyPSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4682C4CEE2;
	Fri, 18 Apr 2025 04:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744949375;
	bh=X9HWpDJKGelzlCUQTDiF/+gV2vBAm2QsT8zUpHUuxwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvEGyPSlADMpXrpDb39mtYQWbsr4vDvXWgXhOxwVcm+1/ZyO98L2tTR17xtXq7F5/
	 3Qnp7bu0pCI8eUyKzpE8NMQIi8gQ7qzp2jVxGCRMaZi9PCDQfEcJUTXYSl6qD5k3Iw
	 EW8ujRSii79rvabBW6nRoZ47tshuQ22cty32TIYzGvaDdlUR0EKwklKONC+9qeq+Mr
	 xCahi/xTQTtPwJOoE1tuLuQ5EqHwUPXxKn09ORAOZJk0Tt9BgDXFTBTWPPu9KfOry+
	 P8NwdCgERlt1WKwblR+V1KrFCxMo1RXDgXojcv40y0KcrjrcWMgsjFNPaCTnlktyKU
	 TMqgU5iBTFq8w==
Date: Thu, 17 Apr 2025 21:09:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <20250418040931.GD38960@quark.localdomain>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
 <20250418033236.GB38960@quark.localdomain>
 <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>

On Fri, Apr 18, 2025 at 11:38:46AM +0800, Herbert Xu wrote:
> On Thu, Apr 17, 2025 at 08:32:36PM -0700, Eric Biggers wrote:
> >
> > I don't think that would be better.  The 'if' would be up to 400 lines long, and
> > it would be easy for people to miss the context when editing the file.
> 
> We should separate the symbols for Crypto API options and the library
> options.  If you're worried about people missing the if statement,
> how about splitting the file into two? One for Crypto API symbols
> and one for the library symbols.
> 
> In fact we could move the library files into a different directory,
> e.g., arch/x86/crypto/lib or arch/x86/lib/crypto.

arch/$ARCH/lib/crypto/ is the "right" way to do it, mirroring lib/crypto/.  I
was just hoping to avoid a 4-deep directory.  But we can do it.

- Eric

