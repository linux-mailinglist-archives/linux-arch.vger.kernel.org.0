Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905FC167F09
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgBUNu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgBUNu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=miiUwvGe7i5BsZI6va27ZyF936XFY9N6YVcmqFdnF/Y=; b=jWFGtaYv2V0pC7pTzGl1XeRhwG
        myEcI9lpltXEpdmZUb8MIGR8X5gP+f3Juu6uG+1jHInIeBvNfiJlL6VEN1hpZeSti6NLsX6tlYwGj
        s0FTmHq91WNU6o21CeHWhNd0eqbMMxB9SKlNWois0BTYwDDTAOdgc6c/RTBCWIsmib0CnoVe+itOG
        soIQiG8Pfj8fm3jH6ZGcWE9LLMiT9eCUjtkOR2HRTQ0azwldmvOCjXvAFlOIdwEuaL8/BQNEYpJvY
        VQAh4uMP/s5Y+Xkxmr+C9xFbZ2dAETvIDwcVY0c7EX5GgYQoRtRMl8oXI8qaQPZHH+FklFEtEsEj/
        0tNmQf+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0000xu-DE; Fri, 21 Feb 2020 13:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7967D307787;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBA9A29D740AF; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134216.051596115@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 16/27] tracing: Remove regular RCU context for _rcuidle tracepoints (again)
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
taught perf how to deal with not having an RCU context provided.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqsave();			\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqsave();				\
+		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)


