Return-Path: <linux-arch+bounces-11620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF8A9DFA2
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2887B25B9
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015322459DC;
	Sun, 27 Apr 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="GiGDuCnv"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E123F26B;
	Sun, 27 Apr 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735463; cv=none; b=Mh6WnNfU/o+RmUOLDfJBW79Exy/ERTpI7OOBozj7hSg6tiVIhV/Nis6GHOPYc4FBOdTnj0ATi8RLFZYYRhXU+N/Bqv3py0stGpiQca4eMAcumeCoFlP6RTGJtof1eMGy2KuP/2yWKx17L5fzurnscR8PR1qodgNo9v2fnnNDfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735463; c=relaxed/simple;
	bh=D3Z5mLIIQOph93MwaqCLNI1hzmJCmHKVY6wlTII/5hQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=Q2PF1i7+xfmGLcs2uzdPr/hTOeQN92xNsLvYoTC3Yad1fieEjbS/f1zluf9xWwF+lIsZ2klNyXn81FqUAWgHlqqQf3aHZD98VyF1uslPCFoIcE+RngucTsBGIa/RS+hFdprvbwfMU7Rpgs8r3EvycrbRgdISaIw/YpMb/Hii2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=GiGDuCnv; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gLb2XsVwrguFbPgJJKgF5KVO+P/aGN3TDK+diIkn7GU=; b=GiGDuCnvt1zEsWb/Tx6+ypnpWp
	pFXJCbV7HbJ4TQUb6tGTuKItT9DkLI8+D7Akpdm5FMJvx/NbStuh9M0fZtwpCiraHCLVLk/a9Csif
	eMhA/q1ARDRhxKwXK99Y3MfksnGnULS97VTHoN+8na8Uf3fK/APrs2mNLqNeq6EnHRf6h+TvZBTYe
	XXhe8fM/c8Tf9r8NogWIf15NXxNCL/dQdnSY4zQEO4B/4DjVTGmJobJr82/ebkvn0crNIPNnY2hWQ
	BAMZyJa+uEd2qffzR1syZ83AR0BM3fDQQJvsLorEmebJi8EYYyisI/egNhABwY+6MTcHMa3UXSOxN
	36DLT+Cg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXK-001LUn-1a;
	Sun, 27 Apr 2025 14:30:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:30:46 +0800
Date: Sun, 27 Apr 2025 14:30:46 +0800
Message-Id: <614e68963438605de1430bf295f2d3928b41c080.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 02/13] crypto: arm/sha256 - implement library instead of
 shash
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld " <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
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
 arch/arm/lib/crypto/Kconfig                   |   7 ++
 arch/arm/lib/crypto/Makefile                  |   8 +-
 arch/arm/{ => lib}/crypto/sha256-armv4.pl     |  20 ++--
 .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  10 +-
 arch/arm/lib/crypto/sha256.c                  |  64 +++++++++++
 17 files changed, 95 insertions(+), 327 deletions(-)
 delete mode 100644 arch/arm/crypto/sha2-ce-glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.c
 delete mode 100644 arch/arm/crypto/sha256_glue.h
 delete mode 100644 arch/arm/crypto/sha256_neon_glue.c
 rename arch/arm/{ => lib}/crypto/sha256-armv4.pl (97%)
 rename arch/arm/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (91%)
 create mode 100644 arch/arm/lib/crypto/sha256.c

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 7ad48fdda1da..244dd5dec98b 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -364,7 +364,6 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index acd16204f8d7..fce33c1eb65b 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -101,7 +101,6 @@ CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
-CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ad037c175fdb..96178acedad0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1301,7 +1301,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
-CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 113d6dfe5243..57d9e4dba29e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -697,7 +697,6 @@ CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index de0ac8f521d7..fa631523616f 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -660,7 +660,6 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 CONFIG_CRYPTO_SHA1_ARM=m
-CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRC_CCITT=y
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 1f889d6bab77..7efb9a8596e4 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -93,27 +93,6 @@ config CRYPTO_SHA1_ARM_CE
 
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
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index ecabe6603e08..8479137c6e80 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_CRYPTO_AES_ARM) += aes-arm.o
 obj-$(CONFIG_CRYPTO_AES_ARM_BS) += aes-arm-bs.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM) += sha1-arm.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
-obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
 obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
 obj-$(CONFIG_CRYPTO_BLAKE2B_NEON) += blake2b-neon.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
@@ -15,20 +14,16 @@ obj-$(CONFIG_CRYPTO_CURVE25519_NEON) += curve25519-neon.o
 
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
@@ -40,9 +35,8 @@ quiet_cmd_perl = PERL    $@
 $(obj)/%-core.S: $(src)/%-armv4.pl
 	$(call cmd,perl)
 
-clean-files += sha256-core.S sha512-core.S
+clean-files += sha512-core.S
 
 aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
 
-AFLAGS_sha256-core.o += $(aflags-thumb2-y)
 AFLAGS_sha512-core.o += $(aflags-thumb2-y)
