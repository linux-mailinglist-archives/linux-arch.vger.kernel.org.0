Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B539C951BF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfHSXlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41164 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfHSXlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so1718576pls.8
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KrfPYPW7hHpyGdKfhM0Fbj+aqAYec03XNpT7CUlwk48=;
        b=QnrNmbkOAfu8bxBlGCuJMiF5SR6TGcun3cWqx/xhCswSSSrYf3m83zf7ILnxVROdPw
         XMcb4j6OAOjtQ9zgwEeaIgrhH8x1wiEGw1ASR2J6zMoeBqqoTljvEV8/PiLUhD0Eu/nh
         lNkfB0rbkhO91GROHRzAkXN7hjKYzdIGYZ3MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KrfPYPW7hHpyGdKfhM0Fbj+aqAYec03XNpT7CUlwk48=;
        b=TvHDCpqnsUibCOCRGkeq81A/oywe2SNQ3lMMADo88l1C24UTFbhyiUOHjlqXoVL5os
         zkYWIhUtvnxJuLZbIglUcPrRFoAXa7gtzx3Vdrfejg/vWf9gSmPm9bbkd9f9WOzT7yF7
         3fZ7sf6eMBNEnYyNFDVJpYCCTuGmIH+uDWS34M3NlA/jpxuqdl8HIq+kYzun76ZeA7Cy
         odkFevgLnEh96p/UoKJbxs5VumrU6aAgTKSHpW7Jm0SKmmIvQGAaLMRTa0ULWRd+GuSo
         RaL9KM96siM4/fXfreSIe1BiFCRL+C+Pa43Wmr4lf9YE2FeNlYnx4OHIgau6N+OBhYIk
         iNww==
X-Gm-Message-State: APjAAAWynz13CaXaQF0Gvi7vSvI4xqkWitmtVdynahSYT1R4tU+v5Owk
        x1jvQH/HlnpRdLRCaRWuvZJPZA==
X-Google-Smtp-Source: APXvYqygsG7Fmp4twlPCBffxDxd1vDdewld+4/vgBMugHA0mY4ldJc3AQlhlyLfHr+Y64lj9tD0b4Q==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr25019254pld.101.1566258079631;
        Mon, 19 Aug 2019 16:41:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3sm13378834pjo.3.2019.08.19.16.41.16
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
Subject: [PATCH 3/7] bug: Consolidate warn_slowpath_fmt() usage
Date:   Mon, 19 Aug 2019 16:41:07 -0700
Message-Id: <20190819234111.9019-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of having a separate helper for no printk output, just
consolidate the logic into warn_slowpath_fmt().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h |  3 +--
 kernel/panic.c            | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index e9166a24b336..f76efbcbe3b5 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -93,9 +93,8 @@ struct bug_entry {
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
-extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
-#define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
+#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d8b7577c82c..51efdeb2558e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -597,19 +597,19 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	if (!fmt) {
+		pr_warn(CUT_HERE);
+		__warn(file, line, __builtin_return_address(0), taint,
+		       NULL, NULL);
+		return;
+	}
+
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
-
-void warn_slowpath_null(const char *file, int line)
-{
-	pr_warn(CUT_HERE);
-	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
-}
-EXPORT_SYMBOL(warn_slowpath_null);
 #else
 void __warn_printk(const char *fmt, ...)
 {
-- 
2.17.1

