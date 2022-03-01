Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571384C8007
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 02:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiCABFM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 20:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiCABFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 20:05:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC41D10B5;
        Mon, 28 Feb 2022 17:04:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l9so11738587pls.6;
        Mon, 28 Feb 2022 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gFbnjPO5BppYFMj5w1roPmhQ+QxHohBl6chbdLG//Y=;
        b=CXmgh4qlkuelcapoCZgjZF28iLW/v4m5kJWYg6rBRfsU5DUl5zh4Mx0gPu3iOMz3kO
         sFQGFd6OZidgbTw+ycrtlKVIoJ04jfEm903MrXEYb3Ye7g8rQzwtMP5SxCnM/8O2DcYG
         KT1ai0FZQmQft3xfOcmZianVXTgsQBzqqS4NTWjXOvprzJIkqfWaPbmFidCLpGuiO50q
         RoTpV49RiE9neuzCuiAgVSmktEJDNMl7oCrFaTPLX20NjLpELw8YKLCpL3ObHKWUeW2G
         LT5UEgsot4rHvhExuMyojkcNhWk92zSSn+9rxU18DRtd+BuKHdncxbZO23c99eMzeWOG
         +71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3gFbnjPO5BppYFMj5w1roPmhQ+QxHohBl6chbdLG//Y=;
        b=tUXCjdh1FqzxPU90BCz2mfKWP4zQqT0qGoFW3x09sfyCw3rU0DMTm48WQLAJG9tMYK
         rmO8oguHEmsCLs3eSkp5izSR0jEwZznGRmhiyc8oJc0WTLxdrP9g9sE9UPXmEuz+Hl45
         5pKBS8v63JKyBUs05MpXDgCg/Tbb5viFJ89PtzypijONQ1Y87xIFINrgSE83fjKAtVxR
         FsGOKZtoTwTT00CVewxJoPIOhtoQLC3dYbQszXWOO2lBPq1kwHSd8UZt7vT09sVytOjH
         mIuXJHgBQ3uM+oK3+hKs3aWzjWu2Tzfs/ojmX30KYrsG2CVtE8AgiQfIzrX06uf9KQXC
         QdZg==
X-Gm-Message-State: AOAM530TPcYNr9knwXBqP4rrJU0QJCmDsEZZa+dS9Okh4WSUbnq5m0qY
        kEAaEujQ1Bx4GB/H+6pu0LE=
X-Google-Smtp-Source: ABdhPJwuQUOhH5HgWMT6ym5KV9IIXSrqjClUjSJJjUuczVfQIokubn+Ue0IR3NYj+iLFUgDjahxybg==
X-Received: by 2002:a17:902:e949:b0:14b:1f32:e926 with SMTP id b9-20020a170902e94900b0014b1f32e926mr23813235pll.170.1646096668567;
        Mon, 28 Feb 2022 17:04:28 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:726c:585a:8796:a60a])
        by smtp.gmail.com with ESMTPSA id cv15-20020a17090afd0f00b001bedcbca1a9sm83861pjb.57.2022.02.28.17.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:04:28 -0800 (PST)
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
Subject: [PATCH 4/4] locking/rwsem: Pass proper call-site ip
Date:   Mon, 28 Feb 2022 17:04:12 -0800
Message-Id: <20220301010412.431299-5-namhyung@kernel.org>
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

For some reason, __down_read_common() was not inlined in my system.
So I can only see its caller down_read() in the tracepoint.  It should
pass an IP of the actual caller.  Let's add a new variants of
LOCK_CONTENDED macro to pass _RET_IP_ to the lock function and make
rwsem down functions take an ip argument

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/lockdep.h | 29 ++++++++++++++++-
 kernel/locking/rwsem.c  | 69 ++++++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105..6aca885f356c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -453,7 +453,16 @@ do {								\
 		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
 		lock(_lock);					\
 	}							\
