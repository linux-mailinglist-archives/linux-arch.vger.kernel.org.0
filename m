Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69534CFA3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhC2MCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhC2MBy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 08:01:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2110361930;
        Mon, 29 Mar 2021 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617019314;
        bh=UT+UrRIVgNhbmAkKeg6HsueNZaK8AB1/0MS5NZZ5NQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfOCEZUNUnR4dKPxmau5OQU9kxgxhGvwo8N3JR/s148VGWrMMAXEH9mfymMgQHnNI
         YhluAI+zInviPvrAzt7wGZUmUh24tq3e4VUhcVfmrQG16kSpgI34Eop4Epu9GViqs/
         IVmw0BZ5JkW63+MoqQ6G98fb6T2mfyqZ3IP+ltAjR0AILOFUyaO7MNL3hyVm/5bPws
         gCi9d/jWTSzGzH6MVMCsFqvbEQnKc5jTCLn7HLSVlr+Xmmw1KvMQXyicd6Uc2kzljR
         404UjwjSmNXVdzJce57PFhk1eGmE8j82NwIiXy6V+pb94GZGHpnIFXPED1fvDHqRUM
         VFkV5eigHQKew==
Received: by mail-lj1-f175.google.com with SMTP id 15so15680568ljj.0;
        Mon, 29 Mar 2021 05:01:54 -0700 (PDT)
X-Gm-Message-State: AOAM531QGLHi1fZ3Kz0L044sDVLidaUegeRgFF5MU8mi9G/8mFRc0JN2
        R6zrajyHs0YtSKgJncIyrNcsaS8Bnv0AAcOdSY0=
X-Google-Smtp-Source: ABdhPJzaBfHptHYx2DLdzeLBCg5t7USdDIneRxDhGd2vvHRCAncwdw++SOaq3bmLo7VgUJwtyPywTZc5e3lJtCC4kNI=
X-Received: by 2002:a2e:9084:: with SMTP id l4mr17142105ljg.498.1617019312425;
 Mon, 29 Mar 2021 05:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com> <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
In-Reply-To: <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 29 Mar 2021 20:01:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
Message-ID: <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 7:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 29, 2021 at 07:19:29PM +0800, Guo Ren wrote:
> > On Mon, Mar 29, 2021 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Some architectures don't have sub-word swap atomic instruction,
> > > > they only have the full word's one.
> > > >
> > > > The sub-word swap only improve the performance when:
> > > > NR_CPUS < 16K
> > > >  *  0- 7: locked byte
> > > >  *     8: pending
> > > >  *  9-15: not used
> > > >  * 16-17: tail index
> > > >  * 18-31: tail cpu (+1)
> > > >
> > > > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > > >
> > > > Please let architecture select xchg16/xchg32 to implement
> > > > xchg_tail.
> > >
> > > So I really don't like this, this pushes complexity into the generic
> > > code for something that's really not needed.
> > >
> > > Lots of RISC already implement sub-word atomics using word ll/sc.
> > > Obviously they're not sharing code like they should be :/ See for
> > > example arch/mips/kernel/cmpxchg.c.
> > I see, we've done two versions of this:
> >  - Using cmpxchg codes from MIPS by Michael
> >  - Re-write with assembly codes by Guo
> >
> > But using the full-word atomic xchg instructions implement xchg16 has
> > the semantic risk for atomic operations.
>
> What? -ENOPARSE

u32 a = 0x55aa66bb;
u16 *ptr = &a;

CPU0                       CPU1
=========             =========
xchg16(ptr, new)     while(1)
                                    WRITE_ONCE(*(ptr + 1), x);

When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.

>
> > > Also, I really do think doing ticket locks first is a far more sensible
> > > step.
> > NACK by Anup
>
> Who's he when he's not sending NAKs ?
We've talked before:
https://lore.kernel.org/linux-riscv/CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com/T/#t

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
