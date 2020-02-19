Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E699B164A67
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSQa5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:30:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qa5MZXsY7UPTTol/FJvhlBtevBmctxCysX0lVvI/ets=; b=ORvjDlmqrnGOh407C041eU3k9p
        b61SyIGFf9hTeHelPoSp8oH07/ImIyZV/JoR16WCgXmm4NsfaVOCwMQ9dY5HHlSoKspp470pNXP8e
        V0T3ydML7tkESZinzvyPdfJX+ZRiC0ekMJaSjeKpnmAtMZGutwjfVQ+OfvNZ8+z79/MjmS9fH/Y2A
        9RwbF0S/YOLT45ukmIfZldOaOgAcPyBAjObWbeolbxHtgs/aLtr9WUQFIUU3Vay4dcKTgTAM2bhsW
        nwiIsf4dkaGjL8VrLOYckcZv6JzZibansKaoN04b+2o0r4cYIQoqUv3FTIoRncDbbzF7eVDxEx6tP
        8H51aBiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SF2-0004Yt-Q2; Wed, 19 Feb 2020 16:30:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 397F3300606;
        Wed, 19 Feb 2020 17:28:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 636E5201BADC9; Wed, 19 Feb 2020 17:30:25 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:30:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is
 not sanitized
Message-ID: <20200219163025.GH18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:06:03PM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 19, 2020 at 4:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > In order to ensure poke_int3_handler() is completely self contained --
> > we call this while we're modifying other text, imagine the fun of
> > hitting another INT3 -- ensure that everything is without sanitize
> > crud.
> 
> +kasan-dev
> 
> Hi Peter,
> 
> How do we hit another INT3 here? 

INT3 is mostly the result of either kprobes (someone sticks a kprobe in
the middle of *SAN) or self modifying text stuff (jump_labels, ftrace
and soon static_call).

> Does the code do
> out-of-bounds/use-after-free writes?
> Debugging later silent memory corruption may be no less fun :)

It all stinks, debugging a recursive exception is also not fun.

> Not sanitizing bsearch entirely is a bit unfortunate. We won't find
> any bugs in it when called from other sites too.

Agreed.

> It may deserve a comment at least. Tomorrow I may want to remove
> __no_sanitize, just because sanitizing more is better, and no int3
> test will fail to stop me from doing that...

If only I actually had a test-case for this :/

> It's quite fragile. Tomorrow poke_int3_handler handler calls more of
> fewer functions, and both ways it's not detected by anything.

Yes; not having tools for this is pretty annoying. In 0/n I asked Dan if
smatch could do at least the normal tracing stuff, the compiler
instrumentation bits are going to be far more difficult because smatch
doesn't work at that level :/

(I actually have

> And if we ignore all by one function, it is still not helpful, right?
> Depending on failure cause/mode, using kasan_disable/enable_current
> may be a better option.

kasan_disable_current() could mostly work; but only covers kasan, not
ubsan or kcsan. It then also relies on kasan_disable_current() itself
being notrace as well as all instrumentation functions itself (which I
think is currently true because of mm/kasan/Makefile stripping
CC_FLAGS_FTRACE).

But what stops someone from sticking a kprobe or #DB before you check
that variable?

By inlining everything in poke_int3_handler() (except bsearch :/) we can
mark the whole function off limits to everything and call it a day. That
simplicity has been the guiding principle so far.

Alternatively we can provide an __always_inline variant of bsearch().
