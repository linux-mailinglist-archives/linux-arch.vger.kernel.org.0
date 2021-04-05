Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C73354572
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhDEQk5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 12:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239110AbhDEQkp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Apr 2021 12:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4EA613B1;
        Mon,  5 Apr 2021 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617640839;
        bh=uwAcNXEy+ghDiCSwGPGlI0CYFJF4SwLzYINuCy4SDVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GeIS+8lluCKRUl3YE+TiOVeb/hvdwna4O8MUQuwFiYmsAyLkj7J2FlGJspKA/mGST
         GuSRADV73FM+ifYvNNcTGyzBIYMlbART2af2ippo6HWHGWZkU7JeBpJyD8+uYvZ0hi
         5e0md006K4jRK67wgby+Tu9sLRcRY5iCZUPpBbslgjMH+l5MEbxk6iVgEZ1Old+Tbm
         LYki2E2+ILVESbdquz6fDxQrESGF50suQHkn0M/S7c4xJmIuAAAonvVvDniZHZRP7I
         yXLtTeS3Spt2En09KW4Zp3E+ANVjGQ39jQQr7tXfbzFfThekM/y+TUO4DzmV25mycD
         Yy9VP8DqW7VGQ==
Received: by mail-lj1-f179.google.com with SMTP id s17so13293976ljc.5;
        Mon, 05 Apr 2021 09:40:39 -0700 (PDT)
X-Gm-Message-State: AOAM531ik6m7sh0f9Po085ErWKZ1JXLS9JS+PUgHcq/PYvz+FwsbFcNM
        o/IymFghnpK0L8tIZmj3dy33ASijLe5KCzhPSPM=
X-Google-Smtp-Source: ABdhPJzkUEfDB95CnL6786fUCeee9xm+HPQm1Xan7zZk5hheQjM99nBvdzRzMz0emsctQ9RjQnKaWKBuL1CIvXQjk0Y=
X-Received: by 2002:a2e:2a44:: with SMTP id q65mr17237317ljq.238.1617640837530;
 Mon, 05 Apr 2021 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
In-Reply-To: <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Apr 2021 00:40:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTitt=aD1eU_i_Nvf2vvYWcPeeyB97UyGwV-G4e+Lh7yw@mail.gmail.com>
Message-ID: <CAJF2gTTitt=aD1eU_i_Nvf2vvYWcPeeyB97UyGwV-G4e+Lh7yw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 12:08 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 30, 2021 at 11:13:55AM +0800, Guo Ren wrote:
> > On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> > > > u32 a = 0x55aa66bb;
> > > > u16 *ptr = &a;
> > > >
> > > > CPU0                       CPU1
> > > > =========             =========
> > > > xchg16(ptr, new)     while(1)
> > > >                                     WRITE_ONCE(*(ptr + 1), x);
> > > >
> > > > When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
> > >
> > > Then I think your LL/SC is broken.
> > >
> > > That also means you really don't want to build super complex locking
> > > primitives on top, because that live-lock will percolate through.
>
> > Do you mean the below implementation has live-lock risk?
> > +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > +{
> > +       u32 old, new, val = atomic_read(&lock->val);
> > +
> > +       for (;;) {
> > +               new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> > +               old = atomic_cmpxchg(&lock->val, val, new);
> > +               if (old == val)
> > +                       break;
> > +
> > +               val = old;
> > +       }
> > +       return old;
> > +}
>
> That entirely depends on the architecture (and cmpxchg() impementation).
>
> There are a number of cases:
>
>  * architecture has cmpxchg() instruction (x86, s390, sparc, etc.).
>
>   - architecture provides fwd progress (x86)
>   - architecture requires backoff for progress (sparc)
>
>  * architecture does not have cmpxchg, and implements it using LL/SC.
>
>   and here things get *really* interesting, because while an
>   architecture can have LL/SC fwd progress, that does not translate into
>   cmpxchg() also having the same guarantees and all bets are off.
Seems riscv spec didn't mandatory LR/SC fwd guarantee, ref:

In riscv-spec 8.3 Eventual Success of Store-Conditional Instructions

"As a consequence of the eventuality guarantee, if some harts in an
execution environment are executing constrained LR/SC loops, and no
other harts or devices in the execution environment execute an
unconditional store or AMO to that reservation set, then at least one
hart will eventually exit its constrained LR/SC loop. *** By contrast,
if other harts or devices continue to write to that reservation set,
it ***is not guaranteed*** that any hart will exit its LR/SC loop.***
"

>
> The real bummer is that C can do cmpxchg(), but there is no way it can
> do LL/SC. And even if we'd teach C how to do LL/SC, it couldn't be
> generic because architectures lacking it can't emulate it using
> cmpxchg() (there's a fun class of bugs there).
>
> So while the above code might be the best we can do in generic code,
> it's really up to the architecture to make it work.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
