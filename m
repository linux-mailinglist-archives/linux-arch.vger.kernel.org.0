Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2534E138
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC3G2Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 02:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhC3G2E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 02:28:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F09B61989;
        Tue, 30 Mar 2021 06:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617085684;
        bh=nayM5SKcKbHhEUcOm1Bpv22PdU7DGZfI45+sXYoCtTE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IMv2XD/wEsVjpGtT55oa1LNc8j8RhbdTKjnNQ5KxitgKHLKqBILXoWrnh+x6ttIrA
         q1J2ephhR/I+5tbpOWeMuB3USIbVJVtaYngvXciiXFf9EoW5AJMfUlYa/upofTvij7
         92BAKbaWUOLgdgyBp9vx8sTXcXC0m/FMahnH8oTzjzNcv1QNpGPFX9wB24ghUbUrxV
         uJNCGihskGr9rgMAHL/U1Ix6m5+kb2J5EeEygcWzA+S9GwRcZlNAr1DH4PD2CXYBx1
         wW2pFlV8bEtbCUoixFLJ4Wcl7LC7ClMjMpphge7lJj98NFp7lmQEnUO+ukZ6tRkNZJ
         NT3E+9qpRLMIg==
Received: by mail-lf1-f50.google.com with SMTP id b4so22056122lfi.6;
        Mon, 29 Mar 2021 23:28:03 -0700 (PDT)
X-Gm-Message-State: AOAM531jSTbFN7ONC7jpkr5E+86oNRWn37+Pxd4iX6hJO3EgmnZyQ63B
        ieoSyq5ZQ4r4iq+hIY8YQTf0hu7qTOVrJ8V7CSI=
X-Google-Smtp-Source: ABdhPJzWJhIlP8ARSkCvemMJ/FDg5buGQEms6F/qyqWvpnvopcR6D0UAUgTZIBVE9j5JQUWiWacZQWv2FbJpDMaNh5s=
X-Received: by 2002:a05:6512:3709:: with SMTP id z9mr18100548lfr.557.1617085681939;
 Mon, 29 Mar 2021 23:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <DM6PR04MB62011884B58F1F4BD5909D308D7D9@DM6PR04MB6201.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB62011884B58F1F4BD5909D308D7D9@DM6PR04MB6201.namprd04.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Mar 2021 14:27:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT5_RnAsYuO-Co1TeURPDAvwgKZb2hRfxdxbnd0ZZL9hw@mail.gmail.com>
Message-ID: <CAJF2gTT5_RnAsYuO-Co1TeURPDAvwgKZb2hRfxdxbnd0ZZL9hw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 12:54 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Guo Ren <guoren@kernel.org>
> > Sent: 30 March 2021 08:44
> > To: Peter Zijlstra <peterz@infradead.org>
> > Cc: linux-riscv <linux-riscv@lists.infradead.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; linux-csky@vger.kernel.org; linux-arch
> > <linux-arch@vger.kernel.org>; Guo Ren <guoren@linux.alibaba.com>; Will
> > Deacon <will@kernel.org>; Ingo Molnar <mingo@redhat.com>; Waiman
> > Long <longman@redhat.com>; Arnd Bergmann <arnd@arndb.de>; Anup
> > Patel <anup@brainfault.org>
> > Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
> > ARCH_USE_QUEUED_SPINLOCKS_XCHG32
> >
> > On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org>
> > wrote:
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
> >
> >
> > >
> > > Step 1 would be to get your architecute fixed such that it can provide
> > > fwd progress guarantees for LL/SC. Otherwise there's absolutely no
> > > point in building complex systems with it.
> >
> > Quote Waiman's comment [1] on xchg16 optimization:
> >
> > "This optimization is needed to make the qspinlock achieve performance
> > parity with ticket spinlock at light load."
> >
> > [1] https://lore.kernel.org/kvm/1429901803-29771-6-git-send-email-
> > Waiman.Long@hp.com/
> >
> > So for a non-xhg16 machine:
> >  - ticket-lock for small numbers of CPUs
> >  - qspinlock for large numbers of CPUs
> >
> > Okay, I'll put all of them into the next patch
>
> I would suggest to have separate Kconfig opitons for ticket spinlock
> in Linux RISC-V which will be disabled by default. This means Linux
> RISC-V will use qspinlock by default and use ticket spinlock only when
> ticket spinlock kconfig is enabled.
OK

>
> Regards,
> Anup



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
