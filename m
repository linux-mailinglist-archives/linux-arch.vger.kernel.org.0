Return-Path: <linux-arch+bounces-11461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469CA94903
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F1117058E
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D52144D2;
	Sun, 20 Apr 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbZpkEBW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705A6DCE1;
	Sun, 20 Apr 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177257; cv=none; b=ABe3PpAPjoHoEpbDZRhx5KWmJ19o8VwG0AmaZiYzRdk2aUx0Cq7mETyEyF8gNwoYZ5JGCGtavs7Er2wq+rJ4eyDI0aJ3cvBRyFQw91pphYSB7BgfC2se55NGy9tqCzxjWFjRt+EHL37BYvQUg9LW352lTj1ANKrzq21aqLpX4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177257; c=relaxed/simple;
	bh=G2+3guS80Z7+Fi1lTQSy/MYrzhZPPyiZuKBsiQq1cFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9ZyvTNtXJBGmBE2FdzbNMwKJfyd5HyVddvU7ilXuLgDNeFc6XHdXJ56D6Cef8mcaCCxPThsbIjERRsXdV4oEBVqZNCiIkz1k3VLHhS+rHTn+kt8QJRHQWcKJiEGjxWJV6CoNMs7RG4TOK4cZdYqmpZajpalFjR1l4F5mzsDZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbZpkEBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8694C4CEE9;
	Sun, 20 Apr 2025 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177257;
	bh=G2+3guS80Z7+Fi1lTQSy/MYrzhZPPyiZuKBsiQq1cFw=;
	h=From:To:Cc:Subject:Date:From;
	b=FbZpkEBWNhZUAR4S/NO1XoeH4u34SC1lefokMqnGudEWBxqui2vKtymu/fD1cyNRi
	 hLiDpP0PlpvZvzNJR+916yiazGnDSV1m2YybRBCnIUcfMQ2EqTmxZYJXLbwsmNwtk/
	 /N4Zo8jNTcREjehEzjCCccCojpVmkcwHT/8o3zBx0CNWyj7MdXsI/SXXef8PuGC1x/
	 7LMxQ7czZNsOysEpEhKcaaXSJ79WfpajzfVEgmUhRQpWIi2Y1y3NOB0wRIEOSQ8cdD
	 7SLiRWaXXW9kb3MA5oc+kVrQ/QpIwXGHeprC9+xIWfFBX32PAj1CGSGv0QVoeGE7F/
	 BboR7QHPWHDow==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 00/13] Finish disentangling ChaCha, Poly1305, and BLAKE2s from CRYPTO
