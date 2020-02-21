Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88531167F15
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgBUNup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgBUNuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pCBX48rd0dWsOjCooJU+RmFl5q+5zrgSeNUcbX25L18=; b=1mbQZVV5PvNkBAKDItLxpSBXNQ
        8An5TepcAXlgELCoeRp8qprMP/+K2CFVKv1RzdRRuKaUr94iGW11YERNA7OLr1vYx7LiF3uV8PKVr
        kwxfz5LUEYx48qVIVMagWCu/AxII6swa5ElqM4NKe2WVlQhYGQHih9AvIfco1bIa9Dbq6Mp/PmE13
        FJ9ygJHM3YcPrg4CXhvacmxnrQyJVS+dRcUMW97Je5R2a25u8DEZ5HANSPcZxn5oj3/9Xa23tDIir
        zG7Pmd0g5pXQGYE+aE3tUqlrn8UeDD5w2Rh6uPmlw9Olzit54HvrvuDCzVYVWm753URGs0C39NrXi
        5D9cEnrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gx-0006VL-0u; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D40EF307961;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C5EB429B59042; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.559644596@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The functions do in fact use local_irq_{save,restore}() and can
therefore be used when IRQs are in fact disabled. Worse, they are
already used in places where IRQs are disabled, leading to great
confusion when reading the code.

Rename them to fix this confusion.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h   |    4 ++--
 include/linux/rcutiny.h    |    4 ++--
 include/linux/rcutree.h    |    4 ++--
 include/linux/tracepoint.h |    4 ++--
 kernel/cpu_pm.c            |    4 ++--
 kernel/rcu/tree.c          |    8 ++++----
 kernel/trace/trace.c       |    4 ++--
 7 files changed, 16 insertions(+), 16 deletions(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -120,9 +120,9 @@ static inline void rcu_init_nohz(void) {
  */
 #define RCU_NONIDLE(a) \
 	do { \
-		rcu_irq_enter_irqson(); \
+		rcu_irq_enter_irqsave(); \
 		do { a; } while (0); \
-		rcu_irq_exit_irqson(); \
+		rcu_irq_exit_irqsave(); \
 	} while (0)
 
 /*
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -68,8 +68,8 @@ static inline int rcu_jiffies_till_stall
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
 static inline void rcu_irq_enter(void) { }
-static inline void rcu_irq_exit_irqson(void) { }
-static inline void rcu_irq_enter_irqson(void) { }
+static inline void rcu_irq_exit_irqsave(void) { }
+static inline void rcu_irq_enter_irqsave(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -46,8 +46,8 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
-void rcu_irq_enter_irqson(void);
-void rcu_irq_exit_irqson(void);
+void rcu_irq_enter_irqsave(void);
+void rcu_irq_exit_irqsave(void);
 
 void exit_rcu(void);
 
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -181,7 +181,7 @@ static inline struct tracepoint *tracepo
 		 */							\
 		if (rcuidle) {						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
+			rcu_irq_enter_irqsave();			\
 		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
@@ -195,7 +195,7 @@ static inline struct tracepoint *tracepo
 		}							\
 									\
 		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
+			rcu_irq_exit_irqsave();				\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -24,10 +24,10 @@ static int cpu_pm_notify(enum cpu_pm_eve
 	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
 	 * RCU know this.
 	 */
-	rcu_irq_enter_irqson();
+	rcu_irq_enter_irqsave();
 	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
-	rcu_irq_exit_irqson();
+	rcu_irq_exit_irqsave();
 
 	return notifier_to_errno(ret);
 }
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -699,10 +699,10 @@ void rcu_irq_exit(void)
 /*
  * Wrapper for rcu_irq_exit() where interrupts are enabled.
  *
- * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
+ * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_exit_irqson(void)
+void rcu_irq_exit_irqsave(void)
 {
 	unsigned long flags;
 
@@ -875,10 +875,10 @@ void rcu_irq_enter(void)
 /*
  * Wrapper for rcu_irq_enter() where interrupts are enabled.
  *
- * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
+ * If you add or remove a call to rcu_irq_enter_irqsave(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_enter_irqson(void)
+void rcu_irq_enter_irqsave(void)
 {
 	unsigned long flags;
 
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3004,9 +3004,9 @@ void __trace_stack(struct trace_array *t
 	if (unlikely(in_nmi()))
 		return;
 
-	rcu_irq_enter_irqson();
+	rcu_irq_enter_irqsave();
 	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
-	rcu_irq_exit_irqson();
+	rcu_irq_exit_irqsave();
 }
 
 /**


