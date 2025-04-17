Return-Path: <linux-arch+bounces-11439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994EFA92874
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0BC8E041C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AD26B097;
	Thu, 17 Apr 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeW0Nneq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C326AABB;
	Thu, 17 Apr 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914438; cv=none; b=cpdK5pFnTDyTVCdFzdgQTAobUQb/TUeocndKhibgx60g7D7JrJe4P5qIRsyxb/ytFwRT8ipt4ZPNPJtaYQOxvZ5khEefMz3kx2U8TfzGwk+bPOw6ZxSTLqY7P4qLAS6MlLiTxtyIGvBZMORrqZRagRabUSUankU4uYRyeXHpRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914438; c=relaxed/simple;
	bh=3nfdu4R/mPq9aAzKFy77Vd824jpabdJRCARw42m5B3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEXxBjydUcdVKJMDAtMxucZB2t3R7ypvyhkdvakbpNnrAGPiCpI/Ba9RaSqyxlX0YVMl46eJM4zKp+xTXi3prTmLUB8l06li6O8nPxv/J0e42PY09851PqXUd4BAxf5P7pcK0Wp6YSqrhvkKU7MAj+7aMirhoOsgQFKtmKePVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeW0Nneq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06218C4CEE7;
	Thu, 17 Apr 2025 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914437;
	bh=3nfdu4R/mPq9aAzKFy77Vd824jpabdJRCARw42m5B3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeW0NneqVCQj7DYVVEg1zpY/h1tmZM6P32rJRZQ6YxrpYlXnaxEpLEk1Au1Uadeww
	 9l9Sp5j7rrCKmQFDwjauWm/MrJAAWSILclhc1uGnQxXQb26q6RtlF1lisvj7bIsDJr
	 O9gmn0l4jTjfWZUhx8ejLkUCSlEOa/rcTDxvg1GMqEv1DCjCYypX/j9prOqeSF9CAp
	 zP+dG8u65oa2fijCqHzQq98k8aHe2/AqMMtjC0NyybcRriVdygBLZ80gw/7GKOViSh
	 T3LQEa5jFjZxYoFZv9b9wA8GNTwskt6oqzI7EFUi28I4G8OEoSyTsnlqYDi4JppUuB
	 ruUD7Fk48RLDQ==
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
Subject: [PATCH 13/15] crypto: x86 - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:21 -0700
Message-ID: <20250417182623.67808-14-ebiggers@kernel.org>
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
CRYPTO_BLAKE2S_X86, CRYPTO_CHACHA20_X86_64, and CRYPTO_POLY1305_X86_64.
To do this, make arch/x86/crypto/Kconfig be sourced regardless of
CRYPTO, and explicitly list the CRYPTO dependency in the symbols that do
need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig        |  4 +++
 arch/x86/crypto/Kconfig | 61 +++++++++++++++++++++--------------------
 crypto/Kconfig          |  6 ----
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..24346944439a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2382,10 +2382,14 @@ config X86_BUS_LOCK_DETECT
 	default y
 	help
 	  Enable Split Lock Detect and Bus Lock Detect functionalities.
 	  See <file:Documentation/arch/x86/buslock.rst> for more information.
 
+if !KMSAN # avoid false positives from assembly
+source "arch/x86/crypto/Kconfig"
+endif
+
 endmenu
 
 config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
 	depends on CC_IS_GCC
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index b4df6cf37e0e..daa168e37b59 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
 config CRYPTO_CURVE25519_X86
 	tristate
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
@@ -15,10 +15,11 @@ config CRYPTO_CURVE25519_X86
 	  Architecture: x86_64 using:
 	  - ADX (large integer arithmetic)
 
 config CRYPTO_AES_NI_INTEL
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XCTR, XTS, GCM (AES-NI/VAES)"
+	depends on CRYPTO
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
@@ -34,11 +35,11 @@ config CRYPTO_AES_NI_INTEL
 	  Some algorithm implementations are supported only in 64-bit builds,
 	  and some have additional prerequisites such as AVX2 or AVX512.
 
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Blowfish cipher algorithm
@@ -46,22 +47,22 @@ config CRYPTO_BLOWFISH_X86_64
 
 	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Camellia cipher algorithms
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
 	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	imply CRYPTO_XTS
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
@@ -70,22 +71,22 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	  - AES-NI (AES New Instructions)
 	  - AVX (Advanced Vector Extensions)
 
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
 	  Architecture: x86_64 using:
 	  - AES-NI (AES New Instructions)
 	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "Ciphers: CAST5 with modes: ECB, CBC (AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
 	imply CRYPTO_CTR
 	help
