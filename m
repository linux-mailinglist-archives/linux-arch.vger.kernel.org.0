Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146685046E0
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiDQGsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 02:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiDQGsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 02:48:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F722E9C1;
        Sat, 16 Apr 2022 23:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22162B808C5;
        Sun, 17 Apr 2022 06:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD53C385AE;
        Sun, 17 Apr 2022 06:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650177961;
        bh=u1JZibw2SpzwrnUWA+7a2n40zCJA2T7hl2y+CHc8Bys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Enrqywv5QK/rGP/TSzPz7EDiCfzO7oUFM+gV9hISYF3o8MX9TaNn4p+MrZmvNIgRr
         XBS6dL+niNqG52aeWt9BUhxB10PekY0NMcIlgQpQ3M5N0tQCpsJB62aRIXVuRZc6rh
         mhf8AEkP6Zxcd3RP2nFG5UDWv9/Y84mtErwGvua8VW3ltd4kvOKW6hMpK3dHqxD1QH
         ADudjR29kpmss52VawYFmRlwfC7C0INAyjz9WDjKgtMwRmkw5QLN1ytjr97v9SbpD1
         IMGcoYQuIXPI3jUJLS/C/SMHtac1j7LieFoN1ByLO9JDU3K4PaCmP5zGLkKB6pSRLA
         I53hTqmnqaSPQ==
Received: by mail-vs1-f52.google.com with SMTP id 190so4384440vse.8;
        Sat, 16 Apr 2022 23:46:01 -0700 (PDT)
X-Gm-Message-State: AOAM5318EBHCZcJd/u8e/PWTeRxcU8vm7VfeiumuqrJu8S4HcN6uBqSd
        R/qeGsGQD3T4oCo1WRQe21TTsuMG3z0wSIsn/AY=
X-Google-Smtp-Source: ABdhPJz/1b5SsJdYKN3GAsgGRqoX5UpyKRVV4cX9w9xRdQtt+NvH5Ejr5oS1GHvNtweZlab8vqZ3fbLTSj4TtJFlgjk=
X-Received: by 2002:a05:6102:dd1:b0:325:80a9:b5d7 with SMTP id
 e17-20020a0561020dd100b0032580a9b5d7mr1421799vst.51.1650177960581; Sat, 16
 Apr 2022 23:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis> <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
 <Ylu0GqNmYmCnpv9Z@tardis>
In-Reply-To: <Ylu0GqNmYmCnpv9Z@tardis>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Apr 2022 14:45:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSp1+gvyPM481_KS58icqwqwkehQUXMMfRNboOrNdWHxg@mail.gmail.com>
Message-ID: <CAJF2gTSp1+gvyPM481_KS58icqwqwkehQUXMMfRNboOrNdWHxg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Apr 17, 2022 at 2:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Sun, Apr 17, 2022 at 12:51:38PM +0800, Guo Ren wrote:
> > Hi Boqun & Andrea,
> >
> > On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> > > [...]
> > > >
> > > > If both the aq and rl bits are set, the atomic memory operation is
> > > > sequentially consistent and cannot be observed to happen before any
> > > > earlier memory operations or after any later memory operations in the
> > > > same RISC-V hart and to the same address domain.
> > > >                 "0:     lr.w     %[p],  %[c]\n"
> > > >                 "       sub      %[rc], %[p], %[o]\n"
> > > >                 "       bltz     %[rc], 1f\n".
> > > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > > +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > >                 "       bnez     %[rc], 0b\n"
> > > > -               "       fence    rw, rw\n"
> > > >                 "1:\n"
> > > > So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
> > > >
> > >
> > > Can .aqrl order memory accesses before and after it (not against itself,
> > > against each other), i.e. act as a full memory barrier? For example, can
> > From the RVWMO spec description, the .aqrl annotation appends the same
> > effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
> >
>
> Thanks for the confirmation, btw, where can I find the RVWMO spec?
RVWMO section:
https://five-embeddev.com/riscv-isa-manual/latest/rvwmo.html#ch:memorymodel

ATOMIC instructions:
https://five-embeddev.com/riscv-isa-manual/latest/a.html#atomics

>
> > Not only .aqrl, and I think the below also could be an RCsc when
> > sc.w.aq is executed:
> > A: Pre-Access
> > B: lr.w.rl ADDR-0
> > ...
> > C: sc.w.aq ADDR-0
> > D: Post-Acess
> > Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
> > global memory order should be A->B->C->D when sc.w.aq is executed. For
> > the amoswap
> >
> > The purpose of the whole patchset is to reduce the usage of
> > independent fence rw, rw instructions, and maximize the usage of the
> > .aq/.rl/.aqrl aonntation of RISC-V.
> >
> >                 __asm__ __volatile__ (                                  \
> >                         "0:     lr.w %0, %2\n"                          \
> >                         "       bne  %0, %z3, 1f\n"                     \
> >                         "       sc.w.rl %1, %z4, %2\n"                  \
> >                         "       bnez %1, 0b\n"                          \
> >                         "       fence rw, rw\n"                         \
> >                         "1:\n"                                          \
> >
> > > we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
> > > following litmus test?
> > >
> > >     C lr-sc-aqrl-pair-vs-full-barrier
> > >
> > >     {}
> > >
> > >     P0(int *x, int *y, atomic_t *u)
> > >     {
> > >             int r0;
> > >             int r1;
> > >
> > >             WRITE_ONCE(*x, 1);
> > >             r0 = atomic_cmpxchg(u, 0, 1);
> > >             r1 = READ_ONCE(*y);
> > >     }
> > >
> > >     P1(int *x, int *y, atomic_t *v)
> > >     {
> > >             int r0;
> > >             int r1;
> > >
> > >             WRITE_ONCE(*y, 1);
> > >             r0 = atomic_cmpxchg(v, 0, 1);
> > >             r1 = READ_ONCE(*x);
> > >     }
> > >
> > >     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
> > I think my patchset won't affect the above sequence guarantee. Current
> > RISC-V implementation only gives RCsc when the original value is the
> > same at least once. So I prefer RISC-V cmpxchg should be:
> >
> >
> > -                       "0:     lr.w %0, %2\n"                          \
> > +                      "0:     lr.w.rl %0, %2\n"                          \
> >                         "       bne  %0, %z3, 1f\n"                     \
> >                         "       sc.w.rl %1, %z4, %2\n"                  \
> >                         "       bnez %1, 0b\n"                          \
> > -                       "       fence rw, rw\n"                         \
> >                         "1:\n"                                          \
> > +                        "       fence w, rw\n"                    \
> >
> > To give an unconditional RSsc for atomic_cmpxchg.
> >
>
> Note that Linux kernel doesn't require cmpxchg() to provide any order if
> cmpxchg() fails to update the memory location. So you won't need to
> strengthen the atomic_cmpxchg().
Thx for the clarification.

>
> Regards,
> Boqun
>
> > >
> > > Regards,
> > > Boqun
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