diff --git a/arch/arm/crypto/sha2-ce-glue.c b/arch/arm/crypto/sha2-ce-glue.c
deleted file mode 100644
index 1e9d16f79678..000000000000
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
index d04c4e6bae6d..000000000000
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
index 9881c9a115d1..000000000000
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
index 76eb3cdc21c9..000000000000
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
index 0d47d4f21c6d..12d74d8b03d0 100644
--- a/arch/arm/lib/crypto/.gitignore
+++ b/arch/arm/lib/crypto/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 poly1305-core.S
+sha256-core.S
diff --git a/arch/arm/lib/crypto/Kconfig b/arch/arm/lib/crypto/Kconfig
index e8444fd0aae3..d1ad664f0c67 100644
--- a/arch/arm/lib/crypto/Kconfig
+++ b/arch/arm/lib/crypto/Kconfig
@@ -22,3 +22,10 @@ config CRYPTO_POLY1305_ARM
 	tristate
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_SHA256_ARM
+	tristate
+	depends on !CPU_V7M
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256_SIMD
diff --git a/arch/arm/lib/crypto/Makefile b/arch/arm/lib/crypto/Makefile
index 4c042a4c77ed..431f77c3ff6f 100644
--- a/arch/arm/lib/crypto/Makefile
+++ b/arch/arm/lib/crypto/Makefile
@@ -10,13 +10,17 @@ chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
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
 
@@ -24,3 +28,5 @@ aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
 poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
 poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
 AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)
+
+AFLAGS_sha256-core.o += $(aflags-thumb2-y)
diff --git a/arch/arm/crypto/sha256-armv4.pl b/arch/arm/lib/crypto/sha256-armv4.pl
similarity index 97%
rename from arch/arm/crypto/sha256-armv4.pl
rename to arch/arm/lib/crypto/sha256-armv4.pl
index f3a2b54efd4e..8122db7fd599 100644
--- a/arch/arm/crypto/sha256-armv4.pl
+++ b/arch/arm/lib/crypto/sha256-armv4.pl
@@ -204,18 +204,18 @@ K256:
 .word	0				@ terminator
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 .LOPENSSL_armcap:
-.word	OPENSSL_armcap_P-sha256_block_data_order
+.word	OPENSSL_armcap_P-sha256_blocks_arch
 #endif
 .align	5
 
-.global	sha256_block_data_order
-.type	sha256_block_data_order,%function
-sha256_block_data_order:
-.Lsha256_block_data_order:
+.global	sha256_blocks_arch
+.type	sha256_blocks_arch,%function
+sha256_blocks_arch:
+.Lsha256_blocks_arch:
 #if __ARM_ARCH__<7
-	sub	r3,pc,#8		@ sha256_block_data_order
+	sub	r3,pc,#8		@ sha256_blocks_arch
 #else
-	adr	r3,.Lsha256_block_data_order
+	adr	r3,.Lsha256_blocks_arch
 #endif
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 	ldr	r12,.LOPENSSL_armcap
@@ -282,7 +282,7 @@ $code.=<<___;
 	moveq	pc,lr			@ be binary compatible with V4, yet
 	bx	lr			@ interoperable with Thumb ISA:-)
 #endif
-.size	sha256_block_data_order,.-sha256_block_data_order
+.size	sha256_blocks_arch,.-sha256_blocks_arch
 ___
 ######################################################################
 # NEON stuff
@@ -470,8 +470,8 @@ sha256_block_data_order_neon:
 	stmdb	sp!,{r4-r12,lr}
 
 	sub	$H,sp,#16*4+16
-	adr	$Ktbl,.Lsha256_block_data_order
-	sub	$Ktbl,$Ktbl,#.Lsha256_block_data_order-K256
+	adr	$Ktbl,.Lsha256_blocks_arch
+	sub	$Ktbl,$Ktbl,#.Lsha256_blocks_arch-K256
 	bic	$H,$H,#15		@ align for 128-bit stores
 	mov	$t2,sp
 	mov	sp,$H			@ alloca
diff --git a/arch/arm/crypto/sha2-ce-core.S b/arch/arm/lib/crypto/sha256-ce.S
similarity index 91%
rename from arch/arm/crypto/sha2-ce-core.S
rename to arch/arm/lib/crypto/sha256-ce.S
index b6369d2440a1..ac2c9b01b22d 100644
--- a/arch/arm/crypto/sha2-ce-core.S
+++ b/arch/arm/lib/crypto/sha256-ce.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * sha2-ce-core.S - SHA-224/256 secure hash using ARMv8 Crypto Extensions
+ * sha256-ce.S - SHA-224/256 secure hash using ARMv8 Crypto Extensions
  *
  * Copyright (C) 2015 Linaro Ltd.
  * Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
@@ -67,10 +67,10 @@
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
 
@@ -120,4 +120,4 @@ ENTRY(sha2_ce_transform)
 	/* store new state */
 	vst1.32		{dga-dgb}, [r0]
 	bx		lr
-ENDPROC(sha2_ce_transform)
+ENDPROC(sha256_ce_transform)
diff --git a/arch/arm/lib/crypto/sha256.c b/arch/arm/lib/crypto/sha256.c
new file mode 100644
index 000000000000..1dd71b8fd611
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+asmlinkage void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+				   const u8 *data, size_t nblocks);
+EXPORT_SYMBOL_GPL(sha256_blocks_arch);
+asmlinkage void sha256_block_data_order_neon(u32 state[SHA256_STATE_WORDS],
+					     const u8 *data, size_t nblocks);
+asmlinkage void sha256_ce_transform(u32 state[SHA256_STATE_WORDS],
+				    const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_ce);
+
+void sha256_blocks_simd(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    static_branch_likely(&have_neon)) {
+		kernel_neon_begin();
+		if (static_branch_likely(&have_ce))
+			sha256_ce_transform(state, data, nblocks);
+		else
+			sha256_block_data_order_neon(state, data, nblocks);
+		kernel_neon_end();
+	} else {
+		sha256_blocks_arch(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_simd);
+
+bool sha256_is_arch_optimized(void)
+{
+	/* We always can use at least the ARM scalar implementation. */
+	return true;
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
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
2.39.5


