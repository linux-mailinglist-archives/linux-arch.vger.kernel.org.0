Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF27515B299
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 22:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgBLVO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 16:14:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgBLVOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MtLsQLaXADO+AZHxVktK/gN+oXBYn0ymRHkx9dI1F3k=; b=Uz44U9t2iYCgfqgExOEiwrMeZI
        6X9awiCu6DPIxtRsoIZDg5DpXXWXhTgnZSLFJzVOgoLdAH1B/OO56E3L9k0zdDSWsk7emmdtdZY9B
        n9GUqKnH95dALIQ9zbbDajTwE0zsfP+SYYIFwV8nvlA1iXQ93QndsMU67hlIw1ZpvGryDWcNKlV3/
        P+0CLRWtSxvzTG1KjdEKjjd44iJTfyLh3t7fbMYm/HelHc9Lb4L9tEl5R7/8bZAvweireWH9dB0VZ
        Qx0yzGUMnIQ5cax1GYYxeR0h+k+MPJ5ftVtpUDGTPu3BuiFleMweLTlTXla1iCHZJdiLqDAFoFLFs
        70+Gu7uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKK-0002Ki-Jn; Wed, 12 Feb 2020 21:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1C2630700B;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 875D8203A89A0; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210750.142334759@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface for RCU changes
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The tracepoint interface will stop providing regular RCU context; make
sure we do it ourselves, since perf makes use of regular RCU protected
data.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	unsigned long rcu_flags;
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
 
+	rcu_flags = trace_rcu_enter();
+
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
@@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
 	}
 
 	perf_swevent_put_recursion_context(rctx);
+
+	trace_rcu_exit(rcu_flags);
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 


