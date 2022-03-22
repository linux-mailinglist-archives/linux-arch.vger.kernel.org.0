Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7B4E465A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiCVS6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCVS6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:58:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C091548;
        Tue, 22 Mar 2022 11:57:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w21so9579888pgm.7;
        Tue, 22 Mar 2022 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAMBj1S29rgAzHcNPl/UWJtGAptXvHHW2Jh7MIwSDOM=;
        b=hmhlSxZTx6aS+hIMhHNUz2KF//sFEwtfxPJISnORBDnKoJz+FNhUrWg2su2tviz/cN
         J2Q7GYV3bp2NNybGH17XweiZlGNpdm2v3fJmudkY1dKQLA0nidLaj8syH+wdh0kWXaTJ
         +8duOg01rsa+Za8uuBZJxXAeeG6qxd004HiungJcyaasNl1SUbArMI6MlzxAIgZl8H2f
         JbSIS6PEIWgTPVFeM4R9fFClqdICrgKL0A8rMNKEiyFAi7zWa1mj9s03Ejwx+5ESUNRs
         jrVH//4MvM9ENJlifOH2YFl9dmEfWCWRCjYUbi3XL9jqgFTHiVWpHG1r8lpBiKe8ZqMJ
         ApGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gAMBj1S29rgAzHcNPl/UWJtGAptXvHHW2Jh7MIwSDOM=;
        b=0I9hC0o8I84NG0a2akb1dd86lVaeaBNfZOte73H4o9qYN/x7SzY3YJhdJ0A1bDCe9P
         crXe+dF1pQI8LgRl+dY4qN+ngwejQWvmGiZImeR2rsByhizmesU9d2x7/eyourRA3VT4
         l+lbACS65PPHr4gX/wqOh7uB9lJK2avhGteFziwxf2X7fOXiz+E+r1kVR+SXcXWyDU5f
         1yuNpoCe4i+CMX2JEFhR1MYz11NqCwGSNTkIyLTBemngL5O4xu15kpn0rtLSDfg1Rj39
         AYPGq4mYZNhCwVQ7Mh8tv4B1XmVXdB+bBtiqMSAFO2ze3Fja0eF1Fh5lOzCeqvaJPRuR
         EIGw==
X-Gm-Message-State: AOAM531PyBtdQwZI8Z7G9eO3ZfvcPniA3gNmRKBzvkXADHcAniDBPO6h
        lTfnbY/y65eKzgNvVei1a1Cshyxl3PU=
X-Google-Smtp-Source: ABdhPJz/yMJgmlsKxx/8y/7qKGZmUAeKx49YYWs9Wej7R+HBSQop0d4WzwpMbAKrAcafRuZhsCPbvA==
X-Received: by 2002:a63:ea51:0:b0:380:7c35:188e with SMTP id l17-20020a63ea51000000b003807c35188emr23113078pgk.607.1647975435002;
        Tue, 22 Mar 2022 11:57:15 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:c09f:7727:246c:bda2])
        by smtp.gmail.com with ESMTPSA id u14-20020a056a00124e00b004fab8f3245fsm3772681pfi.149.2022.03.22.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:57:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 1/2] locking: Add lock contention tracepoints
Date:   Tue, 22 Mar 2022 11:57:08 -0700
Message-Id: <20220322185709.141236-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322185709.141236-1-namhyung@kernel.org>
References: <20220322185709.141236-1-namhyung@kernel.org>
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

This adds two new lock contention tracepoints like below:

 * lock:contention_begin
 * lock:contention_end

The lock:contention_begin takes a flags argument to classify locks.  I
found it useful to identify what kind of locks it's tracing like if
it's spinning or sleeping, reader-writer lock, real-time, and per-cpu.

Move tracepoint definitions into mutex.c so that we can use them
without lockdep.

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/trace/events/lock.h | 61 +++++++++++++++++++++++++++++++++++--
 kernel/locking/lockdep.c    |  1 -
 kernel/locking/mutex.c      |  3 ++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..b9b6e3edd518 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -5,11 +5,21 @@
 #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LOCK_H
 
-#include <linux/lockdep.h>
+#include <linux/sched.h>
 #include <linux/tracepoint.h>
 
+/* flags for lock:contention_begin */
+#define LCB_F_SPIN	(1U << 0)
+#define LCB_F_READ	(1U << 1)
+#define LCB_F_WRITE	(1U << 2)
+#define LCB_F_RT	(1U << 3)
+#define LCB_F_PERCPU	(1U << 4)
+
+
 #ifdef CONFIG_LOCKDEP
 
+#include <linux/lockdep.h>
+
 TRACE_EVENT(lock_acquire,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
@@ -78,8 +88,53 @@ DEFINE_EVENT(lock, lock_acquired,
 	TP_ARGS(lock, ip)
 );
 
-#endif
-#endif
+#endif /* CONFIG_LOCK_STAT */
+#endif /* CONFIG_LOCKDEP */
+
+TRACE_EVENT(contention_begin,
+
+	TP_PROTO(void *lock, unsigned int flags),
+
+	TP_ARGS(lock, flags),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+		__entry->flags = flags;
+	),
+
+	TP_printk("%p (flags=%s)", __entry->lock_addr,
+		  __print_flags(__entry->flags, "|",
+				{ LCB_F_SPIN,		"SPIN" },
+				{ LCB_F_READ,		"READ" },
+				{ LCB_F_WRITE,		"WRITE" },
+				{ LCB_F_RT,		"RT" },
+				{ LCB_F_PERCPU,		"PERCPU" }
+			  ))
+);
+
+TRACE_EVENT(contention_end,
+
+	TP_PROTO(void *lock, int ret),
+
+	TP_ARGS(lock, ret),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+		__entry->ret = ret;
+	),
+
+	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
+);
 
 #endif /* _TRACE_LOCK_H */
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50036c10b518..08f8fb6a2d1e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -60,7 +60,6 @@
 
 #include "lockdep_internals.h"
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e3585950ec8..ee2fd7614a93 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,6 +30,9 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/lock.h>
+
 #ifndef CONFIG_PREEMPT_RT
 #include "mutex.h"
 
-- 
2.35.1.894.gb6a874cedc-goog

