Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA70D34A8B1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhCZNqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:46:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3245 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhCZNpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:45:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWg6LmQz9v03R;
        Fri, 26 Mar 2021 14:45:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uz_V-1h9wFYT; Fri, 26 Mar 2021 14:45:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWd1R42z9v03N;
        Fri, 26 Mar 2021 14:45:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6CF38B8C9;
        Fri, 26 Mar 2021 14:45:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XVHEkPLY74AV; Fri, 26 Mar 2021 14:45:01 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BE0A8B8C7;
        Fri, 26 Mar 2021 14:45:01 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C962267611; Fri, 26 Mar 2021 13:45:01 +0000 (UTC)
Message-Id: <14bee90f01159aca28390d57be538760980436a4.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 14/17] xtensa: Convert to GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Date:   Fri, 26 Mar 2021 13:45:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/xtensa/Kconfig                         | 15 +--------------
 arch/xtensa/configs/audio_kc705_defconfig   |  1 -
 arch/xtensa/configs/common_defconfig        |  1 -
 arch/xtensa/configs/generic_kc705_defconfig |  1 -
 arch/xtensa/configs/iss_defconfig           |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |  1 -
 arch/xtensa/configs/smp_lx200_defconfig     |  1 -
 arch/xtensa/configs/virt_defconfig          |  1 -
 arch/xtensa/configs/xip_kc705_defconfig     |  1 -
 arch/xtensa/kernel/setup.c                  | 10 ++--------
 10 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9ad6b7b82707..42309f5e9cda 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -16,6 +16,7 @@ config XTENSA
 	select COMMON_CLK
 	select DMA_REMAP if MMU
 	select GENERIC_ATOMIC64
+	select GENERIC_CMDLINE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
@@ -353,20 +354,6 @@ config GENERIC_CALIBRATE_DELAY
 	help
 	  The BogoMIPS value can easily be derived from the CPU frequency.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,38400 root=/dev/ram"
-	help
-	  On some architectures (EBSA110 and CATS), there is currently no way
-	  for the boot loader to pass arguments to the kernel. For these
-	  architectures, you should supply some command-line options at build
-	  time by entering them here. As a minimum, you should specify the
-	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
-
 config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index 3be62da8089b..5f8661a33ab4 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -27,7 +27,6 @@ CONFIG_PREEMPT=y
 CONFIG_HIGHMEM=y
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="kc705"
diff --git a/arch/xtensa/configs/common_defconfig b/arch/xtensa/configs/common_defconfig
index fa9389869154..6467ebcbb080 100644
--- a/arch/xtensa/configs/common_defconfig
+++ b/arch/xtensa/configs/common_defconfig
@@ -6,7 +6,6 @@ CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 CONFIG_XTENSA_PLATFORM_XT2000=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,38400 ip=bootp root=nfs nfsroot=/opt/montavista/pro/devkit/xtensa/linux_be/target memmap=128M@0"
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index e9d6b6f6eca1..8984c4e68a42 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -26,7 +26,6 @@ CONFIG_PREEMPT=y
 CONFIG_HIGHMEM=y
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="kc705"
diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
index 32ce8fb068f0..996ad115264d 100644
--- a/arch/xtensa/configs/iss_defconfig
+++ b/arch/xtensa/configs/iss_defconfig
@@ -2,7 +2,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_PCI is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,38400 eth0=tuntap,,tap0 ip=192.168.168.5:192.168.168.1 root=nfs nfsroot=192.168.168.1:/opt/montavista/pro/devkit/xtensa/linux_be/target memmap=128M@0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 88b2e222d4bf..54250bc74885 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -33,7 +33,6 @@ CONFIG_PREEMPT=y
 CONFIG_MEMMAP_CACHEATTR=0xfff2442f
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0x9d050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=256M@0x60000000"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="kc705_nommu"
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index a47c85638ec1..58b284fd627f 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -30,7 +30,6 @@ CONFIG_HOTPLUG_CPU=y
 # CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX is not set
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=96M@0"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="lx200mx"
diff --git a/arch/xtensa/configs/virt_defconfig b/arch/xtensa/configs/virt_defconfig
index 6d1387dfa96f..fb4dce2c70a3 100644
--- a/arch/xtensa/configs/virt_defconfig
+++ b/arch/xtensa/configs/virt_defconfig
@@ -21,7 +21,6 @@ CONFIG_XTENSA_VARIANT_DC233C=y
 CONFIG_XTENSA_UNALIGNED_USER=y
 CONFIG_XTENSA_KSEG_512M=y
 CONFIG_HIGHMEM=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x80000000@0"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="virt"
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 4f1ff9531f6a..ae4427773af2 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -26,7 +26,6 @@ CONFIG_KERNEL_LOAD_ADDRESS=0xf6000000
 CONFIG_XTENSA_KSEG_512M=y
 CONFIG_HIGHMEM=y
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="kc705"
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ed184106e4cf..9703c23a9c3f 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/cmdline.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 # include <linux/console.h>
@@ -73,10 +74,6 @@ extern unsigned long loops_per_jiffy;
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 
-#ifdef CONFIG_CMDLINE_BOOL
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
-#endif
-
 #ifdef CONFIG_PARSE_BOOTPARAM
 /*
  * Boot parameter parsing.
@@ -257,10 +254,7 @@ void __init init_arch(bp_tag_t *bp_start)
 	early_init_devtree(dtb_start);
 #endif
 
-#ifdef CONFIG_CMDLINE_BOOL
-	if (!command_line[0])
-		strlcpy(command_line, default_command_line, COMMAND_LINE_SIZE);
-#endif
+	cmdline(command_line, command_line, COMMAND_LINE_SIZE);
 
 	/* Early hook for platforms */
 
-- 
2.25.0

