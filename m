Return-Path: <linux-arch+bounces-11586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A608DA9D88D
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C98C920AB8
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FB1E1308;
	Sat, 26 Apr 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPg3d5nn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312891DF742;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650301; cv=none; b=s4pu1WJz6bL7H/xJVFSm9z88CvN7PayNY9zdSTSxIddfc6IKr7ReNSUY1YxbGDM8eSr/iEPcB0OOmWen0JS2UwbiZJPe8XDHmxc1zqamgGnBV+0+xuKsSLpPiZjM+jOLHtfoUT+rHqJoyRflhtsplxeBqpwzkawOhoPXvy5Gj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650301; c=relaxed/simple;
	bh=Z8g2QC8t5xCKSohXvmUSVfT8rth+Vg9Lxt049FddoYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaV32B1MUY+LpKGXYih7ZGZTcN2etBI8M9hr1/OpSBAF+05aePiFqMfZH35CTbpJbHIb9/rJ0S3jCgZBNz44xhhbNgXWDq0PVvRerRCSh4bJreMvnEaJRh8SVy10yl+oGp7SWb3JtZTr96xQ1u0fBvHNlZlFDge0m+Ispl8ovDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPg3d5nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A5C4CEED;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745650300;
	bh=Z8g2QC8t5xCKSohXvmUSVfT8rth+Vg9Lxt049FddoYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPg3d5nn3ULW7JRpe6IVXE1Bk7r2X7yA9WibbhTzMjeRf9ALqm6H7ARsM4mfuGXo4
	 fNqydbIM3GqFYiGV6ZMlr4I/vtUuBFqQJk/v1J5IXcIIUjDHFow0ibNJZFDBqHzjqm
	 M1/gdZG9l/fA5MJZ3B0QSxk5lxA1fqxFBl+XOawMwp58l9mSU5YeDoPTnAg6fApxn9
	 fRUEzLCt+7zscEpkq6U8F7V3ANws7z16ZLS6BvmViMe8SSfwAFv0dzA4bSl2EuDRpZ
	 7cXp/pEhJTAX9RAx8tYs60jO7NhS2N5yk85ksULRDBzMgTblSErI7gjXqB5l0ykmp1
	 Cm4xOy8vte8ZQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 02/13] crypto: arm/sha256 - implement library instead of shash
Date: Fri, 25 Apr 2025 23:50:28 -0700
Message-ID: <20250426065041.1551914-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
References: <20250426065041.1551914-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instead of providing crypto_shash algorithms for the arch-optimized
SHA-256 code, instead implement the SHA-256 library.  This is much
simpler, it makes the SHA-256 library functions be arch-optimized, and
it fixes the longstanding issue where the arch-optimized SHA-256 was
disabled by default.  SHA-256 still remains available through
crypto_shash, but individual architectures no longer need to handle it.

To merge the scalar, NEON, and CE code all into one module cleanly, add
!CPU_V7M as a direct dependency of the CE code.  Previously, !CPU_V7M
was only a direct dependency of the scalar and NEON code.  The result is
still the same because CPU_V7M implies !KERNEL_MODE_NEON, so !CPU_V7M
was already an indirect dependency of the CE code.

To match sha256_blocks_arch(), change the type of the nblocks parameter
of the assembly functions from int to size_t.  The assembly functions
actually already treated it as size_t.

