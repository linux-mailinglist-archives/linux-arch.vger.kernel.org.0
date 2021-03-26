Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5262434A86C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCZNp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 09:45:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42407 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhCZNoz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 09:44:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6NWM2kR9z9tyyX;
        Fri, 26 Mar 2021 14:44:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WniDc8Yabw7u; Fri, 26 Mar 2021 14:44:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWM1m9wz9tyyV;
        Fri, 26 Mar 2021 14:44:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18F9E8B8C9;
        Fri, 26 Mar 2021 14:44:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BZpKcB1zy9W0; Fri, 26 Mar 2021 14:44:48 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C3A018B8C7;
        Fri, 26 Mar 2021 14:44:47 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4859067611; Fri, 26 Mar 2021 13:44:48 +0000 (UTC)
Message-Id: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 01/17] cmdline: Add generic function to build command line.
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
Date:   Fri, 26 Mar 2021 13:44:48 +0000 (UTC)
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
---
 include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..dea87edd41be
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+#include <linux/string.h>
+
+/* Allow architectures to override strlcat, powerpc can't use strings so early */
+#ifndef cmdline_strlcat
+#define cmdline_strlcat strlcat
+#endif
+
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dst: The destination of the final appended/prepended string.
+ * @src: The starting string or NULL if there isn't one.
+ * @len: the length of dest buffer.
+ */
+static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
+{
+	if (!len || src == dst)
+		return;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
+		dst[0] = 0;
+		cmdline_strlcat(dst, CONFIG_CMDLINE, len);
+		return;
+	}
+
+	if (dst != src)
+		dst[0] = 0;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
+		cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
+
+	cmdline_strlcat(dst, src, len);
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+		cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
+}
+
+#define cmdline_build(dst, src, len) do {				\
+	char *__c_dst = (dst);						\
+	const char *__c_src = (src);					\
+									\
+	if (__c_src == __c_dst) {					\
+		static char __c_tmp[COMMAND_LINE_SIZE] __initdata = "";	\
+									\
+		cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);	\
+		__cmdline_build(__c_dst, __c_tmp, (len));		\
+	} else {							\
+		__cmdline_build(__c_dst, __c_src, (len));		\
+	}								\
+} while (0)
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.25.0

