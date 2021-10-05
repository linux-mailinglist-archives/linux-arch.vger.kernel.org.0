Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D446E422412
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhJELBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhJELBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:01:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC9DC06161C
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 03:59:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k3-20020a05620a414300b0045e623cd1afso26530589qko.20
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o6tCUIHZ5VDO2w0cRCfWBwR+yqfihIBzxgT5IEbFQNw=;
        b=qOYA0jMM+/K12dDkdqs5dZ3iMCJm3H1O1uaYwVLBeKrAhWN7jVjWdUTboBH62QGYBH
         K7sUdAzFd8gD1odKu/+wFFrgA8t6Kq0PG3NwF/V/QBb6aCzlrc5PsXuOzcgQy0KUXb5M
         QBUBbQzS4bpYxLCwaXrAKKVfnJT80/k/eMJeNwG90yvhariPjIdMkROHst61Ds2Nrkww
         6amOm2FKDDIl4zRWFKQYTrjQhVJel4eUDAvbWBj5aOz7X8h+Lwdb8TydU/s8PFnhfF88
         GNct/WFveKORSyhAc8FPCo2dMHN33ZDlj/EnBENx6DK4m+MRQKBSoxYA9tfhP79S+vhA
         OGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o6tCUIHZ5VDO2w0cRCfWBwR+yqfihIBzxgT5IEbFQNw=;
        b=ytJTm8TClA6p5BQiJDffR+6JnparC3XSl72nTCAUPWjczv6XtpryLzAW9q0qUwSk7n
         1frxk9EM62GrOe8pe1nZzouAUPGDoR9tcMD6WDW7T+nMh9x56RH8STI0d2hpBj5hLS61
         rrmVogrrbJLik0NQbmf3yUf9xWPQS3tHBr9JZa4E5BSDnwWBTwvISwOcOHQJWa35ckb6
         F9H9MB08MkxmmrrP0kKkxpfoecPq/NatKU3Vx71WYIkHOFvKzj0aw5Vxzyi2TXyNhfA9
         lz8O+fRrtNlVpQo/cR3a9sRc9+c3dZlGVcigJbcZCtcwFV4RE6qe6J4kl+rHqGft20Fi
         SSew==
X-Gm-Message-State: AOAM5316F44HK4AN10/frwY10ElOOZN4M2s7bwAOa2BAUzay+L7V2TRd
        NXqSTWs+TWRXv1JOevVNWMPb9q0EXQ==
X-Google-Smtp-Source: ABdhPJyTEl2z+SbGZhkD9pQ6CXRsL39PESmKScxZvPEVS4ezV0+8cNls5zkvZs5Q6ztfstx525hmvU838w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:c1:: with SMTP id
 f1mr7500180qvs.9.1633431587608; Tue, 05 Oct 2021 03:59:47 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:44 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-3-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 02/23] kcsan: Remove redundant zero-initialization
 of globals
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

They are implicitly zero-initialized, remove explicit initialization.
It keeps the upcoming additions to kcsan_ctx consistent with the rest.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 init/init_task.c    | 9 +--------
 kernel/kcsan/core.c | 5 -----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index 2d024066e27b..61700365ce58 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -181,14 +181,7 @@ struct task_struct init_task
 	.kasan_depth	= 1,
 #endif
 #ifdef CONFIG_KCSAN
-	.kcsan_ctx = {
-		.disable_count		= 0,
-		.atomic_next		= 0,
-		.atomic_nest_count	= 0,
-		.in_flat_atomic		= false,
-		.access_mask		= 0,
-		.scoped_accesses	= {LIST_POISON1, NULL},
-	},
+	.kcsan_ctx = { .scoped_accesses = {LIST_POISON1, NULL} },
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	.softirqs_enabled = 1,
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 6bfd3040f46b..e34a1710b7bc 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -44,11 +44,6 @@ bool kcsan_enabled;
 
 /* Per-CPU kcsan_ctx for interrupts */
 static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
-	.disable_count		= 0,
-	.atomic_next		= 0,
-	.atomic_nest_count	= 0,
-	.in_flat_atomic		= false,
-	.access_mask		= 0,
 	.scoped_accesses	= {LIST_POISON1, NULL},
 };
 
-- 
2.33.0.800.g4c38ced690-goog

