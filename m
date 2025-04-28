Return-Path: <linux-arch+bounces-11647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40293A9E7A0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 07:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB107ABC1E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 05:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F120012C;
	Mon, 28 Apr 2025 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nrdBWl8/"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A391BD50C;
	Mon, 28 Apr 2025 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817457; cv=none; b=Dr/RetxwTchn1mKpkmVfe2aqIr2QabnVabqVOJ2XL1OeBhCMJHmWCgp9W990zbFJpxQ8BGvMIEzasc/lK/Lp9gwhbk7hAIF/3uuIOA6DTaHIgjSPJ8lZca3LRCMkaM8pTB/YTwVARCvuEkfeAipfspOTumrPNmFqyzwpDd0anvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817457; c=relaxed/simple;
	bh=1IOVEVQ5ugAr571F4SBDnGMB8RogevKDrQpB3TJjQPc=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=o1xAZRb/DY7hjBOMNnXb80x0dqWv+b2hFu9IM5TkHMhNHC57xOmC9uDl+f4yBE6Tj+IUmMODOEce3Xs3XOesQVL/1nOkkXgF5yxzyKcO8PV7NY+Q8ycF97wTp0B7nGQGw3z5pz648/uyIcoZt81tEg4+lkX1d5grgdFmEJM9i9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nrdBWl8/; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WmxKAuttIQ4TpwkzWXa1Edya4ZlZxgpVSL5JS8RjZ1k=; b=nrdBWl8/Z9qKzChv4yZql8LZdK
	glPaC5MmOlBjDTKniLARTQSpKxYgKEurH3BjiqEo4jw18J2DiN08I0NadpaZo8XyF37S4Xd06gsBP
	oeOZFOQK8TFrCPPmhKMsMXSy9XtIzbqzAJ52AwzpjF4Uv4GRMUT6ZcNOf2kXlMAuayNqaj3vaVVcy
	7jilq8q/y8fzcrdRMhyINeFuQzgZWTWInZFMnuk95Jt672/7llE+4kHfrWHdC2I5RCHw98a1KCjIk
	T7ct3NHNXdibZbabCm+IclVjMtnKUiXW1+um4aH9n67yI5VKru5kAuNvGdF+jaLBUWILiKl/Hl5Bv
	qJ8OTvwg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9Grv-001WU0-2B;
	Mon, 28 Apr 2025 13:17:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 13:17:27 +0800
Date: Mon, 28 Apr 2025 13:17:27 +0800
Message-Id: <cd712819f1de27186c2bc559082bec4873427e03.1745816372.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745816372.git.herbert@gondor.apana.org.au>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 11/13] crypto: x86/sha256 - implement library instead of
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

To match sha256_blocks_arch(), change the type of the nblocks parameter
of the assembly functions from int to size_t.  The assembly functions
actually already treated it as size_t.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/x86/crypto/Kconfig                       |  14 -
 arch/x86/crypto/Makefile                      |   3 -
 arch/x86/crypto/sha256_ssse3_glue.c           | 432 ------------------
 arch/x86/lib/crypto/Kconfig                   |   8 +
 arch/x86/lib/crypto/Makefile                  |   3 +
 arch/x86/{ => lib}/crypto/sha256-avx-asm.S    |  12 +-
 arch/x86/{ => lib}/crypto/sha256-avx2-asm.S   |  12 +-
 .../crypto/sha256-ni-asm.S}                   |  36 +-
 arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S  |  14 +-
 arch/x86/lib/crypto/sha256.c                  |  80 ++++
 10 files changed, 125 insertions(+), 489 deletions(-)
 delete mode 100644 arch/x86/crypto/sha256_ssse3_glue.c
 rename arch/x86/{ => lib}/crypto/sha256-avx-asm.S (98%)
 rename arch/x86/{ => lib}/crypto/sha256-avx2-asm.S (98%)
 rename arch/x86/{crypto/sha256_ni_asm.S => lib/crypto/sha256-ni-asm.S} (85%)
 rename arch/x86/{ => lib}/crypto/sha256-ssse3-asm.S (98%)
 create mode 100644 arch/x86/lib/crypto/sha256.c

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9e941362e4cd..56cfdc79e2c6 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -390,20 +390,6 @@ config CRYPTO_SHA1_SSSE3
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
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index fad59a6c6c26..aa289a9e0153 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -54,9 +54,6 @@ endif
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
 sha1-ssse3-y := sha1_avx2_x86_64_asm.o sha1_ssse3_asm.o sha1_ni_asm.o sha1_ssse3_glue.o
 
