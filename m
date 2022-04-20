Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5335080A1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351114AbiDTFgO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiDTFgO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 01:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666E36B6A;
        Tue, 19 Apr 2022 22:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 528A961770;
        Wed, 20 Apr 2022 05:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87352C385B3;
        Wed, 20 Apr 2022 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650432807;
        bh=O+/nEn2mJyhhn71+9IxwyXxxEqAUenQtbBMtmhNPlZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F8XWcttAhn58uuRRQCfZPF4XR4sjrUNLlEOu7E4EnbPGA+ZUiCa3hSOwX96HY7H24
         l1kIK4aMq1Z0N9e35ItfcLgPzagAOw66G4sMnjmfvXfn9ds17S0ZOzNUuogFbMlO8m
         rSyNbnH1K8giaSEuXuzdrdqqdhQnCnx0xwffBS1oFSG+maukHZNmguAJaE2PxAmFiT
         xM9nSoqRjd3tOrpsMbxCLPNSZ3vOvRIAydywm1E9s7WciFYosZyruKQ9QfiiHbpkHU
         MVgd10fduek7QfJRqyrQUzIgCcIFjVml0fJ8Dec3Wa57ygHjjoC5Zc6LiDh0uiIYjQ
         b3hyYEIgEnDmg==
Received: by mail-ua1-f41.google.com with SMTP id g6so230943uaw.8;
        Tue, 19 Apr 2022 22:33:27 -0700 (PDT)
X-Gm-Message-State: AOAM533f+5YO8YwidFTNFaxVHBF2bYK9yBxK3ki+luSgVpJou+CPuF2w
        JiBOcDd1ftsdRRiaf5MYd7JhTeTnYxhq10emdyY=
X-Google-Smtp-Source: ABdhPJyGiHphDY/NN2jjsA9reE76seGGyg1Qp3EEewMxF5ur2Eod0CCcuEaMFxNqOaSuEE8GU6Hny7R/Sp6/S526sSw=
X-Received: by 2002:ab0:4306:0:b0:35c:df5b:d7ab with SMTP id
 k6-20020ab04306000000b0035cdf5bd7abmr5134224uak.83.1650432806290; Tue, 19 Apr
 2022 22:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis> <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
 <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com>
In-Reply-To: <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Apr 2022 13:33:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
Message-ID: <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
To:     Dan Lustig <dlustig@nvidia.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Dan,

On Wed, Apr 20, 2022 at 1:12 AM Dan Lustig <dlustig@nvidia.com> wrote:
>
> On 4/17/2022 12:51 AM, Guo Ren wrote:
> > Hi Boqun & Andrea,
> >
> > On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> >> [...]
> >>>
> >>> If both the aq and rl bits are set, the atomic memory operation is
> >>> sequentially consistent and cannot be observed to happen before any
> >>> earlier memory operations or after any later memory operations in the
> >>> same RISC-V hart and to the same address domain.
> >>>                 "0:     lr.w     %[p],  %[c]\n"
> >>>                 "       sub      %[rc], %[p], %[o]\n"
> >>>                 "       bltz     %[rc], 1f\n".
> >>> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> >>> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> >>>                 "       bnez     %[rc], 0b\n"
> >>> -               "       fence    rw, rw\n"
> >>>                 "1:\n"
> >>> So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
> >>>
> >>
> >> Can .aqrl order memory accesses before and after it (not against itself,
> >> against each other), i.e. act as a full memory barrier? For example, can
> > From the RVWMO spec description, the .aqrl annotation appends the same
> > effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
> >
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
>
> These opcodes aren't actually meaningful, unfortunately.
>
> Quoting the ISA manual chapter 10.2: "Software should not set the rl bit
> on an LR instruction unless the aq bit is also set, nor should software
> set the aq bit on an SC instruction unless the rl bit is also set."
1. Oh, I've missed the behind half of the ISA manual. But why can't we
utilize lr.rl & sc.aq in software programming to guarantee the
sequence?

2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
right? And reducing a fence instruction to gain better performance:
                "0:     lr.w     %[p],  %[c]\n"
                 "       sub      %[rc], %[p], %[o]\n"
                 "       bltz     %[rc], 1f\n".
 -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
 +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
                 "       bnez     %[rc], 0b\n"
 -               "       fence    rw, rw\n"

>
> Dan
>
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
> >> we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
> >> following litmus test?
> >>
> >>     C lr-sc-aqrl-pair-vs-full-barrier
> >>
> >>     {}
> >>
> >>     P0(int *x, int *y, atomic_t *u)
> >>     {
> >>             int r0;
> >>             int r1;
> >>
> >>             WRITE_ONCE(*x, 1);
> >>             r0 = atomic_cmpxchg(u, 0, 1);
> >>             r1 = READ_ONCE(*y);
> >>     }
> >>
> >>     P1(int *x, int *y, atomic_t *v)
> >>     {
> >>             int r0;
> >>             int r1;
> >>
> >>             WRITE_ONCE(*y, 1);
> >>             r0 = atomic_cmpxchg(v, 0, 1);
> >>             r1 = READ_ONCE(*x);
> >>     }
> >>
> >>     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
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
> >>
> >> Regards,
> >> Boqun
> >
> >
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
