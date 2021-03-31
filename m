Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8F3502FF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhCaPLT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 11:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236057AbhCaPLI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 11:11:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B16960FD7;
        Wed, 31 Mar 2021 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617203467;
        bh=TbOY0j6r4pK8GJkDQSSBT0PG2JRtiy2xv/ZAq0i48Ss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hdH3tDlHe+07OFGfYhY+WigjDnxq+BZOrIr3z28vnHUCREYXNBXiiyfLMq45Gz4KD
         OXTKoAe6fIzf39nk/ohjZVjQ1itgFk8Qp7wtUj5WoeoEHQro70UWqsoWoJxe7re/0Y
         6R7//wzNDqhwwgl4SytvcYDcdeHl4EdVx3OUPhvRV4uVo1SzXuOU4Knk7H0MNCXtA/
         S/GGFBx9Rhaatf9dcX1UnKeh3p0W49ISNoSuBRj7iXZEP5EOYSi7/qExjdDebJCO7T
         CsiZ2SSZkKJBL9FYKokkMNDMbDG5dbZalbZvz1oMcfS4EMnDrD86Djzl8IhGuG8QcH
         qBZg0qd+DfMzQ==
Received: by mail-lf1-f41.google.com with SMTP id i26so29574541lfl.1;
        Wed, 31 Mar 2021 08:11:07 -0700 (PDT)
X-Gm-Message-State: AOAM533ys/yWhw9g0+76CvOOgKo9WYHiKPHC1D0Rfj8y6wgA5pt7aEN9
        9TjrXgH4VoISKIlztXVYU8wihmb6cfGQPB73VL8=
X-Google-Smtp-Source: ABdhPJxs/JOsMnXbAvQoHRYQUiHPUCi/rrjdiOo3Uk29mwIYM4PTu1vWQ44R+zMcgoxUlGYwTQK+40BUJaSfUaObY3M=
X-Received: by 2002:a05:6512:3709:: with SMTP id z9mr2415095lfr.557.1617203465685;
 Wed, 31 Mar 2021 08:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net> <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net> <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com> <20210331123107.GF1171117@lianli.shorne-pla.net>
In-Reply-To: <20210331123107.GF1171117@lianli.shorne-pla.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 Mar 2021 23:10:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZOFL_LECFcg6nEzNaDA_MR4dhxygFwm1_sDKY9CzBPA@mail.gmail.com>
Message-ID: <CAJF2gTRZOFL_LECFcg6nEzNaDA_MR4dhxygFwm1_sDKY9CzBPA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stafford,

How do think add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in openrisc?

https://lore.kernel.org/linux-riscv/1617201040-83905-7-git-send-email-guoren@kernel.org/T/#u

On Wed, Mar 31, 2021 at 8:31 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Wed, Mar 31, 2021 at 09:23:27AM +0200, Arnd Bergmann wrote:
> > On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > I just want to chime in here, there may be a better spot in the thread to
> > > mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> > > which I have on my todo list somwhere to replace the other generic
> > > implementations like that in mips.
> > >
> > >   arch/openrisc/include/asm/cmpxchg.h
> > >
> > > The idea would be that architectures just implement these methods:
> > >
> > >   long cmpxchg_u32(*ptr,old,new)
> > >   long xchg_u32(*ptr,val)
> > >
> > > Then the rest of the generic header would implement cmpxchg.
> >
> > I like the idea of generalizing it a little further. I'd suggest staying a
> > little closer to the existing naming here though, as we already have
> > cmpxchg() for the type-agnostic version, and cmpxchg64() for the
> > fixed-length 64-bit version.
>
> OK.
>
> > I think a nice interface between architecture-specific and architecture
> > independent code would be to have architectures provide
> > arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
> > as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
> > if they have instructions for those.
>
> Thanks for the name suggestions, it makes it easier for me.
>
> > The common code can then build cmpxchg16()/xchg16() on top of
> > either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
> > wrapper around those (or alternatively we can decide to have them
> > only deal with fixed-32-bit and long/pointer sized atomics).
>
> Yeah, that was the idea.
>
> -Stafford



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
