Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D643915B29B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgBLVOH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 16:14:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLVOF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oJSOIpFP8iNago6vN2/fjjdKRB58K6oZEf8HaaQJENs=; b=jwrF8i5fOWi5LlFaKz50NE3Ckz
        TM97PRuHs98wtuhKAwYFkOmT5LVeOQFRSxUsfGoeTD6WRLABApWQhoUrsGl9PHC1Yjx4YajpOOATh
        5tAt+Cu+9LLLNJ1hKEXeCu+euONoC3JjCk/dab/3KeCSkGCb5K6WboBLTTgmHl1pDAsi3jiy+5rYM
        1gpA+e8HoNX4rh8UrxheCJCbMkut4065Spw/9lJz+XLGkemvOOSmXgbI+CnvM0oVkCk5TvwhSN2Zu
        lUOyFaXPAHMPwZasLzkcS0ituMHAi9ZVHmBlOCSkMaJz2nvVRuIVtevcPepr4EazJVz1vZ8eIEJpo
        LseTO4bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKJ-0001Ao-U7; Wed, 12 Feb 2020 21:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 456E2305803;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7E5DA203A899B; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210749.971717428@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
References: <20200212210139.382424693@infradead.org>
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


