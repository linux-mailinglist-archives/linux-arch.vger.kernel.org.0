Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1C164929
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSPui (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBSPuh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:50:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C5C2465D;
        Wed, 19 Feb 2020 15:50:35 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:50:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: Re: [PATCH v3 09/22] sched,rcu,tracing: Avoid tracing before
 in_nmi() is correct
Message-ID: <20200219105034.40915c50@gandalf.local.home>
In-Reply-To: <20200219150744.888917422@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.888917422@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 15:47:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If we call into a tracer before in_nmi() becomes true, the tracer can
> no longer detect it is called from NMI context and behave correctly.
> 
> Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
> as the normal preempt_count_{add,sub}() have a (desired) function
> trace entry.
> 
> This fixes a potential issue with current code; AFAICT when the
> function-tracer has stack-tracing enabled __trace_stack() will
> malfunction when it hits the preempt_count_add() function entry from
> NMI context.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve
