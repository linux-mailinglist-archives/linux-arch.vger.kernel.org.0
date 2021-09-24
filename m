Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E59A417B32
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbhIXSkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 14:40:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:49536 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346362AbhIXSkf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 14:40:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 043AB3296AF;
        Fri, 24 Sep 2021 14:39:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HAZ6d7h-iFTj; Fri, 24 Sep 2021 14:39:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 63A053296AE;
        Fri, 24 Sep 2021 14:39:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 63A053296AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1632508740;
        bh=71VnkTZl6HZ62SXVLyDKn1rthumUvdAsNNnKGkSuYDc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PRmrqBP6qSN6bSSUZKgjAnhpXV9AVTnPx3RJdEodwA5e1pC9096DUA2BF/wOocCfD
         8MECN8rXCtGOEUJ4l+wDZ7xtli6YcsatrX5coOQ4+xdFogiEUZWBePFftOZkGdCpcR
         M/PDJHKS5DI8Uqr3kQH3hL+ZUrz7vadk4fOjb5GnVX4YdLjxN4AfXrJaMlYK5UAkwO
         cZGt4QvjXLQ6BCZmiYdh0VSCvTXFq8BVUI2TDIgBsKhA7w5sEFmN07LDA9Mq0vm81r
         TsceFsBz14utuXXRPpgHb7cbAg1ctipsSfiDMb3KotjmtAdpsiwhnmVGuDv/sHx/gc
         cLd6j9FzqOvDA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q8KBgvl0QZvT; Fri, 24 Sep 2021 14:39:00 -0400 (EDT)
Received: from localhost (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id E8B15329732;
        Fri, 24 Sep 2021 14:38:59 -0400 (EDT)
Date:   Fri, 24 Sep 2021 14:38:58 -0400
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210924183858.GA25901@localhost>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Following the LPC2021 BoF about control dependency, I re-read the kernel
documentation about control dependency, and ended up thinking that what
we have now is utterly fragile.

Considering that the goal here is to prevent the compiler from being able to
optimize a conditional branch into something which lacks the control
dependency, while letting the compiler choose the best conditional
branch in each case, how about the following approach ?

#define ctrl_dep_eval(x)        ({ BUILD_BUG_ON(__builtin_constant_p((_Bool) x)); x; })
#define ctrl_dep_emit_loop(x)   ({ __label__ l_dummy; l_dummy: asm volatile goto ("" : : : "cc", "memory" : l_dummy); (x); })
#define ctrl_dep_if(x)          if ((ctrl_dep_eval(x) && ctrl_dep_emit_loop(1)) || ctrl_dep_emit_loop(0))

The idea is to forbid the compiler from considering the two branches as
identical by adding a dummy loop in each branch with an empty asm goto.
Considering that the compiler should not assume anything about the
contents of the asm goto (it's been designed so the generated assembly
can be modified at runtime), then the compiler can hardly know whether
each branch will trigger an infinite loop or not, which should prevent
unwanted optimisations.

With this approach, the following code now keeps the control dependency:

	z = READ_ONCE(var1);
        ctrl_dep_if (z)
                WRITE_ONCE(var2, 5);
        else
                WRITE_ONCE(var2, 5);

And the ctrl_dep_eval() checking the constant triggers a build error
for:

        y = READ_ONCE(var1);
        ctrl_dep_if (y % 1)
                WRITE_ONCE(var2, 5);
        else
                WRITE_ONCE(var2, 6);

Which is good to have to ensure the compiler don't end up removing the
conditional branch because the resulting evaluation ends up evaluating a
constant.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
