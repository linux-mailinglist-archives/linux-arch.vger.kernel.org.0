Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2237167F16
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgBUNuq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgBUNup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JKOAemZACsIb8BTdjEUCCm2Q107708cmgzXhN3uutPE=; b=pk7215bwx0FlNG8FbKMJBSd0PE
        tKGrEQ+BYL9OZOOzwJTNk7Ofz9dzezuRQCgAOa90UOVTPiA3+FoJQU7VhKyDfTPkT6xdZPAoS80Ga
        tcaUaRJPooal7EhjIcdIAtXDgMkl1dd6vn0LDBAS3soXQtrMLnY0uRNMSPubv3H4JmZ37KusSM+Pt
        GTNciTJt3Wjf8jZBp2VCIhMAhgYWMg4kFAsjWj4xEIv5jGKg+b6L62Q9Jv/XsYpu8uxBY0B0+cDoG
        akpavs8N/yTKi+nGc9foWgRhupZt0Uj0/CTCi1sx5XQ8utk88Z6qYrqbJX2j47TReyDn/SDKvj1Jx
        MUITpoDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0006Uy-43; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 695113072A3;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CF79A29D740AA; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.673793889@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 11/27] rcu,tracing: Create trace_rcu_{enter,exit}()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To facilitate tracers that need RCU, add some helpers to wrap the
magic required.

The problem is that we can call into tracers (trace events and
function tracing) while RCU isn't watching and this can happen from
any context, including NMI.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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


