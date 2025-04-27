Return-Path: <linux-arch+bounces-11625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5FA9DFC8
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96861A83948
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E724E011;
	Sun, 27 Apr 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QJh+Zf8Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114324886E;
	Sun, 27 Apr 2025 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735468; cv=none; b=qOljvEsInQ+0zMvwXQ4s2jJ70OAB61mmKZZnCFwwTVxwXbcnPV3WbLtgl50hzDRrKJctjQdL55XXVefAbv/07bABZneXEJeOOT7JmC0VviUhgTJZ0m7d8PXq4nLgIRHmF20oYLsbQeiwnbXFQ+U0tWddbcSZ/YpzA5C3/nkmzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735468; c=relaxed/simple;
	bh=yw7PeBr0nClAZBwY43wDgqoqDLuzTUHmdjMPNHGTBtQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=kalqDZ3EoOmgkLEQA+zdvg+49Z+b7b0ZammFUO7gCJRMmTO0/y4OlWuYH6Sd1qnYiE5ekkK/gXspbo7TdyQJTu3NyS5XIUC7cb4sI2335frjgI1enKg3/2GI6GP1kah3UvnM1JiqlV9N1Wvrmu5iwblOoCAxn+YYHrobMhk8IoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QJh+Zf8Y; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c8FPEHIXG9k6DVHh4+6lNaAaIuRZXXjhhcXmQ3FuS9Q=; b=QJh+Zf8YdJmBS3aWo45xmXj6nE
	2SOCYu1bw7RwvAkDGodYkOrJwbWNre0Vl7KbAvMK6iy49/8YoPX5B8R9Ar11HFOICiHTNms2Itl5Q
	zbXrFkdeyq17E1kE96nHO7prMLjpjOYNgLVduTP3SZo4vI05Hc2nVHZMlgZTn5VJzSmUnzqPZFrUQ
	3jr2s+Y5LJjQ5PYSg6Ox+NeT3EBJOkEM+TSNP2CH1lacm2zWt6wc+c2DrTLKYUkkh/pkWkteMG9VE
	+zoZyb/Gfnp9K72NfW31qnjOHKOo+RdQpqVoO8U64wrHI857Kc7ftdmMpjX/+WC/Usb4E5DuJdFvW
	XrToi8pw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXY-001LWG-1V;
	Sun, 27 Apr 2025 14:31:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:31:00 +0800
Date: Sun, 27 Apr 2025 14:31:00 +0800
Message-Id: <7b1fae3d2b3ed5307825100e72b860d3d23b9e06.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 08/13] crypto: s390/sha256 - implement library instead of
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/s390/configs/debug_defconfig |   1 -
 arch/s390/configs/defconfig       |   1 -
 arch/s390/crypto/Kconfig          |  10 ---
 arch/s390/crypto/Makefile         |   1 -
 arch/s390/crypto/sha256_s390.c    | 144 ------------------------------
 arch/s390/lib/crypto/Kconfig      |   6 ++
 arch/s390/lib/crypto/Makefile     |   2 +
 arch/s390/lib/crypto/sha256.c     |  47 ++++++++++
 8 files changed, 55 insertions(+), 157 deletions(-)
 delete mode 100644 arch/s390/crypto/sha256_s390.c
 create mode 100644 arch/s390/lib/crypto/sha256.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 6f2c9ce1b154..de69faa4d94f 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -795,7 +795,6 @@ CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_SHA1_S390=m
-CONFIG_CRYPTO_SHA256_S390=m
 CONFIG_CRYPTO_SHA3_256_S390=m
 CONFIG_CRYPTO_SHA3_512_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index f18a7d97ac21..f12679448e97 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -782,7 +782,6 @@ CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_SHA1_S390=m
-CONFIG_CRYPTO_SHA256_S390=m
 CONFIG_CRYPTO_SHA3_256_S390=m
 CONFIG_CRYPTO_SHA3_512_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index a2bfd6eef0ca..e2c27588b21a 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -22,16 +22,6 @@ config CRYPTO_SHA1_S390
 
 	  It is available as of z990.
 
-config CRYPTO_SHA256_S390
-	tristate "Hash functions: SHA-224 and SHA-256"
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: s390
-
-	  It is available as of z9.
-
 config CRYPTO_SHA3_256_S390
 	tristate "Hash functions: SHA3-224 and SHA3-256"
 	select CRYPTO_HASH
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index e3853774e1a3..21757d86cd49 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -4,7 +4,6 @@
 #
 
 obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s390.o sha_common.o
-obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_SHA512_S390) += sha512_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_SHA3_256_S390) += sha3_256_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_SHA3_512_S390) += sha3_512_s390.o sha_common.o
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
deleted file mode 100644
index e6876c49414d..000000000000
--- a/arch/s390/crypto/sha256_s390.c
+++ /dev/null
@@ -1,144 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Cryptographic API.
- *
- * s390 implementation of the SHA256 and SHA224 Secure Hash Algorithm.
- *
- * s390 Version:
- *   Copyright IBM Corp. 2005, 2011
- *   Author(s): Jan Glauber (jang@de.ibm.com)
- */
-#include <asm/cpacf.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <linux/cpufeature.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-#include "sha.h"
-
-static int s390_sha256_init(struct shash_desc *desc)
-{
-	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-
-	sctx->state[0] = SHA256_H0;
-	sctx->state[1] = SHA256_H1;
-	sctx->state[2] = SHA256_H2;
-	sctx->state[3] = SHA256_H3;
-	sctx->state[4] = SHA256_H4;
-	sctx->state[5] = SHA256_H5;
-	sctx->state[6] = SHA256_H6;
-	sctx->state[7] = SHA256_H7;
-	sctx->count = 0;
-	sctx->func = CPACF_KIMD_SHA_256;
-
-	return 0;
-}
-
-static int sha256_export(struct shash_desc *desc, void *out)
-{
-	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-	struct crypto_sha256_state *octx = out;
-
-	octx->count = sctx->count;
-	memcpy(octx->state, sctx->state, sizeof(octx->state));
-	return 0;
-}
-
-static int sha256_import(struct shash_desc *desc, const void *in)
-{
-	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-	const struct crypto_sha256_state *ictx = in;
-
-	sctx->count = ictx->count;
-	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
-	sctx->func = CPACF_KIMD_SHA_256;
-	return 0;
-}
-
-static struct shash_alg sha256_alg = {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	s390_sha256_init,
-	.update		=	s390_sha_update_blocks,
-	.finup		=	s390_sha_finup,
-	.export		=	sha256_export,
-	.import		=	sha256_import,
-	.descsize	=	S390_SHA_CTX_SIZE,
-	.statesize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name=	"sha256-s390",
-		.cra_priority	=	300,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-};
-
-static int s390_sha224_init(struct shash_desc *desc)
-{
-	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
-
-	sctx->state[0] = SHA224_H0;
-	sctx->state[1] = SHA224_H1;
-	sctx->state[2] = SHA224_H2;
-	sctx->state[3] = SHA224_H3;
-	sctx->state[4] = SHA224_H4;
-	sctx->state[5] = SHA224_H5;
-	sctx->state[6] = SHA224_H6;
-	sctx->state[7] = SHA224_H7;
-	sctx->count = 0;
-	sctx->func = CPACF_KIMD_SHA_256;
-
-	return 0;
-}
-
-static struct shash_alg sha224_alg = {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	s390_sha224_init,
-	.update		=	s390_sha_update_blocks,
-	.finup		=	s390_sha_finup,
-	.export		=	sha256_export,
-	.import		=	sha256_import,
-	.descsize	=	S390_SHA_CTX_SIZE,
-	.statesize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name=	"sha224-s390",
-		.cra_priority	=	300,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-};
-
-static int __init sha256_s390_init(void)
-{
-	int ret;
-
-	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_256))
-		return -ENODEV;
-	ret = crypto_register_shash(&sha256_alg);
-	if (ret < 0)
-		goto out;
-	ret = crypto_register_shash(&sha224_alg);
-	if (ret < 0)
-		crypto_unregister_shash(&sha256_alg);
-out:
-	return ret;
-}
-
-static void __exit sha256_s390_fini(void)
-{
-	crypto_unregister_shash(&sha224_alg);
-	crypto_unregister_shash(&sha256_alg);
-}
-
-module_cpu_feature_match(S390_CPU_FEATURE_MSA, sha256_s390_init);
-module_exit(sha256_s390_fini);
-
-MODULE_ALIAS_CRYPTO("sha256");
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA256 and SHA224 Secure Hash Algorithm");
diff --git a/arch/s390/lib/crypto/Kconfig b/arch/s390/lib/crypto/Kconfig
index 069b355fe51a..e3f855ef4393 100644
--- a/arch/s390/lib/crypto/Kconfig
+++ b/arch/s390/lib/crypto/Kconfig
@@ -5,3 +5,9 @@ config CRYPTO_CHACHA_S390
 	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_SHA256_S390
+	tristate
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/s390/lib/crypto/Makefile b/arch/s390/lib/crypto/Makefile
index 06c2cf77178e..920197967f46 100644
--- a/arch/s390/lib/crypto/Makefile
+++ b/arch/s390/lib/crypto/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_CRYPTO_CHACHA_S390) += chacha_s390.o
 chacha_s390-y := chacha-glue.o chacha-s390.o
+
+obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256.o
diff --git a/arch/s390/lib/crypto/sha256.c b/arch/s390/lib/crypto/sha256.c
new file mode 100644
index 000000000000..fcfa2706a7f9
--- /dev/null
+++ b/arch/s390/lib/crypto/sha256.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 optimized using the CP Assist for Cryptographic Functions (CPACF)
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <asm/cpacf.h>
+#include <crypto/internal/sha2.h>
+#include <linux/cpufeature.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_cpacf_sha256);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_cpacf_sha256))
+		cpacf_kimd(CPACF_KIMD_SHA_256, state, data,
+			   nblocks * SHA256_BLOCK_SIZE);
+	else
+		sha256_blocks_generic(state, data, nblocks);
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	return static_key_enabled(&have_cpacf_sha256);
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
+
+static int __init sha256_s390_mod_init(void)
+{
+	if (cpu_have_feature(S390_CPU_FEATURE_MSA) &&
+	    cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_256))
+		static_branch_enable(&have_cpacf_sha256);
+	return 0;
+}
+arch_initcall(sha256_s390_mod_init);
+
+static void __exit sha256_s390_mod_exit(void)
+{
+}
+module_exit(sha256_s390_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-256 using the CP Assist for Cryptographic Functions (CPACF)");
-- 
2.39.5


