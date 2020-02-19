Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B857416480B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSPOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPOS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=s6AiQkSnxphdNF3MST14ep5g9tst2Pr08e6mG1xqIT0=; b=Z6hvT8xCWpFMYzo5eMSZgE5cCk
        8EsUTLh+PoR743f56w9HCrTTHrtZkvqtD7khS/C4pBRIn9IvR7IfFxoqoHSr56HpPKkB8rhBj9vAm
        P0MwjgRDr2hSxva5P8dkUXaeCivk1rHWT8WcnSGWrkqq/W6wWvzDP5llyzAZ6C0oO3aDS96W0aKVc
        VtRyMJunCqwjd4CctAzxEasodjhNR+KTn1jrCrPsfwUPSjy6LmfCpFnia9sxW0Bf635gWUOy06Rej
        ggwfNQx3NxOU5EouiAj+q6Wr/2r3oLEy5Wl4vE96IULxl+W8soiROKGItYoSdBMdiJidfXvTUxeh+
        KY+ArztQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3A-00011L-W1; Wed, 19 Feb 2020 15:14:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EACB4307787;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 854B42B4D7B80; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.888917422@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: [PATCH v3 09/22] sched,rcu,tracing: Avoid tracing before in_nmi() is correct
References: <20200219144724.800607165@infradead.org>
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
 		BUG_ON(in_nmi() == NMI_MASK);			\
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


