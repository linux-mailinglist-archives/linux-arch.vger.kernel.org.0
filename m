Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2A212597
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgGBOH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgGBOH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:07:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC9C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:07:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so13539854pgr.2
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xasBvkD9zePzp96sFEIPKb2xSB/v1inHzybPvJ7+o4E=;
        b=vRUt7S1fZ0VIwheb5Q4yZN1ROwCadsjiGfCM9Lv68CssOdOt42H8H7sjOpdK4EISgn
         j5PF+eF0iM8gFDGZrWPw+yDO8NtocbWITLdKN8Y+PmfScaBUyNurYAFTjzJvyPylxjKr
         sAFIictSJZk1RdErxDcou4XQNTKXaxdQ77YSnQOvHqG5fFrCu4idf71zTPidpi8vdTuy
         QgOghZPJy/bVkNZyi1rUD/qVWQAlmbNgcp+h19sBvX3srnuafjb8HuWNoy/Y5QJ1e4Rn
         48ttk3SDXQWf7os76SehtrdjRE9nIM8MFo7tJO+zpNCEjVkdJIndRRwW8BF1jEb71tAJ
         IEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xasBvkD9zePzp96sFEIPKb2xSB/v1inHzybPvJ7+o4E=;
        b=DA6KkoOjreIoDa2MKmom+kSdqsv664HBWR9S85mrvXefl1TEBQMNaFxjWKBtSzvNAv
         taluNPx5zyAtuEZCfVPrreNVJa8myXaMLsWXWqeOIQ9Y8UlBk4XGb17aBrqGD85GZzx5
         cpdppXdpAogkjwRFOmXYaKcRuJzqgS1zeHtCoseM6KD1XRALDZLlBgLhGHJpNpSpdHdc
         MLGqzwjVnlT8MQHGN27jOAikC0JZUgVXZ6KBMYwtYhFXWbEGxjo1a6fHC/wGhjMdFgqP
         rrC+Jxt6JPuBdYaW53KPsm7p0BeZxWvTulZDCo0wb/lZWUyExFtyl8BtTeffnch3rWOP
         /kTg==
X-Gm-Message-State: AOAM533fGDLZ8DpqP4Wh87+cR07gs2zNejd2PotUpbQPYDDsYTfWtb83
        rhdzbgAyy9CyzR8duuXOh9j74M/O60s=
X-Google-Smtp-Source: ABdhPJw+DD5zO6QG2QGUltLmPfJbGZFVADOvyRxgUGx9pDH+tru9xplZcgr161cC391r5UC2nKiXVg==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr21109029pgv.436.1593698877833;
        Thu, 02 Jul 2020 07:07:57 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id az16sm8057493pjb.7.2020.07.02.07.07.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:07:57 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 24764202D31CF2; Thu,  2 Jul 2020 23:07:55 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v5 02/21] um: add os init and exit calls
Date:   Thu,  2 Jul 2020 23:06:56 +0900
Message-Id: <6dfffa1f31b783b0ca9e0ef3d42ef48cfa25d233.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi@cs.pub.ro>

These calls are added in preparation for moving some of the code from
the kernel to the host build.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 arch/um/include/shared/init.h | 14 ++++----------
 arch/um/kernel/reboot.c       |  5 +++++
 arch/um/kernel/um_arch.c      | 11 +++++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index c66de434a983..d09308330ca5 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -109,19 +109,13 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 
 #ifdef __UM_HOST__
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __used \
-	__attribute__((__section__(".initcall" level ".init"))) = fn
-
-/* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
- * make them run first.
- */
-#define __initcall(fn) __define_initcall("1", fn)
+#undef __uml_exit_call
+#define __uml_exit_call		__used __section(os_exitcalls)
+#define __init_call		__used __section(os_initcalls)
 
+#define __initcall(fn) static initcall_t __initcall_##fn __init_call = fn
 #define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define __init_call	__used __section(.initcall.init)
-
 #endif
 
 #endif /* _LINUX_UML_INIT_H */
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e..5420aec411f4 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -35,10 +35,15 @@ static void kill_off_processes(void)
 	read_unlock(&tasklist_lock);
 }
 
+void __weak os_exitcalls(void)
+{
+}
+
 void uml_cleanup(void)
 {
 	kmalloc_ok = 0;
 	do_uml_exitcalls();
+	os_exitcalls();
 	kill_off_processes();
 }
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0f40eccbd759..78d6042fd2e6 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -362,3 +362,14 @@ void __init check_bugs(void)
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
+
+int __weak os_initcalls(void)
+{
+	return 0;
+}
+
+int __init run_os_initcalls(void)
+{
+	return os_initcalls();
+}
+__initcall(run_os_initcalls);
-- 
2.21.0 (Apple Git-122.2)

