Return-Path: <linux-arch+bounces-12277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033BAD0F83
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E0C3AE9A6
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C821D3F3;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf6I+Ges"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38521CC7F;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326853; cv=none; b=FGqIi1YS6JJF8hkAIRr0ymbTdtTmlmA9SnG4VOjv5EmrGbOu3j9ECu0nqKF4bhLR09c8J8koKuUWsigdBLdxbUQQsxK24wkw1jzD8LyeL/aAkKYujw1R4c0PeUFTusBY4981yKraIG+WuvFq3bW20iq8d9KXDr33RVSWwajQeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326853; c=relaxed/simple;
	bh=ml00Eu6L3MCivT8VcjfT2RgfiZJS9znV2CRfUv6dB7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir3ui3SN3I9ZqcEKKMg+OL7zpG8YhxDco0cWHqq1bqXXurY8nYEK5iXSeoY4ANq8+pZdC611fCFTPIDMNZO4zD2nE1Ef9Ym9W6gGiVDZ5iNCJs3OVEVwxeAKR3Xbk7minAMzSif9m78t+vwd1K2Kkg4IIxiULEsiYhqy1eOCyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf6I+Ges; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C30C4CEE4;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326853;
	bh=ml00Eu6L3MCivT8VcjfT2RgfiZJS9znV2CRfUv6dB7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hf6I+GessssiRha4MpA6RFI+58URioJcA8hkf18voXD1e9otmRrh6ut6f37cDXBp+
	 t02pRBAP/ZlXisnR/Q2kSIylUzzyohdF4xc+dYSaCvPizsqHiblpXpH3M/AcB4DwZm
	 1gsBgk8eLNYcmlAGFZLxK2WApGsMmbHKpUBzmx0pNNo3RVKGFzhTcZ7ZCx//ZzZdDI
	 hLEhV+ur56mvrGVIPD3EuNCPvrKW9CQHIaAhExDe1uBKmjOUWdJvccInA7Py7CALlr
	 ISUzxfUqOE8bsLzp6szFM0WEjwnQYDirYRxe83hqmv+e8gbpJV65fpLADWeNNXS6YC
	 lNZw0bHLVTzlA==
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
Subject: [PATCH v2 10/12] lib/crc/sparc: migrate sparc-optimized CRC code into lib/crc/
Date: Sat,  7 Jun 2025 13:04:52 -0700
Message-ID: <20250607200454.73587-11-ebiggers@kernel.org>
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

Move the sparc-optimized CRC code from arch/sparc/lib/crc* into its new
location in lib/crc/sparc/, and wire it up in the new way.  This new way
of organizing the CRC code eliminates the need to artificially split the
code for each CRC variant into separate arch and generic modules,
enabling better inlining and dead code elimination.  For more details,
see "lib/crc: prepare for arch-optimized code in subdirs of lib/crc/".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/sparc/Kconfig                            |  1 -
 arch/sparc/lib/Makefile                       |  2 -
 lib/crc/Kconfig                               |  1 +
 lib/crc/Makefile                              |  1 +
 .../lib/crc32.c => lib/crc/sparc/crc32.h      | 42 ++++---------------
 .../sparc/lib => lib/crc/sparc}/crc32c_asm.S  |  0
 6 files changed, 10 insertions(+), 37 deletions(-)
 rename arch/sparc/lib/crc32.c => lib/crc/sparc/crc32.h (60%)
 rename {arch/sparc/lib => lib/crc/sparc}/crc32c_asm.S (100%)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f88123925a4f..dcfdb7f1dae97 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -108,11 +108,10 @@ config SPARC64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
-	select ARCH_HAS_CRC32
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
 config CPU_BIG_ENDIAN
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 5cf9781d68b40..2d6c3c5352734 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -52,7 +52,5 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
-obj-$(CONFIG_CRC32_ARCH) += crc32-sparc.o
-crc32-sparc-y := crc32.o crc32c_asm.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 1b69a8bef4a85..af4fa857a81f8 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -73,10 +73,11 @@ config CRC32_ARCH
 	default y if LOONGARCH
 	default y if MIPS && CPU_MIPSR6
 	default y if PPC64 && ALTIVEC
 	default y if RISCV && RISCV_ISA_ZBC
 	default y if S390
