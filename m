Return-Path: <linux-arch+bounces-8815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B39BA8DA
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 23:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5764D1F21BB8
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626111AAE28;
	Sun,  3 Nov 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1i2jBBa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB71AA792;
	Sun,  3 Nov 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673148; cv=none; b=AaNcIJ3yWU321GkZr9Po6VYkvne/ZHqYwCjlFgptw7ta9//QrRKTbCaeJqAyabloy0WyKXXpPwp5EKJEhJwN2r2owSjVogZvPKmIQaLMk7Bxup6RPrk/btf34Wc64cXQJmeEaO4endm5OvM8KQZuJtM6hwp/t4KGWeisxelWenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673148; c=relaxed/simple;
	bh=srZaNiGZ8gMoQFPqdEH2dAlb++rURb+TdhBd5TFMA40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF/8YKyiu8mjHiQJympYmYkSEZ2bW2SjtQkIN8WVKVI5AKeaPnE+Jy4ANP8dXgWZF+JCPtKfpZ+X5XVv6K0fedI/xCP5qoDmKC5B6Ul9wLHgnK8sXh+v2ynSqYuIf7H/DbbGsQXUQC7ukbJJQE05mkzZ1ifQuCjAbGXuknU449A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1i2jBBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE18C4CED4;
	Sun,  3 Nov 2024 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730673148;
	bh=srZaNiGZ8gMoQFPqdEH2dAlb++rURb+TdhBd5TFMA40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1i2jBBaTfB4N5ChgcdHalKuIUTTPdkUr08K5qesOFmTJcS2yTC+5x78uXSSKEwv1
	 8Es1MHqzCn23bxTYo360exE1QaH8Uf1WP2/gPffL0PoxBc1cGxXMlMQwGsO08uzaQ6
	 wdQyYMCryJEy9WzsP6+muxt1WVDkKzFwRjnHkfd1paJ4SNDDvu/4eX059n7CaW79uS
	 BAZX44Fuhs5A+20G6Jhe1cyBxL2S8b0ajUBl+Ylw+627OgWFl5dmoo8Ru54Uy2NwOy
	 IpSnQ75RJw6VEYaq6nfMR1h85uum+A5NfY/8dzP2AlZJrNWNO5qmPz+FIkPtRCgSRw
	 9rTk1VMi0zXBg==
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
Subject: [PATCH v3 07/18] mips/crc32: expose CRC32 functions through lib
Date: Sun,  3 Nov 2024 14:31:43 -0800
Message-ID: <20241103223154.136127-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103223154.136127-1-ebiggers@kernel.org>
References: <20241103223154.136127-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the mips CRC32 assembly code into the lib directory and wire it up
to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/mips/crypto/crc32-mips.c to
arch/mips/lib/crc32-mips.c, view this commit with 'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/mips/Kconfig                     |   5 +-
 arch/mips/configs/eyeq5_defconfig     |   1 -
 arch/mips/configs/eyeq6_defconfig     |   1 -
 arch/mips/configs/generic/32r6.config |   2 -
 arch/mips/configs/generic/64r6.config |   1 -
 arch/mips/crypto/Kconfig              |   9 -
 arch/mips/crypto/Makefile             |   2 -
 arch/mips/crypto/crc32-mips.c         | 354 --------------------------
 arch/mips/lib/Makefile                |   2 +
 arch/mips/lib/crc32-mips.c            | 192 ++++++++++++++
 10 files changed, 195 insertions(+), 374 deletions(-)
 delete mode 100644 arch/mips/crypto/crc32-mips.c
 create mode 100644 arch/mips/lib/crc32-mips.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 397edf05dd72..f80ea80d792f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1993,15 +1993,15 @@ config CPU_MIPSR5
 	select MIPS_SPRAM
 
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+	select ARCH_HAS_CRC32
 	select CPU_HAS_RIXI
 	select CPU_HAS_DIEI if !CPU_DIEI_BROKEN
 	select HAVE_ARCH_BITREVERSE
 	select MIPS_ASID_BITS_VARIABLE
-	select MIPS_CRC_SUPPORT
 	select MIPS_SPRAM
 
 config TARGET_ISA_REV
 	int
 	default 1 if CPU_MIPSR1
@@ -2473,13 +2473,10 @@ config MIPS_ASID_BITS
 	default 8
 
 config MIPS_ASID_BITS_VARIABLE
 	bool
 
