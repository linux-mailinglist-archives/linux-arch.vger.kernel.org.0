Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0981C284986
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFJop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:44:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EA2C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:44:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h4so819219pjk.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeduLP4IxG8QLm5XBKojGInFwj9Qco6vm9ib8DpEzok=;
        b=NOAgb2EzKIDQIfoNs0ZSPUHp2qbsYVXTyo8CNJ7XG+GZBEraYoaX6JU8PXJHtUJE2B
         bfNFQ3w/Esw6I7ru7yQh9LylS4XKFQWW7gJa0MyRjk/V3q9110LX9djxOkvbqnma+Imn
         d+v04wDXnHQsy6qaP891dJOUnMkFwx48bEQH+S/2zszqdvxxg/nBWw1vEmeNHgwjqL30
         DwqNyVStcnM/pFT90yiCKMNbjWQmLgDsIMuSEMjSmqCzYAc+31f9xg4EA2Lbn2J8JGMp
         PLt4hP8JHBpOyR2+yRFGLMpKZEbuzO7PgtR4P0xX0asPpEI/fb5Ob2wv/uQpZOw/P2jU
         PxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeduLP4IxG8QLm5XBKojGInFwj9Qco6vm9ib8DpEzok=;
        b=P7ExBGCa0Ho9UKtga7Iw1eko6OC6Od7fxyXLWUgI/6zxkwhfhb8GlDGTM5owiMXIra
         GKx5BrkukIc3DUxmN06E4g+dtqclLVJhB+/07QtAwIyLtxdZk2lPTOUO09R9cKyW/MSD
         erK05iL+ZaZR8MVkKROobyveuzMKtPvprxKVqqkClaAOvpBgCN37GlzlsQaRGuvsMqNw
         REGpA31T3v3ZkQOoCLiqTjqSjTdJe0P6kOinFfYIFdhDKFPARoH1oII6D9td0cAYWLh9
         ktJJ75Q2A/ljSedjX01lfsHmDC6XK1u/eVbAGrwsKaD/d86YAxLuArrgxLfEZTa+F2cP
         DIfw==
X-Gm-Message-State: AOAM531zr+WWRzlkSvHdvrjH9iesVjb3xxsKwfhMkDoV4PUPyZYBP7yD
        V3hg5IO/2mCNdqVTa+KbNe9Oq3/a7F8cpA==
X-Google-Smtp-Source: ABdhPJwfK7KyY/BU6mloggRGk7amkXG2i9TCxTK9ZytVcgmty25d7O1Hc7diSs9xxXUUhzMRXAzkFw==
X-Received: by 2002:a17:90a:420b:: with SMTP id o11mr3492689pjg.142.1601977484877;
        Tue, 06 Oct 2020 02:44:44 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id w187sm356418pfb.93.2020.10.06.02.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:44:44 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 4091420390F417; Tue,  6 Oct 2020 18:44:42 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v7 02/21] um: add os init and exit calls
Date:   Tue,  6 Oct 2020 18:44:11 +0900
Message-Id: <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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

