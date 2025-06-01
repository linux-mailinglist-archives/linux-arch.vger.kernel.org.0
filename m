Return-Path: <linux-arch+bounces-12172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C3ACA0D6
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F38B171EE5
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1A23E25A;
	Sun,  1 Jun 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/+oa40f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC523D2A9;
	Sun,  1 Jun 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817957; cv=none; b=qhTsD9dfFzev4wOA3+UNFyfMCxeH8SpKQ/f3fmhD78Sa9JsSHdF3kMz1ZIIOX8NEANUlvqz2qvR4lWlazbkarcPFcoovrgAGvhMt3uzLdm9+as8qaZHFsf2Yw1pTL/aaU0nBklPkh0P1iFK5rgtZMssIwAw/3+m6GYoInqW/otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817957; c=relaxed/simple;
	bh=yoI90iVlquVCitVGa7RjvDmSsdHmtg6em7U4Tn0qZw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy8W5MN5D6C5vqUVw9TQq8MnvaQ5AO0ATxb5N36EJ0a3lYPauK2TiZOfOqqlIr7GXoE2MFuzQje/qIXCX/OxX2nGw6m/a+GYSPU8vUxMXNCmITxjzZ9VNwqrSRRmlm8At3aBEF/rpa6kiFmT0nexeSajx3A9inodW1O1gUufxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/+oa40f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74559C4CEE7;
	Sun,  1 Jun 2025 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748817956;
	bh=yoI90iVlquVCitVGa7RjvDmSsdHmtg6em7U4Tn0qZw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/+oa40fhs3WXlKJD4saBc72E23kv2NhgbcXplwEgCHTSx9q7IEqr1ccshOJ7tgnA
	 1wvSNnBXanAW0tzJBW0i77u5/lfiDGRSmDSaAEtDLDXaFSfcXR7uEipZlWltGULHKG
	 vmLfT92usKuxNR1te1C5Gj9xrmv8ttsPpoa7oOuSrgYSTO/zWghx+tMvMSyzzhyquP
	 8bQkBn5G93f6oPP7ZVPETOrTsXb9Nx6g01+InRcz1r/Zt6Z2giIRsqn2+I5unoCbmU
	 Vydkoc1ew8KwpGCw7V2LLbC2a6+CesUEmCU4a0ixOpuS42FGYNReQ3EqOsXAG3DoDU
	 Qol9Wooapbftw==
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
Subject: [PATCH 07/13] lib/crc/loongarch: migrate loongarch-optimized CRC code into lib/crc/
Date: Sun,  1 Jun 2025 15:44:35 -0700
Message-ID: <20250601224441.778374-8-ebiggers@kernel.org>
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

Move the loongarch-optimized CRC code from arch/loongarch/lib/crc* into
its new location in lib/crc/loongarch/, and wire it up in the new way.
For a detailed explanation of why this change is being made, see the
commit that introduced the new way of integrating arch-specific code
into lib/crc/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/loongarch/Kconfig                        |  1 -
 arch/loongarch/lib/Makefile                   |  2 --
 lib/crc/Kconfig                               |  1 +
 .../crc/loongarch/crc32.h                     | 34 ++++---------------
 4 files changed, 8 insertions(+), 30 deletions(-)
 rename arch/loongarch/lib/crc32-loongarch.c => lib/crc/loongarch/crc32.h (71%)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1a2cf012b8f2f..1b19893a6bdf0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -13,11 +13,10 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
-	select ARCH_HAS_CRC32
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index fae77809048b8..ccea3bbd43531 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -9,7 +9,5 @@ lib-y	+= delay.o memset.o memcpy.o memmove.o \
 obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
 
 obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-
-obj-$(CONFIG_CRC32_ARCH) += crc32-loongarch.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 663f4dca2bda1..ee320ae19ca85 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -63,10 +63,11 @@ config CRC32
 config CRC32_ARCH
 	bool
 	depends on CRC32 && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
+	default y if LOONGARCH
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/arch/loongarch/lib/crc32-loongarch.c b/lib/crc/loongarch/crc32.h
similarity index 71%
rename from arch/loongarch/lib/crc32-loongarch.c
rename to lib/crc/loongarch/crc32.h
index b37cd8537b459..d5aff7ca96ae9 100644
--- a/arch/loongarch/lib/crc32-loongarch.c
+++ b/lib/crc/loongarch/crc32.h
@@ -8,12 +8,10 @@
  * Copyright (C) 2018 MIPS Tech, LLC
  * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
  */
 
 #include <asm/cpu-features.h>
-#include <linux/crc32.h>
-#include <linux/module.h>
 #include <linux/unaligned.h>
 
 #define _CRC32(crc, value, size, type)			\
 do {							\
 	__asm__ __volatile__(				\
@@ -26,11 +24,12 @@ do {							\
 #define CRC32(crc, value, size)		_CRC32(crc, value, size, crc)
 #define CRC32C(crc, value, size)	_CRC32(crc, value, size, crcc)
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+#define crc32_le_arch crc32_le_arch
+static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!static_branch_likely(&have_crc32))
 		return crc32_le_base(crc, p, len);
 
 	while (len >= sizeof(u64)) {
@@ -61,13 +60,13 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 		CRC32(crc, value, b);
 	}
 
 	return crc;
 }
-EXPORT_SYMBOL(crc32_le_arch);
 
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
+#define crc32c_arch crc32c_arch
+static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!static_branch_likely(&have_crc32))
 		return crc32c_base(crc, p, len);
 
 	while (len >= sizeof(u64)) {
@@ -98,38 +97,19 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 		CRC32C(crc, value, b);
 	}
 
 	return crc;
 }
-EXPORT_SYMBOL(crc32c_arch);
 
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
-{
-	return crc32_be_base(crc, p, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
-
-static int __init crc32_loongarch_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	if (cpu_has_crc32)
 		static_branch_enable(&have_crc32);
-	return 0;
 }
-subsys_initcall(crc32_loongarch_init);
 
-static void __exit crc32_loongarch_exit(void)
-{
-}
-module_exit(crc32_loongarch_exit);
-
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	if (static_key_enabled(&have_crc32))
 		return CRC32_LE_OPTIMIZATION | CRC32C_OPTIMIZATION;
 	return 0;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_AUTHOR("Min Zhou <zhoumin@loongson.cn>");
-MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
-MODULE_DESCRIPTION("CRC32 and CRC32C using LoongArch crc* instructions");
-MODULE_LICENSE("GPL v2");
-- 
2.49.0


