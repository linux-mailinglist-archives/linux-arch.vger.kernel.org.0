Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF9352C4C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhDBPSI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:18:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40685 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPSH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:18:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkFj2vNPz9v2lt;
        Fri,  2 Apr 2021 17:18:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NJ34BehnDmHj; Fri,  2 Apr 2021 17:18:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkFj1ndyz9v2ls;
        Fri,  2 Apr 2021 17:18:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2774B8BB7C;
        Fri,  2 Apr 2021 17:18:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wc8EW3tptikR; Fri,  2 Apr 2021 17:18:03 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 99C3C8BB7B;
        Fri,  2 Apr 2021 17:18:02 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 701DA67989; Fri,  2 Apr 2021 15:18:02 +0000 (UTC)
Message-Id: <68db4e57bb88c523f76dcae12feafbb0cae1a85d.1617375802.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 01/20] cmdline: Add generic function to build command line.
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
Date:   Fri,  2 Apr 2021 15:18:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This code provides architectures with a way to build command line
based on what is built in the kernel and what is handed over by the
bootloader, based on selected compile-time options.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3:
- Addressed comments from Will
- Added capability to have src == dst
v4:
- Add cmdline_strlcpy()
- Removed cmdline_build() macro, __cmdline_build() becomes cmdline_build()
- Fixed the destination length to COMMAND_LINE_SIZE
- Truncate at a space not in a quote when too long
- Added a message when forcing the command line
---
 include/linux/cmdline.h | 79 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..a0773dc365c7
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+#include <linux/string.h>
+#include <linux/printk.h>
+#include <asm/setup.h>
+
+/* Allow users to override strlcat/strlcpy, powerpc can't use strings so early*/
+#ifndef cmdline_strlcat
+#define cmdline_strlcat strlcat
+#define cmdline_strlcpy strlcpy
+#endif
+
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dst: The destination of the final command line (Min. size COMMAND_LINE_SIZE)
+ * @src: The starting string or NULL if there isn't one. Must not equal dst.
+ * Returns: false if the string was truncated, true otherwise
+ */
+static __always_inline bool __cmdline_build(char *dst, const char *src)
+{
+	int len;
+	char *ptr, *last_space;
+	bool in_quote = false;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE))
+		src = NULL;
+
+	dst[0] = 0;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
+		len = cmdline_strlcat(dst, CONFIG_CMDLINE " ", COMMAND_LINE_SIZE);
+
+	len = cmdline_strlcat(dst, src, COMMAND_LINE_SIZE);
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+
+	if (len < COMMAND_LINE_SIZE - 1)
+		return true;
+
+	for (ptr = dst; *ptr; ptr++) {
+		if (*ptr == '"')
+			in_quote = !in_quote;
+		if (*ptr == ' ' && !in_quote)
+			last_space = ptr;
+	}
+	if (last_space)
+		*last_space = 0;
+
+	return false;
+}
+
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dst: The destination of the final command line (Min. size COMMAND_LINE_SIZE)
+ * @src: The starting string or NULL if there isn't one.
+ */
+static __always_inline void cmdline_build(char *dst, const char *src)
+{
+	static char tmp[COMMAND_LINE_SIZE] __initdata;
+
+	if (src == dst) {
+		cmdline_strlcpy(tmp, src, COMMAND_LINE_SIZE);
+		src = tmp;
+	}
+	if (!__cmdline_build(dst, src))
+		pr_warn("Command line is too long, it has been truncated\n");
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE))
+		pr_info("Forcing kernel command line to: %s\n", dst);
+}
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.25.0

