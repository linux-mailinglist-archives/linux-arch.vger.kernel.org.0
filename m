Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74517B30D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 01:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCFAmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 19:42:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCFAmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Mar 2020 19:42:46 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jA14I-0000gb-53; Fri, 06 Mar 2020 01:42:22 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5E6A3104085; Fri,  6 Mar 2020 01:42:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
In-Reply-To: <20200213163800.5c51a5f1@gandalf.local.home>
References: <20200212210139.382424693@infradead.org> <20200212210749.971717428@infradead.org> <20200212232005.GC115917@google.com> <20200213082716.GI14897@hirez.programming.kicks-ass.net> <20200213135138.GB2935@paulmck-ThinkPad-P72> <20200213164031.GH14914@hirez.programming.kicks-ass.net> <20200213185612.GG2935@paulmck-ThinkPad-P72> <20200213204444.GA94647@google.com> <20200213205442.GK2935@paulmck-ThinkPad-P72> <20200213211930.GG170680@google.com> <20200213163800.5c51a5f1@gandalf.local.home>
Date:   Fri, 06 Mar 2020 01:42:21 +0100
Message-ID: <87y2seb9g2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> rcu_nmi_enter() was marked NOKPROBE or other reasons. See commit

Very well said: OR other reasons. I assume you meant 'for' but ...

> c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
> kprobe_int3_handler()")
>
> The issue was that we must not allow anything in do_int3() call kprobe
> code before kprobe_int3_handler() is called. Because ist_enter() (in
> do_int3()) calls rcu_nmi_enter() it had to be marked NOKPROBE. It had
> nothing to do with it being RCU nor NMI, but because it was simply
> called in do_int3().
>
> Thus, there's no reason to make rcu_nmi_exit() NOKPROBE. But a commont
> to why rcu_nmi_enter() would probably be useful, like below:

... this is really wrong.

While the int3 issue was the reason why it was marked NOKPROBE, fact is
that aside of int3 problem (which is probably true for any other
architecture using breakpoints for patching) any probe _before_ RCU is
watching and _after_ RCU stopped watching is broken. Same applies for
BPF and tracepoints which call into BPF or other nonsense.

Can we please stop claiming that instrumentation can touch anything it
wants and just admit that anything outside RCU covered regions is
off-limits for instrumentation? Same applies for entry code and critical
exceptions/traps.

There is a reason why the tracer can't trace itself and there are very
valid reasons to limit the instrumentation ability in other places.

It's nice to be able to see into 'everything' but for 99.9999% of the
cases the coverage of these things is absolutely irrelevant.

Yes I know, "Correctness first" is this old school thing for grumpy old
greybeards who are still stuck in the 90's. "Features first" is the new
mantra. I deal with that every day by mopping up the mess it creates.

Thanks,

        tglx
