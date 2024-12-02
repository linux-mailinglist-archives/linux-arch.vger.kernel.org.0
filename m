Return-Path: <linux-arch+bounces-9223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3809DF871
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AAD281464
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D796376F1;
	Mon,  2 Dec 2024 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb/WtWYt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA32EAE4;
	Mon,  2 Dec 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102491; cv=none; b=hN2RqIE8IeEYMkZWShRL55e8OSnFwo+ZB2oAKGzcT+nWsL7ksTDo5649hXOXpwbSqe26EUMbPKGbJY7shc4hj0zwOIVntN5idlRZi7/1yphiCEc9uVHB7yArkq9qoyXTGfGbS8KZR/ZcXhsekCe+3uCtuW/bcR223n1189973DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102491; c=relaxed/simple;
	bh=DBCZBKy5Xl57+NGINhjIrOhgQNsT8ZZWQ/xJmC6dxmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX3BYoAtPHTgGvJFJwSEZzspJw7EukX6gMHRalre07Vvvq68G6XSBLnPm0KhFBb9Mv9LvUWGqEBTkMi55CwVrTBOj96rWtP7UyNJHuOoP7trvGR1S67QW2tuhkSetT9xsIsWTpnLeXTb6xCVXmF4am7U0ZHTXIBXmsDLmAwAtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb/WtWYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CAAC4CEE2;
	Mon,  2 Dec 2024 01:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733102490;
	bh=DBCZBKy5Xl57+NGINhjIrOhgQNsT8ZZWQ/xJmC6dxmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lb/WtWYtV7IfGAQh/T9cs4NLshbxZA1ntyfvceEtOWaStAzMgSfK2PXjuab6RTd/T
	 mYc8q4z5m9zMNX/8V4S9rjXnT99604OvM1Sl4R+rZnqw6oxHWv8P+iWzMVzLJPH47z
	 HB1bJnm82BjPoSzauIka55ES1I5NIxyBwims7V5xfSlMwyx/JXbBAG8jiLBF6pgcZS
	 PyJ6Te98iPGo6zOTZDz2OvMYZit6PA9+59jqGNIxuO+xbnEN5oW8zWHYrxD7Rvf1OA
	 4J0sfOZDigemZGH+X/92c5mjQZ6hMKhl+XRgzNIkdoDVX+h3Km/6QpiBnVu9CeMH0Y
	 NG1kZynFOmbZQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 05/12] arm/crc-t10dif: expose CRC-T10DIF function through lib
Date: Sun,  1 Dec 2024 17:20:49 -0800
Message-ID: <20241202012056.209768-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202012056.209768-1-ebiggers@kernel.org>
References: <20241202012056.209768-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the arm CRC-T10DIF assembly code into the lib directory and wire it
up to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/arm/crypto/crct10dif-ce-glue.c to
arch/arm/lib/crc-t10dif-glue.c, view this commit with 'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/Kconfig                              |   1 +
 arch/arm/crypto/Kconfig                       |  11 --
 arch/arm/crypto/Makefile                      |   2 -
 arch/arm/crypto/crct10dif-ce-glue.c           | 124 ------------------
 arch/arm/lib/Makefile                         |   3 +
 .../crc-t10dif-core.S}                        |   0
 arch/arm/lib/crc-t10dif-glue.c                |  80 +++++++++++
 7 files changed, 84 insertions(+), 137 deletions(-)
 delete mode 100644 arch/arm/crypto/crct10dif-ce-glue.c
 rename arch/arm/{crypto/crct10dif-ce-core.S => lib/crc-t10dif-core.S} (100%)
 create mode 100644 arch/arm/lib/crc-t10dif-glue.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f817ca317b02..3ad4c3c97918 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -6,10 +6,11 @@ config ARM
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CRC32 if KERNEL_MODE_NEON
+	select ARCH_HAS_CRC_T10DIF if KERNEL_MODE_NEON
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_ALLOC if MMU
 	select ARCH_HAS_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index ea0ebf336d0d..32650c8431d9 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -220,18 +220,7 @@ config CRYPTO_CHACHA20_NEON
 	  stream cipher algorithms
 
 	  Architecture: arm using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_CRCT10DIF_ARM_CE
-	tristate "CRCT10DIF"
-	depends on KERNEL_MODE_NEON
-	depends on CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
-
-	  Architecture: arm using:
-	  - PMULL (Polynomial Multiply Long) instructions
-
 endmenu
 
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 38ec5cc1e844..3d0e23ff9e74 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -18,11 +18,10 @@ obj-$(CONFIG_CRYPTO_CURVE25519_NEON) += curve25519-neon.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_CE) += sha1-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA2_ARM_CE) += sha2-arm-ce.o
 obj-$(CONFIG_CRYPTO_GHASH_ARM_CE) += ghash-arm-ce.o
-obj-$(CONFIG_CRYPTO_CRCT10DIF_ARM_CE) += crct10dif-arm-ce.o
 
 aes-arm-y	:= aes-cipher-core.o aes-cipher-glue.o
 aes-arm-bs-y	:= aes-neonbs-core.o aes-neonbs-glue.o
 sha1-arm-y	:= sha1-armv4-large.o sha1_glue.o
 sha1-arm-neon-y	:= sha1-armv7-neon.o sha1_neon_glue.o
@@ -34,11 +33,10 @@ libblake2s-arm-y:= blake2s-core.o blake2s-glue.o
 blake2b-neon-y  := blake2b-neon-core.o blake2b-neon-glue.o
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
 sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
