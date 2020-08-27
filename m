Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B4254A94
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH0QVk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgH0QVh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:21:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C28C061264;
        Thu, 27 Aug 2020 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/dLBN4P9+pAErkmLyvSjn/r0UqrOnF/q5iPm2q/+OAs=; b=E2EyvM60kDZCJYRspnXprpFsV8
        60u+SmlSslkOHG6NrVjV9BHT/96jEOQiLXaAPSVQeC4I7trdo4WRBxazyUFDWKBml/rapggo1+RGk
        LXJfpPr/n6SHB3Bh/tXycwXi4ApDJ6Yh9yjQrjzn7vQvtVQFsbejgI8RC+R4SGx1rMV93nd+i5Gul
        tXdf7bOHFFfo4xnvv1Tk3yJAYjkwZmTEgEitdxlvj/fNOtipWDqOC9TUZuVNash2kzTPQeWFKz4UZ
        TJkVRZOlPEnrVGggAgYUesOmpeoBMVdGoE9840nAdmCn2uMQ6HBdzZ67pWT6JB6FDDnFEfyAd+AOT
        Lq1foLxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKe5-0003xo-BN; Thu, 27 Aug 2020 16:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2F0C30753E;
        Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 751922C2868F4; Thu, 27 Aug 2020 18:20:57 +0200 (CEST)
Message-ID: <20200827161754.300260291@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Aug 2020 18:12:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 2/7] sched: Fix try_invoke_on_locked_down_task() semantics
References: <20200827161237.889877377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3006,15 +3006,14 @@ try_to_wake_up(struct task_struct *p, un
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
-		if (task_rq(p) == rq)
+		if (task_rq(p) == rq && rq->curr != p)
 			ret = func(p, arg);
 		rq_unlock(rq, &rf);
 	} else {
@@ -3028,7 +3027,7 @@ bool try_invoke_on_locked_down_task(stru
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 


