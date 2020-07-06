Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFA215F86
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGFTkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFTkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 15:40:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E687C061755;
        Mon,  6 Jul 2020 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fga2epNTXBelXbYkbTxROQdchUloEASZKoCcJ/iKrWw=; b=BeTQRyoGVX7klkBfy71IhIii42
        JLJVPvYdGVws5AyPO2wATPQh812LcOHjFg8RqbL8QgCaxHK+B103YXboryKFzbnforwfw09tNatE9
        Ijvwo8PiAqBc+pqw5sDe87w5LOI2SYN6KwrLb1mF4UNVYiAxzyYRJj/nUVEy5N9Th6O/tYCF8VpZV
        yC2XlC+u2k195dE9l9ZVM2DO+equSQoon5zhP1iEjupkjTXqD4be/tJ9YsR2I1ClBCDJd+yYpIZXF
        Q6+cIuj+PAzHD6t30ZZbYPyuTxPG3nfJprRPcGf3KxUTK93dlpHy3vdg6mTpTVbfsaduXM8c65F50
        6jIUEBlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsWyN-0001u4-QE; Mon, 06 Jul 2020 19:40:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9A28980DD2; Mon,  6 Jul 2020 21:40:12 +0200 (CEST)
Date:   Mon, 6 Jul 2020 21:40:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200706194012.GA5523@worktop.programming.kicks-ass.net>
References: <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703144228.GF9247@paulmck-ThinkPad-P72>
 <20200706162633.GA13288@paulmck-ThinkPad-P72>
 <20200706182926.GH4800@hirez.programming.kicks-ass.net>
 <20200706183933.GE9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706183933.GE9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 11:39:33AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 06, 2020 at 08:29:26PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 06, 2020 at 09:26:33AM -0700, Paul E. McKenney wrote:

> > If they do not consider their Linux OS running correctly :-)
> 
> Many of them really do not care at all.  In fact, some would consider
> Linux failing to run as an added bonus.

This I think is why we have compiler people in the thread that care a
lot more.

> > > Nevertheless, yes, control dependencies also need attention.
> > 
> > Today I added one more \o/
> 
> Just make sure you continually check to make sure that compilers
> don't break it, along with the others you have added.  ;-)

There's:

kernel/locking/mcs_spinlock.h:  smp_cond_load_acquire(l, VAL);                          \
kernel/sched/core.c:                    smp_cond_load_acquire(&p->on_cpu, !VAL);
kernel/smp.c:   smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));

arch/x86/kernel/alternative.c:          atomic_cond_read_acquire(&desc.refs, !VAL);
kernel/locking/qrwlock.c:               atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
kernel/locking/qrwlock.c:       atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
kernel/locking/qrwlock.c:               atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
kernel/locking/qspinlock.c:             atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
kernel/locking/qspinlock.c:     val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));

include/linux/refcount.h:               smp_acquire__after_ctrl_dep();
ipc/mqueue.c:                   smp_acquire__after_ctrl_dep();
ipc/msg.c:                      smp_acquire__after_ctrl_dep();
ipc/sem.c:                      smp_acquire__after_ctrl_dep();
kernel/locking/rwsem.c:                 smp_acquire__after_ctrl_dep();
kernel/sched/core.c:    smp_acquire__after_ctrl_dep();

kernel/events/ring_buffer.c:__perf_output_begin()

And I'm fairly sure I'm forgetting some... One could argue there's too
many of them to check already.

Both GCC and CLANG had better think about it.
