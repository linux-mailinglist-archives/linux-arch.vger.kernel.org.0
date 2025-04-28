Return-Path: <linux-arch+bounces-11651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11745A9EFB2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAFA1710F3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89519264FB0;
	Mon, 28 Apr 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="F9HnbTnW"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF44A21;
	Mon, 28 Apr 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841200; cv=none; b=gjulGnp/PPKy/bleFsxs9bES0rey55yBTf+yQn5omP0oDsEKPEkxZrGO6qQEoL7qdR2cnQsYG57EssmNqIJDf+ndslH3uPAMjX6+F9WlZokrcgzlEMTSvTe+toWeVRdR5nLjpJc+nRgizhew2rX8jOu/OrMNcXkyHLhgmcfY4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841200; c=relaxed/simple;
	bh=Sk7QTKYQHpO4MpyZjQ/Sv46Iq1zpM+5CWnp31Eg8Sy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GG/cGzPfJvKnsZMPy4sKm4X+sXIn2Xw0aGdRsqsplGX4aMXpqbfu3WO5HvhrvuzhPnlvfxapCULPrwKW7jhkHnXPmUP+/u4zxbpK2SijUkkSr5C9GqnDupxvoXQ205N397GJiSPj1uJthHjcAIbIkMFvRbeJMPF3zIHo+OvUTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=F9HnbTnW; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8T1VCs93WeCfIwMLTXrgNJ1jyLMDpCR3K8Uym9nsnV4=; b=F9HnbTnW/poPgQVr/cZWd+pwSz
	2p1UYqYxeKKqwA8eoU4d9x1FUmWqDFUKj4m1rUYjb/NZ9L/ay2spOHSOBLPXjjOkgGBjoE2P9jaY0
	SO6fLRcrPnA4AqqV6iTh6DthFMKWQ5y+2BNRYeq6kcb0mNigo2TQnP1X+8q2t4Cf/E71Dp+6Lc2iG
	rTQFgMhEtDcoE4KDOvGEy2T8moHCtm+9KViSFwmLwa/1cvp4ub/24zEUUuztEGO5LleSISGHI99Tf
	g1Z9Vys8EoAA69OOsZwOKwArWjMhPqhm7YMnEeA5etXfn6zfP8eJ1HnmeULhjUSmQB4vIUfCLIheP
	SY6L1ryw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9N2q-001bJS-2Z;
	Mon, 28 Apr 2025 19:53:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 19:53:08 +0800
Date: Mon, 28 Apr 2025 19:53:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org
Subject: Re: [PATCH v3 00/13] Finish disentangling ChaCha, Poly1305, and
 BLAKE2s from CRYPTO
