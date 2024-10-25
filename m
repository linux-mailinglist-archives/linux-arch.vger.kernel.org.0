Return-Path: <linux-arch+bounces-8559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33B9B0E62
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701EFB232F8
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F52161EC;
	Fri, 25 Oct 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqWQX7ku"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6765215C76;
	Fri, 25 Oct 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883747; cv=none; b=N5bAHHAneABmLNHL5cpRmeCZWgl5MhSYVRtWkPPxCNMRe8bd02myi410e56Ty9q1Zb4uf0vss7imUy6EO27/Ty9oySZx/pa/0UERNjwNzqIxoNh9/rrCuqrYN8SOs8th62Rec1xyR5KIduSCGfQMbZ8sDyq85KMfutGZXsr7jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883747; c=relaxed/simple;
	bh=dB34rez1trxTNuWEOCE9fnblV0mVENKJwWvk8upvfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leA8nxpkzpga7lqamCSQ2lOMt9j2B31NMHSbkyfGXiZKVMVXZ3QOekK29ZFO30U1sY8jy44L8ndCUP660dz7FLStbYPw9NiEVrdAVlF0lWLQaX32mI1BxNU3CJfZaq7rp8j37SbDRt6wuo5n2QGsxE9QZb5zaYwa7i+OnBKAsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqWQX7ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDC0C4CEE6;
	Fri, 25 Oct 2024 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883747;
	bh=dB34rez1trxTNuWEOCE9fnblV0mVENKJwWvk8upvfKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqWQX7kuJ7hdAOKm/CM+5qT+s2WVn5IBNdJp84G8MHIKYl17RgJj+SS5I0T56lv8d
	 VkBAcc62vVBCVm00T7hIlp3aRo5amGIrbM5Q3/IU0LU66lXGKm6Gtxvl3g6W6W63LB
	 7A/UR/cYj9+hB50p2OzS77h6S7ogWnZSrw9TUT8a8c7zmJ8pFhClfmL6YXtdAEzhup
	 Vv0HntwOkRV62sBOSDigzdZ2VS8jTS3B5qaAby9UM8cZL6D6zy7HyV7762eqHHIHSN
	 J/R7zrzlvZttNulBeKGhtMKQM5qOkTDzICH+mSjZw5oiagpqMeW8MnN+K8uTnPIO6i
	 hUB5UK6Fbf/PQ==
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
Subject: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through lib
Date: Fri, 25 Oct 2024 12:14:42 -0700
Message-ID: <20241025191454.72616-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025191454.72616-1-ebiggers@kernel.org>
References: <20241025191454.72616-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the loongarch CRC32 assembly code into the lib directory and wire
it up to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/loongarch/crypto/crc32-loongarch.c to
arch/loongarch/lib/crc32-loongarch.c, view this commit with
'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/loongarch/Kconfig                     |   1 +
 arch/loongarch/configs/loongson3_defconfig |   1 -
 arch/loongarch/crypto/Kconfig              |   9 -
 arch/loongarch/crypto/Makefile             |   2 -
 arch/loongarch/crypto/crc32-loongarch.c    | 300 ---------------------
 arch/loongarch/lib/Makefile                |   2 +
 arch/loongarch/lib/crc32-loongarch.c       | 130 +++++++++
 7 files changed, 133 insertions(+), 312 deletions(-)
 delete mode 100644 arch/loongarch/crypto/crc32-loongarch.c
 create mode 100644 arch/loongarch/lib/crc32-loongarch.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f86d2..455f1af0bf88 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -13,10 +13,11 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
+	select ARCH_HAS_CRC32
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 75b366407a60..0487ac21b38b 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -967,11 +967,10 @@ CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_LZ4HC=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_CRC32_LOONGARCH=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_DMA_CMA=y
 CONFIG_DMA_NUMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
diff --git a/arch/loongarch/crypto/Kconfig b/arch/loongarch/crypto/Kconfig
index 200a6e8b43b1..a0270b3e5b30 100644
--- a/arch/loongarch/crypto/Kconfig
+++ b/arch/loongarch/crypto/Kconfig
@@ -1,14 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (loongarch)"
 