While renaming the assembly files, also fix the naming quirk where
"sha2" meant sha256.  (SHA-512 is also part of SHA-2.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/configs/exynos_defconfig             |   1 -
 arch/arm/configs/milbeaut_m10v_defconfig      |   1 -
 arch/arm/configs/multi_v7_defconfig           |   1 -
 arch/arm/configs/omap2plus_defconfig          |   1 -
 arch/arm/configs/pxa_defconfig                |   1 -
 arch/arm/crypto/Kconfig                       |  21 ----
 arch/arm/crypto/Makefile                      |   8 +-
 arch/arm/crypto/sha2-ce-glue.c                |  87 --------------
 arch/arm/crypto/sha256_glue.c                 | 107 ------------------
 arch/arm/crypto/sha256_glue.h                 |   9 --
 arch/arm/crypto/sha256_neon_glue.c            |  75 ------------
 arch/arm/lib/crypto/.gitignore                |   1 +
 arch/arm/lib/crypto/Kconfig                   |   6 +
 arch/arm/lib/crypto/Makefile                  |   8 +-
 arch/arm/{ => lib}/crypto/sha256-armv4.pl     |   0
 .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  10 +-
 arch/arm/lib/crypto/sha256.c                  |  64 +++++++++++
 17 files changed, 84 insertions(+), 317 deletions(-)
 delete mode 100644 arch/arm/crypto/sha2-ce-glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.h
 delete mode 100644 arch/arm/crypto/sha256_neon_glue.c
 rename arch/arm/{ => lib}/crypto/sha256-armv4.pl (100%)
 rename arch/arm/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (91%)
 create mode 100644 arch/arm/lib/crypto/sha256.c

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 7ad48fdda1dac..244dd5dec98bd 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -362,11 +362,10 @@ CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
 CONFIG_CRYPTO_DEV_S5P=y
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index acd16204f8d7f..fce33c1eb65bf 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -99,11 +99,10 @@ CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
-CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ad037c175fdb0..96178acedad0b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1299,11 +1299,10 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
-CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 113d6dfe52435..57d9e4dba29e3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -695,11 +695,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_OMAP=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index de0ac8f521d76..fa631523616f8 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -658,11 +658,10 @@ CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 CONFIG_CRYPTO_SHA1_ARM=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=m
 CONFIG_FONTS=y
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 1f889d6bab77d..7efb9a8596e4e 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -91,31 +91,10 @@ config CRYPTO_SHA1_ARM_CE
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: arm using ARMv8 Crypto Extensions
 
-config CRYPTO_SHA2_ARM_CE
-	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_SHA256_ARM
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: arm using
-	  - ARMv8 Crypto Extensions
-
-config CRYPTO_SHA256_ARM
-	tristate "Hash functions: SHA-224 and SHA-256 (NEON)"
-	select CRYPTO_HASH
-	depends on !CPU_V7M
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: arm using
-	  - NEON (Advanced SIMD) extensions
-
 config CRYPTO_SHA512_ARM
 	tristate "Hash functions: SHA-384 and SHA-512 (NEON)"
 	select CRYPTO_HASH
 	depends on !CPU_V7M
 	help
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index ecabe6603e080..8479137c6e800 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -5,32 +5,27 @@
 
 obj-$(CONFIG_CRYPTO_AES_ARM) += aes-arm.o
 obj-$(CONFIG_CRYPTO_AES_ARM_BS) += aes-arm-bs.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM) += sha1-arm.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
-obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
 obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
 obj-$(CONFIG_CRYPTO_BLAKE2B_NEON) += blake2b-neon.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
 obj-$(CONFIG_CRYPTO_CURVE25519_NEON) += curve25519-neon.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_CE) += sha1-arm-ce.o
-obj-$(CONFIG_CRYPTO_SHA2_ARM_CE) += sha2-arm-ce.o
 obj-$(CONFIG_CRYPTO_GHASH_ARM_CE) += ghash-arm-ce.o
 
 aes-arm-y	:= aes-cipher-core.o aes-cipher-glue.o
 aes-arm-bs-y	:= aes-neonbs-core.o aes-neonbs-glue.o
 sha1-arm-y	:= sha1-armv4-large.o sha1_glue.o
 sha1-arm-neon-y	:= sha1-armv7-neon.o sha1_neon_glue.o
-sha256-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha256_neon_glue.o
-sha256-arm-y	:= sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
 sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
 sha512-arm-y	:= sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
 blake2b-neon-y  := blake2b-neon-core.o blake2b-neon-glue.o
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
-sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 curve25519-neon-y := curve25519-core.o curve25519-glue.o
 
@@ -38,11 +33,10 @@ quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
 $(obj)/%-core.S: $(src)/%-armv4.pl
 	$(call cmd,perl)
 
-clean-files += sha256-core.S sha512-core.S
+clean-files += sha512-core.S
 
 aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
 
-AFLAGS_sha256-core.o += $(aflags-thumb2-y)
 AFLAGS_sha512-core.o += $(aflags-thumb2-y)