-	lock_acquired(&(_lock)->dep_map, _RET_IP_);			\
+	lock_acquired(&(_lock)->dep_map, _RET_IP_);		\
+} while (0)
+
+#define LOCK_CONTENDED_IP(_lock, try, lock)			\
+do {								\
+	if (!try(_lock)) {					\
+		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
+		lock(_lock, _RET_IP_);				\
+	}							\
+	lock_acquired(&(_lock)->dep_map, _RET_IP_);		\
 } while (0)
 
 #define LOCK_CONTENDED_RETURN(_lock, try, lock)			\
@@ -468,6 +477,18 @@ do {								\
 	____err;						\
 })
 
+#define LOCK_CONTENDED_RETURN_IP(_lock, try, lock)		\
+({								\
+	int ____err = 0;					\
+	if (!try(_lock)) {					\
+		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
+		____err = lock(_lock, _RET_IP_);		\
+	}							\
+	if (!____err)						\
+		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
+	____err;						\
+})
+
 #else /* CONFIG_LOCK_STAT */
 
 #define lock_contended(lockdep_map, ip) do {} while (0)
@@ -476,9 +497,15 @@ do {								\
 #define LOCK_CONTENDED(_lock, try, lock) \
 	lock(_lock)
 
+#define LOCK_CONTENDED_IP(_lock, try, lock) \
+	lock(_lock, _RET_IP_)
+
 #define LOCK_CONTENDED_RETURN(_lock, try, lock) \
 	lock(_lock)
 
+#define LOCK_CONTENDED_RETURN_IP(_lock, try, lock) \
+	lock(_lock, _RET_IP_)
+
 #endif /* CONFIG_LOCK_STAT */
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index a1a17af7f747..eafb0faaed0d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1207,13 +1207,14 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static inline int __down_read_common(struct rw_semaphore *sem, int state,
+				     unsigned long ip)
 {
 	long count;
 	void *ret;
 
 	if (!rwsem_read_trylock(sem, &count)) {
-		trace_contention_begin(sem, _RET_IP_, LCB_F_READ | state);
+		trace_contention_begin(sem, ip, LCB_F_READ | state);
 		ret = rwsem_down_read_slowpath(sem, count, state);
 		trace_contention_end(sem);
 
@@ -1224,19 +1225,19 @@ static inline int __down_read_common(struct rw_semaphore *sem, int state)
 	return 0;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static inline void __down_read(struct rw_semaphore *sem, unsigned long ip)
 {
-	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE, ip);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static inline int __down_read_interruptible(struct rw_semaphore *sem, unsigned long ip)
 {
-	return __down_read_common(sem, TASK_INTERRUPTIBLE);
+	return __down_read_common(sem, TASK_INTERRUPTIBLE, ip);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static inline int __down_read_killable(struct rw_semaphore *sem, unsigned long ip)
 {
-	return __down_read_common(sem, TASK_KILLABLE);
+	return __down_read_common(sem, TASK_KILLABLE, ip);
 }
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -1259,12 +1260,13 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static inline int __down_write_common(struct rw_semaphore *sem, int state,
+				      unsigned long ip)
 {
 	void *ret;
 
 	if (unlikely(!rwsem_write_trylock(sem))) {
-		trace_contention_begin(sem, _RET_IP_, LCB_F_WRITE | state);
+		trace_contention_begin(sem, ip, LCB_F_WRITE | state);
 		ret = rwsem_down_write_slowpath(sem, state);
 		trace_contention_end(sem);
 
@@ -1275,14 +1277,14 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return 0;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write(struct rw_semaphore *sem, unsigned long ip)
 {
-	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
+	__down_write_common(sem, TASK_UNINTERRUPTIBLE, ip);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static inline int __down_write_killable(struct rw_semaphore *sem, unsigned long ip)
 {
-	return __down_write_common(sem, TASK_KILLABLE);
+	return __down_write_common(sem, TASK_KILLABLE, ip);
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
@@ -1397,17 +1399,17 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 }
 EXPORT_SYMBOL(__init_rwsem);
 
-static inline void __down_read(struct rw_semaphore *sem)
+static inline void __down_read(struct rw_semaphore *sem, unsigned long ip)
 {
 	rwbase_read_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static inline int __down_read_interruptible(struct rw_semaphore *sem, unsigned long ip)
 {
 	return rwbase_read_lock(&sem->rwbase, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static inline int __down_read_killable(struct rw_semaphore *sem, unsigned long ip)
 {
 	return rwbase_read_lock(&sem->rwbase, TASK_KILLABLE);
 }
@@ -1422,12 +1424,12 @@ static inline void __up_read(struct rw_semaphore *sem)
 	rwbase_read_unlock(&sem->rwbase, TASK_NORMAL);
 }
 
-static inline void __sched __down_write(struct rw_semaphore *sem)
+static inline void __sched __down_write(struct rw_semaphore *sem, unsigned long ip)
 {
 	rwbase_write_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __sched __down_write_killable(struct rw_semaphore *sem)
+static inline int __sched __down_write_killable(struct rw_semaphore *sem, unsigned long ip)
 {
 	return rwbase_write_lock(&sem->rwbase, TASK_KILLABLE);
 }
@@ -1472,7 +1474,7 @@ void __sched down_read(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
-	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
+	LOCK_CONTENDED_IP(sem, __down_read_trylock, __down_read);
 }
 EXPORT_SYMBOL(down_read);
 
@@ -1481,7 +1483,8 @@ int __sched down_read_interruptible(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
+	if (LOCK_CONTENDED_RETURN_IP(sem, __down_read_trylock,
+				     __down_read_interruptible)) {
 		rwsem_release(&sem->dep_map, _RET_IP_);
 		return -EINTR;
 	}
@@ -1495,7 +1498,8 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
+	if (LOCK_CONTENDED_RETURN_IP(sem, __down_read_trylock,
+				     __down_read_killable)) {
 		rwsem_release(&sem->dep_map, _RET_IP_);
 		return -EINTR;
 	}
@@ -1524,7 +1528,7 @@ void __sched down_write(struct rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
+	LOCK_CONTENDED_IP(sem, __down_write_trylock, __down_write);
 }
 EXPORT_SYMBOL(down_write);
 
@@ -1536,8 +1540,8 @@ int __sched down_write_killable(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
-				  __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN_IP(sem, __down_write_trylock,
+				     __down_write_killable)) {
 		rwsem_release(&sem->dep_map, _RET_IP_);
 		return -EINTR;
 	}
@@ -1596,7 +1600,7 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
-	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
+	LOCK_CONTENDED_IP(sem, __down_read_trylock, __down_read);
 }
 EXPORT_SYMBOL(down_read_nested);
 
@@ -1605,7 +1609,8 @@ int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
+	if (LOCK_CONTENDED_RETURN_IP(sem, __down_read_trylock,
+				     __down_read_killable)) {
 		rwsem_release(&sem->dep_map, _RET_IP_);
 		return -EINTR;
 	}
@@ -1618,14 +1623,14 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
-	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
+	LOCK_CONTENDED_IP(sem, __down_write_trylock, __down_write);
 }
 EXPORT_SYMBOL(_down_write_nest_lock);
 
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
-	__down_read(sem);
+	__down_read(sem, _RET_IP_);
 	__rwsem_set_reader_owned(sem, NULL);
 }
 EXPORT_SYMBOL(down_read_non_owner);
@@ -1634,7 +1639,7 @@ void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
-	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
+	LOCK_CONTENDED_IP(sem, __down_write_trylock, __down_write);
 }
 EXPORT_SYMBOL(down_write_nested);
 
@@ -1643,8 +1648,8 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
-				  __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN_IP(sem, __down_write_trylock,
+				     __down_write_killable)) {
 		rwsem_release(&sem->dep_map, _RET_IP_);
 		return -EINTR;
 	}
-- 
2.35.1.574.g5d30c73bfb-goog

