Return-Path: <linux-arch+bounces-9203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49809DF7D4
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C27162ABB
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2370800;
	Mon,  2 Dec 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRdYtRZ/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AB482CD;
	Mon,  2 Dec 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101772; cv=none; b=r+bUQUWU/TSqtIn/pMkbgK//9wKN1ZRFVxquoU+Ft1m5zAukKKKnZHlCMiHJYTNN+Kcu2OvC1O8416HFYnfE9oUYGRorFmufL0yKzLjm+bha5xld1RUwKy8WeWm/MG0z2YU3mD9AvJhgZqZ2qpR0IsBb/NUk3JqGghcBCYDOJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101772; c=relaxed/simple;
	bh=c+ArA3Pp4JHtlAXp064SAzQdabTy5DgVIAW0CIw9KjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRp1BPOlSpr5Ja4wpAG3nkk1wrA2o2y5aNwlzO+ym38K/X+u0fsnBEw3uRb9TDhxblgmBzPerNodL6+uFIyuYCKw/5ReKOW96k9bSvF+tyZz1FMTN763pWA+tBblr2ZKJJxhWsKfdBVuG/yXClVseucgm54bx+w920ZheUnEek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRdYtRZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E0C4CEDE;
	Mon,  2 Dec 2024 01:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101772;
	bh=c+ArA3Pp4JHtlAXp064SAzQdabTy5DgVIAW0CIw9KjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRdYtRZ/e0XSwefAyWUdL20Ai/m+OdwxINA09y1hCghcDM6Ch970h5TpQK3ky5qaM
	 5VAsaQuxFT4KY5WV8aoxTPrQ5FpVGNcSI3W3dJQSy1qE6fX72hkkCNts4nT2KVyJP9
	 2IWt1DSWF8siStayCpAVf6EA2sCe+1kbUn/cqOtWrG/w2OYWRMRlTQWQdv5aDO7x2V
	 ivwUqDRBmFuuHUeZuEG1qllCDWaWlkAk2OAXyD1w4x0z90Qup/l1a1Zk/UFW3RO5SK
	 iYP0kAIAHtSDBYip8Xz26t7QyASAafBU+TlF5yuE+k270xqQHc9z6Z2mu7IgDr6zDV
	 4XA38notarrgg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 05/19] arm/crc32: expose CRC32 functions through lib
Date: Sun,  1 Dec 2024 17:08:30 -0800
Message-ID: <20241202010844.144356-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
References: <20241202010844.144356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the arm CRC32 assembly code into the lib directory and wire it up
to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/arm/crypto/crc32-ce-glue.c to
arch/arm/lib/crc32-glue.c, view this commit with 'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/Kconfig                              |   1 +
 arch/arm/configs/milbeaut_m10v_defconfig      |   1 -
 arch/arm/configs/multi_v7_defconfig           |   1 -
 arch/arm/crypto/Kconfig                       |  14 -
 arch/arm/crypto/Makefile                      |   2 -
 arch/arm/crypto/crc32-ce-glue.c               | 247 ------------------
 arch/arm/lib/Makefile                         |   3 +
 .../crc32-ce-core.S => lib/crc32-core.S}      |   5 +-
 arch/arm/lib/crc32-glue.c                     | 123 +++++++++
 9 files changed, 129 insertions(+), 268 deletions(-)
 delete mode 100644 arch/arm/crypto/crc32-ce-glue.c
 rename arch/arm/{crypto/crc32-ce-core.S => lib/crc32-core.S} (98%)
 create mode 100644 arch/arm/lib/crc32-glue.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202397be76d8..f817ca317b02 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,10 +5,11 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
+	select ARCH_HAS_CRC32 if KERNEL_MODE_NEON
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_ALLOC if MMU
 	select ARCH_HAS_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index f5eeac9c65c3..acd16204f8d7 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -105,11 +105,10 @@ CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