diff --git a/arch/arm/crypto/sha2-ce-glue.c b/arch/arm/crypto/sha2-ce-glue.c
deleted file mode 100644
index 1e9d16f796787..0000000000000
--- a/arch/arm/crypto/sha2-ce-glue.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * sha2-ce-glue.c - SHA-224/SHA-256 using ARMv8 Crypto Extensions
- *
- * Copyright (C) 2015 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
-#include <asm/neon.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/cpufeature.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_LICENSE("GPL v2");
-
-asmlinkage void sha2_ce_transform(struct crypto_sha256_state *sst,
-				  u8 const *src, int blocks);
-
-static int sha2_ce_update(struct shash_desc *desc, const u8 *data,
-			  unsigned int len)
-{
-	int remain;
-
-	kernel_neon_begin();
-	remain = sha256_base_do_update_blocks(desc, data, len,
-					      sha2_ce_transform);
-	kernel_neon_end();
-	return remain;
-}
-
-static int sha2_ce_finup(struct shash_desc *desc, const u8 *data,
-			 unsigned int len, u8 *out)
-{
-	kernel_neon_begin();
-	sha256_base_do_finup(desc, data, len, sha2_ce_transform);
-	kernel_neon_end();
-	return sha256_base_finish(desc, out);
-}
-
-static struct shash_alg algs[] = { {
-	.init			= sha224_base_init,
-	.update			= sha2_ce_update,
-	.finup			= sha2_ce_finup,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.digestsize		= SHA224_DIGEST_SIZE,
-	.base			= {
-		.cra_name		= "sha224",
-		.cra_driver_name	= "sha224-ce",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					  CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize		= SHA256_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-}, {
-	.init			= sha256_base_init,
-	.update			= sha2_ce_update,
-	.finup			= sha2_ce_finup,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.digestsize		= SHA256_DIGEST_SIZE,
-	.base			= {
-		.cra_name		= "sha256",
-		.cra_driver_name	= "sha256-ce",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					  CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize		= SHA256_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-} };
-
-static int __init sha2_ce_mod_init(void)
-{
-	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
-}
-
-static void __exit sha2_ce_mod_fini(void)
-{
-	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
-}
-
-module_cpu_feature_match(SHA2, sha2_ce_mod_init);
-module_exit(sha2_ce_mod_fini);
diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
deleted file mode 100644
index d04c4e6bae6d3..0000000000000
--- a/arch/arm/crypto/sha256_glue.c
+++ /dev/null
@@ -1,107 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Glue code for the SHA256 Secure Hash Algorithm assembly implementation
- * using optimized ARM assembler and NEON instructions.
- *
- * Copyright © 2015 Google Inc.
- *
- * This file is based on sha256_ssse3_glue.c:
- *   Copyright (C) 2013 Intel Corporation
- *   Author: Tim Chen <tim.c.chen@linux.intel.com>
- */
-
-#include <asm/neon.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include "sha256_glue.h"
-
-asmlinkage void sha256_block_data_order(struct crypto_sha256_state *state,
-					const u8 *data, int num_blks);
-
-static int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
-				    unsigned int len)
-{
-	/* make sure casting to sha256_block_fn() is safe */
-	BUILD_BUG_ON(offsetof(struct crypto_sha256_state, state) != 0);
-
-	return sha256_base_do_update_blocks(desc, data, len,
-					    sha256_block_data_order);
-}
-
-static int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
-				   unsigned int len, u8 *out)
-{
-	sha256_base_do_finup(desc, data, len, sha256_block_data_order);
-	return sha256_base_finish(desc, out);
-}
-
-static struct shash_alg algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	crypto_sha256_arm_update,
-	.finup		=	crypto_sha256_arm_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-asm",
-		.cra_priority	=	150,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	crypto_sha256_arm_update,
-	.finup		=	crypto_sha256_arm_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-asm",
-		.cra_priority	=	150,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static int __init sha256_mod_init(void)
-{
-	int res = crypto_register_shashes(algs, ARRAY_SIZE(algs));
-
-	if (res < 0)
-		return res;
-
-	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && cpu_has_neon()) {
-		res = crypto_register_shashes(sha256_neon_algs,
-					      ARRAY_SIZE(sha256_neon_algs));
-
-		if (res < 0)
-			crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
-	}
-
-	return res;
-}
-
-static void __exit sha256_mod_fini(void)
-{
-	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
-
-	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && cpu_has_neon())
-		crypto_unregister_shashes(sha256_neon_algs,
-					  ARRAY_SIZE(sha256_neon_algs));
-}
-
-module_init(sha256_mod_init);
-module_exit(sha256_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm (ARM), including NEON");
-
-MODULE_ALIAS_CRYPTO("sha256");
diff --git a/arch/arm/crypto/sha256_glue.h b/arch/arm/crypto/sha256_glue.h
deleted file mode 100644
index 9881c9a115d1f..0000000000000
--- a/arch/arm/crypto/sha256_glue.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _CRYPTO_SHA256_GLUE_H
-#define _CRYPTO_SHA256_GLUE_H
-
-#include <crypto/hash.h>
-
-extern struct shash_alg sha256_neon_algs[2];
-
-#endif /* _CRYPTO_SHA256_GLUE_H */
diff --git a/arch/arm/crypto/sha256_neon_glue.c b/arch/arm/crypto/sha256_neon_glue.c
deleted file mode 100644
index 76eb3cdc21c96..0000000000000
--- a/arch/arm/crypto/sha256_neon_glue.c
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Glue code for the SHA256 Secure Hash Algorithm assembly implementation
- * using NEON instructions.
- *
- * Copyright © 2015 Google Inc.
- *
- * This file is based on sha512_neon_glue.c:
- *   Copyright © 2014 Jussi Kivilinna <jussi.kivilinna@iki.fi>
- */
-
-#include <asm/neon.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include "sha256_glue.h"
-
-asmlinkage void sha256_block_data_order_neon(
-	struct crypto_sha256_state *digest, const u8 *data, int num_blks);
-
-static int crypto_sha256_neon_update(struct shash_desc *desc, const u8 *data,
-				     unsigned int len)
-{
-	int remain;
-
-	kernel_neon_begin();
-	remain = sha256_base_do_update_blocks(desc, data, len,
-					      sha256_block_data_order_neon);
-	kernel_neon_end();
-	return remain;
-}
-
-static int crypto_sha256_neon_finup(struct shash_desc *desc, const u8 *data,
-				    unsigned int len, u8 *out)
-{
-	kernel_neon_begin();
-	sha256_base_do_finup(desc, data, len, sha256_block_data_order_neon);
-	kernel_neon_end();
-	return sha256_base_finish(desc, out);
-}
-
-struct shash_alg sha256_neon_algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	crypto_sha256_neon_update,
-	.finup		=	crypto_sha256_neon_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-neon",
-		.cra_priority	=	250,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	crypto_sha256_neon_update,
-	.finup		=	crypto_sha256_neon_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-neon",
-		.cra_priority	=	250,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
diff --git a/arch/arm/lib/crypto/.gitignore b/arch/arm/lib/crypto/.gitignore
index 0d47d4f21c6de..12d74d8b03d0a 100644
--- a/arch/arm/lib/crypto/.gitignore
+++ b/arch/arm/lib/crypto/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 poly1305-core.S
+sha256-core.S
diff --git a/arch/arm/lib/crypto/Kconfig b/arch/arm/lib/crypto/Kconfig
index e8444fd0aae30..9f3ff30f40328 100644
--- a/arch/arm/lib/crypto/Kconfig
+++ b/arch/arm/lib/crypto/Kconfig
@@ -20,5 +20,11 @@ config CRYPTO_CHACHA20_NEON
 
 config CRYPTO_POLY1305_ARM
 	tristate
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_SHA256_ARM
+	tristate
+	depends on !CPU_V7M
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
diff --git a/arch/arm/lib/crypto/Makefile b/arch/arm/lib/crypto/Makefile
index 4c042a4c77ed6..431f77c3ff6fd 100644
--- a/arch/arm/lib/crypto/Makefile
+++ b/arch/arm/lib/crypto/Makefile
@@ -8,19 +8,25 @@ chacha-neon-y := chacha-scalar-core.o chacha-glue.o
 chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
 
 obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
 poly1305-arm-y := poly1305-core.o poly1305-glue.o
 
+obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
+sha256-arm-y := sha256.o sha256-core.o
+sha256-arm-$(CONFIG_KERNEL_MODE_NEON) += sha256-ce.o
+
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
 $(obj)/%-core.S: $(src)/%-armv4.pl
 	$(call cmd,perl)
 
-clean-files += poly1305-core.S
+clean-files += poly1305-core.S sha256-core.S
 
 aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
 
 # massage the perlasm code a bit so we only get the NEON routine if we need it
 poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
 poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
 AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)
