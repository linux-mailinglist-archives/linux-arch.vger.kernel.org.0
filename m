Return-Path: <linux-arch+bounces-11501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48392A970BF
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD517842A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028B2900BB;
	Tue, 22 Apr 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj+wrtdf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F32900B2;
	Tue, 22 Apr 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335696; cv=none; b=erqB2u2Ve5pRaXmWAgtaSA8ed/0aWovJOntgcPPjD8Wxor3dOhLPGUdnZmC+y/FRpu8jEA2Sdbf1u6RrKkrPYoU6MTQDS0ejHXeJ7n4q1+bk5Q7ypCp+0tn1LA4oWeVmtDa2zwCkHunXKsmLcXgTtkOcDY3zgXBrsFuO0m7BMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335696; c=relaxed/simple;
	bh=mivDVzERcJd4HNiCgpjTrrXLffBBYDH/2mu7Bg91B/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2293pCpnW+Ur200ooKx/KPzujZW3ouGbMm1V0FuCmM61qZkZwm1/Q/YuuiFqm4IxG6E9gb8Lpp6a/+0TUVK3qYgDM9uNYPenl5uzJLTKRrEiDXjwV8K7lqycL1CnsnsRirsAnunjYCJXOYBAUqTyuBAz3xD3+VoGsuowbA811k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj+wrtdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE7C4CEED;
	Tue, 22 Apr 2025 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335696;
	bh=mivDVzERcJd4HNiCgpjTrrXLffBBYDH/2mu7Bg91B/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj+wrtdfeqBJ8WM1Iq0fnUetrC8DmNpjL8TqEfHH94kKRQeIJt44m90X4KOz25SnB
	 KnyH44Oj9ws0gMgpTWfaRZ2oYObCxpe+A7oSAS4bLqmMJ03UR9/HZa944YLwsNk6vc
	 T0o1JO8Vca7TbEOVIkCwO72qV+FBVKjoMOmtgJutgOWj6bEeOWyu6ZlN9EX4Jr5pse
	 ExssFG28Uic0LwpytjeFuhl+00hZ9LB9QxISLsd52aSb8hUVV5VFGWOESq4i8veBB1
	 hPI7rhAuC+upfa/vR+Yz46t2R5BsFTR9nbbBMOZVzjYNT9jSeHzbmfQcPwO7Tca8pS
	 t+ST9tLmcXXPA==
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
Subject: [PATCH v3 04/13] crypto: x86 - drop redundant dependencies on X86
Date: Tue, 22 Apr 2025 08:27:07 -0700
Message-ID: <20250422152716.5923-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422152716.5923-1-ebiggers@kernel.org>
References: <20250422152716.5923-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

arch/x86/crypto/Kconfig is sourced only when CONFIG_X86=y, so there is
no need for the symbols defined inside it to depend on X86.

In the case of CRYPTO_TWOFISH_586 and CRYPTO_TWOFISH_X86_64, the
dependency was actually on '(X86 || UML_X86)', which suggests that these
two symbols were intended to be available under user-mode Linux as well.
Yet, again these symbols were defined only when CONFIG_X86=y, so that
was not the case.  Just remove this redundant dependency.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Kconfig | 67 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9a3cade49f638..b4df6cf37e0ea 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
 config CRYPTO_CURVE25519_X86
 	tristate
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
@@ -15,11 +15,10 @@ config CRYPTO_CURVE25519_X86
 	  Architecture: x86_64 using:
 	  - ADX (large integer arithmetic)
 
 config CRYPTO_AES_NI_INTEL
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XCTR, XTS, GCM (AES-NI/VAES)"
-	depends on X86
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_GF128MUL
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
@@ -35,11 +34,11 @@ config CRYPTO_AES_NI_INTEL
 	  Some algorithm implementations are supported only in 64-bit builds,
 	  and some have additional prerequisites such as AVX2 or AVX512.
 
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Blowfish cipher algorithm
@@ -47,22 +46,22 @@ config CRYPTO_BLOWFISH_X86_64
 
 	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Camellia cipher algorithms
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
 	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	imply CRYPTO_XTS
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
@@ -71,22 +70,22 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	  - AES-NI (AES New Instructions)
 	  - AVX (Advanced Vector Extensions)
 
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
 	  Architecture: x86_64 using:
 	  - AES-NI (AES New Instructions)
 	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "Ciphers: CAST5 with modes: ECB, CBC (AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
 	imply CRYPTO_CTR
 	help
