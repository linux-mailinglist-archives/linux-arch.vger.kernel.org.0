Return-Path: <linux-arch+bounces-9119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997669D01A1
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D6D1F2278E
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B01F5FA;
	Sun, 17 Nov 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9o5GmY+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0291DFDE;
	Sun, 17 Nov 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803036; cv=none; b=eZISOOPt/4s9GCjo9YYtIhyoYb2JubRdTDv+xOspAZq06bBEA0xNovCIpeajoYD2qm9JNl5T6arkiPkX2SprXfKG0+pFeInwm0iW2YGHOEK8LjpJ9+UAcFX5pi32RRjNEcy7+15zeyPSa0Krug08Oe1mTg9XG+ThIfXa7peeTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803036; c=relaxed/simple;
	bh=WxUhYnP1fx0cGeoy+OGHDs01GlaiqwZIcvRWEbAyWeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZzDzIvOT+/u6ns3UWYqReK1y+jf3i2zllwPDgVzYoJY5ZXhs510nH1w5BcR+kyJizyQ4BtdxIaMZxq5dnISLwQeWpQJWrVI8JXksyQ83mLhoK9yq0qmpyKT/GC8yC+xwPtfvGO6jisS9uQBxrZ+PkRwKdwLCfJlh6gAwi/P3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9o5GmY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE23C4CED7;
	Sun, 17 Nov 2024 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803036;
	bh=WxUhYnP1fx0cGeoy+OGHDs01GlaiqwZIcvRWEbAyWeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9o5GmY+34Ohxwq3v/3m8iIIBd0VOiuDairRoTYO8XVbdHG/H4vucvO/JboNkFZwZ
	 Z4HgmywYB3qspA6mvIsnPKbZugBj9qczi1Gzf6hYCbn1sGcAnuSgvh266J0BYcXx/O
	 P47n9PP/l4Q+AXh2O7o+LPlBOIqEPG9wB1zeELKFMHwomj+MJmEIlVO2mmUA84fTpK
	 FOWn3BTEJjm2esi7YM35N4UuM1NmzG4cuEE35ZoMkmfqW2Eu1qoRcp4trKwr4pb/2a
	 mYfx5AXpkwt5aABotk+f/65AoIICu2N5seykhLl/g4AXvq7yhwHXPuZbbJSLpp8v1r
	 OVKC0YrhyjCMQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 06/11] arm64/crc-t10dif: expose CRC-T10DIF function through lib
Date: Sat, 16 Nov 2024 16:22:39 -0800
Message-ID: <20241117002244.105200-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the arm64 CRC-T10DIF assembly code into the lib directory and wire
it up to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/arm64/crypto/crct10dif-ce-glue.c to
arch/arm64/lib/crc-t10dif-glue.c, view this commit with 'git show -M10'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/configs/defconfig                  |   1 -
 arch/arm64/crypto/Kconfig                     |  10 --
 arch/arm64/crypto/Makefile                    |   3 -
 arch/arm64/crypto/crct10dif-ce-glue.c         | 132 ------------------
 arch/arm64/lib/Makefile                       |   3 +
 .../crc-t10dif-core.S}                        |   0
 arch/arm64/lib/crc-t10dif-glue.c              |  78 +++++++++++
 .../testing/selftests/arm64/fp/kernel-test.c  |   3 +-
 9 files changed, 83 insertions(+), 148 deletions(-)
 delete mode 100644 arch/arm64/crypto/crct10dif-ce-glue.c
 rename arch/arm64/{crypto/crct10dif-ce-core.S => lib/crc-t10dif-core.S} (100%)
 create mode 100644 arch/arm64/lib/crc-t10dif-glue.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1e48f40f654e..44cdc7ccbc67 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,10 +20,11 @@ config ARM64
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CRC32
+	select ARCH_HAS_CRC_T10DIF if KERNEL_MODE_NEON
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_OPS if XEN
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..5688fc4ec6e9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1689,11 +1689,10 @@ CONFIG_CRYPTO_SHA512_ARM64_CE=m
 CONFIG_CRYPTO_SHA3_ARM64=m
 CONFIG_CRYPTO_SM3_ARM64_CE=m
 CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_AES_ARM64_BS=m
 CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
-CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
 CONFIG_CRYPTO_DEV_SUN8I_CE=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index e7d9bd8e4709..5636ab83f22a 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -310,17 +310,7 @@ config CRYPTO_SM4_ARM64_CE_GCM
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
 	  - PMULL (Polynomial Multiply Long) instructions
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_CRCT10DIF_ARM64_CE
-	tristate "CRCT10DIF (PMULL)"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
-
-	  Architecture: arm64 using
-	  - PMULL (Polynomial Multiply Long) instructions
-
 endmenu
 
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index fbe64dce66e0..e7139c4768ce 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -42,13 +42,10 @@ obj-$(CONFIG_CRYPTO_GHASH_ARM64_CE) += ghash-ce.o
 ghash-ce-y := ghash-ce-glue.o ghash-ce-core.o
 
 obj-$(CONFIG_CRYPTO_POLYVAL_ARM64_CE) += polyval-ce.o
 polyval-ce-y := polyval-ce-glue.o polyval-ce-core.o
 
-obj-$(CONFIG_CRYPTO_CRCT10DIF_ARM64_CE) += crct10dif-ce.o
-crct10dif-ce-y := crct10dif-ce-core.o crct10dif-ce-glue.o
-
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE) += aes-ce-cipher.o
 aes-ce-cipher-y := aes-ce-core.o aes-ce-glue.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_CE_CCM) += aes-ce-ccm.o
 aes-ce-ccm-y := aes-ce-ccm-glue.o aes-ce-ccm-core.o
diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
deleted file mode 100644
index 08bcbd884395..000000000000
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ /dev/null
@@ -1,132 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Accelerated CRC-T10DIF using arm64 NEON and Crypto Extensions instructions
- *
- * Copyright (C) 2016 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
-#include <linux/cpufeature.h>
-#include <linux/crc-t10dif.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-
-#include <asm/neon.h>
-#include <asm/simd.h>
-
-#define CRC_T10DIF_PMULL_CHUNK_SIZE	16U
-
-asmlinkage void crc_t10dif_pmull_p8(u16 init_crc, const u8 *buf, size_t len,
-				    u8 out[16]);
-asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
-
-static int crct10dif_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_update_pmull_p8(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crcp = shash_desc_ctx(desc);
-	u16 crc = *crcp;
-	u8 buf[16];
-
-	if (length > CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
-		kernel_neon_begin();
-		crc_t10dif_pmull_p8(crc, data, length, buf);
-		kernel_neon_end();
-
-		crc = 0;
-		data = buf;
-		length = sizeof(buf);
-	}
-
-	*crcp = crc_t10dif_generic(crc, data, length);
-	return 0;
-}
-
-static int crct10dif_update_pmull_p64(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
-		kernel_neon_begin();
-		*crc = crc_t10dif_pmull_p64(*crc, data, length);
-		kernel_neon_end();
-	} else {
-		*crc = crc_t10dif_generic(*crc, data, length);
-	}
-
-	return 0;
-}
-
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
-}
-
-static struct shash_alg crc_t10dif_alg[] = {{
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update_pmull_p8,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm64-neon",
-	.base.cra_priority	= 150,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}, {
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update_pmull_p64,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm64-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}};
-
-static int __init crc_t10dif_mod_init(void)
-{
-	if (cpu_have_named_feature(PMULL))
-		return crypto_register_shashes(crc_t10dif_alg,
-					       ARRAY_SIZE(crc_t10dif_alg));
-	else
-		/* only register the first array element */
-		return crypto_register_shash(crc_t10dif_alg);
-}
-
-static void __exit crc_t10dif_mod_exit(void)
-{
-	if (cpu_have_named_feature(PMULL))
-		crypto_unregister_shashes(crc_t10dif_alg,
-					  ARRAY_SIZE(crc_t10dif_alg));
-	else
-		crypto_unregister_shash(crc_t10dif_alg);
-}
-
-module_cpu_feature_match(ASIMD, crc_t10dif_mod_init);
-module_exit(crc_t10dif_mod_exit);
-
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_DESCRIPTION("CRC-T10DIF using arm64 NEON and Crypto Extensions");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-arm64-ce");
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 5fbcf0d56665..4d49dff721a8 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -14,10 +14,13 @@ endif
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-arm64.o
 crc32-arm64-y := crc32.o crc32-glue.o
 
+obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-arm64.o
+crc-t10dif-arm64-y := crc-t10dif-glue.o crc-t10dif-core.o
+
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_ARM64_MTE) += mte.o
 
 obj-$(CONFIG_KASAN_SW_TAGS) += kasan_sw_tags.o
diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/lib/crc-t10dif-core.S
similarity index 100%
rename from arch/arm64/crypto/crct10dif-ce-core.S
rename to arch/arm64/lib/crc-t10dif-core.S
diff --git a/arch/arm64/lib/crc-t10dif-glue.c b/arch/arm64/lib/crc-t10dif-glue.c
new file mode 100644
index 000000000000..99058749db67
--- /dev/null
+++ b/arch/arm64/lib/crc-t10dif-glue.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Accelerated CRC-T10DIF using arm64 NEON and Crypto Extensions instructions
+ *
+ * Copyright (C) 2016 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
+ */
+
+#include <linux/cpufeature.h>
+#include <linux/crc-t10dif.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include <crypto/internal/simd.h>
+
+#include <asm/neon.h>
+#include <asm/simd.h>
+
+static DEFINE_STATIC_KEY_FALSE(have_asimd);
+static DEFINE_STATIC_KEY_FALSE(have_pmull);
+
+#define CRC_T10DIF_PMULL_CHUNK_SIZE	16U
+
+asmlinkage void crc_t10dif_pmull_p8(u16 init_crc, const u8 *buf, size_t len,
+				    u8 out[16]);
+asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
+
+u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
+{
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE &&
+	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+		kernel_neon_begin();
+		crc = crc_t10dif_pmull_p64(crc, data, length);
+		kernel_neon_end();
+		return crc;
+	}
+	if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
+	    static_branch_likely(&have_asimd) && crypto_simd_usable()) {
+		u8 buf[16];
+
+		kernel_neon_begin();
+		crc_t10dif_pmull_p8(crc, data, length, buf);
+		kernel_neon_end();
+
+		crc = 0;
+		data = buf;
+		length = sizeof(buf);
+	}
+	return crc_t10dif_generic(crc, data, length);
+}
+EXPORT_SYMBOL(crc_t10dif_arch);
+
+static int __init crc_t10dif_arm64_init(void)
+{
+	if (cpu_have_named_feature(ASIMD)) {
+		static_branch_enable(&have_asimd);
+		if (cpu_have_named_feature(PMULL))
+			static_branch_enable(&have_pmull);
+	}
+	return 0;
+}
+arch_initcall(crc_t10dif_arm64_init);
+
+static void __exit crc_t10dif_arm64_exit(void)
+{
+}
+module_exit(crc_t10dif_arm64_exit);
+
+bool crc_t10dif_is_optimized(void)
+{
+	return static_key_enabled(&have_asimd);
+}
+EXPORT_SYMBOL(crc_t10dif_is_optimized);
+
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_DESCRIPTION("CRC-T10DIF using arm64 NEON and Crypto Extensions");
+MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
index e8da3b4cbd23..9d4c5cc5ae7e 100644
--- a/tools/testing/selftests/arm64/fp/kernel-test.c
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -44,12 +44,11 @@ static void handle_kick_signal(int sig, siginfo_t *info, void *context)
 {
 	sigs++;
 }
 
 static char *drivers[] = {
-	"crct10dif-arm64-ce",
-	/* "crct10dif-arm64-neon", - Same priority as generic */
+	"crct10dif-arm64",
 	"sha1-ce",
 	"sha224-arm64",
 	"sha224-arm64-neon",
 	"sha224-ce",
 	"sha256-arm64",
-- 
2.47.0


