Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C069E3544F0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhDEQNQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 12:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhDEQNQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Apr 2021 12:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F87E613B3;
        Mon,  5 Apr 2021 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617639189;
        bh=xy8R21hrTPrRLeZE3Iow50HkLLBJIhV008i585nefRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SeFOi8/+3Le5xBQWXNW6n6C3HYppZhmwZ4LkGeyoV4qtJlERXR78lokgpt3CNkCfb
         Gd0GoDUH6eXEhmyo0IV3ZBFG0tafGxWzO2Q0NEKY/eJ1l4qVacxFoUhlzpkhpCo5TX
         cxS9sfNc/xGCX39WQi5n5A5lgKpabsdQ56Cz/Qf0GsvWqXuq8nqA6gRImQJNtxtTOq
         9hAt2p1o2UFh46hMdsmyKeZhPwSN7BjkuNCt2rWcmvT+z+mU2iIRLEmOGaOR705Ace
         HFwXTwjeIIrXo4fv3EGSr8w7TZsDqVuZx/nvtdNZ82lvVsktD47DxUfoXlSlBzafqN
         fg9RYqdcnXITA==
Received: by mail-lf1-f44.google.com with SMTP id o10so18152278lfb.9;
        Mon, 05 Apr 2021 09:13:09 -0700 (PDT)
X-Gm-Message-State: AOAM532EUFzVZzpSphm93a/dIG3mkXKBxK5HJa83FDwcUglSNozMb2MD
        FlK2EDWwxaAoXj2juj2XL+mxzFRWO7ffTBQ/wzU=
X-Google-Smtp-Source: ABdhPJyfiO0EIbWm2CPHFNjIUV1Ys8Y18EK39LJgff4lu0eaH9pwDtYDrwYUyulRL/XaEhAKr3B8Xz7p2aVOmQwL5XQ=
X-Received: by 2002:a05:6512:ba2:: with SMTP id b34mr17792144lfv.24.1617639187590;
 Mon, 05 Apr 2021 09:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
 <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com> <1706037.TLkxdtWsSY@rata>
In-Reply-To: <1706037.TLkxdtWsSY@rata>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Apr 2021 00:12:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS1-onvC7i4gqEtK7-mC+TnQ2czR-kjKbPxZdX+4To4yw@mail.gmail.com>
Message-ID: <CAJF2gTS1-onvC7i4gqEtK7-mC+TnQ2czR-kjKbPxZdX+4To4yw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Paul Campbell <taniwha@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

Thx for the explanation, here is my comment.

On Wed, Mar 31, 2021 at 1:33 PM Paul Campbell <taniwha@gmail.com> wrote:
>
> On Wednesday, 31 March 2021 5:18:56 PM NZDT Guo Ren wrote:
> > > > [1]
> > > > https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2fcc
> > > > 52afd0fcbf88> >
> > > > > It also seems that the current "amoswap" based implementation
> > > > > would be reliable independent of RsrvEventual/RsrvNonEventual.
> > > >
> > > > Yes, the hardware implementation of AMO could be different from LR/SC.
> > > > AMO could use ACE snoop holding to lock the bus in hw coherency
> > > > design, but LR/SC uses an exclusive monitor without locking the bus.
> > > >
> > > > RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> > > > think LR/SC would be slower than CAS, and CAS is just good for code
> > > > size.
> > >
> > > What I meant here is that the current spinlock uses a simple amoswap,
> > > which presumably does not suffer from the lack of forward process you
> > > described.
> >
> > Does that mean we should prevent using LR/SC (if RsrvNonEventual)?
>
> Let me provide another data-point, I'm working on a high-end highly
> speculative implementation with many concurrent instructions in flight - from
> my point of view  both sorts of AMO (LR/SC and swap/add/etc) require me to
> grab a cache line in an exclusive modifiable state (so no difference there).
>
> More importantly both sorts of AMO instructions  (unlike most loads and
> stores) can't be speculated (not even LR because it changes hidden state, I
> found this out the hard way bringing up the kernel).
>
> This means that both LR AND SC individually can't be executed until all
> speculation is resolved (that means that they happen really late in the
> execute path and block the resolution of the speculation of subsequent
> instructions) - equally a single amoswap/add/etc instruction can't happen
> until late in the execute path - so both require the same cache line state,
> but one of these sorts of events is better than two of them.
>
> Which in short means that amoswap/add/etc is better for small things - small
> buzzy lock loops, while LR/SC is better for more complex things with actual
> processing between the LR and SC.
Seems your machine using the same way to implement LR/SC and AMO, but
some machines would differ them.

For AMO, I think it's would be like what you've described:
 - AMO would be separated into three parts: load & lock, ALU
operation, store & unlock
 - load & lock, eg: we could using ACE protocol -SNOOP channel to
holding the bus
 - Doing atomic AMO
 - store & unlock: Write the result back and releasing the ACE
protocol -SNOOP channel
I think the above is what you describe as how to "grab a cache line in
an exclusive modifiable state".

But for LR/SC, it's different. Because we have separated AMO into real
three parts of instruction:
 - LR
 - Operation instructions
 - SC
If we let LR holding ACE protocol -SNOOP channel and let SC release
channel, that would break the ISA design (we couldn't let an
instruction holding the snoop bus and made other harts hang up.)

So LR/SC would use address monitors for every hart, to detect the
target address has been written or not.
That means LR/SC won't be implemented fwd progress guarantees. If you
care about fwd progress guarantees, I think ISA should choose cmpxchg
(eg: cas) instead of LR/SC.


>
> ----
>
> Another issue here is to consider is what happens when you hit one of these
> tight spinlocks when the branch target cache is empty and they fail (ie loop
> back and try again) - the default branch prediction, and resulting
> speculation, is (very) likely to be looping back, while hopefully most locks
> are not contended when you hit them and that speculation would be wrong - a
> spinlock like this may not be so good:
>
>         li a0, 1
> loop:
>         amoswap a1, a0, (a2)
>         beqz    a1, loop
>         ..... subsequent code
>
> In my world with no BTC info the pipe fills with dozens of amoswaps, rather
> than  the 'subsequent code'. While (in my world) code like this:
>
>         li a0, 1
> loop:
>         amoswap a1, a0, (a2)
>         bnez    a1, 1f
>         .... subsequent code
>
> 1:      j loop
>
> would actually be better (in my world unconditional jump instructions are
> folded early and never see execution so they're sort of free, though they mess
> with the issue/decode rate). Smart compilers could move the "j loop" out of
> the way, while the double branch on failure is not a big deal since either the
> lock is still held (and you don't care if it's slow) or it's been released in
> which case the cache line has been stolen and the refetch of that cache line
> is going to dominate the next time around the loop
Thx for sharing the view of the spinlock speculative path. But I think
we should use smp_cond_load_acquire not looping.
That means we could use wfe/cpu_relax to let other harts utilized the
core's pipeline. So we needn't optimize the "subsequent code"
speculative path in the multi-threads processing core and just let the
hart relax.


>
> I need to stress here that this is how my architecture works, other's will of
> course be different though I expect that other heavily speculative
> architectures to have similar issues :-)
>
>         Paul Campbell
>         Moonbase Otago
>
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
