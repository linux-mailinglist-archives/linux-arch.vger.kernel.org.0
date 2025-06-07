Return-Path: <linux-arch+bounces-12273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B69AD0F76
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EA168523
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03521B9FC;
	Sat,  7 Jun 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEO6mVXc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4321B9C3;
	Sat,  7 Jun 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326852; cv=none; b=PLapWlZoI9xW8RY3B2qPG6lZrWCl2DW0CIgVIXKSysLyjOZn/bnMly5BIGvG3P3dRDLV2a8BbC/AhEY5yJ8rRPy7tn79UkpV65zPWSXN/Gn7eR50R+pgm367tiQH5VLkM4KSoZSJwAHz8Rvt0vpEnbaJ6CulgRBq/9ztbV71vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326852; c=relaxed/simple;
	bh=hXWT8G8Ba/3m7q18Loqe+RpZLh/rS7DlIty2E8Dsl/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B25320/i21sTFjqkGfiQX4xNWyJUBnnpBujkKhgW6BBTKncEe7Boadi/MsvHhRIBR6cOhjaU5nSJrCn7s5bLIZBSOZjU/ZVmeL0ihriB3kbHARyZin+O6wBheQVbj6yFgMIeQgWS7ylm0jFbFBfOg6zj5FUj2wCSYuSGBgQwYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEO6mVXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79452C4CEE4;
	Sat,  7 Jun 2025 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326851;
	bh=hXWT8G8Ba/3m7q18Loqe+RpZLh/rS7DlIty2E8Dsl/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEO6mVXcE91YyKwFjzGXi6irTVUA1tBomwmunmGf1Du+jIfCHuAy5wElQKbGfewk2
	 cqt+/pVHofIk25s+7+z+vHs/AJUB6wf/SUlcpg28mmvvLHOLI/Nk6RBi4WgacHd+fI
	 8Ry8eQfLXJJXs+JuxPy8DSdiY9kmSJgWdEg7yVYwlzoS3PXBCzEJ0XTyC8wfCuAxf9
	 sReeyz+BcE2Ei41nTT3Qjcca+n2PV3KWkrOmwxJoIbv878RTzGgxk0mjxZHgmCWyPJ
	 xbZ71jtzvDPmm+Ri2cv1Z8To5NdLFIrrZL4k/5XirGm9T0oJLkVy3ZHhGj0PjAaVjb
	 G1L7OksnUwNSQ==
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
Subject: [PATCH v2 07/12] lib/crc/powerpc: migrate powerpc-optimized CRC code into lib/crc/
Date: Sat,  7 Jun 2025 13:04:49 -0700
Message-ID: <20250607200454.73587-8-ebiggers@kernel.org>
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

