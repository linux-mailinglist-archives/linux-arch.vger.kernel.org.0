Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781E934ED37
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3QJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhC3QIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 12:08:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F26DC061574;
        Tue, 30 Mar 2021 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZ/Ko/eJj6YQh9R0IXOj9k0rl82twQEwfEUFGonDznQ=; b=l9DJBYRNfsQ39ItnBtJnvAyo3M
        QMMoRI+Wj38GmNnAOqTypBJXrHcLbR7knvvW9cJkoWZjNfCqlpv36Pm36Rj+78wrHBfdkPyS64QPR
        9wFqTuJsBRoxvriItVBHO3nw8EGsWOJyESrfBlOVX7HG5fsHO4QXLEBU9vpzybSuqwU2gOWiFpH7A
        jEsMRv1JaZpDHaulu9pTTzVPhJvrISL7c75yIXwEtFHdOdSF3QIhsJUud2f88Sh+zX/0sOH+X39M1
        QzF5TJvAviahNOZCjbBQFZxc9DGuFusfmWE7uwB4JoalNzmGA3oFfhwu0+Vrd/FZD93rUi9t6J2r2
        GK0F5RWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRGv3-004J3i-LK; Tue, 30 Mar 2021 16:08:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 392AA3010CF;
        Tue, 30 Mar 2021 18:08:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 266312B85BA0A; Tue, 30 Mar 2021 18:08:40 +0200 (CEST)
Date:   Tue, 30 Mar 2021 18:08:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 11:13:55AM +0800, Guo Ren wrote:
> On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> > > u32 a = 0x55aa66bb;
> > > u16 *ptr = &a;
> > >
> > > CPU0                       CPU1
> > > =========             =========
> > > xchg16(ptr, new)     while(1)
> > >                                     WRITE_ONCE(*(ptr + 1), x);
> > >
> > > When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
> >
> > Then I think your LL/SC is broken.
> >
> > That also means you really don't want to build super complex locking
> > primitives on top, because that live-lock will percolate through.

> Do you mean the below implementation has live-lock risk?
> +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> +{
> +       u32 old, new, val = atomic_read(&lock->val);
> +
> +       for (;;) {
> +               new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> +               old = atomic_cmpxchg(&lock->val, val, new);
> +               if (old == val)
> +                       break;
> +
> +               val = old;
> +       }
> +       return old;
> +}

That entirely depends on the architecture (and cmpxchg() impementation).

There are a number of cases:

 * architecture has cmpxchg() instruction (x86, s390, sparc, etc.).

  - architecture provides fwd progress (x86)
  - architecture requires backoff for progress (sparc)

 * architecture does not have cmpxchg, and implements it using LL/SC.

  and here things get *really* interesting, because while an
  architecture can have LL/SC fwd progress, that does not translate into
  cmpxchg() also having the same guarantees and all bets are off.

The real bummer is that C can do cmpxchg(), but there is no way it can
do LL/SC. And even if we'd teach C how to do LL/SC, it couldn't be
generic because architectures lacking it can't emulate it using
cmpxchg() (there's a fun class of bugs there).

So while the above code might be the best we can do in generic code,
it's really up to the architecture to make it work.
