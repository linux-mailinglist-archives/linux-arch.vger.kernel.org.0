Return-Path: <linux-arch+bounces-11663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E2A9F6C2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA735A54EA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FB294A08;
	Mon, 28 Apr 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqdkhL+U"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BA2949F5;
	Mon, 28 Apr 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859725; cv=none; b=EUGNwhw9YptL9Pf8Nwh+f6xsLEYtk/76c1FmalGm7fW1d0/R497GfUiAOsxyy8FeGq1PRdKd6IqugDMcsdAPKH7uIv8bhkjdFGXSUVcFbd0FC3frEL0c1J16OnjlQvQUi3mWQbk7cPA/J5s7inCqnflGHLcBewUzCQXtl+rY26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859725; c=relaxed/simple;
	bh=Y1aKy5QVBGFd4CpCHS+L+Ce3zC0X9xCmDHzwr3yuur8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4Is4E0anF2GAGBrK15UBIR16f1fnpv/9dLSmck52V31xceuFGDbVdSjq4GDp702g7ipKKZf0Uv52HqLyJZecxqtQ0RhQh/IrXOGxt0LRqsMFEPxdTVqm+QFOt1orXPTxTN0Vq/YxOl9ipvAAj/MQSt1EJfmOd8jUoUpxPdv6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqdkhL+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F1C4CEEC;
	Mon, 28 Apr 2025 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859725;
	bh=Y1aKy5QVBGFd4CpCHS+L+Ce3zC0X9xCmDHzwr3yuur8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqdkhL+UMMJPm5vxVwm3fl8kApgJUo3lWSkFbb6VpXx2mNzFvG3AvRMiVAJmXBFsW
	 ENOMmL7cVq0zW8tcZNx6Cf7Ofjj68U4nCYAJc48K6TwoLLZRmAhMvRx4+O0/TvII14
	 j1++Upi+QJiJ/wQ9DHFojgEomi8KbvIdimR/9TMRJKdSqN0Nn6Ekja2LBClCghaK+j
	 nfm2NI4OaTTmLGnn93IZU1CYStm0eYAICUFpBzIYZJHFBWqepIjgzOlr/0/2UpvA6V
	 UmM+fjSuht755278fXPtAr6ZoEk42bisgCADq+WHlC8RgLwQetZ8d9QUJLXqoNjozI
	 67UiHu08xx6TA==
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
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 11/13] crypto: x86/sha256 - implement library instead of shash
Date: Mon, 28 Apr 2025 10:00:36 -0700
Message-ID: <20250428170040.423825-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428170040.423825-1-ebiggers@kernel.org>
References: <20250428170040.423825-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instead of providing crypto_shash algorithms for the arch-optimized
SHA-256 code, instead implement the SHA-256 library.  This is much
simpler, it makes the SHA-256 library functions be arch-optimized, and
it fixes the longstanding issue where the arch-optimized SHA-256 was
disabled by default.  SHA-256 still remains available through
crypto_shash, but individual architectures no longer need to handle it.

To match sha256_blocks_arch(), change the type of the nblocks parameter
of the assembly functions from int to size_t.  The assembly functions
actually already treated it as size_t.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Kconfig                       |  14 -
 arch/x86/crypto/Makefile                      |   3 -
 arch/x86/crypto/sha256_ssse3_glue.c           | 432 ------------------
 arch/x86/lib/crypto/Kconfig                   |   7 +
 arch/x86/lib/crypto/Makefile                  |   3 +
 arch/x86/{ => lib}/crypto/sha256-avx-asm.S    |  12 +-
 arch/x86/{ => lib}/crypto/sha256-avx2-asm.S   |  12 +-
 .../crypto/sha256-ni-asm.S}                   |  36 +-
 arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S  |  14 +-
 arch/x86/lib/crypto/sha256.c                  |  74 +++
 10 files changed, 118 insertions(+), 489 deletions(-)
 delete mode 100644 arch/x86/crypto/sha256_ssse3_glue.c
 rename arch/x86/{ => lib}/crypto/sha256-avx-asm.S (98%)
 rename arch/x86/{ => lib}/crypto/sha256-avx2-asm.S (98%)
 rename arch/x86/{crypto/sha256_ni_asm.S => lib/crypto/sha256-ni-asm.S} (85%)
 rename arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S (98%)
 create mode 100644 arch/x86/lib/crypto/sha256.c

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9e941362e4cd5..56cfdc79e2c66 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -388,24 +388,10 @@ config CRYPTO_SHA1_SSSE3
 	  - SSSE3 (Supplemental SSE3)
 	  - AVX (Advanced Vector Extensions)
 	  - AVX2 (Advanced Vector Extensions 2)
 	  - SHA-NI (SHA Extensions New Instructions)
 
