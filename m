Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A135F34A878
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCZNqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:46:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27933 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhCZNpZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:45:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWT4TPXz9v03D;
        Fri, 26 Mar 2021 14:44:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EEqTBNdfHvPX; Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWT3Zrwz9v03B;
        Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58E9A8B8C9;
        Fri, 26 Mar 2021 14:44:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Yai4PS5jsljR; Fri, 26 Mar 2021 14:44:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0171D8B8C7;
        Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 80E9967611; Fri, 26 Mar 2021 13:44:54 +0000 (UTC)
Message-Id: <3561ef609d471949454d58f969c036f97f596211.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 07/17] hexagon: Convert to GENERIC_CMDLINE
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
Date:   Fri, 26 Mar 2021 13:44:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/hexagon/Kconfig        | 11 +----------
 arch/hexagon/kernel/setup.c | 10 ++--------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..1e69c99bae6b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -18,6 +18,7 @@ config HEXAGON
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
+	select GENERIC_CMDLINE
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
@@ -91,16 +92,6 @@ config HEXAGON_ARCH_VERSION
 	int "Architecture version"
 	default 2
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader
-	  to pass arguments to the kernel. For these, you should supply some
-	  command-line options at build time by entering them here.  At a
-	  minimum, you should specify the memory size and the root device
-	  (e.g., mem=64M root=/dev/nfs).
-
 config SMP
 	bool "Multi-Processing support"
 	help
diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..be586cea4076 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/console.h>
 #include <linux/of_fdt.h>
+#include <linux/cmdline.h>
 #include <asm/io.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -22,7 +23,6 @@
 #include <asm/time.h>
 
 char cmd_line[COMMAND_LINE_SIZE];
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
 int on_simulator;
 
@@ -38,8 +38,6 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	char *p = &external_cmdline_buffer;
-
 	/*
 	 * These will eventually be pulled in via either some hypervisor
 	 * or devicetree description.  Hardwiring for now.
@@ -65,11 +63,7 @@ void __init setup_arch(char **cmdline_p)
 	else
 		on_simulator = 0;
 
-	if (p[0] != '\0')
-		strlcpy(boot_command_line, p, COMMAND_LINE_SIZE);
-	else
-		strlcpy(boot_command_line, default_command_line,
-			COMMAND_LINE_SIZE);
+	cmdline_build(boot_command_line, external_cmdline_buffer, COMMAND_LINE_SIZE);
 
 	/*
 	 * boot_command_line and the value set up by setup_arch
-- 
2.25.0

