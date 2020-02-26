Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42EB170232
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBZPUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 10:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgBZPUe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 10:20:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1747E20838;
        Wed, 26 Feb 2020 15:20:33 +0000 (UTC)
Date:   Wed, 26 Feb 2020 10:20:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200226102031.15664d19@gandalf.local.home>
In-Reply-To: <20200226102758.GV18400@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.328642621@infradead.org>
        <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
        <20200221202246.GA14897@hirez.programming.kicks-ass.net>
        <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
        <20200224112708.4f307ba3@gandalf.local.home>
        <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
        <20200224114754.0fb798c1@gandalf.local.home>
        <20200224213139.GO11457@worktop.programming.kicks-ass.net>
        <20200224170231.3807931d@gandalf.local.home>
        <20200226102758.GV18400@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 26 Feb 2020 11:27:58 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 24, 2020 at 05:02:31PM -0500, Steven Rostedt wrote:
> 
> > The other is for the hwlat detector that measures the time it was in an
> > NMI, as NMIs appear as a hardware latency too.  
> 
> Yeah,.. I hate that one. But I ended up with this patch.
> 
> And yes, I know some of those notrace annotations are strictly
> unnessecary due to Makefile crap, but having them is _SO_ much easier.
> 
> ---
> Subject: x86,tracing: Robustify ftrace_nmi_enter()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Feb 24 23:40:29 CET 2020
> 
>   ftrace_nmi_enter()
>      trace_hwlat_callback()
>        trace_clock_local()
>          sched_clock()
>            paravirt_sched_clock()
>            native_sched_clock()
> 
> All must not be traced or kprobed, it will be called from do_debug()
> before the kprobe handler.
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/paravirt.h |    2 +-
>  arch/x86/kernel/tsc.c           |    7 +++++--
>  include/linux/ftrace_irq.h      |    4 ++--
>  kernel/trace/trace_clock.c      |    2 ++
>  kernel/trace/trace_hwlat.c      |    4 +++-
>  5 files changed, 13 insertions(+), 6 deletions(-)
> 
