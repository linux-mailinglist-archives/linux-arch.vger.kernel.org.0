Return-Path: <linux-arch+bounces-11612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DCA9DE7D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338397A9599
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1721ACEDF;
	Sun, 27 Apr 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3hPlaXq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901A2B9BC;
	Sun, 27 Apr 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745718638; cv=none; b=DRDKL6fN6b5e6fdddT0TfYe366BTAWjo+BPTaK5XS5Fi+GlW9T7bcex1R23nYBLJ0vCe/2QQ5olrxPbRQG3Yn5gEhQaOP2UIqZww5lF3W9lJe+scBoLjOxjvx4H34DwcE6E5iLbpIHgwjv0uyhKpLKpJr2pj6PD7QXmG/bXvTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745718638; c=relaxed/simple;
	bh=e/U2hXsUieq0eplDUQMGjtnd+RdUdFnygdx2mCJfSjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLjkCFf4Do0kNC8vbBWtfQ90HgmJiyr9moJ3gPkJWFMyJ4TC4bu/JSXtLqGhWziHkUZNWtfmmJc+eUFSZeNFcuN9ZLW9pVDqLMq+iM7qA3fGZd1+rO36rZWNfQ2b9RZ2RurRh5ua3jSZioAxvc7BE4bgwDTm4rHTPYMGU3/qync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3hPlaXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A863C4CEE2;
	Sun, 27 Apr 2025 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745718637;
	bh=e/U2hXsUieq0eplDUQMGjtnd+RdUdFnygdx2mCJfSjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3hPlaXqbKMOOByqg0xO9XDGFN1r/8wVmxH9kT35oxzYfPaLGXzTgbk9sGuMRtTvt
	 44bXMlBlBZQMn8Ipp3JoqeVYAXxD538C1X82i3+WBwshE/qw9nPHmadZjz3sDag3pe
	 JEMPB13QpuEDebnwb5LL7f1z8/SGor7fWyhIXtEz2xGDz/C8I7rNgHiUFkybydeuCe
	 Ro3xou/0TbbO2aRPHU0DEuogQgtgdvMdA5WHna4/b4PQ7kTpgKpaJar1ue9GFDud7L
	 58cp3jMvLW6iFrbLOFJHG9nwrGeuGyAlLwD3YpV4I/HWA3G9v2H3W2WGYZSzk4OmcU
	 KiZ54jDdhgXpw==
Date: Sat, 26 Apr 2025 18:50:41 -0700
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
Message-ID: <20250427015041.GF68006@quark>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
 <20250427011228.GC68006@quark>
 <aA2FqGSHWNO8cRLD@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA2FqGSHWNO8cRLD@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 09:17:28AM +0800, Herbert Xu wrote:
> On Sat, Apr 26, 2025 at 06:12:28PM -0700, Eric Biggers wrote:
> >
> > No, that would be silly.  I'm not doing that.  The full update including the
> > partial block handling is already needed in the library.  There is no need to
> > implement it again at the shash level.
> 
> shash implements a lot more algorithms than the lib/crypto interface.
> If you won't do this then I'll just do it instead.

But this one does have a lib/crypto/ interface now.  There's no reason not to
use it here.

- Eric

