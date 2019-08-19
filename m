Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030EC951BC
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfHSXlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45160 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfHSXlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so2118028pfq.12
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvtOVzdzU3wFN+jfOqC7eykX14KYjG+c7qizRM/FE08=;
        b=boYXQgUkeWXfwExOs7D3W8lXej3rIi85Yhrp20e41WcqqhulPHYLmlA1xiL3ZUZOSM
         opS2VpxxJHEjwDaZwnaq5iUWNYHEGjCdOB/cshRQ3ZZOdKuMGHJuy0AD5nRC47txa08N
         bQXjgKE01+Z/6haEQ9wRPGh8AFtVS6oUEoAcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvtOVzdzU3wFN+jfOqC7eykX14KYjG+c7qizRM/FE08=;
        b=NCkyRE0JvUjXkzU3xQ6KegnxJPOEYbYLdp5nPjhqRrXwNdaclPoTLjlAehVHLpYQ3+
         Emb57do+eS2LBSKinMB5OHZKd59cGA20OSx3BIda+/AGU+8CLmrJHwJG//VjNlV7BheI
         W6XvNJ68g4Mef/4rSb/BTL8NRVaqKbfkwofLwxKGU20TNjO/rBEvXN5ERLEtgtjhVC4C
         xkPQxi+iZeRhGgMut7cI8yxLqcBEVH3rRl7qW0682CnkOkotI2GnhnMUVCkSWVZNBbal
         55jI+BV+iRIgAMHpNN406TvZ/wW+Shtlvyy4KLLF04/MVzTpI7Ihtg9DWRdWSAKVarFE
         K3MQ==
X-Gm-Message-State: APjAAAUFY3mbSYaLkXNFxurJiqzlwYgd5cV3JR28Zsoy/4KAH8v6PuTm
        irTgxUpnzwWmrAJQTwKRES8DiQ==
X-Google-Smtp-Source: APXvYqzZ0bFDie1zp2Bmz5Lz7TS6xiAcc+pOh8XgfkghW2Jb3yJUuG+ovrvL3KiOjQHKVsan+tNDbg==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr22753827pjb.35.1566258077690;
        Mon, 19 Aug 2019 16:41:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm32073025pfq.85.2019.08.19.16.41.16
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
Subject: [PATCH 2/7] bug: Rename __WARN_printf_taint() to __WARN_printf()
Date:   Mon, 19 Aug 2019 16:41:06 -0700
Message-Id: <20190819234111.9019-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This just renames the helper to improve readability.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index ce466432ac3e..e9166a24b336 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -96,14 +96,14 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 extern void warn_slowpath_null(const char *file, const int line);
 #define WANT_WARN_ON_SLOWPATH
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN() do { \
 	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
 } while (0)
-#define __WARN_printf_taint(taint, arg...)				\
+#define __WARN_printf(taint, arg...)					\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif
 
@@ -127,7 +127,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(TAINT_WARN, format);		\
+		__WARN_printf(TAINT_WARN, format);			\
 	unlikely(__ret_warn_on);					\
 })
 #endif
@@ -135,7 +135,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #define WARN_TAINT(condition, taint, format...) ({			\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_printf_taint(taint, format);			\
+		__WARN_printf(taint, format);				\
 	unlikely(__ret_warn_on);					\
 })
 
-- 
2.17.1

