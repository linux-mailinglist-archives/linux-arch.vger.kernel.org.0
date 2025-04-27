Return-Path: <linux-arch+bounces-11614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E540BA9DE89
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E51A83F3C
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DC01A8F89;
	Sun, 27 Apr 2025 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCGIitGd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5452C9A;
	Sun, 27 Apr 2025 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745719547; cv=none; b=k1ANYAMhAagkGMHUn51zPAOwghuHXcAhoRBhPc/uM+eNP62xQDiCMNlyxyarX1YOd9Rqhe6Qf9vXqhNXbW1+ZOFyiBpWOr94GsCjhFGtFSaWbxdfborVjxcWQR42SCHiZEqsB5sMpIKK2Sjdl+vlM8FsOwDjr6X4RrgoDYZ33f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745719547; c=relaxed/simple;
	bh=ueSM0+6v5DBafLvS0giIuMW8ulfX++okvZjAf4dve3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qciB4KJrRcZMNCPA0iiYBcLY4JW5Bscp5cjX27gRmt+24SKbUzAYRH3Tdfyg8+y6ystHs5RgyZtKyvPXt7jDEtkdDZS51/s0U8+73+RnCeLbDgYTX99DJy4iMoYXTMv/mTPd1z0K/nA2038fFXCY4tj7xFsXC2NrUuvVTbzWHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCGIitGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BFBC4CEE2;
	Sun, 27 Apr 2025 02:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745719547;
	bh=ueSM0+6v5DBafLvS0giIuMW8ulfX++okvZjAf4dve3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCGIitGddXyxO16n9EzYOnE9TFJ4BfEVtkdwKz80J3E+jJ+T0+5bLKSqz39z0wxx6
	 24UXZR0EAV95qJ5XXRDbMxMqTcdC91UJ7yLt1g+MQAvpXl2yFYqk6BRrAx1lSYwwC8
	 LHzKORO2cK0uy22Iu+7qhNLgVYT6LB5/fpWCPdxXrFFOtVTTL2V9LEsPxWdqhGc2A7
	 i7osVXQPlfyBxVjnBs45A0dvXdXOSHPf+nI4xhzbXVaUZB9uKG1IVo9eUa47IVB0+M
	 NHbrX2DWvuSzqqHrTuZcr4Fs1MlwZNwMqI5u3LGtXpfD1hHL8rZ8mIBjmrzaosKfhS
	 9TnNyl+W7Q6Uw==
Date: Sat, 26 Apr 2025 19:05:50 -0700
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
Message-ID: <20250427020550.GG68006@quark>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
 <20250427011228.GC68006@quark>
 <aA2FqGSHWNO8cRLD@gondor.apana.org.au>
 <20250427015041.GF68006@quark>
 <aA2N6oJ9fQYQUtD4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA2N6oJ9fQYQUtD4@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 09:52:42AM +0800, Herbert Xu wrote:
> On Sat, Apr 26, 2025 at 06:50:41PM -0700, Eric Biggers wrote:
> >
> > But this one does have a lib/crypto/ interface now.  There's no reason not to
> > use it here.
> 
> I need to maintain a consistent export format between shash and
> ahash

Why?  And how is that relevant here, when the export format should just be
struct sha256_state, as it was before?

- Eric

