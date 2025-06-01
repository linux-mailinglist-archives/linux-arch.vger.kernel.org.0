Return-Path: <linux-arch+bounces-12170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1994ACA0CB
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14FA17191E
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D4F23D280;
	Sun,  1 Jun 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHB3tBZf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1C23C8C9;
	Sun,  1 Jun 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817956; cv=none; b=Bcx9TfLCuHoBnpz0LQ2KT87oXto0BjBvc73W4pcxVErKm39n09mee43+Gik38KiPze5O9MqmvKzvwLKugK+unBfoUM5/h+zaHfbV9G6YxD6RRkKk1eUK0ARLsKtGqZEzqfi+zo7JFnzj51XNm+uFxBoYRhg58BE/iBGJhP5M1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817956; c=relaxed/simple;
	bh=Ha9zZQj7Jf+ffkE3L33bjFk9KtVZ+B+rHBHCMXqGDMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1BaSPPBjfgQ3k4moICNRrPA3Z4WvCTwquruqSq7xfyh0jLJv+7a8upNmxGqu1rFKbDdspwgkrsOBYvmEIjvNcqft9xw9DWDFMfUBZq81nlP171sEbBbIu+ckKS1IXFLdee4r2/CKb6p3tp2aJ6CigyQVeC6Ro5IX1Kn+0vc2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHB3tBZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E6C4CEF2;
	Sun,  1 Jun 2025 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748817955;
	bh=Ha9zZQj7Jf+ffkE3L33bjFk9KtVZ+B+rHBHCMXqGDMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHB3tBZfPR0PjTAc5bEh8QvmRpTFmwcLsr5xvk1n2uvTx326V6vHeCrpZ/MFdMfEy
	 /zcFJLTxddvTMQeRtAX9UoabfX1RmUPPO65iIVJ3kdVROHcmp+EEKa5FIHQbl4Ijk2
	 EqeLs/1TUVUsTxZWWtda0IJjyaN2a8crCnQPzG0CKd7cbv3rk7tCWtRTR6mQEBJlyY
	 Jq/ZBC38H2wbeNQsfSXOVopzeOz2AdR7YRJm5lf0fL2fc2CinDRR8OgtyovH4zNaa1
	 YGj1BBNx8IDtrfIl0DKH/xjb7B/gY46bWJ8iCRJKwj+VZY05/kRiR81Gt+eXKqMJG+
	 pYYt37HfRvjiA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 05/13] lib/crc/arm: migrate arm-optimized CRC code into lib/crc/
