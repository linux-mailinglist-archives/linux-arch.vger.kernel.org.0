Return-Path: <linux-arch+bounces-12278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A760AD0F93
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7B418906A7
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2321FF5B;
	Sat,  7 Jun 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLj0TS3w"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA921FF38;
	Sat,  7 Jun 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326854; cv=none; b=Le3bREux5RSKrGH4WrBzCFdgBWhDG9xXBo6t3jzyzXyqA1ahpoKAIMnc/PBlswCXRnfbkeieG6H/GE13HzOobMSDJIljU3IYgJ3LtiNV9L3tIVx+Dyy5Wc76t/AD2jA8bZcCJl9kzkQbW5UUi3xAm3aaHLyX2kKS3hTsTyTdHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326854; c=relaxed/simple;
	bh=jIlzvyOH3lz8ceAH2y7iElk7+J1Jw8+v3KjhKiaWPsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgYGfrpdOTKZ0e9aBYthtAbXCSWf8I/9OOwxld3f6vZoqlChYdv4o1kOkscve/JMAhYACWGP4iPD2Ess+hZ3NMn87sFYkQgKO7TRileJY1hZuNb3HVKoZTU3vJzNdr8rZy0SR/t0RMKDBPj35gIbopUI4JOfFZsenOovw1ZDsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLj0TS3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9269EC4CEF1;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326854;
	bh=jIlzvyOH3lz8ceAH2y7iElk7+J1Jw8+v3KjhKiaWPsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLj0TS3wOnKV3XdlHRKqAtQfuh56XhiYerch2IoCBZDySahPA9vBdGkFovPasy7BB
	 ri7jwBaWZ3G3CjFkKNWJ5CjTweFueFDBA0HO5kf47VkD0JsVJzkQ1eoA2jSA6YrdVE
	 HdVGUu/5vklpc5Pvo6rMK9nTdMtQ0LYgXKCwNmOCw+qci2pUAl9ZLtUYeSP2fgMMn0
	 NbKuJqU2PgJIMSub5oqyFfbIg6yKXMiTedYAcxHj68USQFujMAxP02FbSWO4Hps5mY
	 EPUaKyVJbYPOTZfokOSvEdI6dM7valKr/PA4vnSyIGDJ7mosNmRw1MzfhqSninIrPL
	 FnJPsPRJfImZg==
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
Subject: [PATCH v2 11/12] lib/crc/x86: migrate x86-optimized CRC code into lib/crc/
Date: Sat,  7 Jun 2025 13:04:53 -0700
Message-ID: <20250607200454.73587-12-ebiggers@kernel.org>
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

