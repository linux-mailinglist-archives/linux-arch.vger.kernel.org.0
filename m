Return-Path: <linux-arch+bounces-11631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E464BA9E2F9
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43211174B2D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427903FFD;
	Sun, 27 Apr 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/bC3K8g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405423DE;
	Sun, 27 Apr 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757310; cv=none; b=to+7c8oAijA8FFlQno39SG8pNyLlRYhEVG7Kc5+ya1uTMXnMQymSu/Y7L4n+XGOoTecMQ/zlzDP6V8w13/2sergUc1XWiJQXKxqoIDYqNwoWNrc8wVusEMn/87NDjAHCD4OvBNWYaaUQ0abpn7vneNk2IcY60hKBzjjf4T4YkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757310; c=relaxed/simple;
	bh=+fG06d9jSSQdeLJWYT8qSWyP0TU2u5CifNzbFJ/XfgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMsP+D1KsLlmNcg6p2UfyYxcj7cSnvBw5uCuck9lSNL0yzUdsrnemgagpc5rvMZ8mZZNGlOfErRgXuBxII1sIpcwCV+nRRjETpw3BZ9JTe6R1hqziNY23O2kuAqbDOI9LFg7QJ1MwdS5COn76FKs6KgbHqHEe45S3DxKxBuM5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/bC3K8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C871EC4CEE3;
	Sun, 27 Apr 2025 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745757309;
	bh=+fG06d9jSSQdeLJWYT8qSWyP0TU2u5CifNzbFJ/XfgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/bC3K8gVx5897sx0m9B41J6wHjyFDFZgASHs9iyreaRRk2MKpyYUHIChH0IMZ+YE
	 CzZkzcFERGfABqvMeyokm38y2VZH1t5PXI3jqlNLj31O6QzfV4ZyHuWpQD5SufL8sh
	 rMNwaM4baXS3hhq65SxgADqCkLMyuW5V/NMVsX9ArKa0gLMzlxZ3ipvrpf8J83tU+o
	 uflwveBrQ+n/Bix3Mc+6fn73BsQynQkFCU+yjw5oweub/OLg/mgN4a2AvYIkGcsQxu
	 WG/oK62LsN1zFPX/8VNMqn7nvg/p7bTy/cbZYyeFB1PCxyrBqaBIAWTWK+La5mkmHu
	 OvCP4g5GpgVHQ==
Date: Sun, 27 Apr 2025 05:35:14 -0700
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
Message-ID: <20250427123514.GA1161@quark>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>

On Sun, Apr 27, 2025 at 02:30:41PM +0800, Herbert Xu wrote:
> Changes in v2:
> - Rebase on top of lib partial block helper series.
> - Restore the block-only shash implementation of sha256.
> - Move the SIMD hardirq test out of the block functions so that
>   it is only done for the lib/crypto interface.
> - Split the lib/crypto sha256 module to break cycle in allmod build.
> 
> This is based on
> 
> 	https://patchwork.kernel.org/project/linux-crypto/list/?series=957415

Well, barely a day and you've already ruined my patch series.  Now instead of a
clean design where the crypto_shash API is built on top of the normal library
API (sha256_update() etc.), there's now a special low-level API
"sha256_choose_blocks()" just for shash that it's built on top of instead, for
no good reason.  You're also still pushing your broken BLOCK_HASH_UPDATE_BLOCKS
macro that doesn't work with size_t, and putting my name on your broken code
that uses it.

And yes, sorry about the allmodconfig build error.  It just means that the
generic code needs to be split into its own module, like how curve25519 works.
I'll post a new version with that fixed and your gratuitous changes undone.

- Eric

