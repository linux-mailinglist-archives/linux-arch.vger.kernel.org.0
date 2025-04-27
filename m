Return-Path: <linux-arch+bounces-11623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE4A9DFBD
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188411A8332F
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148C248878;
	Sun, 27 Apr 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="I+A9fUEe"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA9241679;
	Sun, 27 Apr 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735466; cv=none; b=nm6tSsze6Vl23joX8BS9/Xz96gI59vrX8glUlx9koBZGyYfrTJNvixsBLpI3sAa+6HKmjMZ2VM7tdd4ANxD+O4l2bhZ3NsN8RcF6oMThTydytacHOjyO2Jd56pL/d36+n/ZoIt6+FsR52d/4NaTN6TWMgZ6kh1MH67rCxtnu47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735466; c=relaxed/simple;
	bh=XMClf3wCa2NubTKVC/iGipIrp0HImYzJ0t2Qt0ONKC4=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=GUIZSdIX/UOITzHHZq8iRo3NzgX0SdnXcZHDhqkXAmOkNg2U9FPE9lF+l5gvxPG5CZNZq8Cr/UFWCxumB9rWIIuH/VybK/PTyiVnZ1N8IlAwRk5bLEubrEURWnLK2c3R0tfAtssrhPJ+z6IaxRNQi5YwStKTWMqXESrdhjXLXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=I+A9fUEe; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZJyttXmiIjSdv1E4r6rUPWCh6pFMFPfu4ZpfWFmdHyw=; b=I+A9fUEe13RhDrJRMeGTm3+R3h
	Kqsab3JRQrmO9Ep7O+cDMJBaFfaPd6S3NAyOs7tqcakmgmEbcaq2xOxf5yLZKhJmeYF038GVcPJHW
	B+8tAL2kwWYh9mJCC5cSOXmlqANfD7M+GHgKEr7Qc88cmjZm80g6tIVyRpos9at3UpT9mtyqIypTP
	rGxI8idrS3bD9RoOP7p46IC/RksZaW7D8mA1sV4emkRVtEtDX7FjOhrA1yjqagdNO/ONNfyZjQPVi
	D3VB6GS2FqlqwyoTBDT7GEKhtucbUxMQAs65XgefZFQ2u8sfeEh3/TpzU5zJ84o5o/asuHh36jcKG
	YhqWhlZg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXP-001LVG-0L;
	Sun, 27 Apr 2025 14:30:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:30:51 +0800
Date: Sun, 27 Apr 2025 14:30:51 +0800
Message-Id: <18cc58664512fb0feeb6eb4631b996fd6ef5870a.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 04/13] crypto: arm64/sha256 - implement library instead of
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

Remove support for SHA-256 finalization from the ARMv8 CE assembly code,
since the library does not yet support architecture-specific overrides
of the finalization.  (Support for that has been omitted for now, for
simplicity and because usually it isn't performance-critical.)

To match sha256_blocks_arch(), change the type of the nblocks parameter
of the assembly functions from int or 'unsigned int' to size_t.  Update
the ARMv8 CE assembly function accordingly.  The scalar and NEON
assembly functions actually already treated it as size_t.

While renaming the assembly files, also fix the naming quirks where
"sha2" meant sha256, and "sha512" meant both sha256 and sha512.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/arm64/configs/defconfig                  |   1 -
 arch/arm64/crypto/Kconfig                     |  19 ---
 arch/arm64/crypto/Makefile                    |  13 +-
 arch/arm64/crypto/sha2-ce-glue.c              | 138 ----------------
 arch/arm64/crypto/sha256-glue.c               | 156 ------------------
 arch/arm64/crypto/sha512-glue.c               |   6 +-
 arch/arm64/lib/crypto/.gitignore              |   1 +
 arch/arm64/lib/crypto/Kconfig                 |   6 +
 arch/arm64/lib/crypto/Makefile                |   9 +-
 .../crypto/sha2-armv8.pl}                     |   2 +-
 .../sha2-ce-core.S => lib/crypto/sha256-ce.S} |  36 +---
 arch/arm64/lib/crypto/sha256.c                |  75 +++++++++
 12 files changed, 103 insertions(+), 359 deletions(-)
 delete mode 100644 arch/arm64/crypto/sha2-ce-glue.c
 delete mode 100644 arch/arm64/crypto/sha256-glue.c
 rename arch/arm64/{crypto/sha512-armv8.pl => lib/crypto/sha2-armv8.pl} (99%)
 rename arch/arm64/{crypto/sha2-ce-core.S => lib/crypto/sha256-ce.S} (80%)
 create mode 100644 arch/arm64/lib/crypto/sha256.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..b0d4c7d173ea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1737,7 +1737,6 @@ CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_GHASH_ARM64_CE=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
