Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF353276A63
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgIXHPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHPo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:15:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26497C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so1341292pgl.10
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imyNk/pfD/Crh/h3JilzWEWmXyUrqyB5bMwtrpzuDLg=;
        b=WE0nx41N26rnHl186xWg/PAGD2ArGQgS5Xc3YlKMmbP4nDDcuGJZ5UcAK5fXa9K9xm
         rIi9uaLtfGxHy0yqMapS2KVfs0CAnezmrtOEgJKz06hQ5nxUR67cPe7LISJL4xxTbASC
         w0YgOBTf6GCNQBAwrPcegcev7kogxSd5s/iPx5v7eZQdtE6pzLL49h3dbDcytYDtqFPm
         yx33ExwZ2/XgLeWKO8vFDnqliI/AnmU4He8PxHS9dQxRrCL53xW2NUxc1NcOIdHsEm+b
         Ic+CWlwhccfmHbvDSLdIm84oGNOLawD+YASVIaNRK1jhtbCz5DqjeguqCPz3uwUbHlZR
         omaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imyNk/pfD/Crh/h3JilzWEWmXyUrqyB5bMwtrpzuDLg=;
        b=Rwgy9CxWuW3N1z7rKiS0srjc2+o3X1+sRFNRxMt+SSMZLjFn8iG8bssgXPIuNm7RAs
         Dih9mUqCbY2HQfyGZwSaf7gjGne8dY5R0t0p5t96N6gtjZb7nxVLmnOCUt9fewocP+bz
         vjx0tyCz+2sPI8IuDc/59J8x5JPcV8yWD3fofpyMxyW8+HCI3/SPWE8Q5LaT09cLVlfs
         XZ+/LcIkaBVpKZkqkCxVeCXApNVIBRjr68XF/QasGbdVJ0HKPCgnC4Mi1yinTXBWIpK6
         xv0BeOM+5Rt9uA6s+QHvtpwsEQMcXk0bbOOrIRsIgffEqhxPOZ+OHIZ8Uljc0blGrVnn
         SNVA==
X-Gm-Message-State: AOAM530gpdD31l7DqAshOep0y1umlToyyaYx1fWsWP0Krs6gyDEHUR2b
        AdGp+qJEebrTiNkByWbkxXc=
X-Google-Smtp-Source: ABdhPJzFfcms7QZG3J3BosBrXJB8/VT20RwNmsl8TcTNp0i82LyTcqwG7Ll+GJZ2XO2dz4SVTE1wAw==
X-Received: by 2002:aa7:9409:0:b029:142:2501:3989 with SMTP id x9-20020aa794090000b029014225013989mr3380219pfo.78.1600931743490;
        Thu, 24 Sep 2020 00:15:43 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id bx22sm1439120pjb.23.2020.09.24.00.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:15:42 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 398F22037C20D0; Thu, 24 Sep 2020 16:15:40 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 15/21] um: nommu: integrate with irq infrastructure of UML
Date:   Thu, 24 Sep 2020 16:12:55 +0900
Message-Id: <7ec39a8cb91902ff2cdb22f9143f3449f9f9d009.1600922529.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to cooperate with UML's irq infrastructure and nommu threads
based on host threads, irq handlers shall synchronize the our
scheduler which is controlled by struct lkl_cpu.  To do that, the irq
infra notifies its entry of handlers by obtaining cpu access of thread
scheduler (lkl_cpu_try_run_irq) and its release (lkl_cpu_put).

