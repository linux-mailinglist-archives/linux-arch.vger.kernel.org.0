Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD152125AC
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgGBOJa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOJ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:09:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E25C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:09:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so12721043pgg.10
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=bVz9LuZsGO/IDD5tx0mwO/GA9wDMH0OssxIpGIIVA6NQvdF9JkfPcMrHxBFcn20srG
         yl4JGelPaYz8ej+3dImfWOs87fzpGA6PaWzpPICa0vhAJZ/ubZlHr4h2sQlNkhusEG/Y
         usGyTEEFFk83zaZ4FkYY/ocVsFT4knldB/oMtlC06NmaU4PTGeH0Ntk0VmA7DKJHMS/9
         DOrPkGr5rH6TdQ55nepIIk6MxoAXeDj4i8wbtDdRPeydow7DY7jLX7U7iJtW/gsk8CFG
         1fcIpuCFUosOvdX+FTSLaPz3vwJrWi8udrm97xEUc2EV86fG4WlfCz6oMYyxGKAvls5F
         KL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=MEKGr2szNABNpH6ESF/wOHlWT2gJ9L8k3bRsJ6sDyrrw5inPVXSC4DiX+isOuivePg
         jmpdDRc9w+uXeVLsvqALjAue0JYWknqlm1jGTMwgnuqEokDhA9Sfrp9qD2Hb0fCC/5ui
         NCWo2WxDWElHi1HAPgtu0weg8TrhTBGStCbaG6+t3DalW0QSwsohgYQEBboJB/D+HKwQ
         d2EzSAQt1W+fytIw7iydIOTys1bDW3det+yIEq2YifiIajgd6nwVfgQ4yof7TqJt13D0
         0aNEE1pu4/L8cjNEd9RzD9tlqnnOKs6TVJru7O9LEvpbGoJBZIE7u3JOFqB+miNCE0xA
         B51g==
X-Gm-Message-State: AOAM532io66O90GilTK/jzeiTB1YCmRELON0QHd0BMnQkV3+FL5neWSw
        6b6dM99foxTDb2BJvRP+aL4=
X-Google-Smtp-Source: ABdhPJwxvPuLs5vaKSYTcxvFHtpJ/QsfFEWMOZQe2TS/BVFBxRSZoKUSKJjK95o23Y4MbEituHCO5w==
X-Received: by 2002:a62:86cc:: with SMTP id x195mr21929856pfd.39.1593698967137;
        Thu, 02 Jul 2020 07:09:27 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id k2sm9168410pgm.11.2020.07.02.07.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:09:26 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 42200202D31D41; Thu,  2 Jul 2020 23:09:24 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 13/21] um: nommu: basic console support
Date:   Thu,  2 Jul 2020 23:07:07 +0900
Message-Id: <f7c7b19dcaef76f2c803df022fead27bba89fea0.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit also disables stdio-console of UM if !CONFIG_MMU to avoid
conflicts between multiple consoles.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/Makefile                  |  8 ++++-
 arch/um/nommu/include/uapi/asm/host_ops.h |  3 ++
 arch/um/nommu/um/console.c                | 42 +++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/nommu/um/console.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index ae96c83e312d..694da4aa550d 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,13 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
-obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+ifdef CONFIG_MMU
+obj-y := stdio_console.o
+else
+obj-y :=
+endif
+obj-y += fd.o chan_kern.o chan_user.o line.o
+
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 6ee9489fc47e..133877c857a1 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -15,6 +15,7 @@ struct lkl_jmp_buf {
  *
  * These operations must be provided by a host library or by the application
  * itself.
+ * @print - optional operation that receives console messages
  *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
@@ -63,6 +64,8 @@ struct lkl_jmp_buf {
  *
  */
 struct lkl_host_operations {
+	void (*print)(const char *str, int len);
+
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
 	void (*sem_up)(struct lkl_sem *sem);
diff --git a/arch/um/nommu/um/console.c b/arch/um/nommu/um/console.c
new file mode 100644
index 000000000000..e3194f7bb0dd
--- /dev/null
+++ b/arch/um/nommu/um/console.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str, unsigned len)
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
+int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
+
-- 
2.21.0 (Apple Git-122.2)