-CONFIG_CRYPTO_SHA2_ARM64_CE=y
 CONFIG_CRYPTO_SHA512_ARM64_CE=m
 CONFIG_CRYPTO_SHA3_ARM64=m
 CONFIG_CRYPTO_SM3_ARM64_CE=m
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 55a7d87a6769..c44b0f202a1f 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -36,25 +36,6 @@ config CRYPTO_SHA1_ARM64_CE
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 
-config CRYPTO_SHA256_ARM64
-	tristate "Hash functions: SHA-224 and SHA-256"
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: arm64
-
-config CRYPTO_SHA2_ARM64_CE
-	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_SHA256_ARM64
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: arm64 using:
-	  - ARMv8 Crypto Extensions
-
 config CRYPTO_SHA512_ARM64
 	tristate "Hash functions: SHA-384 and SHA-512"
 	select CRYPTO_HASH
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 089ae3ddde81..c231c980c514 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -8,9 +8,6 @@
 obj-$(CONFIG_CRYPTO_SHA1_ARM64_CE) += sha1-ce.o
 sha1-ce-y := sha1-ce-glue.o sha1-ce-core.o
 
-obj-$(CONFIG_CRYPTO_SHA2_ARM64_CE) += sha2-ce.o
-sha2-ce-y := sha2-ce-glue.o sha2-ce-core.o
-
 obj-$(CONFIG_CRYPTO_SHA512_ARM64_CE) += sha512-ce.o
 sha512-ce-y := sha512-ce-glue.o sha512-ce-core.o
 
@@ -56,9 +53,6 @@ aes-ce-blk-y := aes-glue-ce.o aes-ce.o
 obj-$(CONFIG_CRYPTO_AES_ARM64_NEON_BLK) += aes-neon-blk.o
 aes-neon-blk-y := aes-glue-neon.o aes-neon.o
 
-obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
-sha256-arm64-y := sha256-glue.o sha256-core.o
-
 obj-$(CONFIG_CRYPTO_SHA512_ARM64) += sha512-arm64.o
 sha512-arm64-y := sha512-glue.o sha512-core.o
 
@@ -74,10 +68,7 @@ aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
-$(obj)/%-core.S: $(src)/%-armv8.pl
+$(obj)/sha512-core.S: $(src)/../lib/crypto/sha2-armv8.pl
 	$(call cmd,perlasm)
 