+
+AFLAGS_sha256-core.o += $(aflags-thumb2-y)
diff --git a/arch/arm/crypto/sha256-armv4.pl b/arch/arm/lib/crypto/sha256-armv4.pl
similarity index 100%
rename from arch/arm/crypto/sha256-armv4.pl
rename to arch/arm/lib/crypto/sha256-armv4.pl
diff --git a/arch/arm/crypto/sha2-ce-core.S b/arch/arm/lib/crypto/sha256-ce.S
similarity index 91%
rename from arch/arm/crypto/sha2-ce-core.S
rename to arch/arm/lib/crypto/sha256-ce.S
index b6369d2440a19..ac2c9b01b22d2 100644
--- a/arch/arm/crypto/sha2-ce-core.S
+++ b/arch/arm/lib/crypto/sha256-ce.S
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * sha2-ce-core.S - SHA-224/256 secure hash using ARMv8 Crypto Extensions
+ * sha256-ce.S - SHA-224/256 secure hash using ARMv8 Crypto Extensions
  *
  * Copyright (C) 2015 Linaro Ltd.
  * Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
  */
 
@@ -65,14 +65,14 @@
 	.word		0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3
 	.word		0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208
 	.word		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
 
 	/*
-	 * void sha2_ce_transform(struct sha256_state *sst, u8 const *src,
-				  int blocks);
+	 * void sha256_ce_transform(u32 state[SHA256_STATE_WORDS],
+	 *			    const u8 *data, size_t nblocks);
 	 */
