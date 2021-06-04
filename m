Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FF39BADC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFDO1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 10:27:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49011 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229675AbhFDO1f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 10:27:35 -0400
Received: (qmail 1679280 invoked by uid 1000); 4 Jun 2021 10:25:48 -0400
Date:   Fri, 4 Jun 2021 10:25:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, parri.andrea@gmail.com, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604142548.GD1676809@rowland.harvard.edu>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> Hi!
> 
> With optimizing compilers becoming more and more agressive and C so far
> refusing to acknowledge the concept of control-dependencies even while
> we keep growing the amount of reliance on them, things will eventually
> come apart.
> 
> There have been talks with toolchain people on how to resolve this; one
> suggestion was allowing the volatile qualifier on branch statements like
> 'if', but so far no actual compiler has made any progress on this.
> 
> Rather than waiting any longer, provide our own construct based on that
> suggestion. The idea is by Alan Stern and refined by Paul and myself.
> 
> Code generation is sub-optimal (for the weak architectures) since we're
> forced to convert the condition into another and use a fixed conditional
> branch instruction, but shouldn't be too bad.
> 
> Usage of volatile_if requires the @cond to be headed by a volatile load
> (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> emit the load and the branch emitted will have the required
> data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> should prohibit the compiler from lifting anything out of the selection
> statement.
> 
> This construct should place control dependencies on a stronger footing
> until such time that the compiler folks get around to accepting them :-)
> 
> I've converted most architectures we care about, and the rest will get
> an extra smp_mb() by means of the 'generic' fallback implementation (for
> now).
> 
> I've converted the control dependencies I remembered and those found
> with a search for smp_acquire__after_ctrl_dep(), there might be more.
> 
> Compile tested only (alpha, arm, arm64, x86_64, powerpc, powerpc64, s390
> and sparc64).
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Is there any interest in doing the same sort of thing for switch
statements?  A similar approach would probably work, but maybe people
don't care about it.

Alan
