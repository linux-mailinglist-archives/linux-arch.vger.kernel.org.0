Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E25FCA32
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJLSCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLSCS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 14:02:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA74CBFE9;
        Wed, 12 Oct 2022 11:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 902B9B81B9B;
        Wed, 12 Oct 2022 18:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F627C433D6;
        Wed, 12 Oct 2022 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665597733;
        bh=NricyThb6w2KJUGBxOv0kWU76Th+ejw/kbIbeN8Gwp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UluXDeQReHPSqfdATziJGZk4Yw0/lpESvtY9t1yP5J1FHpNolVlGA1So4x0w93tKY
         I7ijjfFwzBncoGghsZwoEW/aV3vJcP9Aa7geW3G5At9iRb4UbjQIySsStJHd9HXdUJ
         WD/EQo5ID7p7YO7Zz6g0yKZsU/7T6KSDKl9JKCS1KfU97NvaVFC7+UGbaDNNdxgu5F
         6SxpzkcYErgVypkhvmxto0b1SNOJ6wBiOMOSCYaEsuUzKKMxyok2bFyFkorzMBWuVf
         AzFkXgJvdLrf+Js5yT8I2IKl91OMqxs/xG8n0iqoeUun6koYdcqRDRpWgAWnLhxqzN
         qSducaTzBWB/A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 2/2] kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Thu, 13 Oct 2022 03:01:18 +0900
Message-Id: <20221012180118.331005-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012180118.331005-1-masahiroy@kernel.org>
References: <20221012180118.331005-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The use of an undefined macro in an #if directive is warned, but only
in *.c files. No warning from other files such as *.S, *.lds.S.

Since -Wundef is a preprocessor-related warning, it should be added to
KBUILD_CPPFLAGS instead of KBUILD_CFLAGS.

Fix some uncovered issues.

[1] Add -D__LINUX_ARM_ARCH__=* to KBUILD_CPPFLAGS

In file included from arch/arm/kernel/vmlinux.lds.S:13:
./arch/arm/include/asm/cache.h:23:31: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
   23 | #if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
      |                               ^~~~~~~~~~~~~~~~~~

[2] Add missing #include <asm/pgtable.h>

In file included from arch/arm/mm/cache-v7.S:17:
arch/arm/mm/proc-macros.S:109:5: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
  109 | #if L_PTE_SHARED != PTE_EXT_SHARED
      |     ^~~~~~~~~~~~
arch/arm/mm/proc-macros.S:109:21: warning: "PTE_EXT_SHARED" is not defined, evaluates to 0 [-Wundef]
  109 | #if L_PTE_SHARED != PTE_EXT_SHARED
      |                     ^~~~~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:10: warning: "L_PTE_XN" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |          ^~~~~~~~
arch/arm/mm/proc-macros.S:113:19: warning: "L_PTE_USER" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                   ^~~~~~~~~~
arch/arm/mm/proc-macros.S:113:30: warning: "L_PTE_RDONLY" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                              ^~~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:43: warning: "L_PTE_DIRTY" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                                           ^~~~~~~~~~~
arch/arm/mm/proc-macros.S:113:55: warning: "L_PTE_YOUNG" is not defined, evaluates to 0 [-Wundef]
  113 |         (L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
      |                                                       ^~~~~~~~~~~
arch/arm/mm/proc-macros.S:114:10: warning: "L_PTE_PRESENT" is not defined, evaluates to 0 [-Wundef]
  114 |          L_PTE_PRESENT) > L_PTE_SHARED
      |          ^~~~~~~~~~~~~
arch/arm/mm/proc-macros.S:114:27: warning: "L_PTE_SHARED" is not defined, evaluates to 0 [-Wundef]
  114 |          L_PTE_PRESENT) > L_PTE_SHARED
      |                           ^~~~~~~~~~~~

[3] #if -> #ifdef

arch/riscv/kernel/head.S:329:5: warning: "CONFIG_RISCV_BOOT_SPINWAIT" is not defined, evaluates to 0 [-Wundef]
  329 | #if CONFIG_RISCV_BOOT_SPINWAIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~

[4] #elif -> #elif defined()

arch/s390/boot/decompressor.c:28:7: warning: "CONFIG_KERNEL_ZSTD" is not defined, evaluates to 0 [-Wundef]
   28 | #elif CONFIG_KERNEL_ZSTD
      |       ^~~~~~~~~~~~~~~~~~

[5] Exclude arm64 for now

In file included from arch/arm64/kernel/vmlinux.lds.S:65:
arch/arm64/include/asm/kernel-pgtable.h:135:41: warning: "PMD_SHIFT" is not defined, evaluates to 0 [-Wundef]
  135 | #define ARM64_MEMSTART_SHIFT            PMD_SHIFT
      |                                         ^~~~~~~~~
In file included from arch/arm64/include/asm/asm-uaccess.h:8,
                 from arch/arm64/kernel/entry.S:29:
arch/arm64/include/asm/kernel-pgtable.h:135:41: warning: "PMD_SHIFT" is not defined, evaluates to 0 [-Wundef]
  135 | #define ARM64_MEMSTART_SHIFT            PMD_SHIFT
      |                                         ^~~~~~~~~

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Suppress arm64 warnings

Changes in v2:
  - Fix warnings

 Makefile                      | 4 ++--
 arch/arm/Makefile             | 1 +
 arch/arm/mm/proc-macros.S     | 1 +
 arch/arm64/Makefile           | 4 ++++
 arch/riscv/kernel/head.S      | 2 +-
 arch/s390/boot/decompressor.c | 2 +-
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 790760d26ea0..b7fff76a33eb 100644
--- a/Makefile
+++ b/Makefile
@@ -559,12 +559,12 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
 		   -std=gnu11
-KBUILD_CPPFLAGS := -D__KERNEL__
+KBUILD_CPPFLAGS := -D__KERNEL__ -Wundef
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
 		    --target=$(objtree)/rust/target.json \
 		    -Cpanic=abort -Cembed-bitcode=n -Clto=n \
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c846119c448f..f8a1ae6beef7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -132,6 +132,7 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
+KBUILD_CPPFLAGS	+= $(filter -D%, $(arch-y))
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index fa6999e24b07..e43f6d716b4b 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -6,6 +6,7 @@
  *  VM_EXEC
  */
 #include <asm/asm-offsets.h>
+#include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
 #ifdef CONFIG_CPU_V7M
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5e56d26a2239..ca8a02e3e591 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,6 +36,10 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
+# REVISIT
+KBUILD_CPPFLAGS	:= $(filter-out -Wundef, $(KBUILD_CPPFLAGS))
+KBUILD_CFLAGS	+= -Wundef
+
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b865046e4dbb..4bf6c449d78b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -326,7 +326,7 @@ clear_bss_done:
 	call soc_early_init
 	tail start_kernel
 
-#if CONFIG_RISCV_BOOT_SPINWAIT
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 .Lsecondary_start:
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
diff --git a/arch/s390/boot/decompressor.c b/arch/s390/boot/decompressor.c
index e27c2140d620..f96657faffdc 100644
--- a/arch/s390/boot/decompressor.c
+++ b/arch/s390/boot/decompressor.c
@@ -25,7 +25,7 @@
 
 #ifdef CONFIG_KERNEL_BZIP2
 #define BOOT_HEAP_SIZE	0x400000
-#elif CONFIG_KERNEL_ZSTD
+#elif defined(CONFIG_KERNEL_ZSTD)
 #define BOOT_HEAP_SIZE	0x30000
 #else
 #define BOOT_HEAP_SIZE	0x10000
-- 
2.34.1