In additon to that, in order to stick the signal handler's thread to the
one of the idle thread, several required configurations of (thread's)
signal mask are added: otherwise handlers running on arbitrary thread
cannot obtain cpu access and immediately fall into pending interrupt
which may slow down the delivery of signals.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/os.h     |  1 +
 arch/um/kernel/irq.c            | 13 +++++++++++++
 arch/um/kernel/time.c           |  2 ++
 arch/um/nommu/include/asm/cpu.h |  3 +++
 arch/um/nommu/um/cpu.c          | 17 ++++++++++++++---
 arch/um/nommu/um/setup.c        |  5 +++++
 arch/um/nommu/um/threads.c      |  3 +++
 tools/um/uml/signal.c           | 12 ++++++++++--
 8 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..0da3ce22e16f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -241,6 +241,7 @@ extern int set_signals(int enable);
 extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
+extern void set_pending_signals(int sig);
 
 /* util.c */
 extern void stack_protections(unsigned long address);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3577118bb4a5..4ce7f5fef7f8 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -19,6 +19,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <irq_user.h>
+#include <asm/cpu.h>
 
 
 extern void free_irqs(void);
@@ -541,6 +542,11 @@ unsigned long to_irq_stack(unsigned long *mask_out)
 	unsigned long mask, old;
 	int nested;
 
+#ifndef CONFIG_MMU
+	if (!nommu_irq_enter(ffs(*mask_out) - 1))
+		return 1;
+#endif
+
 	mask = xchg(&pending_mask, *mask_out);
 	if (mask != 0) {
 		/*
@@ -557,6 +563,10 @@ unsigned long to_irq_stack(unsigned long *mask_out)
 			old |= mask;
 			mask = xchg(&pending_mask, old);
 		} while (mask != old);
+
+#ifndef CONFIG_MMU
+		nommu_irq_exit();
+#endif
 		return 1;
 	}
 
@@ -594,6 +604,9 @@ unsigned long from_irq_stack(int nested)
 	*to = *ti;
 
 	mask = xchg(&pending_mask, 0);
+#ifndef CONFIG_MMU
+	nommu_irq_exit();
+#endif
 	return mask & ~1;
 }
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 25eaa6a0c658..9e141fe8fe27 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -597,11 +597,13 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
+#ifdef CONFIG_MMU
 	if (get_current()->mm != NULL)
 	{
         /* userspace - relay signal, results in correct userspace timers */
 		os_alarm_process(get_current()->mm->context.id.u.pid);
 	}
+#endif
 
 	(*timer_clockevent.event_handler)(&timer_clockevent);
 
diff --git a/arch/um/nommu/include/asm/cpu.h b/arch/um/nommu/include/asm/cpu.h
index c101c078ef21..c52a78c77bea 100644
--- a/arch/um/nommu/include/asm/cpu.h
+++ b/arch/um/nommu/include/asm/cpu.h
@@ -10,4 +10,7 @@ void lkl_cpu_wait_shutdown(void);
 void lkl_cpu_change_owner(lkl_thread_t owner);
 void lkl_cpu_set_irqs_pending(void);
 
+void nommu_irq_exit(void);
+int nommu_irq_enter(int sig);
+
 #endif
diff --git a/arch/um/nommu/um/cpu.c b/arch/um/nommu/um/cpu.c
index 9986a3f8c5dd..75d8bdc1847e 100644
--- a/arch/um/nommu/um/cpu.c
+++ b/arch/um/nommu/um/cpu.c
@@ -8,15 +8,16 @@
 #include <asm/sched.h>
 #include <asm/syscalls.h>
 #include <init.h>
+#include <os.h>
 
 void run_irqs(void)
 {
-	panic("unimplemented %s", __func__);
+	unblock_signals();
 }
 
-int set_irq_pending(int irq)
+void set_irq_pending(int sig)
 {
-	panic("unimplemented %s", __func__);
+	set_pending_signals(sig);
 }
 
 /*
@@ -174,6 +175,16 @@ int lkl_cpu_try_run_irq(int irq)
 	return ret;
 }
 
+int nommu_irq_enter(int sig)
+{
+	return lkl_cpu_try_run_irq(sig);
+}
+
+void nommu_irq_exit(void)
+{
+	return lkl_cpu_put();
+}
+
 static void lkl_cpu_shutdown(void)
 {
 	__sync_fetch_and_add(&cpu.shutdown_gate, MAX_THREADS);
diff --git a/arch/um/nommu/um/setup.c b/arch/um/nommu/um/setup.c
index eaa74d771f73..922188690139 100644
--- a/arch/um/nommu/um/setup.c
+++ b/arch/um/nommu/um/setup.c
@@ -36,6 +36,8 @@ static void __init *lkl_run_kernel(void *arg)
 
 	panic_blink = lkl_panic_blink;
 
+	/* signal should be received at this thread (main and idle threads) */
+	init_new_thread_signals();
 	threads_init();
 	lkl_cpu_get();
 	start_kernel();
@@ -58,6 +60,9 @@ int __init lkl_start_kernel(struct lkl_host_operations *ops,
 	if (ret)
 		goto out_free_init_sem;
 
+	change_sig(SIGALRM, 0);
+	change_sig(SIGIO, 0);
+
 	ret = lkl_ops->thread_create(lkl_run_kernel, NULL);
 	if (!ret) {
 		ret = -ENOMEM;
diff --git a/arch/um/nommu/um/threads.c b/arch/um/nommu/um/threads.c
index 3e70eccc191a..df96057100fd 100644
--- a/arch/um/nommu/um/threads.c
+++ b/arch/um/nommu/um/threads.c
@@ -151,6 +151,9 @@ static void *thread_bootstrap(void *_tba)
 	int (*f)(void *) = tba->f;
 	void *arg = tba->arg;
 
+	change_sig(SIGALRM, 0);
+	change_sig(SIGIO, 0);
+
 	lkl_ops->sem_down(ti->task->thread.arch.sched_sem);
 	kfree(tba);
 	if (ti->task->thread.prev_sched)
diff --git a/tools/um/uml/signal.c b/tools/um/uml/signal.c
index b58bc68cbe64..2b5c98de21cd 100644
--- a/tools/um/uml/signal.c
+++ b/tools/um/uml/signal.c
@@ -218,8 +218,8 @@ void set_handler(int sig)
 
 	sigemptyset(&sig_mask);
 	sigaddset(&sig_mask, sig);
-	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
-		panic("sigprocmask failed - errno = %d\n", errno);
+	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
+		panic("pthread_sigmask failed - errno = %d\n", errno);
 }
 
 int change_sig(int signal, int on)
@@ -355,3 +355,11 @@ int os_is_signal_stack(void)
 
 	return ss.ss_flags & SS_ONSTACK;
 }
+
+void set_pending_signals(int sig)
+{
+	if (sig == SIGIO)
+		signals_pending |= SIGIO_MASK;
+	else if (sig == SIGALRM)
+		signals_pending |= SIGALRM_MASK;
+}
-- 
2.21.0 (Apple Git-122.2)

