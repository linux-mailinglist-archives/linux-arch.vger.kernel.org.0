Return-Path: <linux-arch+bounces-9120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE69D01A3
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6F2863B2
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8F2940B;
	Sun, 17 Nov 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/WRIE0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CF208DA;
	Sun, 17 Nov 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803036; cv=none; b=Bn0ef+jAFTcNPau1w8n1w9BKuttWwUd/ee7pj6dBl1qyB2uB8eixoZCDqqDh0c/Wq8Ej1+0yinyXG9P2YU12Z4BDKSST00OXRWpIXb+m80/jO6b70MfQ8GQWACFzoT6stNbePcvWKVbj8FY4VD2/lQcseR/aRYJbb1sRVoTg+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803036; c=relaxed/simple;
	bh=nFQhcMX9hP5eFAfXK/vU9okZxNC7og39G0++xIR9h4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZk5CDNF0uaRWmf9f9rctChhlPrajem0ltUZJnd6Zspurcny4a2SUxnyUoevupHMJ6e06ZwgqiUh63ZQOsUnEEnlOlX2S9o39o3PR2GdVBhHrhD0kgpPixYqLaF7SltAAFZQWeV4dPHlTP/fBYUzEVne60vuxG4zmOTFoEInClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/WRIE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B48FC4CED6;
	Sun, 17 Nov 2024 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803036;
	bh=nFQhcMX9hP5eFAfXK/vU9okZxNC7og39G0++xIR9h4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ/WRIE0Rrvn0ogmtqY3Sc9gX4jQ2KCq4CC3sDRVTqivK5dJPwlSCGLX7VSMfszr0
	 k37Wy46ks0OzF6e9s3p5lDv87UxcQXyKyCwp0E7i2d8ENRi2/K/CkikIsynHeQTBce
	 OchveTHxN364Y2y1VQ7U8sSKQ6hLQkzBwmRPO5f7FOOWJfjt5tJbSmT+FiRgAhF9Gw
	 x1A8J8Bv6R78IYj6WqE0LtpSJF13dq7Mh0wNwugnv7o0Zocq3VUW9Uqm8MmfcAsCJr
	 USrbLZtB6vyHm7QXNbC789zyS5hsQbqrqZ/4D1HHn75TFGhh+5/21ZlKRlbZbsxj9k
	 FYL/Gy0H+VLHQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 07/11] powerpc/crc-t10dif: expose CRC-T10DIF function through lib
Date: Sat, 16 Nov 2024 16:22:40 -0800
Message-ID: <20241117002244.105200-8-ebiggers@kernel.org>
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

Move the powerpc CRC-T10DIF assembly code into the lib directory and
wire it up to the library interface.  This allows it to be used without
going through the crypto API.  It remains usable via the crypto API too
via the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/powerpc/crypto/crct10dif-vpmsum_glue.c
to arch/powerpc/lib/crc-t10dif-glue.c, view this commit with
'git show -M10'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/configs/powernv_defconfig        |  1 -
 arch/powerpc/configs/ppc64_defconfig          |  1 -
 arch/powerpc/crypto/Kconfig                   | 15 +---
 arch/powerpc/crypto/Makefile                  |  2 -
 arch/powerpc/lib/Makefile                     |  3 +
 .../crc-t10dif-glue.c}                        | 69 +++++--------------
 .../{crypto => lib}/crct10dif-vpmsum_asm.S    |  2 +-
 8 files changed, 23 insertions(+), 71 deletions(-)
 rename arch/powerpc/{crypto/crct10dif-vpmsum_glue.c => lib/crc-t10dif-glue.c} (50%)
 rename arch/powerpc/{crypto => lib}/crct10dif-vpmsum_asm.S (99%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b05889400b04..ffd5f487dd76 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,10 +126,11 @@ config PPC
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
 	select ARCH_HAS_CRC32			if PPC64 && ALTIVEC
+	select ARCH_HAS_CRC_T10DIF		if PPC64 && ALTIVEC
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX		if STRICT_KERNEL_RWX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 4a7ddea05b4d..6b6d7467fecf 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -318,11 +318,10 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_CRCT10DIF_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_WP512=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index ea01c0d6705f..ec91e0104713 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -388,11 +388,10 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRYPTO_CRCT10DIF_VPMSUM=m
 CONFIG_CRYPTO_VPMSUM_TESTER=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_AES_GCM_P10=m
 CONFIG_CRYPTO_DEV_NX=y
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index f1ded2b11ab6..90ac79513923 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -11,25 +11,14 @@ config CRYPTO_CURVE25519_PPC64
 	  Curve25519 algorithm
 
 	  Architecture: PowerPC64
 	  - Little-endian
 
-config CRYPTO_CRCT10DIF_VPMSUM
-	tristate "CRC32T10DIF"
-	depends on PPC64 && ALTIVEC && CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
-
-	  Architecture: powerpc64 using
-	  - AltiVec extensions
-
-	  Enable on POWER8 and newer processors for improved performance.
-
 config CRYPTO_VPMSUM_TESTER
 	tristate "CRC32c and CRC32T10DIF hardware acceleration tester"
-	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C && CRC32_ARCH
+	depends on CRYPTO_CRC32C && CRC32_ARCH
+	depends on CRYPTO_CRCT10DIF && CRC_T10DIF_ARCH
 	help
 	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
 	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
 	  Unless you are testing these algorithms, you don't need this.
 
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 54486192273c..d2238ac7e52c 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -8,11 +8,10 @@
 obj-$(CONFIG_CRYPTO_AES_PPC_SPE) += aes-ppc-spe.o
 obj-$(CONFIG_CRYPTO_MD5_PPC) += md5-ppc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC) += sha1-powerpc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC_SPE) += sha1-ppc-spe.o
 obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
