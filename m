Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38C167F26
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBUNuj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgBUNui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4ftWpOmadAOI/R1k36uM0sOzlPG8YKuw4enMq9FixWQ=; b=FcHHQ2Za0ZHjLasjlAB4tJcaOc
        B1KapfQ55WVx7k9On26pIvP2VetAPCfgz8RApbRSm2MujQM7r6J+GABxkqPvNP+1844FOXJrDgJcZ
        MOzCiVFkqw/jA1aZOZMI/KIhIMYnsWsCUpDPVT5eNYq2PN6nbOrdPBTZ3fEnjV6gYxoP3OGJaLyBv
        1CLQ27N5vEsWM9VY/rjB3RZew+Oz9PNtXHZfQ+bJVa/9N6ceCno3m44vfbwLM90sCj7m7mUZh9Ga4
        pGiHn6eXlgk/kmybof1YjZYwK65Ze0lrlq+ERQim937Jx1XXgr9vpJ4zJNwrQfI/f27RAqTV0GxF2
        xogcI4sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0006V0-4T; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 468E53070F9;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC15A29B59040; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.385886177@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 06/27] x86/doublefault: Remove memmove() call
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use of memmove() in #DF is problematic when you consider tracing and
other instrumentation.

Remove the memmove() call and simply write out what need doing; Boris
argues the ranges should not overlap.

Survives selftests/x86, specifically sigreturn_64.

(Andy ?!)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200220121727.GB507@zn.tnic
---
 arch/x86/kernel/traps.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -278,6 +278,7 @@ dotraplinkage void do_double_fault(struc
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *p = (unsigned long *)regs->sp;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -285,7 +286,11 @@ dotraplinkage void do_double_fault(struc
 		 * in gpregs->ss through gpregs->ip.
 		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		gpregs->ip	= p[0];
+		gpregs->cs	= p[1];
+		gpregs->flags	= p[2];
+		gpregs->sp	= p[3];
+		gpregs->ss	= p[4];
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*


