Return-Path: <linux-arch+bounces-8566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7B9B0E9E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CF41C20A47
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C821A4D8;
	Fri, 25 Oct 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCFaC3Xn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACE218950;
	Fri, 25 Oct 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883751; cv=none; b=SYqQH1rlU7XZCrcQmSlLFqTC+JINgeM++hDFrIzM8TY99nm/qZJwq5P7r82RBC3/jVjQwcork1+63LsN8czjGqYx9zl/KHkM3OLi7GpPYB8B0/Wt0YxrryTxRFKApQNWgJ4IBdYDbO/oNP1HstRuq1+9V1W25+qjtHtkDGtN6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883751; c=relaxed/simple;
	bh=KEgKhqIiQ4Fjt7R4JVDLeXFDGQuWQZyHl+puuc5o7LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laNAnxuku8tLXl6GOoY8CMtPPN5hCLbNFfHmwpmOaSJy9QXRPrYFlNrUhL2JKqRm7l9vnNDoHDSgN+PDNsr071sxy1UIKfRv6VohQGK+0fyvNiXy73x2fvSreYcCuWYjSuLCS1I2BMyTq5TPc5L3Fk1zeHWpV9Iiepad9VT+H+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCFaC3Xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D9FC4CEE3;
	Fri, 25 Oct 2024 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883751;
	bh=KEgKhqIiQ4Fjt7R4JVDLeXFDGQuWQZyHl+puuc5o7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCFaC3XnDZ8ioNl0AHZsGjjxACScCnMp97lYmgmC50vEOafaZVY5dJBs1isAVjxWk
	 YuHbppTIFMsNfnW4XjLigWm6Hns+FhLAeq60VUVYr0yi1QjYpauGUVlX3uL21QHpPo
	 F6tAJvduBi1cGywnzkm0tuVB9YKYsUmTaeCq+YE14CQigoB1sO6Nanw/Axr/7as17H
	 GaiDD3ttZBsD3KV/oenuRajfuIF+fCpLwcyqlGtmNfG9zF9R3IsTQotVwpUmgg7T5G
	 +JNW4T6Z0hAvFcV+QKGjFZDWWmlG6wX7dIMYJjuUuH7bYgUWsy9A85FJ5NJW8fHMmm
	 RUW9KqIk5sX0w==
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
Subject: [PATCH v2 13/18] x86/crc32: expose CRC32 functions through lib
Date: Fri, 25 Oct 2024 12:14:49 -0700
Message-ID: <20241025191454.72616-14-ebiggers@kernel.org>
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