Message-ID: <aA9sJKUjfhRPMWSo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422152716.5923-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> This series removes the unnecessary dependency of the ChaCha, Poly1305,
> and BLAKE2s library functions on the generic crypto infrastructure, i.e.
> CONFIG_CRYPTO.  To do this, it moves the architecture-optimized
> implementations of these functions into new directories
> arch/*/lib/crypto/ which do not depend on CRYPTO.  This mirrors the
> existing distinction between crypto/ and lib/crypto/.
> 
> The last two patches remove the selection of CRYPTO by CRYPTO_LIB_CHACHA
> and CRYPTO_LIB_POLY1305, and they remove the corresponding *_INTERNAL
> symbols which were needed only because of the entanglement with CRYPTO.
> 
> Note that Curve25519 is still entangled.  Later patches will fix that.
> 
> Changed in v3:
>   - Fixed build error on arm with CONFIG_CPU_THUMBONLY=y.
>   - Small whitespace and commit message fixes.
>   - Added Acked-by's.
> 
> Changed in v2:
>   - Introduced new directories arch/*/lib/crypto/ instead of keeping
>     the library functions in arch/*/crypto/.
> 
> Eric Biggers (13):
>  crypto: arm64 - drop redundant dependencies on ARM64
>  crypto: powerpc - drop redundant dependencies on PPC
>  crypto: s390 - drop redundant dependencies on S390
>  crypto: x86 - drop redundant dependencies on X86
>  crypto: arm - move library functions to arch/arm/lib/crypto/
>  crypto: arm64 - move library functions to arch/arm64/lib/crypto/
>  crypto: mips - move library functions to arch/mips/lib/crypto/
>  crypto: powerpc - move library functions to arch/powerpc/lib/crypto/
>  crypto: riscv - move library functions to arch/riscv/lib/crypto/
>  crypto: s390 - move library functions to arch/s390/lib/crypto/
>  crypto: x86 - move library functions to arch/x86/lib/crypto/
>  crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
>  crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO
> 
> MAINTAINERS                                   |  1 +
> arch/arm/crypto/Kconfig                       | 23 -----
> arch/arm/crypto/Makefile                      | 14 +--
> arch/arm/lib/Makefile                         |  2 +
> arch/arm/lib/crypto/.gitignore                |  2 +
> arch/arm/lib/crypto/Kconfig                   | 24 ++++++
> arch/arm/lib/crypto/Makefile                  | 26 ++++++
> arch/arm/{ => lib}/crypto/blake2s-core.S      |  0
> arch/arm/{ => lib}/crypto/blake2s-glue.c      |  0
> arch/arm/{ => lib}/crypto/chacha-glue.c       |  0
> arch/arm/{ => lib}/crypto/chacha-neon-core.S  |  0
> .../arm/{ => lib}/crypto/chacha-scalar-core.S |  0
> arch/arm/{ => lib}/crypto/poly1305-armv4.pl   |  0
> arch/arm/{ => lib}/crypto/poly1305-glue.c     |  0
> arch/arm64/crypto/Kconfig                     | 17 +---
> arch/arm64/crypto/Makefile                    |  9 +-
> arch/arm64/lib/Makefile                       |  3 +
> arch/arm64/lib/crypto/.gitignore              |  2 +
> arch/arm64/lib/crypto/Kconfig                 | 14 +++
> arch/arm64/lib/crypto/Makefile                | 16 ++++
> .../arm64/{ => lib}/crypto/chacha-neon-core.S |  0
> .../arm64/{ => lib}/crypto/chacha-neon-glue.c |  0
> arch/arm64/{ => lib}/crypto/poly1305-armv8.pl |  0
> arch/arm64/{ => lib}/crypto/poly1305-glue.c   |  0
> arch/mips/crypto/Kconfig                      | 11 ---
> arch/mips/crypto/Makefile                     | 17 ----
> arch/mips/lib/Makefile                        |  2 +
> arch/mips/lib/crypto/.gitignore               |  2 +
> arch/mips/lib/crypto/Kconfig                  | 12 +++
> arch/mips/lib/crypto/Makefile                 | 19 ++++
> arch/mips/{ => lib}/crypto/chacha-core.S      |  0
> arch/mips/{ => lib}/crypto/chacha-glue.c      |  0
> arch/mips/{ => lib}/crypto/poly1305-glue.c    |  0
> arch/mips/{ => lib}/crypto/poly1305-mips.pl   |  0
> arch/powerpc/crypto/Kconfig                   | 22 +----
> arch/powerpc/crypto/Makefile                  |  4 -
> arch/powerpc/lib/Makefile                     |  2 +
> arch/powerpc/lib/crypto/Kconfig               | 15 ++++
> arch/powerpc/lib/crypto/Makefile              |  7 ++
> .../{ => lib}/crypto/chacha-p10-glue.c        |  0
> .../{ => lib}/crypto/chacha-p10le-8x.S        |  0
> .../{ => lib}/crypto/poly1305-p10-glue.c      |  0
> .../{ => lib}/crypto/poly1305-p10le_64.S      |  0
> arch/riscv/crypto/Kconfig                     |  7 --
> arch/riscv/crypto/Makefile                    |  3 -
> arch/riscv/lib/Makefile                       |  1 +
> arch/riscv/lib/crypto/Kconfig                 |  8 ++
> arch/riscv/lib/crypto/Makefile                |  4 +
> .../{ => lib}/crypto/chacha-riscv64-glue.c    |  0
> .../{ => lib}/crypto/chacha-riscv64-zvkb.S    |  0
> arch/s390/crypto/Kconfig                      | 16 ----
> arch/s390/crypto/Makefile                     |  3 -
> arch/s390/lib/Makefile                        |  1 +
> arch/s390/lib/crypto/Kconfig                  |  7 ++
> arch/s390/lib/crypto/Makefile                 |  4 +
> arch/s390/{ => lib}/crypto/chacha-glue.c      |  0
> arch/s390/{ => lib}/crypto/chacha-s390.S      |  0
> arch/s390/{ => lib}/crypto/chacha-s390.h      |  0
> arch/x86/crypto/Kconfig                       | 86 +++++++------------
> arch/x86/crypto/Makefile                      | 15 ----
> arch/x86/lib/Makefile                         |  2 +
> arch/x86/lib/crypto/.gitignore                |  2 +
> arch/x86/lib/crypto/Kconfig                   | 26 ++++++
> arch/x86/lib/crypto/Makefile                  | 17 ++++
> arch/x86/{ => lib}/crypto/blake2s-core.S      |  0
> arch/x86/{ => lib}/crypto/blake2s-glue.c      |  0
> .../x86/{ => lib}/crypto/chacha-avx2-x86_64.S |  0
> .../{ => lib}/crypto/chacha-avx512vl-x86_64.S |  0
> .../{ => lib}/crypto/chacha-ssse3-x86_64.S    |  0
> arch/x86/{ => lib}/crypto/chacha_glue.c       |  0
> .../crypto/poly1305-x86_64-cryptogams.pl      |  0
> arch/x86/{ => lib}/crypto/poly1305_glue.c     |  0
> crypto/Kconfig                                |  4 +-
> lib/crypto/Kconfig                            | 56 +++++++-----
> 74 files changed, 294 insertions(+), 234 deletions(-)
> create mode 100644 arch/arm/lib/crypto/.gitignore
> create mode 100644 arch/arm/lib/crypto/Kconfig
> create mode 100644 arch/arm/lib/crypto/Makefile
> rename arch/arm/{ => lib}/crypto/blake2s-core.S (100%)
> rename arch/arm/{ => lib}/crypto/blake2s-glue.c (100%)
> rename arch/arm/{ => lib}/crypto/chacha-glue.c (100%)
> rename arch/arm/{ => lib}/crypto/chacha-neon-core.S (100%)
> rename arch/arm/{ => lib}/crypto/chacha-scalar-core.S (100%)
> rename arch/arm/{ => lib}/crypto/poly1305-armv4.pl (100%)
> rename arch/arm/{ => lib}/crypto/poly1305-glue.c (100%)
> create mode 100644 arch/arm64/lib/crypto/.gitignore
> create mode 100644 arch/arm64/lib/crypto/Kconfig
> create mode 100644 arch/arm64/lib/crypto/Makefile
> rename arch/arm64/{ => lib}/crypto/chacha-neon-core.S (100%)
> rename arch/arm64/{ => lib}/crypto/chacha-neon-glue.c (100%)
> rename arch/arm64/{ => lib}/crypto/poly1305-armv8.pl (100%)
> rename arch/arm64/{ => lib}/crypto/poly1305-glue.c (100%)
> create mode 100644 arch/mips/lib/crypto/.gitignore
> create mode 100644 arch/mips/lib/crypto/Kconfig
> create mode 100644 arch/mips/lib/crypto/Makefile
> rename arch/mips/{ => lib}/crypto/chacha-core.S (100%)
> rename arch/mips/{ => lib}/crypto/chacha-glue.c (100%)
> rename arch/mips/{ => lib}/crypto/poly1305-glue.c (100%)
> rename arch/mips/{ => lib}/crypto/poly1305-mips.pl (100%)
> create mode 100644 arch/powerpc/lib/crypto/Kconfig
> create mode 100644 arch/powerpc/lib/crypto/Makefile
> rename arch/powerpc/{ => lib}/crypto/chacha-p10-glue.c (100%)
> rename arch/powerpc/{ => lib}/crypto/chacha-p10le-8x.S (100%)
> rename arch/powerpc/{ => lib}/crypto/poly1305-p10-glue.c (100%)
> rename arch/powerpc/{ => lib}/crypto/poly1305-p10le_64.S (100%)
> create mode 100644 arch/riscv/lib/crypto/Kconfig
> create mode 100644 arch/riscv/lib/crypto/Makefile
> rename arch/riscv/{ => lib}/crypto/chacha-riscv64-glue.c (100%)
> rename arch/riscv/{ => lib}/crypto/chacha-riscv64-zvkb.S (100%)
> create mode 100644 arch/s390/lib/crypto/Kconfig
> create mode 100644 arch/s390/lib/crypto/Makefile
> rename arch/s390/{ => lib}/crypto/chacha-glue.c (100%)
> rename arch/s390/{ => lib}/crypto/chacha-s390.S (100%)
> rename arch/s390/{ => lib}/crypto/chacha-s390.h (100%)
> create mode 100644 arch/x86/lib/crypto/.gitignore
> create mode 100644 arch/x86/lib/crypto/Kconfig
> create mode 100644 arch/x86/lib/crypto/Makefile
> rename arch/x86/{ => lib}/crypto/blake2s-core.S (100%)
> rename arch/x86/{ => lib}/crypto/blake2s-glue.c (100%)
> rename arch/x86/{ => lib}/crypto/chacha-avx2-x86_64.S (100%)
> rename arch/x86/{ => lib}/crypto/chacha-avx512vl-x86_64.S (100%)
> rename arch/x86/{ => lib}/crypto/chacha-ssse3-x86_64.S (100%)
> rename arch/x86/{ => lib}/crypto/chacha_glue.c (100%)
> rename arch/x86/{ => lib}/crypto/poly1305-x86_64-cryptogams.pl (100%)
> rename arch/x86/{ => lib}/crypto/poly1305_glue.c (100%)
> 
> 
> base-commit: bb9c648b334be581a791c7669abaa594e4b5ebb7

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

