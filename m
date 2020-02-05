Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF21526E2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBEHbG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43289 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so505068plq.10
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbDfaxto/t64vv9cFZcYy/44Xe4iN6lKROWU2ZL+b3E=;
        b=ZyoOdHiwlB8Hkgl+fLTr6lo2otlx7T0JULGyzAT/QokerDUF8CuHzjdOixHH8UJObS
         40FtbG9F0V4HgmB2hpkj3i5ZamxMBRzdMQAZ/8sDcX6zKua09ho0oGNGmZOleZaeo/qz
         futqyFgxJMguLX09+OfUIYzKFsjmtWM1GG7/ZmIOWBq9oWi/jjGpCDOQu/1Aka6QnxM4
         45KZEzBcKRMZJ+cYjv0G/rHKFqzwJbTMckHc4i/xTNg9TWpYrn0pkz6nYefm08MC9WqE
         kJ1KvMYRkK/SYk0/xVnTLXE5QEZfdhhEYydNK+Rtz/drx8brlebaii5pMEuJQTFrhjxX
         DHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbDfaxto/t64vv9cFZcYy/44Xe4iN6lKROWU2ZL+b3E=;
        b=G3XZN7XanUEfeec8edncsT5CMhF2SjaF9DFD1CmnkgqyXIXHCywU3Ceot/7TP4xdvj
         F3OnWAOgdT4kmDnQwWRPbTo7Y7/8Y4He5Rxs6R29jXvmnAwdQbFl/Nf1dm+CD/aYauY/
         qHnYZtCmeYBvYVwQJb9fW5/u7KwKXlglY9t5j7tXpCu8sh78JstROUU49ujLKM+dEp6i
         tTMKH+zoTbHm4Cyh5UI/8JDzvvTjhFAAFeHcQvHr4+dzcKlFbJN7YIhVQ+HAnYiNkqLP
         ygcCSpvco4VxcKWwXVSEhKUzR3kCNA7w1eJUH1j1EAz/Tbqh1v3w1xK66VpAgn9drKbU
         pCDg==
X-Gm-Message-State: APjAAAURmZ8TmtmiK5MDqodtKIjBDg4l6qFxHehVRrDrnwFOsk6eTHh4
        gxYvUqZ5Cu0/Np5pmMXnIhhFsFhNmTM=
X-Google-Smtp-Source: APXvYqxXbg35qC03kIHX1KjqD5j2I/EEfLNjc7mi8P+dOYtpzUy4H/3CE1KXfgBPBiUYIGsPFU/ehA==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr4233611pjq.5.1580887865440;
        Tue, 04 Feb 2020 23:31:05 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id 10sm27288181pfu.132.2020.02.04.23.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:04 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 87B16202573005; Wed,  5 Feb 2020 16:31:03 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v3 10/26] um lkl: basic kernel console support
Date:   Wed,  5 Feb 2020 16:30:19 +0900
Message-Id: <f38b9e100b963bdc88d296287a290728d2ece94e.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Write operations are deferred to the host print operation.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/uapi/asm/host_ops.h |  4 +++
 arch/um/lkl/kernel/console.c            | 42 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/um/lkl/kernel/console.c

diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index c9f77dd7fbe7..986340ba9d8d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -17,6 +17,8 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  *
+ * @print - optional operation that receives console messages
+ *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
  * @sem_up - perform an up operation on the semaphore
@@ -70,6 +72,8 @@ struct lkl_jmp_buf {
  * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
  */
 struct lkl_host_operations {
+	void (*print)(const char *str, int len);
+
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
 	void (*sem_up)(struct lkl_sem *sem);
diff --git a/arch/um/lkl/kernel/console.c b/arch/um/lkl/kernel/console.c
new file mode 100644
index 000000000000..54d7f756c6da
--- /dev/null
+++ b/arch/um/lkl/kernel/console.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str,
+			  unsigned int len)
+{
+	if (lkl_ops->print)
+		lkl_ops->print(str, len);
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
+static int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
-- 
2.21.0 (Apple Git-122.2)