Move the x86-optimized CRC code from arch/x86/lib/crc* into its new
location in lib/crc/x86/, and wire it up in the new way.  This new way
of organizing the CRC code eliminates the need to artificially split the
code for each CRC variant into separate arch and generic modules,
enabling better inlining and dead code elimination.  For more details,
see "lib/crc: prepare for arch-optimized code in subdirs of lib/crc/".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig                              |  3 --
 arch/x86/lib/Makefile                         | 10 -------
 lib/crc/Kconfig                               |  3 ++
 lib/crc/Makefile                              |  4 +++
 .../lib => lib/crc/x86}/crc-pclmul-consts.h   |  0
 .../lib => lib/crc/x86}/crc-pclmul-template.S |  0
 .../lib => lib/crc/x86}/crc-pclmul-template.h |  0
 .../crc-t10dif.c => lib/crc/x86/crc-t10dif.h  | 18 ++---------
 .../lib => lib/crc/x86}/crc16-msb-pclmul.S    |  0
 {arch/x86/lib => lib/crc/x86}/crc32-pclmul.S  |  0
 arch/x86/lib/crc32.c => lib/crc/x86/crc32.h   | 30 ++++---------------
 {arch/x86/lib => lib/crc/x86}/crc32c-3way.S   |  0
 {arch/x86/lib => lib/crc/x86}/crc64-pclmul.S  |  0
 arch/x86/lib/crc64.c => lib/crc/x86/crc64.h   | 21 +++----------
 14 files changed, 20 insertions(+), 69 deletions(-)
 rename {arch/x86/lib => lib/crc/x86}/crc-pclmul-consts.h (100%)
 rename {arch/x86/lib => lib/crc/x86}/crc-pclmul-template.S (100%)
 rename {arch/x86/lib => lib/crc/x86}/crc-pclmul-template.h (100%)
 rename arch/x86/lib/crc-t10dif.c => lib/crc/x86/crc-t10dif.h (56%)
 rename {arch/x86/lib => lib/crc/x86}/crc16-msb-pclmul.S (100%)
 rename {arch/x86/lib => lib/crc/x86}/crc32-pclmul.S (100%)
 rename arch/x86/lib/crc32.c => lib/crc/x86/crc32.h (76%)
 rename {arch/x86/lib => lib/crc/x86}/crc32c-3way.S (100%)
 rename {arch/x86/lib => lib/crc/x86}/crc64-pclmul.S (100%)
 rename arch/x86/lib/crc64.c => lib/crc/x86/crc64.h (61%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 340e5468980e0..6181f414f87ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -77,13 +77,10 @@ config X86
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
-	select ARCH_HAS_CRC32
-	select ARCH_HAS_CRC64			if X86_64
-	select ARCH_HAS_CRC_T10DIF
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 4fa5c4e1ba8a0..dc5ee2a6938c4 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -38,20 +38,10 @@ lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 
-obj-$(CONFIG_CRC32_ARCH) += crc32-x86.o
-crc32-x86-y := crc32.o crc32-pclmul.o
-crc32-x86-$(CONFIG_64BIT) += crc32c-3way.o
-
-obj-$(CONFIG_CRC64_ARCH) += crc64-x86.o
-crc64-x86-y := crc64.o crc64-pclmul.o
-
-obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-x86.o
-crc-t10dif-x86-y := crc-t10dif.o crc16-msb-pclmul.o
-
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
         obj-y += atomic64_32.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index af4fa857a81f8..de4b2182ae7ff 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -52,10 +52,11 @@ config CRC_T10DIF_ARCH
 	depends on CRC_T10DIF && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64 && KERNEL_MODE_NEON
 	default y if PPC64 && ALTIVEC
 	default y if RISCV && RISCV_ISA_ZBC
+	default y if X86
 
 config CRC32
 	tristate
 	select BITREVERSE
 	help
@@ -74,10 +75,11 @@ config CRC32_ARCH
 	default y if MIPS && CPU_MIPSR6
 	default y if PPC64 && ALTIVEC
 	default y if RISCV && RISCV_ISA_ZBC
 	default y if S390
 	default y if SPARC64
+	default y if X86
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
@@ -88,10 +90,11 @@ config ARCH_HAS_CRC64
 
 config CRC64_ARCH
 	bool
 	depends on CRC64 && CRC_OPTIMIZATIONS
 	default y if RISCV && RISCV_ISA_ZBC && 64BIT
+	default y if X86_64
 
 config CRC_OPTIMIZATIONS
 	bool "Enable optimized CRC implementations" if EXPERT
 	default y
 	help
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index 81e176db0947c..7543ad295ab6f 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -15,10 +15,11 @@ ifeq ($(CONFIG_CRC_T10DIF_ARCH),y)
 CFLAGS_crc-t10dif-main.o += -I$(src)/$(SRCARCH)
 crc-t10dif-$(CONFIG_ARM) += arm/crc-t10dif-core.o
 crc-t10dif-$(CONFIG_ARM64) += arm64/crc-t10dif-core.o
 crc-t10dif-$(CONFIG_PPC) += powerpc/crct10dif-vpmsum_asm.o
 crc-t10dif-$(CONFIG_RISCV) += riscv/crc16_msb.o
+crc-t10dif-$(CONFIG_X86) += x86/crc16-msb-pclmul.o
 endif
 
 obj-$(CONFIG_CRC32) += crc32.o
 crc32-y := crc32-main.o
 ifeq ($(CONFIG_CRC32_ARCH),y)
@@ -27,17 +28,20 @@ crc32-$(CONFIG_ARM) += arm/crc32-core.o
 crc32-$(CONFIG_ARM64) += arm64/crc32-core.o
 crc32-$(CONFIG_PPC) += powerpc/crc32c-vpmsum_asm.o
 crc32-$(CONFIG_RISCV) += riscv/crc32_lsb.o riscv/crc32_msb.o
 crc32-$(CONFIG_S390) += s390/crc32le-vx.o s390/crc32be-vx.o
 crc32-$(CONFIG_SPARC) += sparc/crc32c_asm.o
+crc32-$(CONFIG_X86) += x86/crc32-pclmul.o
+crc32-$(CONFIG_X86_64) += x86/crc32c-3way.o
 endif
 
 obj-$(CONFIG_CRC64) += crc64.o
 crc64-y := crc64-main.o
 ifeq ($(CONFIG_CRC64_ARCH),y)
 CFLAGS_crc64-main.o += -I$(src)/$(SRCARCH)
 crc64-$(CONFIG_RISCV) += riscv/crc64_lsb.o riscv/crc64_msb.o
+crc64-$(CONFIG_X86) += x86/crc64-pclmul.o
 endif
 
 obj-y += tests/
 
 hostprogs := gen_crc32table gen_crc64table
diff --git a/arch/x86/lib/crc-pclmul-consts.h b/lib/crc/x86/crc-pclmul-consts.h
similarity index 100%
rename from arch/x86/lib/crc-pclmul-consts.h
rename to lib/crc/x86/crc-pclmul-consts.h
diff --git a/arch/x86/lib/crc-pclmul-template.S b/lib/crc/x86/crc-pclmul-template.S
similarity index 100%
rename from arch/x86/lib/crc-pclmul-template.S
rename to lib/crc/x86/crc-pclmul-template.S
diff --git a/arch/x86/lib/crc-pclmul-template.h b/lib/crc/x86/crc-pclmul-template.h
similarity index 100%
rename from arch/x86/lib/crc-pclmul-template.h
rename to lib/crc/x86/crc-pclmul-template.h
diff --git a/arch/x86/lib/crc-t10dif.c b/lib/crc/x86/crc-t10dif.h
similarity index 56%
rename from arch/x86/lib/crc-t10dif.c
rename to lib/crc/x86/crc-t10dif.h
index db7ce59c31ace..eb1f23db4daa1 100644
--- a/arch/x86/lib/crc-t10dif.c
+++ b/lib/crc/x86/crc-t10dif.h
@@ -3,38 +3,26 @@
  * CRC-T10DIF using [V]PCLMULQDQ instructions
  *
  * Copyright 2024 Google LLC
  */
 
-#include <linux/crc-t10dif.h>
-#include <linux/module.h>
 #include "crc-pclmul-template.h"
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
 DECLARE_CRC_PCLMUL_FUNCS(crc16_msb, u16);
 
-u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len)
+static inline u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len)
 {
 	CRC_PCLMUL(crc, p, len, crc16_msb, crc16_msb_0x8bb7_consts,
 		   have_pclmulqdq);
 	return crc_t10dif_generic(crc, p, len);
 }
