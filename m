Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CA4DBAB7
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 23:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiCPWrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiCPWrO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 18:47:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590FC12AF4;
        Wed, 16 Mar 2022 15:45:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz9-20020a17090b378900b001c657559290so3622783pjb.2;
        Wed, 16 Mar 2022 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBd+rVGks9vxgeyO63hZy1sNZZwzfinQbSZQpFKlhAw=;
        b=eu6OVpRj0+nZhkCSNtlFKEy3cF+RYvB6hgqFUMT1NmyDcj1kmGG+HWTbAxhmEUe18Y
         bqo7J3zlOhhdgDwx/apB7DPGwbmY0boUVlZuy/qxxEDXvf16Oi/8YH0oF3EftsH2VHYw
         Q5iwuHsMcB+FkcHBnHDv9EMzRICC9me0WpVDOX3SP0Sck/Kp1CUVYBHl8Tyl84nHcDhJ
         YnDDb6D3hSpyms2TuidXLgUS2Nw144mnNyvzPYWLbHH5nVmWuk+VtKGklDkku77oEqvF
         cU2OQL6E0kK9au10lj1Tg+P8fKw0jgHVKZ4Gb3EvKhgA4+mX2qhL1btzRfJvI5NY3zDH
         Zalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EBd+rVGks9vxgeyO63hZy1sNZZwzfinQbSZQpFKlhAw=;
        b=b98aAM7QiucL7FKlDg0kzKbzchdrs0REOEie9omZGz9gsS03dtmeANpUWWl30PhJH4
         iJeTdYmWuOFh04Ac5j23pNgIe5PfxwG6dbQ2EfoOxH+N3GDlSMh626tT3T0SUaB6dD0U
         yIfKRoPlwVJQQVlZ7nQSBSKOe10xPFZwSCb7XdE/W19Ij5s4LwWSKx1fG1yfhriLGOn0
         O33Jr77vwH/CqFYEy2E/ig3R8H0geEOvEGkeE9breolV2vTSFVk9qxaPxYzQUys3j5gO
         r0Tb4W+GIGI4O3yOal1nTAXwTGg3B/OJ3kRcjGorrRClEBiUvOfWqu0PT56FiLgfJl7i
         SEvA==
X-Gm-Message-State: AOAM532vtUG1oFxPdkQkpRRcRjv11Wwt+D2EUMHYEt13WySBclkYJevX
        oq7H4zi976W5GNpH35TsPEo=
X-Google-Smtp-Source: ABdhPJye2AcvGypEIet/hQ5rU4qqo0zrUBf5qXPgC4FyfdCmtWmZdiqbLpjpSTAJuEd8/rnjgEM+gQ==
X-Received: by 2002:a17:902:cec7:b0:151:bb1b:5c9d with SMTP id d7-20020a170902cec700b00151bb1b5c9dmr2079383plg.41.1647470758862;
        Wed, 16 Mar 2022 15:45:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:9b43:96ac:9f9:5093])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a088d00b001c64d30fa8bsm6397832pjc.1.2022.03.16.15.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:45:58 -0700 (PDT)
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
        bpf@vger.kernel.org
Subject: [PATCH 1/2] locking: Add lock contention tracepoints
Date:   Wed, 16 Mar 2022 15:45:47 -0700
Message-Id: <20220316224548.500123-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220316224548.500123-1-namhyung@kernel.org>
References: <20220316224548.500123-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/trace/events/lock.h | 54 ++++++++++++++++++++++++++++++++++---
 kernel/locking/lockdep.c    |  1 -
 kernel/locking/mutex.c      |  3 +++
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..2a3df36d4fdb 100644
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
@@ -78,8 +88,46 @@ DEFINE_EVENT(lock, lock_acquired,
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
+	TP_printk("%p (flags=%x)", __entry->lock_addr, __entry->flags)
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

