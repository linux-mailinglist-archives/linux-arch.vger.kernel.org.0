Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF66354B66
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 05:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbhDFDu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 23:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhDFDu7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Apr 2021 23:50:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D895D611EE;
        Tue,  6 Apr 2021 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617681052;
        bh=szRR4JcrQICDR26E7y2EmbZ8ojtgg1rHPlcrE0/d3ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xh7LyhlX8SgYtaHo207MEW2YT8a8f1clTe8y0Yi2E7VuF9cUTfe3JNTF/XGwPyFR1
         7J0Gpiyo8cIbAloHohpmQUYB4YgDXxaKIbx9OdCUDVq2Mfr7ffFqOl5g2SeEDwbRJp
         kjeZVx00J+1BGWp5Uu85JuFeWRfHJDIk+Y9CTprTvQJ9+wtB9KeZgyeXFLxGYq+9UD
         oUYNEKYxSHPACshu3nkz63R73hwAtR4zoTEqdh2ulp7EwSnwEN/5VZNrTZIXtGpeHz
         C6yA+io5tq4xzb/4cKCGwLiVQjlYVXb7m29lq4j4/n9F1YwCFYKJZyxY5au3/vHiU6
         Uz++RocqdA5lQ==
Received: by mail-lf1-f46.google.com with SMTP id o126so20585175lfa.0;
        Mon, 05 Apr 2021 20:50:51 -0700 (PDT)
X-Gm-Message-State: AOAM533DWFYAOKbErtDhkmiv6Pt+TRtpTW4b1FbvGxLSC0Oa/IfKgI9I
        udcqeKbkCI64nwa3zJq+0s/jfwjLDha9qFtXmbM=
X-Google-Smtp-Source: ABdhPJxz7vekhbYxQi/US2gfIUiFffiADC+caHLoxoXMbnk8SvvFWk5EFQrEYzPpfuBRSNV+B6LNPvDCyqdYyVLCZPM=
X-Received: by 2002:a19:f501:: with SMTP id j1mr20502473lfb.231.1617681050232;
 Mon, 05 Apr 2021 20:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net> <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
In-Reply-To: <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Apr 2021 11:50:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
Message-ID: <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stafford Horne <shorne@gmail.com>,
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

On Wed, Mar 31, 2021 at 3:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > I just want to chime in here, there may be a better spot in the thread to
> > mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> > which I have on my todo list somwhere to replace the other generic
> > implementations like that in mips.
> >
> >   arch/openrisc/include/asm/cmpxchg.h
> >
> > The idea would be that architectures just implement these methods:
> >
> >   long cmpxchg_u32(*ptr,old,new)
> >   long xchg_u32(*ptr,val)
> >
> > Then the rest of the generic header would implement cmpxchg.
>
> I like the idea of generalizing it a little further. I'd suggest staying a
> little closer to the existing naming here though, as we already have
> cmpxchg() for the type-agnostic version, and cmpxchg64() for the
> fixed-length 64-bit version.
>
> I think a nice interface between architecture-specific and architecture
> independent code would be to have architectures provide
> arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
> as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
> if they have instructions for those.
>
> The common code can then build cmpxchg16()/xchg16() on top of
> either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
> wrapper around those (or alternatively we can decide to have them
> only deal with fixed-32-bit and long/pointer sized atomics).
I think these emulation codes are suitable for some architectures but not riscv.

We shouldn't export xchg16/cmpxchg16(emulated by lr.w/sc.w) in riscv,
We should forbid these sub-word atomic primitive and lets the
programmers consider their atomic design.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
