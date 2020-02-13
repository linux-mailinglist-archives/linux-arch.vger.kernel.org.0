Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10A15CC80
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBMUor (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 15:44:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46697 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgBMUor (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 15:44:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so6546594qkh.13
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 12:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGZL8B9m+ilzkwsOKl6SOln5HHutKWEkvqhf7ivBJIk=;
        b=F3ayNW2NSkM7HnQx4BHPDF7z8ooTocTXqD69VRWsE57xogHS/BREYNTBVqHY7H3a87
         UOGnaUaHBjVdApHKjDldpUB8YE9IsS0nv9qubkI7dS8wxE6FLTB6XBGmDcS77vGZzBEl
         7SRdTDE06ObZfpOfFFjhMbKqN1psy2ioRSZ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGZL8B9m+ilzkwsOKl6SOln5HHutKWEkvqhf7ivBJIk=;
        b=t0y3j11ssQVoIGldyKnfgBr43VzsfTHapcc7FM7B1f00q63kD7ZAGbF01LvLOb9Jm9
         ZJ1NIWfRaqWSYcZAyHlNPSEjytB6Sl4X3L2DIcttG49RpJLry3GXP+Wexpu8XqYDLe2a
         Kw9XIeXtw5udwcn50c0W740mRoJ8Q/BU5LjoGNbdMVnzUlO3mzvTA9UYDjmJzro7yStE
         yh0vUbIN5obu0Da2T1H0a/BIyYQSniL6HNHddUWkKytTJ4VBNUdCOYDw/kZVFBFI7JoH
         CZT+y6R8tfG3TgIfr8ZvQ7UMtb0rEnSQwYPY7rTFyPMQaDAwEBp/BMH4zQba8k8dvdGy
         kD9g==
X-Gm-Message-State: APjAAAUVznpSxho0Q6ARpAx+QmonweifCk+sqsn66U/Gk4pOy2R9Up9b
        sBNHtQaVLWogY2Dk/rbRMSaMQA==
X-Google-Smtp-Source: APXvYqwv98+xg9XT2ijvAzhSUJJszIibPsO7J7uiDNP2L+pssDhPUOKi/8BDl76wt/Tko/xF9nB/WQ==
X-Received: by 2002:a37:6858:: with SMTP id d85mr49814qkc.286.1581626685614;
        Thu, 13 Feb 2020 12:44:45 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x41sm2183809qtj.52.2020.02.13.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:44:44 -0800 (PST)
Date:   Thu, 13 Feb 2020 15:44:44 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213204444.GA94647@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213185612.GG2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
[...] 
> > > It might well be that I could make these functions be NMI-safe, but
> > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > So, before looking into that, I have a question.  Given these proposed
> > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > to just use in_nmi()?
> > 
> > That _should_ already be the case today. That is, if we end up in a
> > tracer and in_nmi() is unreliable we're already screwed anyway.
> 
> So something like this, then?  This is untested, probably doesn't even
> build, and could use some careful review from both Peter and Steve,
> at least.  As in the below is the second version of the patch, the first
> having been missing a couple of important "!" characters.

I removed the static from rcu_nmi_enter()/exit() as it is called from
outside, that makes it build now. Updated below is Paul's diff. I also added
NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
asymmetric.

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2e..bbcc7767f18ee 100644
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
+__always_inline void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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
-
-/**
- * rcu_nmi_exit - inform RCU of exit from NMI context
- *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void rcu_nmi_exit(void)
-{
-	rcu_nmi_exit_common(false);
-}
+NOKPROBE_SYMBOL(rcu_nmi_exit);
 
 /**
  * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
@@ -693,7 +685,7 @@ void rcu_nmi_exit(void)
 void rcu_irq_exit(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit_common(true);
+	rcu_nmi_exit();
 }
 
 /*
@@ -777,7 +769,7 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * rcu_nmi_enter - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
@@ -786,10 +778,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_enter_common(bool irq)
+__always_inline void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -807,12 +799,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
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
@@ -834,14 +826,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
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
@@ -869,7 +853,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
 void rcu_irq_enter(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_enter_common(true);
+	rcu_nmi_enter();
 }
 
 /*
