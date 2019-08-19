Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49FB951CC
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfHSXlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 19:41:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfHSXlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so2135355pfq.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbeJELJt4yIGEhE/X9GRRM8X1m9EGNSNDo3EW/BYEes=;
        b=fMeKccAI6lBQNvCfoQV4v6qBvMdAH0T9g8CjKXNIx1cPaQ4rQ+1Kq2Ut+2C4eSadkD
         VUEdvlPJgcmSvF73Z2OB3ZJzh7zLPiZYxPE3eJvCrn7y8Gz8iRR9f8hwnM7a04jlBxbP
         +qX9jkeutY2O8jjNHf8HVe/7o5331zFJnqeL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbeJELJt4yIGEhE/X9GRRM8X1m9EGNSNDo3EW/BYEes=;
        b=o0Cau8PWIeSrU9s1KH5k7l6Lsx+9AfkjtDoUs7dGI7tgQUHAsMaQkektiPZHyYrMV/
         NEEPTbJu9fmeuFbq17FsO0+EQMgk4sXlZmML7WI1p07Ht9eOez0wox0hRL46zde+klmw
         f6dyI157wOtC7Thb/yep2Izci9Es329U6WycewbsF1lV0NZuuMwFvMk9gr/ATvXw/WEM
         XHq4XU6Ge9iCKJ582KbMKJr83pQxCxMzMI0LCh09pQu/IZi13ibkBOHII2cvKZ/Pm3ba
         gsGxGksMH17TVV8y2NB3xp6I9t1/Jm17Aoe6yxSicZlYo1VeTUlgptiUmz1K2cVuT+v1
         U/KA==
X-Gm-Message-State: APjAAAWkiK/Y+b4cYfSTSTBo/OZdEVL21Lp+8+b/wIYn5kJleFxEutka
        WpkZ3S6ViyQnYTpyFcNxOisa4Q==
X-Google-Smtp-Source: APXvYqzsFtbJdhYh/+Iruj5b5YlJcm3VFKU+IRNlxr49ybr/vufBEOgAKggdIWnSj76CjWchhxCTgQ==
X-Received: by 2002:a65:518a:: with SMTP id h10mr20084317pgq.117.1566258078186;
        Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16sm18169083pfs.6.2019.08.19.16.41.16
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
Subject: [PATCH 4/7] bug: Lift "cut here" out of __warn()
Date:   Mon, 19 Aug 2019 16:41:08 -0700
Message-Id: <20190819234111.9019-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for cleaning up "cut here", move the "cut here" logic
up out of __warn() and into callers that pass non-NULL args. For anyone
looking closely, there are two callers that pass NULL args: one already
explicitly prints "cut here". The remaining case is covered by how a
WARN is built, which will be cleaned up in the next patch.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 51efdeb2558e..dc2243429903 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -551,9 +551,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	if (args)
-		pr_warn(CUT_HERE);
-
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
 			raw_smp_processor_id(), current->pid, file, line,
@@ -597,8 +594,9 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	pr_warn(CUT_HERE);
+
 	if (!fmt) {
-		pr_warn(CUT_HERE);
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
 		return;
-- 
2.17.1

