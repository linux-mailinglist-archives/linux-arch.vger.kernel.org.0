Return-Path: <linux-arch+bounces-12270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C8AD0F5A
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0816A79C
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E7F219302;
	Sat,  7 Jun 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTfXrhqp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F3218EBF;
	Sat,  7 Jun 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326850; cv=none; b=GxI9oGz+6tGCWS1KP/NrvbRcdON1Lt1d96XeP/jsAlcpOfZGiFc/tLCgAJrIgRKr+VvqAWXwi4B9uM28VmNF2u6coTaZQ0AJ0+qU2UZRWS/AtiAUopLV1zYoprj5BrNQVEN9xMp2Q1QyRhX2DZ5QlNenNGb1MMSGUBKqedyTGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326850; c=relaxed/simple;
	bh=sDKX0MxyKMIL+HZ/mXu69f6T4IOkE11+BdTbwDYdB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF4+M+zQ5fi/0kv2b38EbKhIJizzBKD+vuo+lsuqMtqA5ISdgN9bvLPa6ZiLHaOwpgFjnEW7Ain8k7cIoLuOBmkayvbirNJIFOsnatOULs+tQTyiWHTfW+CptRaIQceiUT7fg9PbtT1uFIXT5iCy+RzP3NnjwXGghli3Q+SX78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTfXrhqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678B4C4CEF6;
	Sat,  7 Jun 2025 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326849;
	bh=sDKX0MxyKMIL+HZ/mXu69f6T4IOkE11+BdTbwDYdB/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTfXrhqpFlnkZTgQrji+Og+HrxqlZiXD94N/b4vQ4dcwfjOCpaHzuq+5nzA7kNFMw
	 OEkYSRG2dd58HHKjnA0EraCPfAMqk20IUxbiQ7x1g/INvmbiLTdkEDxU1m+ah+5Qto
	 egViG3MIi9m5LmMoD4YIIE3SdjKdp+ub+HsGVVbNB/B31RASYhvKw77kJYT7ef2cdN
	 yPF5nOTYwYDW6kfgpV+XLEM55tulrzlsOCOYqF/2lxDtF54k3ooNGvsw53az5iuumM
	 zQ0Ac4aUcCCpjyrpej4Rrb7nWEjEdvHdysCxxHsXX5R0pnjiJ+d2cMkS9WrvlmTlz5
	 tQ7NM6IqVseJA==
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
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 03/12] lib/crc/arm: migrate arm-optimized CRC code into lib/crc/
Date: Sat,  7 Jun 2025 13:04:45 -0700
Message-ID: <20250607200454.73587-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the arm-optimized CRC code from arch/arm/lib/crc* into its new
location in lib/crc/arm/, and wire it up in the new way.  This new way
of organizing the CRC code eliminates the need to artificially split the
code for each CRC variant into separate arch and generic modules,
enabling better inlining and dead code elimination.  For more details,
see "lib/crc: prepare for arch-optimized code in subdirs of lib/crc/".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/Kconfig                              |  2 -
 arch/arm/lib/Makefile                         |  6 ---
 lib/crc/Kconfig                               |  2 +
 lib/crc/Makefile                              |  2 +
 .../arm/lib => lib/crc/arm}/crc-t10dif-core.S |  0
 .../crc-t10dif.c => lib/crc/arm/crc-t10dif.h  | 23 ++---------
 {arch/arm/lib => lib/crc/arm}/crc32-core.S    |  0
 arch/arm/lib/crc32.c => lib/crc/arm/crc32.h   | 38 ++++---------------
 8 files changed, 15 insertions(+), 58 deletions(-)
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
index e049f01a4d2c8..edd1b99098003 100644
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
@@ -62,10 +63,11 @@ config ARCH_HAS_CRC32
 	bool
 
 config CRC32_ARCH
 	bool
 	depends on CRC32 && CRC_OPTIMIZATIONS
+	default y if ARM && KERNEL_MODE_NEON
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index 926edc3b035f6..c72d351be6cb8 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -11,16 +11,18 @@ obj-$(CONFIG_CRC_ITU_T) += crc-itu-t.o
 
 obj-$(CONFIG_CRC_T10DIF) += crc-t10dif.o
 crc-t10dif-y := crc-t10dif-main.o
 ifeq ($(CONFIG_CRC_T10DIF_ARCH),y)
 CFLAGS_crc-t10dif-main.o += -I$(src)/$(SRCARCH)
+crc-t10dif-$(CONFIG_ARM) += arm/crc-t10dif-core.o
 endif
 
 obj-$(CONFIG_CRC32) += crc32.o
 crc32-y := crc32-main.o
 ifeq ($(CONFIG_CRC32_ARCH),y)
 CFLAGS_crc32-main.o += -I$(src)/$(SRCARCH)
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
index f2bef8849c7c3..018007e162a2b 100644
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
@@ -27,18 +22,18 @@ asmlinkage u32 crc32_pmull_le(const u8 buf[], u32 len, u32 init_crc);
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
+static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
 	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
 		size_t n = -(uintptr_t)p & 15;
 
@@ -55,20 +50,19 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
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
+static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (len >= PMULL_MIN_LEN + 15 &&
 	    static_branch_likely(&have_pmull) && crypto_simd_usable()) {
 		size_t n = -(uintptr_t)p & 15;
 
@@ -85,39 +79,23 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
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
+#define crc32_be_arch crc32_be_base /* not implemented on this arch */
 
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


