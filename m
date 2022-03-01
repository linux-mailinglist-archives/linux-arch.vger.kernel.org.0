Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626714C7FFE
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiCABFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiCABFF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:05:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B680922;
        Mon, 28 Feb 2022 17:04:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l9so11738456pls.6;
        Mon, 28 Feb 2022 17:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrNR0ubFsESPf43y01w+R9fi1phF7RotGPv8gNv+PG4=;
        b=TlIRGW5ki+2r1DGJzlEGSyKwiuTOfpNGgpmDLCHUp/G9CMWMSd+4KvysT1o0mnEbZY
         nq5b7FjpvitHGTEiTdyQ/ZoVObQAqMCpsmje5wNcIcLzkujDMXwNdZz/2pfG6VajWbVd
         ni/Nc5WAuyX6YTzWgXYE1vu1kwKqoFIxlvuLpegP8f0PRfeO4bxX7o+3V8a8VXSfSL1t
         mUavpRsQzBpFKHUqqVHDy9/PJDLnbrjAQXY7ZK/QRBCluP3OnlHbKAtQlQOXjnGB1Zkd
         BAd/tDNi8oaRObc/heaKSntGVFR/SEbTo/UDUTvYF4NzwM2IaUgZlV+duhUktLLFk7+x
         N/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JrNR0ubFsESPf43y01w+R9fi1phF7RotGPv8gNv+PG4=;
        b=4LPTXRqXcWqZIkiuDxMn4GD0Qc424nJASQsNjo/tIi0bqAFn5+p41BV8+CEjS9H8f3
         r9DDFbqyiyJC6ed5UQJEANqdoGPJXcPkraSnhLag0XcN4KdhkIZj6Uq7Rm9Dp+vgchPr
         HQazpZpZ6jhbfOYyVa+gj/oLccKtUHPsMnEQ7bfSda8heBtHG1JX+JhZ+UH6Xpx3dqtu
         DAp7sO0DB/uKk0DmsTu/zlnFOMgESgfm9hzNMQ7nReUg674q/pwfsJlFtVNzwi/U1urW
         tkK3ZpvO7P03x83a9cqqxyIimEa2dGaDq6X328ScapLw+jDeJQh0VdkerYBPV0nLByB5
         XG+g==
X-Gm-Message-State: AOAM530d5R4oQNuhYcMVHtHs2Ysd2ZdGoqdAVv6Ru4AHATSM9t9xsFtT
        Upj8BVi+6HJ1Yb+05vDOaws=
X-Google-Smtp-Source: ABdhPJyfEE8rU4X5tKG//O1ZqAiGer717B/t2w0IWdQ1q+GSufua1ZPJB2V7F1xzZRKvy2TgvIMgZQ==
X-Received: by 2002:a17:902:7e08:b0:151:65dd:a2d1 with SMTP id b8-20020a1709027e0800b0015165dda2d1mr8195879plm.66.1646096662540;
        Mon, 28 Feb 2022 17:04:22 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:726c:585a:8796:a60a])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm83861pjb.57.2022.02.28.17.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:04:21 -0800 (PST)
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
Subject: [PATCH 1/4] locking: Add lock contention tracepoints
Date:   Mon, 28 Feb 2022 17:04:09 -0800
Message-Id: <20220301010412.431299-2-namhyung@kernel.org>
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

This adds two new lock contention tracepoints like below:

 * lock:contention_begin
 * lock:contention_end

The lock:contention_begin takes a flags argument to classify locks.  I
found it useful to pass a task state it goes to and it can tell if the
given lock is busy-waiting (spinlock) or sleeping (mutex or semaphore).
Also it has info whether it's a reader-writer lock, real-time, and
per-cpu.

Move tracepoint definitions into a separate file so that we can use
some of them without lockdep.  Also lock_trace.h header was added to
provide access to the tracepoints in the header file (like spinlock.h)
which cannot include the tracepoint definition directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/lock_trace.h  | 31 +++++++++++++++++++++++++++
 include/trace/events/lock.h | 42 ++++++++++++++++++++++++++++++++++++-
 kernel/locking/Makefile     |  2 +-
 kernel/locking/lockdep.c    |  1 -
 kernel/locking/tracepoint.c | 21 +++++++++++++++++++
 5 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/lock_trace.h
 create mode 100644 kernel/locking/tracepoint.c

