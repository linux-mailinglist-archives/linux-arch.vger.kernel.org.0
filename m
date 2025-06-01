Return-Path: <linux-arch+bounces-12173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF774ACA0DB
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC66171EED
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF623ED5A;
	Sun,  1 Jun 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn1ngrvi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B423E340;
	Sun,  1 Jun 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817957; cv=none; b=Xt0LUP/3KxYOQQ72Q06ku0+ihwdcGVf/xvTfzt5MpCFbCo+8Rkd4FDIIjb+vc04/ri5aNO3gQ/2oI4zKrnsEXbcNJautwUdm8w9sjw32BYpzeQcrT02U09Mgku/P66x9Rtu9TrCAL65CF5nkShHT91qhU1BzZhB3US5iORoYvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817957; c=relaxed/simple;
	bh=apKGde3VrZfQelJPg198iFKP+frhjwkkcGBF4f9uuBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7maCPgLJVRTOgcSI32J+9hPHsv1kFK6UjoiNvgHXxevJmzyzoHVWj7a2Y/k2zALcUBdcgoGGZU8ljVKl/bx+EuBbrH9r3TEXm7HEkpWrORpA7hdLN79Gwn63YRsBJod6yQNkImku21CcCkemwkXHPr3913sSAtEUVkBN8BXBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn1ngrvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C14AC4CEF3;
	Sun,  1 Jun 2025 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748817957;
	bh=apKGde3VrZfQelJPg198iFKP+frhjwkkcGBF4f9uuBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn1ngrvibz2nkinD2PEEbiJAzT/lFfENVLFa/KQveCqdfEdnd0LNqEHp1YsV2Tpab
	 l1tIAoLh4EkWGv2pnHwWdbpFO0M+dewFCrtd7LjIhfBn5dI74xg3dyGUvNq4vCJxGC
	 FpbEjQus9K/L1HVXHA1zAjwWWafUYsmUWv+CihYUpDXp1JmqxKIjMoKUaWdNknUGQP
	 +3QhNRmQOb3F6RBhkO4xhbkae7c5y7ACq3ir0zqlg2qipWGqyD2kfcoDvd1J9L3ul5
	 DsZnfo+4xcVTRfOZkyD0T0W1xMq+5AjdKylLJoTZk+pjAHcGDsSJYL6FIOChhzBtDW
	 2hb95ofQgtrgQ==
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
Subject: [PATCH 08/13] lib/crc/mips: migrate mips-optimized CRC code into lib/crc/
Date: Sun,  1 Jun 2025 15:44:36 -0700
Message-ID: <20250601224441.778374-9-ebiggers@kernel.org>
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

Move the mips-optimized CRC code from arch/mips/lib/crc* into its new
location in lib/crc/mips/, and wire it up in the new way.  For a
detailed explanation of why this change is being made, see the commit
that introduced the new way of integrating arch-specific code into
lib/crc/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/mips/Kconfig                             |  1 -
 arch/mips/lib/Makefile                        |  2 --
 lib/crc/Kconfig                               |  1 +
 .../lib/crc32-mips.c => lib/crc/mips/crc32.h  | 35 ++++---------------
 4 files changed, 8 insertions(+), 31 deletions(-)
 rename arch/mips/lib/crc32-mips.c => lib/crc/mips/crc32.h (82%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fc0772c1bad4a..31d6975674fd6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1995,11 +1995,10 @@ config CPU_MIPSR5
 	select MIPS_SPRAM
 
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
-	select ARCH_HAS_CRC32
 	select CPU_HAS_RIXI
 	select CPU_HAS_DIEI if !CPU_DIEI_BROKEN
 	select HAVE_ARCH_BITREVERSE
 	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_SPRAM
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9d75845ef78e1..8c40ffb09c420 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -14,9 +14,7 @@ obj-$(CONFIG_PCI)	+= iomap-pci.o
 lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 
 obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 
-obj-$(CONFIG_CRC32_ARCH)	+= crc32-mips.o
-
 # libgcc-style stuff needed in the kernel
 obj-y += bswapsi.o bswapdi.o multi3.o
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index ee320ae19ca85..2d99aab4f838d 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -64,10 +64,11 @@ config CRC32_ARCH
 	bool
 	depends on CRC32 && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
 	default y if LOONGARCH
+	default y if MIPS && CPU_MIPSR6
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
diff --git a/arch/mips/lib/crc32-mips.c b/lib/crc/mips/crc32.h
similarity index 82%
rename from arch/mips/lib/crc32-mips.c
rename to lib/crc/mips/crc32.h
index 45e4d2c9fbf54..aa7f3228b7db3 100644
--- a/arch/mips/lib/crc32-mips.c
+++ b/lib/crc/mips/crc32.h
@@ -7,14 +7,10 @@
  * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
  * Copyright (C) 2018 MIPS Tech, LLC
  */
 
 #include <linux/cpufeature.h>
-#include <linux/crc32.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <asm/mipsregs.h>
 #include <linux/unaligned.h>
 
 #ifndef TOOLCHAIN_SUPPORTS_CRC
 #define _ASM_SET_CRC(OP, SZ, TYPE)					  \
@@ -62,11 +58,12 @@ do {							\
 #define CRC32C(crc, value, size) \
 	_CRC32(crc, value, size, crc32c)
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
+#define crc32_le_arch crc32_le_arch
+static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 {
 	if (!static_branch_likely(&have_crc32))
 		return crc32_le_base(crc, p, len);
 
 	if (IS_ENABLED(CONFIG_64BIT)) {
@@ -104,13 +101,13 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
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
 
 	if (IS_ENABLED(CONFIG_64BIT)) {
@@ -147,37 +144,19 @@ u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 
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
-static int __init crc32_mips_init(void)
+#define crc32_mod_init_arch crc32_mod_init_arch
+static inline void crc32_mod_init_arch(void)
 {
 	if (cpu_have_feature(cpu_feature(MIPS_CRC32)))
 		static_branch_enable(&have_crc32);
-	return 0;
 }
-subsys_initcall(crc32_mips_init);
 
-static void __exit crc32_mips_exit(void)
-{
-}
-module_exit(crc32_mips_exit);
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
-MODULE_AUTHOR("Marcin Nowakowski <marcin.nowakowski@mips.com");
-MODULE_DESCRIPTION("CRC32 and CRC32C using optional MIPS instructions");
-MODULE_LICENSE("GPL v2");
-- 
2.49.0


