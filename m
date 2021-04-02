Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B8352C2F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhDBPSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:18:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61689 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235952AbhDBPS0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkG52l3Hz9v2lx;
        Fri,  2 Apr 2021 17:18:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GzDR9N0g0Rpg; Fri,  2 Apr 2021 17:18:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkG519y8z9v2ls;
        Fri,  2 Apr 2021 17:18:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F0A0F8BB7C;
        Fri,  2 Apr 2021 17:18:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JBXhU7_Qtg1N; Fri,  2 Apr 2021 17:18:22 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 789078BB7D;
        Fri,  2 Apr 2021 17:18:22 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5513E67989; Fri,  2 Apr 2021 15:18:22 +0000 (UTC)
Message-Id: <349128c2baa37dfcafb61a10d4e6c62f93cfe881.1617375803.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 20/20] cmdline: Remove CONFIG_CMDLINE_EXTEND
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
Date:   Fri,  2 Apr 2021 15:18:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All architectures providing CONFIG_CMDLINE_EXTEND
are now converted to GENERIC_CMDLINE.

This configuration item is not used anymore, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/cmdline.h | 2 +-
 init/Kconfig            | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index a0773dc365c7..020028e2bdf0 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -36,7 +36,7 @@ static __always_inline bool __cmdline_build(char *dst, const char *src)
 
 	len = cmdline_strlcat(dst, src, COMMAND_LINE_SIZE);
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+	if (IS_ENABLED(CONFIG_CMDLINE_APPEND))
 		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 
 	if (len < COMMAND_LINE_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index af0d84662cc2..fa002e3765ab 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -163,12 +163,6 @@ config CMDLINE_FORCE
 	  arguments provided by the bootloader.
 endchoice
 
-config CMDLINE_EXTEND
-	bool
-	default CMDLINE_APPEND
-	help
-	  To be removed once all architectures are converted to generic CMDLINE
-
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on HAS_IOMEM
-- 
2.25.0