-EXPORT_SYMBOL(crc_t10dif_arch);
 
-static int __init crc_t10dif_x86_init(void)
+#define crc_t10dif_mod_init_arch crc_t10dif_mod_init_arch
+static inline void crc_t10dif_mod_init_arch(void)
 {
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc16_msb);
 	}
-	return 0;
 }
-subsys_initcall(crc_t10dif_x86_init);
-
-static void __exit crc_t10dif_x86_exit(void)
-{
-}
-module_exit(crc_t10dif_x86_exit);
-
-MODULE_DESCRIPTION("CRC-T10DIF using [V]PCLMULQDQ instructions");
-MODULE_LICENSE("GPL");
diff --git a/arch/x86/lib/crc16-msb-pclmul.S b/lib/crc/x86/crc16-msb-pclmul.S
similarity index 100%
rename from arch/x86/lib/crc16-msb-pclmul.S
rename to lib/crc/x86/crc16-msb-pclmul.S
diff --git a/arch/x86/lib/crc32-pclmul.S b/lib/crc/x86/crc32-pclmul.S
similarity index 100%
rename from arch/x86/lib/crc32-pclmul.S
rename to lib/crc/x86/crc32-pclmul.S
diff --git a/arch/x86/lib/crc32.c b/lib/crc/x86/crc32.h
similarity index 76%
rename from arch/x86/lib/crc32.c
rename to lib/crc/x86/crc32.h
index d09343e2cea93..28451d5769c3a 100644
--- a/arch/x86/lib/crc32.c
+++ b/lib/crc/x86/crc32.h
@@ -5,26 +5,23 @@
  * Copyright (C) 2008 Intel Corporation
  * Copyright 2012 Xyratex Technology Limited
  * Copyright 2024 Google LLC
  */
 
-#include <linux/crc32.h>
-#include <linux/module.h>
 #include "crc-pclmul-template.h"
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
 DECLARE_CRC_PCLMUL_FUNCS(crc32_lsb, u32);
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	CRC_PCLMUL(crc, p, len, crc32_lsb, crc32_lsb_0xedb88320_consts,
 		   have_pclmulqdq);
 	return crc32_le_base(crc, p, len);
 }
-EXPORT_SYMBOL(crc32_le_arch);
 
 #ifdef CONFIG_X86_64
 #define CRC32_INST "crc32q %1, %q0"
 #else
 #define CRC32_INST "crc32l %1, %0"
