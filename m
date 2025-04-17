Return-Path: <linux-arch+bounces-11427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0987A927FB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A8D19E72D4
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41778263C7C;
	Thu, 17 Apr 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNicRjUq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F512638B2;
	Thu, 17 Apr 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914427; cv=none; b=kJVTl9WrCN+2K8SvLBhSJRZB1t4Mm3nr0t7E+kK9IDtZ8Xc9TFA7Iaktx504qTmMbeRwA3Drh28oin0WpBU1DxrP+4D+v5WNvs1JcjR1mE4rKVKthgJfHM5sxez1u3AqxZ5hqpRI0myS/fcKlnwvWZ34ODnYfkRpdIDYSjUH0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914427; c=relaxed/simple;
	bh=5dSTk9hCMalH9KouPCri0ueCaynOtEG8zNL9Aah4GBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6niflPSxzhq3hJMWErlIauQgj131g6kR3XHmD/I+BwEErNZRiAS4N/SRFJ7WBdmmfLTfrMUPKYAElsazMDguUE77XKzzcwpawGnx0X3z+q0PaeCfSSl1+42adQvt3NamZ5qYXl6dM9FyHhZ58IHNApL0BKYIfQLG07Ei6KepXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNicRjUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1FFC4CEFC;
	Thu, 17 Apr 2025 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914426;
	bh=5dSTk9hCMalH9KouPCri0ueCaynOtEG8zNL9Aah4GBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNicRjUq6+lSEG5MUjPWjKxrQv9g7Uqlt4v1mUDqOzfDmTlQ78EnINfC/7p4hhuLf
	 unDZ581a3lk1/CyVkyU/eRAe8C1IEg8saysLWZqDZWXoA45KcXcO4coHUJBFTuU3UU
	 +xsr3CESWT7KSNaneo8H65gLiuHccxH4KxKzFFMUUZGv2t6JHGf1kSabQmxcF0YHfK
	 mOf5Xw8XfiwsxdjEmQE1c84/BkqF9yF6Tj0betPMHuynJy3dKUlBW0wahGrgSTudTe
	 CMjPBeWPikTExhX+uBX+hcFcEgCFnb0elSvHf6BGxQc70WYDafl8soF2IP0mVYCoWJ
	 eIX8TaKHJUMvQ==
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
Subject: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:09 -0700
Message-ID: <20250417182623.67808-2-ebiggers@kernel.org>
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
CRYPTO_BLAKE2S_ARM, CRYPTO_CHACHA20_NEON, and CRYPTO_POLY1305_ARM.  To
do this, make arch/arm/crypto/Kconfig be sourced regardless of CRYPTO,
and explicitly list the CRYPTO dependency in the symbols that do need
it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/Kconfig        |  2 ++
 arch/arm/crypto/Kconfig | 24 +++++++++++++-----------
 crypto/Kconfig          |  3 ---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 25ed6f1a7c7a..86fcce738887 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1753,5 +1753,7 @@ config ARCH_HIBERNATION_POSSIBLE
 	bool
 	depends on MMU
 	default y if ARCH_SUSPEND_POSSIBLE
 
 endmenu
+
+source "arch/arm/crypto/Kconfig"
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 3530e7c80793..a03017a6dbc4 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
 config CRYPTO_CURVE25519_NEON
 	tristate
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
@@ -15,11 +15,11 @@ config CRYPTO_CURVE25519_NEON
 	  Architecture: arm with
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_GHASH_ARM_CE
 	tristate "Hash functions: GHASH (PMULL/NEON/ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_AEAD
 	select CRYPTO_HASH
 	select CRYPTO_CRYPTD
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_GF128MUL
@@ -36,11 +36,11 @@ config CRYPTO_GHASH_ARM_CE
 	  that is part of the ARMv8 Crypto Extensions, or a slower variant that
 	  uses the vmull.p8 instruction that is part of the basic NEON ISA.
 
 config CRYPTO_NHPOLY1305_NEON
 	tristate "Hash functions: NHPoly1305 (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function (Adiantum)
 
 	  Architecture: arm using:
@@ -64,11 +64,11 @@ config CRYPTO_BLAKE2S_ARM
 	  There is no NEON implementation of BLAKE2s, since NEON doesn't
 	  really help with it.
 
 config CRYPTO_BLAKE2B_NEON
 	tristate "Hash functions: BLAKE2b (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_BLAKE2B
 	help
 	  BLAKE2b cryptographic hash function (RFC 7693)
 
 	  Architecture: arm using
@@ -80,20 +80,21 @@ config CRYPTO_BLAKE2B_NEON
 	  much faster than the SHA-2 family and slightly faster than
 	  SHA-1.
 
 config CRYPTO_SHA1_ARM
 	tristate "Hash functions: SHA-1"
+	depends on CRYPTO
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: arm
 
 config CRYPTO_SHA1_ARM_NEON
 	tristate "Hash functions: SHA-1 (NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SHA1_ARM
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
@@ -101,51 +102,52 @@ config CRYPTO_SHA1_ARM_NEON
 	  Architecture: arm using
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SHA1_ARM_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SHA1_ARM
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: arm using ARMv8 Crypto Extensions
 
 config CRYPTO_SHA2_ARM_CE
 	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SHA256_ARM
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm using
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA256_ARM
 	tristate "Hash functions: SHA-224 and SHA-256 (NEON)"
+	depends on CRYPTO && !CPU_V7M
 	select CRYPTO_HASH
-	depends on !CPU_V7M
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm using
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SHA512_ARM
 	tristate "Hash functions: SHA-384 and SHA-512 (NEON)"
+	depends on CRYPTO && !CPU_V7M
 	select CRYPTO_HASH
-	depends on !CPU_V7M
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: arm using
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM
 	tristate "Ciphers: AES"
+	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 
@@ -160,11 +162,11 @@ config CRYPTO_AES_ARM
 	  disables IRQs and preloads the tables; it is hoped this makes
 	  such attacks very difficult.
 
 config CRYPTO_AES_ARM_BS
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (bit-sliced NEON)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_AES_ARM
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
 	help
 	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
@@ -188,11 +190,11 @@ config CRYPTO_AES_ARM_BS
 	  ciphertext stealing when the message isn't a multiple of 16 bytes, and
 	  CTR when invoked in a context in which NEON instructions are unusable.
 
 config CRYPTO_AES_ARM_CE
 	tristate "Ciphers: AES, modes: ECB/CBC/CTS/CTR/XTS (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
+	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
 	help
 	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
 	   with block cipher modes:
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9322e42e562d..cad71f32e1e3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if ARM
-source "arch/arm/crypto/Kconfig"
-endif
 if ARM64
 source "arch/arm64/crypto/Kconfig"
 endif
 if LOONGARCH
 source "arch/loongarch/crypto/Kconfig"
-- 
2.49.0