-ENTRY(sha2_ce_transform)
+ENTRY(sha256_ce_transform)
 	/* load state */
 	vld1.32		{dga-dgb}, [r0]
 
 	/* load input */
 0:	vld1.32		{q0-q1}, [r1]!
@@ -118,6 +118,6 @@ ENTRY(sha2_ce_transform)
 	bne		0b
 
 	/* store new state */
 	vst1.32		{dga-dgb}, [r0]
 	bx		lr
-ENDPROC(sha2_ce_transform)
+ENDPROC(sha256_ce_transform)
diff --git a/arch/arm/lib/crypto/sha256.c b/arch/arm/lib/crypto/sha256.c
new file mode 100644
index 0000000000000..3a8dfc304807a
--- /dev/null
+++ b/arch/arm/lib/crypto/sha256.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 optimized for ARM
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <asm/neon.h>
+#include <crypto/internal/sha2.h>
+#include <crypto/internal/simd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+asmlinkage void sha256_block_data_order(u32 state[SHA256_STATE_WORDS],
+					const u8 *data, size_t nblocks);
+asmlinkage void sha256_block_data_order_neon(u32 state[SHA256_STATE_WORDS],
+					     const u8 *data, size_t nblocks);
+asmlinkage void sha256_ce_transform(u32 state[SHA256_STATE_WORDS],
+				    const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_ce);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    static_branch_likely(&have_neon) && crypto_simd_usable()) {
+		kernel_neon_begin();
+		if (static_branch_likely(&have_ce))
+			sha256_ce_transform(state, data, nblocks);
+		else
+			sha256_block_data_order_neon(state, data, nblocks);
+		kernel_neon_end();
+	} else {
+		sha256_block_data_order(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	/* We always can use at least the ARM scalar implementation. */
+	return true;
+}
+EXPORT_SYMBOL(sha256_is_arch_optimized);
+
+static int __init sha256_arm_mod_init(void)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && (elf_hwcap & HWCAP_NEON)) {
+		static_branch_enable(&have_neon);
+		if (elf_hwcap2 & HWCAP2_SHA2)
+			static_branch_enable(&have_ce);
+	}
+	return 0;
+}
+arch_initcall(sha256_arm_mod_init);
+
+static void __exit sha256_arm_mod_exit(void)
+{
+}
+module_exit(sha256_arm_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-256 optimized for ARM");
-- 
2.49.0


