Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE52CB326
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 04:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgLBDKS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgLBDKS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 22:10:18 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36BC0613CF;
        Tue,  1 Dec 2020 19:09:38 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so199987pga.7;
        Tue, 01 Dec 2020 19:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=mTu9T1PiFi4oAwV6r4bAppvxwrYc5gq1agidYIWJs7k=;
        b=FGyql/mAwbC1lUm8OPPQwoMJm0RNgttEWeqjEk80gdvhrTf/haYKk+IQqtLUfSkh7C
         18g6gG85BpyZUGNf1QEwbfi7jBex7GvtzzE0FZH0m4fgyJaYCYaOY6xKD78d7sa1+K4q
         LvAGIpkix2QOJKzt5ynJuu/N4kRYthA2BQAfCKUNUqQarTh86Pe1k+WzKPKsQXNQkInm
         uZgMhlZFWV231VFKUe/WXy8uvsxTzTosj/NTnCd7qkX8U5mI1QDntoq5K4whE+TGvbPi
         qQjkj5Q8gj/uxsqwMAIFrq4gb6d0ULz15QLMDsbE6eiTAhnp/ueeteVY1W23J52Yz3Jl
         BP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=mTu9T1PiFi4oAwV6r4bAppvxwrYc5gq1agidYIWJs7k=;
        b=Dy2P/6SSMkoJosDTfjk15Av3RdV0dB+ngu3/6PygaJVZTlUi1sQKKlrMYtpiXdIijz
         MM8MkrdxEqTStU0v6nZ9N0y+LxF04i8uLl1uBycZG6CwNcME+6lao6xDvgfOZGbG4WSE
         OjaYEXKQZ544M74GfPT7VFGNoMiQbXYKNxY37zj0Dgf55ht7dB098K0C5Y9CqP/XCFpY
         HgbI1FYEiuIB2W2HQYyKtv04hQnaJmFATJINDlEHw/zycdGSj/QjVfD/6OJz0h0hw954
         S9HeoPA+vPhvl+XW7HrkpAlwNMPiSKmB0vmqAsVuCLs8VLAAxx9h90mt3ZxbytSbPo6w
         lY6Q==
X-Gm-Message-State: AOAM5310Mkmb43T9YA38f+BoHgLua9X7e13heN7gnPjFaHdV+AGdIrSf
        +56s5evQidPyTPct851zGR4=
X-Google-Smtp-Source: ABdhPJyMqgqZnm3RX5OBhSrD+f5WEYMBcOc1X5In125AXSEq+tZ/SLJm9LVYEWZ7r6/Oj+0f1pVMQQ==
X-Received: by 2002:a63:a0b:: with SMTP id 11mr717907pgk.21.1606878577415;
        Tue, 01 Dec 2020 19:09:37 -0800 (PST)
Received: from localhost ([1.132.180.166])
        by smtp.gmail.com with ESMTPSA id o133sm309710pfg.97.2020.12.01.19.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 19:09:37 -0800 (PST)
Date:   Wed, 02 Dec 2020 13:09:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20201128160141.1003903-1-npiggin@gmail.com>
        <20201128160141.1003903-7-npiggin@gmail.com>
        <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
In-Reply-To: <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1606877416.ym0jhixy72.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of November 29, 2020 1:54 pm:
> On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> On big systems, the mm refcount can become highly contented when doing
>> a lot of context switching with threaded applications (particularly
>> switching between the idle thread and an application thread).
>>
>> Abandoning lazy tlb slows switching down quite a bit in the important
>> user->idle->user cases, so so instead implement a non-refcounted scheme
>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
>> any remaining lazy ones.
>>
>> Shootdown IPIs are some concern, but they have not been observed to be
>> a big problem with this scheme (the powerpc implementation generated
>> 314 additional interrupts on a 144 CPU system during a kernel compile).
>> There are a number of strategies that could be employed to reduce IPIs
>> if they turn out to be a problem for some workload.
>=20
> I'm still wondering whether we can do even better.

We probably can, for some values of better / more complex. This came up=20
last time I posted, there was a big concern about IPIs etc, but it just=20
wasn't an issue at all even when I tried to coax them to happen a bit.

The thing is they are faily self-limiting, it's not actually all that=20
frequent that you have an mm get taken for a lazy *and* move between=20
CPUs. Perhaps more often with threaded apps, but in that case you're=20
eating various IPI costs anyway (e.g., when moving the task to another
CPU, on TLB shootdowns, etc).

So from last time I did measure and I did document some possible=20
improvements that could be made in comments, but I decided to keep it=20
simple before adding complexity to it.