-config MIPS_CRC_SUPPORT
-	bool
-
 # R4600 erratum.  Due to the lack of errata information the exact
 # technical details aren't known.  I've experimentally found that disabling
 # interrupts during indexed I-cache flushes seems to be sufficient to deal
 # with the issue.
 config WAR_R4600_V1_INDEX_ICACHEOP
diff --git a/arch/mips/configs/eyeq5_defconfig b/arch/mips/configs/eyeq5_defconfig
index ae9a09b16e40..ff7af5dc6d9d 100644
--- a/arch/mips/configs/eyeq5_defconfig
+++ b/arch/mips/configs/eyeq5_defconfig
@@ -97,11 +97,10 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRYPTO_CRC32_MIPS=y
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_FS=y
 # CONFIG_RCU_TRACE is not set
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/eyeq6_defconfig b/arch/mips/configs/eyeq6_defconfig
index 6597d5e88b33..0afbb45a78e8 100644
--- a/arch/mips/configs/eyeq6_defconfig
+++ b/arch/mips/configs/eyeq6_defconfig
@@ -100,11 +100,10 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRYPTO_CRC32_MIPS=y
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_FS=y
 # CONFIG_RCU_TRACE is not set
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/generic/32r6.config b/arch/mips/configs/generic/32r6.config
index 1a5d5ea4ab2b..ca606e71f4d0 100644
--- a/arch/mips/configs/generic/32r6.config
+++ b/arch/mips/configs/generic/32r6.config
@@ -1,4 +1,2 @@
 CONFIG_CPU_MIPS32_R6=y
 CONFIG_HIGHMEM=y
-
-CONFIG_CRYPTO_CRC32_MIPS=y
diff --git a/arch/mips/configs/generic/64r6.config b/arch/mips/configs/generic/64r6.config
index 63b4e95f303d..23a300914957 100644
--- a/arch/mips/configs/generic/64r6.config
+++ b/arch/mips/configs/generic/64r6.config
@@ -2,7 +2,6 @@ CONFIG_CPU_MIPS64_R6=y
 CONFIG_64BIT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 
 CONFIG_CPU_HAS_MSA=y
-CONFIG_CRYPTO_CRC32_MIPS=y
 CONFIG_VIRTUALIZATION=y
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 9003a5c1e879..7decd40c4e20 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -1,18 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (mips)"
 
-config CRYPTO_CRC32_MIPS
-	tristate "CRC32c and CRC32"
-	depends on MIPS_CRC_SUPPORT
-	select CRYPTO_HASH
-	help
-	  CRC32c and CRC32 CRC algorithms
-
-	  Architecture: mips
-
 config CRYPTO_POLY1305_MIPS
 	tristate "Hash functions: Poly1305"
 	depends on MIPS
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
diff --git a/arch/mips/crypto/Makefile b/arch/mips/crypto/Makefile
index 5e4105cccf9f..fddc88281412 100644
--- a/arch/mips/crypto/Makefile
+++ b/arch/mips/crypto/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for MIPS crypto files..
 #
 
-obj-$(CONFIG_CRYPTO_CRC32_MIPS) += crc32-mips.o
-
 obj-$(CONFIG_CRYPTO_CHACHA_MIPS) += chacha-mips.o
 chacha-mips-y := chacha-core.o chacha-glue.o
 AFLAGS_chacha-core.o += -O2 # needed to fill branch delay slots
 
 obj-$(CONFIG_CRYPTO_POLY1305_MIPS) += poly1305-mips.o
