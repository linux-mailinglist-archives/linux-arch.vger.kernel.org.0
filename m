Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D72FC912
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbhATDfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbhATC3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:30 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481FC0613D6
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:54 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g15so14212950pgu.9
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qejdfy+QlJhUSFQGrK0Ia4xgOJlSsrLTBMDT6zR+X90=;
        b=kW/PgAi/wIkh8MXu8GBgZrGyuFHaoHsBmWmghFcucJqqsFCCp9xLEuAaBS37q5MFEe
         ssuer8DcV0pU3SZK9LSut4j8j9/EyGQjiaQIDlP+xl0/B45YPYqUF21iGFWCtuBHKrbs
         nsjeOIMwgD2w70G0+NQDKTAy8PTMtLiCLVHmSGBZscABmK94FdU4+vqUGktLZlmha5KQ
         O8lUwnyqtCwTv40K5YFjQ4IlNFimCkJcwxMVOORc/67wTborR88PGX2RMZYWePGnHigO
         CbxUg2AESDxY9h09rgfrTlV2FRWgPTtgpJckRRQbDDPmbz4/KjE8p6bCcrnVz4N4vnCQ
         IONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qejdfy+QlJhUSFQGrK0Ia4xgOJlSsrLTBMDT6zR+X90=;
        b=fU2BHR6vCq2dkDHjqSHCC/WvM+BXBvujIWPUdDUkrUwVA+bGgPleWTZddBqw8fub/M
         6/zFDm88Wir5u+YVE6jgoW12ORMAZ1fDaKm1gSagNyjEvIsjwS/TP9gtehGpDy+8J4/B
         enYq0VL/7Klm2pwaUuedU2TJSxzJLZkdU4IVitU/+NneLVkFczVgTTUzXbSGipvLpO27
         zqzPI6U2m1siQEbwbTItCF8XxiUVjHIsWc4MKB8hV0eVaFpJD4EBZt2anucm834ZY9zR
         30IPuZm1A4rW81W4/UDXZOjoTBdYVL6hGtYcohnf3ZPthgNgmmSAQPhCXwX4lX6s85jg
         4xlw==
X-Gm-Message-State: AOAM5300rnnNNohuhGfah8sY5z+EM3w3jpCtsVWVwwvVeCUBC2SqlsEC
        rGtD3hBOrjVKHCx7gUhUyFw=
X-Google-Smtp-Source: ABdhPJyDqhTEG6lOp1H7FlxI8fLuZjn3ZYGcGT02hoHJDwgVSB7hL9iZ0/8U3kD3r98gVZhCGcw68Q==
X-Received: by 2002:aa7:8c4a:0:b029:1b8:2cd1:9a69 with SMTP id e10-20020aa78c4a0000b02901b82cd19a69mr7042234pfd.46.1611109734264;
        Tue, 19 Jan 2021 18:28:54 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id m15sm271725pji.21.2021.01.19.18.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:53 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5029220442D361; Wed, 20 Jan 2021 11:28:51 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 11/20] um: lkl: basic console support
Date:   Wed, 20 Jan 2021 11:27:16 +0900
Message-Id: <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds a basic structure of console support in kernel.  Write
operations are deferred to the host print operation.

This commit also disables stdio-console of UML when library mode to avoid
conflicts between multiple consoles.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/Makefile                |  8 ++++-
 arch/um/lkl/include/uapi/asm/host_ops.h |  9 ++++++
 arch/um/lkl/um/console.c                | 41 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/lkl/um/console.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index ae96c83e312d..dc0d32d62294 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,13 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
-obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+ifndef CONFIG_UMMODE_LIB
+obj-y := stdio_console.o
+else
+obj-y :=
+endif
+obj-y += fd.o chan_kern.o chan_user.o line.o
+
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index b97aa1099a17..976fc4301b3d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -243,4 +243,13 @@ int lkl_tls_set(struct lkl_tls_key *key, void *data);
  */
 void *lkl_tls_get(struct lkl_tls_key *key);
 
+/**
+ * lkl_print - optional operation that receives console messages
+ *
+ * @str: strings to be printed
+ * @len: the length of @str
+ *
+ */
+void lkl_print(const char *str, int len);
+
 #endif
diff --git a/arch/um/lkl/um/console.c b/arch/um/lkl/um/console.c
new file mode 100644
index 000000000000..f2b48dc7ae22
--- /dev/null
+++ b/arch/um/lkl/um/console.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str, unsigned len)
+{
+	lkl_print(str, len);
+}
+
+#ifdef CONFIG_LKL_EARLY_CONSOLE
+static struct console lkl_boot_console = {
+	.name	= "lkl_boot_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1,
+};
+
+int __init lkl_boot_console_init(void)
+{
+	register_console(&lkl_boot_console);
+	return 0;
+}
+early_initcall(lkl_boot_console_init);
+#endif
+
+static struct console lkl_console = {
+	.name	= "lkl_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
+
-- 
2.21.0 (Apple Git-122.2)