-config CRYPTO_SHA256_SSSE3
-	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on 64BIT
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: x86_64 using:
-	  - SSSE3 (Supplemental SSE3)
-	  - AVX (Advanced Vector Extensions)
-	  - AVX2 (Advanced Vector Extensions 2)
-	  - SHA-NI (SHA Extensions New Instructions)
-
 config CRYPTO_SHA512_SSSE3
 	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
 	depends on 64BIT
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index fad59a6c6c26f..aa289a9e0153b 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -52,13 +52,10 @@ aesni-intel-$(CONFIG_64BIT) += aes-gcm-avx10-x86_64.o
 endif
 
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
 sha1-ssse3-y := sha1_avx2_x86_64_asm.o sha1_ssse3_asm.o sha1_ni_asm.o sha1_ssse3_glue.o
 
-obj-$(CONFIG_CRYPTO_SHA256_SSSE3) += sha256-ssse3.o
-sha256-ssse3-y := sha256-ssse3-asm.o sha256-avx-asm.o sha256-avx2-asm.o sha256_ni_asm.o sha256_ssse3_glue.o
-
 obj-$(CONFIG_CRYPTO_SHA512_SSSE3) += sha512-ssse3.o
 sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_ssse3_glue.o
 
 obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
 ghash-clmulni-intel-y := ghash-clmulni-intel_asm.o ghash-clmulni-intel_glue.o
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
deleted file mode 100644
index a5d3be00550b8..0000000000000
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ /dev/null
@@ -1,432 +0,0 @@
-/*
- * Cryptographic API.
- *
- * Glue code for the SHA256 Secure Hash Algorithm assembler implementations
- * using SSSE3, AVX, AVX2, and SHA-NI instructions.
- *
- * This file is based on sha256_generic.c
- *
- * Copyright (C) 2013 Intel Corporation.
- *
- * Author:
- *     Tim Chen <tim.c.chen@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <asm/cpu_device_id.h>
-#include <asm/fpu/api.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-asmlinkage void sha256_transform_ssse3(struct crypto_sha256_state *state,
-				       const u8 *data, int blocks);
-
-static const struct x86_cpu_id module_cpu_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
-
-static int _sha256_update(struct shash_desc *desc, const u8 *data,
-			  unsigned int len,
-			  sha256_block_fn *sha256_xform)
-{
-	int remain;
-
-	/*
-	 * Make sure struct crypto_sha256_state begins directly with the SHA256
-	 * 256-bit internal state, as this is what the asm functions expect.
-	 */
-	BUILD_BUG_ON(offsetof(struct crypto_sha256_state, state) != 0);
-
-	kernel_fpu_begin();
-	remain = sha256_base_do_update_blocks(desc, data, len, sha256_xform);
-	kernel_fpu_end();
-
-	return remain;
-}
-
-static int sha256_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
-{
-	kernel_fpu_begin();
-	sha256_base_do_finup(desc, data, len, sha256_xform);
-	kernel_fpu_end();
-
-	return sha256_base_finish(desc, out);
-}
-
-static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
-{
-	return _sha256_update(desc, data, len, sha256_transform_ssse3);
-}
-
-static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out)
-{
-	return sha256_finup(desc, data, len, out, sha256_transform_ssse3);
-}
-
-static int sha256_ssse3_digest(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out)
-{
-	return sha256_base_init(desc) ?:
-	       sha256_ssse3_finup(desc, data, len, out);
-}
-
-static struct shash_alg sha256_ssse3_algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	sha256_ssse3_update,
-	.finup		=	sha256_ssse3_finup,
-	.digest		=	sha256_ssse3_digest,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-ssse3",
-		.cra_priority	=	150,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	sha256_ssse3_update,
-	.finup		=	sha256_ssse3_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-ssse3",
-		.cra_priority	=	150,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static int register_sha256_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		return crypto_register_shashes(sha256_ssse3_algs,
-				ARRAY_SIZE(sha256_ssse3_algs));
-	return 0;
-}
-
-static void unregister_sha256_ssse3(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SSSE3))
-		crypto_unregister_shashes(sha256_ssse3_algs,
-				ARRAY_SIZE(sha256_ssse3_algs));
-}
-
-asmlinkage void sha256_transform_avx(struct crypto_sha256_state *state,
-				     const u8 *data, int blocks);
-
-static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
-{
-	return _sha256_update(desc, data, len, sha256_transform_avx);
-}
-
-static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_finup(desc, data, len, out, sha256_transform_avx);
-}
-
-static int sha256_avx_digest(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_base_init(desc) ?:
-	       sha256_avx_finup(desc, data, len, out);
-}
-
-static struct shash_alg sha256_avx_algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	sha256_avx_update,
-	.finup		=	sha256_avx_finup,
-	.digest		=	sha256_avx_digest,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-avx",
-		.cra_priority	=	160,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	sha256_avx_update,
-	.finup		=	sha256_avx_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-avx",
-		.cra_priority	=	160,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static bool avx_usable(void)
-{
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
-		if (boot_cpu_has(X86_FEATURE_AVX))
-			pr_info("AVX detected but unusable.\n");
-		return false;
-	}
-
-	return true;
-}
-
-static int register_sha256_avx(void)
-{
-	if (avx_usable())
-		return crypto_register_shashes(sha256_avx_algs,
-				ARRAY_SIZE(sha256_avx_algs));
-	return 0;
-}
-
-static void unregister_sha256_avx(void)
-{
-	if (avx_usable())
-		crypto_unregister_shashes(sha256_avx_algs,
-				ARRAY_SIZE(sha256_avx_algs));
-}
-
-asmlinkage void sha256_transform_rorx(struct crypto_sha256_state *state,
-				      const u8 *data, int blocks);
-
-static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
-{
-	return _sha256_update(desc, data, len, sha256_transform_rorx);
-}
-
-static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_finup(desc, data, len, out, sha256_transform_rorx);
-}
-
-static int sha256_avx2_digest(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_base_init(desc) ?:
-	       sha256_avx2_finup(desc, data, len, out);
-}
-
-static struct shash_alg sha256_avx2_algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	sha256_avx2_update,
-	.finup		=	sha256_avx2_finup,
-	.digest		=	sha256_avx2_digest,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-avx2",
-		.cra_priority	=	170,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	sha256_avx2_update,
-	.finup		=	sha256_avx2_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-avx2",
-		.cra_priority	=	170,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static bool avx2_usable(void)
-{
-	if (avx_usable() && boot_cpu_has(X86_FEATURE_AVX2) &&
-		    boot_cpu_has(X86_FEATURE_BMI2))
-		return true;
-
-	return false;
-}
-
-static int register_sha256_avx2(void)
-{
-	if (avx2_usable())
-		return crypto_register_shashes(sha256_avx2_algs,
-				ARRAY_SIZE(sha256_avx2_algs));
-	return 0;
-}
-
-static void unregister_sha256_avx2(void)
-{
-	if (avx2_usable())
-		crypto_unregister_shashes(sha256_avx2_algs,
-				ARRAY_SIZE(sha256_avx2_algs));
-}
-
-asmlinkage void sha256_ni_transform(struct crypto_sha256_state *digest,
-				    const u8 *data, int rounds);
-
-static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
-{
-	return _sha256_update(desc, data, len, sha256_ni_transform);
-}
-
-static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_finup(desc, data, len, out, sha256_ni_transform);
-}
-
-static int sha256_ni_digest(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out)
-{
-	return sha256_base_init(desc) ?:
-	       sha256_ni_finup(desc, data, len, out);
-}
-
-static struct shash_alg sha256_ni_algs[] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	sha256_ni_update,
-	.finup		=	sha256_ni_finup,
-	.digest		=	sha256_ni_digest,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name =	"sha256-ni",
-		.cra_priority	=	250,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	sha256_ni_update,
-	.finup		=	sha256_ni_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name =	"sha224-ni",
-		.cra_priority	=	250,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static int register_sha256_ni(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
-		return crypto_register_shashes(sha256_ni_algs,
-				ARRAY_SIZE(sha256_ni_algs));
-	return 0;
-}
-
-static void unregister_sha256_ni(void)
-{
-	if (boot_cpu_has(X86_FEATURE_SHA_NI))
-		crypto_unregister_shashes(sha256_ni_algs,
-				ARRAY_SIZE(sha256_ni_algs));
-}
-
-static int __init sha256_ssse3_mod_init(void)
-{
-	if (!x86_match_cpu(module_cpu_ids))
-		return -ENODEV;
-
-	if (register_sha256_ssse3())
-		goto fail;
-
-	if (register_sha256_avx()) {
-		unregister_sha256_ssse3();
-		goto fail;
-	}
-
-	if (register_sha256_avx2()) {
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
-	}
-
-	if (register_sha256_ni()) {
-		unregister_sha256_avx2();
-		unregister_sha256_avx();
-		unregister_sha256_ssse3();
-		goto fail;
-	}
-
-	return 0;
-fail:
-	return -ENODEV;
-}
-
-static void __exit sha256_ssse3_mod_fini(void)
-{
-	unregister_sha256_ni();
-	unregister_sha256_avx2();
-	unregister_sha256_avx();
-	unregister_sha256_ssse3();
-}
-
-module_init(sha256_ssse3_mod_init);
-module_exit(sha256_ssse3_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm, Supplemental SSE3 accelerated");
-
-MODULE_ALIAS_CRYPTO("sha256");
-MODULE_ALIAS_CRYPTO("sha256-ssse3");
-MODULE_ALIAS_CRYPTO("sha256-avx");
-MODULE_ALIAS_CRYPTO("sha256-avx2");
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_ALIAS_CRYPTO("sha224-ssse3");
-MODULE_ALIAS_CRYPTO("sha224-avx");
-MODULE_ALIAS_CRYPTO("sha224-avx2");
-MODULE_ALIAS_CRYPTO("sha256-ni");
-MODULE_ALIAS_CRYPTO("sha224-ni");
diff --git a/arch/x86/lib/crypto/Kconfig b/arch/x86/lib/crypto/Kconfig
index 546fe2afe0b51..e344579db3d85 100644
--- a/arch/x86/lib/crypto/Kconfig
+++ b/arch/x86/lib/crypto/Kconfig
@@ -22,5 +22,12 @@ config CRYPTO_CHACHA20_X86_64
 config CRYPTO_POLY1305_X86_64
 	tristate
 	depends on 64BIT
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_SHA256_X86_64
+	tristate
+	depends on 64BIT
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/x86/lib/crypto/Makefile b/arch/x86/lib/crypto/Makefile
index c2ff8c5f1046e..abceca3d31c01 100644
--- a/arch/x86/lib/crypto/Makefile
+++ b/arch/x86/lib/crypto/Makefile
@@ -8,10 +8,13 @@ chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha-avx512vl-x8
 
 obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
 poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
 targets += poly1305-x86_64-cryptogams.S
 
+obj-$(CONFIG_CRYPTO_SHA256_X86_64) += sha256-x86_64.o
+sha256-x86_64-y := sha256.o sha256-ssse3-asm.o sha256-avx-asm.o sha256-avx2-asm.o sha256-ni-asm.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 
 $(obj)/%.S: $(src)/%.pl FORCE
 	$(call if_changed,perlasm)
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/lib/crypto/sha256-avx-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-avx-asm.S
rename to arch/x86/lib/crypto/sha256-avx-asm.S
index 53de72bdd851e..0d7b2c3e45d9a 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/lib/crypto/sha256-avx-asm.S
@@ -46,11 +46,11 @@
 ########################################################################
 # This code schedules 1 block at a time, with 4 lanes per block
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define    VMOVDQ vmovdqu
 
 ################################ Define Macros
@@ -339,17 +339,17 @@ a = TMP_
         add     y0, h                   # h = h + S1 + CH + k + w + S0 + MAJ
         ROTATE_ARGS
 .endm
 
 ########################################################################
-## void sha256_transform_avx(state sha256_state *state, const u8 *data, int blocks)
-## arg 1 : pointer to state
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
+## void sha256_transform_avx(u32 state[SHA256_STATE_WORDS],
+##			     const u8 *data, size_t nblocks);
 ########################################################################
 .text
-SYM_TYPED_FUNC_START(sha256_transform_avx)
+SYM_FUNC_START(sha256_transform_avx)
+	ANNOTATE_NOENDBR	# since this is called only via static_call
+
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
 	pushq   %r14
 	pushq   %r15
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/lib/crypto/sha256-avx2-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-avx2-asm.S
rename to arch/x86/lib/crypto/sha256-avx2-asm.S
index 0bbec1c75cd0b..25d3380321ec3 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/lib/crypto/sha256-avx2-asm.S
@@ -47,11 +47,11 @@
 ########################################################################
 # This code schedules 2 blocks at a time, with 4 lanes per block
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define	VMOVDQ vmovdqu
 
 ################################ Define Macros
@@ -516,17 +516,17 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 	ROTATE_ARGS
 
 .endm
 
 ########################################################################
-## void sha256_transform_rorx(struct sha256_state *state, const u8 *data, int blocks)
-## arg 1 : pointer to state
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
+## void sha256_transform_rorx(u32 state[SHA256_STATE_WORDS],
+##			      const u8 *data, size_t nblocks);
 ########################################################################
 .text
-SYM_TYPED_FUNC_START(sha256_transform_rorx)
+SYM_FUNC_START(sha256_transform_rorx)
+	ANNOTATE_NOENDBR	# since this is called only via static_call
+
 	pushq	%rbx
 	pushq	%r12
 	pushq	%r13
 	pushq	%r14
 	pushq	%r15
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/lib/crypto/sha256-ni-asm.S
similarity index 85%
rename from arch/x86/crypto/sha256_ni_asm.S
rename to arch/x86/lib/crypto/sha256-ni-asm.S
index d515a55a3bc1d..d3548206cf3d4 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/lib/crypto/sha256-ni-asm.S
@@ -52,13 +52,13 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  */
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
-#define DIGEST_PTR	%rdi	/* 1st arg */
+#define STATE_PTR	%rdi	/* 1st arg */
 #define DATA_PTR	%rsi	/* 2nd arg */
 #define NUM_BLKS	%rdx	/* 3rd arg */
 
 #define SHA256CONSTANTS	%rax
 
@@ -96,40 +96,36 @@
 	sha256msg1	\m0, \m3
 .endif
 .endm
 
 /*
- * Intel SHA Extensions optimized implementation of a SHA-256 update function
+ * Intel SHA Extensions optimized implementation of a SHA-256 block function
  *
- * The function takes a pointer to the current hash values, a pointer to the
- * input data, and a number of 64 byte blocks to process.  Once all blocks have
- * been processed, the digest pointer is  updated with the resulting hash value.
- * The function only processes complete blocks, there is no functionality to
- * store partial blocks.  All message padding and hash value initialization must
- * be done outside the update function.
+ * This function takes a pointer to the current SHA-256 state, a pointer to the
+ * input data, and the number of 64-byte blocks to process.  Once all blocks
+ * have been processed, the state is updated with the new state.  This function
+ * only processes complete blocks.  State initialization, buffering of partial
+ * blocks, and digest finalization is expected to be handled elsewhere.
  *
- * void sha256_ni_transform(uint32_t *digest, const void *data,
-		uint32_t numBlocks);
- * digest : pointer to digest
- * data: pointer to input data
- * numBlocks: Number of blocks to process
+ * void sha256_ni_transform(u32 state[SHA256_STATE_WORDS],
+ *			    const u8 *data, size_t nblocks);
  */
-
 .text
-SYM_TYPED_FUNC_START(sha256_ni_transform)
+SYM_FUNC_START(sha256_ni_transform)
+	ANNOTATE_NOENDBR	# since this is called only via static_call
 
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
 	add		DATA_PTR, NUM_BLKS	/* pointer to end of data */
 
 	/*
 	 * load initial hash values
 	 * Need to reorder these appropriately
 	 * DCBA, HGFE -> ABEF, CDGH
 	 */
-	movdqu		0*16(DIGEST_PTR), STATE0	/* DCBA */
-	movdqu		1*16(DIGEST_PTR), STATE1	/* HGFE */
+	movdqu		0*16(STATE_PTR), STATE0		/* DCBA */
+	movdqu		1*16(STATE_PTR), STATE1		/* HGFE */
 
 	movdqa		STATE0, TMP
 	punpcklqdq	STATE1, STATE0			/* FEBA */
 	punpckhqdq	TMP, STATE1			/* DCHG */
 	pshufd		$0x1B, STATE0, STATE0		/* ABEF */
@@ -164,12 +160,12 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	punpcklqdq	STATE1, STATE0			/* GHEF */
 	punpckhqdq	TMP, STATE1			/* ABCD */
 	pshufd		$0xB1, STATE0, STATE0		/* HGFE */
 	pshufd		$0x1B, STATE1, STATE1		/* DCBA */
 
-	movdqu		STATE1, 0*16(DIGEST_PTR)
-	movdqu		STATE0, 1*16(DIGEST_PTR)
+	movdqu		STATE1, 0*16(STATE_PTR)
+	movdqu		STATE0, 1*16(STATE_PTR)
 
 .Ldone_hash:
 
 	RET
 SYM_FUNC_END(sha256_ni_transform)
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/lib/crypto/sha256-ssse3-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-ssse3-asm.S
rename to arch/x86/lib/crypto/sha256-ssse3-asm.S
index 93264ee445432..7f24a4cdcb257 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/lib/crypto/sha256-ssse3-asm.S
@@ -45,11 +45,11 @@
 # and search for that title.
 #
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define    MOVDQ movdqu
 
 ################################ Define Macros
@@ -346,19 +346,17 @@ a = TMP_
 	add     y0, h		      # h = h + S1 + CH + k + w + S0 + MAJ
 	ROTATE_ARGS
 .endm
 
 ########################################################################
-## void sha256_transform_ssse3(struct sha256_state *state, const u8 *data,
-##			       int blocks);
-## arg 1 : pointer to state
-##	   (struct sha256_state is assumed to begin with u32 state[8])
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
+## void sha256_transform_ssse3(u32 state[SHA256_STATE_WORDS],
+##			       const u8 *data, size_t nblocks);
 ########################################################################
 .text
-SYM_TYPED_FUNC_START(sha256_transform_ssse3)
+SYM_FUNC_START(sha256_transform_ssse3)
+	ANNOTATE_NOENDBR	# since this is called only via static_call
+
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
 	pushq   %r14
 	pushq   %r15
diff --git a/arch/x86/lib/crypto/sha256.c b/arch/x86/lib/crypto/sha256.c
new file mode 100644
index 0000000000000..47865b5cd94be
--- /dev/null
+++ b/arch/x86/lib/crypto/sha256.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 optimized for x86_64
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <asm/fpu/api.h>
+#include <crypto/internal/sha2.h>
+#include <crypto/internal/simd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/static_call.h>
+
+asmlinkage void sha256_transform_ssse3(u32 state[SHA256_STATE_WORDS],
+				       const u8 *data, size_t nblocks);
+asmlinkage void sha256_transform_avx(u32 state[SHA256_STATE_WORDS],
+				     const u8 *data, size_t nblocks);
+asmlinkage void sha256_transform_rorx(u32 state[SHA256_STATE_WORDS],
+				      const u8 *data, size_t nblocks);
+asmlinkage void sha256_ni_transform(u32 state[SHA256_STATE_WORDS],
+				    const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_sha256_x86);
+
+DEFINE_STATIC_CALL(sha256_blocks_x86, sha256_transform_ssse3);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_sha256_x86) && crypto_simd_usable()) {
+		kernel_fpu_begin();
+		static_call(sha256_blocks_x86)(state, data, nblocks);
+		kernel_fpu_end();
+	} else {
+		sha256_blocks_generic(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	return static_key_enabled(&have_sha256_x86);
+}
+EXPORT_SYMBOL(sha256_is_arch_optimized);
+
+static int __init sha256_x86_mod_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
+		static_call_update(sha256_blocks_x86, sha256_ni_transform);
+	} else if (cpu_has_xfeatures(XFEATURE_MASK_SSE |
+				     XFEATURE_MASK_YMM, NULL) &&
+		   boot_cpu_has(X86_FEATURE_AVX)) {
+		if (boot_cpu_has(X86_FEATURE_AVX2) &&
+		    boot_cpu_has(X86_FEATURE_BMI2))
+			static_call_update(sha256_blocks_x86,
+					   sha256_transform_rorx);
+		else
+			static_call_update(sha256_blocks_x86,
+					   sha256_transform_avx);
+	} else if (!boot_cpu_has(X86_FEATURE_SSSE3)) {
+		return 0;
+	}
+	static_branch_enable(&have_sha256_x86);
+	return 0;
+}
+arch_initcall(sha256_x86_mod_init);
+
+static void __exit sha256_x86_mod_exit(void)
+{
+}
+module_exit(sha256_x86_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-256 optimized for x86_64");
-- 
2.49.0


