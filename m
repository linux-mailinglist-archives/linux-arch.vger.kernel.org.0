Return-Path: <linux-arch+bounces-11434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F25A9284E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9418884E3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5ED2686B9;
	Thu, 17 Apr 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEzKamQ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D9268699;
	Thu, 17 Apr 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914433; cv=none; b=Ct03/MvLqFLdWlD8i83ET51eKU3KvjZJPxCwegi4C8WZAr2wuOpgj8kBIB5WSqsmIsj72AhrbC2HlVBh6GePvcAfhNP5+IrEVdyoyX4Sxqhbe04+GfARBI+le8CkMUThFsmpxmLRfwHevyYuHTd/F5tcVg1apnWyXe0t0KFfQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914433; c=relaxed/simple;
	bh=UX4WI8EDuBMolYsjuDM2U8XKg5QnChDBXSYKd39EvNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQKcABfPU0/WP3MbhJjT1i+2mA47ixLWPCdVGvxHMKne0cE8GCFiJPcXtu6zUDij494vszC81LOjK0qObrhGO17Nns8StUyQQvWi3KpmPkc8Q9SWeJMe1QrBXO0LckGKQbVkeGmlysWpATNDZGytt8b0w0RJz7R3ikTa8LCeSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEzKamQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7754CC4CEE4;
	Thu, 17 Apr 2025 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914433;
	bh=UX4WI8EDuBMolYsjuDM2U8XKg5QnChDBXSYKd39EvNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEzKamQ77+ydJivcumu5A0EVk/kXXWFfSMds2u7k1YTk1H+rF/67bqU+j+jJWKdl+
	 Q2n7E/dnU6nc5VZ8aq76mLC/hUu6qr1DUvojFRMnBTG+hbecrgjHXxpJDYNWm7g372
	 mmod6G58GI206xhh4cwUi5gmbRp9pUV4UvcKffRJAd/SAd+OZL0MArn+XZe+a+lWse
	 WraOSg0kbetPV1xAm5FmZOqOUclZDEor8z8B8fJwgV0wrK0yHCkvuFiYjwgVictUSB
	 YND7Tu4UPgsbBXF3UxPOsP1otOEQDGQ0geJEuAFCBu/GYCNhtmvhRyLJmhJesven4e
	 nLNW8wApG8jyw==
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
Subject: [PATCH 08/15] crypto: riscv - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:16 -0700
Message-ID: <20250417182623.67808-9-ebiggers@kernel.org>
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
CRYPTO_CHACHA_RISCV64.  To do this, make arch/riscv/crypto/Kconfig be
sourced regardless of CRYPTO, and explicitly list the CRYPTO dependency
in the symbols that do need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/Kconfig        |  2 ++
 arch/riscv/crypto/Kconfig | 12 ++++++------
 crypto/Kconfig            |  3 ---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bbec87b79309..baa7b8d98ed8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1349,8 +1349,10 @@ source "drivers/cpuidle/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
 
 endmenu # "CPU Power Management"
 
+source "arch/riscv/crypto/Kconfig"
+
 source "arch/riscv/kvm/Kconfig"
 
 source "drivers/acpi/Kconfig"
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 27a1f26d41bd..08547694937c 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
 config CRYPTO_AES_RISCV64
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTS"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	select CRYPTO_SKCIPHER
 	help
 	  Block cipher: AES cipher algorithms
@@ -25,43 +25,43 @@ config CRYPTO_CHACHA_RISCV64
 	select CRYPTO_LIB_CHACHA_GENERIC
 	default CRYPTO_LIB_CHACHA_INTERNAL
 
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_GCM
 	help
 	  GCM GHASH function (NIST SP 800-38D)
 
 	  Architecture: riscv64 using:
 	  - Zvkg vector crypto extension
 
 config CRYPTO_SHA256_RISCV64
 	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA256
 	help
 	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
 
 	  Architecture: riscv64 using:
 	  - Zvknha or Zvknhb vector crypto extensions
 	  - Zvkb vector crypto extension
 
 config CRYPTO_SHA512_RISCV64
 	tristate "Hash functions: SHA-384 and SHA-512"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA512
 	help
 	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
 
 	  Architecture: riscv64 using:
 	  - Zvknhb vector crypto extension
 	  - Zvkb vector crypto extension
 
 config CRYPTO_SM3_RISCV64
 	tristate "Hash functions: SM3 (ShangMi 3)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SM3
 	help
 	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
 
@@ -69,11 +69,11 @@ config CRYPTO_SM3_RISCV64
 	  - Zvksh vector crypto extension
 	  - Zvkb vector crypto extension
 
 config CRYPTO_SM4_RISCV64
 	tristate "Ciphers: SM4 (ShangMi 4)"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
 	  SM4 block cipher algorithm (OSCCA GB/T 32907-2016,
 	  ISO/IEC 18033-3:2010/Amd 1:2021)
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 2467dba73372..8c334c9f2081 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if RISCV
-source "arch/riscv/crypto/Kconfig"
-endif
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
 if SPARC
 source "arch/sparc/crypto/Kconfig"
-- 
2.49.0


