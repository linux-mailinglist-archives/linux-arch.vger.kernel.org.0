Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED8284993
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFJpx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFJpx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8AC061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so7706013pgm.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=ZlholVl/dFZV1wJbuj+c1Edq1swxwn3sjURNYfImVwLS+jPaY96fWkhSangajbCy0/
         bFEXWpO0ekB+jE1eGmqdlGE38V1U9qagvPtM1JjfmeRuy2Am+p1ANll6avpFZXZroy+1
         UtbQhHIHheTgcT/7Pt6lflqckAAkyQbUfQXyBKExAWazXHCa+XF/630fM9Cpnj1QaqaE
         e8W7Sor2Gc09XP968raF3VnJnQK0b43Ox4HY11uG1QPJ0wP+j2sb3L3l4bO4tLYGedMW
         fWSBFC3P572H43g8VY48TJf2rZsPFXpOAkUVtRD+YcnXwAtxVSH7XbvOYL7x6hpnVixz
         DFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dw71STGvxu+fI7O/Zk3vtwTxDzn/GLjAFDhUcWGe5Xc=;
        b=dGHkuqu+ne5oAnhjKC5/RZi20b8L20v8CTzz14NnE86fkku9WEV9RG3tSo76znL0hm
         fZCUBFCqbd1vdHoE5qFtquqllt4U1nqfA6F52e9c64kQlvPzDy9u3BPzBGvb6DIZ68Yg
         oA4f6JVlH0SEvXHQ5SGl15N4rTovnHxmaSsTXDC876hx3fdcso9fUOEpfHU0EMzq2G21
         2mTxgT94PH0iIuZlS6k9vxhu0XiXbekP5am8Q5qGBZgRl9ABxxOQWAZndmjJO3Se/0AS
         HLH7AssusDjN0TxrfS+r1rp+aBOeSBO0Z3viKUwuFtnzGcTJXRv9MF+Jv63gXp7Oxh+x
         tIfg==
X-Gm-Message-State: AOAM533ilL44TFN9907cbPdtR7Rk7oHwZPzv14NuKhRYHK0VM5ux+tJH
        sqjGC6o8mghOSS3uT93Y6gg=
X-Google-Smtp-Source: ABdhPJwVglZOcLYRka5KE8m8A0q01wp6rqFE8JjGc/rKwzzSz0J0QSIAiCaqsDb6zAfuLdueOpCF7Q==
X-Received: by 2002:a63:2547:: with SMTP id l68mr3233160pgl.241.1601977552525;
        Tue, 06 Oct 2020 02:45:52 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id x5sm2988461pfp.113.2020.10.06.02.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:51 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 3FF9220390F4FA; Tue,  6 Oct 2020 18:45:49 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 13/21] um: nommu: basic console support
Date:   Tue,  6 Oct 2020 18:44:22 +0900
Message-Id: <50557e259c25a5fea82e687665ab611ea54f599f.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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

