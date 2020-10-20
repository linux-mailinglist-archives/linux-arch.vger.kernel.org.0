Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF00284994
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFJp5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFJp4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A4C0613D1
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so1286516pjb.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0xMiLkPJtWHIFGoHWeokK9tDlZx4lNx6V5goDL8fYI=;
        b=Ki9f3/1fgUxaaHIAAkeCHin2NP5fERX8KuQucuCDkuUfNqM9CbNx66lBt6JsECSzAY
         5oXJOGMzqwaFvaX8qXt40Jki9DR4zxNHSJUMetKn4OcTBls8A/fQZHsIsFO5qa4J/zqA
         R2JFTYsX15rrqPv2FCvtjD/w5hXKzpAr1+VN0yMfq0EnFYkgNKchys4qfgwXdBBqbYvP
         kjKJTQKl0ExCBhIbpeyCOb66ukhuPfH6XfTaxV4V/mjYNyDtZr/pIPINTOISn2s47yBy
         vc6q4/xVEsh68fZbq18ESohJox+1NqsyyokU0tYsgDgTiqzPcY/lT4d1ZQGNvpjyXfg7
         Qyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0xMiLkPJtWHIFGoHWeokK9tDlZx4lNx6V5goDL8fYI=;
        b=nHaykPhp+3Vwpl8DWQpqITTzLKrfSvQmRMe4z7lPxiQsQvgxr3O8cRzUxuIkY8VIis
         XE5zoLY4Rx1kCvGQI9nN+Fg8YQB7OTrrCUXJN1cOewUoPACXI6gbpaCI4zeGrFHfKKZ3
         36fAuSFz2+Sw8oMbqMshHQNU1BDmhdd87SscOrOhtb/47yDlW6D5phQxMSFcVq4h2+gS
         MVho2jJsdA3Bh7lc4N357KLYyud4bZYoXx+yZQT1pFlvq/6lY+umwYVlKnuyiNwx+JxS
         GVtSH05TXrBTFU6PTfEr0cY5OGPC/cR8zpBG0Ax4YBS1C7jP26pRviV5OeoB7uQqTF32
         uzrQ==
X-Gm-Message-State: AOAM532UsyxS9rtl+gBtOTlMEG6M90eSF7cu0CsYJ79iaHPrhYLvT6S8
        I5SCEb3FO2wvIR+keOOFM5M=
X-Google-Smtp-Source: ABdhPJx6mPff2Z8ScSRZIEYaxFl7LYKBYIafQ3KuGKfLRssEoRqg/Cx92qs1rnrYfK4lcAoXu5akWQ==
X-Received: by 2002:a17:902:d896:b029:d2:288e:bafc with SMTP id b22-20020a170902d896b02900d2288ebafcmr2510737plz.43.1601977555957;
        Tue, 06 Oct 2020 02:45:55 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id f12sm2557902pjm.5.2020.10.06.02.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:55 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 6410C20390F4FF; Tue,  6 Oct 2020 18:45:53 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 15/21] um: nommu: integrate with irq infrastructure of UML
Date:   Tue,  6 Oct 2020 18:44:24 +0900
Message-Id: <68b53edd5ec17510626ae19546752cde198ecc3e.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
index e9a49100d40e..fe2fa3e688fd 100644
--- a/arch/um/nommu/um/threads.c
+++ b/arch/um/nommu/um/threads.c
@@ -152,6 +152,9 @@ static void *thread_bootstrap(void *_tba)
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

