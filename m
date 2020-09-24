Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0478276A4A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgIXHOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:14:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0DC0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l71so1354215pge.4
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=bDRiwy+OBmf9+dYoD0f6rZFMOQ5EIJ4Gj9fz1X8mEeMvEPNyzevLyIaaNPhAWtOHzF
         xE/Res2P+sLHlqQnnfN4rfk5q9lyM7x5UGs/FIKoJdpiEmqlZQgDqb0x7wdLaIE7Tmn1
         F1Kab+CvwFDkXtahnmViPvWRhqZLKglR9+1LjoRP4ZIPMEOoQcYVpp7G+Dc6GFv+yY59
         YiEmXFSS9kp+aLv8U5olm//VkbX3uAMnkgfB1Ea3pbKNyJLkonXJrz2ab4XF+ZOoXwW3
         gfujKiLKlrLr4XV/l9Z7X2uuaYCAl9TfnLNtEvjZ2yJC8rWvGxxZZhrq//CxVkL4etZ9
         sXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=XWy2h8XNqxYERUrgV1EBsw+D6dECDPchp3MPqy15tgyadYqL8LlnWnINtXTPLmQ54t
         WGqVZ4Edr+2uTSFjA3KWI1yUD8OBX9IrztuHFP/tvw03bzBdIrD7TD5SiC8Xy4djog7h
         dylJSsKFulWAc/2bKo35UhK92khSa9cfAjy2xwsJmUcE5nY4Wyg6c2hr4ikZIgrFIqdQ
         m5wCkokfhz9rpK90TNoOAz+jL0veKhSDGYIqshL4iDXlBj7eIJjYiW/TkqCrU+K7whEm
         /wNMSymQ1hM9ATBiH+hlWFe8unlv8FsmQbvtPuI0KR0wi6XUDddE+XDJKehUMsJxvOTU
         MsGw==
X-Gm-Message-State: AOAM532Whr+IRC+JJXF89OZxmmbbE9UAXb+1l2r6W4B6fVOkt+mUCQNW
        xtLXdSR1njuGp3t0QKEz+C0=
X-Google-Smtp-Source: ABdhPJx76/l2E/HyukrgHAeLcdQc2Ypx9BzDY/iDm8vH17cL8MGrc7Kg8/O/vBwyEGStE8W+Emy/Hg==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr2837301pgg.138.1600931654773;
        Thu, 24 Sep 2020 00:14:14 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id v205sm1762846pfc.110.2020.09.24.00.14.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:14:14 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 575762037C203D; Thu, 24 Sep 2020 16:14:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v6 04/21] um: host: implement os_initcalls and os_exitcalls
Date:   Thu, 24 Sep 2020 16:12:44 +0900
Message-Id: <278b23a9e7f1cb0de260f2c6fe9f5919fb51cce9.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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
 tools/um/uml/util.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index ecf2f390fad2..4011b36fee7e 100644
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
+	while (--call >= &__start_os_exitcalls)
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
+	while (--call >= &__start_os_initcalls)
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)

