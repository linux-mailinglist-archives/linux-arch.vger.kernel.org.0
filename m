Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E412FC909
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhATDbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732072AbhATC34 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA75C0613ED
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id o20so5154584pfu.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iR0rH4noiY0NrQInQIw7FL2wGYYI8flSm7RU9FhIUpo=;
        b=q8U6v/ANEMoDMJXIBR48Izh3z+6DE9vJ6b6dcV1V+bEZrbw2doMG2iKOFd5Z+jIYL4
         b4JEG/9i4ACMPv/a8+gpRclJ01ASb1FbwrfZ9773LbbXlNTm/7V3khymJB6y1GsiYo6a
         BLnQUticTguurof5aOnOKobRjJeXAMCiXJlUuymHMcN00nGYyKW7AJ4bdnmCeadq0x0x
         Dk9IvzgS9d2snc+Q8sZj7h/Wgh8GMsFiiuttkFQ64bqULqOErKoKNxOCG1abn8bqqmnY
         QL4c2uVBREKQC7+KDDB4bse1lV11nOAyKMi4O72XLEKZU9VfAALnbxtBsmwaYtHStsUe
         cADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iR0rH4noiY0NrQInQIw7FL2wGYYI8flSm7RU9FhIUpo=;
        b=MKTMaD6Yrbb33dHeTaqjX8VRziKXD8/GW0tINr+uQ8JlX9ZzldmSLDIgA9PXJjlvmk
         tAIRliEvOcae1+CTXW8E9uHVBZw9Mfya+uB39OP/rFe5K3CXe5L0cdRWJi1TxZgfIA9A
         TNqPL8OZ3nwcG8TMhetWr8y64dP3Jd7JY2M3SPgslYXuL+cJ9OBp3WsXcra8ngnFVyzr
         NLqa6CCgSt9YHo3iD9WdEstIN4B5p7ibDo89VI1x9aMO4Ge70WJZLteq1mlPs7bZ9DAr
         4x0EhkX34HIfqizENawHTMalbdgIyyXvVII31DHdeJtQ/rTKtYYVcvI57+Ic3tOMq3WT
         7m4A==
X-Gm-Message-State: AOAM533pS0rZPylXhfnWZSfMPMi3mfizCY3cHmJDJ7v6KykoEVMZjNuV
        KiUo3kMDZGWirgIqxeJMxeg=
X-Google-Smtp-Source: ABdhPJxyA5+KbuR9GNUH7RykKIikQ4XzaML136l9WfqFzzuO9hiL+74MzJ8PmIksu1l1tlbIfU2beA==
X-Received: by 2002:a63:e101:: with SMTP id z1mr7243500pgh.190.1611109755902;
        Tue, 19 Jan 2021 18:29:15 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id b1sm249548pjh.54.2021.01.19.18.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:15 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 5BDC020442D3B0; Wed, 20 Jan 2021 11:29:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
Date:   Wed, 20 Jan 2021 11:27:18 +0900
Message-Id: <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to cooperate with UML's irq infrastructure and LKL threads
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
 arch/um/include/shared/os.h   |  1 +
 arch/um/kernel/irq.c          | 13 ++++++++++
 arch/um/kernel/time.c         |  2 ++
 arch/um/lkl/include/asm/cpu.h |  4 +++
 arch/um/lkl/um/cpu.c          | 46 +++++++++++++++++++++++++++++++++++
 arch/um/lkl/um/setup.c        |  5 ++++
 arch/um/lkl/um/threads.c      |  3 +++
 tools/um/uml/signal.c         | 12 +++++++--
 8 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 13d86f94cf0f..cd8583e4df12 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -243,6 +243,7 @@ extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
 extern void register_pm_wake_signal(void);
+extern void set_pending_signals(int sig);
 
 /* util.c */
 extern void stack_protections(unsigned long address);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3741d2380060..d632156b52ac 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -21,6 +21,7 @@
 #include <irq_user.h>
 #include <irq_kern.h>
 #include <as-layout.h>
+#include <asm/cpu.h>
 
 
 extern void free_irqs(void);
@@ -563,6 +564,11 @@ unsigned long to_irq_stack(unsigned long *mask_out)
 	unsigned long mask, old;
 	int nested;
 
+#ifdef CONFIG_UMMODE_LIB
+	if (!lkl_irq_enter(ffs(*mask_out) - 1))
+		return 1;
+#endif
+
 	mask = xchg(&pending_mask, *mask_out);
 	if (mask != 0) {
 		/*
@@ -579,6 +585,10 @@ unsigned long to_irq_stack(unsigned long *mask_out)
 			old |= mask;
 			mask = xchg(&pending_mask, old);
 		} while (mask != old);
+
+#ifdef CONFIG_UMMODE_LIB
+		lkl_irq_exit();
+#endif
 		return 1;
 	}
 
@@ -616,6 +626,9 @@ unsigned long from_irq_stack(int nested)
 	*to = *ti;
 
 	mask = xchg(&pending_mask, 0);
+#ifdef CONFIG_UMMODE_LIB
+	lkl_irq_exit();
+#endif
 	return mask & ~1;
 }
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index f4db89b5b5a6..07d705ec5193 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -659,11 +659,13 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
+#ifndef CONFIG_UMMODE_LIB
 	if (get_current()->mm != NULL)
 	{
         /* userspace - relay signal, results in correct userspace timers */
 		os_alarm_process(get_current()->mm->context.id.u.pid);
 	}