Move the x86 CRC32 assembly code into the lib directory and wire it up
to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig                              |   1 +
 arch/x86/crypto/Kconfig                       |  22 --
 arch/x86/crypto/Makefile                      |   7 -
 arch/x86/crypto/crc32-pclmul_glue.c           | 202 --------------
 arch/x86/crypto/crc32c-intel_glue.c           | 249 ------------------
 arch/x86/lib/Makefile                         |   4 +
 arch/x86/lib/crc32-glue.c                     | 116 ++++++++
 .../crc32-pclmul_asm.S => lib/crc32-pclmul.S} |   0
 .../crc32c-3way.S}                            |   0
 drivers/target/iscsi/Kconfig                  |   1 -
 10 files changed, 121 insertions(+), 481 deletions(-)
 delete mode 100644 arch/x86/crypto/crc32-pclmul_glue.c
 delete mode 100644 arch/x86/crypto/crc32c-intel_glue.c
 create mode 100644 arch/x86/lib/crc32-glue.c
 rename arch/x86/{crypto/crc32-pclmul_asm.S => lib/crc32-pclmul.S} (100%)
 rename arch/x86/{crypto/crc32c-pcl-intel-asm_64.S => lib/crc32c-3way.S} (100%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..a7a1a1448d23 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -74,10 +74,11 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
+	select ARCH_HAS_CRC32
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 7b1bebed879d..1ca53e847966 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -490,32 +490,10 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: x86_64 using:
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
-config CRYPTO_CRC32C_INTEL
-	tristate "CRC32c (SSE4.2/PCLMULQDQ)"
-	depends on X86
-	select CRYPTO_HASH
-	help
-	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
-
-	  Architecture: x86 (32-bit and 64-bit) using:
-	  - SSE4.2 (Streaming SIMD Extensions 4.2) CRC32 instruction
-	  - PCLMULQDQ (carry-less multiplication)
-
-config CRYPTO_CRC32_PCLMUL
-	tristate "CRC32 (PCLMULQDQ)"
-	depends on X86
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  CRC32 CRC algorithm (IEEE 802.3)
-
-	  Architecture: x86 (32-bit and 64-bit) using:
-	  - PCLMULQDQ (carry-less multiplication)
-
 config CRYPTO_CRCT10DIF_PCLMUL
 	tristate "CRCT10DIF (PCLMULQDQ)"
 	depends on X86 && 64BIT && CRC_T10DIF
 	select CRYPTO_HASH
 	help
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 53b4a277809e..030b925ca4e2 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -73,17 +73,10 @@ obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
 ghash-clmulni-intel-y := ghash-clmulni-intel_asm.o ghash-clmulni-intel_glue.o
 
 obj-$(CONFIG_CRYPTO_POLYVAL_CLMUL_NI) += polyval-clmulni.o
 polyval-clmulni-y := polyval-clmulni_asm.o polyval-clmulni_glue.o
 
-obj-$(CONFIG_CRYPTO_CRC32C_INTEL) += crc32c-intel.o
-crc32c-intel-y := crc32c-intel_glue.o
-crc32c-intel-$(CONFIG_64BIT) += crc32c-pcl-intel-asm_64.o
-
-obj-$(CONFIG_CRYPTO_CRC32_PCLMUL) += crc32-pclmul.o
-crc32-pclmul-y := crc32-pclmul_asm.o crc32-pclmul_glue.o
-
 obj-$(CONFIG_CRYPTO_CRCT10DIF_PCLMUL) += crct10dif-pclmul.o
 crct10dif-pclmul-y := crct10dif-pcl-asm_64.o crct10dif-pclmul_glue.o
 
 obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
 poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
deleted file mode 100644
index 9d14eac51c5b..000000000000
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/* GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * You should have received a copy of the GNU General Public License
- * version 2 along with this program; If not, see http://www.gnu.org/licenses
- *
- * Please  visit http://www.xyratex.com/contact if you need additional
- * information or have any questions.
- *
- * GPL HEADER END
- */
-
-/*
- * Copyright 2012 Xyratex Technology Limited
- *
- * Wrappers for kernel crypto shash api to pclmulqdq crc32 implementation.
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/crc32.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-
-#include <asm/cpufeatures.h>
-#include <asm/cpu_device_id.h>
-#include <asm/simd.h>
-
-#define CHKSUM_BLOCK_SIZE	1
-#define CHKSUM_DIGEST_SIZE	4
-
-#define PCLMUL_MIN_LEN		64L     /* minimum size of buffer
-					 * for crc32_pclmul_le_16 */
-#define SCALE_F			16L	/* size of xmm register */
-#define SCALE_F_MASK		(SCALE_F - 1)
-
-u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
-
-static u32 __attribute__((pure))
-	crc32_pclmul_le(u32 crc, unsigned char const *p, size_t len)
-{
-	unsigned int iquotient;
-	unsigned int iremainder;
-	unsigned int prealign;
-
-	if (len < PCLMUL_MIN_LEN + SCALE_F_MASK || !crypto_simd_usable())
-		return crc32_le(crc, p, len);
-
-	if ((long)p & SCALE_F_MASK) {
-		/* align p to 16 byte */
-		prealign = SCALE_F - ((long)p & SCALE_F_MASK);
-
-		crc = crc32_le(crc, p, prealign);
-		len -= prealign;
-		p = (unsigned char *)(((unsigned long)p + SCALE_F_MASK) &
-				     ~SCALE_F_MASK);
-	}
-	iquotient = len & (~SCALE_F_MASK);
-	iremainder = len & SCALE_F_MASK;
-
-	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(crc, p, iquotient);
-	kernel_fpu_end();
-
-	if (iremainder)
-		crc = crc32_le(crc, p + iquotient, iremainder);
-
-	return crc;
-}
-
-static int crc32_pclmul_cra_init(struct crypto_tfm *tfm)
-{
-	u32 *key = crypto_tfm_ctx(tfm);
-
-	*key = 0;
-
-	return 0;
-}
-
-static int crc32_pclmul_setkey(struct crypto_shash *hash, const u8 *key,
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
-static int crc32_pclmul_init(struct shash_desc *desc)
-{
-	u32 *mctx = crypto_shash_ctx(desc->tfm);
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = *mctx;
-
-	return 0;
-}
-
-static int crc32_pclmul_update(struct shash_desc *desc, const u8 *data,
-			       unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = crc32_pclmul_le(*crcp, data, len);
-	return 0;
-}
-
-/* No final XOR 0xFFFFFFFF, like crc32_le */
-static int __crc32_pclmul_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
-{
-	*(__le32 *)out = cpu_to_le32(crc32_pclmul_le(*crcp, data, len));
-	return 0;
-}
-
-static int crc32_pclmul_finup(struct shash_desc *desc, const u8 *data,
-			      unsigned int len, u8 *out)
-{
-	return __crc32_pclmul_finup(shash_desc_ctx(desc), data, len, out);
-}
-
-static int crc32_pclmul_final(struct shash_desc *desc, u8 *out)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*(__le32 *)out = cpu_to_le32p(crcp);
-	return 0;
-}
-
-static int crc32_pclmul_digest(struct shash_desc *desc, const u8 *data,
-			       unsigned int len, u8 *out)
-{
-	return __crc32_pclmul_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
-}
-
-static struct shash_alg alg = {
-	.setkey		= crc32_pclmul_setkey,
-	.init		= crc32_pclmul_init,
-	.update		= crc32_pclmul_update,
-	.final		= crc32_pclmul_final,
-	.finup		= crc32_pclmul_finup,
-	.digest		= crc32_pclmul_digest,
-	.descsize	= sizeof(u32),
-	.digestsize	= CHKSUM_DIGEST_SIZE,
-	.base		= {
-			.cra_name		= "crc32",
-			.cra_driver_name	= "crc32-pclmul",
-			.cra_priority		= 200,
-			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-			.cra_blocksize		= CHKSUM_BLOCK_SIZE,
-			.cra_ctxsize		= sizeof(u32),
-			.cra_module		= THIS_MODULE,
-			.cra_init		= crc32_pclmul_cra_init,
-	}
-};
-
-static const struct x86_cpu_id crc32pclmul_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, crc32pclmul_cpu_id);
-
-
-static int __init crc32_pclmul_mod_init(void)
-{
-
-	if (!x86_match_cpu(crc32pclmul_cpu_id)) {
-		pr_info("PCLMULQDQ-NI instructions are not detected.\n");
-		return -ENODEV;
-	}
-	return crypto_register_shash(&alg);
-}
-
-static void __exit crc32_pclmul_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-module_init(crc32_pclmul_mod_init);
-module_exit(crc32_pclmul_mod_fini);
-
-MODULE_AUTHOR("Alexander Boyko <alexander_boyko@xyratex.com>");
-MODULE_DESCRIPTION("CRC32 algorithm (IEEE 802.3) accelerated with PCLMULQDQ");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crc32");
-MODULE_ALIAS_CRYPTO("crc32-pclmul");
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
deleted file mode 100644
index 603d159de400..000000000000
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ /dev/null
@@ -1,249 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Using hardware provided CRC32 instruction to accelerate the CRC32 disposal.
- * CRC32C polynomial:0x1EDC6F41(BE)/0x82F63B78(LE)
- * CRC32 is a new instruction in Intel SSE4.2, the reference can be found at:
- * http://www.intel.com/products/processor/manuals/
- * Intel(R) 64 and IA-32 Architectures Software Developer's Manual
- * Volume 2A: Instruction Set Reference, A-M
- *
- * Copyright (C) 2008 Intel Corporation
- * Authors: Austin Zhang <austin_zhang@linux.intel.com>
- *          Kent Liu <kent.liu@intel.com>
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/simd.h>
-
-#include <asm/cpufeatures.h>
-#include <asm/cpu_device_id.h>
-#include <asm/simd.h>
-
-#define CHKSUM_BLOCK_SIZE	1
-#define CHKSUM_DIGEST_SIZE	4
-
-#define SCALE_F	sizeof(unsigned long)
-
-#ifdef CONFIG_X86_64
-#define CRC32_INST "crc32q %1, %q0"
-#else
-#define CRC32_INST "crc32l %1, %0"
-#endif
-
-#ifdef CONFIG_X86_64
-/*
- * use carryless multiply version of crc32c when buffer
- * size is >= 512 to account
- * for fpu state save/restore overhead.
- */
-#define CRC32C_PCL_BREAKEVEN	512
-
-asmlinkage u32 crc32c_x86_3way(u32 crc, const u8 *buffer, size_t len);
-#endif /* CONFIG_X86_64 */
-
-static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)
-{
-	while (length--) {
-		asm("crc32b %1, %0"
-		    : "+r" (crc) : "rm" (*data));
-		data++;
-	}
-
-	return crc;
-}
-
-static u32 __pure crc32c_intel_le_hw(u32 crc, unsigned char const *p, size_t len)
-{
-	unsigned int iquotient = len / SCALE_F;
-	unsigned int iremainder = len % SCALE_F;
-	unsigned long *ptmp = (unsigned long *)p;
-
-	while (iquotient--) {
-		asm(CRC32_INST
-		    : "+r" (crc) : "rm" (*ptmp));
-		ptmp++;
-	}
-
-	if (iremainder)
-		crc = crc32c_intel_le_hw_byte(crc, (unsigned char *)ptmp,
-				 iremainder);
-
-	return crc;
-}
-
-/*
- * Setting the seed allows arbitrary accumulators and flexible XOR policy
- * If your algorithm starts with ~0, then XOR with ~0 before you set
- * the seed.
- */
-static int crc32c_intel_setkey(struct crypto_shash *hash, const u8 *key,
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
-static int crc32c_intel_init(struct shash_desc *desc)
-{
-	u32 *mctx = crypto_shash_ctx(desc->tfm);
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = *mctx;
-
-	return 0;
-}
-
-static int crc32c_intel_update(struct shash_desc *desc, const u8 *data,
-			       unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = crc32c_intel_le_hw(*crcp, data, len);
-	return 0;
-}
-
-static int __crc32c_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
-{
-	*(__le32 *)out = ~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
-	return 0;
-}
-
-static int crc32c_intel_finup(struct shash_desc *desc, const u8 *data,
-			      unsigned int len, u8 *out)
-{
-	return __crc32c_intel_finup(shash_desc_ctx(desc), data, len, out);
-}
-
-static int crc32c_intel_final(struct shash_desc *desc, u8 *out)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*(__le32 *)out = ~cpu_to_le32p(crcp);
-	return 0;
-}
-
-static int crc32c_intel_digest(struct shash_desc *desc, const u8 *data,
-			       unsigned int len, u8 *out)
-{
-	return __crc32c_intel_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
-}
-
-static int crc32c_intel_cra_init(struct crypto_tfm *tfm)
-{
-	u32 *key = crypto_tfm_ctx(tfm);
-
-	*key = ~0;
-
-	return 0;
-}
-
-#ifdef CONFIG_X86_64
-static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
-			       unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	/*
-	 * use faster PCL version if datasize is large enough to
-	 * overcome kernel fpu state save/restore overhead
-	 */
-	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*crcp = crc32c_x86_3way(*crcp, data, len);
-		kernel_fpu_end();
-	} else
-		*crcp = crc32c_intel_le_hw(*crcp, data, len);
-	return 0;
-}
-
-static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
-				u8 *out)
-{
-	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc32c_x86_3way(*crcp, data, len));
-		kernel_fpu_end();
-	} else
-		*(__le32 *)out =
-			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
-	return 0;
-}
-
-static int crc32c_pcl_intel_finup(struct shash_desc *desc, const u8 *data,
-			      unsigned int len, u8 *out)
-{
-	return __crc32c_pcl_intel_finup(shash_desc_ctx(desc), data, len, out);
-}
-
-static int crc32c_pcl_intel_digest(struct shash_desc *desc, const u8 *data,
-			       unsigned int len, u8 *out)
-{
-	return __crc32c_pcl_intel_finup(crypto_shash_ctx(desc->tfm), data, len,
-				    out);
-}
-#endif /* CONFIG_X86_64 */
-
-static struct shash_alg alg = {
-	.setkey			=	crc32c_intel_setkey,
-	.init			=	crc32c_intel_init,
-	.update			=	crc32c_intel_update,
-	.final			=	crc32c_intel_final,
-	.finup			=	crc32c_intel_finup,
-	.digest			=	crc32c_intel_digest,
-	.descsize		=	sizeof(u32),
-	.digestsize		=	CHKSUM_DIGEST_SIZE,
-	.base			=	{
-		.cra_name		=	"crc32c",
-		.cra_driver_name	=	"crc32c-intel",
-		.cra_priority		=	200,
-		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		=	sizeof(u32),
-		.cra_module		=	THIS_MODULE,
-		.cra_init		=	crc32c_intel_cra_init,
-	}
-};
-
-static const struct x86_cpu_id crc32c_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_XMM4_2, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, crc32c_cpu_id);
-
-static int __init crc32c_intel_mod_init(void)
-{
-	if (!x86_match_cpu(crc32c_cpu_id))
-		return -ENODEV;
-#ifdef CONFIG_X86_64
-	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
-		alg.update = crc32c_pcl_intel_update;
-		alg.finup = crc32c_pcl_intel_finup;
-		alg.digest = crc32c_pcl_intel_digest;
-	}
-#endif
-	return crypto_register_shash(&alg);
-}
-
-static void __exit crc32c_intel_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-module_init(crc32c_intel_mod_init);
-module_exit(crc32c_intel_mod_fini);
-
-MODULE_AUTHOR("Austin Zhang <austin.zhang@intel.com>, Kent Liu <kent.liu@intel.com>");
-MODULE_DESCRIPTION("CRC32c (Castagnoli) optimization using Intel Hardware.");
-MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crc32c");
-MODULE_ALIAS_CRYPTO("crc32c-intel");
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 98583a9dbab3..17510da06c9f 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -36,10 +36,14 @@ lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 
+obj-$(CONFIG_CRC32_ARCH) += crc32-x86.o
+crc32-x86-y := crc32-glue.o crc32-pclmul.o
+crc32-x86-$(CONFIG_64BIT) += crc32c-3way.o
+
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
new file mode 100644
index 000000000000..e830773f228d
--- /dev/null
+++ b/arch/x86/lib/crc32-glue.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * x86-optimized CRC32 functions
+ *
+ * Copyright (C) 2008 Intel Corporation
+ * Copyright 2012 Xyratex Technology Limited
+ * Copyright 2024 Google LLC
+ */
+
+#include <asm/cpufeatures.h>
+#include <asm/simd.h>
+#include <crypto/internal/simd.h>
+#include <linux/crc32.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+/* minimum size of buffer for crc32_pclmul_le_16 */
+#define CRC32_PCLMUL_MIN_LEN	64
+
+static DEFINE_STATIC_KEY_FALSE(have_crc32);
+static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
+
+u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
+
+u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	if (len >= CRC32_PCLMUL_MIN_LEN + 15 &&
+	    crypto_simd_usable() && static_branch_likely(&have_pclmulqdq)) {
+		size_t n = -(uintptr_t)p & 15;
+
+		/* align p to 16-byte boundary */
+		if (n) {
+			crc = crc32_le_base(crc, p, n);
+			p += n;
+			len -= n;
+		}
+		n = round_down(len, 16);
+		kernel_fpu_begin();
+		crc = crc32_pclmul_le_16(crc, p, n);
+		kernel_fpu_end();
+		p += n;
+		len -= n;
+	}
+	if (len)
+		crc = crc32_le_base(crc, p, len);
+	return crc;
+}
+EXPORT_SYMBOL(crc32_le_arch);
+
+#ifdef CONFIG_X86_64
+#define CRC32_INST "crc32q %1, %q0"
+#else
+#define CRC32_INST "crc32l %1, %0"
+#endif
+
+/*
+ * Use carryless multiply version of crc32c when buffer size is >= 512 to
+ * account for FPU state save/restore overhead.
+ */
+#define CRC32C_PCLMUL_BREAKEVEN	512
+
+asmlinkage u32 crc32c_x86_3way(u32 crc, const u8 *buffer, size_t len);
+
+u32 crc32c_le_arch(u32 crc, const u8 *p, size_t len)
+{
+	size_t num_longs;
+
+	if (!static_branch_likely(&have_crc32))
+		return crc32c_le_base(crc, p, len);
+
+	if (IS_ENABLED(CONFIG_X86_64) && len >= CRC32C_PCLMUL_BREAKEVEN &&
+	    crypto_simd_usable() && static_branch_likely(&have_pclmulqdq)) {
+		kernel_fpu_begin();
+		crc = crc32c_x86_3way(crc, p, len);
+		kernel_fpu_end();
+		return crc;
+	}
+
+	for (num_longs = len / sizeof(unsigned long);
+	     num_longs != 0; num_longs--, p += sizeof(unsigned long))
+		asm(CRC32_INST : "+r" (crc) : "rm" (*(unsigned long *)p));
+
+	for (len %= sizeof(unsigned long); len; len--, p++)
+		asm("crc32b %1, %0" : "+r" (crc) : "rm" (*p));
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
+static int __init crc32_x86_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_XMM4_2)) {
+		static_branch_enable(&have_crc32);
+		crc32_optimizations |= CRC32C_OPTIMIZATION;
+	}
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
+		static_branch_enable(&have_pclmulqdq);
+		crc32_optimizations |= CRC32_LE_OPTIMIZATION;
+	}
+	return 0;
+}
+arch_initcall(crc32_x86_init);
+
+static void __exit crc32_x86_exit(void)
+{
+}
+module_exit(crc32_x86_exit);
+
+MODULE_DESCRIPTION("x86-optimized CRC32 functions");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/lib/crc32-pclmul.S
similarity index 100%
rename from arch/x86/crypto/crc32-pclmul_asm.S
rename to arch/x86/lib/crc32-pclmul.S
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/lib/crc32c-3way.S
similarity index 100%
rename from arch/x86/crypto/crc32c-pcl-intel-asm_64.S
rename to arch/x86/lib/crc32c-3way.S
diff --git a/drivers/target/iscsi/Kconfig b/drivers/target/iscsi/Kconfig
index 922b207bc69d..1c0517a12571 100644
--- a/drivers/target/iscsi/Kconfig
+++ b/drivers/target/iscsi/Kconfig
@@ -2,11 +2,10 @@
 config ISCSI_TARGET
 	tristate "SCSI Target Mode Stack"
 	depends on INET
 	select CRYPTO
 	select CRYPTO_CRC32C
-	select CRYPTO_CRC32C_INTEL if X86
 	help
 	Say M to enable the SCSI target mode stack. A SCSI target mode stack
 	is software that makes local storage available over a storage network
 	to a SCSI initiator system. The supported storage network technologies
 	include iSCSI, Fibre Channel and the SCSI RDMA Protocol (SRP).
-- 
2.47.0


