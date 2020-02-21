Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC872167F43
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgBUNvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgBUNu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xEZO8jQiUjD6Cw8Z5SrFWAbKXhwmoT9wPCbHC88J+aM=; b=gGDzdv1RSKknX1ahOL0kXPrLnb
        gWRG2EjxmL/P2gX/LfZvuwpaejSjtwb7i+wUQ0j5AcOhVS855Zq2f4xxPhx3dbzrDNSL1MnJFOB7P
        E+WHebeagImiiuv5bLdiZyxm1ItrLGlTzLCne74p6zwsDL9S+Z5Bbl6XWjNGk/EXZGljx/+u6eHVk
        8dubqAz+tDc5b6Cxgtr+7H2qAPZfjobvXKTq7UcsYFXKiUNNdcrvQScdMtpc+NCn4JIuF/UW/GFwl
        0sIWKN4dhtdKj5JzF678lXHPjm/UH9+VFMu0e+MdukeiAJkwJsx9/iIQV0j2DC9HLX6XJnN40cQpv
        9sTsxtwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0000q9-Ku; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 796DB3077C4;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E37AE29D740AE; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.951340533@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 15/27] tracing: Employ trace_rcu_{enter,exit}()
References: <20200221133416.777099322@infradead.org>
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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2989,24 +2989,11 @@ void __trace_stack(struct trace_array *t
 		   int pc)
 {
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	int rcu_flags;
 
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


