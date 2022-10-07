Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEC5F736C
	for <lists+linux-arch@lfdr.de>; Fri,  7 Oct 2022 05:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJGDqI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 23:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJGDqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 23:46:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D2AA98DA
        for <linux-arch@vger.kernel.org>; Thu,  6 Oct 2022 20:46:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a23so3532304pgi.10
        for <linux-arch@vger.kernel.org>; Thu, 06 Oct 2022 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Of6uuZrFPfhKGdyJ9elZ3n4OUuukfLcOMEiama6UO5k=;
        b=PBFEwd3G8uAm7W3VBr4bDcubtKKrL5V+TRGD0qJjwhY/EtlwL2a7OAqTPQpAad25ny
         sLbAGN6yIWmyV1oFHnZ5XWfjr67fVKwWkvuZeEGzZ136wiIZKwGiv252h8van0KRIx19
         klGi4Eery7RorgPC3KEEanMn0nXbD8V9Nu+vnnEE/Pe1Jyct4dlN9SPkwzocuswvEtUx
         JeWf4oxTjhart58vDRMv8xYljaERFJXA88M4howi+Fxv9IcfjpS5L7XkCUJHKNlCn48S
         0InYIGkouoXsLlDh6cemDmldFHL0dJZv+Vs3v/obxnibEmvtbZDSfy1/8EN8EAUHM1ms
         FbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Of6uuZrFPfhKGdyJ9elZ3n4OUuukfLcOMEiama6UO5k=;
        b=LjmJJknr6wIVvuZqaFJzvApSNWj/DjhdiuVl6S4FkaQVrZkEaq5ZRa+wNVxxQkbP8E
         qRfkOQ0pk5WHcIjYX7EGkqbnVb1XlzZ/E8GEk1/NHajV4LXgLmGoCnXqKG7iSh5GZdgb
         eFYIxvTLNR6roVIYS3Nmk+wTpKWiDWuyQJEjBQKi1HOD8soIcPYVC/hP8A5H906zwDf6
         Cfnahn5L2PqBpMR1gH365a7rpjhUySfZnp4bOX68Ik6fOCHGGIW+meEQKVqIYjptJ7/7
         OjIRWSu0amCADOhgp5tskYSl8SeRto+GPZ+qykQgKWONI1lytXK+RdifqB64/ccplsT2
         8F1A==
X-Gm-Message-State: ACrzQf1D4kkI0CecszeAn81MpO4K19KEF3xg7i7n1A47KtbYG/inB+4a
        DdV04wyPvapPirhBGlNrj8ZJHQ==
X-Google-Smtp-Source: AMsMyM7xScmQctzsPbDjjfHv9MGnyXNwQVI9akId+CqGr1yRA3TUA03YJQzQadjdA8w1enEaYZT/tQ==
X-Received: by 2002:a05:6a00:2290:b0:541:f19:5197 with SMTP id f16-20020a056a00229000b005410f195197mr2799706pfe.42.1665114361852;
        Thu, 06 Oct 2022 20:46:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b00562b05c9674sm416027pfb.130.2022.10.06.20.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 20:46:01 -0700 (PDT)
Subject: [PATCH] arch, drivers: Add HAVE_IOREMAP_CACHE
Date:   Thu,  6 Oct 2022 20:44:26 -0700
Message-Id: <20221007034426.21713-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ioremap_cache() isn't recommended for portable drivers, but there's a
handful of uses of it within the kernel.  This adds a HAVE_IOREMAP_CACHE
Kconfig, which is enabled for the ports that have implemented it and
added as a driver dependency when ioremap_cache() is uncoditionally
called (a handful of drivers have arch-specific ifdefs already, those I
left alone).

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

Not sure what to do about splitting this up, it touches a lot of trees
but it seems saner to do this atomicly.  I've just included linux-arch
for now, just to try and keep from blasting everyone.  Another option
here would be to add some sort of ioremap_cache() fallback, but I'm
assuming that has not been done to discourage more use of
ioremap_cache() in drivers.

I'm also not sure all these ports should have ioremap_cache(), but I
figured it'd be easier to just enumerate what's there rather than trying
to change the ports.  Preventing the drivers from compiling also seems
like a pretty heavy hammer, as it seems like some of these could have
their ioremap_cache() dependency removed pretty easily, but again I
figured it'd be better to start small.

