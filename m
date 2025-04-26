Return-Path: <linux-arch+bounces-11584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742DA9D87F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 08:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBF7B3157
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B01D514F;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5CKi8Fj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179482F56;
	Sat, 26 Apr 2025 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650300; cv=none; b=pOnEhG+fd++y4sQ5n7LCOehPtlBwbi2TZfrUN0l43KqBFHqBpOHC5C6clDF9qBHJEo8jMHOo8JHV49xLTukHFadlPHB46k4zFqegiL8VSwehwgWtYZyEUZfR+3Buk356jGEK9CHrlSdZ48d9Tn3hXdJMT83ZiiFc95vDyyoPyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650300; c=relaxed/simple;
	bh=Wt4NiLwr3M+nnRmOESBPWOhsCFaewP404R89YU0Ma5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJ0QhW5HYaotU4Y5iQHqg+NHe6vZMPEqnNAI53geMm4nPTxUgaWx3LfZPK35cusLeGmfBIJ+ZpulL1w0edCukZo3ZG3efBC8MVJWCTtShv5HCETFjmbip6fDu1l7CXxHQlExy/Bm6tUt4CR5abP3/lvgT8U8KXl7ab+hO7Aa5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5CKi8Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A8C4CEE2;
	Sat, 26 Apr 2025 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745650299;
	bh=Wt4NiLwr3M+nnRmOESBPWOhsCFaewP404R89YU0Ma5M=;
	h=From:To:Cc:Subject:Date:From;
	b=Q5CKi8Fj8xTGPwU5Drh/PIkGhwVgbuW9HluQx63MK9bQszLhD1B+qOn0taEs2bOYT
	 xBLhxHiJ14hN8wZd5OxE4WguGmBhxzXaFqJL+htoOFdKU3BzoM7lR/QIeSUuRtp/5R
	 gig6dijFkQjn6WC6FuWjCbGcPvoQXYpyadAK/qbp921I+Fz1WufozNZ0O7WVjBivlP
	 hD9T2mbnScBpB1uA34w+nY5WNn6DaqxIZnEognT6gjIUeJu/GMOiHHum2pD1dS7SFk
	 vI6VS1pf337qJxrzm8RfuoAuUx7oT9vTJZmvfL9I9A7sqtxZoeM8H6MVnLOxkCewCS
	 jDKNVfj94qJ7A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 00/13] Architecture-optimized SHA-256 library API
Date: Fri, 25 Apr 2025 23:50:26 -0700
Message-ID: <20250426065041.1551914-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is based on cryptodev commit bf0b4f15267ca404 plus the series
https://lore.kernel.org/linux-crypto/20250422152716.5923-1-ebiggers@kernel.org/.
It can also be retrieved from:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git sha256-lib-v1

Following the example of several other algorithms (e.g. CRC32, ChaCha,
Poly1305, BLAKE2s), this series refactors the kernel's existing
architecture-optimized SHA-256 code to be available via the library API,
instead of just via the crypto_shash API as it was before.  It also
reimplements the SHA-256 crypto_shash API on top of the library API.

This makes it possible to use the SHA-256 library in
performance-critical cases.  The new design is also much simpler, with a
negative diffstat of over 1200 lines.  Finally, this also fixes the
longstanding issue where the arch-optimized SHA-256 was disabled by
default, so people often forgot to enable it.

For now the SHA-256 library is well-covered by the crypto_shash
self-tests, but I plan to add a test for the library directly later.
I've fully tested this series on arm, arm64, riscv, and x86.  On mips,
powerpc, s390, and sparc I've only been able to partially test it, since
QEMU does not support the SHA-256 instructions on those platforms.  If
anyone with access to a mips, powerpc, s390, or sparc system that has
SHA-256 instructions can verify that the crypto self-tests still pass,
that would be appreciated.  But I don't expect any issues, especially
since the new code is more straightforward than the old code.

