Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD90D15A526
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgBLJnv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:43:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59346 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgBLJnv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oJSOIpFP8iNago6vN2/fjjdKRB58K6oZEf8HaaQJENs=; b=W+embj81hKRh1yJ3gO1YoG/5M9
        p0Ug4A+T8ertR3DQT5K1iCUxk/DSCl+u63yEeV0IbZvPxZN4NMmnA1CPqLBYjrPVM3Pv0A+Zm1Z/e
        vRO5yFhHWglp5L0uxN3nWwNU+YSq0VlemQsmVzm4Z0HXPSPGX//82ihGn+bC/Yuo8xftTFVUy7NIk
        4U73/U4cx4qqo6Wyg/77IZpVqlstUxhjmQgA5RHLhkznsFc3ZIm+gMivWPJd/surX2O69hvs02sFu
        H/jPyEYW7KmvhgajjgAIlI7guLwv9xyV9wySXTwzft0j77fT9Ao06GVCP7x7JHknsoXGpg9erZMrD
        /3WlR9Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYH-0006Ax-Ll; Wed, 12 Feb 2020 09:43:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D4063077E1;
        Wed, 12 Feb 2020 10:41:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 543BA2B9154EC; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212094107.781220598@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 3/8] rcu,tracing: Create trace_rcu_{enter,exit}()
References: <20200212093210.468391728@infradead.org>
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
 include/linux/hardirq.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -89,4 +89,52 @@ extern void irq_exit(void);
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
+#define __TR_IRQ	1
+#define __TR_NMI	2
+
+#define trace_rcu_enter()					\
+({								\
+	unsigned long state = 0;				\
+	if (!rcu_is_watching())	{				\
+		if (in_nmi()) {					\
+			state = __TR_NMI;			\
+			rcu_nmi_enter();			\
+		} else {					\
+			state = __TR_IRQ;			\
+			rcu_irq_enter_irqsave();		\
+		}						\
+	}							\
+	state;							\
+})
+
+#define trace_rcu_exit(state)					\
+do {								\
+	switch (state) {					\
+	case __TR_IRQ:						\
+		rcu_irq_exit_irqsave();				\
+		break;						\
+	case __TR_NMI:						\
+		rcu_nmi_exit();					\
+		break;						\
+	default:						\
+		break;						\
+	}							\
+} while (0)
+
 #endif /* LINUX_HARDIRQ_H */


