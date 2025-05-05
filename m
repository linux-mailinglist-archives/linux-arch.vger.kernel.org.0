Return-Path: <linux-arch+bounces-11845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C4AA92FC
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634D61899C90
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997F24E4D2;
	Mon,  5 May 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="jUFEgM7x"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C724A074;
	Mon,  5 May 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447889; cv=none; b=UohfV0JDExr6DZjaWaLouduPx1W09K3Qj98wz35psl1FnFco/K/jeYPsELW5U2ZofFfZNnCV75p5f7qapRyaH5q8lUJ7ETfPJk+eCaLVJDsosNpoGffXy7Wcc/bRwe42pjICtmzPgHaPlWnkTR4OKHTAsIpYUhj30VR23uDM6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447889; c=relaxed/simple;
	bh=gUtLnnBlgN4oa3fbuy6o4bFI9sAqbqwKcfAmFldC8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gzdggJWyRufETj7E3f0kFFcBEwUbXf8FL/FDmOTHc1Ezw0o2Ym59zyKlHt0za5IQXcZLba2dG3I2vaCP9N52fpeaLRfndoNVljY29VpgQ+IOWGNzUTFDRtrNISPh0ubYWINc5qHolSPKQY9RYldAzYVzShhQVgQ+zPGRFaZ1kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=jUFEgM7x; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iiHvH/1rSwXo9uixqUrJppMDuid6Cv2Sop1xAMo9dLA=; b=jUFEgM7xHTyX6uCn8/IqbVS2Lw
	xNUHFMvTKJKro4tC6G4rQNlzNBHGh8zGffQEv35w5nDoPRfJY39OqOYlX13JkHxm1wv1VEkMmw70x
	ELi/cSzReridEambIpFuTBgzqFNXUJJr0nEPYtZdctRco2NRBZQVl29xO9JuOIeyq20t5FiVK3Bjs
	fZpDPaPJSljdgMRQNKYUB3C4ZlvwSPccuG4528N7nhrs4uAfx5an/jFBkEz+Ge++erT72/YB5Zk4w
	iPLaXiYvfgJJTxZd3v94maTSuKrZYyqa8J/l4GS0gzUqMjyJPHqtjKVVxxvdFzm3OoR5g9cyGh5Qu
	qIU3r1hw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uBus6-003YEX-1O;
	Mon, 05 May 2025 20:24:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 05 May 2025 20:24:34 +0800
