Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3881434A8A5
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhCZNqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:46:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54132 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhCZNpa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:45:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWg6LQyz9v03Q;
        Fri, 26 Mar 2021 14:45:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zJCa16S0wtXm; Fri, 26 Mar 2021 14:45:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWb59d2z9v03M;
        Fri, 26 Mar 2021 14:44:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FD6D8B8C7;
        Fri, 26 Mar 2021 14:45:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hUWtC_m1pLjs; Fri, 26 Mar 2021 14:45:00 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 485328B8CB;
        Fri, 26 Mar 2021 14:45:00 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C232D67611; Fri, 26 Mar 2021 13:45:00 +0000 (UTC)
Message-Id: <3a5407b76a256affa124902d9c2285a98d2516dc.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 13/17] sparc: Convert to GENERIC_CMDLINE
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
Date:   Fri, 26 Mar 2021 13:45:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/sparc/Kconfig           | 18 +-----------------
 arch/sparc/prom/bootstr_64.c |  2 +-
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..2a197f3a2549 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -50,6 +50,7 @@ config SPARC
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select SET_FS
+	select GENERIC_CMDLINE if SPARC64
 
 config SPARC32
 	def_bool !64BIT
@@ -313,23 +314,6 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-	depends on SPARC64
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 root=/dev/sda1"
-	help
-	  Say Y here if you want to be able to pass default arguments to
-	  the kernel. This will be overridden by the bootloader, if you
-	  use one (such as SILO). This is most useful if you want to boot
-	  a kernel from TFTP, and want default options to be available
-	  with having them passed on the command line.
-
-	  NOTE: This option WILL override the PROM bootargs setting!
-
 config SUN_PM
 	bool
 	default y if SPARC32
diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index f1cc34d99eec..4853a45b3de9 100644
--- a/arch/sparc/prom/bootstr_64.c
+++ b/arch/sparc/prom/bootstr_64.c
@@ -25,7 +25,7 @@ struct {
 	char bootstr_buf[BARG_LEN];
 } bootstr_info = {
 	.bootstr_len = BARG_LEN,
-#ifdef CONFIG_CMDLINE
+#if CONFIG_CMDLINE != ""
 	.bootstr_valid = 1,
 	.bootstr_buf = CONFIG_CMDLINE,
 #endif
-- 
2.25.0