@@ -97,11 +98,11 @@ config CRYPTO_CAST5_AVX_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "Ciphers: CAST6 with modes: ECB, CBC (AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
@@ -114,11 +115,11 @@ config CRYPTO_CAST6_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Ciphers: Triple DES EDE with modes: ECB, CBC"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Triple DES EDE (FIPS 46-3) cipher algorithm
@@ -128,11 +129,11 @@ config CRYPTO_DES3_EDE_X86_64
 
 	  Processes one or three blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (SSE2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_CTR
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -143,11 +144,11 @@ config CRYPTO_SERPENT_SSE2_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Ciphers: Serpent with modes: ECB, CBC (32-bit with SSE2)"
-	depends on !64BIT
+	depends on CRYPTO && !64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_CTR
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -158,11 +159,11 @@ config CRYPTO_SERPENT_SSE2_586
 
 	  Processes four blocks in parallel.
 
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
@@ -174,11 +175,11 @@ config CRYPTO_SERPENT_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
 	  with ECB and CBC modes
 
@@ -187,11 +188,11 @@ config CRYPTO_SERPENT_AVX2_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_SM4_AESNI_AVX_X86_64
 	tristate "Ciphers: SM4 with modes: ECB, CBC, CTR (AES-NI/AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
 	  Length-preserving ciphers: SM4 cipher algorithms
@@ -207,11 +208,11 @@ config CRYPTO_SM4_AESNI_AVX_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_SM4_AESNI_AVX2_X86_64
 	tristate "Ciphers: SM4 with modes: ECB, CBC, CTR (AES-NI/AVX2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	select CRYPTO_SM4_AESNI_AVX_X86_64
 	help
@@ -228,33 +229,33 @@ config CRYPTO_SM4_AESNI_AVX2_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_TWOFISH_586
 	tristate "Ciphers: Twofish (32-bit)"
-	depends on !64BIT
+	depends on CRYPTO && !64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Twofish cipher algorithm
 
 	  Architecture: x86 (32-bit)
 
 config CRYPTO_TWOFISH_X86_64
 	tristate "Ciphers: Twofish"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Twofish cipher algorithm
 
 	  Architecture: x86_64
 
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Ciphers: Twofish with modes: ECB, CBC (3-way parallel)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	help
 	  Length-preserving cipher: Twofish cipher algorithm
@@ -265,11 +266,11 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 	  Processes three blocks in parallel, better utilizing resources of
 	  out-of-order CPUs.
 
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Ciphers: Twofish with modes: ECB, CBC (AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	select CRYPTO_TWOFISH_X86_64_3WAY
 	imply CRYPTO_XTS
@@ -282,11 +283,11 @@ config CRYPTO_TWOFISH_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_ARIA_AESNI_AVX_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AES-NI/AVX/GFNI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	help
 	  Length-preserving cipher: ARIA cipher algorithms
@@ -299,11 +300,11 @@ config CRYPTO_ARIA_AESNI_AVX_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_ARIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AES-NI/AVX2/GFNI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	select CRYPTO_ARIA_AESNI_AVX_X86_64
 	help
@@ -317,11 +318,11 @@ config CRYPTO_ARIA_AESNI_AVX2_X86_64
 
 	  Processes 32 blocks in parallel.
 
 config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AVX512/GFNI)"
-	depends on 64BIT && AS_GFNI
+	depends on CRYPTO && 64BIT && AS_GFNI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	select CRYPTO_ARIA_AESNI_AVX_X86_64
 	select CRYPTO_ARIA_AESNI_AVX2_X86_64
@@ -342,32 +343,32 @@ config CRYPTO_CHACHA20_X86_64
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE4.1)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_AEAD
 	help
 	  AEGIS-128 AEAD algorithm
 
 	  Architecture: x86_64 using:
 	  - AES-NI (AES New Instructions)
 	  - SSE4.1 (Streaming SIMD Extensions 4.1)
 
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "Hash functions: NHPoly1305 (SSE2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
 
 	  Architecture: x86_64 using:
 	  - SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "Hash functions: NHPoly1305 (AVX2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
 
 	  Architecture: x86_64 using:
@@ -385,11 +386,11 @@ config CRYPTO_BLAKE2S_X86
 	  - SSSE3 (Supplemental SSE3)
 	  - AVX-512 (Advanced Vector Extensions-512)
 
 config CRYPTO_POLYVAL_CLMUL_NI
 	tristate "Hash functions: POLYVAL (CLMUL-NI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_POLYVAL
 	help
 	  POLYVAL hash function for HCTR2
 
 	  Architecture: x86_64 using:
@@ -401,11 +402,11 @@ config CRYPTO_POLY1305_X86_64
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
@@ -415,11 +416,11 @@ config CRYPTO_SHA1_SSSE3
 	  - AVX2 (Advanced Vector Extensions 2)
 	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA256_SSSE3
 	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
@@ -429,11 +430,11 @@ config CRYPTO_SHA256_SSSE3
 	  - AVX2 (Advanced Vector Extensions 2)
 	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA512_SSSE3
 	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
@@ -442,11 +443,11 @@ config CRYPTO_SHA512_SSSE3
 	  - AVX (Advanced Vector Extensions)
 	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_SM3_AVX_X86_64
 	tristate "Hash functions: SM3 (AVX)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
 	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3
 
@@ -455,11 +456,11 @@ config CRYPTO_SM3_AVX_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "Hash functions: GHASH (CLMUL-NI)"
-	depends on 64BIT
+	depends on CRYPTO && 64BIT
 	select CRYPTO_CRYPTD
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: x86_64 using:
diff --git a/crypto/Kconfig b/crypto/Kconfig
index c0906bb4f844..7e207f3d3eca 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1423,16 +1423,10 @@ config CRYPTO_USER_API_ENABLE_OBSOLETE
 endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
-if !KMSAN # avoid false positives from assembly
-if X86
-source "arch/x86/crypto/Kconfig"
-endif
-endif
-
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
 source "crypto/krb5/Kconfig"
 
-- 
2.49.0