Date: Mon, 5 May 2025 20:24:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v4 00/13] Architecture-optimized SHA-256 library API
Message-ID: <aBiuAnJZfitrkkyC@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428170040.423825-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
> This is based on cryptodev commit 2dfc7cd74a5e062a.  It can also be
> retrieved from:
> 
>    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git sha256-lib-v4
> 
> Following the example of several other algorithms (e.g. CRC32, ChaCha,
> Poly1305, BLAKE2s), this series refactors the kernel's existing
> architecture-optimized SHA-256 code to be available via the library API,
> instead of just via the crypto_shash API as it was before.  It also
> reimplements the SHA-256 crypto_shash API on top of the library API.
> 
> This makes it possible to use the SHA-256 library in
> performance-critical cases.  The new design is also much simpler, with a
> negative diffstat of almost 1200 lines.  Finally, this also fixes the
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
> 
> Changed v1 => v4:
>    - Moved sha256_generic_blocks() into its own module to avoid a
>      circular module dependency.
>    - Added Ard's Reviewed-by tags.
>    - Rebased onto cryptodev.
> 
> Eric Biggers (13):
>  crypto: sha256 - support arch-optimized lib and expose through shash
>  crypto: arm/sha256 - implement library instead of shash
>  crypto: arm64/sha256 - remove obsolete chunking logic
>  crypto: arm64/sha256 - implement library instead of shash
>  crypto: mips/sha256 - implement library instead of shash
>  crypto: powerpc/sha256 - implement library instead of shash
>  crypto: riscv/sha256 - implement library instead of shash
>  crypto: s390/sha256 - implement library instead of shash
>  crypto: sparc - move opcodes.h into asm directory
>  crypto: sparc/sha256 - implement library instead of shash
>  crypto: x86/sha256 - implement library instead of shash
>  crypto: sha256 - remove sha256_base.h
>  crypto: lib/sha256 - improve function prototypes
> 
> arch/arm/configs/exynos_defconfig             |   1 -
> arch/arm/configs/milbeaut_m10v_defconfig      |   1 -
> arch/arm/configs/multi_v7_defconfig           |   1 -
> arch/arm/configs/omap2plus_defconfig          |   1 -
> arch/arm/configs/pxa_defconfig                |   1 -
> arch/arm/crypto/Kconfig                       |  21 -
> arch/arm/crypto/Makefile                      |   8 +-
> arch/arm/crypto/sha2-ce-glue.c                |  87 ----
> arch/arm/crypto/sha256_glue.c                 | 107 -----
> arch/arm/crypto/sha256_glue.h                 |   9 -
> arch/arm/crypto/sha256_neon_glue.c            |  75 ---
> arch/arm/lib/crypto/.gitignore                |   1 +
> arch/arm/lib/crypto/Kconfig                   |   6 +
> arch/arm/lib/crypto/Makefile                  |   8 +-
> arch/arm/{ => lib}/crypto/sha256-armv4.pl     |   0
> .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  10 +-
> arch/arm/lib/crypto/sha256.c                  |  64 +++
> arch/arm64/configs/defconfig                  |   1 -
> arch/arm64/crypto/Kconfig                     |  19 -
> arch/arm64/crypto/Makefile                    |  13 +-
> arch/arm64/crypto/sha2-ce-glue.c              | 138 ------
> arch/arm64/crypto/sha256-glue.c               | 171 -------
> arch/arm64/lib/crypto/.gitignore              |   1 +
> arch/arm64/lib/crypto/Kconfig                 |   5 +
> arch/arm64/lib/crypto/Makefile                |   9 +-
> .../crypto/sha2-armv8.pl}                     |   0
> .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  36 +-
> arch/arm64/lib/crypto/sha256.c                |  75 +++
> arch/mips/cavium-octeon/Kconfig               |   6 +
> .../mips/cavium-octeon/crypto/octeon-sha256.c | 135 ++----
> arch/mips/configs/cavium_octeon_defconfig     |   1 -
> arch/mips/crypto/Kconfig                      |  10 -
> arch/powerpc/crypto/Kconfig                   |  11 -
> arch/powerpc/crypto/Makefile                  |   2 -
> arch/powerpc/crypto/sha256-spe-glue.c         | 128 ------
> arch/powerpc/lib/crypto/Kconfig               |   6 +
> arch/powerpc/lib/crypto/Makefile              |   3 +
> .../powerpc/{ => lib}/crypto/sha256-spe-asm.S |   0
> arch/powerpc/lib/crypto/sha256.c              |  70 +++
> arch/riscv/crypto/Kconfig                     |  11 -
> arch/riscv/crypto/Makefile                    |   3 -
> arch/riscv/crypto/sha256-riscv64-glue.c       | 125 -----
> arch/riscv/lib/crypto/Kconfig                 |   7 +
> arch/riscv/lib/crypto/Makefile                |   3 +
> .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    |   4 +-
> arch/riscv/lib/crypto/sha256.c                |  62 +++
> arch/s390/configs/debug_defconfig             |   1 -
> arch/s390/configs/defconfig                   |   1 -
> arch/s390/crypto/Kconfig                      |  10 -
> arch/s390/crypto/Makefile                     |   1 -
> arch/s390/crypto/sha256_s390.c                | 144 ------
> arch/s390/lib/crypto/Kconfig                  |   6 +
> arch/s390/lib/crypto/Makefile                 |   2 +
> arch/s390/lib/crypto/sha256.c                 |  47 ++
> arch/sparc/crypto/Kconfig                     |  10 -
> arch/sparc/crypto/Makefile                    |   2 -
> arch/sparc/crypto/aes_asm.S                   |   3 +-
> arch/sparc/crypto/aes_glue.c                  |   3 +-
> arch/sparc/crypto/camellia_asm.S              |   3 +-
> arch/sparc/crypto/camellia_glue.c             |   3 +-
> arch/sparc/crypto/des_asm.S                   |   3 +-
> arch/sparc/crypto/des_glue.c                  |   3 +-
> arch/sparc/crypto/md5_asm.S                   |   3 +-
> arch/sparc/crypto/md5_glue.c                  |   3 +-
> arch/sparc/crypto/sha1_asm.S                  |   3 +-
> arch/sparc/crypto/sha1_glue.c                 |   3 +-
> arch/sparc/crypto/sha256_glue.c               | 129 ------
> arch/sparc/crypto/sha512_asm.S                |   3 +-
> arch/sparc/crypto/sha512_glue.c               |   3 +-
> arch/sparc/{crypto => include/asm}/opcodes.h  |   6 +-
> arch/sparc/lib/Makefile                       |   1 +
> arch/sparc/lib/crc32c_asm.S                   |   3 +-
> arch/sparc/lib/crypto/Kconfig                 |   8 +
> arch/sparc/lib/crypto/Makefile                |   4 +
> arch/sparc/lib/crypto/sha256.c                |  64 +++
> arch/sparc/{ => lib}/crypto/sha256_asm.S      |   5 +-
> arch/x86/crypto/Kconfig                       |  14 -
> arch/x86/crypto/Makefile                      |   3 -
> arch/x86/crypto/sha256_ssse3_glue.c           | 432 ------------------
> arch/x86/lib/crypto/Kconfig                   |   7 +
> arch/x86/lib/crypto/Makefile                  |   3 +
> arch/x86/{ => lib}/crypto/sha256-avx-asm.S    |  12 +-
> arch/x86/{ => lib}/crypto/sha256-avx2-asm.S   |  12 +-
> .../crypto/sha256-ni-asm.S}                   |  36 +-
> arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S  |  14 +-
> arch/x86/lib/crypto/sha256.c                  |  74 +++
> crypto/Kconfig                                |   1 +
> crypto/Makefile                               |   3 +-
> crypto/sha256.c                               | 201 ++++++++
> crypto/sha256_generic.c                       | 102 -----
> include/crypto/internal/sha2.h                |  28 ++
> include/crypto/sha2.h                         |  23 +-
> include/crypto/sha256_base.h                  | 180 --------
> lib/crypto/Kconfig                            |  22 +
> lib/crypto/Makefile                           |   3 +
> lib/crypto/sha256-generic.c                   | 137 ++++++
> lib/crypto/sha256.c                           | 204 ++++-----
> 97 files changed, 1128 insertions(+), 2319 deletions(-)
> delete mode 100644 arch/arm/crypto/sha2-ce-glue.c
> delete mode 100644 arch/arm/crypto/sha256_glue.c
> delete mode 100644 arch/arm/crypto/sha256_glue.h
> delete mode 100644 arch/arm/crypto/sha256_neon_glue.c
> rename arch/arm/{ => lib}/crypto/sha256-armv4.pl (100%)
> rename arch/arm/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (91%)
> create mode 100644 arch/arm/lib/crypto/sha256.c
> delete mode 100644 arch/arm64/crypto/sha2-ce-glue.c
> delete mode 100644 arch/arm64/crypto/sha256-glue.c
> rename arch/arm64/{crypto/sha512-armv8.pl => lib/crypto/sha2-armv8.pl} (100%)
> rename arch/arm64/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (80%)
> create mode 100644 arch/arm64/lib/crypto/sha256.c
> delete mode 100644 arch/powerpc/crypto/sha256-spe-glue.c
> rename arch/powerpc/{ => lib}/crypto/sha256-spe-asm.S (100%)
> create mode 100644 arch/powerpc/lib/crypto/sha256.c
> delete mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
> rename arch/riscv/{ => lib}/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S (98%)
> create mode 100644 arch/riscv/lib/crypto/sha256.c
> delete mode 100644 arch/s390/crypto/sha256_s390.c
> create mode 100644 arch/s390/lib/crypto/sha256.c
> delete mode 100644 arch/sparc/crypto/sha256_glue.c
> rename arch/sparc/{crypto => include/asm}/opcodes.h (96%)
> create mode 100644 arch/sparc/lib/crypto/Kconfig
> create mode 100644 arch/sparc/lib/crypto/Makefile
> create mode 100644 arch/sparc/lib/crypto/sha256.c
> rename arch/sparc/{ => lib}/crypto/sha256_asm.S (95%)
> delete mode 100644 arch/x86/crypto/sha256_ssse3_glue.c
> rename arch/x86/{ => lib}/crypto/sha256-avx-asm.S (98%)
> rename arch/x86/{ => lib}/crypto/sha256-avx2-asm.S (98%)
> rename arch/x86/{crypto/sha256_ni_asm.S => lib/crypto/sha256-ni-asm.S} (85%)
> rename arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S (98%)
> create mode 100644 arch/x86/lib/crypto/sha256.c
> create mode 100644 crypto/sha256.c
> delete mode 100644 crypto/sha256_generic.c
> create mode 100644 include/crypto/internal/sha2.h
> delete mode 100644 include/crypto/sha256_base.h
> create mode 100644 lib/crypto/sha256-generic.c
> 
> 
> base-commit: 2dfc7cd74a5e062a5405560447517e7aab1c7341

All applied with export/import addition to patch 1.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

