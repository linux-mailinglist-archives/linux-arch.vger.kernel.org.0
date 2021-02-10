Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F33168DB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhBJOOC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 09:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhBJONP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 09:13:15 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E753C06178B
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 06:11:46 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id TSBj2400s4C55Sk01SBjmn; Wed, 10 Feb 2021 15:11:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDX-005Ht0-8l; Wed, 10 Feb 2021 15:11:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDW-006Jqr-Sp; Wed, 10 Feb 2021 15:11:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] microblaze: Remove support for gcc < 4
Date:   Wed, 10 Feb 2021 15:11:40 +0100
Message-Id: <20210210141140.1506212-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210141140.1506212-1-geert+renesas@glider.be>
References: <20210210141140.1506212-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
to 4.6") , the kernel can no longer be compiled using gcc-3.
Hence drop support code for gcc-3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/microblaze/kernel/module.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/microblaze/kernel/module.c b/arch/microblaze/kernel/module.c
index 9f12e3c2bb42a319..e5db3a57b9e30d9e 100644
--- a/arch/microblaze/kernel/module.c
+++ b/arch/microblaze/kernel/module.c
@@ -24,9 +24,6 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 	Elf32_Sym *sym;
 	unsigned long int *location;
 	unsigned long int value;
-#if __GNUC__ < 4
-	unsigned long int old_value;
-#endif
 
 	pr_debug("Applying add relocation section %u to %u\n",
 		relsec, sechdrs[relsec].sh_info);
@@ -49,40 +46,17 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 		 */
 
 		case R_MICROBLAZE_32:
-#if __GNUC__ < 4
-			old_value = *location;
-			*location = value + old_value;
-
-			pr_debug("R_MICROBLAZE_32 (%08lx->%08lx)\n",
-				old_value, value);
-#else
 			*location = value;
-#endif
 			break;
 
 		case R_MICROBLAZE_64:
-#if __GNUC__ < 4
-			/* Split relocs only required/used pre gcc4.1.1 */
-			old_value = ((location[0] & 0x0000FFFF) << 16) |
-					(location[1] & 0x0000FFFF);
-			value += old_value;
-#endif
 			location[0] = (location[0] & 0xFFFF0000) |
 					(value >> 16);
 			location[1] = (location[1] & 0xFFFF0000) |
 					(value & 0xFFFF);
-#if __GNUC__ < 4
-			pr_debug("R_MICROBLAZE_64 (%08lx->%08lx)\n",
-				old_value, value);
-#endif
 			break;
 
 		case R_MICROBLAZE_64_PCREL:
-#if __GNUC__ < 4
-			old_value = (location[0] & 0xFFFF) << 16 |
-				(location[1] & 0xFFFF);
-			value -= old_value;
-#endif
 			value -= (unsigned long int)(location) + 4;
 			location[0] = (location[0] & 0xFFFF0000) |
 					(value >> 16);
-- 
2.25.1

