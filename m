Return-Path: <linux-arch+bounces-11429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72FA9281C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA147AA630
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A24264609;
	Thu, 17 Apr 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhq+jSRp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB62641F2;
	Thu, 17 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914428; cv=none; b=rtAdSPRUPUgjBP5LuY8KoktnWMDvhEW6z4JL+diYttVllkkyAu7A2L0eOASGlmn9RM1RweM1UhwOtRVSos3ldQFjbGt+j8UPasfIg48Uh0WwoUjeU1H9dEB07ZRBiH84QNkT12//17FNp163FE6GWDybXdNm/m/cP0p5Y1C1ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914428; c=relaxed/simple;
	bh=I03HgIe8hlztmVaX0kmyqHgQfk9uC8Y2YUsxqcekmxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLJ1lSn3AZsowz9hiRgXEqj8Dmko/rgmMFTQfgcrEKSqMsgJnjRN+HkQJP4Age+bZAMcjtPIs9kcB6a0+Cs/jQxPpgU8jBvowKvyT0DjMAW5e4qU044llYe0yKXNC+89HPDGF3WDimjdE4N/M/ZADroa5wCV9oQvk2rmDHDyldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhq+jSRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5078C4CEE4;
	Thu, 17 Apr 2025 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914428;
	bh=I03HgIe8hlztmVaX0kmyqHgQfk9uC8Y2YUsxqcekmxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhq+jSRpIPLURJ7s8ysIZZYCuX6lz66JWazTUrzcabv+csLeQT+ovERbI+ddDLfrw
	 1Kgf+ZJjLsqxPtVC5El31bcJPPy05AhyHzed/kO+mlc0E9Xq+fJ1m+1CWprIHo56nA
	 273CkNbWjnRX35UsiY6IqK4NRWCRBQ0bVz5roGfPqj4p4pv+SamyAh4osGCswH4+Aj
	 LwZGPhbiAx9t3neXz2nWtjF8AG3GMWWzwWYeVmtb9a8GNogNqGaxc6N/N0pS9Nfulr
	 vVpGX9fkt0iciOEHT8EPdERvnFeMXTGoTuQqsLX1nvQ1/eOHdv8/e8u03/U+eIaSR1
	 /2/r8Yqh0y04g==
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
Subject: [PATCH 03/15] crypto: arm64 - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:11 -0700
Message-ID: <20250417182623.67808-4-ebiggers@kernel.org>
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

Continue disentangling the crypto library functions from the generic
crypto infrastructure by removing the unnecessary CRYPTO dependency of
CRYPTO_CHACHA20_NEON and CRYPTO_POLY1305_NEON.  To do this, make
arch/arm64/crypto/Kconfig be sourced regardless of CRYPTO, and
explicitly list the CRYPTO dependency in the symbols that do need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/Kconfig        |  3 ++-
 arch/arm64/crypto/Kconfig | 41 +++++++++++++++++++++------------------
 crypto/Kconfig            |  3 ---
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a182295e6f08..7f6ce0da6f87 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2509,7 +2509,8 @@ source "drivers/cpufreq/Kconfig"
 
 endmenu # "CPU Power Management"
 
 source "drivers/acpi/Kconfig"
 
-source "arch/arm64/kvm/Kconfig"
+source "arch/arm64/crypto/Kconfig"
 
+source "arch/arm64/kvm/Kconfig"
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 704d0b7e1d13..a2cccd2accb0 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "Hash functions: GHASH (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_AEAD
 	help
@@ -15,11 +15,11 @@ config CRYPTO_GHASH_ARM64_CE
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_NHPOLY1305_NEON
 	tristate "Hash functions: NHPoly1305 (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function (Adiantum)
 
 	  Architecture: arm64 using:
