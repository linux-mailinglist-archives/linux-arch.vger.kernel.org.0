Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296C2352CFD
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhDBPS3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:18:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51006 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235304AbhDBPSV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkFz0Y09z9v2mB;
        Fri,  2 Apr 2021 17:18:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TNsWx4HFdgfR; Fri,  2 Apr 2021 17:18:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkFy6Rvjz9v2ls;
        Fri,  2 Apr 2021 17:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA3E68BB79;
        Fri,  2 Apr 2021 17:18:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kXdNH-tnbrin; Fri,  2 Apr 2021 17:18:16 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C7018BB7C;
        Fri,  2 Apr 2021 17:18:16 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 12AC46798A; Fri,  2 Apr 2021 15:18:16 +0000 (UTC)
Message-Id: <9590d262050923a22d434358a9037131f67fcaae.1617375802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 14/20] riscv: Convert to GENERIC_CMDLINE
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
Date:   Fri,  2 Apr 2021 15:18:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: Remove the message when forcing
---
 arch/riscv/Kconfig        | 44 +--------------------------------------
 arch/riscv/kernel/setup.c |  7 +++----
 2 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 87d7b52f278f..3dbd50bed037 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMDLINE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
@@ -390,49 +391,6 @@ endmenu
 
 menu "Boot options"
 
-config CMDLINE
-	string "Built-in kernel command line"
-	help
-	  For most platforms, the arguments for the kernel's command line
-	  are provided at run-time, during boot. However, there are cases
-	  where either no arguments are being provided or the provided
-	  arguments are insufficient or even invalid.
-
-	  When that occurs, it is possible to define a built-in command
-	  line here and choose how the kernel should use it later on.
-
-choice
-	prompt "Built-in command line usage" if CMDLINE != ""
-	default CMDLINE_FALLBACK
-	help
-	  Choose how the kernel will handle the provided built-in command
-	  line.
-
-config CMDLINE_FALLBACK
-	bool "Use bootloader kernel arguments if available"
-	help
-	  Use the built-in command line as fallback in case we get nothing
-	  during boot. This is the default behaviour.
-
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided during boot will be
-	  appended to the built-in command line. This is useful in
-	  cases where the provided arguments are insufficient and
-	  you don't want to or cannot modify them.
-
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	help
-	  Always use the built-in command line, even if we get one during
-	  boot. This is useful in case you need to override the provided
-	  command line on systems where you don't have or want control
-	  over it.
-
-endchoice
-
 config EFI_STUB
 	bool
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f8f15332caa2..d4f16a9c1762 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
 #include <linux/efi.h>
+#include <linux/cmdline.h>
 
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
@@ -228,10 +229,8 @@ static void __init parse_dtb(void)
 	}
 
 	pr_err("No DTB passed to the kernel\n");
-#ifdef CONFIG_CMDLINE_FORCE
-	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
-#endif
+
+	cmdline_build(boot_command_line, NULL);
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.25.0