@@ -36,11 +33,11 @@ EXPORT_SYMBOL(crc32_le_arch);
  */
 #define CRC32C_PCLMUL_BREAKEVEN	512
 
 asmlinkage u32 crc32c_x86_3way(u32 crc, const u8 *buffer, size_t len);
 
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
+static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	size_t num_longs;
 
 	if (!static_branch_likely(&have_crc32))
 		return crc32c_base(crc, p, len);
@@ -68,44 +65,29 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 	if (len & 1)
 		asm("crc32b %1, %0" : "+r" (crc) : ASM_INPUT_RM (*p));
 
 	return crc;
 }
-EXPORT_SYMBOL(crc32c_arch);
 
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_be_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
+#define crc32_be_arch crc32_be_base /* not implemented on this arch */
 
-static int __init crc32_x86_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	if (boot_cpu_has(X86_FEATURE_XMM4_2))
 		static_branch_enable(&have_crc32);
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc32_lsb);
 	}
-	return 0;
-}
-subsys_initcall(crc32_x86_init);
-
-static void __exit crc32_x86_exit(void)
-{
 }
-module_exit(crc32_x86_exit);
 
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	u32 optimizations = 0;
 
 	if (static_key_enabled(&have_crc32))
 		optimizations |= CRC32C_OPTIMIZATION;
 	if (static_key_enabled(&have_pclmulqdq))
 		optimizations |= CRC32_LE_OPTIMIZATION;
 	return optimizations;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_DESCRIPTION("x86-optimized CRC32 functions");
-MODULE_LICENSE("GPL");
diff --git a/arch/x86/lib/crc32c-3way.S b/lib/crc/x86/crc32c-3way.S
similarity index 100%
rename from arch/x86/lib/crc32c-3way.S
rename to lib/crc/x86/crc32c-3way.S
diff --git a/arch/x86/lib/crc64-pclmul.S b/lib/crc/x86/crc64-pclmul.S
similarity index 100%
rename from arch/x86/lib/crc64-pclmul.S
rename to lib/crc/x86/crc64-pclmul.S
diff --git a/arch/x86/lib/crc64.c b/lib/crc/x86/crc64.h
similarity index 61%
rename from arch/x86/lib/crc64.c
rename to lib/crc/x86/crc64.h
index 351a09f5813e2..54aca3a9475c9 100644
--- a/arch/x86/lib/crc64.c
+++ b/lib/crc/x86/crc64.h
@@ -3,48 +3,35 @@
  * CRC64 using [V]PCLMULQDQ instructions
  *
  * Copyright 2025 Google LLC
  */
 
-#include <linux/crc64.h>
-#include <linux/module.h>
 #include "crc-pclmul-template.h"
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
 DECLARE_CRC_PCLMUL_FUNCS(crc64_msb, u64);
 DECLARE_CRC_PCLMUL_FUNCS(crc64_lsb, u64);
 
-u64 crc64_be_arch(u64 crc, const u8 *p, size_t len)
+static inline u64 crc64_be_arch(u64 crc, const u8 *p, size_t len)
 {
 	CRC_PCLMUL(crc, p, len, crc64_msb, crc64_msb_0x42f0e1eba9ea3693_consts,
 		   have_pclmulqdq);
 	return crc64_be_generic(crc, p, len);
 }
-EXPORT_SYMBOL_GPL(crc64_be_arch);
 
-u64 crc64_nvme_arch(u64 crc, const u8 *p, size_t len)
+static inline u64 crc64_nvme_arch(u64 crc, const u8 *p, size_t len)
 {
 	CRC_PCLMUL(crc, p, len, crc64_lsb, crc64_lsb_0x9a6c9329ac4bc9b5_consts,
 		   have_pclmulqdq);
 	return crc64_nvme_generic(crc, p, len);
 }
-EXPORT_SYMBOL_GPL(crc64_nvme_arch);
 
-static int __init crc64_x86_init(void)
+#define crc64_mod_init_arch crc64_mod_init_arch
+static inline void crc64_mod_init_arch(void)
 {
 	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc64_msb);
 		INIT_CRC_PCLMUL(crc64_lsb);
 	}
-	return 0;
 }
-subsys_initcall(crc64_x86_init);
-
-static void __exit crc64_x86_exit(void)
-{
-}
-module_exit(crc64_x86_exit);
-
-MODULE_DESCRIPTION("CRC64 using [V]PCLMULQDQ instructions");
-MODULE_LICENSE("GPL");
-- 
2.49.0