Move the powerpc-optimized CRC code from arch/powerpc/lib/crc* into its
new location in lib/crc/powerpc/, and wire it up in the new way.  This
new way of organizing the CRC code eliminates the need to artificially
split the code for each CRC variant into separate arch and generic
modules, enabling better inlining and dead code elimination.  For more
details, see "lib/crc: prepare for arch-optimized code in subdirs of
lib/crc/".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/Kconfig                          |  2 -
 arch/powerpc/lib/Makefile                     |  6 ---
 lib/crc/Kconfig                               |  2 +
 lib/crc/Makefile                              |  2 +
 .../crc/powerpc/crc-t10dif.h                  | 20 ++--------
 .../crc/powerpc}/crc-vpmsum-template.S        |  0
 .../lib/crc32.c => lib/crc/powerpc/crc32.h    | 38 ++++---------------
 .../crc/powerpc}/crc32c-vpmsum_asm.S          |  0
 .../crc/powerpc}/crct10dif-vpmsum_asm.S       |  0
 9 files changed, 14 insertions(+), 56 deletions(-)
 rename arch/powerpc/lib/crc-t10dif.c => lib/crc/powerpc/crc-t10dif.h (75%)
 rename {arch/powerpc/lib => lib/crc/powerpc}/crc-vpmsum-template.S (100%)
 rename arch/powerpc/lib/crc32.c => lib/crc/powerpc/crc32.h (64%)
 rename {arch/powerpc/lib => lib/crc/powerpc}/crc32c-vpmsum_asm.S (100%)
 rename {arch/powerpc/lib => lib/crc/powerpc}/crct10dif-vpmsum_asm.S (100%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f1205..45b4fa7b9b02f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -125,12 +125,10 @@ config PPC
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
-	select ARCH_HAS_CRC32			if PPC64 && ALTIVEC
-	select ARCH_HAS_CRC_T10DIF		if PPC64 && ALTIVEC
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX		if STRICT_KERNEL_RWX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 481f968e42c7b..59de2e2232df6 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -78,12 +78,6 @@ obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
 CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 # Enable <altivec.h>
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
-obj-$(CONFIG_CRC32_ARCH) += crc32-powerpc.o
-crc32-powerpc-y := crc32.o crc32c-vpmsum_asm.o
-
-obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-powerpc.o
-crc-t10dif-powerpc-y := crc-t10dif.o crct10dif-vpmsum_asm.o
-
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 3f534fbfba951..c3f9091ee512e 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -50,10 +50,11 @@ config ARCH_HAS_CRC_T10DIF
 config CRC_T10DIF_ARCH
 	bool
 	depends on CRC_T10DIF && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64 && KERNEL_MODE_NEON
+	default y if PPC64 && ALTIVEC
 
 config CRC32
 	tristate
 	select BITREVERSE
 	help
@@ -68,10 +69,11 @@ config CRC32_ARCH
 	depends on CRC32 && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
 	default y if LOONGARCH
 	default y if MIPS && CPU_MIPSR6
+	default y if PPC64 && ALTIVEC
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index 8adff4ae1ba63..555fd3fb6d197 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -13,18 +13,20 @@ obj-$(CONFIG_CRC_T10DIF) += crc-t10dif.o
 crc-t10dif-y := crc-t10dif-main.o
 ifeq ($(CONFIG_CRC_T10DIF_ARCH),y)
 CFLAGS_crc-t10dif-main.o += -I$(src)/$(SRCARCH)
 crc-t10dif-$(CONFIG_ARM) += arm/crc-t10dif-core.o
 crc-t10dif-$(CONFIG_ARM64) += arm64/crc-t10dif-core.o
+crc-t10dif-$(CONFIG_PPC) += powerpc/crct10dif-vpmsum_asm.o
 endif
 
 obj-$(CONFIG_CRC32) += crc32.o
 crc32-y := crc32-main.o
 ifeq ($(CONFIG_CRC32_ARCH),y)
 CFLAGS_crc32-main.o += -I$(src)/$(SRCARCH)
 crc32-$(CONFIG_ARM) += arm/crc32-core.o
 crc32-$(CONFIG_ARM64) += arm64/crc32-core.o
+crc32-$(CONFIG_PPC) += powerpc/crc32c-vpmsum_asm.o
 endif
 
 obj-$(CONFIG_CRC64) += crc64.o
 crc64-y := crc64-main.o
 ifeq ($(CONFIG_CRC64_ARCH),y)
diff --git a/arch/powerpc/lib/crc-t10dif.c b/lib/crc/powerpc/crc-t10dif.h
similarity index 75%
rename from arch/powerpc/lib/crc-t10dif.c
rename to lib/crc/powerpc/crc-t10dif.h
index be23ded3a9df6..59e16804a6eae 100644
--- a/arch/powerpc/lib/crc-t10dif.c
+++ b/lib/crc/powerpc/crc-t10dif.h
@@ -7,14 +7,11 @@
  */
 
 #include <asm/switch_to.h>
 #include <crypto/internal/simd.h>
 #include <linux/cpufeature.h>
-#include <linux/crc-t10dif.h>
 #include <linux/jump_label.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 
 #define VMX_ALIGN		16
 #define VMX_ALIGN_MASK		(VMX_ALIGN-1)
@@ -23,11 +20,11 @@
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_vec_crypto);
 
 u32 __crct10dif_vpmsum(u32 crc, unsigned char const *p, size_t len);
 
