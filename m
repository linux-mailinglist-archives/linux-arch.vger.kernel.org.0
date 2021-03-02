Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5032B4BE
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354186AbhCCF1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:27:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:44261 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352011AbhCBRvJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqkXv5h6Lz9v1C5;
        Tue,  2 Mar 2021 18:25:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iMobo7Uj95lP; Tue,  2 Mar 2021 18:25:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqkXv07VPz9v1C4;
        Tue,  2 Mar 2021 18:25:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB7A38B75F;
        Tue,  2 Mar 2021 18:25:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oLcqukm6Bo_U; Tue,  2 Mar 2021 18:25:20 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77FDD8B7B6;
        Tue,  2 Mar 2021 18:25:20 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 5247C674A2; Tue,  2 Mar 2021 17:25:20 +0000 (UTC)
Message-Id: <e1a498d02d47ec2420b404bd5f3e4a00fc628532.1614705851.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614705851.git.christophe.leroy@csgroup.eu>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/7] cmdline: Add capability to prepend the command line
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue,  2 Mar 2021 17:25:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchs adds an option of prepend a text to the command
line instead of appending it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/cmdline.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index ae3610bb0ee2..144346051e01 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -31,7 +31,7 @@ static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_
 }
 
 /*
- * This function will append a builtin command line to the command
+ * This function will append or prepend a builtin command line to the command
  * line provided by the bootloader. Kconfig options can be used to alter
  * the behavior of this builtin command line.
  * @dest: The destination of the final appended/prepended string.
@@ -50,6 +50,9 @@ static __always_inline void cmdline_build(char *dest, const char *src, size_t le
 		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND) && sizeof(CONFIG_CMDLINE) > 1)
+		cmdline_strlcat(dest, CONFIG_CMDLINE " ", length);
 #endif
 	if (dest != src)
 		cmdline_strlcat(dest, src, length);
-- 
2.25.0