-config CRYPTO_CRC32_LOONGARCH
-	tristate "CRC32c and CRC32"
-	select CRC32
-	select CRYPTO_HASH
-	help
-	  CRC32c and CRC32 CRC algorithms
-
-	  Architecture: LoongArch with CRC32 instructions
-
 endmenu
diff --git a/arch/loongarch/crypto/Makefile b/arch/loongarch/crypto/Makefile
index d22613d27ce9..ba83755dde2b 100644
--- a/arch/loongarch/crypto/Makefile
+++ b/arch/loongarch/crypto/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for LoongArch crypto files..
 #
-
-obj-$(CONFIG_CRYPTO_CRC32_LOONGARCH) += crc32-loongarch.o
diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
deleted file mode 100644
index b7d9782827f5..000000000000
--- a/arch/loongarch/crypto/crc32-loongarch.c
+++ /dev/null
@@ -1,300 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * crc32.c - CRC32 and CRC32C using LoongArch crc* instructions
- *
- * Module based on mips/crypto/crc32-mips.c
- *
- * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
- * Copyright (C) 2018 MIPS Tech, LLC
- * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
- */
-
-#include <linux/module.h>
-#include <crypto/internal/hash.h>
-
-#include <asm/cpu-features.h>
-#include <linux/unaligned.h>
-
-#define _CRC32(crc, value, size, type)			\
-do {							\
-	__asm__ __volatile__(				\
-		#type ".w." #size ".w" " %0, %1, %0\n\t"\
-		: "+r" (crc)				\
-		: "r" (value)				\
-		: "memory");				\
-} while (0)
-
-#define CRC32(crc, value, size)		_CRC32(crc, value, size, crc)
-#define CRC32C(crc, value, size)	_CRC32(crc, value, size, crcc)
-
-static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
-{
-	u32 crc = crc_;
-
-	while (len >= sizeof(u64)) {
-		u64 value = get_unaligned_le64(p);
-
-		CRC32(crc, value, d);
-		p += sizeof(u64);
-		len -= sizeof(u64);
-	}
-
-	if (len & sizeof(u32)) {
-		u32 value = get_unaligned_le32(p);
-
-		CRC32(crc, value, w);
-		p += sizeof(u32);
-	}
-
-	if (len & sizeof(u16)) {
-		u16 value = get_unaligned_le16(p);
-
-		CRC32(crc, value, h);
-		p += sizeof(u16);
-	}
-
-	if (len & sizeof(u8)) {
-		u8 value = *p++;
-
-		CRC32(crc, value, b);
-	}
-
-	return crc;
-}
-
-static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
-{
-	u32 crc = crc_;
-
-	while (len >= sizeof(u64)) {
-		u64 value = get_unaligned_le64(p);
-
-		CRC32C(crc, value, d);
-		p += sizeof(u64);
-		len -= sizeof(u64);
-	}
-
-	if (len & sizeof(u32)) {
-		u32 value = get_unaligned_le32(p);
-
-		CRC32C(crc, value, w);
-		p += sizeof(u32);
-	}
-
-	if (len & sizeof(u16)) {
-		u16 value = get_unaligned_le16(p);
-
-		CRC32C(crc, value, h);
-		p += sizeof(u16);
-	}
-
-	if (len & sizeof(u8)) {
-		u8 value = *p++;
-
-		CRC32C(crc, value, b);
-	}
-
-	return crc;
-}
-
-#define CHKSUM_BLOCK_SIZE	1
-#define CHKSUM_DIGEST_SIZE	4
-
-struct chksum_ctx {
-	u32 key;
-};
-
-struct chksum_desc_ctx {
-	u32 crc;
-};
-
-static int chksum_init(struct shash_desc *desc)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = mctx->key;
-
-	return 0;
-}
-
-/*
- * Setting the seed allows arbitrary accumulators and flexible XOR policy
- * If your algorithm starts with ~0, then XOR with ~0 before you set the seed.
- */
-static int chksum_setkey(struct crypto_shash *tfm, const u8 *key, unsigned int keylen)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(tfm);
-
-	if (keylen != sizeof(mctx->key))
-		return -EINVAL;
-
-	mctx->key = get_unaligned_le32(key);
-
-	return 0;
-}
-
-static int chksum_update(struct shash_desc *desc, const u8 *data, unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = crc32_loongarch_hw(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksumc_update(struct shash_desc *desc, const u8 *data, unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = crc32c_loongarch_hw(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_final(struct shash_desc *desc, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	put_unaligned_le32(ctx->crc, out);
-	return 0;
-}
-
-static int chksumc_final(struct shash_desc *desc, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	put_unaligned_le32(~ctx->crc, out);
-	return 0;
-}
-
-static int __chksum_finup(u32 crc, const u8 *data, unsigned int len, u8 *out)
-{
-	put_unaligned_le32(crc32_loongarch_hw(crc, data, len), out);
-	return 0;
-}
-
-static int __chksumc_finup(u32 crc, const u8 *data, unsigned int len, u8 *out)
-{
-	put_unaligned_le32(~crc32c_loongarch_hw(crc, data, len), out);
-	return 0;
-}
-
-static int chksum_finup(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(ctx->crc, data, len, out);
-}
-
-static int chksumc_finup(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksumc_finup(ctx->crc, data, len, out);
-}
-
-static int chksum_digest(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-
-	return __chksum_finup(mctx->key, data, length, out);
-}
-
-static int chksumc_digest(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-
-	return __chksumc_finup(mctx->key, data, length, out);
-}
-
-static int chksum_cra_init(struct crypto_tfm *tfm)
-{
-	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
-
-	mctx->key = 0;
-	return 0;
-}
-
-static int chksumc_cra_init(struct crypto_tfm *tfm)
-{
-	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
-
-	mctx->key = ~0;
-	return 0;
-}
-
-static struct shash_alg crc32_alg = {
-	.digestsize		=	CHKSUM_DIGEST_SIZE,
-	.setkey			=	chksum_setkey,
-	.init			=	chksum_init,
-	.update			=	chksum_update,
-	.final			=	chksum_final,
-	.finup			=	chksum_finup,
-	.digest			=	chksum_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crc32",
-		.cra_driver_name	=	"crc32-loongarch",
-		.cra_priority		=	300,
-		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		=	sizeof(struct chksum_ctx),
-		.cra_module		=	THIS_MODULE,
-		.cra_init		=	chksum_cra_init,
-	}
-};
-
-static struct shash_alg crc32c_alg = {
-	.digestsize		=	CHKSUM_DIGEST_SIZE,
-	.setkey			=	chksum_setkey,
-	.init			=	chksum_init,
-	.update			=	chksumc_update,
-	.final			=	chksumc_final,
-	.finup			=	chksumc_finup,
-	.digest			=	chksumc_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crc32c",
-		.cra_driver_name	=	"crc32c-loongarch",
-		.cra_priority		=	300,
-		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		=	sizeof(struct chksum_ctx),
-		.cra_module		=	THIS_MODULE,
-		.cra_init		=	chksumc_cra_init,
-	}
-};
-
-static int __init crc32_mod_init(void)
-{
-	int err;
-
-	if (!cpu_has(CPU_FEATURE_CRC32))
-		return 0;
-
-	err = crypto_register_shash(&crc32_alg);
-	if (err)
-		return err;
-
-	err = crypto_register_shash(&crc32c_alg);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static void __exit crc32_mod_exit(void)
-{
-	if (!cpu_has(CPU_FEATURE_CRC32))
-		return;
-
-	crypto_unregister_shash(&crc32_alg);
-	crypto_unregister_shash(&crc32c_alg);
-}
-
-module_init(crc32_mod_init);
-module_exit(crc32_mod_exit);
-
-MODULE_AUTHOR("Min Zhou <zhoumin@loongson.cn>");
-MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
-MODULE_DESCRIPTION("CRC32 and CRC32C using LoongArch crc* instructions");
-MODULE_LICENSE("GPL v2");
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index ccea3bbd4353..fae77809048b 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -9,5 +9,7 @@ lib-y	+= delay.o memset.o memcpy.o memmove.o \
 obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
 
 obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_CRC32_ARCH) += crc32-loongarch.o
diff --git a/arch/loongarch/lib/crc32-loongarch.c b/arch/loongarch/lib/crc32-loongarch.c
new file mode 100644
index 000000000000..aa03e1a7a7e8
--- /dev/null
+++ b/arch/loongarch/lib/crc32-loongarch.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * crc32.c - CRC32 and CRC32C using LoongArch crc* instructions
+ *
+ * Module based on mips/crypto/crc32-mips.c
+ *
+ * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
+ * Copyright (C) 2018 MIPS Tech, LLC
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <asm/cpu-features.h>
+#include <linux/crc32.h>
+#include <linux/module.h>
+#include <linux/unaligned.h>
+
+#define _CRC32(crc, value, size, type)			\
+do {							\
+	__asm__ __volatile__(				\
+		#type ".w." #size ".w" " %0, %1, %0\n\t"\
+		: "+r" (crc)				\
+		: "r" (value)				\
+		: "memory");				\
+} while (0)
+
+#define CRC32(crc, value, size)		_CRC32(crc, value, size, crc)
+#define CRC32C(crc, value, size)	_CRC32(crc, value, size, crcc)
+
+static DEFINE_STATIC_KEY_FALSE(have_crc32);
+
+u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (!static_branch_likely(&have_crc32))
+		return crc32_le_base(crc, p, len);
+
+	while (len >= sizeof(u64)) {
+		u64 value = get_unaligned_le64(p);
+
+		CRC32(crc, value, d);
+		p += sizeof(u64);
+		len -= sizeof(u64);
+	}
+
+	if (len & sizeof(u32)) {
+		u32 value = get_unaligned_le32(p);
+
+		CRC32(crc, value, w);
+		p += sizeof(u32);
+	}
+
+	if (len & sizeof(u16)) {
+		u16 value = get_unaligned_le16(p);
+
+		CRC32(crc, value, h);
+		p += sizeof(u16);
+	}
+
+	if (len & sizeof(u8)) {
+		u8 value = *p++;
+
+		CRC32(crc, value, b);
+	}
+
+	return crc;
+}
+EXPORT_SYMBOL(crc32_le_arch);
+
+u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (!static_branch_likely(&have_crc32))
+		return crc32c_le_base(crc, p, len);
+
+	while (len >= sizeof(u64)) {
+		u64 value = get_unaligned_le64(p);
+
+		CRC32C(crc, value, d);
+		p += sizeof(u64);
+		len -= sizeof(u64);
+	}
+
+	if (len & sizeof(u32)) {
+		u32 value = get_unaligned_le32(p);
+
+		CRC32C(crc, value, w);
+		p += sizeof(u32);
+	}
+
+	if (len & sizeof(u16)) {
+		u16 value = get_unaligned_le16(p);
+
+		CRC32C(crc, value, h);
+		p += sizeof(u16);
+	}
+
+	if (len & sizeof(u8)) {
+		u8 value = *p++;
+
+		CRC32C(crc, value, b);
+	}
+
+	return crc;
+}
+EXPORT_SYMBOL(crc32c_le_arch);
+
+u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
+{
+	return crc32_be_base(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_be_arch);
+
+static int __init crc32_loongarch_init(void)
+{
+	if (cpu_has(CPU_FEATURE_CRC32)) {
+		static_branch_enable(&have_crc32);
+		crc32_optimizations = CRC32_LE_OPTIMIZATION |
+				      CRC32C_OPTIMIZATION;
+	}
+	return 0;
+}
+arch_initcall(crc32_loongarch_init);
+
+static void __exit crc32_loongarch_exit(void)
+{
+}
+module_exit(crc32_loongarch_exit);
+
+MODULE_AUTHOR("Min Zhou <zhoumin@loongson.cn>");
+MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
+MODULE_DESCRIPTION("CRC32 and CRC32C using LoongArch crc* instructions");
+MODULE_LICENSE("GPL v2");
-- 
2.47.0


