Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD4167F2B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgBUNup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45602 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgBUNuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/oBPWrG9EVgl4LEO/hSDsTUt0NUc1tA6jTJTcYoVfdU=; b=PaY6ochsF4feFxMwxw77EnuxG4
        ePLoFLkPUSqGnW74ZKku4GaY12DLLQV38XpZsuR9dIFSGVvCWVPSFP3M9DNH+cCjceXo9zxbi4A1Y
        UFYeyn3iTYR6dWbt0pneGRGM594mIYFILE2I7bBN3l4Cg3a7nYXDq6dN4HwdGGymSlxL6A++BZbCD
        eAQKG1mw44Tt+k8otV6a8ra2A5o/nn7+SICpB6WJFms8+twhWjhBDpLlvrZKJ+8Hn3EM3uQkT3cn0
        dKI6Oi1gVwCYi+Wi0dj3QXaZ3pRRZ2tmIu6JiUJ22Vm58IxrIgIU5wrQkRZwUrDunS8l1Za3wIPNE
        7cUMyxLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0006V7-2D; Fri, 21 Feb 2020 13:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D4F73077E6;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F3E2829D740B0; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134216.151419321@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 17/27] perf,tracing: Allow function tracing when !RCU
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since perf is now able to deal with !rcu_is_watching() contexts,
remove the restraint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_event_perf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -477,7 +477,7 @@ static int perf_ftrace_function_register
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->flags   = FTRACE_OPS_FL_RCU;
+	ops->flags   = 0;
 	ops->func    = perf_ftrace_function_call;
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 