-obj-$(CONFIG_CRYPTO_SHA256_SSSE3) += sha256-ssse3.o
-sha256-ssse3-y := sha256-ssse3-asm.o sha256-avx-asm.o sha256-avx2-asm.o sha256_ni_asm.o sha256_ssse3_glue.o
-
 obj-$(CONFIG_CRYPTO_SHA512_SSSE3) += sha512-ssse3.o
 sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_ssse3_glue.o
 
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
deleted file mode 100644
index a5d3be00550b..000000000000
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
index 546fe2afe0b5..5e94cdee492c 100644
--- a/arch/x86/lib/crypto/Kconfig
+++ b/arch/x86/lib/crypto/Kconfig
@@ -24,3 +24,11 @@ config CRYPTO_POLY1305_X86_64
 	depends on 64BIT
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_SHA256_X86_64
+	tristate
+	depends on 64BIT
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256_SIMD
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/x86/lib/crypto/Makefile b/arch/x86/lib/crypto/Makefile
index c2ff8c5f1046..abceca3d31c0 100644
--- a/arch/x86/lib/crypto/Makefile
+++ b/arch/x86/lib/crypto/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
 poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
 targets += poly1305-x86_64-cryptogams.S
 
+obj-$(CONFIG_CRYPTO_SHA256_X86_64) += sha256-x86_64.o
+sha256-x86_64-y := sha256.o sha256-ssse3-asm.o sha256-avx-asm.o sha256-avx2-asm.o sha256-ni-asm.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/lib/crypto/sha256-avx-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-avx-asm.S
rename to arch/x86/lib/crypto/sha256-avx-asm.S
index 53de72bdd851..0d7b2c3e45d9 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/lib/crypto/sha256-avx-asm.S
@@ -48,7 +48,7 @@
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define    VMOVDQ vmovdqu
@@ -341,13 +341,13 @@ a = TMP_
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
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/lib/crypto/sha256-avx2-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-avx2-asm.S
rename to arch/x86/lib/crypto/sha256-avx2-asm.S
index 0bbec1c75cd0..25d3380321ec 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/lib/crypto/sha256-avx2-asm.S
@@ -49,7 +49,7 @@
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define	VMOVDQ vmovdqu
@@ -518,13 +518,13 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
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
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/lib/crypto/sha256-ni-asm.S
similarity index 85%
rename from arch/x86/crypto/sha256_ni_asm.S
rename to arch/x86/lib/crypto/sha256-ni-asm.S
index d515a55a3bc1..d3548206cf3d 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/lib/crypto/sha256-ni-asm.S
@@ -54,9 +54,9 @@
  */
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
-#define DIGEST_PTR	%rdi	/* 1st arg */
+#define STATE_PTR	%rdi	/* 1st arg */
 #define DATA_PTR	%rsi	/* 2nd arg */
 #define NUM_BLKS	%rdx	/* 3rd arg */
 
@@ -98,24 +98,20 @@
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
@@ -126,8 +122,8 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	 * Need to reorder these appropriately
 	 * DCBA, HGFE -> ABEF, CDGH
 	 */
-	movdqu		0*16(DIGEST_PTR), STATE0	/* DCBA */
-	movdqu		1*16(DIGEST_PTR), STATE1	/* HGFE */
+	movdqu		0*16(STATE_PTR), STATE0		/* DCBA */
+	movdqu		1*16(STATE_PTR), STATE1		/* HGFE */
 
 	movdqa		STATE0, TMP
 	punpcklqdq	STATE1, STATE0			/* FEBA */
@@ -166,8 +162,8 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	pshufd		$0xB1, STATE0, STATE0		/* HGFE */
 	pshufd		$0x1B, STATE1, STATE1		/* DCBA */
 
-	movdqu		STATE1, 0*16(DIGEST_PTR)
-	movdqu		STATE0, 1*16(DIGEST_PTR)
+	movdqu		STATE1, 0*16(STATE_PTR)
+	movdqu		STATE0, 1*16(STATE_PTR)
 
 .Ldone_hash:
 
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/lib/crypto/sha256-ssse3-asm.S
similarity index 98%
rename from arch/x86/crypto/sha256-ssse3-asm.S
rename to arch/x86/lib/crypto/sha256-ssse3-asm.S
index 93264ee44543..7f24a4cdcb25 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/lib/crypto/sha256-ssse3-asm.S
@@ -47,7 +47,7 @@
 ########################################################################
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
+#include <linux/objtool.h>
 
 ## assume buffers not aligned
 #define    MOVDQ movdqu
@@ -348,15 +348,13 @@ a = TMP_
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
diff --git a/arch/x86/lib/crypto/sha256.c b/arch/x86/lib/crypto/sha256.c
new file mode 100644
index 000000000000..cdd88497eedf
--- /dev/null
+++ b/arch/x86/lib/crypto/sha256.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 optimized for x86_64
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <asm/fpu/api.h>
+#include <crypto/internal/sha2.h>
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
+void sha256_blocks_simd(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_sha256_x86)) {
+		kernel_fpu_begin();
+		static_call(sha256_blocks_x86)(state, data, nblocks);
+		kernel_fpu_end();
+	} else {
+		sha256_blocks_generic(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_simd);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	sha256_blocks_generic(state, data, nblocks);
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	return static_key_enabled(&have_sha256_x86);
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
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
2.39.5


