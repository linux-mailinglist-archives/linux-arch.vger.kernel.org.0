Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6076354590
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhDEQqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 12:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhDEQqS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Apr 2021 12:46:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DE86613B5;
        Mon,  5 Apr 2021 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617641172;
        bh=nvXi4hYjQxujRN4W9KX3qS1fYgktkx9tedrpn6VjnDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxzmJBZuBld5sJKFtIgFhtxZ/SkoFA5kpaeIJGbV1LBQRbvXVRsr/fyhSC45Is36i
         ILR3x8Zz7Qy0N5gswtym1dMsn1nSzGVkFE3N3wn5rRx4vVs1tPvnzUYe87peyCf8W3
         FKkSEERRWusqJkqMmtn2YKobrF7nFTMDFUlF3/1WhFct/9Wl80LPi+RNP31Pz7RPRN
         H6d1XFXgY6T1xqpZmqF0MPWjMhGhc03fYNEvE+5EtJf6IrQPWUA+3ZGFkMQ6Ll7sWc
         gXxkRJrQ5IOUjUM6TywkaaGEYD64CgmYoLlS5/F7+9JVGwETERUrtDnrw7e/30Im5j
         AWlC0lesAknZw==
Received: by mail-lj1-f178.google.com with SMTP id u4so13306792ljo.6;
        Mon, 05 Apr 2021 09:46:11 -0700 (PDT)
X-Gm-Message-State: AOAM530oPbo+CJ1nq+sJI7ZFE1CmawpaYFQ1iz1+IB3IfAGnhxLAmnHe
        uSselKKVxyQ5dajNb2lKnTmlaK2Qus1tGYZl3iU=
X-Google-Smtp-Source: ABdhPJw0FTyLwg6e/Tk15+o6HkD8pB40TY7P5ksg6HGPRcBX1Fy6riyYpCNQKZz84He3ZLobLKsH9V3hAX6HoOnLlIA=
X-Received: by 2002:a2e:a7d4:: with SMTP id x20mr16378736ljp.285.1617641169881;
 Mon, 05 Apr 2021 09:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <4d0dbaa0-1f96-470c-0ed0-04f6827ea384@redhat.com>
In-Reply-To: <4d0dbaa0-1f96-470c-0ed0-04f6827ea384@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Apr 2021 00:45:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRN2FLUbJzwsgitMg2j3sMRcq5a1Gm5dTQivuiakmAdOQ@mail.gmail.com>
Message-ID: <CAJF2gTRN2FLUbJzwsgitMg2j3sMRcq5a1Gm5dTQivuiakmAdOQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 10:09 PM Waiman Long <longman@redhat.com> wrote:
>
> On 3/29/21 11:13 PM, Guo Ren wrote:
> > On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> >>> u32 a = 0x55aa66bb;
> >>> u16 *ptr = &a;
> >>>
> >>> CPU0                       CPU1
> >>> =========             =========
> >>> xchg16(ptr, new)     while(1)
> >>>                                      WRITE_ONCE(*(ptr + 1), x);
> >>>
> >>> When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
> >> Then I think your LL/SC is broken.
> >>
> >> That also means you really don't want to build super complex locking
> >> primitives on top, because that live-lock will percolate through.
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
> If there is a continuous stream of incoming spinlock takers, it is
> possible that some cpus may have to wait a long time to set the tail
> right. However, this should only happen on artificial workload. I doubt
> it will happen with real workload or with limit number of cpus.
Yes, I think is ok for LR/SC in riscv, becasue

CPU0 LR
CPU1 LR
CPU0 SC //success
CPU1 SC //fail

or

CPU0 LR
CPU1 LR
CPU1 SC //success
CPU0 SC //fail

So always one store condition would success. I think it's OK.

> >
> >> Step 1 would be to get your architecute fixed such that it can provide
> >> fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
> >> in building complex systems with it.
> > Quote Waiman's comment [1] on xchg16 optimization:
> >
> > "This optimization is needed to make the qspinlock achieve performance
> > parity with ticket spinlock at light load."
> >
> > [1] https://lore.kernel.org/kvm/1429901803-29771-6-git-send-email-Waiman.Long@hp.com/
> >
> > So for a non-xhg16 machine:
> >   - ticket-lock for small numbers of CPUs
> >   - qspinlock for large numbers of CPUs
> >
> > Okay, I'll put all of them into the next patch :P
> >
> It is true that qspinlock may not offer much advantage when the number
> of cpus is small. It shines for systems with many cpus. You may use
> NR_CPUS to determine if the default should be ticket or qspinlock with
> user override. To determine the right NR_CPUS threshold, you may need to
> run on real SMP RISCV systems to find out.
I Agree

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