Eric Biggers (13):
  crypto: sha256 - support arch-optimized lib and expose through shash
  crypto: arm/sha256 - implement library instead of shash
  crypto: arm64/sha256 - remove obsolete chunking logic
  crypto: arm64/sha256 - implement library instead of shash
  crypto: mips/sha256 - implement library instead of shash
  crypto: powerpc/sha256 - implement library instead of shash
  crypto: riscv/sha256 - implement library instead of shash
  crypto: s390/sha256 - implement library instead of shash
  crypto: sparc - move opcodes.h into asm directory
  crypto: sparc/sha256 - implement library instead of shash
  crypto: x86/sha256 - implement library instead of shash
  crypto: sha256 - remove sha256_base.h
  crypto: lib/sha256 - improve function prototypes

 arch/arm/configs/exynos_defconfig             |   1 -
 arch/arm/configs/milbeaut_m10v_defconfig      |   1 -
 arch/arm/configs/multi_v7_defconfig           |   1 -
 arch/arm/configs/omap2plus_defconfig          |   1 -
 arch/arm/configs/pxa_defconfig                |   1 -
 arch/arm/crypto/Kconfig                       |  21 -
 arch/arm/crypto/Makefile                      |   8 +-
 arch/arm/crypto/sha2-ce-glue.c                |  87 ----
 arch/arm/crypto/sha256_glue.c                 | 107 -----
 arch/arm/crypto/sha256_glue.h                 |   9 -
 arch/arm/crypto/sha256_neon_glue.c            |  75 ---
 arch/arm/lib/crypto/.gitignore                |   1 +
 arch/arm/lib/crypto/Kconfig                   |   6 +
 arch/arm/lib/crypto/Makefile                  |   8 +-
 arch/arm/{ => lib}/crypto/sha256-armv4.pl     |   0
 .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  10 +-
 arch/arm/lib/crypto/sha256.c                  |  64 +++
 arch/arm64/configs/defconfig                  |   1 -
 arch/arm64/crypto/Kconfig                     |  19 -
 arch/arm64/crypto/Makefile                    |  13 +-
 arch/arm64/crypto/sha2-ce-glue.c              | 138 ------
 arch/arm64/crypto/sha256-glue.c               | 171 -------
 arch/arm64/lib/crypto/.gitignore              |   1 +
 arch/arm64/lib/crypto/Kconfig                 |   5 +
 arch/arm64/lib/crypto/Makefile                |   9 +-
 .../crypto/sha2-armv8.pl}                     |   0
 .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  36 +-
 arch/arm64/lib/crypto/sha256.c                |  75 +++
 arch/mips/cavium-octeon/Kconfig               |   6 +
 .../mips/cavium-octeon/crypto/octeon-sha256.c | 135 ++----
 arch/mips/configs/cavium_octeon_defconfig     |   1 -
 arch/mips/crypto/Kconfig                      |  10 -
 arch/powerpc/crypto/Kconfig                   |  11 -
 arch/powerpc/crypto/Makefile                  |   2 -
 arch/powerpc/crypto/sha256-spe-glue.c         | 128 ------
 arch/powerpc/lib/crypto/Kconfig               |   6 +
 arch/powerpc/lib/crypto/Makefile              |   3 +
 .../powerpc/{ => lib}/crypto/sha256-spe-asm.S |   0
 arch/powerpc/lib/crypto/sha256.c              |  70 +++
 arch/riscv/crypto/Kconfig                     |  11 -
 arch/riscv/crypto/Makefile                    |   3 -
 arch/riscv/crypto/sha256-riscv64-glue.c       | 125 -----
 arch/riscv/lib/crypto/Kconfig                 |   7 +
 arch/riscv/lib/crypto/Makefile                |   3 +
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    |   4 +-
 arch/riscv/lib/crypto/sha256.c                |  62 +++
 arch/s390/configs/debug_defconfig             |   1 -
 arch/s390/configs/defconfig                   |   1 -
 arch/s390/crypto/Kconfig                      |  10 -
 arch/s390/crypto/Makefile                     |   1 -
 arch/s390/crypto/sha256_s390.c                | 144 ------
 arch/s390/lib/crypto/Kconfig                  |   6 +
 arch/s390/lib/crypto/Makefile                 |   2 +
 arch/s390/lib/crypto/sha256.c                 |  47 ++
 arch/sparc/crypto/Kconfig                     |  10 -
 arch/sparc/crypto/Makefile                    |   2 -
 arch/sparc/crypto/aes_asm.S                   |   3 +-
 arch/sparc/crypto/aes_glue.c                  |   3 +-
 arch/sparc/crypto/camellia_asm.S              |   3 +-
 arch/sparc/crypto/camellia_glue.c             |   3 +-
 arch/sparc/crypto/des_asm.S                   |   3 +-
 arch/sparc/crypto/des_glue.c                  |   3 +-
 arch/sparc/crypto/md5_asm.S                   |   3 +-
 arch/sparc/crypto/md5_glue.c                  |   3 +-
 arch/sparc/crypto/sha1_asm.S                  |   3 +-
 arch/sparc/crypto/sha1_glue.c                 |   3 +-
 arch/sparc/crypto/sha256_glue.c               | 129 ------
 arch/sparc/crypto/sha512_asm.S                |   3 +-
 arch/sparc/crypto/sha512_glue.c               |   3 +-
 arch/sparc/{crypto => include/asm}/opcodes.h  |   6 +-
 arch/sparc/lib/Makefile                       |   1 +
 arch/sparc/lib/crc32c_asm.S                   |   3 +-
 arch/sparc/lib/crypto/Kconfig                 |   8 +
 arch/sparc/lib/crypto/Makefile                |   4 +
 arch/sparc/lib/crypto/sha256.c                |  64 +++
 arch/sparc/{ => lib}/crypto/sha256_asm.S      |   5 +-
 arch/x86/crypto/Kconfig                       |  14 -
 arch/x86/crypto/Makefile                      |   3 -
 arch/x86/crypto/sha256_ssse3_glue.c           | 432 ------------------
 arch/x86/lib/crypto/Kconfig                   |   7 +
 arch/x86/lib/crypto/Makefile                  |   3 +
 arch/x86/{ => lib}/crypto/sha256-avx-asm.S    |  12 +-
 arch/x86/{ => lib}/crypto/sha256-avx2-asm.S   |  12 +-
 .../crypto/sha256-ni-asm.S}                   |  36 +-
 arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S  |  14 +-
 arch/x86/lib/crypto/sha256.c                  |  74 +++
 crypto/Kconfig                                |   1 +
 crypto/Makefile                               |   3 +-
 crypto/sha256.c                               | 201 ++++++++
 crypto/sha256_generic.c                       | 102 -----
 include/crypto/internal/sha2.h                |  28 ++
 include/crypto/sha2.h                         |  23 +-
 include/crypto/sha256_base.h                  | 180 --------
 lib/crypto/Kconfig                            |  22 +
 lib/crypto/sha256.c                           | 130 +++++-
 95 files changed, 1008 insertions(+), 2225 deletions(-)
 delete mode 100644 arch/arm/crypto/sha2-ce-glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.h
 delete mode 100644 arch/arm/crypto/sha256_neon_glue.c
 rename arch/arm/{ => lib}/crypto/sha256-armv4.pl (100%)
 rename arch/arm/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (91%)
 create mode 100644 arch/arm/lib/crypto/sha256.c
 delete mode 100644 arch/arm64/crypto/sha2-ce-glue.c
 delete mode 100644 arch/arm64/crypto/sha256-glue.c
 rename arch/arm64/{crypto/sha512-armv8.pl => lib/crypto/sha2-armv8.pl} (100%)
 rename arch/arm64/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (80%)
 create mode 100644 arch/arm64/lib/crypto/sha256.c
 delete mode 100644 arch/powerpc/crypto/sha256-spe-glue.c
 rename arch/powerpc/{ => lib}/crypto/sha256-spe-asm.S (100%)
 create mode 100644 arch/powerpc/lib/crypto/sha256.c
 delete mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 rename arch/riscv/{ => lib}/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S (98%)
 create mode 100644 arch/riscv/lib/crypto/sha256.c
 delete mode 100644 arch/s390/crypto/sha256_s390.c
 create mode 100644 arch/s390/lib/crypto/sha256.c
 delete mode 100644 arch/sparc/crypto/sha256_glue.c
 rename arch/sparc/{crypto => include/asm}/opcodes.h (96%)
 create mode 100644 arch/sparc/lib/crypto/Kconfig
 create mode 100644 arch/sparc/lib/crypto/Makefile
 create mode 100644 arch/sparc/lib/crypto/sha256.c
 rename arch/sparc/{ => lib}/crypto/sha256_asm.S (95%)
 delete mode 100644 arch/x86/crypto/sha256_ssse3_glue.c
 rename arch/x86/{ => lib}/crypto/sha256-avx-asm.S (98%)
 rename arch/x86/{ => lib}/crypto/sha256-avx2-asm.S (98%)
 rename arch/x86/{crypto/sha256_ni_asm.S => lib/crypto/sha256-ni-asm.S} (85%)
 rename arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S (98%)
 create mode 100644 arch/x86/lib/crypto/sha256.c
 create mode 100644 crypto/sha256.c
 delete mode 100644 crypto/sha256_generic.c
 create mode 100644 include/crypto/internal/sha2.h
 delete mode 100644 include/crypto/sha256_base.h

-- 
2.49.0


