Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4D15B29A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgBLVOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 16:14:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLVON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cfSfHywsIy4GHGrttczRnVt4997LxQml8cl0HP/ciiI=; b=cMlmV2zZOoNsqmF2+KF4Bt1uPO
        mSJp/F4LqNXh/S0SGAryDrNzkZ4PS+zS7UMBViWf4G6PFKCkzm9tvdwAll/NwUpp2PrA6bwRxncoB
        x9p0aC/as+5FzJ1PTjkTCLddcjw2ZhtuiKhT/V8qMrDskTIDVQy+DdKXt582yiegamu6kvNZeQ8Hi
        21tGzG+BdxJiFAD/5RJ/dB24BI4mP4SP5P4SOM2lSl3/SCztLs5nGmOg1YRJLRBp2093VUDPNdj5j
        jYpwD3zP1rB5KHdfUHC2YA2/BR3/JMysrtRtSDjoE1GpwUjn+2N5G4T+hEtS3YBsvTodzxbbbKm3O
        9MPc5YWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKK-0002Kj-Jv; Wed, 12 Feb 2020 21:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4646E306012;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 806DE203A8999; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210750.028161469@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: [PATCH v2 4/9] sched,rcu,tracing: Avoid tracing before in_nmi() is correct
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If we call into a tracer before in_nmi() becomes true, the tracer can
no longer detect it is called from NMI context and behave correctly.

Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
as the normal preempt_count_{add,sub}() have a (desired) function
trace entry.

This fixes a potential issue with current code; AFAICT when the
function-tracer has stack-tracing enabled __trace_stack() will
malfunction when it hits the preempt_count_add() function entry from
NMI context.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/hardirq.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -65,6 +65,15 @@ extern void irq_exit(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+/*
+ * NMI vs Tracing
+ * --------------
+ *
+ * We must not land in a tracer until (or after) we've changed preempt_count
+ * such that in_nmi() becomes true. To that effect all NMI C entry points must
+ * be marked 'notrace' and call nmi_enter() as soon as possible.
+ */
+
 #define nmi_enter()						\
 	do {							\
 		arch_nmi_enter();				\
@@ -72,7 +81,7 @@ extern void irq_exit(void);
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi());				\
-		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET); \
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
 	} while (0)
@@ -82,7 +91,7 @@ extern void irq_exit(void);
 		trace_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
-		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET); \
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\


