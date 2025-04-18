Return-Path: <linux-arch+bounces-11445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FDA930D3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8AE1B6102D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54197E0FF;
	Fri, 18 Apr 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr2SG5z+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C021E4AB;
	Fri, 18 Apr 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947160; cv=none; b=r7vYFkoDbI1wxDswZAVN5scEk3AfPjFfADt/gXDHB12PYbLt2jKztoFB1ppdM0+R65qxis/AZujvfXUyvLWWYOL6ZZ4+EDN7c9Qg0/mqlKIlxU8ddb1hbgc20IWghjlIgtQMT/fpX6EoYrOMGTOzUYA8w04gVvPK0nuPlUy2v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947160; c=relaxed/simple;
	bh=pKH0iMn/ElSIBHsAfOGxNhjlTOJh60B8ZyUUd2TvSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg/63KzDN2OhYsgM6nW/6PfjXgNlf4JHl6GdxlslWzsH1jbt3oMhWo6x1Rg4SayN1JL2YFAoTVMOALRpYzO+/5471Z80PN7c09uyLDQzSlwn/jgkQk2cLaWYhL0or9KOx64zeXmVpsTggnL1XbJ44IZcxjyYy+DhuvqSdj4WffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr2SG5z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A07C4CEE2;
	Fri, 18 Apr 2025 03:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744947160;
	bh=pKH0iMn/ElSIBHsAfOGxNhjlTOJh60B8ZyUUd2TvSWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr2SG5z+VUuYx9tif00YQ4lXNJDQnAwS2cDvkeWHH+1dDjsS2xsJGAVflXA6/ugx0
	 YsreR8YIfO9pbQUnd5xqyIK7iDfa6mm8d+b64w67ZiyskrV9BSY5w4eNuG1gIe8aMh
	 /VnOIjxNG2ruThkQpwZSfy/nhIHEMmCw9JPPO7DDUnVyMHs6LCgq7j1FqX+Rh9kZ7N
	 4GyosOjpiwdAVR0Xk/3odPnwV33kADLe1BLf6Cpyx7vL4VB4V9XETfCPvYX5JoGdKg
	 HqxC1RDd1RT1ZgzvfoMCxVk+o5IqKy8Sd7rwMaeTae0bDMeANN2hLnouvr+ZWcbtXB
	 8c/XrREVJrfjg==
Date: Thu, 17 Apr 2025 20:32:36 -0700
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
Message-ID: <20250418033236.GB38960@quark.localdomain>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAHDIRlSNLsYYZmW@gondor.apana.org.au>

On Fri, Apr 18, 2025 at 11:12:33AM +0800, Herbert Xu wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > config CRYPTO_CURVE25519_NEON
> >        tristate
> > -       depends on KERNEL_MODE_NEON
> > +       depends on CRYPTO && KERNEL_MODE_NEON
> 
> Rather than adding CRYPTO to each symbol, how about grouping all
> the CRYPTO symbols together under one if statement?

I don't think that would be better.  The 'if' would be up to 400 lines long, and
it would be easy for people to miss the context when editing the file.

- Eric

