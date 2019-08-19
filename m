Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865A7951C3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfHSXlX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43388 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfHSXlW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so2119194pfn.10
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndCaMtJVRFCFpuEAuYUAm3sbqaCuhfpOV0yimySsF9c=;
        b=ayztbxcgRt6M2/mj99/k+Bod1keHWx323G5KA79M3xmiIvq6hUALeUleEP4NMdsOkv
         EhpbaiK3AUQptjg71XNwz02I5jz4cPaJEABnQbCMw/6qQ607Uin/Fd/6FWFm8jFR9eyl
         sNMC6QNWNzjozycodonQUWxbZmx5M/kNGJlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndCaMtJVRFCFpuEAuYUAm3sbqaCuhfpOV0yimySsF9c=;
        b=agDSjmwRWKwb9vgW/CokmMXy8Z2gLV2ZDTTA0gN7uksRiMkLF0HxP0o5zcGzsV/CxE
         /IOSiuprUseUuBKvv9NV7akvZdwmgxBIdZw8TUq4Xn4NEhto4uJ4z16Av0FQ+2Qfk26/
         s/cpnKBy9cvBx8JEJo1OXsoO2Rt2WzhQHqEcePwXuWnCw98XuFqyU6OCpgaXIIh0E7Hg
         J0oYneCALJJWMFTDxIkvSP4BPvGscZlfBVUOQfmAMSYrmRXgbwQucSAC/tBL4h60b5yp
         MtVcn3AqUtSjTw+nCDj4nCU45kX7B6Y5+d9r1yVDhyajR7GVxobyNbVUlZ3dOsAdV9db
         G7OA==
X-Gm-Message-State: APjAAAUKp1GKfCNiTMckHYTZo35MLMHxoovER1vTKMxxDqVs4l4jztMC
        lW3gSSoVAEXEQtzWjxRljzkqNL3w544=
X-Google-Smtp-Source: APXvYqyPjSnicM/lgIC6fOw9Ktv3xAyr8RBLemy9cm+wQjoj4kzaWdHMetN644yt5LoBEcRId7+IEw==
X-Received: by 2002:a17:90a:de02:: with SMTP id m2mr23331561pjv.18.1566258081698;
        Mon, 19 Aug 2019 16:41:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c70sm23442423pfb.163.2019.08.19.16.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Drew Davenport <ddavenport@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] bug: Consolidate __WARN_FLAGS usage
Date:   Mon, 19 Aug 2019 16:41:10 -0700
Message-Id: <20190819234111.9019-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of having separate tests for __WARN_FLAGS, merge the two #ifdef
blocks and replace the synonym WANT_WARN_ON_SLOWPATH macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 18 +++++++-----------
 kernel/panic.c            |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6ea8d258cb96..588dd59a5b72 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -61,16 +61,6 @@ struct bug_entry {
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
-#ifdef __WARN_FLAGS
-#define WARN_ON_ONCE(condition) ({				\
-	int __ret_warn_on = !!(condition);			\
-	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS(BUGFLAG_ONCE |			\
-			     BUGFLAG_TAINT(TAINT_WARN));	\
-	unlikely(__ret_warn_on);				\
-})
-#endif
-
 /*
  * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
  * significant kernel issues that need prompt attention if they should ever
@@ -91,7 +81,6 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-#define WANT_WARN_ON_SLOWPATH
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
@@ -105,6 +94,13 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
 	} while (0)
+#define WARN_ON_ONCE(condition) ({				\
+	int __ret_warn_on = !!(condition);			\
+	if (unlikely(__ret_warn_on))				\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
+	unlikely(__ret_warn_on);				\
+})
 #endif
 
 /* used internally by panic.c */
diff --git a/kernel/panic.c b/kernel/panic.c
index dc2243429903..233219b3fb34 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -588,7 +588,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	add_taint(taint, LOCKDEP_STILL_OK);
 }
 
-#ifdef WANT_WARN_ON_SLOWPATH
+#ifndef __WARN_FLAGS
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
-- 
2.17.1

