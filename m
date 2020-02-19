Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E26164823
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBSPOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBSPOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=c9ATBN+E5JwyTbRV0yS7l8gPvIrFoBtelm6e5d8k3l0=; b=MF17X275oqucpMUbdnHnI9vn6U
        0B7u7v4hNvLna5MByf8pWhgzalL9a2XWWnE50QJwgh8Y8BGtst6+HtuKsvd3YQJhIMCmHJWas7lrp
        XmQLD5P0lJz8Eb7BAEOuY4l/KF2PU8MFgQ+VxujgacYwZc5rVP2Zna34NHfQvOjWxpiu7LSPnj6hk
        Q/L2jsEv+IGWBOnPP7F8ckIilQ5Z+EtJsryU4RKM6oF4o1MvZ2ySlStrM6RajGMa4m7Hqot7EDwzq
        CmCcYAqZV49qPmdT9rUms1ddEnfDGozs0akL5JpBAT+z5l6cUcqFK0VWisVOTgulA3WhDMHoe6Sk6
        k34IjeHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3A-00011A-7Y; Wed, 19 Feb 2020 15:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFA623077C4;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8DD9C2B4D7B81; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.060958307@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 12/22] tracing: Employ trace_rcu_{enter,exit}()
References: <20200219144724.800607165@infradead.org>
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