-obj-$(CONFIG_CRYPTO_CRCT10DIF_VPMSUM) += crct10dif-vpmsum.o
 obj-$(CONFIG_CRYPTO_VPMSUM_TESTER) += crc-vpmsum_test.o
 obj-$(CONFIG_CRYPTO_AES_GCM_P10) += aes-gcm-p10-crypto.o
 obj-$(CONFIG_CRYPTO_CHACHA20_P10) += chacha-p10-crypto.o
 obj-$(CONFIG_CRYPTO_POLY1305_P10) += poly1305-p10-crypto.o
 obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
@@ -21,11 +20,10 @@ obj-$(CONFIG_CRYPTO_CURVE25519_PPC64) += curve25519-ppc64le.o
 aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
 md5-ppc-y := md5-asm.o md5-glue.o
 sha1-powerpc-y := sha1-powerpc-asm.o sha1.o
 sha1-ppc-spe-y := sha1-spe-asm.o sha1-spe-glue.o
 sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
-crct10dif-vpmsum-y := crct10dif-vpmsum_asm.o crct10dif-vpmsum_glue.o
 aes-gcm-p10-crypto-y := aes-gcm-p10-glue.o aes-gcm-p10.o ghashp10-ppc.o aesp10-ppc.o
 chacha-p10-crypto-y := chacha-p10-glue.o chacha-p10le-8x.o
 poly1305-p10-crypto-y := poly1305-p10-glue.o poly1305-p10le_64.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 curve25519-ppc64le-y := curve25519-ppc64le-core.o curve25519-ppc64le_asm.o
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index da9381a1c95b..dd8a4b52a0cc 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -79,6 +79,9 @@ CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
 obj-$(CONFIG_CRC32_ARCH) += crc32-powerpc.o
 crc32-powerpc-y := crc32-glue.o crc32c-vpmsum_asm.o
 
+obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-powerpc.o
+crc-t10dif-powerpc-y := crc-t10dif-glue.o crct10dif-vpmsum_asm.o
+
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c b/arch/powerpc/lib/crc-t10dif-glue.c
similarity index 50%
rename from arch/powerpc/crypto/crct10dif-vpmsum_glue.c
rename to arch/powerpc/lib/crc-t10dif-glue.c
index 1dc8b6915178..730850dbc51d 100644
--- a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
+++ b/arch/powerpc/lib/crc-t10dif-glue.c
@@ -5,11 +5,10 @@
  * Copyright 2017, Daniel Axtens, IBM Corporation.
  * [based on crc32c-vpmsum_glue.c]
  */
 
 #include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -20,19 +19,22 @@
 #define VMX_ALIGN		16
 #define VMX_ALIGN_MASK		(VMX_ALIGN-1)
 
 #define VECTOR_BREAKPOINT	64
 