+#endif
 
 	(*timer_clockevent.event_handler)(&timer_clockevent);
 
diff --git a/arch/um/lkl/include/asm/cpu.h b/arch/um/lkl/include/asm/cpu.h
index c1164187151e..b241b5bbdc53 100644
--- a/arch/um/lkl/include/asm/cpu.h
+++ b/arch/um/lkl/include/asm/cpu.h
@@ -8,4 +8,8 @@ int lkl_cpu_init(void);
 void lkl_cpu_wait_shutdown(void);
 void lkl_cpu_change_owner(lkl_thread_t owner);
 
+int lkl_cpu_try_run_irq(int irq);
+void lkl_irq_exit(void);
+int lkl_irq_enter(int sig);
+
 #endif
diff --git a/arch/um/lkl/um/cpu.c b/arch/um/lkl/um/cpu.c
index 75452b28d741..841c7e9cc881 100644
--- a/arch/um/lkl/um/cpu.c
+++ b/arch/um/lkl/um/cpu.c
@@ -8,6 +8,7 @@
 #include <asm/sched.h>
 #include <asm/syscalls.h>
 #include <init.h>
+#include <os.h>
 
 /*
  * This structure is used to get access to the "LKL CPU" that allows us to run
@@ -41,6 +42,7 @@ static struct lkl_cpu {
 	 */
 	#define MAX_THREADS 1000000
 	unsigned int shutdown_gate;
+	bool irqs_pending;
 	/* no of threads waiting the CPU */
 	unsigned int sleepers;
 	/* no of times the current thread got the CPU */
@@ -53,6 +55,16 @@ static struct lkl_cpu {
 	struct lkl_sem *shutdown_sem;
 } cpu;
 
+static void run_irqs(void)
+{
+	unblock_signals();
+}
+
+static void set_irq_pending(int sig)
+{
+	set_pending_signals(sig);
+}
+
 /*
  * internal routine to acquire LKL CPU's lock
  */
@@ -132,6 +144,16 @@ void lkl_cpu_put(void)
 	    !lkl_thread_equal(cpu.owner, lkl_thread_self()))
 		lkl_bug("%s: unbalanced put\n", __func__);
 
+	/* we're going to trigger irq handlers if there are any pending
+	 * interrupts, and not irq_disabled.
+	 */
+	while (cpu.irqs_pending && !irqs_disabled()) {
+		cpu.irqs_pending = false;
+		lkl_mutex_unlock(cpu.lock);
+		run_irqs();
+		lkl_mutex_lock(cpu.lock);
+	}
+
 	/* switch to userspace code if current is host task (TIF_HOST_THREAD),
 	 * AND, there are other running tasks.
 	 */
@@ -163,6 +185,30 @@ void lkl_cpu_put(void)
 	lkl_mutex_unlock(cpu.lock);
 }
 
+int lkl_cpu_try_run_irq(int irq)
+{
+	int ret;
+
+	ret = __cpu_try_get_lock(1);
+	if (!ret) {
+		set_irq_pending(irq);
+		cpu.irqs_pending = true;
+	}
+	__cpu_try_get_unlock(ret, 1);
+
+	return ret;
+}
+
+int lkl_irq_enter(int sig)
+{
+	return lkl_cpu_try_run_irq(sig);
+}
+
+void lkl_irq_exit(void)
+{
+	return lkl_cpu_put();
+}
+
 static void lkl_cpu_shutdown(void)
 {
 	__sync_fetch_and_add(&cpu.shutdown_gate, MAX_THREADS);
diff --git a/arch/um/lkl/um/setup.c b/arch/um/lkl/um/setup.c
index ba8338d4fc23..12b235826573 100644
--- a/arch/um/lkl/um/setup.c
+++ b/arch/um/lkl/um/setup.c
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
 	ret = lkl_thread_create(lkl_run_kernel, NULL);
 	if (!ret) {
 		ret = -ENOMEM;
diff --git a/arch/um/lkl/um/threads.c b/arch/um/lkl/um/threads.c
index 7ef9b9f2a6b7..c7ff578b7a91 100644
--- a/arch/um/lkl/um/threads.c
+++ b/arch/um/lkl/um/threads.c
@@ -152,6 +152,9 @@ static void *thread_bootstrap(void *_tba)
 	int (*f)(void *) = tba->f;
 	void *arg = tba->arg;
 
+	change_sig(SIGALRM, 0);
+	change_sig(SIGIO, 0);
+
 	lkl_sem_down(ti->task->thread.arch.sched_sem);
 	kfree(tba);
 	if (ti->task->thread.prev_sched)
diff --git a/tools/um/uml/signal.c b/tools/um/uml/signal.c
index 96f511d1aabe..de04b0dd34bb 100644
--- a/tools/um/uml/signal.c
+++ b/tools/um/uml/signal.c
@@ -230,8 +230,8 @@ void set_handler(int sig)
 
 	sigemptyset(&sig_mask);
 	sigaddset(&sig_mask, sig);
-	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
-		panic("sigprocmask failed - errno = %d\n", errno);
+	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
+		panic("pthread_sigmask failed - errno = %d\n", errno);
 }
 
 void send_sigio_to_self(void)
@@ -375,3 +375,11 @@ int os_is_signal_stack(void)
 
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

