Return-Path: <linux-arch+bounces-11767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C4CAA599D
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 04:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4133B845C
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4A22DF99;
	Thu,  1 May 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVIMS6EX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62AC2ED;
	Thu,  1 May 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066382; cv=none; b=Ae1kOFRQdOgHeGIw8lFMsE2EEcZYKXGk0iEb9sHR+UYzpMIjWk3MFy3MtUqmbQfttPBPryZ6DXVnkBiWz79TSyoNaZdQYg4c/sbVmVjUUnIxPMrVJIXCaHkFwZ0ryxKGvK5WXmsSiPX7NZpkvKOuAWW/sp1kZWFOx1sFhz5NcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066382; c=relaxed/simple;
	bh=xDvmI+RzBrsAPUkmwQMATcemiN1t9n0AYagyAz0GKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGn6IpZtL8wFeiPe8PRcTg69u49W041oO3AdbNrHPqvIYO6eAiPuPXN9OV8ex8DhOX9FL2hXfalY/6ELhFJeuUY6lPnQJ2kj53zC9DHlahqoeAdAXQDpKVKyR1lSXE2+MYzyHgLMa2U0amczmcVnHTxVPY8jZQa0MFZ3CdXN81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVIMS6EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4EBC4CEE7;
	Thu,  1 May 2025 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746066381;
	bh=xDvmI+RzBrsAPUkmwQMATcemiN1t9n0AYagyAz0GKD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVIMS6EX1bmdbZlCT4Ph9BQSkBsKo1ZZ8cv5kzE4w46J3KEcLVv9IU8J0N+zyXVDh
	 AQh5znq8L73Eebkqo9Roe6Tl62Ut7eDfj7S+TgnQVbe0LlkF9QvY+5jRgMO/I58+Hd
	 DUtTGnQiUls4Cq2vq1gOBHdJSYQrXrUnhN1ltHksGAwh2qLYZDOhdMQfyTqAL8258e
	 EYaDBvVua06TCgkHQsRTxv7B27A5j+kEQQOkOjqMum92sfyZPD0dgF2MTTnz9pQXtS
	 TW38MM3FRjMU3ZHSvSgrLnKmeDJzpKfSfPN84pKFsYNlM2D3IIZyiP174i14GcTTpv
	 XkpcgDRMXkRMw==
Date: Wed, 30 Apr 2025 19:26:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/12] crypto: sha256 - Use partial block API
Message-ID: <20250501022617.GA65059@sol.localdomain>
References: <cover.1745992998.git.herbert@gondor.apana.org.au>
 <20250430174543.GB1958@sol.localdomain>
 <aBLMi5XOQKJyJGu-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBLMi5XOQKJyJGu-@gondor.apana.org.au>

On Thu, May 01, 2025 at 09:21:15AM +0800, Herbert Xu wrote:
> On Wed, Apr 30, 2025 at 10:45:43AM -0700, Eric Biggers wrote:
> >
> > As for your sha256_finup "optimization", it's an interesting idea, but
> > unfortunately it slightly slows down the common case which is count % 64 < 56,
> > due to the unnecessary copy to the stack and the following zeroization.  In the
> > uncommon case where count % 64 >= 56 you do get to pass nblocks=2 to
> > sha256_blocks_*(), but ultimately SHA-256 is serialized block-by-block anyway,
> > so it ends up being only slightly faster in that case, which again is the
> > uncommon case.  So while it's an interesting idea, it doesn't seem to actually
> > be better.  And the fact that that patch is also being used to submit unrelated,
> > more dubious changes isn't very helpful, of course.
> 
> I'm more than willing to change sha256_finup if you can prove it
> with real numbers that it is worse than the single-block version.

Interesting approach -- pushing out misguided optimizations without data, then
demanding data for them to be reverted.  It's obviously worse for
len % 64 < 56 for the reason I gave, so this is a waste of time IMO.  But since
you're insisting on data anyway, here are some quick benchmarks on AMD Zen 5
(not going to bother formatting into a table):

