Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC54197ED0
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgC3Orv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:47:51 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52422 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgC3Orv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:47:51 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so7677968pjb.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WJWXIBn2EeJafNFgCrfWBYhVUMwRu8tn6FcwGDWnVA=;
        b=iCIVxfyXhJPCtvZuxxdFOqNact2m60anKnxGvMI61GdQufDa7q6HrC0pdRxy2q4JjM
         dPMq/ALeRzrtRtP/2v8gAmFh+eTkY4l6+nGt9Qqla1FxCHsO/vJtMosdTZNp/FucHhqI
         baTDDPeLrJk5zhCdDR7HpCS+8Cwd1OkeiFQFDEj8y4UK8J8Yo/e3GFMts/Tv8y349mAv
         SWzhJdzqUFk0HkcOjHLFzLitVhc1/iD/snxNT7aCz4R3dbUD2iMWa0lm+nLWDOFsD84N
         jSens+lIpebRccng5lB17RkAHD+tFZk+Uot1PYTsuXq7FIuOYqx60ktHhBeYceQRDc+g
         eA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WJWXIBn2EeJafNFgCrfWBYhVUMwRu8tn6FcwGDWnVA=;
        b=bsXdSdNbgz+OOyE/+9sPvuMm0PCOeVUmrpwkWcgf6OlWnyRbtzIl1XrOta4NnceWMB
         8NqDqzu6JMaz6sccLqNhQ7zkvjy4hUNkA5maH+tEbPf2yxBsj/2wNIIFE1PCF4lxbgJG
         Cjn4iRG/A2AoMJTd3JZdLVX7NNbARZlPsKntklUegZXODAsVttyszSPL3eUhyCBm0NTC
         wnPJbu1GtPm6R/pQjZjxZ+qoWMAZ6OdxETQhXt6zL/Hv8NiZdMnY5HlSk3g/kb6UU/1u
         Jdu2aeQ3M0Q11lhkHj6XQCBoLvgeBMxY0g7mAdnm/YGPTBDYraG7qhRpbg9MNIQqwo+B
         vbcA==
X-Gm-Message-State: ANhLgQ21GRizk1guLH28oBAILNAKmSt8mw5zJyY6fCcHDTdxf7dJFDp0
        T+LW6Jbyf/zROxloJkRFYsI=
X-Google-Smtp-Source: ADFU+vtbM7bFviKqNSqDo3jcri4/ukynuq+Ny5bXej7qJt6EyG+HCzRvd34bWJoUeQU1ImCjs9pnbg==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr13081155pls.7.1585579670147;
        Mon, 30 Mar 2020 07:47:50 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id r4sm9744680pgp.53.2020.03.30.07.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:47:49 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id BA31D202804D55; Mon, 30 Mar 2020 23:47:47 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v4 09/25] um lkl: basic kernel console support
Date:   Mon, 30 Mar 2020 23:45:41 +0900
Message-Id: <0c8b9f122563372acea307b738f833a211ef28c5.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch adds a basic structure of console support in kernel.  Write
operations are deferred to the host print operation.

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

