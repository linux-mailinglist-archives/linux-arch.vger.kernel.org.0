Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA227DAD5
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgI2Vr4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgI2VrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:47:22 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA6C0613D6
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m13so4863568pfk.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/vP7q5BBB0uTfRm2AgwdilGSRfsWzFPQ2WkTiyoFr6c=;
        b=b55hwPidpBtwXSYzPL7nG9/Vda7JuMVr/EGJixbfG0vXQwUBtPjkDoj3MJOTqZMsWM
         vzguUIrKQvSlcJMS9LcTLx25efyz9HzS/XNyEl+Vmt3JZFYWS9Xi9CW480UD18Iv8V/8
         Zv0q3PdFWw+MxCu1kPSRKo5b5kauZeRMwrGkfiXKdlBUKbyUb+Mx09RiNdFeO5g1b1k/
         MGs4GivcBr1kLWAINFKbVMCXqvyatQdyLKZ3K2d+FSPXYNUWpizBFCZ7ExOm+k6gsGZr
         9pRIvsrPB/pkdVgUtISLhxoJY5If1dpdNi3Vrr64TIoPSMdOxtuHEgcrwzGEARSD2d7Y
         rM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/vP7q5BBB0uTfRm2AgwdilGSRfsWzFPQ2WkTiyoFr6c=;
        b=Y7MoCXrPMSw29zJJIO6fkWEXQova5vmJIXU6smP6mQYUBJ6Fg3PmLHRWYNoSQPOBvF
         DM07u5k3SgysSiGvk8jK+j77ECmXRlt/Aj7TSaCUSOnpaavxviinPOt+lNi4mP5cbXtB
         6QPxVPxiUD1EVu479gGqTwu7wWTVx1NvwNNDk4a+twFgsVntk8d+MbIkq3xSeesSxkxE
         x3g3pAVRYgCmEUuU+MmZUsmP9VEq0XsDmSXL7n596QXHyzPqaPMAiRm50Zn49+19FrBe
         T1yXREUc2zxnts4Hwv8lnp/f+eYKY9Z9IyXXcjYn5ddP7G2Bd8yaumZgWZ2ed5G+5fAs
         UI7A==
X-Gm-Message-State: AOAM533yzHUzG4Z5siSlSRHDGEKq5s2o9klhCcgumD4SugYBXP98lchn
        D67qNE4w5bn5XGzqygF+OAF4llsRCkC/+jhu+F8=
X-Google-Smtp-Source: ABdhPJzwunn8/64a+JvNFjvDzCLI2jH4jHUm6kjJgtH3L7MwJCKNh04+JiRlVd1IwEJ79vkmzQAo7H0Oi+ZByvS+NaY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:e813:: with SMTP id
 s19mr4805529pgh.33.1601416033950; Tue, 29 Sep 2020 14:47:13 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:20 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 18/29] init: lto: fix PREL32 relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.28.0.709.gb0816b6eb0-goog

