Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5F417C1A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbhIXUCq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 16:02:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:60688 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345661AbhIXUCq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Sep 2021 16:02:46 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18OJtaHF002175;
        Fri, 24 Sep 2021 14:55:36 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 18OJtZvk002172;
        Fri, 24 Sep 2021 14:55:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 24 Sep 2021 14:55:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        will@kernel.org, paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210924195535.GC17780@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <20210924183858.GA25901@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924183858.GA25901@localhost>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Fri, Sep 24, 2021 at 02:38:58PM -0400, Mathieu Desnoyers wrote:
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

[The "cc" clobber only pessimises things: the asm doesn't actually
clobber the default condition code register (which is what "cc" means),
and you can have conditional branches using other condition code
registers, or on other registers even (general purpose registers is
common.]

> The idea is to forbid the compiler from considering the two branches as
> identical by adding a dummy loop in each branch with an empty asm goto.
> Considering that the compiler should not assume anything about the
> contents of the asm goto (it's been designed so the generated assembly
> can be modified at runtime), then the compiler can hardly know whether
> each branch will trigger an infinite loop or not, which should prevent
> unwanted optimisations.

The compiler looks if the code is identical, nothing more, nothing less.
There are no extra guarantees.  In principle the compiler could see both
copies are empty asms looping to self, and so consider them equal.


Segher
