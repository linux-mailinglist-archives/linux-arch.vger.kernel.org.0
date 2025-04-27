Return-Path: <linux-arch+bounces-11624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DFA9DFE1
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E5A5A44F2
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1124BBEE;
	Sun, 27 Apr 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WTqV1YEN"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D032459D1;
	Sun, 27 Apr 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735466; cv=none; b=kNUOX+hGjNAeuXVFemVldGaf0eIvltwJkW5kCXekZEcuPrP+roktOdaE3Svl9lrL8ZZK6UEA82L8MxtYQ7vPk+s/0v25kzeCNNf9BY6rf0fa8Y5DpUfGv2pAC/YVepfv8G94lAW62z1sXW/Q5Vjbw/pdhd+08UMPmCfzkV6qhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735466; c=relaxed/simple;
	bh=Hh5sLDXb5arGabByzQ1480NIiE2yWoXHTG2rWbLWjww=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=XiUCS+w+IBdvwjucUSBiVHDtjKsM84I6i4DGcjxZKAIx6y/6y8MGDELLVd4c9QuO+VF4GXuQMI0Gy2zZGDR1rNgAjQo6q6GLVLkzkQCoKlKO7LSHjhCyL81e9hYjKCkACe7EgJacJbBNz79om+Z/oPSFKjtxJaRaSTaqKdLYMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WTqV1YEN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yks5gCO0v3/Nwhtw3eMhsS1fOwKBC+qVEuvZm4t2GQQ=; b=WTqV1YENxPzNvxPcVnBKMS6EaA
	xjItsqAUp0jyl4kNlFEw+kAt4VYusxZf8e8Fvo8B62keb3W5IzRcBBrinoyBTJR69VXosIU9J/P1m
	D4g0K9imlogPjrh85ZdQx+GG3gGqtWApziyvqgSr+JgK5StscFItSo5WAcTvrz0dKKMI3autWvl1t
	MwMbLU66P+ghTgq4gQbvRixy8GxP+PNDI8ToZyI/yQ/zt4tQPlUpQydUkfMe9d6p2QJOO1f6+estw
	IvkQ1Kg1ZcpliSL63XLdtfEkJkl0TrDyn4k6xmFKtvHRYqZFe535gToM6pqeuis7FFqFC6JZFAEbe
	UigYMfYw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXW-001LW1-06;
	Sun, 27 Apr 2025 14:30:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:30:58 +0800
Date: Sun, 27 Apr 2025 14:30:58 +0800
Message-Id: <f78d8294da2b20f649c676afafe8cf810dc68650.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 07/13] crypto: riscv/sha256 - implement library instead of
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
of the assembly function from int to size_t.  The assembly function
actually already treated it as size_t.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/riscv/crypto/Kconfig                     |  11 --
 arch/riscv/crypto/Makefile                    |   3 -
 arch/riscv/crypto/sha256-riscv64-glue.c       | 125 ------------------
 arch/riscv/lib/crypto/Kconfig                 |   8 ++
 arch/riscv/lib/crypto/Makefile                |   3 +
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    |   4 +-
 arch/riscv/lib/crypto/sha256.c                |  67 ++++++++++
 7 files changed, 80 insertions(+), 141 deletions(-)
 delete mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 rename arch/riscv/{ => lib}/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S (98%)
 create mode 100644 arch/riscv/lib/crypto/sha256.c

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 4863be2a4ec2..cd9b776602f8 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -28,17 +28,6 @@ config CRYPTO_GHASH_RISCV64
 	  Architecture: riscv64 using:
 	  - Zvkg vector crypto extension
 
-config CRYPTO_SHA256_RISCV64
-	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
-	select CRYPTO_SHA256
-	help
-	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
-
-	  Architecture: riscv64 using:
-	  - Zvknha or Zvknhb vector crypto extensions
-	  - Zvkb vector crypto extension
-
 config CRYPTO_SHA512_RISCV64
 	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 4ae9bf762e90..e10e8257734e 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -7,9 +7,6 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
-obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
-sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
-
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
 
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
deleted file mode 100644
index c998300ab843..000000000000
--- a/arch/riscv/crypto/sha256-riscv64-glue.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * SHA-256 and SHA-224 using the RISC-V vector crypto extensions
- *
- * Copyright (C) 2022 VRULL GmbH
- * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
- *
- * Copyright (C) 2023 SiFive, Inc.
- * Author: Jerry Shih <jerry.shih@sifive.com>
- */
-
-#include <asm/simd.h>
-#include <asm/vector.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-/*
- * Note: the asm function only uses the 'state' field of struct sha256_state.
- * It is assumed to be the first field.
- */
-asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
-	struct crypto_sha256_state *state, const u8 *data, int num_blocks);
-
-static void sha256_block(struct crypto_sha256_state *state, const u8 *data,
-			 int num_blocks)
-{
-	/*
-	 * Ensure struct crypto_sha256_state begins directly with the SHA-256
-	 * 256-bit internal state, as this is what the asm function expects.
-	 */
-	BUILD_BUG_ON(offsetof(struct crypto_sha256_state, state) != 0);
-
-	if (crypto_simd_usable()) {
-		kernel_vector_begin();
-		sha256_transform_zvknha_or_zvknhb_zvkb(state, data, num_blocks);
-		kernel_vector_end();
-	} else
-		sha256_transform_blocks(state, data, num_blocks);
-}
-
-static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
-				 unsigned int len)
-{
-	return sha256_base_do_update_blocks(desc, data, len, sha256_block);
-}
-
-static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
-				unsigned int len, u8 *out)
-{
-	sha256_base_do_finup(desc, data, len, sha256_block);
-	return sha256_base_finish(desc, out);
-}
-
-static int riscv64_sha256_digest(struct shash_desc *desc, const u8 *data,
-				 unsigned int len, u8 *out)
-{
-	return sha256_base_init(desc) ?:
-	       riscv64_sha256_finup(desc, data, len, out);
-}
-
-static struct shash_alg riscv64_sha256_algs[] = {
-	{
-		.init = sha256_base_init,
-		.update = riscv64_sha256_update,
-		.finup = riscv64_sha256_finup,
-		.digest = riscv64_sha256_digest,
-		.descsize = sizeof(struct crypto_sha256_state),
-		.digestsize = SHA256_DIGEST_SIZE,
-		.base = {
-			.cra_blocksize = SHA256_BLOCK_SIZE,
-			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				     CRYPTO_AHASH_ALG_FINUP_MAX,
-			.cra_priority = 300,
-			.cra_name = "sha256",
-			.cra_driver_name = "sha256-riscv64-zvknha_or_zvknhb-zvkb",
-			.cra_module = THIS_MODULE,
-		},
-	}, {
-		.init = sha224_base_init,
-		.update = riscv64_sha256_update,
-		.finup = riscv64_sha256_finup,
-		.descsize = sizeof(struct crypto_sha256_state),
-		.digestsize = SHA224_DIGEST_SIZE,
-		.base = {
-			.cra_blocksize = SHA224_BLOCK_SIZE,
-			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
-				     CRYPTO_AHASH_ALG_FINUP_MAX,
-			.cra_priority = 300,
-			.cra_name = "sha224",
-			.cra_driver_name = "sha224-riscv64-zvknha_or_zvknhb-zvkb",
-			.cra_module = THIS_MODULE,
-		},
-	},
-};
-
-static int __init riscv64_sha256_mod_init(void)
-{
-	/* Both zvknha and zvknhb provide the SHA-256 instructions. */
-	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
-	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
-	    riscv_isa_extension_available(NULL, ZVKB) &&
-	    riscv_vector_vlen() >= 128)
-		return crypto_register_shashes(riscv64_sha256_algs,
-					       ARRAY_SIZE(riscv64_sha256_algs));
-
-	return -ENODEV;
-}
-
-static void __exit riscv64_sha256_mod_exit(void)
-{
-	crypto_unregister_shashes(riscv64_sha256_algs,
-				  ARRAY_SIZE(riscv64_sha256_algs));
-}
-
-module_init(riscv64_sha256_mod_init);
-module_exit(riscv64_sha256_mod_exit);
-
-MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
-MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_CRYPTO("sha256");
-MODULE_ALIAS_CRYPTO("sha224");
diff --git a/arch/riscv/lib/crypto/Kconfig b/arch/riscv/lib/crypto/Kconfig
index bc7a43f33eb3..47c99ea97ce2 100644
--- a/arch/riscv/lib/crypto/Kconfig
+++ b/arch/riscv/lib/crypto/Kconfig
@@ -6,3 +6,11 @@ config CRYPTO_CHACHA_RISCV64
 	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
+
+config CRYPTO_SHA256_RISCV64
+	tristate
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256_SIMD
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/riscv/lib/crypto/Makefile b/arch/riscv/lib/crypto/Makefile
index e27b78f317fc..b7cb877a2c07 100644
--- a/arch/riscv/lib/crypto/Makefile
+++ b/arch/riscv/lib/crypto/Makefile
@@ -2,3 +2,6 @@
 
 obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
+
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
similarity index 98%
rename from arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
rename to arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
index f1f5779e4732..fad501ad0617 100644
--- a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
+++ b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
@@ -106,8 +106,8 @@
 	sha256_4rounds	\last, \k3, W3, W0, W1, W2
 .endm
 
-// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[8], const u8 *data,
-//					       int num_blocks);
+// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[SHA256_STATE_WORDS],
+//					       const u8 *data, size_t nblocks);
 SYM_FUNC_START(sha256_transform_zvknha_or_zvknhb_zvkb)
 
 	// Load the round constants into K0-K15.
diff --git a/arch/riscv/lib/crypto/sha256.c b/arch/riscv/lib/crypto/sha256.c
new file mode 100644
index 000000000000..c1358eafc2ad
--- /dev/null
+++ b/arch/riscv/lib/crypto/sha256.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 (RISC-V accelerated)
+ *
+ * Copyright (C) 2022 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/vector.h>
+#include <crypto/internal/sha2.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
+	u32 state[SHA256_STATE_WORDS], const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_extensions);
+
+void sha256_blocks_simd(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_extensions)) {
+		kernel_vector_begin();
+		sha256_transform_zvknha_or_zvknhb_zvkb(state, data, nblocks);
+		kernel_vector_end();
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
+	return static_key_enabled(&have_extensions);
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
+
+static int __init riscv64_sha256_mod_init(void)
+{
+	/* Both zvknha and zvknhb provide the SHA-256 instructions. */
+	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
+	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		static_branch_enable(&have_extensions);
+	return 0;
+}
+arch_initcall(riscv64_sha256_mod_init);
+
+static void __exit riscv64_sha256_mod_exit(void)
+{
+}
+module_exit(riscv64_sha256_mod_exit);
+
+MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
-- 
2.39.5