diff --git a/include/linux/lock_trace.h b/include/linux/lock_trace.h
new file mode 100644
index 000000000000..d84bcc9570a4
--- /dev/null
+++ b/include/linux/lock_trace.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_LOCK_TRACE_H
+#define __LINUX_LOCK_TRACE_H
+
+#include <linux/tracepoint-defs.h>
+
+DECLARE_TRACEPOINT(contention_begin);
+DECLARE_TRACEPOINT(contention_end);
+
+#define LCB_F_READ	(1U << 31)
+#define LCB_F_WRITE	(1U << 30)
+#define LCB_F_RT	(1U << 29)
+#define LCB_F_PERCPU	(1U << 28)
+
+extern void lock_contention_begin(void *lock, unsigned long ip,
+				  unsigned int flags);
+extern void lock_contention_end(void *lock);
+
+#define LOCK_CONTENTION_BEGIN(_lock, _flags)				\
+	do {								\
+		if (tracepoint_enabled(contention_begin))		\
+			lock_contention_begin(_lock, _RET_IP_, _flags);	\
+	} while (0)
+
+#define LOCK_CONTENTION_END(_lock)					\
+	do {								\
+		if (tracepoint_enabled(contention_end))			\
+			lock_contention_end(_lock);			\
+	} while (0)
+
+#endif /* __LINUX_LOCK_TRACE_H */
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..7bca0a537dbd 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -5,11 +5,12 @@
 #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LOCK_H
 
-#include <linux/lockdep.h>
 #include <linux/tracepoint.h>
 
 #ifdef CONFIG_LOCKDEP
 
+#include <linux/lockdep.h>
+
 TRACE_EVENT(lock_acquire,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
@@ -81,6 +82,45 @@ DEFINE_EVENT(lock, lock_acquired,
 #endif
 #endif
 
+TRACE_EVENT(contention_begin,
+
+	TP_PROTO(void *lock, unsigned long ip, unsigned int flags),
+
+	TP_ARGS(lock, ip, flags),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+		__field(unsigned long, ip)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+		__entry->ip = ip;
+		__entry->flags = flags;
+	),
+
+	TP_printk("%p %pS (%x)", __entry->lock_addr,  (void *) __entry->ip,
+		  __entry->flags)
+);
+
+TRACE_EVENT(contention_end,
+
+	TP_PROTO(void *lock),
+
+	TP_ARGS(lock),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+	),
+
+	TP_printk("%p", __entry->lock_addr)
+);
+
 #endif /* _TRACE_LOCK_H */
 
 /* This part must be outside protection */
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index d51cabf28f38..d212401adcdc 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -3,7 +3,7 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT		:= n
 
-obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
+obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o tracepoint.o
 
 # Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
 KCSAN_SANITIZE_lockdep.o := n
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50036c10b518..08f8fb6a2d1e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -60,7 +60,6 @@
 
 #include "lockdep_internals.h"
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/tracepoint.c b/kernel/locking/tracepoint.c
new file mode 100644
index 000000000000..d6f5c6c1d7bd
--- /dev/null
+++ b/kernel/locking/tracepoint.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <linux/lock_trace.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/lock.h>
+
+/* these are exported via LOCK_CONTENTION_{BEGIN,END} macro */
+EXPORT_TRACEPOINT_SYMBOL_GPL(contention_begin);
+EXPORT_TRACEPOINT_SYMBOL_GPL(contention_end);
+
+void lock_contention_begin(void *lock, unsigned long ip, unsigned int flags)
+{
+	trace_contention_begin(lock, ip, flags);
+}
+EXPORT_SYMBOL_GPL(lock_contention_begin);
+
+void lock_contention_end(void *lock)
+{
+	trace_contention_end(lock);
+}
+EXPORT_SYMBOL_GPL(lock_contention_end);
-- 
2.35.1.574.g5d30c73bfb-goog