+static DEFINE_STATIC_KEY_FALSE(have_vec_crypto);
+
 u32 __crct10dif_vpmsum(u32 crc, unsigned char const *p, size_t len);
 
-static u16 crct10dif_vpmsum(u16 crci, unsigned char const *p, size_t len)
+u16 crc_t10dif_arch(u16 crci, const u8 *p, size_t len)
 {
 	unsigned int prealign;
 	unsigned int tail;
 	u32 crc = crci;
 
-	if (len < (VECTOR_BREAKPOINT + VMX_ALIGN) || !crypto_simd_usable())
+	if (len < (VECTOR_BREAKPOINT + VMX_ALIGN) ||
+	    !static_branch_likely(&have_vec_crypto) || !crypto_simd_usable())
 		return crc_t10dif_generic(crc, p, len);
 
 	if ((unsigned long)p & VMX_ALIGN_MASK) {
 		prealign = VMX_ALIGN - ((unsigned long)p & VMX_ALIGN_MASK);
 		crc = crc_t10dif_generic(crc, p, prealign);
@@ -58,69 +60,30 @@ static u16 crct10dif_vpmsum(u16 crci, unsigned char const *p, size_t len)
 		crc = crc_t10dif_generic(crc, p, tail);
 	}
 
 	return crc & 0xffff;
 }
+EXPORT_SYMBOL(crc_t10dif_arch);
 
-static int crct10dif_vpmsum_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_vpmsum_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = crct10dif_vpmsum(*crc, data, length);
-
-	return 0;
-}
-
-
-static int crct10dif_vpmsum_final(struct shash_desc *desc, u8 *out)
+static int __init crc_t10dif_powerpc_init(void)
 {
-	u16 *crcp = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crcp;
+	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
+	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
+		static_branch_enable(&have_vec_crypto);
 	return 0;
 }
+arch_initcall(crc_t10dif_powerpc_init);
 
-static struct shash_alg alg = {
-	.init		= crct10dif_vpmsum_init,
-	.update		= crct10dif_vpmsum_update,
-	.final		= crct10dif_vpmsum_final,
-	.descsize	= CRC_T10DIF_DIGEST_SIZE,
-	.digestsize	= CRC_T10DIF_DIGEST_SIZE,
-	.base		= {
-		.cra_name		= "crct10dif",
-		.cra_driver_name	= "crct10dif-vpmsum",
-		.cra_priority		= 200,
-		.cra_blocksize		= CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-};
-
-static int __init crct10dif_vpmsum_mod_init(void)
+static void __exit crc_t10dif_powerpc_exit(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-		return -ENODEV;
-
-	return crypto_register_shash(&alg);
 }
+module_exit(crc_t10dif_powerpc_exit);
 
-static void __exit crct10dif_vpmsum_mod_fini(void)
+bool crc_t10dif_is_optimized(void)
 {
-	crypto_unregister_shash(&alg);
+	return static_key_enabled(&have_vec_crypto);
 }
-
-module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crct10dif_vpmsum_mod_init);
-module_exit(crct10dif_vpmsum_mod_fini);
+EXPORT_SYMBOL(crc_t10dif_is_optimized);
 
 MODULE_AUTHOR("Daniel Axtens <dja@axtens.net>");
 MODULE_DESCRIPTION("CRCT10DIF using vector polynomial multiply-sum instructions");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-vpmsum");
diff --git a/arch/powerpc/crypto/crct10dif-vpmsum_asm.S b/arch/powerpc/lib/crct10dif-vpmsum_asm.S
similarity index 99%
rename from arch/powerpc/crypto/crct10dif-vpmsum_asm.S
rename to arch/powerpc/lib/crct10dif-vpmsum_asm.S
index 0a52261bf859..f0b93a0fe168 100644
--- a/arch/powerpc/crypto/crct10dif-vpmsum_asm.S
+++ b/arch/powerpc/lib/crct10dif-vpmsum_asm.S
@@ -840,6 +840,6 @@
 	.octa 0x000000000000000000000001f65a57f8	/* x^64 div p(x) */
 	/* Barrett constant n */
 	.octa 0x0000000000000000000000018bb70000
 
 #define CRC_FUNCTION_NAME __crct10dif_vpmsum
-#include "../lib/crc32-vpmsum_core.S"
+#include "crc32-vpmsum_core.S"
-- 
2.47.0