Date: Sun,  1 Jun 2025 15:44:33 -0700
Message-ID: <20250601224441.778374-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601224441.778374-1-ebiggers@kernel.org>
References: <20250601224441.778374-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the arm-optimized CRC code from arch/arm/lib/crc* into its new
location in lib/crc/arm/, and wire it up in the new way.  For a detailed
explanation of why this change is being made, see the commit that
introduced the new way of integrating arch-specific code into lib/crc/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/Kconfig                              |  2 -
 arch/arm/lib/Makefile                         |  6 ---
 lib/crc/Kconfig                               |  2 +
 lib/crc/Makefile                              |  2 +
 .../arm/lib => lib/crc/arm}/crc-t10dif-core.S |  0
 .../crc-t10dif.c => lib/crc/arm/crc-t10dif.h  | 23 ++---------
 {arch/arm/lib => lib/crc/arm}/crc32-core.S    |  0
 arch/arm/lib/crc32.c => lib/crc/arm/crc32.h   | 40 +++++--------------
 8 files changed, 16 insertions(+), 59 deletions(-)
 rename {arch/arm/lib => lib/crc/arm}/crc-t10dif-core.S (100%)
 rename arch/arm/lib/crc-t10dif.c => lib/crc/arm/crc-t10dif.h (70%)
 rename {arch/arm/lib => lib/crc/arm}/crc32-core.S (100%)
 rename arch/arm/lib/crc32.c => lib/crc/arm/crc32.h (69%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3072731fe09c5..c531b49aa98ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -6,12 +6,10 @@ config ARM
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CACHE_LINE_SIZE if OF
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
-	select ARCH_HAS_CRC32 if KERNEL_MODE_NEON
-	select ARCH_HAS_CRC_T10DIF if KERNEL_MODE_NEON
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_ALLOC if MMU
 	select ARCH_HAS_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 91ea0e29107af..d1b9ea2023648 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -45,11 +45,5 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
   CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-
-obj-$(CONFIG_CRC32_ARCH) += crc32-arm.o
-crc32-arm-y := crc32.o crc32-core.o
-
-obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-arm.o
-crc-t10dif-arm-y := crc-t10dif.o crc-t10dif-core.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 85b0dc774d722..b34a52cdba5d7 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -48,10 +48,11 @@ config ARCH_HAS_CRC_T10DIF
 	bool
 
 config CRC_T10DIF_ARCH
 	bool
 	depends on CRC_T10DIF && CRC_OPTIMIZATIONS
+	default y if ARM && KERNEL_MODE_NEON
 
 config CRC32
 	tristate
 	select BITREVERSE
 	help
@@ -59,10 +60,11 @@ config CRC32
 	  the functions from <linux/crc32.h> or <linux/crc32c.h>.
 
 config CRC32_ARCH
 	bool
 	depends on CRC32 && CRC_OPTIMIZATIONS
+	default y if ARM && KERNEL_MODE_NEON
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index 2f39385f97a5c..1069edb81a481 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -12,15 +12,17 @@ obj-$(CONFIG_CRC_CCITT) += crc-ccitt.o
 obj-$(CONFIG_CRC_ITU_T) += crc-itu-t.o
 
 obj-$(CONFIG_CRC_T10DIF) += crc-t10dif.o
 crc-t10dif-y := crc-t10dif-main.o
 ifeq ($(CONFIG_CRC_T10DIF_ARCH),y)
+crc-t10dif-$(CONFIG_ARM) += arm/crc-t10dif-core.o
 endif
 
 obj-$(CONFIG_CRC32) += crc32.o
 crc32-y := crc32-main.o
 ifeq ($(CONFIG_CRC32_ARCH),y)
+crc32-$(CONFIG_ARM) += arm/crc32-core.o
 endif
 
 obj-$(CONFIG_CRC64) += crc64.o
 crc64-y := crc64-main.o
 ifeq ($(CONFIG_CRC64_ARCH),y)
diff --git a/arch/arm/lib/crc-t10dif-core.S b/lib/crc/arm/crc-t10dif-core.S
similarity index 100%
rename from arch/arm/lib/crc-t10dif-core.S
rename to lib/crc/arm/crc-t10dif-core.S
diff --git a/arch/arm/lib/crc-t10dif.c b/lib/crc/arm/crc-t10dif.h
similarity index 70%
rename from arch/arm/lib/crc-t10dif.c
rename to lib/crc/arm/crc-t10dif.h
index 1093f8ec13b0b..2edf7e9681d05 100644
--- a/arch/arm/lib/crc-t10dif.c
+++ b/lib/crc/arm/crc-t10dif.h
@@ -3,16 +3,10 @@
  * Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions instructions
  *
  * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <linux/crc-t10dif.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
 #include <crypto/internal/simd.h>
 
 #include <asm/neon.h>
 #include <asm/simd.h>
 
@@ -23,11 +17,11 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pmull);
 
 asmlinkage u16 crc_t10dif_pmull64(u16 init_crc, const u8 *buf, size_t len);
 asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
 				  u8 out[16]);
 
-u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
+static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
 		if (static_branch_likely(&have_pmull)) {
 			if (crypto_simd_usable()) {
 				kernel_neon_begin();
@@ -47,26 +41,15 @@ u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
 	}
 	return crc_t10dif_generic(crc, data, length);
 }
-EXPORT_SYMBOL(crc_t10dif_arch);
 
-static int __init crc_t10dif_arm_init(void)
+#define crc_t10dif_mod_init_arch crc_t10dif_mod_init_arch
+static inline void crc_t10dif_mod_init_arch(void)
 {
 	if (elf_hwcap & HWCAP_NEON) {
 		static_branch_enable(&have_neon);
 		if (elf_hwcap2 & HWCAP2_PMULL)
 			static_branch_enable(&have_pmull);
 	}
-	return 0;
 }
