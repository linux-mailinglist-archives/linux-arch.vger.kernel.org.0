Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A661A165B99
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBTKet (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 05:34:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTKet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 05:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HKt6/QuqsefyaXBGYt8iU89pRbakH3QRmMyWQxstXMM=; b=qfu31yBcYEcO8yaVXfWXV/w2op
        6YXlnCa4XOchCnRmTTQK8OtquM1q9Oaq4/ysovfP+8/gnzBqLkjHYZPCFkIj23iPnPRhv5VOZgHDI
        91HMbU09ScgS62iSfds9clOJ3ArWK7D5bHRTgv1Y7suzfwalRAwaadMdF5SOIOTeufkAVD6fThfa+
        ECH2E/gfoKLYnFft0qMXS+222TC/8sFu0n8tgf78wcJbAWNMToa2rSlXvi0L9qNtbW09r0xs0qP/H
        3PkbNKFHp3x8aiLYJ/HsMx6SK4bRPbD3BQSC0gs/JU45DdZMGOA+3GIbSJP5miicgJi76OqKKj8ci
        DV27kL8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4jA0-0000tq-B0; Thu, 20 Feb 2020 10:34:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9840300606;
        Thu, 20 Feb 2020 11:32:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C0F32B2A8A9F; Thu, 20 Feb 2020 11:34:21 +0100 (CET)
Date:   Thu, 20 Feb 2020 11:34:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200220103421.GV18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
 <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
 <20200219164449.GC2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219164449.GC2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:44:50AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 05:35:35PM +0100, Peter Zijlstra wrote:

> > Possibly, and I suppose the current version is less obviously dependent
> > on the in_nmi() functionality as was the previous, seeing how Paul
> > frobbed that all the way into the rcu_irq_enter*() implementation.
> > 
> > So sure, I can go move it I suppose.
> 
> No objections here.

It now looks like so:

---
Subject: rcu,tracing: Create trace_rcu_{enter,exit}()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Feb 12 09:18:57 CET 2020

To facilitate tracers that need RCU, add some helpers to wrap the
magic required.

The problem is that we can call into tracers (trace events and
function tracing) while RCU isn't watching and this can happen from
any context, including NMI.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rcupdate.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -175,6 +175,35 @@ do { \
 #error "Unknown RCU implementation specified to kernel configuration"
 #endif
 
+/**
+ * trace_rcu_enter - Force RCU to be active, for code that needs RCU readers
+ *
+ * Very similar to RCU_NONIDLE() above.
+ *
+ * Tracing can happen while RCU isn't active yet, for instance in the idle loop
+ * between rcu_idle_enter() and rcu_idle_exit(), or early in exception entry.
+ * RCU will happily ignore any read-side critical sections in this case.
+ *
+ * This function ensures that RCU is aware hereafter and the code can readily
+ * rely on RCU read-side critical sections working as expected.
+ *
+ * This function is NMI safe -- provided in_nmi() is correct and will nest up-to
+ * INT_MAX/2 times.
+ */
+static inline int trace_rcu_enter(void)
+{
+	int state = !rcu_is_watching();
+	if (state)
+		rcu_irq_enter_irqsave();
+	return state;
+}
+
+static inline void trace_rcu_exit(int state)
+{
+	if (state)
+		rcu_irq_exit_irqsave();
+}
+
 /*
  * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
  * are needed for dynamic initialization and destruction of rcu_head
