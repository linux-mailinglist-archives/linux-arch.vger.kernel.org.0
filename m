Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F24352D0F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhDBPSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:18:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21614 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235935AbhDBPS0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkG44gBbz9v2m7;
        Fri,  2 Apr 2021 17:18:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sBnAWcx1Go7E; Fri,  2 Apr 2021 17:18:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkG43Nc3z9v2ls;
        Fri,  2 Apr 2021 17:18:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12BCB8BB7C;
        Fri,  2 Apr 2021 17:18:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mdOU6-fT9Uo6; Fri,  2 Apr 2021 17:18:21 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71E4F8BB7F;
        Fri,  2 Apr 2021 17:18:21 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4E3F867989; Fri,  2 Apr 2021 15:18:21 +0000 (UTC)
Message-Id: <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Date:   Fri,  2 Apr 2021 15:18:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/mips/Kconfig                         |  1 +
 arch/mips/Kconfig.debug                   | 44 -----------------------
 arch/mips/configs/ar7_defconfig           |  1 -
 arch/mips/configs/bcm47xx_defconfig       |  1 -
 arch/mips/configs/bcm63xx_defconfig       |  1 -
 arch/mips/configs/bmips_be_defconfig      |  1 -
 arch/mips/configs/bmips_stb_defconfig     |  1 -
 arch/mips/configs/capcella_defconfig      |  1 -
 arch/mips/configs/ci20_defconfig          |  1 -
 arch/mips/configs/cu1000-neo_defconfig    |  1 -
 arch/mips/configs/cu1830-neo_defconfig    |  1 -
 arch/mips/configs/e55_defconfig           |  1 -
 arch/mips/configs/generic_defconfig       |  1 -
 arch/mips/configs/gpr_defconfig           |  1 -
 arch/mips/configs/loongson3_defconfig     |  1 -
 arch/mips/configs/mpc30x_defconfig        |  1 -
 arch/mips/configs/rt305x_defconfig        |  1 -
 arch/mips/configs/tb0219_defconfig        |  1 -
 arch/mips/configs/tb0226_defconfig        |  1 -
 arch/mips/configs/tb0287_defconfig        |  1 -
 arch/mips/configs/workpad_defconfig       |  1 -
 arch/mips/configs/xway_defconfig          |  1 -
 arch/mips/kernel/relocate.c               |  4 +--
 arch/mips/kernel/setup.c                  | 40 ++-------------------
 arch/mips/pic32/pic32mzda/early_console.c |  2 +-
 arch/mips/pic32/pic32mzda/init.c          |  2 --
 26 files changed, 5 insertions(+), 108 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d89efba3d8a4..a65ce9ddbfce 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -24,6 +24,7 @@ config MIPS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 7a8d94cdd493..b5a099c74eb6 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -30,50 +30,6 @@ config EARLY_PRINTK_8250
 config USE_GENERIC_EARLY_PRINTK_8250
 	bool
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	help
-	  For most systems, it is firmware or second stage bootloader that
-	  by default specifies the kernel command line options.  However,
-	  it might be necessary or advantageous to either override the
-	  default kernel command line or add a few extra options to it.
-	  For such cases, this option allows you to hardcode your own
-	  command line options directly into the kernel.  For that, you
-	  should choose 'Y' here, and fill in the extra boot arguments
-	  in CONFIG_CMDLINE.
-
-	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
-	  command line will be ignored and replaced by the built-in string.
-
-	  Most MIPS systems will normally expect 'N' here and rely upon
-	  the command line from the firmware or the second-stage bootloader.
-
-config CMDLINE
-	string "Default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel.  For these platforms, and for the cases
-	  when you want to add some extra options to the command line or ignore
-	  the default command line, you can supply some command-line options at
-	  build time by entering them here.  In other cases you can specify
-	  kernel args so that you don't have to set them up in board prom
-	  initialization routines.
-
-	  For more information, see the CMDLINE_BOOL and CMDLINE_OVERRIDE
-	  options.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides firmware arguments"
-	depends on CMDLINE_BOOL
-	help
-	  By setting this option to 'Y' you will have your kernel ignore
-	  command line arguments from firmware or second stage bootloader.
-	  Instead, the built-in command line will be used exclusively.
-
-	  Normally, you will choose 'N' here.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index cf9c6329b807..5e8adcd799d0 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -120,5 +120,4 @@ CONFIG_SQUASHFS=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 91ce75edbfb4..690f423509f0 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -77,5 +77,4 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 861f680184b9..19b15424f669 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -65,5 +65,4 @@ CONFIG_PROC_KCORE=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index 032bb51defe8..2db7712acc5d 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -75,5 +75,4 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 625bd2d7e685..bc1659d43ca7 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -86,5 +86,4 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 7bf8971af53b..300032a5caa0 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -87,5 +87,4 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index ab7ebb066834..f874e421b54f 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -203,5 +203,4 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index 9d75f5b77d5d..03cb524967e7 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -123,5 +123,4 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon clk_ignore_unused"
diff --git a/arch/mips/configs/cu1830-neo_defconfig b/arch/mips/configs/cu1830-neo_defconfig
index 29decd0003c6..d733ccab494e 100644
--- a/arch/mips/configs/cu1830-neo_defconfig
+++ b/arch/mips/configs/cu1830-neo_defconfig
@@ -126,5 +126,4 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon clk_ignore_unused"
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index fd82b858a8f0..ffc964d1bae7 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -33,5 +33,4 @@ CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x1f0,0x3f6,40 mem=8M"
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 714169e411cf..6003f6c7aa09 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -88,5 +88,4 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon"
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 5cb91509bb7c..8998d28b94c8 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -306,5 +306,4 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 0e79f81217bc..c4f9a236bd1f 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -408,5 +408,4 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="ieee754=relaxed"
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index d4e038802510..6ecef2a666fc 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -49,5 +49,4 @@ CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,19200 ide0=0x170,0x376,73"
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index fec5851c164b..c34441ce6621 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -147,4 +147,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index 6547f84750b5..ccf20bd156a1 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -73,5 +73,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 7e099f7c2286..9f78fd00a4f6 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -68,5 +68,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index 0d881dd862c0..5529d0dacf94 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -81,5 +81,4 @@ CONFIG_NFSD_V3=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 891a5f77305d..ee712f7b5575 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -61,5 +61,4 @@ CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=m
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x170,0x376,49 mem=16M"
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index 9abbc0debc2a..ebd8dbdb0695 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -153,4 +153,3 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 499a5357c09f..13c955027696 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -244,15 +244,13 @@ static inline __init unsigned long get_random_boot(void)
 static inline __init bool kaslr_disabled(void)
 {
 	char *str;
-
-#if defined(CONFIG_CMDLINE_BOOL)
 	const char *builtin_cmdline = CONFIG_CMDLINE;
 
 	str = strstr(builtin_cmdline, "nokaslr");
 	if (str == builtin_cmdline ||
 	    (str > builtin_cmdline && *(str - 1) == ' '))
 		return true;
-#endif
+
 	str = strstr(arcs_cmdline, "nokaslr");
 	if (str == arcs_cmdline || (str > arcs_cmdline && *(str - 1) == ' '))
 		return true;
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 279be0153f8b..f2270528011b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <linux/of_fdt.h>
 #include <linux/dmi.h>
 #include <linux/crash_dump.h>
+#include <linux/cmdline.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -66,12 +67,6 @@ EXPORT_SYMBOL(mips_machtype);
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 
-#ifdef CONFIG_CMDLINE_BOOL
-static const char builtin_cmdline[] __initconst = CONFIG_CMDLINE;
-#else
-static const char builtin_cmdline[] __initconst = "";
-#endif
-
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -546,28 +541,6 @@ static void __init bootcmdline_init(void)
 {
 	bool dt_bootargs = false;
 
-	/*
-	 * If CMDLINE_OVERRIDE is enabled then initializing the command line is
-	 * trivial - we simply use the built-in command line unconditionally &
-	 * unmodified.
-	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-		return;
-	}
-
-	/*
-	 * If the user specified a built-in command line &
-	 * MIPS_CMDLINE_BUILTIN_EXTEND, then the built-in command line is
-	 * prepended to arguments from the bootloader or DT so we'll copy them
-	 * to the start of boot_command_line here. Otherwise, empty
-	 * boot_command_line to undo anything early_init_dt_scan_chosen() did.
-	 */
-	if (IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND))
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	else
-		boot_command_line[0] = 0;
-
 #ifdef CONFIG_OF_EARLY_FLATTREE
 	/*
 	 * If we're configured to take boot arguments from DT, look for those
@@ -585,16 +558,7 @@ static void __init bootcmdline_init(void)
 	 * plat_mem_setup() should have filled arcs_cmdline with arguments from
 	 * the bootloader.
 	 */
-	if (IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND) || !dt_bootargs)
-		bootcmdline_append(arcs_cmdline, COMMAND_LINE_SIZE);
-
-	/*
-	 * If the user specified a built-in command line & we didn't already
-	 * prepend it, we append it to boot_command_line here.
-	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) &&
-	    !IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND))
-		bootcmdline_append(builtin_cmdline, COMMAND_LINE_SIZE);
+	cmdline_build(boot_command_line, arcs_cmdline);
 }
 
 /*
diff --git a/arch/mips/pic32/pic32mzda/early_console.c b/arch/mips/pic32/pic32mzda/early_console.c
index 25372e62783b..94d3a5ba5e10 100644
--- a/arch/mips/pic32/pic32mzda/early_console.c
+++ b/arch/mips/pic32/pic32mzda/early_console.c
@@ -75,7 +75,7 @@ static char * __init pic32_getcmdline(void)
 	 * arch_mem_init() has not been called yet, so we don't have a real
 	 * command line setup if using CONFIG_CMDLINE_BOOL.
 	 */
-#ifdef CONFIG_CMDLINE_OVERRIDE
+#ifdef CONFIG_CMDLINE_FORCE
 	return CONFIG_CMDLINE;
 #else
 	return fw_getcmdline();
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 764f2d022fae..39fdacbbac56 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -40,9 +40,7 @@ void __init plat_mem_setup(void)
 	pr_info("Found following command lines\n");
 	pr_info(" boot_command_line: %s\n", boot_command_line);
 	pr_info(" arcs_cmdline     : %s\n", arcs_cmdline);
-#ifdef CONFIG_CMDLINE_BOOL
 	pr_info(" builtin_cmdline  : %s\n", CONFIG_CMDLINE);
-#endif
 	if (dtb != __dtb_start)
 		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 
-- 
2.25.0

