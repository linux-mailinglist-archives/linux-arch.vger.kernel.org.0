Return-Path: <linux-arch+bounces-11608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCAA9DE2D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34AE1A845F6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC701FFC41;
	Sun, 27 Apr 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPyZLOlv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B742A83;
	Sun, 27 Apr 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745715765; cv=none; b=Ul9kI4xQinifjUbMvK3i6ER/B+ylSDCxyQ762YahzayzHYCOUFVPdYUZzs1hpDHKJ9JrDRvshDL37JI/Ff5s5NTRcADMZzJlje6iRVXxvtfubrzW9i2iPdA2omtv8K0P4XUwrS7PtZLhc+AVzYIhaUxOZr5TD9/Lk/qxRPrxvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745715765; c=relaxed/simple;
	bh=MwWC0ebZT3d3MlgdSCMljk/IiWQqDJK/sfFSFFVgLjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIKIWTkuZMIybfEWF43J2/bDRdWU07aaK2TzTUjZU/iuKkApLX9U5ShG4yT60AAgn9cjYCvhOealb88YY2/L+l3cHUn5+BgF3uA3UmdweLsYqYCuCOC/KhkIfLSU1D2mAQN97sW1PrbBdkP2AVX5A/6LTI6XtSAK49ZmrZI88As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPyZLOlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A008C4CEE2;
	Sun, 27 Apr 2025 01:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745715765;
	bh=MwWC0ebZT3d3MlgdSCMljk/IiWQqDJK/sfFSFFVgLjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPyZLOlvkggv+3wlQaPSM6gxDYFrytafe2vABHHUGe/DW28h51dobXwpP5JnZZv8e
	 siueA/NSLIi8nuwG9dfsk1681ilJovb4Z29iknbvMhR8GPTRbN0ZVeKBFFKZOwwljj
	 3U9QNUIWg3TN3LjeAfIWIWZYU3/vTYkS431OGKS6sxinbT9y/6X+clr/wOAXFX7E2r
	 VeFF9mnbIdUIuH/fv/IyMBN/ULQFSIccwdyDW2UT7HFOKtoe4pSnJMpfS90ZAD5CqB
	 IjZesituwcBevS0RAxopmnZA/CE/trjgjd8Bsfakzob1TBrOKKYrpOqivjGk4OuyjL
	 pu9aEs4XUVNSA==
Date: Sat, 26 Apr 2025 18:02:48 -0700
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
Message-ID: <20250427010248.GA68006@quark>
References: <20250426065041.1551914-12-ebiggers@kernel.org>
 <aAy6g3nblKtRj1l3@gondor.apana.org.au>
 <20250426180326.GA1184@sol.localdomain>
 <aA138IKjqyZeQLgB@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA138IKjqyZeQLgB@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 08:18:56AM +0800, Herbert Xu wrote:
> On Sat, Apr 26, 2025 at 11:03:26AM -0700, Eric Biggers wrote:
> >
> > The SHA-256 library functions currently work in any context, and this patch
> > series preserves that behavior.  Changing that would be a separate change.
> 
> I've already removed the SIMD fallback path and your patch is
> adding it back.

While you've been pushing out a lot of random broken changes to shash recently,
the SHA-256 library functions weren't SIMD-optimized until this patchset.

> > But also as I've explained before, for the library API the performance benefit
> > of removing the crypto_simd_usable() doesn't seem to be worth the footgun that
> > would be introduced.  Your position is, effectively, that if someone calls one
> > of the sha256*() functions from a hardirq, we should sometimes corrupt a random
> > task's FPU registers.  That's a really bad bug that is very difficult to
> > root-cause.  My position is that we should make it just work as expected.
> 
> kernel_fpu_begin already does a WARN_ON when called in hardirq
> context and it can't safely use the FPU, there is no silent
> corruption.

Only when CONFIG_X86_DEBUG_FPU is enabled, which people don't enable in
production.  And even if that is enabled, it's just a WARN, so the registers
still get used and corrupted anyway.

- Eric

