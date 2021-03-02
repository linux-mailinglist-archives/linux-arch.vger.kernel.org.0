Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176B032B4B9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354176AbhCCF07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:26:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:44895 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352008AbhCBRvJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqkXr0xnBz9v1C0;
        Tue,  2 Mar 2021 18:25:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GmkJLeTlmTYY; Tue,  2 Mar 2021 18:25:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqkXq6QS8z9v1Bx;
        Tue,  2 Mar 2021 18:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F8998B7B5;
        Tue,  2 Mar 2021 18:25:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SpTJBwmTOVdC; Tue,  2 Mar 2021 18:25:17 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 633FD8B75F;
        Tue,  2 Mar 2021 18:25:17 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 32BC5674A2; Tue,  2 Mar 2021 17:25:17 +0000 (UTC)
Message-Id: <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614705851.git.christophe.leroy@csgroup.eu>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/7] cmdline: Add generic function to build command line.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue,  2 Mar 2021 17:25:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This code provides architectures with a way to build command line
based on what is built in the kernel and what is handed over by the
bootloader, based on selected compile-time options.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..ae3610bb0ee2
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+static __always_inline size_t cmdline_strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		; /* nothing */
+	return sc - s;
+}
+
+static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
+{
+	size_t dsize = cmdline_strlen(dest);
+	size_t len = cmdline_strlen(src);
+	size_t res = dsize + len;
+
+	/* This would be a bug */
+	if (dsize >= count)
+		return count;
+
+	dest += dsize;
+	count -= dsize;
+	if (len >= count)
+		len = count - 1;
+	memcpy(dest, src, len);
+	dest[len] = 0;
+	return res;
+}
+
+/*
+ * This function will append a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string.
+ * @src: The starting string or NULL if there isn't one. Must not equal dest.
+ * @length: the length of dest buffer.
+ */
+static __always_inline void cmdline_build(char *dest, const char *src, size_t length)
+{
+	if (length <= 0)
+		return;
+
+	dest[0] = 0;
+
+#ifdef CONFIG_CMDLINE
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
+		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
+		return;
+	}
+#endif
+	if (dest != src)
+		cmdline_strlcat(dest, src, length);
+#ifdef CONFIG_CMDLINE
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && sizeof(CONFIG_CMDLINE) > 1)
+		cmdline_strlcat(dest, " " CONFIG_CMDLINE, length);
+#endif
+}
+
+#endif /* _LINUX_CMDLINE_H */
-- 
2.25.0