This has barely been tested, just a defconfig build on x86.  That's very
much insufficient, but with this touching so many ports I figure it's
better to let the autobuilders have at that.
---
 arch/Kconfig                   | 3 +++
 arch/arm/Kconfig               | 1 +
 arch/arm64/Kconfig             | 1 +
 arch/ia64/Kconfig              | 1 +
 arch/loongarch/Kconfig         | 1 +
 arch/mips/Kconfig              | 1 +
 arch/powerpc/Kconfig           | 1 +
 arch/sh/Kconfig                | 1 +
 arch/x86/Kconfig               | 1 +
 arch/xtensa/Kconfig            | 1 +
 drivers/acpi/apei/Kconfig      | 2 +-
 drivers/firmware/meson/Kconfig | 1 +
 drivers/gpu/drm/Kconfig        | 2 +-
 drivers/mtd/devices/Kconfig    | 2 +-
 drivers/mtd/maps/Kconfig       | 2 +-
 drivers/video/fbdev/Kconfig    | 2 +-
 include/acpi/acpi_io.h         | 2 +-
 17 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a..2b282fabde13 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -188,6 +188,9 @@ config USER_RETURN_NOTIFIER
 	  Provide a kernel-internal notification when a cpu is about to
 	  switch to user mode.
 
+config HAVE_IOREMAP_CACHE
+	def_bool n
+
 config HAVE_IOREMAP_PROT
 	bool
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..a5e738e0ddd7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -100,6 +100,7 @@ config ARM
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_IOREMAP_CACHE if MMU
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
 	select HAVE_KERNEL_LZMA
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..e0de7f45fbde 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -190,6 +190,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOREMAP_CACHE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KVM
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 26ac8ea15a9e..e51612a94c73 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -53,6 +53,7 @@ config IA64
 	select GENERIC_TIME_VSYSCALL
 	select LEGACY_TIMER_TICK
 	select SWIOTLB
+	select HAVE_IOREMAP_CACHE
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4abc9a28aba4..90d9ad188e67 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -85,6 +85,7 @@ config LOONGARCH
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_GENERIC_VDSO
+	select HAVE_IOREMAP_CACHE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec21f8999249..2900d5c5d5f1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -74,6 +74,7 @@ config MIPS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
+	select HAVE_IOREMAP_CACHE if MMU
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c466acdc70d..c552fc97aad2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,6 +223,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
+	select HAVE_IOREMAP_CACHE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..bd9426cfc13b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -37,6 +37,7 @@ config SUPERH
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_HW_BREAKPOINT
+	select HAVE_IOREMAP_CACHE if MMU
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..05fa399fe103 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_IOREMAP_CACHE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 12ac277282ba..edfa5127322c 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -42,6 +42,7 @@ config XTENSA
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS if GCC_VERSION >= 120000
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOREMAP_CACHE
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..56e215641e63 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -10,7 +10,7 @@ config ACPI_APEI
 	select MISC_FILESYSTEMS
 	select PSTORE
 	select UEFI_CPER
-	depends on HAVE_ACPI_APEI
+	depends on HAVE_ACPI_APEI && HAVE_IOREMAP_CACHE
 	help
 	  APEI allows to report errors (for example from the chipset)
 	  to the operating system. This improves NMI handling
diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index f2fdd3756648..612ca9ad3256 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -7,5 +7,6 @@ config MESON_SM
 	depends on ARCH_MESON || COMPILE_TEST
 	default y
 	depends on ARM64_4K_PAGES
+	depends on HAVE_IOREMAP_CACHE
 	help
 	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6c2256e8474b..3c28b3ee1384 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -405,7 +405,7 @@ source "drivers/gpu/drm/sprd/Kconfig"
 
 config DRM_HYPERV
 	tristate "DRM Support for Hyper-V synthetic video device"
-	depends on DRM && PCI && MMU && HYPERV
+	depends on DRM && PCI && MMU && HYPERV && HAVE_IOREMAP_CACHE
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	help
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 79cb981ececc..e6b55cab5a4a 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -114,7 +114,7 @@ config MTD_SST25L
 
 config MTD_BCM47XXSFLASH
 	tristate "Support for serial flash on BCMA bus"
-	depends on BCMA_SFLASH && (MIPS || ARM)
+	depends on BCMA_SFLASH && (MIPS || ARM) && HAVE_IOREMAP_CACHE
 	help
 	  BCMA bus can have various flash memories attached, they are
 	  registered by bcma as platform devices. This enables driver for
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index e098ae937ce8..e40d3277dcf6 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -183,7 +183,7 @@ config MTD_SBC_GXX
 
 config MTD_PXA2XX
 	tristate "CFI Flash device mapped on Intel XScale PXA2xx based boards"
-	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT
+	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT && HAVE_IOREMAP_CACHE
 	help
 	  This provides a driver for the NOR flash attached to a PXA2xx chip.
 
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index cfc55273dc5d..99f160319b5c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2181,7 +2181,7 @@ config FB_BROADSHEET
 
 config FB_HYPERV
 	tristate "Microsoft Hyper-V Synthetic Video support"
-	depends on FB && HYPERV
+	depends on FB && HYPERV && HAVE_IOREMAP_CACHE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 027faa8883aa..4fb945a449e6 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -6,7 +6,7 @@
 
 #include <asm/acpi.h>
 
-#ifndef acpi_os_ioremap
+#if !defined(acpi_os_ioremap) && defined(CONFIG_HAVE_IOREMAP_CACHE)
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
-- 
2.34.1