-CONFIG_CRYPTO_CRC32_ARM_CE=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_ITU_T=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 758276027dbc..9d4336261e45 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1304,11 +1304,10 @@ CONFIG_CRYPTO_SHA2_ARM_CE=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
-CONFIG_CRYPTO_CRC32_ARM_CE=m
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_EXYNOS_RNG=m
 CONFIG_CRYPTO_DEV_S5P=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=m
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 5ff49a5e9afc..ea0ebf336d0d 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -220,24 +220,10 @@ config CRYPTO_CHACHA20_NEON
 	  stream cipher algorithms
 
 	  Architecture: arm using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_CRC32_ARM_CE
-	tristate "CRC32C and CRC32"
-	depends on KERNEL_MODE_NEON
-	depends on CRC32
-	select CRYPTO_HASH
-	help
-	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
-	  and CRC32 CRC algorithm (IEEE 802.3)
-
-	  Architecture: arm using:
-	  - CRC and/or PMULL instructions
-
-	  Drivers: crc32-arm-ce and crc32c-arm-ce
-
 config CRYPTO_CRCT10DIF_ARM_CE
 	tristate "CRCT10DIF"
 	depends on KERNEL_MODE_NEON
 	depends on CRC_T10DIF
 	select CRYPTO_HASH
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 13e62c7c25dc..38ec5cc1e844 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -19,11 +19,10 @@ obj-$(CONFIG_CRYPTO_CURVE25519_NEON) += curve25519-neon.o
 obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_CE) += sha1-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA2_ARM_CE) += sha2-arm-ce.o
 obj-$(CONFIG_CRYPTO_GHASH_ARM_CE) += ghash-arm-ce.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF_ARM_CE) += crct10dif-arm-ce.o
-obj-$(CONFIG_CRYPTO_CRC32_ARM_CE) += crc32-arm-ce.o
 
 aes-arm-y	:= aes-cipher-core.o aes-cipher-glue.o
 aes-arm-bs-y	:= aes-neonbs-core.o aes-neonbs-glue.o
 sha1-arm-y	:= sha1-armv4-large.o sha1_glue.o
 sha1-arm-neon-y	:= sha1-armv7-neon.o sha1_neon_glue.o
@@ -36,11 +35,10 @@ blake2b-neon-y  := blake2b-neon-core.o blake2b-neon-glue.o
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
 sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
 crct10dif-arm-ce-y	:= crct10dif-ce-core.o crct10dif-ce-glue.o
-crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
 chacha-neon-y := chacha-scalar-core.o chacha-glue.o
 chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
 poly1305-arm-y := poly1305-core.o poly1305-glue.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 curve25519-neon-y := curve25519-core.o curve25519-glue.o
