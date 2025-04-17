Return-Path: <linux-arch+bounces-11440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031CA92871
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DCE465B8A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFEF26E15F;
	Thu, 17 Apr 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imzS3N2w"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979826B2CE;
	Thu, 17 Apr 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914439; cv=none; b=lMD3ac3uudAkWWt7sSttvFRr5Zzptt5/Pavpl0XUA66HpuwyEo/AgfCNZxoHDxuID7vLi1tyl3+p0SAhv1KV2cq7EEQm7O1mPLgkHTPY4t+SjWPfnoGakCdJdVwySaJqKExITDbU2fctd7OXHAgep0aUmPkcNcbTnBXBsmB8G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914439; c=relaxed/simple;
	bh=hyWo6YL7FRAGp3TLSpqd740amjRb093kTvvI69CX+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxkxBgGPIu58li9yVSL5+2dE9VNzNrzQtqyqhU4csfrEG0/Lz6jBSBBIX4XPk6OuEGvpRKcCUh4W1pMVn3tWm1hmIV2wLqLfKPLukiQwuBqQ7nl4QCd5uOE2Z8hqQs/O6ZKmmIlPcK28PhVbMgWU9POlNlAuk0FDbA1bC41lfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imzS3N2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0482CC4CEE4;
	Thu, 17 Apr 2025 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914438;
	bh=hyWo6YL7FRAGp3TLSpqd740amjRb093kTvvI69CX+8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imzS3N2w1uI9WmXTcKqyl8ymKSGwBPi5n+G/0SvG9X98fdlgohEz8iGI1c7b+xl4O
	 sjt7mpHQZTknkcM9C1Cuy/Wcsk6S9A0wu2BwUVlD07RJ+ODrMQQhlpP0gCHa6qd/S8
	 TwzyelGLWBED5iEPcEVFwFMxoVplOs2g1cgJOTUsM0tsyCJMx0/38V/yPGT2g46Dij
	 /y1WNSsWBKWSjVrVfZDXkb1KE14N3SqJgsglAVISKJW+lxLHgPWRKnNFxQ9SyPjG5y
	 9b+ch3bo053BcmuboIKtZ4933Z//aAdM0lhAFLkYIJUT22Rx6w3Yz1Eu500nKM9Vd3
	 8e/fPJ90zdD7g==
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
Subject: [PATCH 14/15] crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
Date: Thu, 17 Apr 2025 11:26:22 -0700
Message-ID: <20250417182623.67808-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417182623.67808-1-ebiggers@kernel.org>
References: <20250417182623.67808-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the architecture-optimized ChaCha kconfig symbols are visible
without CRYPTO, there is no need for CRYPTO_LIB_CHACHA to select CRYPTO.
So, remove that.  This makes the indirection through the
CRYPTO_LIB_CHACHA_INTERNAL symbol unnecessary, so get rid of that and
just use CRYPTO_LIB_CHACHA directly.  Finally, make the fallback to the
generic implementation use a default value instead of a select; this
makes it consistent with how the arch-optimized code gets enabled and
also with how CRYPTO_LIB_BLAKE2S_GENERIC gets enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/Kconfig     |  2 +-
 arch/arm64/crypto/Kconfig   |  2 +-
 arch/mips/crypto/Kconfig    |  2 +-
 arch/powerpc/crypto/Kconfig |  2 +-
 arch/riscv/crypto/Kconfig   |  2 +-
 arch/s390/crypto/Kconfig    |  2 +-
 arch/x86/crypto/Kconfig     |  2 +-
 crypto/Kconfig              |  2 +-
 lib/crypto/Kconfig          | 16 +++++-----------
 9 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index a03017a6dbc4..960602271443 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -208,10 +208,10 @@ config CRYPTO_AES_ARM_CE
 	  Architecture: arm using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_CHACHA20_NEON
 	tristate
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 endmenu
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index a2cccd2accb0..8184da75b24f 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -184,13 +184,13 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CHACHA20_NEON
 	tristate
 	depends on KERNEL_MODE_NEON
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_AES_ARM64_BS
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XCTR/XTS modes (bit-sliced NEON)"
 	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index beb7b20cf3e8..f1d61457518f 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -48,9 +48,9 @@ config CRYPTO_SHA512_OCTEON
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_CHACHA_MIPS
 	tristate
 	depends on CPU_MIPS32_R2
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 endmenu
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 0f14bdf104d5..dd3bd22d8e20 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -93,13 +93,13 @@ config CRYPTO_AES_GCM_P10
 	  later CPU. This module supports stitched acceleration for AES/GCM.
 
 config CRYPTO_CHACHA20_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_POLY1305_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 08547694937c..b5ac0d41f4a3 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -19,13 +19,13 @@ config CRYPTO_AES_RISCV64
 	  - Zvkg vector crypto extension (XTS)
 
 config CRYPTO_CHACHA_RISCV64
 	tristate
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
 	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_GCM
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index a2e6efd8aed8..c0d238228cad 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -107,13 +107,13 @@ config CRYPTO_DES_S390
 	  As of z990 the ECB and CBC mode are hardware accelerated.
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_CHACHA_S390
 	tristate
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_HMAC_S390
 	tristate "Keyed-hash message authentication code: HMAC"
 	depends on CRYPTO
 	select CRYPTO_HASH
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index daa168e37b59..5b9d6dbe6185 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -337,13 +337,13 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	  Processes 64 blocks in parallel.
 
 config CRYPTO_CHACHA20_X86_64
 	tristate
 	depends on 64BIT
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE4.1)"
 	depends on CRYPTO && 64BIT
 	select CRYPTO_AEAD
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7e207f3d3eca..ed50d1b6f6f3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -632,12 +632,12 @@ config CRYPTO_ARC4
 	  WEP, but it should not be for other purposes because of the
 	  weakness of the algorithm.
 
 config CRYPTO_CHACHA20
 	tristate "ChaCha"
+	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_LIB_CHACHA_INTERNAL
 	select CRYPTO_SKCIPHER
 	help
 	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
 
 	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 2c6ab80e0cdc..cc4c0ee04f98 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -48,26 +48,20 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 	  accelerated implementation of the ChaCha library interface,
 	  either builtin or as a module.
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
+	default CRYPTO_LIB_CHACHA if !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_UTILS
 	help
-	  This symbol can be depended upon by arch implementations of the
-	  ChaCha library interface that require the generic code as a
-	  fallback, e.g., for SIMD implementations. If no arch specific
-	  implementation is enabled, this implementation serves the users
-	  of CRYPTO_LIB_CHACHA.
-
-config CRYPTO_LIB_CHACHA_INTERNAL
-	tristate
-	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+	  This symbol can be selected by arch implementations of the ChaCha
+	  library interface that require the generic code as a fallback, e.g.,
+	  for SIMD implementations. If no arch specific implementation is
+	  enabled, this implementation serves the users of CRYPTO_LIB_CHACHA.
 
 config CRYPTO_LIB_CHACHA
 	tristate
-	select CRYPTO
-	select CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
 	  is available and enabled.
 
-- 
2.49.0


