Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB25276A61
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgIXHPc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:15:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2087DC0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1189841pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=Zmy1SS6kl0jxxONEvBC4wfmfIJ1KuHy2r4cVTdhd5TSpg0pk/4s08WSU0NLFyQNpQt
         y2lIxp9PemHVppTSCraE3H6U1KBIvC01tzr3p6gvSFfFt2tC0veYPgb31cou+32kYAfY
         3BFeWKUb4qhfeVPliICJFB5BrNVWCSKeiXIeG7RJnUYwfGJr3kvEajYCNuYuf/hbpTqm
         A9SZEuxnNoZUUHeZB18ecNm3ESGb8KUSy7f4N0/t17jMzJcxf+DQpsgdU+LKuq5R7EHx
         JTmHt+kPxqUF0WqrzwkrcNr3GvZOgHg7bGmLSMr3aQPlL7B6mBPg3xgrbdOFOXdxfPPJ
         KC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=FwbEqOIDHJYc4j30bPCw3A19V7gRFD/IetnR69AQCzBgxzZk0LbyBUy3m2IMFk8B2S
         5dkL9+k5HzAKXB3spDe33AaeNSpwgJyxq97z3u3iCItxViEQ7jl2qy2sNb2P1oXcQrpC
         tD/pF2CuPMJV8Ys9zZjJAJVUxUE8L77naUSohvQWyd3SZgQRZyf22aHawNt6Z9ZP3lH/
         k+GqExtqGcNzz7oZqkcEYDUugx5Jc2j8hJRt6rUVcWUWgwjm6B4Oqbfz+UvxQDmVCHTF
         Ly7sECLvphIU3hQUEaisGG5waxEylIencf/jNgPvYHC+CE6iCmaVrY+d/Pz9TmBSCDMF
         DYsA==
X-Gm-Message-State: AOAM533G1xGvGinnYKqUlgcM/rOMvrHZvDVdaSf6RKcHYrOfWE/ZQ8gm
        c0NhgYr5BS4OSnispiTDFgpsOQXe5ZE86g==
X-Google-Smtp-Source: ABdhPJyyI9b4RjXtue10Pcn9wOYh23pY5YnZqTM4dKsIAg9ZR7hWxwRFU9TNytr+vT5qmL/RfOGtog==
X-Received: by 2002:a17:90a:e44b:: with SMTP id jp11mr2724334pjb.96.1600931731555;
        Thu, 24 Sep 2020 00:15:31 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 124sm1722152pfd.132.2020.09.24.00.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:15:30 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 8B05D2037C20AD; Thu, 24 Sep 2020 16:15:28 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 13/21] um: nommu: basic console support
Date:   Thu, 24 Sep 2020 16:12:53 +0900
Message-Id: <379481a81c96e9a073df02dc49f976dc6e346cc4.1600922529.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

