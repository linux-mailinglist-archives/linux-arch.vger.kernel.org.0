Return-Path: <linux-arch+bounces-11433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE99A92847
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE3164D70
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7C267B91;
	Thu, 17 Apr 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDsCxtn3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDE267B16;
	Thu, 17 Apr 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914432; cv=none; b=HMwxOsK9jj4bTesh6rP6/kDoWJUzm/4m6R5iN7g5arvz8etGiBzIJuRlwS2C3QGBTHYregKziabJRGaVXKrPqts0qR0oLDLT0NSzcoWN+5tZYSqlbnsSrqZ0RP642kC8HwLOIaAs9Ww37gcB7IzWZPTFYavfT3XVC9euwTumeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914432; c=relaxed/simple;
	bh=dsE7qfp3A3zmlcPG+tvm4sv24/L4ppO0aAJ6BZiEshE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmmTG08Z2RAdrtXWkDzbjADu+LZJuKb4ucBtoB3Vp4vZ1pLuVfdSgnpIkmR7bz0K6yPpVMhgtt7JfmCOdZDPzW4mvXaAguaQaMTSePGju6GeBJnvb/Iq3JA0NDlXRNn8bMu+W4ZXdaw8LXCNu4aLiJpa/A5pWLP9rOUTS0LMaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDsCxtn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96532C4CEEA;
	Thu, 17 Apr 2025 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914432;
	bh=dsE7qfp3A3zmlcPG+tvm4sv24/L4ppO0aAJ6BZiEshE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDsCxtn3lebQV/DysLhlXFbm/jncgwomZE43WtxQP24LtFE9xOa6eiBclZTQg8gDA
	 3i+j3v6r50KIUvO1d2f48AAFIoj4fUY/I6hS7t2+pB5aL99Y91V+Kzolg1S3dFzK1W
	 YmIRVjS0t8vEJ6EiUPzxMajKFyxEWSlavCF2LEd6VhnTb/rYUhXfOqH5nXDNaDa8ni
	 ar9klYXp61RWo3pSI30VW4AUilqd4McXNnCe0pDOHszpxAKhTden3pUGSby2brHFmP
	 9x6UwlkgdIPBH9H34XsZtVKioNaIav0ZkUaIIrvvYZfYdw17pnWZSyakOtR5xQXcRz
	 o04U7Rx5/k7vg==
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
Subject: [PATCH 07/15] crypto: powerpc - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:15 -0700
Message-ID: <20250417182623.67808-8-ebiggers@kernel.org>
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
CRYPTO_CHACHA20_P10 and CRYPTO_POLY1305_P10.  To do this, make
arch/powerpc/crypto/Kconfig be sourced regardless of CRYPTO, and
explicitly list the CRYPTO dependency in the symbols that do need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/Kconfig        |  2 ++
 arch/powerpc/crypto/Kconfig | 16 +++++++++-------
 crypto/Kconfig              |  3 ---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6722625a406a..9ffd80880675 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1346,8 +1346,10 @@ config PHYSICAL_START
 endif
 
 config PPC_LIB_RHEAP
 	bool
 
+source "arch/powerpc/crypto/Kconfig"
+
 source "arch/powerpc/kvm/Kconfig"
 
 source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 8bcc69013464..0f14bdf104d5 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (powerpc)"
 
 config CRYPTO_CURVE25519_PPC64
 	tristate
-	depends on PPC64 && CPU_LITTLE_ENDIAN
+	depends on CRYPTO && PPC64 && CPU_LITTLE_ENDIAN
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	default CRYPTO_LIB_CURVE25519_INTERNAL
 	help
@@ -15,46 +15,48 @@ config CRYPTO_CURVE25519_PPC64
 	  Architecture: PowerPC64
 	  - Little-endian
 
 config CRYPTO_MD5_PPC
 	tristate "Digests: MD5"
+	depends on CRYPTO
 	select CRYPTO_HASH
 	help
 	  MD5 message digest algorithm (RFC1321)
 
 	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC
 	tristate "Hash functions: SHA-1"
+	depends on CRYPTO
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC_SPE
 	tristate "Hash functions: SHA-1 (SPE)"
-	depends on SPE
+	depends on CRYPTO && SPE
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: powerpc using
 	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_SHA256_PPC_SPE
 	tristate "Hash functions: SHA-224 and SHA-256 (SPE)"
-	depends on SPE
+	depends on CRYPTO && SPE
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: powerpc using
 	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_AES_PPC_SPE
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (SPE)"
-	depends on SPE
+	depends on CRYPTO && SPE
 	select CRYPTO_SKCIPHER
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 	  Length-preserving ciphers: AES with ECB, CBC, CTR, and XTS modes
 
@@ -72,11 +74,11 @@ config CRYPTO_AES_PPC_SPE
 	  architecture specific assembler implementations that work on 1KB
 	  tables or 256 bytes S-boxes.
 
 config CRYPTO_AES_GCM_P10
 	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
-	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	depends on CRYPTO && PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
@@ -104,17 +106,17 @@ config CRYPTO_POLY1305_P10
 	select CRYPTO_LIB_POLY1305_GENERIC
 	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_DEV_VMX
         bool "Support for VMX cryptographic acceleration instructions"
-        depends on PPC64 && VSX
+        depends on CRYPTO && PPC64 && VSX
         help
           Support for VMX cryptographic acceleration instructions.
 
 config CRYPTO_DEV_VMX_ENCRYPT
 	tristate "Encryption acceleration support on P8 CPU"
-	depends on CRYPTO_DEV_VMX
+	depends on CRYPTO && CRYPTO_DEV_VMX
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_CTR
 	select CRYPTO_GHASH
 	select CRYPTO_XTS
diff --git a/crypto/Kconfig b/crypto/Kconfig
index cfa426bea0c6..2467dba73372 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if PPC
-source "arch/powerpc/crypto/Kconfig"
-endif
 if RISCV
 source "arch/riscv/crypto/Kconfig"
 endif
 if S390
 source "arch/s390/crypto/Kconfig"
-- 
2.49.0