>=20
> The IPIs you're doing aren't really necessary -- we don't
> fundamentally need to free the pagetables immediately when all
> non-lazy users are done with them (and current kernels don't) -- what
> we need to do is to synchronize all the bookkeeping.  So, with
> adequate locking (famous last words), a couple of alternative schemes
> ought to be possible.

It's not freeing the page tables, those are freed by this point already=20
I think (at least on powerpc they are). It's releasing the lazy mm.

>=20
> a) Instead of sending an IPI, increment mm_count on behalf of the
> remote CPU and do something to make sure that the remote CPU knows we
> did this on its behalf.  Then free the mm when mm_count hits zero.
>=20
> b) Treat mm_cpumask as part of the refcount.  Add one to mm_count when
> an mm is created.  Once mm_users hits zero, whoever clears the last
> bit in mm_cpumask is responsible for decrementing a single reference
> from mm_count, and whoever sets it to zero frees the mm.

Right, these were some possible avenues to explore, thing is it's=20
complexity and more synchronisation costs, and in the fast (context=20
switch) path too. The IPI actually avoids all fast path work, atomic
or not.

> Version (b) seems fairly straightforward to implement -- add RCU
> protection and a atomic_t special_ref_cleared (initially 0) to struct
> mm_struct itself.  After anyone clears a bit to mm_cpumask (which is
> already a barrier), they read mm_users.  If it's zero, then they scan
> mm_cpumask and see if it's empty.  If it is, they atomically swap
> special_ref_cleared to 1.  If it was zero before the swap, they do
> mmdrop().  I can imagine some tweaks that could make this a big
> faster, at least in the limit of a huge number of CPUs.
>=20
> Version (a) seems a bit harder to reason about.  Maybe it could be
> done like this.  Add a percpu variable mm_with_extra_count.  This
> variable can be NULL, but it can also be an mm that has an extra
> reference on behalf of the cpu in question.
>=20
> __mmput scans mm_cpumask and, for each cpu in the mask, mmgrabs the mm
> and cmpxchgs that cpu's mm_with_extra_count from NULL to mm.  If it
> succeeds, then we win.  If it fails, further thought is required, and
> maybe we have to send an IPI, although maybe some other cleverness is
> possible.  Any time a CPU switches mms, it does atomic swaps
> mm_with_extra_count to NULL and mmdrops whatever the mm was.  (Maybe
> it needs to check the mm isn't equal to the new mm, although it would
> be quite bizarre for this to happen.)  Other than these mmgrab and
> mmdrop calls, the mm switching code doesn't mmgrab or mmdrop at all.
>=20
>=20
> Version (a) seems like it could have excellent performance.

That said, if x86 wanted to explore something like this, the code to do=20
it is a bit modular (I don't think a proliferation of lazy refcounting=20
config options is a good idea of course, but 2 versions one for powrepc
style set-and-forget mm_cpumask and one for x86 set-and-clear would
be okay.

> *However*, I think we should consider whether we want to do something
> even bigger first.  Even with any of these changes, we still need to
> maintain mm_cpumask(), and that itself can be a scalability problem.
> I wonder if we can solve this problem too.  Perhaps the switch_mm()
> paths could only ever set mm_cpumask bits,

Powerpc does this.

> and anyone who would send
> an IPI because a bit is set in mm_cpumask would first check some
> percpu variable (cpu_rq(cpu)->something?=20

This is a suggested possible optimization to the IPI scheme (you would
check if it's active).

There's pros and cons to it. You get more IPIs and cross TLB shootdowns
and jitter cleaning up behind you rather than cleaning up as you go.

> an entirely new variable) to
> see if the bit in mm_cpumask is spurious.  Or perhaps mm_cpumask could
> be split up across multiple cachelines, one per node.

IIRC Peter or someone mentioned this was something that was looked at=20
for x86.

> We should keep the recent lessons from Apple in mind, though: x86 is a
> dinosaur.

Wow. What is the recent lesson from Apple?? I'm completely out of the=20
loop here.

> The future of atomics is going to look a lot more like
> ARM's LSE than x86's rather anemic set.  This means that mm_cpumask
> operations won't need to be full barriers forever, and we might not
> want to take the implied full barriers in set_bit() and clear_bit()
> for granted.

Sure, set_bit / clear_bit aren't full barriers in terms of Linux=20
semantics, so generic code doesn't assume that. What x86 does is
add the smp_mb__after_blah or before_blah to avoid an added barrier
because of it's heavier-than-required set_bit.

I'm not quite sure what you were getting at though. The atomic itself is=20
really quite a small cost of the exit() operation (or even a context=20
switch operation) _most_ of the time (x86 CPUs seem to have very fast
atomics so might be even smaller cost for you). It's just when you=20
happen to bounce a cache line, which hurts no matter what you do.

Thanks,
Nick


