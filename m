Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60552270696
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgIRUQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIRUPa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5AC0613D7
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e190so6656458ybf.18
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XxAfB/P/jhgYhoVgUFO0krm50APtT+WWyqbk+4ioXTk=;
        b=DmFIi1OVxsFoFg92oFWH2VPRTDu4wE9Rmg6s0bvmp2TuRAbHoKv6/fPJl1fuBdrjn7
         VWzTK0IQDIyNMi23xcASGWrTPyHk0S7e0w5yoc9SZ/pQdToneOnD9OdIiO2v+KW9gj7y
         9zlTW9p+FprZHdCq5rpUHZD/0n8xUda24onsLXZ66jqtU8LkEkm1FqYFsbOXQY9gVmIy
         ib61pYrKwyraXm+h5krhXzdEdTlzkFDCT45b4X7mDBl5iBONcOD1ksa0s/BExbykYGIB
         wn/5Ms/kn3W2LpKihjogJj5qO+B0a2gDh6bG4SxQfn0sDbgdsmBBEBBNuSsdj96B5Er/
         uLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XxAfB/P/jhgYhoVgUFO0krm50APtT+WWyqbk+4ioXTk=;
        b=hrHiFbTFKl3T347qQgYPuLFXKTAi3T/DgvEzA5iFgOdLgR6uodOlp9VQCKkeuAhxrZ
         ximCmZcoY1pgK45g6AY3vVbwyeSCl65fT0MlL4ulfIRDIv1kRFT9QA15UvG6hanj4fCk
         CBH0LvOwK8W+Bv55E77EuJdRuBRkScrSHfxvaE2eB06K1TTG5AEhiK8oTdjyU37RV41S
         kZVtutcEYyrqcx1rzRSRS0bkHdFGeHItfwhcU0Oc5wizd08JmZx+ih+8dIfbjK9Gce/f
         nBq4FkW+zZ7uHGI9alGVPY9XZGE2T09v5xv+VRiJ2gYDHwYfQxQhH8uJJ/oTEpyGuz5p
         W2wg==
X-Gm-Message-State: AOAM532M0bnqp5J7+MbnJ9g2yTzZJjOf3MSYw1sp9LZXl2IzeDr1bXUh
        7TxUOjIexjDHQ7sorMT9LwO2mzD5rXAcMSAWQW0=
X-Google-Smtp-Source: ABdhPJy2KjHLDlLlwF3FZGYG4YjeDAk7DNS4RO40Qo5O+7UwvN2wgXBj6NsmIvpwMLwrVraEYVu5qDWHVwe1uVR3arc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:e009:: with SMTP id
 x9mr6392448ybg.373.1600460121392; Fri, 18 Sep 2020 13:15:21 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:24 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 18/30] init: lto: fix PREL32 relocations
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
2.28.0.681.g6f77f65b4e-goog

