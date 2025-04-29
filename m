Return-Path: <linux-arch+bounces-11720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1DAA1312
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 19:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E97A1BA636D
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E43247291;
	Tue, 29 Apr 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfHRE0Zf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D924A047;
	Tue, 29 Apr 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945872; cv=none; b=u2/6ifII56JyZg3an4doJxwaOEBC5vAwYnzwEC/E2qQ00n7bivfCxkAY+IAzzFYwcF0MM9XPghG+S0KFA0UukzEz0IVCHYvFvGD1w3mBRItIIBKN1XgWN7kWPe18rIiGxiviheB8WGOaRMt8UvvM9F91bB4dTyqKJ4PBrvMg9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945872; c=relaxed/simple;
	bh=Tg1ctzwo0ak0Lwu1YWKgH+RS3fovIZ1X+v294BjOsH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5eCeW9G/DNrxqMjMeS6kxib+gjQYz9CyZqnoldd0kEhlNgvIhtYcLWjQJq+9WiISZJbe+qFCxeGivQqm99xdgA6mmTEx18ceZLowYpXXm2ntArkAC2GRkoklRfWlzPeOGa9RSqWdP8nVRMQN68t7TLdLn0sT9rNvF8YC8jIK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfHRE0Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3CC4CEEA;
	Tue, 29 Apr 2025 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945871;
	bh=Tg1ctzwo0ak0Lwu1YWKgH+RS3fovIZ1X+v294BjOsH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfHRE0ZfOmDAVECATIVhnIIEDv8InpF/NVtbUFhMnpUd0U4Y+5b0Ww4zgRVL1MNmR
	 u8gCoUF2f9BknbD6Z34UXG4o4jeie06f9l37yhBS9hg7PyyZPh0t76hiNmFRLKGGi5
	 iEyi9z3gFBB3tX3cQpD1giyD3J3AvQz31/yIHy3BsfSa938ZSffUIHVakH6CrbbrdF
	 VDAjwRavumw/UONhO/E9zhOSkKcu9AG/KUZggezyKAUSbacO11GC7UHvJUwjFrcjyu
	 f0RJmP3EuGwQ5b0kiClDl4KQSZySaB5MQps8Q90qLLDnvzKrTossosvNsmID5DJOBH
	 TIWeglu12AohQ==
Date: Tue, 29 Apr 2025 09:57:49 -0700
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
Subject: Re: [v3 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <20250429165749.GC1743@sol.localdomain>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745816372.git.herbert@gondor.apana.org.au>

On Mon, Apr 28, 2025 at 01:17:02PM +0800, Herbert Xu wrote:
> Changes in v3:
> - Add shash sha256-lib/sha224-lib to provide test coverage for libsha256.
> 
> This is based on
> 
> 	https://patchwork.kernel.org/project/linux-crypto/list/?series=957558
> 
> Original description:
> 
> Following the example of several other algorithms (e.g. CRC32, ChaCha,
> Poly1305, BLAKE2s), this series refactors the kernel's existing
> architecture-optimized SHA-256 code to be available via the library API,
> instead of just via the crypto_shash API as it was before.  It also
> reimplements the SHA-256 crypto_shash API on top of the library API.
> 
> This makes it possible to use the SHA-256 library in
> performance-critical cases.  The new design is also much simpler, with a
> negative diffstat of over 1200 lines.  Finally, this also fixes the
> longstanding issue where the arch-optimized SHA-256 was disabled by
> default, so people often forgot to enable it.
> 
> For now the SHA-256 library is well-covered by the crypto_shash
> self-tests, but I plan to add a test for the library directly later.
> I've fully tested this series on arm, arm64, riscv, and x86.  On mips,
> powerpc, s390, and sparc I've only been able to partially test it, since
> QEMU does not support the SHA-256 instructions on those platforms.  If
> anyone with access to a mips, powerpc, s390, or sparc system that has
> SHA-256 instructions can verify that the crypto self-tests still pass,
> that would be appreciated.  But I don't expect any issues, especially
> since the new code is more straightforward than the old code.
> 
> Eric Biggers (13):
>   crypto: sha256 - support arch-optimized lib and expose through shash
>   crypto: arm/sha256 - implement library instead of shash
>   crypto: arm64/sha256 - remove obsolete chunking logic
>   crypto: arm64/sha256 - implement library instead of shash
>   crypto: mips/sha256 - implement library instead of shash
>   crypto: powerpc/sha256 - implement library instead of shash
>   crypto: riscv/sha256 - implement library instead of shash
>   crypto: s390/sha256 - implement library instead of shash
>   crypto: sparc - move opcodes.h into asm directory
>   crypto: sparc/sha256 - implement library instead of shash
>   crypto: x86/sha256 - implement library instead of shash
>   crypto: sha256 - remove sha256_base.h
>   crypto: lib/sha256 - improve function prototypes

To be clear, the objections I have on your v2 patchset still hold.  Your
unsolicited changes to my patches add unnecessary complexity and redundancy,
make the crypto_shash API even harder to use correctly, and also break the build
for several architectures.  If you're going to again use your maintainer
privileges to push these out anyway over my objections, I'd appreciate it if you
at least made your dubious changes as incremental patches using your own
authorship so that they can be properly reviewed/blamed.

Please also note that I've sent a v4 which fixes the one real issue that my v1
patchset had: https://lore.kernel.org/r/20250428170040.423825-1-ebiggers@kernel.org

- Eric