diff --git a/arch/arm/crypto/crc32-ce-glue.c b/arch/arm/crypto/crc32-ce-glue.c
deleted file mode 100644
index 20b4dff13e3a..000000000000
--- a/arch/arm/crypto/crc32-ce-glue.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Accelerated CRC32(C) using ARM CRC, NEON and Crypto Extensions instructions
- *
- * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
-#include <linux/cpufeature.h>
-#include <linux/crc32.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-
-#include <asm/hwcap.h>
-#include <asm/neon.h>
-#include <asm/simd.h>
-#include <linux/unaligned.h>
-
-#define PMULL_MIN_LEN		64L	/* minimum size of buffer
-					 * for crc32_pmull_le_16 */
-#define SCALE_F			16L	/* size of NEON register */
-
-asmlinkage u32 crc32_pmull_le(const u8 buf[], u32 len, u32 init_crc);
-asmlinkage u32 crc32_armv8_le(u32 init_crc, const u8 buf[], u32 len);
-
-asmlinkage u32 crc32c_pmull_le(const u8 buf[], u32 len, u32 init_crc);
-asmlinkage u32 crc32c_armv8_le(u32 init_crc, const u8 buf[], u32 len);
-
-static u32 (*fallback_crc32)(u32 init_crc, const u8 buf[], u32 len);
-static u32 (*fallback_crc32c)(u32 init_crc, const u8 buf[], u32 len);
-
-static int crc32_cra_init(struct crypto_tfm *tfm)
-{
-	u32 *key = crypto_tfm_ctx(tfm);
-
-	*key = 0;
-	return 0;
-}
-
-static int crc32c_cra_init(struct crypto_tfm *tfm)
-{
-	u32 *key = crypto_tfm_ctx(tfm);
-
-	*key = ~0;
-	return 0;
-}
-
-static int crc32_setkey(struct crypto_shash *hash, const u8 *key,
-			unsigned int keylen)
-{
-	u32 *mctx = crypto_shash_ctx(hash);
-
-	if (keylen != sizeof(u32))
-		return -EINVAL;
-	*mctx = le32_to_cpup((__le32 *)key);
-	return 0;
-}
-
-static int crc32_init(struct shash_desc *desc)
-{
-	u32 *mctx = crypto_shash_ctx(desc->tfm);
-	u32 *crc = shash_desc_ctx(desc);
-
-	*crc = *mctx;
-	return 0;
-}
-
-static int crc32_update(struct shash_desc *desc, const u8 *data,
-			unsigned int length)
-{
-	u32 *crc = shash_desc_ctx(desc);
-
-	*crc = crc32_armv8_le(*crc, data, length);
-	return 0;
-}
-
-static int crc32c_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	u32 *crc = shash_desc_ctx(desc);
-
-	*crc = crc32c_armv8_le(*crc, data, length);
-	return 0;
-}
-
-static int crc32_final(struct shash_desc *desc, u8 *out)
-{
-	u32 *crc = shash_desc_ctx(desc);
-
-	put_unaligned_le32(*crc, out);
-	return 0;
-}
-
-static int crc32c_final(struct shash_desc *desc, u8 *out)
-{
-	u32 *crc = shash_desc_ctx(desc);
-
-	put_unaligned_le32(~*crc, out);
-	return 0;
-}
-
-static int crc32_pmull_update(struct shash_desc *desc, const u8 *data,
-			      unsigned int length)
-{
-	u32 *crc = shash_desc_ctx(desc);
-	unsigned int l;
-
-	if (crypto_simd_usable()) {
-		if ((u32)data % SCALE_F) {
-			l = min_t(u32, length, SCALE_F - ((u32)data % SCALE_F));
-
-			*crc = fallback_crc32(*crc, data, l);
-
-			data += l;
-			length -= l;
-		}
-
-		if (length >= PMULL_MIN_LEN) {
-			l = round_down(length, SCALE_F);
-
-			kernel_neon_begin();
-			*crc = crc32_pmull_le(data, l, *crc);
-			kernel_neon_end();
-
-			data += l;
-			length -= l;
-		}
-	}
-
-	if (length > 0)
-		*crc = fallback_crc32(*crc, data, length);
-
-	return 0;
-}
-
-static int crc32c_pmull_update(struct shash_desc *desc, const u8 *data,
-			       unsigned int length)
-{
-	u32 *crc = shash_desc_ctx(desc);
-	unsigned int l;
-
-	if (crypto_simd_usable()) {
-		if ((u32)data % SCALE_F) {
-			l = min_t(u32, length, SCALE_F - ((u32)data % SCALE_F));
-
-			*crc = fallback_crc32c(*crc, data, l);
-
-			data += l;
-			length -= l;
-		}
-
-		if (length >= PMULL_MIN_LEN) {
-			l = round_down(length, SCALE_F);
-
-			kernel_neon_begin();
-			*crc = crc32c_pmull_le(data, l, *crc);
-			kernel_neon_end();
-
-			data += l;
-			length -= l;
-		}
-	}
-
-	if (length > 0)
-		*crc = fallback_crc32c(*crc, data, length);
-
-	return 0;
-}
-
-static struct shash_alg crc32_pmull_algs[] = { {
-	.setkey			= crc32_setkey,
-	.init			= crc32_init,
-	.update			= crc32_update,
-	.final			= crc32_final,
-	.descsize		= sizeof(u32),
-	.digestsize		= sizeof(u32),
-
-	.base.cra_ctxsize	= sizeof(u32),
-	.base.cra_init		= crc32_cra_init,
-	.base.cra_name		= "crc32",
-	.base.cra_driver_name	= "crc32-arm-ce",
-	.base.cra_priority	= 200,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= 1,
-	.base.cra_module	= THIS_MODULE,
-}, {
-	.setkey			= crc32_setkey,
-	.init			= crc32_init,
-	.update			= crc32c_update,
-	.final			= crc32c_final,
-	.descsize		= sizeof(u32),
-	.digestsize		= sizeof(u32),
-
-	.base.cra_ctxsize	= sizeof(u32),
-	.base.cra_init		= crc32c_cra_init,
-	.base.cra_name		= "crc32c",
-	.base.cra_driver_name	= "crc32c-arm-ce",
-	.base.cra_priority	= 200,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= 1,
-	.base.cra_module	= THIS_MODULE,
-} };
-
-static int __init crc32_pmull_mod_init(void)
-{
-	if (elf_hwcap2 & HWCAP2_PMULL) {
-		crc32_pmull_algs[0].update = crc32_pmull_update;
-		crc32_pmull_algs[1].update = crc32c_pmull_update;
-
-		if (elf_hwcap2 & HWCAP2_CRC32) {
-			fallback_crc32 = crc32_armv8_le;
-			fallback_crc32c = crc32c_armv8_le;
-		} else {
-			fallback_crc32 = crc32_le;
-			fallback_crc32c = __crc32c_le;
-		}
-	} else if (!(elf_hwcap2 & HWCAP2_CRC32)) {
-		return -ENODEV;
-	}
-
-	return crypto_register_shashes(crc32_pmull_algs,
-				       ARRAY_SIZE(crc32_pmull_algs));
-}
-
-static void __exit crc32_pmull_mod_exit(void)
-{
-	crypto_unregister_shashes(crc32_pmull_algs,
-				  ARRAY_SIZE(crc32_pmull_algs));
-}
-
-static const struct cpu_feature __maybe_unused crc32_cpu_feature[] = {
-	{ cpu_feature(CRC32) }, { cpu_feature(PMULL) }, { }
-};
-MODULE_DEVICE_TABLE(cpu, crc32_cpu_feature);
-
-module_init(crc32_pmull_mod_init);
-module_exit(crc32_pmull_mod_exit);
-
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_DESCRIPTION("Accelerated CRC32(C) using ARM CRC, NEON and Crypto Extensions");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crc32");
-MODULE_ALIAS_CRYPTO("crc32c");
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0ca5aae1bcc3..01cd4db2ed47 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -43,5 +43,8 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
   CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_CRC32_ARCH) += crc32-arm.o
