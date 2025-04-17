Return-Path: <linux-arch+bounces-11436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD6A92865
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7CC3A68D7
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61690269898;
	Thu, 17 Apr 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbNidi6A"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B32269830;
	Thu, 17 Apr 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914435; cv=none; b=ggVDANTmFVxDBFcWPud4wJFy21h6NWyg8zjawRBVl+pmQtQd3CtcFtzVLnU29zD9QZNjQiPFcxfvdtG4rXTBil6KTC//1DS8I+qSoEn0DU4eYa4QytTnXRvlHhnlJmELXQbNrXZ2+Lde0t6cJU8aFzP7+ZvQ3iwW1eIX0QQpSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914435; c=relaxed/simple;
	bh=wTYOYOEcD2tS5YApzAw5JpRPXQeBTl3cVi6SPyyOu+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVbijrkhKJUBYH/xNAtn2EWsWcg+WlVbeXWWCJs6D3f0gMFCQpmaLVNMU6NWfxw2Sk9ttur/X33IliGSRdWeWbMpSp97lrLe+Y1b4QuuwZ4Jej+D3l7ihXm8AoOXzS9+qlTfpIikRC8oGfL0hxLGXGk4jwrcMWONRSRBo4KSpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbNidi6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4949CC4CEEC;
	Thu, 17 Apr 2025 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914435;
	bh=wTYOYOEcD2tS5YApzAw5JpRPXQeBTl3cVi6SPyyOu+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbNidi6AtUqg9ISmFMuBJvftddFhJ2bcWeL+ejDz2zW4ZErEzBHzZYDummTru8tmW
	 y4GOfnNa09S9itz1MfWA23c6oDCpNd7uqxbv1F/9JdCV0B2Db+8HsWek8EzVZdO+vO
	 +sRYZ5pucJykN1CDLhm35tsJPBJYshSIF25x70GuEHXa11iNNqyuO1DDOcDJ2EkRza
	 xWWwnzzSLvJGFi/kjZWECMXrYXrGklDMeY0x2rXJWAIFC+B6H8ACWQ5kPnlU+4xN3i
	 mkhVtPkRCj5RRVowUKtQFtRaTZhi7MCmpNj8shK6yD8mqvrdNNF7TxpMUYCJ9d3FwO
	 qcCdh5Ka8LHMQ==
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
Subject: [PATCH 10/15] crypto: s390 - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:18 -0700
Message-ID: <20250417182623.67808-11-ebiggers@kernel.org>
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
CRYPTO_CHACHA_S390.  To do this, make arch/s390/crypto/Kconfig be
sourced regardless of CRYPTO, and explicitly list the CRYPTO dependency
in the symbols that do need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/Kconfig        | 4 ++++
 arch/s390/crypto/Kconfig | 9 +++++++++
 crypto/Kconfig           | 3 ---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index db8161ebb43c..2f32d51e8a73 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -679,10 +679,14 @@ config KERNEL_IMAGE_BASE
 
 	  If the value of this option leads to the kernel image overlapping
 	  the virtual memory where other data structures are located, this
 	  option is ignored and the image is loaded above the structures.
 
+if !KMSAN # avoid false positives from assembly
+source "arch/s390/crypto/Kconfig"
+endif
+
 endmenu
 
 menu "Memory setup"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index e88d9cd256ef..a2e6efd8aed8 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -2,70 +2,77 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (s390)"
 
 config CRYPTO_SHA512_S390
 	tristate "Hash functions: SHA-384 and SHA-512"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z10.
 
 config CRYPTO_SHA1_S390
 	tristate "Hash functions: SHA-1"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z990.
 
 config CRYPTO_SHA256_S390
 	tristate "Hash functions: SHA-224 and SHA-256"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: s390
 
 	  It is available as of z9.
 
 config CRYPTO_SHA3_256_S390
 	tristate "Hash functions: SHA3-224 and SHA3-256"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA3-224 and SHA3-256 secure hash algorithms (FIPS 202)
 
 	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_SHA3_512_S390
 	tristate "Hash functions: SHA3-384 and SHA3-512"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  SHA3-384 and SHA3-512 secure hash algorithms (FIPS 202)
 
 	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_GHASH_S390
 	tristate "Hash functions: GHASH"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: s390
 
 	  It is available as of z196.
 
 config CRYPTO_AES_S390
 	tristate "Ciphers: AES, modes: ECB, CBC, CTR, XTS, GCM"
+	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
 	  Block cipher: AES cipher algorithms (FIPS 197)
 	  AEAD cipher: AES with GCM
@@ -83,10 +90,11 @@ config CRYPTO_AES_S390
 	  key sizes and XTS mode is hardware accelerated for 256 and
 	  512 bit keys.
 
 config CRYPTO_DES_S390
 	tristate "Ciphers: DES and Triple DES EDE, modes: ECB, CBC, CTR"
+	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	help
 	  Block ciphers: DES (FIPS 46-2) cipher algorithm
@@ -105,10 +113,11 @@ config CRYPTO_CHACHA_S390
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_HMAC_S390
 	tristate "Keyed-hash message authentication code: HMAC"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  s390 specific HMAC hardware support for SHA224, SHA256, SHA384 and
 	  SHA512.
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8c334c9f2081..78e83ce576ed 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if S390
-source "arch/s390/crypto/Kconfig"
-endif
 if SPARC
 source "arch/sparc/crypto/Kconfig"
 endif
 if X86
 source "arch/x86/crypto/Kconfig"
-- 
2.49.0


