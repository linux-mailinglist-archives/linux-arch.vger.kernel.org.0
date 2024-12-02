Return-Path: <linux-arch+bounces-9209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E69DF80A
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8928148F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B22183CA9;
	Mon,  2 Dec 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ87GNW/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA8178CC8;
	Mon,  2 Dec 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101775; cv=none; b=udExxsShGzGDapSerEBWpfMVEDdtj8HXu8fh84YmJL++r8opBdXLrq50aGxOSthbO12J26y4ZbutDBrrZkCBgqIifGGPmJPY2Wpa8R0Mi52wlS9/IPXM2JIEnCn+mcBfTIwtV0nwO7bk05ii47is+VVcm35g+Zk4d3KDST7wUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101775; c=relaxed/simple;
	bh=9mXT0mc7f6aCM+c01pj9bEUORU1XVxhTIJLf8dd+HbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7FdQy4N0IKOiT1JUNxoavyq2FQePF8VLPQY4xzAwy0My2Fq6b4xUZcLYe84idef9M18ME7zGSc10c6jD+ThZ+z6vwRSwjnwhDzTtutE1xcu3brtZGw4wydtkPgj91HHbCPvODQfGHxB5gYwbT+mG2pIoPKMQKJ1kP41sujocqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ87GNW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA5AC4CED2;
	Mon,  2 Dec 2024 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101774;
	bh=9mXT0mc7f6aCM+c01pj9bEUORU1XVxhTIJLf8dd+HbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQ87GNW/LWTrxPmRDkYSPEKyYTosibM6ycnPqwZ9fu/5zup+nurLaUNIOFUMaNA8Y
	 A+UyDYdO94OBm6V9yq3cKN5UKEaRRrGGO0Ws6CzEaPGqvd8+AG2IvaGhfX0wwkGfaw
	 sV+1HSx/n7I3PL0m1k+0AmfepP8tbGHUSdI8kCLYD9u4EmPWKT6UdP7HKiM9vQZloe
	 SwkfXLvGitH+uIxbeUgdRDsT2gWTq7v0brroX/GeMPNDhlzW3U8JIpPzMhLhiM7kqk
	 II0/GzQUmtnhIZOubmanfJa9ca2OhIy7vAl6OSoXgRimWFrxYHfcUnh56mSQA32zOf
	 vhhEgjE7/2W8Q==
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
Subject: [PATCH v4 09/19] s390/crc32: expose CRC32 functions through lib
Date: Sun,  1 Dec 2024 17:08:34 -0800
Message-ID: <20241202010844.144356-10-ebiggers@kernel.org>
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

Move the s390 CRC32 assembly code into the lib directory and wire it up
to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/s390/crypto/crc32-vx.c to
arch/s390/lib/crc32-glue.c, view this commit with 'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/Kconfig                      |   1 +
 arch/s390/configs/debug_defconfig      |   1 -
 arch/s390/configs/defconfig            |   1 -
 arch/s390/crypto/Kconfig               |  12 -
 arch/s390/crypto/Makefile              |   2 -
 arch/s390/crypto/crc32-vx.c            | 306 -------------------------
 arch/s390/lib/Makefile                 |   3 +
 arch/s390/lib/crc32-glue.c             |  92 ++++++++
 arch/s390/{crypto => lib}/crc32-vx.h   |   0
 arch/s390/{crypto => lib}/crc32be-vx.c |   0
 arch/s390/{crypto => lib}/crc32le-vx.c |   0
 11 files changed, 96 insertions(+), 322 deletions(-)
 delete mode 100644 arch/s390/crypto/crc32-vx.c
 create mode 100644 arch/s390/lib/crc32-glue.c
 rename arch/s390/{crypto => lib}/crc32-vx.h (100%)
 rename arch/s390/{crypto => lib}/crc32be-vx.c (100%)
 rename arch/s390/{crypto => lib}/crc32le-vx.c (100%)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..d272230cc885 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -70,10 +70,11 @@ config S390
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
+	select ARCH_HAS_CRC32
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index d8d227ab82de..f2a149b4fafd 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -793,11 +793,10 @@ CONFIG_CRYPTO_ZSTD=m
 CONFIG_CRYPTO_ANSI_CPRNG=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_SHA1_S390=m
 CONFIG_CRYPTO_SHA256_S390=m
 CONFIG_CRYPTO_SHA3_256_S390=m
 CONFIG_CRYPTO_SHA3_512_S390=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 6c2f2bb4fbf8..d521aabc31d7 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -780,11 +780,10 @@ CONFIG_CRYPTO_ANSI_CPRNG=m
 CONFIG_CRYPTO_JITTERENTROPY_OSR=1
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_SHA1_S390=m
 CONFIG_CRYPTO_SHA256_S390=m
 CONFIG_CRYPTO_SHA3_256_S390=m
 CONFIG_CRYPTO_SHA3_512_S390=m
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index d3eb3a233693..b760232537f1 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -1,21 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (s390)"
 