+crc32-arm-y := crc32-glue.o crc32-core.o
diff --git a/arch/arm/crypto/crc32-ce-core.S b/arch/arm/lib/crc32-core.S
similarity index 98%
rename from arch/arm/crypto/crc32-ce-core.S
rename to arch/arm/lib/crc32-core.S
index 88f9edf94e95..6f674f30c70b 100644
--- a/arch/arm/crypto/crc32-ce-core.S
+++ b/arch/arm/lib/crc32-core.S
@@ -46,11 +46,10 @@
  * Authors:   Gregory Prestas <Gregory_Prestas@us.xyratex.com>
  *	      Alexander Boyko <Alexander_Boyko@xyratex.com>
  */
 
 #include <linux/linkage.h>
-#include <linux/cfi_types.h>
 #include <asm/assembler.h>
 
 	.text
 	.align		6
 	.arch		armv8-a
@@ -295,13 +294,13 @@ ARM_BE8(rev16		r3, r3		)
 	bpl		.Laligned8\c
 	b		.Ltail\c
 	.endm
 
 	.align		5
-SYM_TYPED_FUNC_START(crc32_armv8_le)
+SYM_FUNC_START(crc32_armv8_le)
 	__crc32
 SYM_FUNC_END(crc32_armv8_le)
 
 	.align		5