Date: Sun, 20 Apr 2025 12:25:56 -0700
Message-ID: <20250420192609.295075-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the unnecessary dependency of the ChaCha, Poly1305,
and BLAKE2s library functions on the generic crypto infrastructure, i.e.
CONFIG_CRYPTO.  To do this, it moves the architecture-optimized
implementations of these functions into new directories
arch/*/lib/crypto/ which do not depend on CRYPTO.  This mirrors the
existing distinction between crypto/ and lib/crypto/.

The last two patches remove the selection of CRYPTO by CRYPTO_LIB_CHACHA
and CRYPTO_LIB_POLY1305, and they remove the corresponding *_INTERNAL
symbols which were needed only because of the entanglement with CRYPTO.

Note that Curve25519 is still entangled.  Later patches will fix that.

Changed in v2:
   - Introduced new directories arch/*/lib/crypto/ instead of keeping
     the library functions in arch/*/crypto/.

Eric Biggers (13):
  crypto: arm64 - drop redundant dependencies on ARM64
  crypto: powerpc - drop redundant dependencies on PPC
  crypto: s390 - drop redundant dependencies on S390
  crypto: x86 - drop redundant dependencies on X86
  crypto: arm - move library functions to arch/arm/lib/crypto/
  crypto: arm64 - move library functions to arch/arm64/lib/crypto/
  crypto: mips - move library functions to arch/mips/lib/crypto/
  crypto: powerpc - move library functions to arch/powerpc/lib/crypto/
  crypto: riscv - move library functions to arch/riscv/lib/crypto/
  crypto: s390 - move library functions to arch/s390/lib/crypto/
  crypto: x86 - move library functions to arch/x86/lib/crypto/
  crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
  crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO

 MAINTAINERS                                   |  1 +
 arch/arm/crypto/Kconfig                       | 23 -----
 arch/arm/crypto/Makefile                      | 14 +--
 arch/arm/lib/Makefile                         |  2 +
 arch/arm/lib/crypto/.gitignore                |  2 +
 arch/arm/lib/crypto/Kconfig                   | 24 ++++++
 arch/arm/lib/crypto/Makefile                  | 24 ++++++
 arch/arm/{ => lib}/crypto/blake2s-core.S      |  0
 arch/arm/{ => lib}/crypto/blake2s-glue.c      |  0
 arch/arm/{ => lib}/crypto/chacha-glue.c       |  0
 arch/arm/{ => lib}/crypto/chacha-neon-core.S  |  0
 .../arm/{ => lib}/crypto/chacha-scalar-core.S |  0
 arch/arm/{ => lib}/crypto/poly1305-armv4.pl   |  0
 arch/arm/{ => lib}/crypto/poly1305-glue.c     |  0
 arch/arm64/crypto/Kconfig                     | 17 +---
 arch/arm64/crypto/Makefile                    |  9 +-
 arch/arm64/lib/Makefile                       |  3 +
 arch/arm64/lib/crypto/.gitignore              |  2 +
 arch/arm64/lib/crypto/Kconfig                 | 14 +++
 arch/arm64/lib/crypto/Makefile                | 16 ++++
 .../arm64/{ => lib}/crypto/chacha-neon-core.S |  0
 .../arm64/{ => lib}/crypto/chacha-neon-glue.c |  0
 arch/arm64/{ => lib}/crypto/poly1305-armv8.pl |  0
 arch/arm64/{ => lib}/crypto/poly1305-glue.c   |  0
 arch/mips/crypto/Kconfig                      | 11 ---
 arch/mips/crypto/Makefile                     | 17 ----
 arch/mips/lib/Makefile                        |  2 +
 arch/mips/lib/crypto/.gitignore               |  2 +
 arch/mips/lib/crypto/Kconfig                  | 12 +++
 arch/mips/lib/crypto/Makefile                 | 19 ++++
 arch/mips/{ => lib}/crypto/chacha-core.S      |  0
 arch/mips/{ => lib}/crypto/chacha-glue.c      |  0
 arch/mips/{ => lib}/crypto/poly1305-glue.c    |  0
 arch/mips/{ => lib}/crypto/poly1305-mips.pl   |  0
 arch/powerpc/crypto/Kconfig                   | 22 +----
 arch/powerpc/crypto/Makefile                  |  4 -
 arch/powerpc/lib/Makefile                     |  2 +
 arch/powerpc/lib/crypto/Kconfig               | 15 ++++
 arch/powerpc/lib/crypto/Makefile              |  7 ++
 .../{ => lib}/crypto/chacha-p10-glue.c        |  0
 .../{ => lib}/crypto/chacha-p10le-8x.S        |  0
 .../{ => lib}/crypto/poly1305-p10-glue.c      |  0
 .../{ => lib}/crypto/poly1305-p10le_64.S      |  0
 arch/riscv/crypto/Kconfig                     |  7 --
 arch/riscv/crypto/Makefile                    |  3 -
 arch/riscv/lib/Makefile                       |  1 +
 arch/riscv/lib/crypto/Kconfig                 |  8 ++
 arch/riscv/lib/crypto/Makefile                |  4 +
 .../{ => lib}/crypto/chacha-riscv64-glue.c    |  0
 .../{ => lib}/crypto/chacha-riscv64-zvkb.S    |  0
 arch/s390/crypto/Kconfig                      | 16 ----
 arch/s390/crypto/Makefile                     |  3 -
 arch/s390/lib/Makefile                        |  1 +
 arch/s390/lib/crypto/Kconfig                  |  7 ++
 arch/s390/lib/crypto/Makefile                 |  4 +
 arch/s390/{ => lib}/crypto/chacha-glue.c      |  0
 arch/s390/{ => lib}/crypto/chacha-s390.S      |  0
 arch/s390/{ => lib}/crypto/chacha-s390.h      |  0
 arch/x86/crypto/Kconfig                       | 86 +++++++------------
 arch/x86/crypto/Makefile                      | 15 ----
 arch/x86/lib/Makefile                         |  2 +
 arch/x86/lib/crypto/.gitignore                |  2 +
 arch/x86/lib/crypto/Kconfig                   | 26 ++++++
 arch/x86/lib/crypto/Makefile                  | 17 ++++
 arch/x86/{ => lib}/crypto/blake2s-core.S      |  0
 arch/x86/{ => lib}/crypto/blake2s-glue.c      |  0
 .../x86/{ => lib}/crypto/chacha-avx2-x86_64.S |  0
 .../{ => lib}/crypto/chacha-avx512vl-x86_64.S |  0
 .../{ => lib}/crypto/chacha-ssse3-x86_64.S    |  0
 arch/x86/{ => lib}/crypto/chacha_glue.c       |  0
 .../crypto/poly1305-x86_64-cryptogams.pl      |  0
 arch/x86/{ => lib}/crypto/poly1305_glue.c     |  0
 crypto/Kconfig                                |  4 +-
 lib/crypto/Kconfig                            | 56 +++++++-----
 74 files changed, 292 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm/lib/crypto/.gitignore
 create mode 100644 arch/arm/lib/crypto/Kconfig
 create mode 100644 arch/arm/lib/crypto/Makefile
 rename arch/arm/{ => lib}/crypto/blake2s-core.S (100%)
 rename arch/arm/{ => lib}/crypto/blake2s-glue.c (100%)
 rename arch/arm/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/arm/{ => lib}/crypto/chacha-neon-core.S (100%)
 rename arch/arm/{ => lib}/crypto/chacha-scalar-core.S (100%)
 rename arch/arm/{ => lib}/crypto/poly1305-armv4.pl (100%)
 rename arch/arm/{ => lib}/crypto/poly1305-glue.c (100%)
 create mode 100644 arch/arm64/lib/crypto/.gitignore
 create mode 100644 arch/arm64/lib/crypto/Kconfig
 create mode 100644 arch/arm64/lib/crypto/Makefile
 rename arch/arm64/{ => lib}/crypto/chacha-neon-core.S (100%)
 rename arch/arm64/{ => lib}/crypto/chacha-neon-glue.c (100%)
 rename arch/arm64/{ => lib}/crypto/poly1305-armv8.pl (100%)
 rename arch/arm64/{ => lib}/crypto/poly1305-glue.c (100%)
 create mode 100644 arch/mips/lib/crypto/.gitignore
 create mode 100644 arch/mips/lib/crypto/Kconfig
 create mode 100644 arch/mips/lib/crypto/Makefile
 rename arch/mips/{ => lib}/crypto/chacha-core.S (100%)
 rename arch/mips/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/mips/{ => lib}/crypto/poly1305-glue.c (100%)
 rename arch/mips/{ => lib}/crypto/poly1305-mips.pl (100%)
 create mode 100644 arch/powerpc/lib/crypto/Kconfig
 create mode 100644 arch/powerpc/lib/crypto/Makefile
 rename arch/powerpc/{ => lib}/crypto/chacha-p10-glue.c (100%)
 rename arch/powerpc/{ => lib}/crypto/chacha-p10le-8x.S (100%)
 rename arch/powerpc/{ => lib}/crypto/poly1305-p10-glue.c (100%)
 rename arch/powerpc/{ => lib}/crypto/poly1305-p10le_64.S (100%)
 create mode 100644 arch/riscv/lib/crypto/Kconfig
 create mode 100644 arch/riscv/lib/crypto/Makefile
 rename arch/riscv/{ => lib}/crypto/chacha-riscv64-glue.c (100%)
 rename arch/riscv/{ => lib}/crypto/chacha-riscv64-zvkb.S (100%)
 create mode 100644 arch/s390/lib/crypto/Kconfig
 create mode 100644 arch/s390/lib/crypto/Makefile
 rename arch/s390/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/s390/{ => lib}/crypto/chacha-s390.S (100%)
 rename arch/s390/{ => lib}/crypto/chacha-s390.h (100%)
 create mode 100644 arch/x86/lib/crypto/.gitignore
 create mode 100644 arch/x86/lib/crypto/Kconfig
 create mode 100644 arch/x86/lib/crypto/Makefile
 rename arch/x86/{ => lib}/crypto/blake2s-core.S (100%)
 rename arch/x86/{ => lib}/crypto/blake2s-glue.c (100%)
 rename arch/x86/{ => lib}/crypto/chacha-avx2-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha-avx512vl-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha-ssse3-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha_glue.c (100%)
 rename arch/x86/{ => lib}/crypto/poly1305-x86_64-cryptogams.pl (100%)
 rename arch/x86/{ => lib}/crypto/poly1305_glue.c (100%)


base-commit: bb9c648b334be581a791c7669abaa594e4b5ebb7
-- 
2.49.0


