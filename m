Return-Path: <linux-arch+bounces-11435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA63A92852
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58442189C9E3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036B268FE9;
	Thu, 17 Apr 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFRg94yt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFD268C69;
	Thu, 17 Apr 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914434; cv=none; b=r9Lp+RCxFJ8ka4YHVJ6lTbAmgPW0IJGhz64beJ1B58QJ8ItvXm4KJ2oqAbTtCRP33zwKBlNNlYLczP6GXNohIemo9JdxBhS47H0/fo4kuQWIw5vknD4/O1ccxMEP5BIvzUkyTZy7CR8aO3B0WysB8XRW8NmB0qW3JoM0QmASk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914434; c=relaxed/simple;
	bh=obiaeiH3M3/PJ05fFDi3tJIZJm6vLPgHN3Yv3HcRMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNDDGSRvgTLjEA0K1rnf9+mMr8f0uzCuABpamzr/6XMg4w3+a55t6yQ8kYx/ErJIIHVtQ+DM3DDcuPB0A+tvkvsJ838TAqiqFs6vbrpVlWqLRfwgHbnrWYopgZTzju0TSjQWcZCATRYSRWRxM+TgifernXlfXuohW4z15maoV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFRg94yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E381C4CEE7;
	Thu, 17 Apr 2025 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914434;
	bh=obiaeiH3M3/PJ05fFDi3tJIZJm6vLPgHN3Yv3HcRMYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFRg94ytvFwWb9eEX7DfMbWd/h6Y8idIO3Z1B3mXh/Djib/YaOtCh+29vjwVs79SA
	 QM9c0oAyqr0FmMxLVQo0BJjGSeljXZv+0ige27EFJNNGFGIrjB8PFGGxLYh9gNSLjL
	 OBJEI5gLRWvc/6c5B8jhHR1zHzlvZe5+dcUS3we+S5R+BYOZA0qjnPGO/f4gjySuGi
	 9Xc7Ce01qxhIBBgjg4Do4jIs/J3qRFhT6eXBcCtyOmba9O27SK9Cs3evZHonw/v4sI
	 CfLmw9KzH2g+HVO2hDtYFuLXnqYzsaGMf/n9P6mu//qnJKjcB6bDArCoeA6HE2U4Ts
	 VvktptufPNesg==
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
Subject: [PATCH 09/15] crypto: s390 - drop redundant dependencies on S390
Date: Thu, 17 Apr 2025 11:26:17 -0700
Message-ID: <20250417182623.67808-10-ebiggers@kernel.org>
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

arch/s390/crypto/Kconfig is sourced only when CONFIG_S390=y, so there is
no need for the symbols defined inside it to depend on S390.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/crypto/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index 055b08f259ab..e88d9cd256ef 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -2,77 +2,70 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (s390)"
 
 config CRYPTO_SHA512_S390
 	tristate "Hash functions: SHA-384 and SHA-512"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z10.
 
 config CRYPTO_SHA1_S390
 	tristate "Hash functions: SHA-1"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z990.
 
 config CRYPTO_SHA256_S390
 	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z9.
 
 config CRYPTO_SHA3_256_S390
 	tristate "Hash functions: SHA3-224 and SHA3-256"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  SHA3-224 and SHA3-256 secure hash algorithms (FIPS 202)
 
 	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_SHA3_512_S390
 	tristate "Hash functions: SHA3-384 and SHA3-512"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  SHA3-384 and SHA3-512 secure hash algorithms (FIPS 202)
 
 	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_GHASH_S390
 	tristate "Hash functions: GHASH"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: s390
 
 	  It is available as of z196.
 
 config CRYPTO_AES_S390
 	tristate "Ciphers: AES, modes: ECB, CBC, CTR, XTS, GCM"
-	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
 	  Block cipher: AES cipher algorithms (FIPS 197)
 	  AEAD cipher: AES with GCM
@@ -90,11 +83,10 @@ config CRYPTO_AES_S390
 	  key sizes and XTS mode is hardware accelerated for 256 and
 	  512 bit keys.
 
 config CRYPTO_DES_S390
 	tristate "Ciphers: DES and Triple DES EDE, modes: ECB, CBC, CTR"
-	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	help
 	  Block ciphers: DES (FIPS 46-2) cipher algorithm
@@ -107,18 +99,16 @@ config CRYPTO_DES_S390
 	  As of z990 the ECB and CBC mode are hardware accelerated.
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_CHACHA_S390
 	tristate
-	depends on S390
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_HMAC_S390
 	tristate "Keyed-hash message authentication code: HMAC"
-	depends on S390
 	select CRYPTO_HASH
 	help
 	  s390 specific HMAC hardware support for SHA224, SHA256, SHA384 and
 	  SHA512.
 
-- 
2.49.0


