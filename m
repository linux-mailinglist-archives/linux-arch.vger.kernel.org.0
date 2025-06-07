Return-Path: <linux-arch+bounces-12276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA81AD0F80
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2163AE9AC
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1E21D3D6;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK97FH/u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091A21CC5F;
	Sat,  7 Jun 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326853; cv=none; b=iaaK6fv+DBd/ZFJ3hW0mBW4XR5DZlkXuBcW5WQhOjiIMUv+E4j7UQIOwbzBPe8v49zeO1jRcGtF/Py7dX6O5uJm/1NX5WRs7YzYz8kN0WGiA7f8xApIDaIbVzHqhZmNvLL5E33yHW6eh3tUPLE9dNFyopftDK1HaHwlhtOtk/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326853; c=relaxed/simple;
	bh=167zq5zi7wdD08Zx3i/mgZI+CHCjTsXkRCx5v5LY1DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ52QW8XYbtvNPO64QKlJD1/6tyAw1tl7fptI1twf0UWirUW4boH83PhnTIMRd7hhQW+diE9KE0zLKkSQ08NAXFmfF0q4ObICpejmT3VTGjAPTZ8Xo6kNjVilaxLM1Ok6Bugr3TKJ6NxQbK01A3Ok7AJPV+Mvc53/og7bwXm3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK97FH/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A05C4AF09;
	Sat,  7 Jun 2025 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326852;
	bh=167zq5zi7wdD08Zx3i/mgZI+CHCjTsXkRCx5v5LY1DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK97FH/u1ZexrL4xPo108kbPSyiyqv5D8XHaqv+mjS2WIeFt3z02kKZQoPSDq/X9G
	 neVztBJCZmrBoT35lHT7/4k1mw3IU50u8eK2I8rCFsAO3s5eNyH+UgVyYXahnJYGwP
	 TiPrvKloWZbvdMpC4iYVrFLfzw9UqgZm3B60tJ2p04gkZ1fhmhjAqppFmzZj0+0I9k
	 fZrdwvK3bggFG+eTMFGHLb/guQtWXCbVKytVYD912FXa4Gfgsp4iP8TdQzvl2cNx9/
	 p7CAFgRZSOtmmJ1+fxlmzhOAzyN+XY2FyOZvJtvXu7z3ScuzRfpONDpwE/CuTrEy5Y
	 iwR5ANOjA/+Mw==
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
Subject: [PATCH v2 09/12] lib/crc/s390: migrate s390-optimized CRC code into lib/crc/
Date: Sat,  7 Jun 2025 13:04:51 -0700
Message-ID: <20250607200454.73587-10-ebiggers@kernel.org>
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

Move the s390-optimized CRC code from arch/s390/lib/crc* into its new
location in lib/crc/s390/, and wire it up in the new way.  This new way
of organizing the CRC code eliminates the need to artificially split the
code for each CRC variant into separate arch and generic modules,
enabling better inlining and dead code elimination.  For more details,
see "lib/crc: prepare for arch-optimized code in subdirs of lib/crc/".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/Kconfig                             |  1 -
 arch/s390/lib/Makefile                        |  3 ---
 lib/crc/Kconfig                               |  1 +
 lib/crc/Makefile                              |  1 +
 {arch/s390/lib => lib/crc/s390}/crc32-vx.h    |  0
 arch/s390/lib/crc32.c => lib/crc/s390/crc32.h | 16 +++-------------
 {arch/s390/lib => lib/crc/s390}/crc32be-vx.c  |  0
 {arch/s390/lib => lib/crc/s390}/crc32le-vx.c  |  0
 8 files changed, 5 insertions(+), 17 deletions(-)
 rename {arch/s390/lib => lib/crc/s390}/crc32-vx.h (100%)
 rename arch/s390/lib/crc32.c => lib/crc/s390/crc32.h (81%)
 rename {arch/s390/lib => lib/crc/s390}/crc32be-vx.c (100%)
 rename {arch/s390/lib => lib/crc/s390}/crc32le-vx.c (100%)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f6..22b90f6aa1a09 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -73,11 +73,10 @@ config S390
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_CPU_FINALIZE_INIT
-	select ARCH_HAS_CRC32
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index cd35cdbfa8713..7c8583d46eca1 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -23,8 +23,5 @@ obj-$(CONFIG_S390_MODULES_SANITY_TEST) += test_modules.o
 obj-$(CONFIG_S390_MODULES_SANITY_TEST_HELPERS) += test_modules_helpers.o
 
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_EXPOLINE_EXTERN) += expoline.o
-
-obj-$(CONFIG_CRC32_ARCH) += crc32-s390.o
-crc32-s390-y := crc32.o crc32le-vx.o crc32be-vx.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index d0c293b1a4182..1b69a8bef4a85 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -72,10 +72,11 @@ config CRC32_ARCH
 	default y if ARM64
 	default y if LOONGARCH
 	default y if MIPS && CPU_MIPSR6
 	default y if PPC64 && ALTIVEC
 	default y if RISCV && RISCV_ISA_ZBC
