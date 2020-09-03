Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF925CA83
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgICUcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgICUcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:32:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7BC061233
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o8so3991674ybg.16
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uaTfkB4ak1aJZWY50HSjxViiXLY/kut+uNnKrezpcK8=;
        b=mF0WB4Q1ilKN/2ZqpXw5x4/HmJUMwCWGi2P+cTr/YpR+8mKfhxtAQ98O8PqGynIC8O
         SEOr8J0gsFlwzelGzRV17yurypMIXiNJ55R0Ym5qIIwq+cQiNZ/t4akGHBiu14GZxifB
         mGzV4o2ZdqIe4cXD+oWt+lNNks1pqY9XmZ8qYRr8AF+yz2wMbwhUJW9NadF6++sNk6qg
         k6gt9RssqRm8Ro+SLyHZewy2mRecQrib+ApgUWgcAWDaDTixRz6n/GojNuc8DZQ0zJwb
         gqJSHHf8ovZr9XJCJdpQFTPz3QtwXORXLXWqFrqr3VgOKkRiidqDj1RYJuMC+BGncMrH
         crQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uaTfkB4ak1aJZWY50HSjxViiXLY/kut+uNnKrezpcK8=;
        b=rvp9+PFA5/2iqUr/qUKEr6Yo8PZadD6W+OJ9tgKs1/lGRAGvABEag3YfIVQdSJgc+B
         hcBqGIdEr7mNw5Z8We3W37q9zLTnPtu5ciVL4mG+IoBfk+kq1tajXECA97QCwLepTSBl
         CLf07RQGAne2Za3phyldCfsKMrxXq991cs3Q6FJAKCBchetms4VuIlm4CjKz39Qnp162
         PCs6s1AN5cKaiB4+rl3KDZ/oepFHUlESwPbMDXNGdFAXeH093zUHzPZlWXbnuTdILmuE
         I++e8vsZ8fDru1HLrrFP4ZT5Uge1eJm2mNY4djqz1IN2cKyf4gHGd6o5UbMYPZzU3RPU
         z/WA==
X-Gm-Message-State: AOAM533APRia+iL6ZJR2XctsuKFekJCH4VRABUSItK3jQ5yfLH2Tnc84
        xfBsaZbJAWyD2pXSJ4xQZo6LqTVeYe8sCkDxNN8=
X-Google-Smtp-Source: ABdhPJxkMmB21+S7VY0Jt9zVeucemxfhi5zBK41/ZcXFOz1RBFo/uHKHBl3+bP1fnXBaBCAh+O4Eoo9Dz40YO9G7Tzc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:cdca:: with SMTP id
 d193mr5380428ybf.402.1599165087915; Thu, 03 Sep 2020 13:31:27 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:41 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 16/28] init: lto: fix PREL32 relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/init.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index af638cd6dd52..cea63f7e7705 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -209,26 +209,49 @@ extern bool initcall_debug;
  */
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
+
+/*
+ * With LTO, the compiler can rename static functions to avoid
+ * global naming collisions. We use a global stub function for
+ * initcalls to create a stable symbol name whose address can be
+ * taken in inline assembly when PREL32 relocations are used.
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
+
+#define __define_initcall_stub(__stub, fn)			\
+	int __init __stub(void);				\
+	int __init __stub(void)					\
+	{ 							\
+		return fn();					\
+	}							\
+	__ADDRESSABLE(__stub)
 #else
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init"
+
+#define __initcall_stub(fn, __iid, id)	fn
+
+#define __define_initcall_stub(__stub, fn)			\
+	__ADDRESSABLE(fn)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ____define_initcall(fn, __name, __sec)			\
-	__ADDRESSABLE(fn)					\
+#define ____define_initcall(fn, __stub, __name, __sec)		\
+	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
-	    ".long	" #fn " - .			\n"	\
+	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");
 #else
-#define ____define_initcall(fn, __name, __sec)			\
+#define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
 #define __unique_initcall(fn, id, __sec, __iid)			\
 	____define_initcall(fn,					\
+		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-- 
2.28.0.402.g5ffc5be6b7-goog

