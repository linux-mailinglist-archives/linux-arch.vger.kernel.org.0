Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA06346A16
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhCWUkd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhCWUkB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB3C0613D9
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e129so3837159yba.3
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=obb/St0ECVpiVYPjl0tFmSeAu+nwHW6a+FyVf5Y93kL0zciJ7OpXo5pz5/5qK+sMFf
         HVCB7lPNLLCcgrreAMPMIq89DUCTawBOwNPUPSIBya5VRwan8cbfXQx100+5xN/Qkd+t
         DrRy/pbSThpGxZ1QzI4eyYQAJqKt5nt14oxKeAqxjwjAb66eROjyJZpq+iXVKnIt1UeO
         qE3Het9/jgbk33l/79gSOA0M2UKmfHun8/qcQ5XwaA/WAB2nFQGlLlfTzyIcIhj7o/5V
         IAm35WHoPPYpvmYzDW1CTc/YgvwTLIfoZ+x6jtjFf4U8j7x1w0Jt0fXDFRfY/dN/7g6Y
         zgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=YQjMof3PvrKdJPtrFazmi4QqF0pWsVL3PKTfrMm9uJoR5ibeyOIz2bTyxjWMTsWpU8
         RikWE7SM2iN5MXjCYvL8FjUKuxWdBDrq/cphU4NHT4DOPzvz4S5ciDrx63wYbrW6IMBN
         ePx3jDcMocO8qJdNgLVnbU9yP/AdmANQ++g5i8xzjkExrYKq/SP43E0zEG4D/cbPHvjH
         P1mxLDsAv2jMs/BSkRsN68Zzqu2KudwPguocJLdFdmhhcLKqQCihIuG6RdumSxEm60zF
         JgzVSFBO7hTqfKEakJhz8NB8CjtWTwgeEcT685nr2orfUxs9ySBnnubU4t2eUo9xl9H8
         5Rgw==
X-Gm-Message-State: AOAM532lKWbIXc5xQbNllydlDrLUWutOqt/KZj9CIxvlBY3r+EPPsWED
        41ZdNGQFGLJXa8/KRO4zipcq1JYuTL6Yu5ZNHqg=
X-Google-Smtp-Source: ABdhPJy06lzastyLa7rjZrqrKe8Kw6vypE8VYVF9BzE0zOiJRLohmqAfcSnsVJk7XWpS4yGsr/w/V3cRXxwJCIzEtGs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:e008:: with SMTP id
 x8mr147121ybg.90.1616531999835; Tue, 23 Mar 2021 13:39:59 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:35 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..a1972eba2917 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -963,7 +963,8 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function,
+				  kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.31.0.291.g576ba9dcdaf-goog