Before your finup "optimization":

 sha256(len=0): 145 cycles
 sha256(len=1): 146 cycles
 sha256(len=2): 146 cycles
 sha256(len=3): 146 cycles
 sha256(len=4): 146 cycles
 sha256(len=5): 146 cycles
 sha256(len=6): 146 cycles
 sha256(len=7): 146 cycles
 sha256(len=8): 151 cycles
 sha256(len=9): 148 cycles
 sha256(len=10): 148 cycles
 sha256(len=11): 148 cycles
 sha256(len=12): 148 cycles
 sha256(len=13): 148 cycles
 sha256(len=14): 148 cycles
 sha256(len=15): 149 cycles
 sha256(len=16): 149 cycles
 sha256(len=17): 148 cycles
 sha256(len=18): 148 cycles
 sha256(len=19): 148 cycles
 sha256(len=20): 148 cycles
 sha256(len=21): 148 cycles
 sha256(len=22): 148 cycles
 sha256(len=23): 148 cycles
 sha256(len=24): 148 cycles
 sha256(len=25): 148 cycles
 sha256(len=26): 148 cycles
 sha256(len=27): 148 cycles
 sha256(len=28): 148 cycles
 sha256(len=29): 148 cycles
 sha256(len=30): 148 cycles
 sha256(len=31): 148 cycles
 sha256(len=32): 151 cycles
 sha256(len=33): 148 cycles
 sha256(len=34): 148 cycles
 sha256(len=35): 148 cycles
 sha256(len=36): 148 cycles
 sha256(len=37): 148 cycles
 sha256(len=38): 148 cycles
 sha256(len=39): 148 cycles
 sha256(len=40): 148 cycles
 sha256(len=41): 148 cycles
 sha256(len=42): 148 cycles
 sha256(len=43): 148 cycles
 sha256(len=44): 148 cycles
 sha256(len=45): 148 cycles
 sha256(len=46): 150 cycles
 sha256(len=47): 149 cycles
 sha256(len=48): 147 cycles
 sha256(len=49): 147 cycles
 sha256(len=50): 147 cycles
 sha256(len=51): 147 cycles
 sha256(len=52): 147 cycles
 sha256(len=53): 147 cycles
 sha256(len=54): 147 cycles
 sha256(len=55): 148 cycles
 sha256(len=56): 278 cycles
 sha256(len=57): 278 cycles
 sha256(len=58): 278 cycles
 sha256(len=59): 278 cycles
 sha256(len=60): 277 cycles
 sha256(len=61): 277 cycles
 sha256(len=62): 277 cycles
 sha256(len=63): 276 cycles
 sha256(len=64): 276 cycles

After your finup "optimization":

 sha256(len=0): 188 cycles
 sha256(len=1): 190 cycles
 sha256(len=2): 190 cycles
 sha256(len=3): 190 cycles
 sha256(len=4): 189 cycles
 sha256(len=5): 189 cycles
 sha256(len=6): 189 cycles
 sha256(len=7): 190 cycles
 sha256(len=8): 187 cycles
 sha256(len=9): 188 cycles
 sha256(len=10): 188 cycles
 sha256(len=11): 188 cycles
 sha256(len=12): 189 cycles
 sha256(len=13): 189 cycles
 sha256(len=14): 188 cycles
 sha256(len=15): 189 cycles
 sha256(len=16): 189 cycles
 sha256(len=17): 190 cycles
 sha256(len=18): 190 cycles
 sha256(len=19): 190 cycles
 sha256(len=20): 190 cycles
 sha256(len=21): 190 cycles
 sha256(len=22): 190 cycles
 sha256(len=23): 190 cycles
 sha256(len=24): 191 cycles
 sha256(len=25): 191 cycles
 sha256(len=26): 191 cycles
 sha256(len=27): 191 cycles
 sha256(len=28): 191 cycles
 sha256(len=29): 192 cycles
 sha256(len=30): 191 cycles
 sha256(len=31): 191 cycles
 sha256(len=32): 191 cycles
 sha256(len=33): 191 cycles
 sha256(len=34): 191 cycles
 sha256(len=35): 191 cycles
 sha256(len=36): 192 cycles
 sha256(len=37): 192 cycles
 sha256(len=38): 192 cycles
 sha256(len=39): 191 cycles
 sha256(len=40): 191 cycles
 sha256(len=41): 194 cycles
 sha256(len=42): 193 cycles
 sha256(len=43): 193 cycles
 sha256(len=44): 193 cycles
 sha256(len=45): 193 cycles
 sha256(len=46): 194 cycles
 sha256(len=47): 194 cycles
 sha256(len=48): 193 cycles
 sha256(len=49): 195 cycles
 sha256(len=50): 195 cycles
 sha256(len=51): 196 cycles
 sha256(len=52): 196 cycles
 sha256(len=53): 195 cycles
 sha256(len=54): 195 cycles
 sha256(len=55): 195 cycles
 sha256(len=56): 297 cycles
 sha256(len=57): 297 cycles
 sha256(len=58): 297 cycles
 sha256(len=59): 297 cycles
 sha256(len=60): 297 cycles
 sha256(len=61): 297 cycles
 sha256(len=62): 297 cycles
 sha256(len=63): 297 cycles
 sha256(len=64): 292 cycles

So your "optimization" made it ~43 cycles slower for len % 64 < 56, or ~19
cycles slower for len % 64 >= 56.

As I said, it's from the overhead of unnecessarily copying the data onto the
stack and then having to zeroize it at the end.

- Eric

