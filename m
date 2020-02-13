Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E373515CAC5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 19:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBMS4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 13:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBMS4O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 13:56:14 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18DB206CC;
        Thu, 13 Feb 2020 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581620174;
        bh=R+Oau6HIHy3Iq+WUBREZwGMoUQW3uxooWNG8mE5vlyk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b1hLF0ZMuSaUZTCOrmYTRaqBZG8ROxQUwpHT5otgJIMdqb/p0EmhGnnjh9VgeoZjf
         LV9Xxpd2iOdLFVmE9+FgjAYtcy5pNtteDkdLofvyVnpsXdBb5w4HiFIEpMvfX66TGc
         pipo9V2C7ogXTQ7ZilWhbQEakpTDvqf6rNdufE+M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 24AAD3520B69; Thu, 13 Feb 2020 10:56:12 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:56:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213185612.GG2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213164031.GH14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 05:40:31PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 05:51:38AM -0800, Paul E. McKenney wrote:
> 
> > The reason for the irq argument is to avoid invoking
> > rcu_prepare_for_idle() and rcu_dynticks_task_enter() from NMI context
> > from rcu_nmi_exit_common().  Similarly, we need to avoid invoking
> > rcu_dynticks_task_exit() and rcu_cleanup_after_idle() from NMI context
> > from rcu_nmi_enter_common().
> 
> Aaah, I see. I didn't grep hard enough earlier today (I only found
> stubs). Yes, those take locks, we mustn't call them from NMI context.

Been there, done that...

> > It might well be that I could make these functions be NMI-safe, but
> > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > So, before looking into that, I have a question.  Given these proposed
> > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > to just use in_nmi()?
> 
> That _should_ already be the case today. That is, if we end up in a
> tracer and in_nmi() is unreliable we're already screwed anyway.

So something like this, then?  This is untested, probably doesn't even
build, and could use some careful review from both Peter and Steve,
at least.  As in the below is the second version of the patch, the first
having been missing a couple of important "!" characters.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1f5fdf7..f783572 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -623,16 +623,18 @@ void rcu_user_enter(void)
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
+static __always_inline void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -660,27 +662,16 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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
@@ -702,7 +693,7 @@ void rcu_nmi_exit(void)
 void rcu_irq_exit(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit_common(true);
+	rcu_nmi_exit();
 }
 
 /*
@@ -786,7 +777,7 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * rcu_nmi_enter - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
@@ -795,10 +786,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_enter_common(bool irq)
+static __always_inline void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -816,12 +807,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
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
@@ -844,14 +835,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
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
@@ -879,7 +862,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
 void rcu_irq_enter(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_enter_common(true);
+	rcu_nmi_enter();
 }
 
 /*