+	default y if SPARC64
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index bec58266251f8..81e176db0947c 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -26,10 +26,11 @@ CFLAGS_crc32-main.o += -I$(src)/$(SRCARCH)
 crc32-$(CONFIG_ARM) += arm/crc32-core.o
 crc32-$(CONFIG_ARM64) += arm64/crc32-core.o
 crc32-$(CONFIG_PPC) += powerpc/crc32c-vpmsum_asm.o
 crc32-$(CONFIG_RISCV) += riscv/crc32_lsb.o riscv/crc32_msb.o
 crc32-$(CONFIG_S390) += s390/crc32le-vx.o s390/crc32be-vx.o
+crc32-$(CONFIG_SPARC) += sparc/crc32c_asm.o
 endif
 
 obj-$(CONFIG_CRC64) += crc64.o
 crc64-y := crc64-main.o
 ifeq ($(CONFIG_CRC64_ARCH),y)
diff --git a/arch/sparc/lib/crc32.c b/lib/crc/sparc/crc32.h
similarity index 60%
rename from arch/sparc/lib/crc32.c
rename to lib/crc/sparc/crc32.h
index 40d4720a42a1b..60f2765ac0157 100644
--- a/arch/sparc/lib/crc32.c
+++ b/lib/crc/sparc/crc32.h
@@ -6,30 +6,21 @@
  * Copyright (C) 2008 Intel Corporation
  * Authors: Austin Zhang <austin_zhang@linux.intel.com>
  *          Kent Liu <kent.liu@intel.com>
  */
 
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/crc32.h>
 #include <asm/pstate.h>
 #include <asm/elf.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32c_opcode);
 
-u32 crc32_le_arch(u32 crc, const u8 *data, size_t len)
-{
-	return crc32_le_base(crc, data, len);
-}
-EXPORT_SYMBOL(crc32_le_arch);
+#define crc32_le_arch crc32_le_base /* not implemented on this arch */
+#define crc32_be_arch crc32_be_base /* not implemented on this arch */
 
 void crc32c_sparc64(u32 *crcp, const u64 *data, size_t len);
 
-u32 crc32c_arch(u32 crc, const u8 *data, size_t len)
+static inline u32 crc32c_arch(u32 crc, const u8 *data, size_t len)
 {
 	size_t n = -(uintptr_t)data & 7;
 
 	if (!static_branch_likely(&have_crc32c_opcode))
 		return crc32c_base(crc, data, len);
@@ -49,45 +40,28 @@ u32 crc32c_arch(u32 crc, const u8 *data, size_t len)
 	}
 	if (len)
 		crc = crc32c_base(crc, data, len);
 	return crc;
 }
-EXPORT_SYMBOL(crc32c_arch);
-
-u32 crc32_be_arch(u32 crc, const u8 *data, size_t len)
-{
-	return crc32_be_base(crc, data, len);
-}
-EXPORT_SYMBOL(crc32_be_arch);
 
-static int __init crc32_sparc_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	unsigned long cfr;
 
 	if (!(sparc64_elf_hwcap & HWCAP_SPARC_CRYPTO))
-		return 0;
+		return;
 
 	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
 	if (!(cfr & CFR_CRC32C))
-		return 0;
+		return;
 
 	static_branch_enable(&have_crc32c_opcode);
 	pr_info("Using sparc64 crc32c opcode optimized CRC32C implementation\n");
-	return 0;
 }
-subsys_initcall(crc32_sparc_init);
 
-static void __exit crc32_sparc_exit(void)
-{
-}
-module_exit(crc32_sparc_exit);
-
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	if (static_key_enabled(&have_crc32c_opcode))
 		return CRC32C_OPTIMIZATION;
 	return 0;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("CRC32c (Castagnoli), sparc64 crc32c opcode accelerated");
diff --git a/arch/sparc/lib/crc32c_asm.S b/lib/crc/sparc/crc32c_asm.S
similarity index 100%
rename from arch/sparc/lib/crc32c_asm.S
rename to lib/crc/sparc/crc32c_asm.S
-- 
2.49.0


