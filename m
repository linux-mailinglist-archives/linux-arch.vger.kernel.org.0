Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B75164812
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBSPO2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2+57Zr+TG6np5KagGUk/QFz65YscGCIQTCJ7Ievnq5M=; b=aMtNQvnoCkRIzy+ixUKVB1gzfe
        fdHr7Aef5gVkJwxdNXd0h3VnVHpneVwcETaTEsialBXDXz56uh9DdspDdNZK05pOazux8XIhLorqQ
        TOUA1RwYlYTx6tor1ZnJrWDg9zoCOchTtuP+36YPPcSqKRsyHmM37dmhSEs4Y4jPRDEK8raPxaDJz
        Rp6yoKR6dP76iJgplW+6h75Fp71INazKUP+33O76cVQnRPiNjF4wum3PdN+I3A1wlJDp3nzE2Ex4a
        pW4JFK36QT3f//+mlE0AHRBa7uy7et1sZUKaZKcMDwHes8xbNxP1XFxil/ol4caYDdIdVak1TKZ8d
        8kIzjwfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R39-000113-DF; Wed, 19 Feb 2020 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E200E3074D4;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8098C29E09C1C; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.832297480@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
References: <20200219144724.800607165@infradead.org>
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

It is this latter that is causing most of the trouble; we must make
sure in_nmi() returns true before we land in anything tracing,
otherwise we cannot recover.

These helpers are macros because of header-hell; they're placed here
because of the proximity to nmi_{enter,exit{().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/hardirq.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -89,4 +89,36 @@ extern void irq_exit(void);
 		arch_nmi_exit();				\
 	} while (0)
 
+/*
+ * Tracing vs RCU
+ * --------------
+ *
+ * tracepoints and function-tracing can happen when RCU isn't watching (idle,
+ * or early IRQ/NMI entry).
+ *
+ * When it happens during idle or early during IRQ entry, tracing will have
+ * to inform RCU that it ought to pay attention, this is done by calling
+ * rcu_irq_enter_irqsave().
+ *
+ * On NMI entry, we must be very careful that tracing only happens after we've
+ * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
+ * the special path.
+ */
+
+#define trace_rcu_enter()					\
+({								\
+	unsigned long state = 0;				\
+	if (!rcu_is_watching())	{				\
+		rcu_irq_enter_irqsave();			\
+		state = 1;					\
+	}							\
+	state;							\
+})
+
+#define trace_rcu_exit(state)					\
+do {								\
+	if (state)						\
+		rcu_irq_exit_irqsave();				\
+} while (0)
+
 #endif /* LINUX_HARDIRQ_H */