-u16 crc_t10dif_arch(u16 crci, const u8 *p, size_t len)
+static inline u16 crc_t10dif_arch(u16 crci, const u8 *p, size_t len)
 {
 	unsigned int prealign;
 	unsigned int tail;
 	u32 crc = crci;
 
@@ -60,24 +57,13 @@ u16 crc_t10dif_arch(u16 crci, const u8 *p, size_t len)
 		crc = crc_t10dif_generic(crc, p, tail);
 	}
 
 	return crc & 0xffff;
 }
-EXPORT_SYMBOL(crc_t10dif_arch);
 
-static int __init crc_t10dif_powerpc_init(void)
+#define crc_t10dif_mod_init_arch crc_t10dif_mod_init_arch
+static inline void crc_t10dif_mod_init_arch(void)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
 		static_branch_enable(&have_vec_crypto);
-	return 0;
 }
-subsys_initcall(crc_t10dif_powerpc_init);
-
-static void __exit crc_t10dif_powerpc_exit(void)
-{
-}
-module_exit(crc_t10dif_powerpc_exit);
-
-MODULE_AUTHOR("Daniel Axtens <dja@axtens.net>");
-MODULE_DESCRIPTION("CRCT10DIF using vector polynomial multiply-sum instructions");
-MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/lib/crc-vpmsum-template.S b/lib/crc/powerpc/crc-vpmsum-template.S
similarity index 100%
rename from arch/powerpc/lib/crc-vpmsum-template.S
rename to lib/crc/powerpc/crc-vpmsum-template.S
diff --git a/arch/powerpc/lib/crc32.c b/lib/crc/powerpc/crc32.h
similarity index 64%
rename from arch/powerpc/lib/crc32.c
rename to lib/crc/powerpc/crc32.h
index 0d9befb6e7b83..811cc2e6ed24d 100644
--- a/arch/powerpc/lib/crc32.c
+++ b/lib/crc/powerpc/crc32.h
@@ -1,32 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <asm/switch_to.h>
 #include <crypto/internal/simd.h>
 #include <linux/cpufeature.h>
-#include <linux/crc32.h>
 #include <linux/jump_label.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/preempt.h>
 #include <linux/uaccess.h>
 
 #define VMX_ALIGN		16
 #define VMX_ALIGN_MASK		(VMX_ALIGN-1)
 
 #define VECTOR_BREAKPOINT	512
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_vec_crypto);
 
-u32 __crc32c_vpmsum(u32 crc, const u8 *p, size_t len);
+#define crc32_le_arch crc32_le_base /* not implemented on this arch */
+#define crc32_be_arch crc32_be_base /* not implemented on this arch */
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_le_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_le_arch);
+u32 __crc32c_vpmsum(u32 crc, const u8 *p, size_t len);
 
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
+static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	unsigned int prealign;
 	unsigned int tail;
 
 	if (len < (VECTOR_BREAKPOINT + VMX_ALIGN) ||
@@ -56,38 +50,20 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 		crc = crc32c_base(crc, p, tail);
 	}
 
 	return crc;
 }
-EXPORT_SYMBOL(crc32c_arch);
-
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_be_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
 
-static int __init crc32_powerpc_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
 		static_branch_enable(&have_vec_crypto);
-	return 0;
-}
-subsys_initcall(crc32_powerpc_init);
-
-static void __exit crc32_powerpc_exit(void)
-{
 }
-module_exit(crc32_powerpc_exit);
 
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	if (static_key_enabled(&have_vec_crypto))
 		return CRC32C_OPTIMIZATION;
 	return 0;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_AUTHOR("Anton Blanchard <anton@samba.org>");
-MODULE_DESCRIPTION("CRC32C using vector polynomial multiply-sum instructions");
-MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/lib/crc32c-vpmsum_asm.S b/lib/crc/powerpc/crc32c-vpmsum_asm.S
similarity index 100%
rename from arch/powerpc/lib/crc32c-vpmsum_asm.S
rename to lib/crc/powerpc/crc32c-vpmsum_asm.S
diff --git a/arch/powerpc/lib/crct10dif-vpmsum_asm.S b/lib/crc/powerpc/crct10dif-vpmsum_asm.S
similarity index 100%
rename from arch/powerpc/lib/crct10dif-vpmsum_asm.S
rename to lib/crc/powerpc/crct10dif-vpmsum_asm.S
-- 
2.49.0


