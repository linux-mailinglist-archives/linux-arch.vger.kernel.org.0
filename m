Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC165046B7
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiDQEya (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiDQEy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 00:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3F53FD94;
        Sat, 16 Apr 2022 21:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD55DB80A1F;
        Sun, 17 Apr 2022 04:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79641C385AA;
        Sun, 17 Apr 2022 04:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650171110;
        bh=q9fcztGM71+vCsZD2N4sUtaABxXR93vfr2R7Ii6mFC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jUbXnBi9aMXK60wnUJjnyZw58Q3GYnhe/dy+0o6GJtQhO+IUFN0Dury2JuSnsaH2D
         21iHpkdwKQgjRAzcOahPeVVcCl4QYLXr1JwQcJ0TDZgo8Z3ccQAz4Ca/aq0vRGV4PS
         FhzFZdXkU7apPFJYQ2hW/+Y7ugiY7vezx1YyDsrZKU3n3+rCe0ZwwdA1lrckuRzpPD
         K9WO3KbWWNbEOAptuVga4h1/rXgfNejideMJiOQQ9ZuS+F3D4+R8EGi4uSWP1x/5Qb
         J9CYsLtiYDIIF8PDufa5skqzfYGR33WScBQsxzeM4Ps8mmalNQNZmJa8xc6rGeLOGq
         ctsnD/hOJLjfw==
Received: by mail-vs1-f50.google.com with SMTP id d9so10152505vsh.10;
        Sat, 16 Apr 2022 21:51:50 -0700 (PDT)
X-Gm-Message-State: AOAM532WMv4+IC/Si3qkUaUbPstHuapM2uxwVic5T9Yu3YM2ERz7ZAsn
        jASjXkGb5pfpOlczO8gbjZA7JgCo/A9kAcRxPHI=
X-Google-Smtp-Source: ABdhPJwe8VaBJyEULUgbn9Rxjc0N2mB5BdM3ji3bpONwyvqfGaJOdzxm8o3/Qi4EIqs0qE0oejXEmKnFqtUwR+buu3o=
X-Received: by 2002:a67:e181:0:b0:32a:335c:4ac1 with SMTP id
 e1-20020a67e181000000b0032a335c4ac1mr1455751vsl.2.1650171109426; Sat, 16 Apr
 2022 21:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com> <Ylt6zqPgimmKpJzg@tardis>
In-Reply-To: <Ylt6zqPgimmKpJzg@tardis>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Apr 2022 12:51:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
Message-ID: <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
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

Hi Boqun & Andrea,

On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> [...]
> >
> > If both the aq and rl bits are set, the atomic memory operation is
> > sequentially consistent and cannot be observed to happen before any
> > earlier memory operations or after any later memory operations in the
> > same RISC-V hart and to the same address domain.
> >                 "0:     lr.w     %[p],  %[c]\n"
> >                 "       sub      %[rc], %[p], %[o]\n"
> >                 "       bltz     %[rc], 1f\n".
> > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> >                 "       bnez     %[rc], 0b\n"
> > -               "       fence    rw, rw\n"
> >                 "1:\n"
> > So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
> >
>
> Can .aqrl order memory accesses before and after it (not against itself,
> against each other), i.e. act as a full memory barrier? For example, can
From the RVWMO spec description, the .aqrl annotation appends the same
effect with "fence rw, rw" to the AMO instruction, so it's RCsc.

Not only .aqrl, and I think the below also could be an RCsc when
sc.w.aq is executed:
A: Pre-Access
B: lr.w.rl ADDR-0
...
C: sc.w.aq ADDR-0
D: Post-Acess
Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
global memory order should be A->B->C->D when sc.w.aq is executed. For
the amoswap

The purpose of the whole patchset is to reduce the usage of
independent fence rw, rw instructions, and maximize the usage of the
.aq/.rl/.aqrl aonntation of RISC-V.

                __asm__ __volatile__ (                                  \
                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w.rl %1, %z4, %2\n"                  \
                        "       bnez %1, 0b\n"                          \
                        "       fence rw, rw\n"                         \
                        "1:\n"                                          \

> we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
> following litmus test?
>
>     C lr-sc-aqrl-pair-vs-full-barrier
>
>     {}
>
>     P0(int *x, int *y, atomic_t *u)
>     {
>             int r0;
>             int r1;
>
>             WRITE_ONCE(*x, 1);
>             r0 = atomic_cmpxchg(u, 0, 1);
>             r1 = READ_ONCE(*y);
>     }
>
>     P1(int *x, int *y, atomic_t *v)
>     {
>             int r0;
>             int r1;
>
>             WRITE_ONCE(*y, 1);
>             r0 = atomic_cmpxchg(v, 0, 1);
>             r1 = READ_ONCE(*x);
>     }
>
>     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
I think my patchset won't affect the above sequence guarantee. Current
RISC-V implementation only gives RCsc when the original value is the
same at least once. So I prefer RISC-V cmpxchg should be:


-                       "0:     lr.w %0, %2\n"                          \
+                      "0:     lr.w.rl %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w.rl %1, %z4, %2\n"                  \
                        "       bnez %1, 0b\n"                          \
-                       "       fence rw, rw\n"                         \
                        "1:\n"                                          \
+                        "       fence w, rw\n"                    \

To give an unconditional RSsc for atomic_cmpxchg.

>
> Regards,
> Boqun



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