-crct10dif-arm-ce-y	:= crct10dif-ce-core.o crct10dif-ce-glue.o
 chacha-neon-y := chacha-scalar-core.o chacha-glue.o
 chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
 poly1305-arm-y := poly1305-core.o poly1305-glue.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 curve25519-neon-y := curve25519-core.o curve25519-glue.o
diff --git a/arch/arm/crypto/crct10dif-ce-glue.c b/arch/arm/crypto/crct10dif-ce-glue.c
deleted file mode 100644
index a8b74523729e..000000000000
--- a/arch/arm/crypto/crct10dif-ce-glue.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions instructions
- *
- * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
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
-asmlinkage u16 crc_t10dif_pmull64(u16 init_crc, const u8 *buf, size_t len);
-asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
-				  u8 out[16]);
-
-static int crct10dif_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_update_ce(struct shash_desc *desc, const u8 *data,
-			       unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
-		kernel_neon_begin();
-		*crc = crc_t10dif_pmull64(*crc, data, length);
-		kernel_neon_end();
-	} else {
-		*crc = crc_t10dif_generic(*crc, data, length);
-	}
-
-	return 0;
-}
-
-static int crct10dif_update_neon(struct shash_desc *desc, const u8 *data,
-			         unsigned int length)
-{
-	u16 *crcp = shash_desc_ctx(desc);
-	u8 buf[16] __aligned(16);
-	u16 crc = *crcp;
-
-	if (length > CRC_T10DIF_PMULL_CHUNK_SIZE && crypto_simd_usable()) {
-		kernel_neon_begin();
-		crc_t10dif_pmull8(crc, data, length, buf);
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
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
-}
-
-static struct shash_alg algs[] = {{
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update_neon,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm-neon",
-	.base.cra_priority	= 150,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}, {
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update_ce,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-}};
-
-static int __init crc_t10dif_mod_init(void)
-{
-	if (!(elf_hwcap & HWCAP_NEON))
-		return -ENODEV;
-
-	return crypto_register_shashes(algs, 1 + !!(elf_hwcap2 & HWCAP2_PMULL));
-}
-
-static void __exit crc_t10dif_mod_exit(void)
-{
-	crypto_unregister_shashes(algs, 1 + !!(elf_hwcap2 & HWCAP2_PMULL));
-}
-
-module_init(crc_t10dif_mod_init);
-module_exit(crc_t10dif_mod_exit);
-
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_DESCRIPTION("Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 01cd4db2ed47..007874320937 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -46,5 +46,8 @@ endif
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-arm.o
 crc32-arm-y := crc32-glue.o crc32-core.o
+
+obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-arm.o
+crc-t10dif-arm-y := crc-t10dif-glue.o crc-t10dif-core.o
diff --git a/arch/arm/crypto/crct10dif-ce-core.S b/arch/arm/lib/crc-t10dif-core.S
similarity index 100%
rename from arch/arm/crypto/crct10dif-ce-core.S
rename to arch/arm/lib/crc-t10dif-core.S
diff --git a/arch/arm/lib/crc-t10dif-glue.c b/arch/arm/lib/crc-t10dif-glue.c
new file mode 100644
index 000000000000..d24dee62670e
--- /dev/null
+++ b/arch/arm/lib/crc-t10dif-glue.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions instructions
+ *
+ * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
+ */
+
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
+static DEFINE_STATIC_KEY_FALSE(have_neon);
+static DEFINE_STATIC_KEY_FALSE(have_pmull);
+
+#define CRC_T10DIF_PMULL_CHUNK_SIZE	16U
+
+asmlinkage u16 crc_t10dif_pmull64(u16 init_crc, const u8 *buf, size_t len);
+asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
+				  u8 out[16]);
+
+u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
+{
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
+		if (static_branch_likely(&have_pmull)) {
+			if (crypto_simd_usable()) {
+				kernel_neon_begin();
+				crc = crc_t10dif_pmull64(crc, data, length);
+				kernel_neon_end();
+				return crc;
+			}
+		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
+			   static_branch_likely(&have_neon) &&
+			   crypto_simd_usable()) {
+			u8 buf[16] __aligned(16);
+
+			kernel_neon_begin();
+			crc_t10dif_pmull8(crc, data, length, buf);
+			kernel_neon_end();
+
+			crc = 0;
+			data = buf;
+			length = sizeof(buf);
+		}
+	}
+	return crc_t10dif_generic(crc, data, length);
+}
+EXPORT_SYMBOL(crc_t10dif_arch);
+
+static int __init crc_t10dif_arm_init(void)
+{
+	if (elf_hwcap & HWCAP_NEON) {
+		static_branch_enable(&have_neon);
+		if (elf_hwcap2 & HWCAP2_PMULL)
+			static_branch_enable(&have_pmull);
+	}
+	return 0;
+}
+arch_initcall(crc_t10dif_arm_init);
+
+static void __exit crc_t10dif_arm_exit(void)
+{
+}
+module_exit(crc_t10dif_arm_exit);
+
+bool crc_t10dif_is_optimized(void)
+{
+	return static_key_enabled(&have_neon);
+}
+EXPORT_SYMBOL(crc_t10dif_is_optimized);
+
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_DESCRIPTION("Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions");
+MODULE_LICENSE("GPL v2");
-- 
2.47.1


