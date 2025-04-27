Return-Path: <linux-arch+bounces-11633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF924A9E324
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BAB7AFFCA
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE013FD86;
	Sun, 27 Apr 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV/qYJtt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9F8F6F;
	Sun, 27 Apr 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758597; cv=none; b=VHZqeepea4RmJ7rKFR7MnWfgotSmbSm7s7DLv65Ns0Fb/CwRIgcaAHh+AIHzQGw0Vh4cbOe/OKHtJ7Yj08ORkeL8ocqxgMA6ZpQjBC6APDOsBDYocof3rjky35Yo28UvPbQdJIMr9WjviiqKafKGW1qh5d4TZ9q8RUTpWxQnNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758597; c=relaxed/simple;
	bh=AgqV1hMsSjVwY25pYZciWVxf7VAWpBvP9JfqHyR35EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6b880KcCZ0eq7TMRE5USqL9qMUx73jXHI93vC3FjFwH/c2gbgy8ypnZ03+V0VXaJmi3cmkqu+NLKlmfntIASIad2h9+LdC0D3+UPLpwYHdISqztpu+vEn2o+Cg54bVW+D67nFeHsQvxR96Fbo34BXqPAgOw2mQwKl1GkBAxXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV/qYJtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD42C4CEE3;
	Sun, 27 Apr 2025 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745758596;
	bh=AgqV1hMsSjVwY25pYZciWVxf7VAWpBvP9JfqHyR35EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qV/qYJttnMqF/e8OqPLChbglT+OXe0BUI3C3XJkFZdTZhhNyHpOmlW5bb+1pxLyao
	 gwGGLC+l03/YlzGd5+J56KHsYr0ohKSxDi747S0hGoCacZJ2qaaZmYUqJ2US3FnkyK
	 Tu/o38Ex6SQrwWRr+GMMtqdU70l2SZNmFzlAG7PYaH28iELmPY1EI0osYVw1sYYhyG
	 uGzqeuOneXyF0+JHSk9mnATjjGPRJIaqEHig6iKUkyyMDrwIc+ilmnaGMs99Mvxqgv
	 8h/Ac2RS79Wo+V7nYuNH9MBFb5lhQYMARyeMIsV0ibobHTJbQn5pg36EgAkKZDDFP6
	 PxMIuzZeFmMsQ==
Date: Sun, 27 Apr 2025 05:56:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v2 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <20250427125641.GB1161@quark>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
 <20250427123514.GA1161@quark>
 <aA4mAlozk3RvxvTe@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA4mAlozk3RvxvTe@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 08:41:38PM +0800, Herbert Xu wrote:
> On Sun, Apr 27, 2025 at 05:35:14AM -0700, Eric Biggers wrote:
> >
> > Well, barely a day and you've already ruined my patch series.  Now instead of a
> > clean design where the crypto_shash API is built on top of the normal library
> > API (sha256_update() etc.), there's now a special low-level API
> > "sha256_choose_blocks()" just for shash that it's built on top of instead, for
> > no good reason.  You're also still pushing your broken BLOCK_HASH_UPDATE_BLOCKS
> > macro that doesn't work with size_t, and putting my name on your broken code
> > that uses it.
> 
> Your design is unacceptable because you're forcing the partial block
> handling on shash where it's not needed,

Excuse me?  It's the other way around.  In my version the partial block handling
is only in the library, not shash.  In your version you've forced it into the
shash layer, even though the library does it already.  I understand that you've
added support for partial block handling to crypto/shash.c and you want to feel
like your work is useful, but in this case it's not, since the libray has to
handle arbitrary-length inputs anyway.

> just as you're forcing the hardirq support on everything.

If you want crypto_shash to warn on hardirq usage you should just put a
WARN_ON(in_hardirq()) in crypto_shash_*(), which will actually achieve that.
Not add a shash-specific non-hardirq-safe low-level API to the library that can
silently corrupt random tasks' SIMD registers on production systems.

- Eric

