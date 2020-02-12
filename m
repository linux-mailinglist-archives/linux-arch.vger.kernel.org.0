Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF515A529
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgBLJn5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:43:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgBLJnu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=c9ATBN+E5JwyTbRV0yS7l8gPvIrFoBtelm6e5d8k3l0=; b=nHgILnrhfqE4EKmlTP81/KY0NB
        BvOdoqy26gmIcZ4oj6BTpOgBrJ4oO6C+mrJmlVhJozMPxwZirtwob0niHf19XZd9gaugvrUCzb8I1
        dLZ41mhhlkjmagbPeayOcjEVJ0sEGnUkykF9FlDxao3NQ6UeHV4SQf1o6xwFkIiSWVNWucKDFoSCy
        6NYBTJGV1rhMhZD2SF2Kl3uQMOie7XUsN8qiMLuwZZRuQ7BEKxcnv/HTlabAuYGyQbXWyfV4PywJc
        TYkx8Oa5ULlVn4xanxIAKrca4o9NIpDMikJVUu9Hk3aYnm7tEdf7ZRpdsUs8mRuEg6LOctsK5xJ6O
        3fwBDwhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYH-0006Ay-My; Wed, 12 Feb 2020 09:43:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22A7B30783F;
        Wed, 12 Feb 2020 10:41:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 612762B9154FA; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212094108.007700525@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 7/8] tracing: Employ trace_rcu_{enter,exit}()
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the opencoded (and incomplete) RCU manipulations with the new
helpers to ensure a regular RCU context when calling into
__ftrace_trace_stack().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2989,24 +2989,11 @@ void __trace_stack(struct trace_array *t
 		   int pc)
 {
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	unsigned long rcu_flags;
 
-	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
-		return;
-	}
-
-	/*
-	 * When an NMI triggers, RCU is enabled via rcu_nmi_enter(),
-	 * but if the above rcu_is_watching() failed, then the NMI
-	 * triggered someplace critical, and rcu_irq_enter() should
-	 * not be called from NMI.
-	 */
-	if (unlikely(in_nmi()))
-		return;
-
-	rcu_irq_enter_irqsave();
+	rcu_flags = trace_rcu_enter();
 	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
-	rcu_irq_exit_irqsave();
+	trace_rcu_exit(rcu_flags);
 }
 
 /**


