Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72CF3502AD
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhCaOsH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236166AbhCaOsE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:48:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F906101C;
        Wed, 31 Mar 2021 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617202083;
        bh=dXpBkyPDmbez1Pv+mZa7eusgRzqDeW4JZXnYKhHzMk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Re/nuxKj6QEYHf70+XHtUekdh0SgLtX2v0Dq4k/E/fjt30sf13znsjWRI0kjJM0Au
         n1YlstKhZlykOk+cnE6MvbEJSV7mx0zjGqRTI8VYNp6YFlRgSY8POv5d+N5lZlXh+9
         mwumfHkHrHUZWwbI6qMbkO5mGTY11xCmtyTg6qMQHWYIuO283M9fT2bkKV7qnVE4FJ
         A/0aSitADe9d7Mloan8wwpuLg76c4K5GMvu2c36Pwy1liSOzI4bafKwlbaZkZYzaXR
         Oun1TPpqQB5WRz161Npy3wLI569ki5fUnfLw4UaofWMv4hlLuLYbxBZqf+vXOttInp
         8oLRFyWt3sBhw==
Received: by mail-lf1-f48.google.com with SMTP id 12so19132755lfq.13;
        Wed, 31 Mar 2021 07:48:03 -0700 (PDT)
X-Gm-Message-State: AOAM531JCbQ2twCAuAqw4sHbZm6zcVRFXsXWDi7jcoWKbknPVmLir0uC
        Xeu0LPzgpSUHoPUc3ndTBAhPd985SLC9FPGFbps=
X-Google-Smtp-Source: ABdhPJxV0SkyhL0J9EtcC6qc8ehvvfZdh5JPRdhm6ZIBPp9ZQqcovoazEDBeivA8bcGEP5e3bpkou1wZRXG+mH7U7hM=
X-Received: by 2002:a05:6512:ba2:: with SMTP id b34mr2434254lfv.24.1617202081736;
 Wed, 31 Mar 2021 07:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <4d0dbaa0-1f96-470c-0ed0-04f6827ea384@redhat.com>
In-Reply-To: <4d0dbaa0-1f96-470c-0ed0-04f6827ea384@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 Mar 2021 22:47:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSavTCv2yyGvMyHWXapN2nWG17Z02catYJgC3s-hYco9g@mail.gmail.com>
Message-ID: <CAJF2gTSavTCv2yyGvMyHWXapN2nWG17Z02catYJgC3s-hYco9g@mail.gmail.com>
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
Yes, I agree or it couldn't with NR_CPU > 16k.

So the implementation above is suitable for non-sub-word-xchg architecture.

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
We'd give the choice to the users, and they could select ticket-lock
or qspinlock in riscv.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