diff --git a/arch/mips/crypto/crc32-mips.c b/arch/mips/crypto/crc32-mips.c
deleted file mode 100644
index 90eacf00cfc3..000000000000
--- a/arch/mips/crypto/crc32-mips.c
+++ /dev/null
@@ -1,354 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * crc32-mips.c - CRC32 and CRC32C using optional MIPSr6 instructions
- *
- * Module based on arm64/crypto/crc32-arm.c
- *
- * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
- * Copyright (C) 2018 MIPS Tech, LLC
- */
-
-#include <linux/cpufeature.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <asm/mipsregs.h>
-#include <linux/unaligned.h>
-
-#include <crypto/internal/hash.h>
-
-enum crc_op_size {
-	b, h, w, d,
-};
-
-enum crc_type {
-	crc32,
-	crc32c,
-};
-
-#ifndef TOOLCHAIN_SUPPORTS_CRC
-#define _ASM_SET_CRC(OP, SZ, TYPE)					  \
-_ASM_MACRO_3R(OP, rt, rs, rt2,						  \
-	".ifnc	\\rt, \\rt2\n\t"					  \
-	".error	\"invalid operands \\\"" #OP " \\rt,\\rs,\\rt2\\\"\"\n\t" \
-	".endif\n\t"							  \
-	_ASM_INSN_IF_MIPS(0x7c00000f | (__rt << 16) | (__rs << 21) |	  \
-			  ((SZ) <<  6) | ((TYPE) << 8))			  \
-	_ASM_INSN32_IF_MM(0x00000030 | (__rs << 16) | (__rt << 21) |	  \
-			  ((SZ) << 14) | ((TYPE) << 3)))
-#define _ASM_UNSET_CRC(op, SZ, TYPE) ".purgem " #op "\n\t"
-#else /* !TOOLCHAIN_SUPPORTS_CRC */
-#define _ASM_SET_CRC(op, SZ, TYPE) ".set\tcrc\n\t"
-#define _ASM_UNSET_CRC(op, SZ, TYPE)
-#endif
-
-#define __CRC32(crc, value, op, SZ, TYPE)		\
-do {							\
-	__asm__ __volatile__(				\
-		".set	push\n\t"			\
-		_ASM_SET_CRC(op, SZ, TYPE)		\
-		#op "	%0, %1, %0\n\t"			\
-		_ASM_UNSET_CRC(op, SZ, TYPE)		\
-		".set	pop"				\
-		: "+r" (crc)				\
-		: "r" (value));				\
-} while (0)
-
-#define _CRC32_crc32b(crc, value)	__CRC32(crc, value, crc32b, 0, 0)
-#define _CRC32_crc32h(crc, value)	__CRC32(crc, value, crc32h, 1, 0)
-#define _CRC32_crc32w(crc, value)	__CRC32(crc, value, crc32w, 2, 0)
-#define _CRC32_crc32d(crc, value)	__CRC32(crc, value, crc32d, 3, 0)
-#define _CRC32_crc32cb(crc, value)	__CRC32(crc, value, crc32cb, 0, 1)
-#define _CRC32_crc32ch(crc, value)	__CRC32(crc, value, crc32ch, 1, 1)
-#define _CRC32_crc32cw(crc, value)	__CRC32(crc, value, crc32cw, 2, 1)
-#define _CRC32_crc32cd(crc, value)	__CRC32(crc, value, crc32cd, 3, 1)
-
-#define _CRC32(crc, value, size, op) \
-	_CRC32_##op##size(crc, value)
-
-#define CRC32(crc, value, size) \
-	_CRC32(crc, value, size, crc32)
-
-#define CRC32C(crc, value, size) \
-	_CRC32(crc, value, size, crc32c)
-
-static u32 crc32_mips_le_hw(u32 crc_, const u8 *p, unsigned int len)
-{
-	u32 crc = crc_;
-
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		for (; len >= sizeof(u64); p += sizeof(u64), len -= sizeof(u64)) {
-			u64 value = get_unaligned_le64(p);
-
-			CRC32(crc, value, d);
-		}
-
-		if (len & sizeof(u32)) {
-			u32 value = get_unaligned_le32(p);
-
-			CRC32(crc, value, w);
-			p += sizeof(u32);
-		}
-	} else {
-		for (; len >= sizeof(u32); len -= sizeof(u32)) {
-			u32 value = get_unaligned_le32(p);
-
-			CRC32(crc, value, w);
-			p += sizeof(u32);
-		}
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
-static u32 crc32c_mips_le_hw(u32 crc_, const u8 *p, unsigned int len)
-{
-	u32 crc = crc_;
-
-	if (IS_ENABLED(CONFIG_64BIT)) {
-		for (; len >= sizeof(u64); p += sizeof(u64), len -= sizeof(u64)) {
-			u64 value = get_unaligned_le64(p);
-
-			CRC32C(crc, value, d);
-		}
-
-		if (len & sizeof(u32)) {
-			u32 value = get_unaligned_le32(p);
-
-			CRC32C(crc, value, w);
-			p += sizeof(u32);
-		}
-	} else {
-		for (; len >= sizeof(u32); len -= sizeof(u32)) {
-			u32 value = get_unaligned_le32(p);
-
-			CRC32C(crc, value, w);
-			p += sizeof(u32);
-		}
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
- * If your algorithm starts with ~0, then XOR with ~0 before you set
- * the seed.
- */
-static int chksum_setkey(struct crypto_shash *tfm, const u8 *key,
-			 unsigned int keylen)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(tfm);
-
-	if (keylen != sizeof(mctx->key))
-		return -EINVAL;
-	mctx->key = get_unaligned_le32(key);
-	return 0;
-}
-
-static int chksum_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = crc32_mips_le_hw(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksumc_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = crc32c_mips_le_hw(ctx->crc, data, length);
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
-	put_unaligned_le32(crc32_mips_le_hw(crc, data, len), out);
-	return 0;
-}
-
-static int __chksumc_finup(u32 crc, const u8 *data, unsigned int len, u8 *out)
-{
-	put_unaligned_le32(~crc32c_mips_le_hw(crc, data, len), out);
-	return 0;
-}
-
-static int chksum_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(ctx->crc, data, len, out);
-}
-
-static int chksumc_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksumc_finup(ctx->crc, data, len, out);
-}
-
-static int chksum_digest(struct shash_desc *desc, const u8 *data,
-			 unsigned int length, u8 *out)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-
-	return __chksum_finup(mctx->key, data, length, out);
-}
-
-static int chksumc_digest(struct shash_desc *desc, const u8 *data,
-			 unsigned int length, u8 *out)
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
-		.cra_driver_name	=	"crc32-mips-hw",
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
-		.cra_driver_name	=	"crc32c-mips-hw",
-		.cra_priority		=	300,
-		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		=	sizeof(struct chksum_ctx),
-		.cra_module		=	THIS_MODULE,
-		.cra_init		=	chksum_cra_init,
-	}
-};
-
-static int __init crc32_mod_init(void)
-{
-	int err;
-
-	err = crypto_register_shash(&crc32_alg);
-
-	if (err)
-		return err;
-
-	err = crypto_register_shash(&crc32c_alg);
-
-	if (err) {
-		crypto_unregister_shash(&crc32_alg);
-		return err;
-	}
-
-	return 0;
-}
-
-static void __exit crc32_mod_exit(void)
-{
-	crypto_unregister_shash(&crc32_alg);
-	crypto_unregister_shash(&crc32c_alg);
-}
-
-MODULE_AUTHOR("Marcin Nowakowski <marcin.nowakowski@mips.com");
-MODULE_DESCRIPTION("CRC32 and CRC32C using optional MIPS instructions");
-MODULE_LICENSE("GPL v2");
-
-module_cpu_feature_match(MIPS_CRC32, crc32_mod_init);
-module_exit(crc32_mod_exit);
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 5d5b993cbc2b..9c024e6d5e54 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -12,7 +12,9 @@ obj-$(CONFIG_PCI)	+= iomap-pci.o
 lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 
 obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 