-subsys_initcall(crc_t10dif_arm_init);
-
-static void __exit crc_t10dif_arm_exit(void)
-{
-}
-module_exit(crc_t10dif_arm_exit);
-
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_DESCRIPTION("Accelerated CRC-T10DIF using ARM NEON and Crypto Extensions");
-MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/lib/crc32-core.S b/lib/crc/arm/crc32-core.S
similarity index 100%
rename from arch/arm/lib/crc32-core.S
rename to lib/crc/arm/crc32-core.S
diff --git a/arch/arm/lib/crc32.c b/lib/crc/arm/crc32.h
similarity index 69%
rename from arch/arm/lib/crc32.c
rename to lib/crc/arm/crc32.h
index f2bef8849c7c3..19e6e35f6418f 100644
--- a/arch/arm/lib/crc32.c
+++ b/lib/crc/arm/crc32.h
@@ -4,15 +4,10 @@
  *
  * Copyright (C) 2016 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
 #include <linux/cpufeature.h>
-#include <linux/crc32.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
 
 #include <crypto/internal/simd.h>
 
 #include <asm/hwcap.h>
 #include <asm/neon.h>
@@ -27,18 +22,19 @@ asmlinkage u32 crc32_pmull_le(const u8 buf[], u32 len, u32 init_crc);
 asmlinkage u32 crc32_armv8_le(u32 init_crc, const u8 buf[], u32 len);
 
 asmlinkage u32 crc32c_pmull_le(const u8 buf[], u32 len, u32 init_crc);
 asmlinkage u32 crc32c_armv8_le(u32 init_crc, const u8 buf[], u32 len);
 
-static u32 crc32_le_scalar(u32 crc, const u8 *p, size_t len)
+static inline u32 crc32_le_scalar(u32 crc, const u8 *p, size_t len)
 {
 	if (static_branch_likely(&have_crc32))
 		return crc32_armv8_le(crc, p, len);
 	return crc32_le_base(crc, p, len);
 }
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+#define crc32_le_arch crc32_le_arch
+static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
 	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
 		size_t n = -(uintptr_t)p & 15;
 
@@ -55,20 +51,20 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 		p += n;
 		len -= n;
 	}
 	return crc32_le_scalar(crc, p, len);
 }
-EXPORT_SYMBOL(crc32_le_arch);
 
-static u32 crc32c_scalar(u32 crc, const u8 *p, size_t len)
+static inline u32 crc32c_scalar(u32 crc, const u8 *p, size_t len)
 {
 	if (static_branch_likely(&have_crc32))
 		return crc32c_armv8_le(crc, p, len);
 	return crc32c_base(crc, p, len);
 }
 
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
+#define crc32c_arch crc32c_arch
+static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
 	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
 		size_t n = -(uintptr_t)p & 15;
 
@@ -85,39 +81,21 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 		p += n;
 		len -= n;
 	}
 	return crc32c_scalar(crc, p, len);
 }
-EXPORT_SYMBOL(crc32c_arch);
 
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_be_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
-
-static int __init crc32_arm_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	if (elf_hwcap2 & HWCAP2_CRC32)
 		static_branch_enable(&have_crc32);
 	if (elf_hwcap2 & HWCAP2_PMULL)
 		static_branch_enable(&have_pmull);
-	return 0;
 }
-subsys_initcall(crc32_arm_init);
 
-static void __exit crc32_arm_exit(void)
-{
-}
-module_exit(crc32_arm_exit);
-
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	if (elf_hwcap2 & (HWCAP2_CRC32 | HWCAP2_PMULL))
 		return CRC32_LE_OPTIMIZATION | CRC32C_OPTIMIZATION;
 	return 0;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
-MODULE_DESCRIPTION("Accelerated CRC32(C) using ARM CRC, NEON and Crypto Extensions");
-MODULE_LICENSE("GPL v2");
-- 
2.49.0


