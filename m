Return-Path: <linux-arch+bounces-11451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F1A9390D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BE7B0D83
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51A2063FC;
	Fri, 18 Apr 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/hWodxC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBB1D89F0;
	Fri, 18 Apr 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988512; cv=none; b=C4jkfcDks5VGZce+l6wRhn1eyua+UZzdhl5jPuBsgwY1/EQ3Sj4zgsi5imhxZT27Lk59JO9UfF23/51oJJfW13EIQ9Py+MwtWZYv2L2DOla2cnKKNgLgOvJ98qWYFKzOqbQvM+fRPIUG2Gv8BshiNg8gJeoSMsycZGrJ+k0NFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988512; c=relaxed/simple;
	bh=8A/sIYJ5SKbc782T5XhHrLEMq+A/QJdgAYupGNodiY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFinf8Q9MKcP87AFpn0ocogJDFAdJ8pEwR3TWoWlrFneXR0BSz6ABzEtUr4Jp0FPOClThuLKIc8M/hQvTbnxN33nqT3sOQw3Doh+nmYEx2KIyPodrcAGk6dkGMCPkH6HA1azwF3fPgwQJGfSMdRBAjDxhtGQSpMwsdUxpmpN3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/hWodxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F22C4CEED;
	Fri, 18 Apr 2025 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988511;
	bh=8A/sIYJ5SKbc782T5XhHrLEMq+A/QJdgAYupGNodiY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/hWodxCNPsy1G6IUlmfsUKPqnT1Ujt4MbzqWbcblOUnrPeC6mUHiaQLG39y8aCpX
	 CqM4lGrfOvsbTyqM0ArrrdiSchD0Xw68g1637tLVyX/a9miA1OW2TXJvaaJKssdA15
	 inuGhv2ZpxgFYHibi/I/56uplFouJCiprgLowDFdyI+DlKXeBDXjv5/ilK8nceskID
	 33KmL/slPYF0SJaOQKKaeK1Y5oGNFE2aC5lj8BAeoOh/smuVOSxzQ777mGw5dvt2gU
	 JYALSfe1bQeiyShNesrRus2B56KAIV2A8kPS//gNu0iYoXVZZSAu0XoWTuho1RFTd7
	 UcpVyOsFppB7Q==
Date: Fri, 18 Apr 2025 08:01:49 -0700
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
Message-ID: <20250418150149.GB1890@quark.localdomain>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
 <20250418033236.GB38960@quark.localdomain>
 <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>
 <20250418040931.GD38960@quark.localdomain>
 <aAIMhLD3UMM41JkT@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAIMhLD3UMM41JkT@gondor.apana.org.au>

On Fri, Apr 18, 2025 at 04:25:40PM +0800, Herbert Xu wrote:
> On Thu, Apr 17, 2025 at 09:09:31PM -0700, Eric Biggers wrote:
> >
> > arch/$ARCH/lib/crypto/ is the "right" way to do it, mirroring lib/crypto/.  I
> > was just hoping to avoid a 4-deep directory.  But we can do it.
> 
> You can do that in a follow-up, assuming nothing else pops for this
> series.

Doing it as a follow-up when this series hasn't been merged yet would be kind of
silly, since it would undo a lot of this series.  I'll just send out a v2 of
this series.

- Eric

