Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869E4167F2D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgBUNup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgBUNuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eg1eQJ//SprCAwF+hza1bycJo6HO/QF3v0sPZ8+K7tU=; b=XpDT/kCMxj9tTvG6igVCsumJHI
        kyA08iFApmHLjaKPXYi8IwWXUsdZhpE4AOPPJiKNABnjKv+JKnb96v7snGT0WghcwGwOhpVvUYbEx
        pIsmYdobsP/Z/BMjIFPWzxowqCB8TTJWStci0GA5IyEf+1PopQS5d+cMCaqdZxqru+YOjhJVJGwee
        uXfWO2g3qv7iGmUuf3ILUCPS4b/69Uo30h4GKYBJ9IU2kf+PJEAsOUiQ0LOivK+vuDzegXHwma0jf
        HiJ/0aNDdrMkrg3WgRjLRAZ31D6cLcw7P3Bidh80Hm4L4MIquVeVSFdRIoPwfn+825NPn9DuKn+o5
        pGllJQag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gx-0006VK-0N; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4106307962;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BE12329B59041; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.443368893@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 07/27] rcu: Make RCU IRQ enter/exit functions rely on in_nmi()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
"irq" parameter that indicates whether these functions are invoked from
an irq handler (irq==true) or an NMI handler (irq==false).  However,
recent changes have applied notrace to a few critical functions such
that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
on in_nmi().  Note that in_nmi() works no differently than before,
but rather that tracing is now prohibited in code regions where in_nmi()
would incorrectly report NMI state.

This commit therefore removes the "irq" parameter and inlines
rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
and rcu_nmi_exit(), respectively.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |   45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -614,16 +614,18 @@ void rcu_user_enter(void)
 }
 #endif /* CONFIG_NO_HZ_FULL */
 
-/*
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_exit(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_exit_common(bool irq)
+void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -651,27 +653,16 @@ static __always_inline void rcu_nmi_exit
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
-	if (irq)
+	if (!in_nmi())
 		rcu_prepare_for_idle();
 
 	rcu_dynticks_eqs_enter();
 
-	if (irq)
+	if (!in_nmi())
 		rcu_dynticks_task_enter();
 }
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
- *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void rcu_nmi_exit(void)
-{
-	rcu_nmi_exit_common(false);
-}
-
-/**
  * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
  *
  * Exit from an interrupt handler, which might possibly result in entering
@@ -693,7 +684,7 @@ void rcu_nmi_exit(void)
 void rcu_irq_exit(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit_common(true);
+	rcu_nmi_exit();
 }
 
 /*
@@ -777,7 +768,7 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * rcu_nmi_enter - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
@@ -786,10 +777,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_enter_common(bool irq)
+void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -807,12 +798,12 @@ static __always_inline void rcu_nmi_ente
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
-		if (irq)
+		if (!in_nmi())
 			rcu_dynticks_task_exit();
 
 		rcu_dynticks_eqs_exit();
 
-		if (irq)
+		if (!in_nmi())
 			rcu_cleanup_after_idle();
 
 		incby = 1;
@@ -834,14 +825,6 @@ static __always_inline void rcu_nmi_ente
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
 }
-
-/**
- * rcu_nmi_enter - inform RCU of entry to NMI context
- */
-void rcu_nmi_enter(void)
-{
-	rcu_nmi_enter_common(false);
-}
 NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
@@ -869,7 +852,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
 void rcu_irq_enter(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_enter_common(true);
+	rcu_nmi_enter();
 }
 
 /*