+obj-$(CONFIG_CRC32_ARCH)	+= crc32-mips.o
+
 # libgcc-style stuff needed in the kernel
 obj-y += bswapsi.o bswapdi.o multi3.o
diff --git a/arch/mips/lib/crc32-mips.c b/arch/mips/lib/crc32-mips.c
new file mode 100644
index 000000000000..083e5d693a16
--- /dev/null
+++ b/arch/mips/lib/crc32-mips.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * crc32-mips.c - CRC32 and CRC32C using optional MIPSr6 instructions
+ *
+ * Module based on arm64/crypto/crc32-arm.c
+ *
+ * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
+ * Copyright (C) 2018 MIPS Tech, LLC
+ */
+
+#include <linux/cpufeature.h>
+#include <linux/crc32.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/mipsregs.h>
+#include <linux/unaligned.h>
+
+enum crc_op_size {
+	b, h, w, d,
+};
+
+enum crc_type {
+	crc32,
+	crc32c,
+};
+
+#ifndef TOOLCHAIN_SUPPORTS_CRC
+#define _ASM_SET_CRC(OP, SZ, TYPE)					  \
+_ASM_MACRO_3R(OP, rt, rs, rt2,						  \
+	".ifnc	\\rt, \\rt2\n\t"					  \
+	".error	\"invalid operands \\\"" #OP " \\rt,\\rs,\\rt2\\\"\"\n\t" \
+	".endif\n\t"							  \
+	_ASM_INSN_IF_MIPS(0x7c00000f | (__rt << 16) | (__rs << 21) |	  \
+			  ((SZ) <<  6) | ((TYPE) << 8))			  \
+	_ASM_INSN32_IF_MM(0x00000030 | (__rs << 16) | (__rt << 21) |	  \
+			  ((SZ) << 14) | ((TYPE) << 3)))
+#define _ASM_UNSET_CRC(op, SZ, TYPE) ".purgem " #op "\n\t"
+#else /* !TOOLCHAIN_SUPPORTS_CRC */
+#define _ASM_SET_CRC(op, SZ, TYPE) ".set\tcrc\n\t"
+#define _ASM_UNSET_CRC(op, SZ, TYPE)
+#endif
+
+#define __CRC32(crc, value, op, SZ, TYPE)		\
+do {							\
+	__asm__ __volatile__(				\
+		".set	push\n\t"			\
+		_ASM_SET_CRC(op, SZ, TYPE)		\
+		#op "	%0, %1, %0\n\t"			\
+		_ASM_UNSET_CRC(op, SZ, TYPE)		\
+		".set	pop"				\
+		: "+r" (crc)				\
+		: "r" (value));				\
+} while (0)
+
+#define _CRC32_crc32b(crc, value)	__CRC32(crc, value, crc32b, 0, 0)
+#define _CRC32_crc32h(crc, value)	__CRC32(crc, value, crc32h, 1, 0)
+#define _CRC32_crc32w(crc, value)	__CRC32(crc, value, crc32w, 2, 0)
+#define _CRC32_crc32d(crc, value)	__CRC32(crc, value, crc32d, 3, 0)
+#define _CRC32_crc32cb(crc, value)	__CRC32(crc, value, crc32cb, 0, 1)
+#define _CRC32_crc32ch(crc, value)	__CRC32(crc, value, crc32ch, 1, 1)
+#define _CRC32_crc32cw(crc, value)	__CRC32(crc, value, crc32cw, 2, 1)
+#define _CRC32_crc32cd(crc, value)	__CRC32(crc, value, crc32cd, 3, 1)
+
+#define _CRC32(crc, value, size, op) \
+	_CRC32_##op##size(crc, value)
+
+#define CRC32(crc, value, size) \
+	_CRC32(crc, value, size, crc32)
+
+#define CRC32C(crc, value, size) \
+	_CRC32(crc, value, size, crc32c)
+
+static DEFINE_STATIC_KEY_FALSE(have_crc32);
+
+u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (!static_branch_likely(&have_crc32))
+		return crc32_le_base(crc, p, len);
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		for (; len >= sizeof(u64); p += sizeof(u64), len -= sizeof(u64)) {
+			u64 value = get_unaligned_le64(p);
+
+			CRC32(crc, value, d);
+		}
+
+		if (len & sizeof(u32)) {
+			u32 value = get_unaligned_le32(p);
+
+			CRC32(crc, value, w);
+			p += sizeof(u32);
+		}
+	} else {
+		for (; len >= sizeof(u32); len -= sizeof(u32)) {
+			u32 value = get_unaligned_le32(p);
+
+			CRC32(crc, value, w);
+			p += sizeof(u32);
+		}
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
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		for (; len >= sizeof(u64); p += sizeof(u64), len -= sizeof(u64)) {
+			u64 value = get_unaligned_le64(p);
+
+			CRC32C(crc, value, d);
+		}
+
+		if (len & sizeof(u32)) {
+			u32 value = get_unaligned_le32(p);
+
+			CRC32C(crc, value, w);
+			p += sizeof(u32);
+		}
+	} else {
+		for (; len >= sizeof(u32); len -= sizeof(u32)) {
+			u32 value = get_unaligned_le32(p);
+
+			CRC32C(crc, value, w);
+			p += sizeof(u32);
+		}
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
+static int __init crc32_mips_init(void)
+{
+	if (cpu_have_feature(cpu_feature(MIPS_CRC32)))
+		static_branch_enable(&have_crc32);
+	return 0;
+}
+arch_initcall(crc32_mips_init);
+
+static void __exit crc32_mips_exit(void)
+{
+}
+module_exit(crc32_mips_exit);
+
+u32 crc32_optimizations(void)
+{
+	if (static_key_enabled(&have_crc32))
+		return CRC32_LE_OPTIMIZATION | CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
+MODULE_AUTHOR("Marcin Nowakowski <marcin.nowakowski@mips.com");
+MODULE_DESCRIPTION("CRC32 and CRC32C using optional MIPS instructions");
+MODULE_LICENSE("GPL v2");
-- 
2.47.0


