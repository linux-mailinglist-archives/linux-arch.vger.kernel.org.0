Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD064C8004
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiCABFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCABFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:05:06 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC4D005F;
        Mon, 28 Feb 2022 17:04:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 139so13084767pge.1;
        Mon, 28 Feb 2022 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yM/quxeVqCB0P6Eu2BBnjYZ4Tx/QdCrOaO8okg5iWo=;
        b=F/2F5Mak16oDCB4aG+yUBXI4U/uWfuo/xWxkWFqdPAxEScPG1/fKN+r+FmGQkVqmm5
         5ASJI0BH/HCMown0NwrCHx9Yx2549mBwYC2DVfy/5XlEQsW8TNRJsD0QG7I4rjchgHCY
         aksBL0gHpvxaw+OVAMD0D0XUMbuJSfQRIVWgQg9XhD4D9LQIxDWFHn1napKOVy/NR67c
         E0aHzGtcoXISsn0llv6qzSzCZacTdhV+59NHIR08r1Myl1tNgOR3PrudTl7dQApSYOeO
         7Ml7RqaibagRSxuTCUH6brjjn90FO44ka02j91jWrKWvyqJ35naz0lwvUEk3sgZhdXTK
         OArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0yM/quxeVqCB0P6Eu2BBnjYZ4Tx/QdCrOaO8okg5iWo=;
        b=JvzIL+Kpd9ixV1JmZ9REQiojUHxbssQxGhe8wkRzCnsrjAl62liDe/LyExs3SwFllx
         rPAzfMdyu7N/YYJ367OQTZgvvYiy++9tOOi6CxF2e7vvA1Hvvit9yNysMNzjV5yIBeKv
         XBqtKkP8amKCVpz2G5u3eqS7hZ3ALjnYqKgZzyJweq41ISG53tCMlHZTh2Z0GEK1ibOB
         IGH9kmEg7nPAQLyQT2s/VKgxB9foUW71Jj0PSrljEOl7Ly2PPlD+D8480k/NWS0AMXoq
         Zv55eWXowSXIOV/JUNScb9ItcD/jGGc4wk22gFK+Ef86IpFmrVHqisdNsnFdKcUWgiBI
         4tJA==
X-Gm-Message-State: AOAM531FS4WoWiWaeJiZrurDlzQcfHdCo4jWjt/hJuqa2k/QlmOsRpaP
        T7EFB2HAHqfuETd05oZG15A=
X-Google-Smtp-Source: ABdhPJxmx8QY6WLC1rmMvip8jHagVdEZuVhy+ogBV9rFHUfQ1TaT8aorNNhFjYluEZtlOYASjmIxdA==
X-Received: by 2002:a05:6a00:24ca:b0:4e1:cb76:32da with SMTP id d10-20020a056a0024ca00b004e1cb7632damr24244003pfv.81.1646096666357;
        Mon, 28 Feb 2022 17:04:26 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:726c:585a:8796:a60a])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm83861pjb.57.2022.02.28.17.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:04:25 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: [PATCH 3/4] locking/mutex: Pass proper call-site ip
Date:   Mon, 28 Feb 2022 17:04:11 -0800
Message-Id: <20220301010412.431299-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
In-Reply-To: <20220301010412.431299-1-namhyung@kernel.org>
References: <20220301010412.431299-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The __mutex_lock_slowpath() and friends are declared as noinline and
_RET_IP_ returns its caller as mutex_lock which is not meaningful.
Pass the ip from mutex_lock() to have actual caller info in the trace.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/mutex.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 756624c14dfd..126b014098f3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -254,7 +254,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
  * We also put the fastpath first in the kernel image, to make sure the
  * branch is predicted by the CPU as default-untaken.
  */
-static void __sched __mutex_lock_slowpath(struct mutex *lock);
+static void __sched __mutex_lock_slowpath(struct mutex *lock, unsigned long ip);
 
 /**
  * mutex_lock - acquire the mutex
@@ -282,7 +282,7 @@ void __sched mutex_lock(struct mutex *lock)
 	might_sleep();
 
 	if (!__mutex_trylock_fast(lock))
-		__mutex_lock_slowpath(lock);
+		__mutex_lock_slowpath(lock, _RET_IP_);
 }
 EXPORT_SYMBOL(mutex_lock);
 #endif
@@ -947,10 +947,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  * mutex_lock_interruptible() and mutex_trylock().
  */
 static noinline int __sched
-__mutex_lock_killable_slowpath(struct mutex *lock);
+__mutex_lock_killable_slowpath(struct mutex *lock, unsigned long ip);
 
 static noinline int __sched
-__mutex_lock_interruptible_slowpath(struct mutex *lock);
+__mutex_lock_interruptible_slowpath(struct mutex *lock, unsigned long ip);
 
 /**
  * mutex_lock_interruptible() - Acquire the mutex, interruptible by signals.
@@ -971,7 +971,7 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
 	if (__mutex_trylock_fast(lock))
 		return 0;
 
-	return __mutex_lock_interruptible_slowpath(lock);
+	return __mutex_lock_interruptible_slowpath(lock, _RET_IP_);
 }
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
@@ -995,7 +995,7 @@ int __sched mutex_lock_killable(struct mutex *lock)
 	if (__mutex_trylock_fast(lock))
 		return 0;
 
-	return __mutex_lock_killable_slowpath(lock);
+	return __mutex_lock_killable_slowpath(lock, _RET_IP_);
 }
 EXPORT_SYMBOL(mutex_lock_killable);
 
@@ -1020,36 +1020,36 @@ void __sched mutex_lock_io(struct mutex *lock)
 EXPORT_SYMBOL_GPL(mutex_lock_io);
 
 static noinline void __sched
-__mutex_lock_slowpath(struct mutex *lock)
+__mutex_lock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, ip);
 }
 
 static noinline int __sched
-__mutex_lock_killable_slowpath(struct mutex *lock)
+__mutex_lock_killable_slowpath(struct mutex *lock, unsigned long ip)
 {
-	return __mutex_lock(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_KILLABLE, 0, NULL, ip);
 }
 
 static noinline int __sched
-__mutex_lock_interruptible_slowpath(struct mutex *lock)
+__mutex_lock_interruptible_slowpath(struct mutex *lock, unsigned long ip)
 {
-	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, ip);
 }
 
 static noinline int __sched
-__ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+__ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx,
+			 unsigned long ip)
 {
-	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
-			       _RET_IP_, ctx);
+	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, ip, ctx);
 }
 
 static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
-					    struct ww_acquire_ctx *ctx)
+				       struct ww_acquire_ctx *ctx,
+				       unsigned long ip)
 {
-	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
-			       _RET_IP_, ctx);
+	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, ip, ctx);
 }
 
 #endif
@@ -1094,7 +1094,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 		return 0;
 	}
 
-	return __ww_mutex_lock_slowpath(lock, ctx);
+	return __ww_mutex_lock_slowpath(lock, ctx, _RET_IP_);
 }
 EXPORT_SYMBOL(ww_mutex_lock);
 
@@ -1109,7 +1109,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 		return 0;
 	}
 
-	return __ww_mutex_lock_interruptible_slowpath(lock, ctx);
+	return __ww_mutex_lock_interruptible_slowpath(lock, ctx, _RET_IP_);
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
-- 
2.35.1.574.g5d30c73bfb-goog

