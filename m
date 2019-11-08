Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5FCF3F24
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfKHFDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41339 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfKHFDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so3849354pfq.8
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyvqWALI8MnevLv/A8ySJHIuhHx8bMptexZb+6i988I=;
        b=eU/iu2RdQ8b3xWS6EF16dIdGVNDvBbBD9eNSd9wv7EOUjeAg8Vq608VvQwQeOAj2Qg
         i/HGE/HRtSq2juUPd5OZbNUt1SJ3UKIzxNqBhiWS2axFK2hQiwDaTWS4tI3BPVxl2hAT
         ZqoqGh6eoWkfeceUkwr+UFknixVFrNf5IZLw5R/IB6o4WGvnt7ulyY53aSSFzpg7P6ng
         A3E5zB17UaCjA3Fk/C40PinXScozGA0TKqzRLPmFnZ9JSfz86ChXC0TaQhWy5DGBGsUZ
         8C2lznXQyN+Bd4g9I57p876kjZwCM28oKhVZ7svtlC7qagEWyATeGrQtyajv57HIxEfQ
         zYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyvqWALI8MnevLv/A8ySJHIuhHx8bMptexZb+6i988I=;
        b=rIIa4KDsLIXZS5lXmREYpWJ7Dq3HA0bSPCRHRAprupUZmEG7HcdXrNpiyubN/ruEZ4
         rd0+x+BPdW4MlnFF93/cdX4gC2E79xo3suWFur9TzoBUBnEppJcKrgnV5+I5wV1GNzM+
         igDCFkrDLdIEnk/78HZgGB8dcv23Cl15EerLv0Ov+W7gUc6PnbVsMs7xuWRy5/1ww+He
         jbBKx+b3PfAMf8rx4QpnIiI8pGk6g0Ljx84yvLjbC1bigBH7zXAExAcXFLoJY7RmD7OY
         IulWr7rUbG9ZBt6WvjtAqFMZZ2iQgysJxxkAcZgv9p0aWanKXzzFHE9HmeR1UBIudrv8
         xE3Q==
X-Gm-Message-State: APjAAAWvo6QQO4mQDs0Z8gnE2lEzLEEmw0OSawEeiJ8ZuIZh3j7QLcCd
        +3DFn9C/qnBegVFBUOpmW8c=
X-Google-Smtp-Source: APXvYqw7/wd1w7j241VU4UTj3rC4Cd4rbC6pZMhnohEChwDkTKwg8LXqGUL4u8mYjNDdGC76NvnTQQ==
X-Received: by 2002:a63:f246:: with SMTP id d6mr9410497pgk.368.1573189403660;
        Thu, 07 Nov 2019 21:03:23 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id y26sm4797659pfo.76.2019.11.07.21.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:23 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id CABF9201ACFCD9; Fri,  8 Nov 2019 14:03:21 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 11/37] lkl: basic kernel console support
Date:   Fri,  8 Nov 2019 14:02:26 +0900
Message-Id: <9dc36b27c3a7f584425de69495e7196e0987be4c.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
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
index 7c0c0967c44a..6ae781419ce6 100644
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
@@ -76,6 +78,8 @@ struct lkl_jmp_buf {
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
2.20.1 (Apple Git-117)

