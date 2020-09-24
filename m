Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBD276A40
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgIXHNw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:13:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD62C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:13:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1131049pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeduLP4IxG8QLm5XBKojGInFwj9Qco6vm9ib8DpEzok=;
        b=e9hMfqV+8Qyp+mFEsnlBzQhOkdw4jChVTgzW2atFzOcF6eQ2Ofe+ye8hUrWWTsOjbQ
         KkdbtHtBxKy1AJRynUw4HSB0vXLCxFsa14oVWiRAm5JrhM3q0VdvWCLDqpl+yAIknf66
         iZUAiqGudwylI/vJ76rkJXpQYUawD+CYpv2uwpS1p1VxTrS2qAaeKS/rMVxpm0XdeyJs
         xizwF8wbY5eO7ItoYXfu0UsFcPWjtleNbAdGhB70x0F/6M7pCEoIXIJtSisOBVbVNo2P
         ZbIl0bNdqIWGtBwCmC3JEfIlHJrgxbiMzleiQwicYy8uiE7YPq5LoNK/0jPejrVzOn0g
         SNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeduLP4IxG8QLm5XBKojGInFwj9Qco6vm9ib8DpEzok=;
        b=GqzP29cvy3drwjf/kHTdVTuEqF0lTXJcqk7CkcwzfaHk1c0k5oLwkgOGOLpWYe8pH8
         qRzTYvSePzxrvRJzt9rgC/QczahSzee7lVaLuynaqNtY9byuhUmJjZtOqS3OTbPPLBr4
         cX/FJPJBUML3oHvO44m1FSlrIKbP1qEPEWWCIDEaIWX+/4T63RrtJwrpji/RBAIZgrhP
         zySbZOsp4Eyh7q7yarZMyLva+VYl6R3bhAzjWpGoIG5fSIXxXz073+v43Tbho0mbUKdS
         QOOltObpkB24YlAZg7unDODmLs7fx1BOO1ssnnAfrAbws+iGNjP440oEBvKPxFjwlNGZ
         j4zA==
X-Gm-Message-State: AOAM531Ycy9gJzluLlocG+k540t0DgJHceNpl0PurEzifJl56FD0ps6d
        9w9kqVUY6jcmJsrGmswqzlA=
X-Google-Smtp-Source: ABdhPJy6l/2edLKPoLJJy/XOmFKZ6m7ZQp1W8mAAVtYqAunDxDl8EBLdy0PozZJ9/JBpa04m6QK7UA==
X-Received: by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with SMTP id l2-20020a170902ec02b02900d1fc2bfe95mr3408136pld.79.1600931631684;
        Thu, 24 Sep 2020 00:13:51 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id y79sm1846800pfb.45.2020.09.24.00.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:13:51 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5B88E2037C202F; Thu, 24 Sep 2020 16:13:49 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v6 02/21] um: add os init and exit calls
Date:   Thu, 24 Sep 2020 16:12:42 +0900
Message-Id: <0479e4453fbc20abc3a9a7fbd892bb258440712a.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 00141e70de56..e2cb76c03b25 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -377,3 +377,14 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 void text_poke_sync(void)
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
+early_initcall(run_os_initcalls);
-- 
2.21.0 (Apple Git-122.2)

