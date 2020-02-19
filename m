Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2AF164D31
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSSAQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 13:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSSAP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 13:00:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D502024656;
        Wed, 19 Feb 2020 18:00:13 +0000 (UTC)
Date:   Wed, 19 Feb 2020 13:00:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200219130012.116670fd@gandalf.local.home>
In-Reply-To: <20200219174025.GJ2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
        <20200219150745.125119627@infradead.org>
        <20200219164356.GB2935@paulmck-ThinkPad-P72>
        <20200219164736.GL18400@hirez.programming.kicks-ass.net>
        <20200219170507.GH14946@hirez.programming.kicks-ass.net>
        <20200219122116.7aeaf230@gandalf.local.home>
        <20200219174025.GJ2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 09:40:25 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Correct, and if rcuidle is not set, and this is a macro, the SRCU
> > portion is compiled out.  
> 
> Sigh!  Apologies for the noise!
> 
> If we are using SRCU, we don't care whether or not RCU is watching.  OK,
> maybe finally catching up -- the whole point was use of RCU in other
> tracing code, wasn't it?

Some callbacks (namely perf) might use RCU, but then the callbacks
need to make sure rcu is watching.

-- Steve
