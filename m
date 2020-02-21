Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08D4167F3A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgBUNvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgBUNui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eb9IIA3CR0LweOzY8oDNQhcAxSg7moC5djB9xFdbk5k=; b=OYZaO5jXikb4ReQbFnoWq8tvyp
        VCy7BYr8IXGYHDKPFpdKZT7h+xcXxx8JNI8OhLtC9Q2GNsg9+KqGXoS62//4wECx6AOQ0z7+HdTxE
        dYdjD+KakzpGA2CtYEzeezIvcp/Rese5pOvbSd34VPenJ9BgkX/WJWiF/+W3ozgmZ5+3hPe1pSt75
        XFS/pN4XvWJzD/EtTc5M2v5Q1Wh3TY/6T3OaD2tCROatXBeCpDslsPcFgbYUovbXhn99nMB5kYC3R
        MppP4fyWVnR8RJOFkvMu4VNZwMbcH/VUwYXJo3v6nqjGMwP7d1SNW7PSUQyOhqT8ckLC0S9c5YmVa
        ktFTqB8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gx-0006VQ-Fk; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D40CE307960;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C394F29B59043; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.501225981@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 08/27] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

It's confusing that rcu_nmi_enter() is marked NOKPROBE and
rcu_nmi_exit() is not. One may think that the exit needs to be marked
for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
state back to what it was before rcu_nmi_enter(). But the reason has
nothing to do with the state of RCU.

The breakpoint handler (int3 on x86) must not have any kprobe on it
until the kprobe handler is called. Otherwise, it can cause an infinite
recursion and crash the machine. It just so happens that
rcu_nmi_enter() is called by the int3 handler before the kprobe handler
can run, and therefore needs to be marked as NOKPROBE.

Comment this to remove the confusion to why rcu_nmi_enter() is marked
NOKPROBE but rcu_nmi_exit() is not.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
---
 kernel/rcu/tree.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -825,6 +825,14 @@ void rcu_nmi_enter(void)
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
 }
+/*
+ * All functions called in the breakpoint trap handler (e.g. do_int3()
+ * on x86), must not allow kprobes until the kprobe breakpoint handler
+ * is called, otherwise it can cause an infinite recursion.
+ * On some archs, rcu_nmi_enter() is called in the breakpoint handler
+ * before the kprobe breakpoint handler is called, thus it must be
+ * marked as NOKPROBE.
+ */
 NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**