-config CRYPTO_CRC32_S390
-	tristate "CRC32c and CRC32"
-	depends on S390
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  CRC32c and CRC32 CRC algorithms
-
-	  Architecture: s390
-
-	  It is available with IBM z13 or later.
-
 config CRYPTO_SHA512_S390
 	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on S390
 	select CRYPTO_HASH
 	help
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index a0cb96937c3d..14dafadbcbed 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -12,11 +12,9 @@ obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
 obj-$(CONFIG_CRYPTO_PAES_S390) += paes_s390.o
 obj-$(CONFIG_CRYPTO_CHACHA_S390) += chacha_s390.o
 obj-$(CONFIG_S390_PRNG) += prng.o
 obj-$(CONFIG_CRYPTO_GHASH_S390) += ghash_s390.o
-obj-$(CONFIG_CRYPTO_CRC32_S390) += crc32-vx_s390.o
 obj-$(CONFIG_CRYPTO_HMAC_S390) += hmac_s390.o
 obj-y += arch_random.o
 
-crc32-vx_s390-y := crc32-vx.o crc32le-vx.o crc32be-vx.o
 chacha_s390-y := chacha-glue.o chacha-s390.o
diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
deleted file mode 100644
index 89a10337e6ea..000000000000
--- a/arch/s390/crypto/crc32-vx.c
+++ /dev/null
@@ -1,306 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Crypto-API module for CRC-32 algorithms implemented with the
- * z/Architecture Vector Extension Facility.
- *
- * Copyright IBM Corp. 2015
- * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- */
-#define KMSG_COMPONENT	"crc32-vx"
-#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
-
-#include <linux/module.h>
-#include <linux/cpufeature.h>
-#include <linux/crc32.h>
-#include <crypto/internal/hash.h>
-#include <asm/fpu.h>
-#include "crc32-vx.h"
-
-#define CRC32_BLOCK_SIZE	1
-#define CRC32_DIGEST_SIZE	4
-
-#define VX_MIN_LEN		64
-#define VX_ALIGNMENT		16L
-#define VX_ALIGN_MASK		(VX_ALIGNMENT - 1)
-
-struct crc_ctx {
-	u32 key;
-};
-
-struct crc_desc_ctx {
-	u32 crc;
-};
-
-/*
- * DEFINE_CRC32_VX() - Define a CRC-32 function using the vector extension
- *
- * Creates a function to perform a particular CRC-32 computation. Depending
- * on the message buffer, the hardware-accelerated or software implementation
- * is used.   Note that the message buffer is aligned to improve fetch
- * operations of VECTOR LOAD MULTIPLE instructions.
- *
- */
-#define DEFINE_CRC32_VX(___fname, ___crc32_vx, ___crc32_sw)		    \
-	static u32 __pure ___fname(u32 crc,				    \
-				unsigned char const *data, size_t datalen)  \
-	{								    \
-		unsigned long prealign, aligned, remaining;		    \
-		DECLARE_KERNEL_FPU_ONSTACK16(vxstate);			    \
-									    \
-		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK)		    \
-			return ___crc32_sw(crc, data, datalen);		    \
-									    \
-		if ((unsigned long)data & VX_ALIGN_MASK) {		    \
-			prealign = VX_ALIGNMENT -			    \
-				  ((unsigned long)data & VX_ALIGN_MASK);    \
-			datalen -= prealign;				    \
-			crc = ___crc32_sw(crc, data, prealign);		    \
-			data = (void *)((unsigned long)data + prealign);    \
-		}							    \
-									    \
-		aligned = datalen & ~VX_ALIGN_MASK;			    \
-		remaining = datalen & VX_ALIGN_MASK;			    \
-									    \
-		kernel_fpu_begin(&vxstate, KERNEL_VXR_LOW);		    \
-		crc = ___crc32_vx(crc, data, aligned);			    \
-		kernel_fpu_end(&vxstate, KERNEL_VXR_LOW);		    \
-									    \
-		if (remaining)						    \
-			crc = ___crc32_sw(crc, data + aligned, remaining);  \
-									    \
-		return crc;						    \
-	}
-
-DEFINE_CRC32_VX(crc32_le_vx, crc32_le_vgfm_16, crc32_le)
-DEFINE_CRC32_VX(crc32_be_vx, crc32_be_vgfm_16, crc32_be)
-DEFINE_CRC32_VX(crc32c_le_vx, crc32c_le_vgfm_16, __crc32c_le)
-
-
-static int crc32_vx_cra_init_zero(struct crypto_tfm *tfm)
-{
-	struct crc_ctx *mctx = crypto_tfm_ctx(tfm);
-
-	mctx->key = 0;
-	return 0;
-}
-
-static int crc32_vx_cra_init_invert(struct crypto_tfm *tfm)
-{
-	struct crc_ctx *mctx = crypto_tfm_ctx(tfm);
-
-	mctx->key = ~0;
-	return 0;
-}
-
-static int crc32_vx_init(struct shash_desc *desc)
-{
-	struct crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
-	struct crc_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = mctx->key;
-	return 0;
-}
-
-static int crc32_vx_setkey(struct crypto_shash *tfm, const u8 *newkey,
-			   unsigned int newkeylen)
-{
-	struct crc_ctx *mctx = crypto_shash_ctx(tfm);
-
-	if (newkeylen != sizeof(mctx->key))
-		return -EINVAL;
-	mctx->key = le32_to_cpu(*(__le32 *)newkey);
-	return 0;
-}
-
-static int crc32be_vx_setkey(struct crypto_shash *tfm, const u8 *newkey,
-			     unsigned int newkeylen)
-{
-	struct crc_ctx *mctx = crypto_shash_ctx(tfm);
-
-	if (newkeylen != sizeof(mctx->key))
-		return -EINVAL;
-	mctx->key = be32_to_cpu(*(__be32 *)newkey);
-	return 0;
-}
-
-static int crc32le_vx_final(struct shash_desc *desc, u8 *out)
-{
-	struct crc_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	*(__le32 *)out = cpu_to_le32p(&ctx->crc);
-	return 0;
-}
-
-static int crc32be_vx_final(struct shash_desc *desc, u8 *out)
-{
-	struct crc_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	*(__be32 *)out = cpu_to_be32p(&ctx->crc);
-	return 0;
-}
-
-static int crc32c_vx_final(struct shash_desc *desc, u8 *out)
-{
-	struct crc_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	/*
-	 * Perform a final XOR with 0xFFFFFFFF to be in sync
-	 * with the generic crc32c shash implementation.
-	 */
-	*(__le32 *)out = ~cpu_to_le32p(&ctx->crc);
-	return 0;
-}
-
-static int __crc32le_vx_finup(u32 *crc, const u8 *data, unsigned int len,
-			      u8 *out)
-{
-	*(__le32 *)out = cpu_to_le32(crc32_le_vx(*crc, data, len));
-	return 0;
-}
-
-static int __crc32be_vx_finup(u32 *crc, const u8 *data, unsigned int len,
-			      u8 *out)
-{
-	*(__be32 *)out = cpu_to_be32(crc32_be_vx(*crc, data, len));
-	return 0;
-}
-
-static int __crc32c_vx_finup(u32 *crc, const u8 *data, unsigned int len,
-			     u8 *out)
-{
-	/*
-	 * Perform a final XOR with 0xFFFFFFFF to be in sync
-	 * with the generic crc32c shash implementation.
-	 */
-	*(__le32 *)out = ~cpu_to_le32(crc32c_le_vx(*crc, data, len));
-	return 0;
-}
-
-
-#define CRC32_VX_FINUP(alg, func)					      \
-	static int alg ## _vx_finup(struct shash_desc *desc, const u8 *data,  \
-				   unsigned int datalen, u8 *out)	      \
-	{								      \
-		return __ ## alg ## _vx_finup(shash_desc_ctx(desc),	      \
-					      data, datalen, out);	      \
-	}
-
-CRC32_VX_FINUP(crc32le, crc32_le_vx)
-CRC32_VX_FINUP(crc32be, crc32_be_vx)
-CRC32_VX_FINUP(crc32c, crc32c_le_vx)
-
-#define CRC32_VX_DIGEST(alg, func)					      \
-	static int alg ## _vx_digest(struct shash_desc *desc, const u8 *data, \
-				     unsigned int len, u8 *out)		      \
-	{								      \
-		return __ ## alg ## _vx_finup(crypto_shash_ctx(desc->tfm),    \
-					      data, len, out);		      \
-	}
-
-CRC32_VX_DIGEST(crc32le, crc32_le_vx)
-CRC32_VX_DIGEST(crc32be, crc32_be_vx)
-CRC32_VX_DIGEST(crc32c, crc32c_le_vx)
-
-#define CRC32_VX_UPDATE(alg, func)					      \
-	static int alg ## _vx_update(struct shash_desc *desc, const u8 *data, \
-				     unsigned int datalen)		      \
-	{								      \
-		struct crc_desc_ctx *ctx = shash_desc_ctx(desc);	      \
-		ctx->crc = func(ctx->crc, data, datalen);		      \
-		return 0;						      \
-	}
-
-CRC32_VX_UPDATE(crc32le, crc32_le_vx)
-CRC32_VX_UPDATE(crc32be, crc32_be_vx)
-CRC32_VX_UPDATE(crc32c, crc32c_le_vx)
-
-
-static struct shash_alg crc32_vx_algs[] = {
-	/* CRC-32 LE */
-	{
-		.init		=	crc32_vx_init,
-		.setkey		=	crc32_vx_setkey,
-		.update		=	crc32le_vx_update,
-		.final		=	crc32le_vx_final,
-		.finup		=	crc32le_vx_finup,
-		.digest		=	crc32le_vx_digest,
-		.descsize	=	sizeof(struct crc_desc_ctx),
-		.digestsize	=	CRC32_DIGEST_SIZE,
-		.base		=	{
-			.cra_name	 = "crc32",
-			.cra_driver_name = "crc32-vx",
-			.cra_priority	 = 200,
-			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
-			.cra_blocksize	 = CRC32_BLOCK_SIZE,
-			.cra_ctxsize	 = sizeof(struct crc_ctx),
-			.cra_module	 = THIS_MODULE,
-			.cra_init	 = crc32_vx_cra_init_zero,
-		},
-	},
-	/* CRC-32 BE */
-	{
-		.init		=	crc32_vx_init,
-		.setkey		=	crc32be_vx_setkey,
-		.update		=	crc32be_vx_update,
-		.final		=	crc32be_vx_final,
-		.finup		=	crc32be_vx_finup,
-		.digest		=	crc32be_vx_digest,
-		.descsize	=	sizeof(struct crc_desc_ctx),
-		.digestsize	=	CRC32_DIGEST_SIZE,
-		.base		=	{
-			.cra_name	 = "crc32be",
-			.cra_driver_name = "crc32be-vx",
-			.cra_priority	 = 200,
-			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
-			.cra_blocksize	 = CRC32_BLOCK_SIZE,
-			.cra_ctxsize	 = sizeof(struct crc_ctx),
-			.cra_module	 = THIS_MODULE,
-			.cra_init	 = crc32_vx_cra_init_zero,
-		},
-	},
-	/* CRC-32C LE */
-	{
-		.init		=	crc32_vx_init,
-		.setkey		=	crc32_vx_setkey,
-		.update		=	crc32c_vx_update,
-		.final		=	crc32c_vx_final,
-		.finup		=	crc32c_vx_finup,
-		.digest		=	crc32c_vx_digest,
-		.descsize	=	sizeof(struct crc_desc_ctx),
-		.digestsize	=	CRC32_DIGEST_SIZE,
-		.base		=	{
-			.cra_name	 = "crc32c",
-			.cra_driver_name = "crc32c-vx",
-			.cra_priority	 = 200,
-			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
-			.cra_blocksize	 = CRC32_BLOCK_SIZE,
-			.cra_ctxsize	 = sizeof(struct crc_ctx),
-			.cra_module	 = THIS_MODULE,
-			.cra_init	 = crc32_vx_cra_init_invert,
-		},
-	},
-};
-
-
-static int __init crc_vx_mod_init(void)
-{
-	return crypto_register_shashes(crc32_vx_algs,
-				       ARRAY_SIZE(crc32_vx_algs));
-}
-
-static void __exit crc_vx_mod_exit(void)
-{
-	crypto_unregister_shashes(crc32_vx_algs, ARRAY_SIZE(crc32_vx_algs));
-}
-
-module_cpu_feature_match(S390_CPU_FEATURE_VXRS, crc_vx_mod_init);
-module_exit(crc_vx_mod_exit);
-
-MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
-MODULE_DESCRIPTION("CRC-32 algorithms using z/Architecture Vector Extension Facility");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crc32");
-MODULE_ALIAS_CRYPTO("crc32-vx");
-MODULE_ALIAS_CRYPTO("crc32c");
-MODULE_ALIAS_CRYPTO("crc32c-vx");
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index f43f897d3fc0..14bbfe50033c 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -22,5 +22,8 @@ obj-$(CONFIG_S390_MODULES_SANITY_TEST) += test_modules.o
 obj-$(CONFIG_S390_MODULES_SANITY_TEST_HELPERS) += test_modules_helpers.o
 
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_EXPOLINE_EXTERN) += expoline.o
+
+obj-$(CONFIG_CRC32_ARCH) += crc32-s390.o
+crc32-s390-y := crc32-glue.o crc32le-vx.o crc32be-vx.o
diff --git a/arch/s390/lib/crc32-glue.c b/arch/s390/lib/crc32-glue.c
new file mode 100644
index 000000000000..137080e61f90
--- /dev/null
+++ b/arch/s390/lib/crc32-glue.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CRC-32 implemented with the z/Architecture Vector Extension Facility.
+ *
+ * Copyright IBM Corp. 2015
+ * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+ */
+#define KMSG_COMPONENT	"crc32-vx"
+#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
+
+#include <linux/module.h>
+#include <linux/cpufeature.h>
+#include <linux/crc32.h>
+#include <asm/fpu.h>
+#include "crc32-vx.h"
+
+#define VX_MIN_LEN		64
+#define VX_ALIGNMENT		16L
+#define VX_ALIGN_MASK		(VX_ALIGNMENT - 1)
+
+static DEFINE_STATIC_KEY_FALSE(have_vxrs);
+
+/*
+ * DEFINE_CRC32_VX() - Define a CRC-32 function using the vector extension
+ *
+ * Creates a function to perform a particular CRC-32 computation. Depending
+ * on the message buffer, the hardware-accelerated or software implementation
+ * is used.   Note that the message buffer is aligned to improve fetch
+ * operations of VECTOR LOAD MULTIPLE instructions.
+ */
+#define DEFINE_CRC32_VX(___fname, ___crc32_vx, ___crc32_sw)		    \
+	u32 ___fname(u32 crc, const u8 *data, size_t datalen)		    \
+	{								    \
+		unsigned long prealign, aligned, remaining;		    \
+		DECLARE_KERNEL_FPU_ONSTACK16(vxstate);			    \
+									    \
+		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK ||		    \
+		    !static_branch_likely(&have_vxrs))			    \
+			return ___crc32_sw(crc, data, datalen);		    \
+									    \
+		if ((unsigned long)data & VX_ALIGN_MASK) {		    \
+			prealign = VX_ALIGNMENT -			    \
+				  ((unsigned long)data & VX_ALIGN_MASK);    \
+			datalen -= prealign;				    \
+			crc = ___crc32_sw(crc, data, prealign);		    \
+			data = (void *)((unsigned long)data + prealign);    \
+		}							    \
+									    \
+		aligned = datalen & ~VX_ALIGN_MASK;			    \
+		remaining = datalen & VX_ALIGN_MASK;			    \
+									    \
+		kernel_fpu_begin(&vxstate, KERNEL_VXR_LOW);		    \
+		crc = ___crc32_vx(crc, data, aligned);			    \
+		kernel_fpu_end(&vxstate, KERNEL_VXR_LOW);		    \
+									    \
+		if (remaining)						    \
+			crc = ___crc32_sw(crc, data + aligned, remaining);  \
+									    \
+		return crc;						    \
+	}								    \
+	EXPORT_SYMBOL(___fname);
+
+DEFINE_CRC32_VX(crc32_le_arch, crc32_le_vgfm_16, crc32_le_base)
+DEFINE_CRC32_VX(crc32_be_arch, crc32_be_vgfm_16, crc32_be_base)
+DEFINE_CRC32_VX(crc32c_le_arch, crc32c_le_vgfm_16, crc32c_le_base)
+
+static int __init crc32_s390_init(void)
+{
+	if (cpu_have_feature(S390_CPU_FEATURE_VXRS))
+		static_branch_enable(&have_vxrs);
+	return 0;
+}
+arch_initcall(crc32_s390_init);
+
+static void __exit crc32_s390_exit(void)
+{
+}
+module_exit(crc32_s390_exit);
+
+u32 crc32_optimizations(void)
+{
+	if (static_key_enabled(&have_vxrs))
+		return CRC32_LE_OPTIMIZATION |
+		       CRC32_BE_OPTIMIZATION |
+		       CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
+MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("CRC-32 algorithms using z/Architecture Vector Extension Facility");
+MODULE_LICENSE("GPL");
diff --git a/arch/s390/crypto/crc32-vx.h b/arch/s390/lib/crc32-vx.h
similarity index 100%
rename from arch/s390/crypto/crc32-vx.h
rename to arch/s390/lib/crc32-vx.h
diff --git a/arch/s390/crypto/crc32be-vx.c b/arch/s390/lib/crc32be-vx.c
similarity index 100%
rename from arch/s390/crypto/crc32be-vx.c
rename to arch/s390/lib/crc32be-vx.c
diff --git a/arch/s390/crypto/crc32le-vx.c b/arch/s390/lib/crc32le-vx.c
similarity index 100%
rename from arch/s390/crypto/crc32le-vx.c
rename to arch/s390/lib/crc32le-vx.c
-- 
2.47.1


