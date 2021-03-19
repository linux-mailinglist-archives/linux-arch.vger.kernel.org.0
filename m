Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8F3422C6
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCSREP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 13:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhCSRDn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 13:03:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D4A61959;
        Fri, 19 Mar 2021 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616173423;
        bh=fnbNfVXXSTD6OJ8WdQ6LVfKjqUArSJ75bhS89QA902k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B1GcSm/D1kNRA0qRKWzu/c3ZKpVm3TzqwxezJDa+PSERqt2ezZwTqJ0xg/uqfvb/A
         QC/GflPaOyJQBVdzr3zYPnsDs4Pozyl0h/stZmVQiOrVAIGZHZ9uOPrYZPAUjY1sQI
         55M9NmgMJUikwyNi2jBgszYm0vpHXn7pI7PdXnx+ic7lPPI8VwNmzrXaGOtLMy/+2V
         /qnVKM8XZrhfihkUovSYDaVyEI1ZGJNLhviLxUFpgEWAEL7Mh+3Tygq0V/g55+xvwZ
         ByQzENQ8wRkvL83YCA0EOwh+yssAHg2V5QlRjn785+0aTg/sFOd7dX6GARRr2wMA8m
         b+IBDwwCHhg/Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 017E035239E5; Fri, 19 Mar 2021 10:03:42 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:03:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
Message-ID: <20210319170342.GM2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com>
 <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
 <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
 <YFSYkyNFb34N8Ile@hirez.programming.kicks-ass.net>
 <20210319135229.GJ2696@paulmck-ThinkPad-P72>
 <CABCJKud=aJUSgWG==qqKi-+cKRCtRp4qLNgdDqoYKL+S9X7q4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKud=aJUSgWG==qqKi-+cKRCtRp4qLNgdDqoYKL+S9X7q4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 19, 2021 at 09:17:14AM -0700, Sami Tolvanen wrote:
> On Fri, Mar 19, 2021 at 6:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Mar 19, 2021 at 01:26:59PM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 18, 2021 at 04:48:43PM -0700, Sami Tolvanen wrote:
> > > > On Thu, Mar 18, 2021 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> > > > > > +static void update_shadow(struct module *mod, unsigned long base_addr,
> > > > > > +             update_shadow_fn fn)
> > > > > > +{
> > > > > > +     struct cfi_shadow *prev;
> > > > > > +     struct cfi_shadow *next;
> > > > > > +     unsigned long min_addr, max_addr;
> > > > > > +
> > > > > > +     next = vmalloc(SHADOW_SIZE);
> > > > > > +
> > > > > > +     mutex_lock(&shadow_update_lock);
> > > > > > +     prev = rcu_dereference_protected(cfi_shadow,
> > > > > > +                                      mutex_is_locked(&shadow_update_lock));
> > > > > > +
> > > > > > +     if (next) {
> > > > > > +             next->base = base_addr >> PAGE_SHIFT;
> > > > > > +             prepare_next_shadow(prev, next);
> > > > > > +
> > > > > > +             min_addr = (unsigned long)mod->core_layout.base;
> > > > > > +             max_addr = min_addr + mod->core_layout.text_size;
> > > > > > +             fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> > > > > > +
> > > > > > +             set_memory_ro((unsigned long)next, SHADOW_PAGES);
> > > > > > +     }
> > > > > > +
> > > > > > +     rcu_assign_pointer(cfi_shadow, next);
> > > > > > +     mutex_unlock(&shadow_update_lock);
> > > > > > +     synchronize_rcu_expedited();
> > > > >
> > > > > expedited is BAD(tm), why is it required and why doesn't it have a
> > > > > comment?
> > > >
> > > > Ah, this uses synchronize_rcu_expedited() because we have a case where
> > > > synchronize_rcu() hangs here with a specific SoC family after the
> > > > vendor's cpu_pm driver powers down CPU cores.
> > >
> > > Broken vendor drivers seem like an exceedingly poor reason for this.
> >
> > The vendor is supposed to make sure that RCU sees the CPU cores as either
> > deep idle or offline before powering them down.  My guess is that the
> > CPU is powered down, but RCU (and probably much else in the system)
> > thinks that the CPU is still up and running.  So I bet that you are
> > seeing other issues as well.
> >
> > I take it that the IPIs from synchronize_rcu_expedited() have the effect
> > of momentarily powering up those CPUs?
> 
> I suspect you're correct. I'll change this to use synchronize_rcu() in v3.

You might also suggest to the vendor that they look for a missing
rcu_idle_enter(), rcu_irq_exit(), or similar on the code path that the
outgoing CPUs follow before getting powered down.  That way, they won't
be wasting power from irrelevant IPIs.  You see, RCU will eventually
send IPIs to non-responding CPUs for normal grace periods.

							Thanx, Paul
