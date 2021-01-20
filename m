Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3A2FC7EC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 03:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbhATC3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 21:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbhATC3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC21C061793
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kx7so1197478pjb.2
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiYNYYWvR1DJ04Q8n+7+P7GfYD0bpMl9iyFLMdV2/U8=;
        b=MwW23UXhK95+qUbX9dKv+ny1LuKuI4qFPwTURdiuT62X9trzLAgh/4LmQ0r5pdmUPG
         RtukuKiTkAuwM5pSdQqZnioy2UpKgzhmv9d+mCM4Q8pcpvcuBjI8jDCsQxy87/QLYAW/
         ipp858VpPl6KcLcTiPFjqJtK1pCsmFA+2q0bCP84ENrFhQ5Qw7jU+Saw9HESJSPPaKmL
         1ERPNCtLM5sXlq6z9CPBMUPliU4tkCPhc2n3BoHy1HUGnAGk/ywVWJc1SVL+hobIL9y5
         MtqQqNpZPZtSPu+muE6YezsjaaILjbA5eNME2yha6Vx2Dn1WRce4hPgdyppEw9gAuhpn
         izeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiYNYYWvR1DJ04Q8n+7+P7GfYD0bpMl9iyFLMdV2/U8=;
        b=RjWMeEgVsXXQjIqMIgPc7U6Secu3KvtTK20Fjvobat9BqUHeuS4ZvXkb5xOOWZBNE3
         Wzh2jJgAFn+5YC2MTC6hzuFFNvO3lMQhl4/zJsUi4nb8pBWy59BXY8XZ5nXJqZu8vm8d
         Vo8Fk0npoR2dkUbWEkqXQsBZXFAtXcikPOUWweuAPPBuDzXSWjASQqkRkp7gQjdRjcdw
         f0Imo9e20qI6JoUAQ1ovHnuWF8+YJ0SKM8Rfn2TM+fAwIDCunBKSCDs+d6DdvEbaaqcb
         3QBTbMbGL4oGOIuF9qzgrxBlqiOcFZ8GmHeF5N461yRyIe1AWV2Y/9opaFZDnou59cjk
         M/zQ==
X-Gm-Message-State: AOAM5334F70YzQL8Powib/XYa5Ku2TZm7idfXTA8UYnrQ0cLu3WTsuNG
        uDMJ9c0s8SYaG+YIWPYYcrk=
X-Google-Smtp-Source: ABdhPJxE8H83ThS9Wn2cH3rWKo/mN8mYdvteY84tmYodgeeMN+KLSe78SZ3Ijxln0HklRRfdbKYzRA==
X-Received: by 2002:a17:90a:3846:: with SMTP id l6mr2922345pjf.21.1611109694121;
        Tue, 19 Jan 2021 18:28:14 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id y67sm382433pfb.211.2021.01.19.18.28.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:13 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 6310920442D2F5; Wed, 20 Jan 2021 11:28:10 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v8 04/20] um: implement os_initcalls and os_exitcalls
Date:   Wed, 20 Jan 2021 11:27:09 +0900
Message-Id: <7a16b13b232b2be9daf424dcd4d14ec8c43a5225.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi@cs.pub.ro>

This patch implements the init and exit calls for host code. It uses
the automatic __start_<section> and __stop_<section> variables that
are defined by gcc / ld when using custom sections.

Note that this patch should be merged with "um: move arch/um/os-Linux
dir to tools/um" but for now it is separate to make the review easier.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 arch/um/include/shared/init.h | 14 ++++----------
 arch/um/kernel/reboot.c       |  5 +++++
 arch/um/kernel/um_arch.c      | 11 +++++++++++
 tools/um/uml/util.c           | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index fa2d3138d497..0d6de61c0f37 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -114,19 +114,13 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 
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
 
-#define __init_call	__used __section(".initcall.init")
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
index 31d356b1ffd8..dfc6194b5ac7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -444,3 +444,14 @@ static int init_pm_wake_signal(void)
 
 late_initcall(init_pm_wake_signal);
 #endif
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
+early_initcall(run_os_initcalls);
diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index 07327425d06e..8a3382c47f98 100644
--- a/tools/um/uml/util.c
+++ b/tools/um/uml/util.c
@@ -186,3 +186,29 @@ void os_warn(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+extern void (*__start_os_exitcalls)(void);
+extern void (*__stop_os_exitcalls)(void);
+
+void os_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__stop_os_exitcalls;
+	while (--call >= &__start_os_exitcalls && (*call))
+		(*call)();
+}
+
+extern int (*__start_os_initcalls)(void);
+extern int (*__stop_os_initcalls)(void);
+
+int os_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__stop_os_initcalls;
+	while (--call >= &__start_os_initcalls && (*call))
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)

