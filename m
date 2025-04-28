Return-Path: <linux-arch+bounces-11659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB06A9F694
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8301B7ADF41
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E72291152;
	Mon, 28 Apr 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxGlPp+k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A1290BB2;
	Mon, 28 Apr 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859723; cv=none; b=JRTu8nRyJyVNnvB8Zs/N5gZaUgkTU0Y5/o8TNVQazU0iBKWAvc5O2L1JI9jVT15z2UJ39ej8zHE2aWEtxfAeHu4MovKUWJaIL9nO264GBWrhwGXFTTB6/aa/S1Vr+2ebt/GQY+NN6FF+iHgmJ6bIjoLA17KvMNWRMYGbDmM71yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859723; c=relaxed/simple;
	bh=UZ7gk36w4cLhvdSqxxmiIouNdLfsFUW3VDR+CsRAy7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIVD8leN8aiSLw+aaWaPK8kEs/O0RQe7v6yIVCr9IhvC44Gy0vuFagKnScJo034XGy3e/uMAb5rjYX9sRnpBxWuTZMEYoeE6AC191udCEVh+htiZBTl1YeJwW+9sincND1bdHCOrR7W7fSk+Fdv/CIg3c98cgcPRnzFnWhdnEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxGlPp+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BFC4CEED;
	Mon, 28 Apr 2025 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859723;
	bh=UZ7gk36w4cLhvdSqxxmiIouNdLfsFUW3VDR+CsRAy7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxGlPp+kG0foYanlY4XvP6LcQ5pH+QEhcSS7rp66b1RML7QuCA62TcVgbX1jWfCqL
	 Asx++7oxKTLkFyoTarKCkq1YqlUJA92kq+mY+gRechkEgNflRQiu25oGDYruKKeMez
	 qxjj/4Lnkh86vCOvdAaLvt2LrMeakgCB+eiNY6g57akYW28N6NUCVKHcnz8I1Magr+
	 MqOM9BxhnshD+NLNCZ1Q6j4OBGBQbRE+UN+Pe0Kk5LCthRgC8evSPrpHwD29d0lnbO
	 BQu0dgVhdx/pe+wqeAa0wUWfe2l0/7qQPAWzv+bYpzosCL27PFum59bA98bNKXBQSX
	 dZDuWAK/C/Y2A==
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
Subject: [PATCH v4 07/13] crypto: riscv/sha256 - implement library instead of shash
Date: Mon, 28 Apr 2025 10:00:32 -0700
Message-ID: <20250428170040.423825-8-ebiggers@kernel.org>
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
of the assembly function from int to size_t.  The assembly function
actually already treated it as size_t.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                     |  11 --
 arch/riscv/crypto/Makefile                    |   3 -
 arch/riscv/crypto/sha256-riscv64-glue.c       | 125 ------------------
 arch/riscv/lib/crypto/Kconfig                 |   7 +
 arch/riscv/lib/crypto/Makefile                |   3 +
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    |   4 +-
 arch/riscv/lib/crypto/sha256.c                |  62 +++++++++
 7 files changed, 74 insertions(+), 141 deletions(-)
 delete mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 rename arch/riscv/{ => lib}/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S (98%)
 create mode 100644 arch/riscv/lib/crypto/sha256.c

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 4863be2a4ec2f..cd9b776602f89 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -26,21 +26,10 @@ config CRYPTO_GHASH_RISCV64
 	  GCM GHASH function (NIST SP 800-38D)
 
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
 	select CRYPTO_SHA512
 	help
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 4ae9bf762e907..e10e8257734e3 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -5,13 +5,10 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
-obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
-sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
-
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
 
 obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
 sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh-zvkb.o
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
deleted file mode 100644
index c998300ab8435..0000000000000
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
index bc7a43f33eb3a..c100571feb7e8 100644
--- a/arch/riscv/lib/crypto/Kconfig
+++ b/arch/riscv/lib/crypto/Kconfig
@@ -4,5 +4,12 @@ config CRYPTO_CHACHA_RISCV64
 	tristate
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
+
+config CRYPTO_SHA256_RISCV64
+	tristate
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/riscv/lib/crypto/Makefile b/arch/riscv/lib/crypto/Makefile
index e27b78f317fc8..b7cb877a2c07e 100644
--- a/arch/riscv/lib/crypto/Makefile
+++ b/arch/riscv/lib/crypto/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
+
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
similarity index 98%
rename from arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
rename to arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
index f1f5779e47323..fad501ad06171 100644
--- a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
+++ b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
@@ -104,12 +104,12 @@
 	sha256_4rounds	\last, \k1, W1, W2, W3, W0
 	sha256_4rounds	\last, \k2, W2, W3, W0, W1
 	sha256_4rounds	\last, \k3, W3, W0, W1, W2
 .endm
 
-// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[8], const u8 *data,
-//					       int num_blocks);
+// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[SHA256_STATE_WORDS],
+//					       const u8 *data, size_t nblocks);
 SYM_FUNC_START(sha256_transform_zvknha_or_zvknhb_zvkb)
 
 	// Load the round constants into K0-K15.
 	vsetivli	zero, 4, e32, m1, ta, ma
 	la		t0, K256
diff --git a/arch/riscv/lib/crypto/sha256.c b/arch/riscv/lib/crypto/sha256.c
new file mode 100644
index 0000000000000..18b84030f0b39
--- /dev/null
+++ b/arch/riscv/lib/crypto/sha256.c
@@ -0,0 +1,62 @@
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
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/sha2.h>
+#include <crypto/internal/simd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
+	u32 state[SHA256_STATE_WORDS], const u8 *data, size_t nblocks);
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_extensions);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_extensions) && crypto_simd_usable()) {
+		kernel_vector_begin();
+		sha256_transform_zvknha_or_zvknhb_zvkb(state, data, nblocks);
+		kernel_vector_end();
+	} else {
+		sha256_blocks_generic(state, data, nblocks);
+	}
+}
+EXPORT_SYMBOL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	return static_key_enabled(&have_extensions);
+}
+EXPORT_SYMBOL(sha256_is_arch_optimized);
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
2.49.0


