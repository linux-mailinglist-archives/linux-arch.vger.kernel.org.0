Return-Path: <linux-arch+bounces-11606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC1A9DCB6
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD21B639E2
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4625D8F3;
	Sat, 26 Apr 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAIxHEC/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344797E110;
	Sat, 26 Apr 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745690609; cv=none; b=saujoxRmjQ9XHEK6REVMA0X1opnRxC467toBl7nEtbWzQDCYLW5n5CJnH9WjNs6l+uO9knjKqO8O9ouOfkuTd0zX0I8G9B45E3MPUSp/KJDfIXmP6rm+BhU0Tfxs5ALekZ+ZbleeZdx5qqDLrhLZFOOzxC/i3aYoPr81Kzj/YcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745690609; c=relaxed/simple;
	bh=thPYajZSkuIUqKSQ0PKrjdP700DcSK2zwAu2Gky2T80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsC0QOWAIu4XUqFxjJcTrGlll4PmDrzRsoPly9KFq4dgg3F4fGPbpZu2tjW9FhNE6WPzsKSHuGSJbsZKHNkc+Zxib8kyWf2qPh2cPWGjh9L6tG/p+zJclW2e8wCH8TOuAruQceVJirwdhqqof7IAQ4XvFRFK9mfBU28hAzrtv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAIxHEC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C994C4CEE2;
	Sat, 26 Apr 2025 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745690608;
	bh=thPYajZSkuIUqKSQ0PKrjdP700DcSK2zwAu2Gky2T80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAIxHEC/RBFXC7YAAr3+tsr8rzEcee3Oga1vMPOVdLEclJGRGGYsap6d40ssYdREa
	 631y8iWvrWajenPInP5JKnMuJ2fzsFVn4xbQ/K+cHhgPVnyuchNRRoD0ozvKffZkS3
	 MqUsr8paPOUnFmn+B8HDI8yKlJGh1TXUf3fq6tuJ1SIjPZir6nq73386jFGlYKnBTI
	 uo2ZHr9L3pkwpshwb0rthNh+eao6mVOKjQYtoSDUrpgKEgzJXu+h6VzFzy4Z/K4auE
	 MgMeah9RtM9RNppv7fmQMq0y8aXytAvAE0U5aitXE09LbzHtDgGADWAkJrVYOWn55s
	 dQXkKhP5hQ5yw==
Date: Sat, 26 Apr 2025 11:03:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/13] crypto: x86/sha256 - implement library instead of
 shash
Message-ID: <20250426180326.GA1184@sol.localdomain>
References: <20250426065041.1551914-12-ebiggers@kernel.org>
 <aAy6g3nblKtRj1l3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAy6g3nblKtRj1l3@gondor.apana.org.au>

On Sat, Apr 26, 2025 at 06:50:43PM +0800, Herbert Xu wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > +void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
> > +                       const u8 *data, size_t nblocks)
> > +{
> > +       if (static_branch_likely(&have_sha256_x86) && crypto_simd_usable()) {
> > +               kernel_fpu_begin();
> > +               static_call(sha256_blocks_x86)(state, data, nblocks);
> > +               kernel_fpu_end();
> > +       } else {
> > +               sha256_blocks_generic(state, data, nblocks);
> > +       }
> 
> Why did you restore the SIMD fallback path? Please provide a real
> use-case for doing SHA2 in a hardirq or I'll just remove it again.

The SHA-256 library functions currently work in any context, and this patch
series preserves that behavior.  Changing that would be a separate change.

But also as I've explained before, for the library API the performance benefit
of removing the crypto_simd_usable() doesn't seem to be worth the footgun that
would be introduced.  Your position is, effectively, that if someone calls one
of the sha256*() functions from a hardirq, we should sometimes corrupt a random
task's FPU registers.  That's a really bad bug that is very difficult to
root-cause.  My position is that we should make it just work as expected.

Yes, no one *should* be doing SHA-256 in a hardirq.  But I don't think that
means we should corrupt a random task's FPU registers if someone doesn't follow
best practices, when we can easily make the API just work as expected.

- Eric