+	default y if S390
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index 190f889adf556..bec58266251f8 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -25,10 +25,11 @@ ifeq ($(CONFIG_CRC32_ARCH),y)
 CFLAGS_crc32-main.o += -I$(src)/$(SRCARCH)
 crc32-$(CONFIG_ARM) += arm/crc32-core.o
 crc32-$(CONFIG_ARM64) += arm64/crc32-core.o
 crc32-$(CONFIG_PPC) += powerpc/crc32c-vpmsum_asm.o
 crc32-$(CONFIG_RISCV) += riscv/crc32_lsb.o riscv/crc32_msb.o
+crc32-$(CONFIG_S390) += s390/crc32le-vx.o s390/crc32be-vx.o
 endif
 
 obj-$(CONFIG_CRC64) += crc64.o
 crc64-y := crc64-main.o
 ifeq ($(CONFIG_CRC64_ARCH),y)
diff --git a/arch/s390/lib/crc32-vx.h b/lib/crc/s390/crc32-vx.h
similarity index 100%
rename from arch/s390/lib/crc32-vx.h
rename to lib/crc/s390/crc32-vx.h
diff --git a/arch/s390/lib/crc32.c b/lib/crc/s390/crc32.h
similarity index 81%
rename from arch/s390/lib/crc32.c
rename to lib/crc/s390/crc32.h
index 3c4b344417c11..59c8983d428be 100644
--- a/arch/s390/lib/crc32.c
+++ b/lib/crc/s390/crc32.h
@@ -3,16 +3,12 @@
  * CRC-32 implemented with the z/Architecture Vector Extension Facility.
  *
  * Copyright IBM Corp. 2015
  * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  */
-#define KMSG_COMPONENT	"crc32-vx"
-#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
 
-#include <linux/module.h>
 #include <linux/cpufeature.h>
-#include <linux/crc32.h>
 #include <asm/fpu.h>
 #include "crc32-vx.h"
 
 #define VX_MIN_LEN		64
 #define VX_ALIGNMENT		16L
@@ -25,11 +21,11 @@
  * on the message buffer, the hardware-accelerated or software implementation
  * is used.   Note that the message buffer is aligned to improve fetch
  * operations of VECTOR LOAD MULTIPLE instructions.
  */
 #define DEFINE_CRC32_VX(___fname, ___crc32_vx, ___crc32_sw)		    \
-	u32 ___fname(u32 crc, const u8 *data, size_t datalen)		    \
+	static inline u32 ___fname(u32 crc, const u8 *data, size_t datalen) \
 	{								    \
 		unsigned long prealign, aligned, remaining;		    \
 		DECLARE_KERNEL_FPU_ONSTACK16(vxstate);			    \
 									    \
 		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK || !cpu_has_vx())  \
@@ -52,26 +48,20 @@
 									    \
 		if (remaining)						    \
 			crc = ___crc32_sw(crc, data + aligned, remaining);  \
 									    \
 		return crc;						    \
-	}								    \
-	EXPORT_SYMBOL(___fname);
+	}
 
 DEFINE_CRC32_VX(crc32_le_arch, crc32_le_vgfm_16, crc32_le_base)
 DEFINE_CRC32_VX(crc32_be_arch, crc32_be_vgfm_16, crc32_be_base)
 DEFINE_CRC32_VX(crc32c_arch, crc32c_le_vgfm_16, crc32c_base)
 
-u32 crc32_optimizations(void)
+static inline u32 crc32_optimizations_arch(void)
 {
 	if (cpu_has_vx()) {
 		return CRC32_LE_OPTIMIZATION |
 		       CRC32_BE_OPTIMIZATION |
 		       CRC32C_OPTIMIZATION;
 	}
 	return 0;
 }
-EXPORT_SYMBOL(crc32_optimizations);
-
-MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
-MODULE_DESCRIPTION("CRC-32 algorithms using z/Architecture Vector Extension Facility");
-MODULE_LICENSE("GPL");
diff --git a/arch/s390/lib/crc32be-vx.c b/lib/crc/s390/crc32be-vx.c
similarity index 100%
rename from arch/s390/lib/crc32be-vx.c
rename to lib/crc/s390/crc32be-vx.c
diff --git a/arch/s390/lib/crc32le-vx.c b/lib/crc/s390/crc32le-vx.c
similarity index 100%
rename from arch/s390/lib/crc32le-vx.c
rename to lib/crc/s390/crc32le-vx.c
-- 
2.49.0


