Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE81951C1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfHSXlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfHSXlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so2127783pfa.4
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0GL8shUR1c/tLxSyNMSfWKHUqzxIvLdp8FEXDirf90=;
        b=lpl80kn5MumxewjiBHdQEneXhPHNAtCGPdNSfPSfDzAcG81pLpoUZ/xv++x4vLw5ed
         4Zx3rMcy9ZpdA32I6LEayRbDq+L765PZ1qWpEDPIH0Bz79nLZgP9lx81HSXv2m4ylXp9
         uqn8mHLeIjqNErJntLFgVTK570Qkin2XA/Ww8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0GL8shUR1c/tLxSyNMSfWKHUqzxIvLdp8FEXDirf90=;
        b=DnjZr0yIeGxdr7sKmqxLV4radXpLcgifQ2/GLjzEKPndcCqGV+bcKCkPY26QQDaeDF
         LejZXZOeJmyZBhhJKEyjsSxpBzAR5ZwBvMXyKiS/S40tcXlLsP1TE7H/lHYjo4gIH/xO
         kh6n9cx7OKMb89ar3hUPy6KDW9Sxbv4XQnanu373o+rbU5QPI5NqeKM4edkYPFkDAn4E
         tXs1v2oGFi/T7GzBUxz5OOQnGs6d40WhvorHRXVxJ9eXFnOM+jT9NLPqpsC5u6GLdDit
         jyhVl0SQ5x5949NDGCiUm6wk6xljcHBcRfrSoyjiDpWsiJYibmxf3Ds1rg88pADTMVII
         Bx6w==
X-Gm-Message-State: APjAAAWbUkMvMcbcaDy6X/kcHHsSol7OQpmOxGmknk5IUzm8ABV9dMaP
        UjCIauwl95zX/y+9d47ofmJDxw==
X-Google-Smtp-Source: APXvYqyxwSm5k05PpNmk5gP1R/zoQCRs6O+6N7K/sPfzxjumkEzFP9b+kV9SLvzMfEMd4BprOb+w3g==
X-Received: by 2002:a65:6815:: with SMTP id l21mr22579318pgt.146.1566258079080;
        Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm25322617pgo.46.2019.08.19.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:16 -0700 (PDT)
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
Subject: [PATCH 1/7] bug: Refactor away warn_slowpath_fmt_taint()
Date:   Mon, 19 Aug 2019 16:41:05 -0700
Message-Id: <20190819234111.9019-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There's no reason to have specialized helpers for passing the warn
taint down to __warn(). Consolidate and refactor helper macros, removing
__WARN_printf() and warn_slowpath_fmt_taint().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 13 ++++---------
 kernel/panic.c            | 18 +++---------------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index aa6c093d9ce9..ce466432ac3e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -90,24 +90,19 @@ struct bug_entry {
  * Use the versions with printk format strings to provide better diagnostics.
  */
 #ifndef __WARN_TAINT
-extern __printf(3, 4)
-void warn_slowpath_fmt(const char *file, const int line,
-		       const char *fmt, ...);
 extern __printf(4, 5)
-void warn_slowpath_fmt_taint(const char *file, const int line, unsigned taint,
-			     const char *fmt, ...);
+void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
+		       const char *fmt, ...);
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
-#define __WARN_printf(arg...)	warn_slowpath_fmt(__FILE__, __LINE__, arg)
 #define __WARN_printf_taint(taint, arg...)				\
-	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
+	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN() do { \
 	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
 } while (0)
-#define __WARN_printf(arg...)	__WARN_printf_taint(TAINT_WARN, arg)
 #define __WARN_printf_taint(taint, arg...)				\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif
@@ -132,7 +127,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf(format);					\
+		__WARN_printf_taint(TAINT_WARN, format);		\
 	unlikely(__ret_warn_on);					\
 })
 #endif
diff --git a/kernel/panic.c b/kernel/panic.c
index 057540b6eee9..4d8b7577c82c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -592,20 +592,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 }
 
 #ifdef WANT_WARN_ON_SLOWPATH
-void warn_slowpath_fmt(const char *file, int line, const char *fmt, ...)
-{
-	struct warn_args args;
-
-	args.fmt = fmt;
-	va_start(args.args, fmt);
-	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL,
-	       &args);
-	va_end(args.args);
-}
-EXPORT_SYMBOL(warn_slowpath_fmt);
-
-void warn_slowpath_fmt_taint(const char *file, int line,
-			     unsigned taint, const char *fmt, ...)
+void warn_slowpath_fmt(const char *file, int line, unsigned taint,
+		       const char *fmt, ...)
 {
 	struct warn_args args;
 
@@ -614,7 +602,7 @@ void warn_slowpath_fmt_taint(const char *file, int line,
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
 }
-EXPORT_SYMBOL(warn_slowpath_fmt_taint);
+EXPORT_SYMBOL(warn_slowpath_fmt);
 
 void warn_slowpath_null(const char *file, int line)
 {
-- 
2.17.1