@@ -31,102 +31,105 @@ config CRYPTO_POLY1305_NEON
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA256_ARM64
 	tristate "Hash functions: SHA-224 and SHA-256"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm64
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA512_ARM64
 	tristate "Hash functions: SHA-384 and SHA-512"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm64
 
 config CRYPTO_SHA512_ARM64_CE
 	tristate "Hash functions: SHA-384 and SHA-512 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA512_ARM64
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA3_ARM64
 	tristate "Hash functions: SHA-3 (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA3
 	help
 	  SHA-3 secure hash algorithms (FIPS 202)
 
 	  Architecture: arm64 using:
 	  - ARMv8.2 Crypto Extensions
 
 config CRYPTO_SM3_NEON
 	tristate "Hash functions: SM3 (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
 	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
 
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM3_ARM64_CE
 	tristate "Hash functions: SM3 (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
 	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
 
 	  Architecture: arm64 using:
 	  - ARMv8.2 Crypto Extensions
 
 config CRYPTO_POLYVAL_ARM64_CE
 	tristate "Hash functions: POLYVAL (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_POLYVAL
 	help
 	  POLYVAL hash function for HCTR2
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64
 	tristate "Ciphers: AES, modes: ECB, CBC, CTR, CTS, XCTR, XTS"
+	depends on CRYPTO
 	select CRYPTO_AES
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 	  Length-preserving ciphers: AES with ECB, CBC, CTR, CTS,
 	    XCTR, and XTS modes
@@ -135,22 +138,22 @@ config CRYPTO_AES_ARM64
 
 	  Architecture: arm64
 
 config CRYPTO_AES_ARM64_CE
 	tristate "Ciphers: AES (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	help
 	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
 	  with block cipher modes:
@@ -163,11 +166,11 @@ config CRYPTO_AES_ARM64_CE_BLK
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
 	help
 	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
 	  with block cipher modes:
@@ -187,11 +190,11 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_AES_ARM64_BS
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XCTR/XTS modes (bit-sliced NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_LIB_AES
 	help
 	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
@@ -207,11 +210,11 @@ config CRYPTO_AES_ARM64_BS
 	  - bit-sliced algorithm
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE
 	tristate "Ciphers: SM4 (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
 	  Block ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
 
@@ -219,11 +222,11 @@ config CRYPTO_SM4_ARM64_CE
 	  - ARMv8.2 Crypto Extensions
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE_BLK
 	tristate "Ciphers: SM4, modes: ECB/CBC/CTR/XTS (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
 	help
 	  Length-preserving ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
 	  with block cipher modes:
@@ -237,11 +240,11 @@ config CRYPTO_SM4_ARM64_CE_BLK
 	  - ARMv8 Crypto Extensions
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_NEON_BLK
 	tristate "Ciphers: SM4, modes: ECB/CBC/CTR (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
 	help
 	  Length-preserving ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
 	  with block cipher modes:
@@ -252,11 +255,11 @@ config CRYPTO_SM4_ARM64_NEON_BLK
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AEAD cipher: AES in CCM mode (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64_CE_BLK
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
@@ -269,11 +272,11 @@ config CRYPTO_AES_ARM64_CE_CCM
 	  - ARMv8 Crypto Extensions
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE_CCM
 	tristate "AEAD cipher: SM4 in CCM mode (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AEAD
 	select CRYPTO_SM4
 	select CRYPTO_SM4_ARM64_CE_BLK
 	help
@@ -285,11 +288,11 @@ config CRYPTO_SM4_ARM64_CE_CCM
 	  - ARMv8 Crypto Extensions
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE_GCM
 	tristate "AEAD cipher: SM4 in GCM mode (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AEAD
 	select CRYPTO_SM4
 	select CRYPTO_SM4_ARM64_CE_BLK
 	help
diff --git a/crypto/Kconfig b/crypto/Kconfig
index cad71f32e1e3..a5225c6d0488 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if ARM64
-source "arch/arm64/crypto/Kconfig"
-endif
 if LOONGARCH
 source "arch/loongarch/crypto/Kconfig"
 endif
 if MIPS
 source "arch/mips/crypto/Kconfig"
-- 
2.49.0