-SYM_TYPED_FUNC_START(crc32c_armv8_le)
+SYM_FUNC_START(crc32c_armv8_le)
 	__crc32		c
 SYM_FUNC_END(crc32c_armv8_le)
diff --git a/arch/arm/lib/crc32-glue.c b/arch/arm/lib/crc32-glue.c
new file mode 100644
index 000000000000..2c30ba3d80e6
--- /dev/null
+++ b/arch/arm/lib/crc32-glue.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Accelerated CRC32(C) using ARM CRC, NEON and Crypto Extensions instructions
+ *
+ * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
+ */
+
+#include <linux/cpufeature.h>
+#include <linux/crc32.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include <crypto/internal/simd.h>
+
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+#include <asm/simd.h>
+
+static DEFINE_STATIC_KEY_FALSE(have_crc32);
+static DEFINE_STATIC_KEY_FALSE(have_pmull);
+
+#define PMULL_MIN_LEN	64	/* min size of buffer for pmull functions */
+
+asmlinkage u32 crc32_pmull_le(const u8 buf[], u32 len, u32 init_crc);
+asmlinkage u32 crc32_armv8_le(u32 init_crc, const u8 buf[], u32 len);
+
+asmlinkage u32 crc32c_pmull_le(const u8 buf[], u32 len, u32 init_crc);
+asmlinkage u32 crc32c_armv8_le(u32 init_crc, const u8 buf[], u32 len);
+
+static u32 crc32_le_scalar(u32 crc, const u8 *p, size_t len)
+{
+	if (static_branch_likely(&have_crc32))
+		return crc32_armv8_le(crc, p, len);
+	return crc32_le_base(crc, p, len);
+}
+
+u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (len >= PMULL_MIN_LEN + 15 &&
+	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+		size_t n = -(uintptr_t)p & 15;
+
+		/* align p to 16-byte boundary */
+		if (n) {
+			crc = crc32_le_scalar(crc, p, n);
+			p += n;
+			len -= n;
+		}
+		n = round_down(len, 16);
+		kernel_neon_begin();
+		crc = crc32_pmull_le(p, n, crc);
+		kernel_neon_end();
+		p += n;
+		len -= n;
+	}
+	return crc32_le_scalar(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_le_arch);
+
+static u32 crc32c_le_scalar(u32 crc, const u8 *p, size_t len)
+{
+	if (static_branch_likely(&have_crc32))
+		return crc32c_armv8_le(crc, p, len);
+	return crc32c_le_base(crc, p, len);
+}
+
+u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (len >= PMULL_MIN_LEN + 15 &&
+	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+		size_t n = -(uintptr_t)p & 15;
+
+		/* align p to 16-byte boundary */
+		if (n) {
+			crc = crc32c_le_scalar(crc, p, n);
+			p += n;
+			len -= n;
+		}
+		n = round_down(len, 16);
+		kernel_neon_begin();
+		crc = crc32c_pmull_le(p, n, crc);
+		kernel_neon_end();
+		p += n;
+		len -= n;
+	}
+	return crc32c_le_scalar(crc, p, len);
+}
+EXPORT_SYMBOL(crc32c_le_arch);
+
+u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
+{
+	return crc32_be_base(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_be_arch);
+
+static int __init crc32_arm_init(void)
+{
+	if (elf_hwcap2 & HWCAP2_CRC32)
+		static_branch_enable(&have_crc32);
+	if (elf_hwcap2 & HWCAP2_PMULL)
+		static_branch_enable(&have_pmull);
+	return 0;
+}
+arch_initcall(crc32_arm_init);
+
+static void __exit crc32_arm_exit(void)
+{
+}
+module_exit(crc32_arm_exit);
+
+u32 crc32_optimizations(void)
+{
+	if (elf_hwcap2 & (HWCAP2_CRC32 | HWCAP2_PMULL))
+		return CRC32_LE_OPTIMIZATION | CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_DESCRIPTION("Accelerated CRC32(C) using ARM CRC, NEON and Crypto Extensions");
+MODULE_LICENSE("GPL v2");
-- 
2.47.1