-$(obj)/sha256-core.S: $(src)/sha512-armv8.pl
-	$(call cmd,perlasm)
-
-clean-files += sha256-core.S sha512-core.S
+clean-files += sha512-core.S
diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
deleted file mode 100644
index 912c215101eb..000000000000
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * sha2-ce-glue.c - SHA-224/SHA-256 using ARMv8 Crypto Extensions
- *
- * Copyright (C) 2014 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
-#include <asm/neon.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/cpufeature.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_ALIAS_CRYPTO("sha256");
-
-struct sha256_ce_state {
-	struct crypto_sha256_state sst;
-	u32			finalize;
-};
-
-extern const u32 sha256_ce_offsetof_count;
-extern const u32 sha256_ce_offsetof_finalize;
-
-asmlinkage int __sha256_ce_transform(struct sha256_ce_state *sst, u8 const *src,
-				     int blocks);
-
-static void sha256_ce_transform(struct crypto_sha256_state *sst, u8 const *src,
-				int blocks)
-{
-	while (blocks) {
-		int rem;
-
-		kernel_neon_begin();
-		rem = __sha256_ce_transform(container_of(sst,
-							 struct sha256_ce_state,
-							 sst), src, blocks);
-		kernel_neon_end();
-		src += (blocks - rem) * SHA256_BLOCK_SIZE;
-		blocks = rem;
-	}
-}
-
-const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
-					      sst.count);
-const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
-						 finalize);
-
-static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int len)
-{
-	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-
-	sctx->finalize = 0;
-	return sha256_base_do_update_blocks(desc, data, len,
-					    sha256_ce_transform);
-}
-
-static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
-			   unsigned int len, u8 *out)
-{
-	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !(len % SHA256_BLOCK_SIZE) && len;
-
-	/*
-	 * Allow the asm code to perform the finalization if there is no
-	 * partial data and the input is a round multiple of the block size.
-	 */
-	sctx->finalize = finalize;
-
-	if (finalize)
-		sha256_base_do_update_blocks(desc, data, len,
-					     sha256_ce_transform);
-	else
-		sha256_base_do_finup(desc, data, len, sha256_ce_transform);
-	return sha256_base_finish(desc, out);
-}
-
-static int sha256_ce_digest(struct shash_desc *desc, const u8 *data,
-			    unsigned int len, u8 *out)
-{
-	sha256_base_init(desc);
-	return sha256_ce_finup(desc, data, len, out);
-}
-
-static struct shash_alg algs[] = { {
-	.init			= sha224_base_init,
-	.update			= sha256_ce_update,
-	.finup			= sha256_ce_finup,
-	.descsize		= sizeof(struct sha256_ce_state),
-	.statesize		= sizeof(struct crypto_sha256_state),
-	.digestsize		= SHA224_DIGEST_SIZE,
-	.base			= {
-		.cra_name		= "sha224",
-		.cra_driver_name	= "sha224-ce",
-		.cra_priority		= 200,
-		.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					  CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize		= SHA256_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-}, {
-	.init			= sha256_base_init,
-	.update			= sha256_ce_update,
-	.finup			= sha256_ce_finup,
-	.digest			= sha256_ce_digest,
-	.descsize		= sizeof(struct sha256_ce_state),
-	.statesize		= sizeof(struct crypto_sha256_state),
-	.digestsize		= SHA256_DIGEST_SIZE,
-	.base			= {
-		.cra_name		= "sha256",
-		.cra_driver_name	= "sha256-ce",
-		.cra_priority		= 200,
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
diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
deleted file mode 100644
index d63ea82e1374..000000000000
--- a/arch/arm64/crypto/sha256-glue.c
+++ /dev/null
@@ -1,156 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Linux/arm64 port of the OpenSSL SHA256 implementation for AArch64
- *
- * Copyright (c) 2016 Linaro Ltd. <ard.biesheuvel@linaro.org>
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
-MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash for arm64");
-MODULE_AUTHOR("Andy Polyakov <appro@openssl.org>");
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_ALIAS_CRYPTO("sha256");
-
-asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
-					unsigned int num_blks);
-EXPORT_SYMBOL(sha256_block_data_order);
-
-static void sha256_arm64_transform(struct crypto_sha256_state *sst,
-				   u8 const *src, int blocks)
-{
-	sha256_block_data_order(sst->state, src, blocks);
-}
-
-asmlinkage void sha256_block_neon(u32 *digest, const void *data,
-				  unsigned int num_blks);
-
-static void sha256_neon_transform(struct crypto_sha256_state *sst,
-				  u8 const *src, int blocks)
-{
-	kernel_neon_begin();
-	sha256_block_neon(sst->state, src, blocks);
-	kernel_neon_end();
-}
-
-static int crypto_sha256_arm64_update(struct shash_desc *desc, const u8 *data,
-				      unsigned int len)
-{
-	return sha256_base_do_update_blocks(desc, data, len,
-					    sha256_arm64_transform);
-}
-
-static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
-				     unsigned int len, u8 *out)
-{
-	sha256_base_do_finup(desc, data, len, sha256_arm64_transform);
-	return sha256_base_finish(desc, out);
-}
-
-static struct shash_alg algs[] = { {
-	.digestsize		= SHA256_DIGEST_SIZE,
-	.init			= sha256_base_init,
-	.update			= crypto_sha256_arm64_update,
-	.finup			= crypto_sha256_arm64_finup,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.base.cra_name		= "sha256",
-	.base.cra_driver_name	= "sha256-arm64",
-	.base.cra_priority	= 125,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINUP_MAX,
-	.base.cra_blocksize	= SHA256_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}, {
-	.digestsize		= SHA224_DIGEST_SIZE,
-	.init			= sha224_base_init,
-	.update			= crypto_sha256_arm64_update,
-	.finup			= crypto_sha256_arm64_finup,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.base.cra_name		= "sha224",
-	.base.cra_driver_name	= "sha224-arm64",
-	.base.cra_priority	= 125,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINUP_MAX,
-	.base.cra_blocksize	= SHA224_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-} };
-
-static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
-			      unsigned int len)
-{
-	return sha256_base_do_update_blocks(desc, data, len,
-					    sha256_neon_transform);
-}
-
-static int sha256_finup_neon(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *out)
-{
-	if (len >= SHA256_BLOCK_SIZE) {
-		int remain = sha256_update_neon(desc, data, len);
-
-		data += len - remain;
-		len = remain;
-	}
-	sha256_base_do_finup(desc, data, len, sha256_neon_transform);
-	return sha256_base_finish(desc, out);
-}
-
-static struct shash_alg neon_algs[] = { {
-	.digestsize		= SHA256_DIGEST_SIZE,
-	.init			= sha256_base_init,
-	.update			= sha256_update_neon,
-	.finup			= sha256_finup_neon,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.base.cra_name		= "sha256",
-	.base.cra_driver_name	= "sha256-arm64-neon",
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINUP_MAX,
-	.base.cra_blocksize	= SHA256_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}, {
-	.digestsize		= SHA224_DIGEST_SIZE,
-	.init			= sha224_base_init,
-	.update			= sha256_update_neon,
-	.finup			= sha256_finup_neon,
-	.descsize		= sizeof(struct crypto_sha256_state),
-	.base.cra_name		= "sha224",
-	.base.cra_driver_name	= "sha224-arm64-neon",
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				  CRYPTO_AHASH_ALG_FINUP_MAX,
-	.base.cra_blocksize	= SHA224_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-} };
-
-static int __init sha256_mod_init(void)
-{
-	int ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
-	if (ret)
-		return ret;
-
-	if (cpu_have_named_feature(ASIMD)) {
-		ret = crypto_register_shashes(neon_algs, ARRAY_SIZE(neon_algs));
-		if (ret)
-			crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
-	}
-	return ret;
-}
-
-static void __exit sha256_mod_fini(void)
-{
-	if (cpu_have_named_feature(ASIMD))
-		crypto_unregister_shashes(neon_algs, ARRAY_SIZE(neon_algs));
-	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
-}
-
-module_init(sha256_mod_init);
-module_exit(sha256_mod_fini);
diff --git a/arch/arm64/crypto/sha512-glue.c b/arch/arm64/crypto/sha512-glue.c
index ab2e1c13dfad..15aa9d8b7b2c 100644
--- a/arch/arm64/crypto/sha512-glue.c
+++ b/arch/arm64/crypto/sha512-glue.c
@@ -18,13 +18,13 @@ MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_CRYPTO("sha384");
 MODULE_ALIAS_CRYPTO("sha512");
 
-asmlinkage void sha512_block_data_order(u64 *digest, const void *data,
-					unsigned int num_blks);
+asmlinkage void sha512_blocks_arch(u64 *digest, const void *data,
+				   unsigned int num_blks);
 
 static void sha512_arm64_transform(struct sha512_state *sst, u8 const *src,
 				   int blocks)
 {
-	sha512_block_data_order(sst->state, src, blocks);
+	sha512_blocks_arch(sst->state, src, blocks);
 }
 
 static int sha512_update(struct shash_desc *desc, const u8 *data,
diff --git a/arch/arm64/lib/crypto/.gitignore b/arch/arm64/lib/crypto/.gitignore
index 0d47d4f21c6d..12d74d8b03d0 100644
--- a/arch/arm64/lib/crypto/.gitignore
+++ b/arch/arm64/lib/crypto/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 poly1305-core.S
+sha256-core.S
diff --git a/arch/arm64/lib/crypto/Kconfig b/arch/arm64/lib/crypto/Kconfig
index 0b903ef524d8..129a7685cb4c 100644
--- a/arch/arm64/lib/crypto/Kconfig
+++ b/arch/arm64/lib/crypto/Kconfig
@@ -12,3 +12,9 @@ config CRYPTO_POLY1305_NEON
 	depends on KERNEL_MODE_NEON
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_SHA256_ARM64
+	tristate
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256_SIMD
diff --git a/arch/arm64/lib/crypto/Makefile b/arch/arm64/lib/crypto/Makefile
index 6207088397a7..946c09903711 100644
--- a/arch/arm64/lib/crypto/Makefile
+++ b/arch/arm64/lib/crypto/Makefile
@@ -8,10 +8,17 @@ poly1305-neon-y := poly1305-core.o poly1305-glue.o
 AFLAGS_poly1305-core.o += -Dpoly1305_init=poly1305_block_init_arch
 AFLAGS_poly1305-core.o += -Dpoly1305_emit=poly1305_emit_arch
 
+obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
+sha256-arm64-y := sha256.o sha256-core.o
+sha256-arm64-$(CONFIG_KERNEL_MODE_NEON) += sha256-ce.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
 $(obj)/%-core.S: $(src)/%-armv8.pl
 	$(call cmd,perlasm)
 
-clean-files += poly1305-core.S
+$(obj)/sha256-core.S: $(src)/sha2-armv8.pl
+	$(call cmd,perlasm)
+
+clean-files += poly1305-core.S sha256-core.S
diff --git a/arch/arm64/crypto/sha512-armv8.pl b/arch/arm64/lib/crypto/sha2-armv8.pl
similarity index 99%
rename from arch/arm64/crypto/sha512-armv8.pl
rename to arch/arm64/lib/crypto/sha2-armv8.pl
index 35ec9ae99fe1..4aebd20c498b 100644
--- a/arch/arm64/crypto/sha512-armv8.pl
+++ b/arch/arm64/lib/crypto/sha2-armv8.pl
@@ -95,7 +95,7 @@ if ($output =~ /512/) {
 	$reg_t="w";
 }
 
-$func="sha${BITS}_block_data_order";
+$func="sha${BITS}_blocks_arch";
 
 ($ctx,$inp,$num,$Ktbl)=map("x$_",(0..2,30));
 
diff --git a/arch/arm64/crypto/sha2-ce-core.S b/arch/arm64/lib/crypto/sha256-ce.S
similarity index 80%
rename from arch/arm64/crypto/sha2-ce-core.S
rename to arch/arm64/lib/crypto/sha256-ce.S
index fce84d88ddb2..a8461d6dad63 100644
--- a/arch/arm64/crypto/sha2-ce-core.S
+++ b/arch/arm64/lib/crypto/sha256-ce.S
@@ -71,8 +71,8 @@
 	.word		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
 
 	/*
-	 * int __sha256_ce_transform(struct sha256_ce_state *sst, u8 const *src,
-	 *			     int blocks)
+	 * size_t __sha256_ce_transform(u32 state[SHA256_STATE_WORDS],
+	 *				const u8 *data, size_t nblocks);
 	 */
 	.text
 SYM_FUNC_START(__sha256_ce_transform)
@@ -86,20 +86,16 @@ SYM_FUNC_START(__sha256_ce_transform)
 	/* load state */
 	ld1		{dgav.4s, dgbv.4s}, [x0]
 
-	/* load sha256_ce_state::finalize */
-	ldr_l		w4, sha256_ce_offsetof_finalize, x4
-	ldr		w4, [x0, x4]
-
 	/* load input */
 0:	ld1		{v16.4s-v19.4s}, [x1], #64
-	sub		w2, w2, #1
+	sub		x2, x2, #1
 
 CPU_LE(	rev32		v16.16b, v16.16b	)
 CPU_LE(	rev32		v17.16b, v17.16b	)
 CPU_LE(	rev32		v18.16b, v18.16b	)
 CPU_LE(	rev32		v19.16b, v19.16b	)
 
-1:	add		t0.4s, v16.4s, v0.4s
+	add		t0.4s, v16.4s, v0.4s
 	mov		dg0v.16b, dgav.16b
 	mov		dg1v.16b, dgbv.16b
 
@@ -128,30 +124,12 @@ CPU_LE(	rev32		v19.16b, v19.16b	)
 	add		dgbv.4s, dgbv.4s, dg1v.4s
 
 	/* handled all input blocks? */
-	cbz		w2, 2f
+	cbz		x2, 1f
 	cond_yield	3f, x5, x6
 	b		0b
 
-	/*
-	 * Final block: add padding and total bit count.
-	 * Skip if the input size was not a round multiple of the block size,
-	 * the padding is handled by the C code in that case.
-	 */
-2:	cbz		x4, 3f
-	ldr_l		w4, sha256_ce_offsetof_count, x4
-	ldr		x4, [x0, x4]
-	movi		v17.2d, #0
-	mov		x8, #0x80000000
-	movi		v18.2d, #0
-	ror		x7, x4, #29		// ror(lsl(x4, 3), 32)
-	fmov		d16, x8
-	mov		x4, #0
-	mov		v19.d[0], xzr
-	mov		v19.d[1], x7
-	b		1b
-
 	/* store new state */
-3:	st1		{dgav.4s, dgbv.4s}, [x0]
-	mov		w0, w2
+1:	st1		{dgav.4s, dgbv.4s}, [x0]
+	mov		x0, x2
 	ret
 SYM_FUNC_END(__sha256_ce_transform)
diff --git a/arch/arm64/lib/crypto/sha256.c b/arch/arm64/lib/crypto/sha256.c
new file mode 100644
index 000000000000..fdceb2d0899c
--- /dev/null
+++ b/arch/arm64/lib/crypto/sha256.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 optimized for ARM64
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
+asmlinkage void sha256_block_neon(u32 state[SHA256_STATE_WORDS],
+				  const u8 *data, size_t nblocks);
+asmlinkage size_t __sha256_ce_transform(u32 state[SHA256_STATE_WORDS],
+					const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_ce);
+
+void sha256_blocks_simd(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    static_branch_likely(&have_neon)) {
+		if (static_branch_likely(&have_ce)) {
+			do {
+				size_t rem;
+
+				kernel_neon_begin();
+				rem = __sha256_ce_transform(state,
+							    data, nblocks);
+				kernel_neon_end();
+				data += (nblocks - rem) * SHA256_BLOCK_SIZE;
+				nblocks = rem;
+			} while (nblocks);
+		} else {
+			kernel_neon_begin();
+			sha256_block_neon(state, data, nblocks);
+			kernel_neon_end();
+		}
+	} else {
+		sha256_blocks_arch(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_simd);
+
+bool sha256_is_arch_optimized(void)
+{
+	/* We always can use at least the ARM64 scalar implementation. */
+	return true;
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
+
+static int __init sha256_arm64_mod_init(void)
+{
+	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
+	    cpu_have_named_feature(ASIMD)) {
+		static_branch_enable(&have_neon);
+		if (cpu_have_named_feature(SHA2))
+			static_branch_enable(&have_ce);
+	}
+	return 0;
+}
+arch_initcall(sha256_arm64_mod_init);
+
+static void __exit sha256_arm64_mod_exit(void)
+{
+}
+module_exit(sha256_arm64_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-256 optimized for ARM64");
-- 
2.39.5