@@ -98,11 +97,11 @@ config CRYPTO_CAST5_AVX_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "Ciphers: CAST6 with modes: ECB, CBC (AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
@@ -115,11 +114,11 @@ config CRYPTO_CAST6_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Ciphers: Triple DES EDE with modes: ECB, CBC"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Triple DES EDE (FIPS 46-3) cipher algorithm
@@ -129,11 +128,11 @@ config CRYPTO_DES3_EDE_X86_64
 
 	  Processes one or three blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (SSE2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_CTR
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -144,11 +143,11 @@ config CRYPTO_SERPENT_SSE2_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Ciphers: Serpent with modes: ECB, CBC (32-bit with SSE2)"
-	depends on X86 && !64BIT
+	depends on !64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_CTR
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -159,11 +158,11 @@ config CRYPTO_SERPENT_SSE2_586
 
 	  Processes four blocks in parallel.
 
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
@@ -175,11 +174,11 @@ config CRYPTO_SERPENT_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
 	  with ECB and CBC modes
 
@@ -188,11 +187,11 @@ config CRYPTO_SERPENT_AVX2_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_SM4_AESNI_AVX_X86_64
 	tristate "Ciphers: SM4 with modes: ECB, CBC, CTR (AES-NI/AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
 	  Length-preserving ciphers: SM4 cipher algorithms
@@ -208,11 +207,11 @@ config CRYPTO_SM4_AESNI_AVX_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_SM4_AESNI_AVX2_X86_64
 	tristate "Ciphers: SM4 with modes: ECB, CBC, CTR (AES-NI/AVX2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	select CRYPTO_SM4_AESNI_AVX_X86_64
 	help
@@ -229,33 +228,33 @@ config CRYPTO_SM4_AESNI_AVX2_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_TWOFISH_586
 	tristate "Ciphers: Twofish (32-bit)"
-	depends on (X86 || UML_X86) && !64BIT
+	depends on !64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Twofish cipher algorithm
 
 	  Architecture: x86 (32-bit)
 
 config CRYPTO_TWOFISH_X86_64
 	tristate "Ciphers: Twofish"
-	depends on (X86 || UML_X86) && 64BIT
+	depends on 64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
 	  Block cipher: Twofish cipher algorithm
 
 	  Architecture: x86_64
 
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Ciphers: Twofish with modes: ECB, CBC (3-way parallel)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	help
 	  Length-preserving cipher: Twofish cipher algorithm
@@ -266,11 +265,11 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 	  Processes three blocks in parallel, better utilizing resources of
 	  out-of-order CPUs.
 
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Ciphers: Twofish with modes: ECB, CBC (AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	select CRYPTO_TWOFISH_X86_64_3WAY
 	imply CRYPTO_XTS
@@ -283,11 +282,11 @@ config CRYPTO_TWOFISH_AVX_X86_64
 
 	  Processes eight blocks in parallel.
 
 config CRYPTO_ARIA_AESNI_AVX_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AES-NI/AVX/GFNI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	help
 	  Length-preserving cipher: ARIA cipher algorithms
@@ -300,11 +299,11 @@ config CRYPTO_ARIA_AESNI_AVX_X86_64
 
 	  Processes 16 blocks in parallel.
 
 config CRYPTO_ARIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AES-NI/AVX2/GFNI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	select CRYPTO_ARIA_AESNI_AVX_X86_64
 	help
@@ -318,11 +317,11 @@ config CRYPTO_ARIA_AESNI_AVX2_X86_64
 
 	  Processes 32 blocks in parallel.
 
 config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AVX512/GFNI)"
-	depends on X86 && 64BIT && AS_GFNI
+	depends on 64BIT && AS_GFNI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
 	select CRYPTO_ARIA_AESNI_AVX_X86_64
 	select CRYPTO_ARIA_AESNI_AVX2_X86_64
@@ -336,49 +335,49 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 
 	  Processes 64 blocks in parallel.
 
 config CRYPTO_CHACHA20_X86_64
 	tristate
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE4.1)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_AEAD
 	help
 	  AEGIS-128 AEAD algorithm
 
 	  Architecture: x86_64 using:
 	  - AES-NI (AES New Instructions)
 	  - SSE4.1 (Streaming SIMD Extensions 4.1)
 
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "Hash functions: NHPoly1305 (SSE2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
 
 	  Architecture: x86_64 using:
 	  - SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "Hash functions: NHPoly1305 (AVX2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
 
 	  Architecture: x86_64 using:
 	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_BLAKE2S_X86
 	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
 	  BLAKE2s cryptographic hash function (RFC 7693)
 
@@ -386,27 +385,27 @@ config CRYPTO_BLAKE2S_X86
 	  - SSSE3 (Supplemental SSE3)
 	  - AVX-512 (Advanced Vector Extensions-512)
 
 config CRYPTO_POLYVAL_CLMUL_NI
 	tristate "Hash functions: POLYVAL (CLMUL-NI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_POLYVAL
 	help
 	  POLYVAL hash function for HCTR2
 
 	  Architecture: x86_64 using:
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_POLY1305_X86_64
 	tristate
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
@@ -416,11 +415,11 @@ config CRYPTO_SHA1_SSSE3
 	  - AVX2 (Advanced Vector Extensions 2)
 	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA256_SSSE3
 	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
@@ -430,11 +429,11 @@ config CRYPTO_SHA256_SSSE3
 	  - AVX2 (Advanced Vector Extensions 2)
 	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA512_SSSE3
 	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
@@ -443,11 +442,11 @@ config CRYPTO_SHA512_SSSE3
 	  - AVX (Advanced Vector Extensions)
 	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_SM3_AVX_X86_64
 	tristate "Hash functions: SM3 (AVX)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
 	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3
 
@@ -456,11 +455,11 @@ config CRYPTO_SM3_AVX_X86_64
 
 	  If unsure, say N.
 
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "Hash functions: GHASH (CLMUL-NI)"
-	depends on X86 && 64BIT
+	depends on 64BIT
 	select CRYPTO_CRYPTD
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: x86_64 using:
-- 
2.49.0


