Return-Path: <linux-arch+bounces-11426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601DBA927F3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0049619E722F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C662262817;
	Thu, 17 Apr 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIGe0C4H"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346F2571AC;
	Thu, 17 Apr 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914426; cv=none; b=YUhNYX9tqXc7pvAAr6cHhkegMvsDKmxcEvW9e+VvsQrr1sXZOwTH89RuUT2jGK20zHRDJD+3yYhX3jyS9v2IPhz77lvrAk5kDhI66/+tB7lJXFOb7mDAR/W0Utrg3VUfFJ5hPl3/Yr97Xekp9SmTJy6Av3GBrmzdg62/v4Q0J+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914426; c=relaxed/simple;
	bh=eYlw8AhwDiKSQwbJxBZMP6nL7U7/odFuPU2SW3GNcIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LC5ipJ9Ycq4QQvRcxojdrUaiL93BRg7AiXDS/SMSaREVCQh9QZh9y59UCMmqStWt0m2AqR5F122VBaQnNKnX27JqR9eK8mu9I6lZRZJ7dyaduCMybahTc0RbVDnZ7S+saTmJQLD3+2LDyJm51p1WI3+y2iqFeNnwivX5QWnyTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIGe0C4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241E8C4CEEC;
	Thu, 17 Apr 2025 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914425;
	bh=eYlw8AhwDiKSQwbJxBZMP6nL7U7/odFuPU2SW3GNcIs=;
	h=From:To:Cc:Subject:Date:From;
	b=OIGe0C4HhyE/SwSQmKx2rHmtBTJv+C//vsUPyHQ9nBNZ7SM70FI5kAjNOXx0SiPAT
	 oAV2RDvW3y7SexpSfNzDbW3E0WnI97wnBu7vd0ixGUtDVT++ajf0iwHpYPkfRoPvP9
	 dT4SFF4LmjWuyS23J7I28QPr2BOEobjN9OeNUvVqomFKSjPZoUnpDk/aJjRQhRsRIa
	 2jmz2BHEDWHCJM4wvqlkIeqwkGTdW4f9UXQwxbXtBHS8en8Ihmr+5OuGxO4m0tt2DT
	 hAvSXPNfuhibOtdvN7de1S4/+B2pChejRWcf0/OP2SYlBqQ90ckVcnffrq7XEP05h7
	 kOgQb7+Go6l8A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 00/15] Finish disentangling ChaCha, Poly1305, and BLAKE2s from CRYPTO
Date: Thu, 17 Apr 2025 11:26:08 -0700
Message-ID: <20250417182623.67808-1-ebiggers@kernel.org>
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
CONFIG_CRYPTO.  To do this, it moves arch/*/crypto/Kconfig from a
submenu of crypto/Kconfig to a submenu of arch/*/Kconfig, then re-adds
the CRYPTO dependency to the symbols that actually need it.

Patches 14-15 then simplify the ChaCha and Poly1305 symbols by removing
the unneeded "internal" symbols.

Note that Curve25519 is still entangled.  Later patches will fix that.

Eric Biggers (15):
  crypto: arm - remove CRYPTO dependency of library functions
  crypto: arm64 - drop redundant dependencies on ARM64
  crypto: arm64 - remove CRYPTO dependency of library functions
  crypto: loongarch - source arch/loongarch/crypto/Kconfig without
    CRYPTO
  crypto: mips - remove CRYPTO dependency of library functions
  crypto: powerpc - drop redundant dependencies on PPC
  crypto: powerpc - remove CRYPTO dependency of library functions
  crypto: riscv - remove CRYPTO dependency of library functions
  crypto: s390 - drop redundant dependencies on S390
  crypto: s390 - remove CRYPTO dependency of library functions
  crypto: sparc - source arch/sparc/crypto/Kconfig without CRYPTO
  crypto: x86 - drop redundant dependencies on X86
  crypto: x86 - remove CRYPTO dependency of library functions
  crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
  crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO

 arch/arm/Kconfig            |  2 ++
 arch/arm/crypto/Kconfig     | 28 ++++++++-------
 arch/arm64/Kconfig          |  3 +-
 arch/arm64/crypto/Kconfig   | 45 ++++++++++++-----------
 arch/loongarch/Kconfig      |  1 +
 arch/mips/Kconfig           |  2 ++
 arch/mips/crypto/Kconfig    | 12 +++----
 arch/powerpc/Kconfig        |  2 ++
 arch/powerpc/crypto/Kconfig | 22 ++++++------
 arch/riscv/Kconfig          |  2 ++
 arch/riscv/crypto/Kconfig   | 14 ++++----
 arch/s390/Kconfig           |  4 +++
 arch/s390/crypto/Kconfig    | 21 ++++++-----
 arch/sparc/Kconfig          |  2 ++
 arch/sparc/crypto/Kconfig   | 14 ++++----
 arch/x86/Kconfig            |  4 +++
 arch/x86/crypto/Kconfig     | 72 ++++++++++++++++++-------------------
 crypto/Kconfig              | 34 ++----------------
 lib/crypto/Kconfig          | 32 ++++++-----------
 19 files changed, 149 insertions(+), 167 deletions(-)


base-commit: da4cb617bc7d827946cbb368034940b379a1de90
-- 
2.49.0


