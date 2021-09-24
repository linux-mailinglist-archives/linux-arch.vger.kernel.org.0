Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B148B417BEF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbhIXTx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 15:53:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50107 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1345019AbhIXTx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 15:53:59 -0400
Received: (qmail 288858 invoked by uid 1000); 24 Sep 2021 15:52:23 -0400
Date:   Fri, 24 Sep 2021 15:52:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        will@kernel.org, paulmck@kernel.org, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210924195223.GA287835@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210924183858.GA25901@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924183858.GA25901@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 24, 2021 at 02:38:58PM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Following the LPC2021 BoF about control dependency, I re-read the kernel
> documentation about control dependency, and ended up thinking that what
> we have now is utterly fragile.
> 
> Considering that the goal here is to prevent the compiler from being able to
> optimize a conditional branch into something which lacks the control
> dependency, while letting the compiler choose the best conditional
> branch in each case, how about the following approach ?
> 
> #define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p((_Bool) x)); x; })
> #define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm volatile goto ("" : : : "cc", "memory" : l_dummy); (x); })
> #define ctrl_dep_if(x)          if ((ctrl_dep_eval(x) && ctrl_dep_emit_loop(1)) || ctrl_dep_emit_loop(0))
> 
> The idea is to forbid the compiler from considering the two branches as
> identical by adding a dummy loop in each branch with an empty asm goto.
> Considering that the compiler should not assume anything about the
> contents of the asm goto (it's been designed so the generated assembly
> can be modified at runtime), then the compiler can hardly know whether
> each branch will trigger an infinite loop or not, which should prevent
> unwanted optimisations.
> 
> With this approach, the following code now keeps the control dependency:
> 
> 	z = READ_ONCE(var1);
>         ctrl_dep_if (z)
>                 WRITE_ONCE(var2, 5);
>         else
>                 WRITE_ONCE(var2, 5);
> 
> And the ctrl_dep_eval() checking the constant triggers a build error
> for:
> 
>         y = READ_ONCE(var1);
>         ctrl_dep_if (y % 1)
>                 WRITE_ONCE(var2, 5);
>         else
>                 WRITE_ONCE(var2, 6);
> 
> Which is good to have to ensure the compiler don't end up removing the
> conditional branch because the resulting evaluation ends up evaluating a
> constant.
> 
> Thoughts ?

As I remember the earlier discussion, Linus felt that the kernel doesn't 
really need any sort of explicit control dependency (although we called 
it "volatile if").  In many cases there is an actual semantic 
dependency, so it doesn't matter what the compiler does -- the hardware 
will enforce the actual dependency.  In other cases, we can work around 
the issue by using acquire loads or release stores.

In fact, Linus's biggest wish was to have a weak form of compiler 
barrier, one which would block the compiler from reordering accesses 
across the barrier but wouldn't invalidate the compiler's knowledge 
about the values of earlier reads (which barrier() would do).

Alan Stern
