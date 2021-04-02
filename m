Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA7352C7E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhDBPSP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:18:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9704 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235054AbhDBPSJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkFl3Jq5z9v2m1;
        Fri,  2 Apr 2021 17:18:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id otY6ACZI1rY1; Fri,  2 Apr 2021 17:18:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkFl2Mpwz9v2ls;
        Fri,  2 Apr 2021 17:18:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33C168BB7B;
        Fri,  2 Apr 2021 17:18:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j0ftI9D6qL0u; Fri,  2 Apr 2021 17:18:05 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A27078BB79;
        Fri,  2 Apr 2021 17:18:04 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7ECCA67989; Fri,  2 Apr 2021 15:18:04 +0000 (UTC)
Message-Id: <76542a49b685ddb41894fd53feb250fcec731b01.1617375802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 03/20] x86/efi: Replace CONFIG_CMDLINE_OVERRIDE by
 CONFIG_CMDLINE_FORCE
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
Date:   Fri,  2 Apr 2021 15:18:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During boot, x86 uses EFI driver. That driver is also used
by ARM.

In order to refactor the command line processing in that driver
in a following patch, rename CONFIG_CMDLINE_OVERRIDE by
CONFIG_CMDLINE_FORCE on the x86 in order to be similar
to ARM (and most other architectures).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: New
---
 arch/x86/Kconfig                        | 4 ++--
 arch/x86/kernel/setup.c                 | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..a20684d56b4b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2384,14 +2384,14 @@ config CMDLINE
 	  command line at boot time, it is appended to this string to
 	  form the full kernel command line, when the system boots.
 
-	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  However, you can use the CONFIG_CMDLINE_FORCE option to
 	  change this behavior.
 
 	  In most cases, the command line (whether built-in or provided
 	  by the boot loader) should specify the device for the root
 	  file system.
 
-config CMDLINE_OVERRIDE
+config CMDLINE_FORCE
 	bool "Built-in command line overrides boot loader arguments"
 	depends on CMDLINE_BOOL && CMDLINE != ""
 	help
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..6f2de58eeb54 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -884,7 +884,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
 #ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
+#ifdef CONFIG_CMDLINE_FORCE
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f14c4ff5839f..28659276b6ba 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -742,7 +742,7 @@ unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 #endif
-	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
 		status = efi_parse_options((char *)cmdline_paddr);
-- 
2.25.0

