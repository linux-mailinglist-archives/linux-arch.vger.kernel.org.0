Return-Path: <linux-arch+bounces-11610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A72A9DE44
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B4F5A3096
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CE227E8B;
	Sun, 27 Apr 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGr63U24"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D501922DD;
	Sun, 27 Apr 2025 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716346; cv=none; b=KJ/GztxdPpe4lhGBtdfyVRnF4kZcNA2OQyl5t11F14lVr1taE3WdheeiPAIbUdH23Trmcmuw0acy+/zF1XVvJZ+7uP+fc+h2xiCz4rKTX38y/7Ry2OH9duzJkcKh8+DFlNcyeBZ3/pcKhh9QfOlArfNOJoG6lGnYoc3k2P7/1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716346; c=relaxed/simple;
	bh=XtR2f2thGcnDYbhl0pb+41JAmRYzjJrz7p093kCXmZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxXIVvu4GT5SuFDTGcvzrRpz8PpXRMyFT1le+kb12ml4EmnjAAxALWkc3VbPMi1w8nCjXTrWMP1TSuMj2XVM1OYFtQd8hhYIpOA7HIJ9sBc0alWop2HlRzgWKgvmyN0Bc7tAs1NHZV4eOl2af9tKbrgXcGW21hQ7EzOSYyr27Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGr63U24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15DFC4CEE2;
	Sun, 27 Apr 2025 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745716345;
	bh=XtR2f2thGcnDYbhl0pb+41JAmRYzjJrz7p093kCXmZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGr63U24Gm8hRXTQSMA4lzYe51LBc4e4LKosvkah6KUyAMJnYCNTl7qlYhU9meJPQ
	 JXkGSHgyHAyGkABiWTxETPK9T9HG/YCslPrpz1C2Rd8U2nORRVXbC4q/iDWve+GK82
	 tKfCzgcrJ9AoZEh29PMKmsJJndXIegAqGM6CXLVC0Jh29/H7Y2m/d6O+p5ZDEL/K1B
	 BsxWASsxCYPCjwizywmWlK+UzpRcqKy6xOMgy1n/V4zXZhtyAWrSPPp7i+Xo/4/X0e
	 Daye4QLiZSXNkXPQd/hQ2xs+4CCmLsIfbjf9n7+azNxdTbZM9lQ7Q5y3du8vu544X9
	 Trq6TtAEEdGeA==
Date: Sat, 26 Apr 2025 18:12:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/13] crypto: sha256 - support arch-optimized lib and
 expose through shash
Message-ID: <20250427011228.GC68006@quark>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA2DKzOh8xhCYY8C@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 09:06:51AM +0800, Herbert Xu wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > +static int crypto_sha256_update_arch(struct shash_desc *desc, const u8 *data,
> > +                                    unsigned int len)
> > +{
> > +       sha256_update(shash_desc_ctx(desc), data, len);
> > +       return 0;
> > +}
> 
> Please use the block functions directly in the shash implementation.

No, that would be silly.  I'm not doing that.  The full update including the
partial block handling is already needed in the library.  There is no need to
implement it again at the shash level.

- Eric

