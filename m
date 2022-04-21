Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0B509C6A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387732AbiDUJmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiDUJmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 05:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852C1AF37;
        Thu, 21 Apr 2022 02:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB2CB823AB;
        Thu, 21 Apr 2022 09:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4AAC385AC;
        Thu, 21 Apr 2022 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650533962;
        bh=TKu/sxCbrXinnTKyGp1ARSw/I9VGSbCrBPL3G9CHtqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=upB6LaoAQE85lW1nWPieV/TdsTSpRqq+P1Fn76wgxiipt6xVer7//n/E2rCLJjPAA
         BEG9dU7hoT0LfsIyt4HOHQI0rcUD2Jxizj2mbhrQGM+yMGFOJm2tadXVuht/qZAFW+
         IbTmoqEatshFQru1Nv0WOHWd3PXACzEw7/fZDeIJlXqvt2Y5qcFNiUp+GZ3F2oh9F8
         QIeCvlSdwVTs7hsEvDdW3OO+nzGzoPd/Xp/eChOXJK2wCL+jA21b5YbzrgfeG8ytGt
         4C+7l9iylJufQA/QWHla2rw5EEhW4He9lD3kW4hwjR0wRyCEu7lBWIEnoUJYhJxi55
         HxkzQWTTt95kg==
Received: by mail-ua1-f51.google.com with SMTP id o10so1622730uar.0;
        Thu, 21 Apr 2022 02:39:22 -0700 (PDT)
X-Gm-Message-State: AOAM5307arkpwK2DBLZCE/1hWIRj2yRf5/qVs56agEsP6equQQPPJLek
        xmfDn8MN7IoIKVkmwvR/84iR3t/P8SX095Nbcw4=
X-Google-Smtp-Source: ABdhPJyj5ZaPcasAU7Kyks+YWcmMk/mOYXYoPD/J7hr6Rn8n2cDQpD9mPbZxb65rTgSAovcpuH0Q1EPSHT/FDI+yQVM=
X-Received: by 2002:ab0:2703:0:b0:35a:78c:f23a with SMTP id
 s3-20020ab02703000000b0035a078cf23amr7359846uao.114.1650533961152; Thu, 21
 Apr 2022 02:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220412034957.1481088-1-guoren@kernel.org> <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis> <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
 <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com> <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
 <41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com>
In-Reply-To: <41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Apr 2022 17:39:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSD1CsMf2uFXbv4qekh72r6iY-0BVaBwA8Ntu0L6WcEPA@mail.gmail.com>
Message-ID: <CAJF2gTSD1CsMf2uFXbv4qekh72r6iY-0BVaBwA8Ntu0L6WcEPA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dan,

On Thu, Apr 21, 2022 at 1:03 AM Dan Lustig <dlustig@nvidia.com> wrote:
>
> On 4/20/2022 1:33 AM, Guo Ren wrote:
> > Thx Dan,
> >
> > On Wed, Apr 20, 2022 at 1:12 AM Dan Lustig <dlustig@nvidia.com> wrote:
> >>
> >> On 4/17/2022 12:51 AM, Guo Ren wrote:
> >>> Hi Boqun & Andrea,
> >>>
> >>> On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>>
> >>>> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> >>>> [...]
> >>>>>
> >>>>> If both the aq and rl bits are set, the atomic memory operation is
> >>>>> sequentially consistent and cannot be observed to happen before any
> >>>>> earlier memory operations or after any later memory operations in the
> >>>>> same RISC-V hart and to the same address domain.
> >>>>>                 "0:     lr.w     %[p],  %[c]\n"
> >>>>>                 "       sub      %[rc], %[p], %[o]\n"
> >>>>>                 "       bltz     %[rc], 1f\n".
> >>>>> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> >>>>> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> >>>>>                 "       bnez     %[rc], 0b\n"
> >>>>> -               "       fence    rw, rw\n"
> >>>>>                 "1:\n"
> >>>>> So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
> >>>>>
> >>>>
> >>>> Can .aqrl order memory accesses before and after it (not against itself,
> >>>> against each other), i.e. act as a full memory barrier? For example, can
> >>> From the RVWMO spec description, the .aqrl annotation appends the same
> >>> effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
> >>>
> >>> Not only .aqrl, and I think the below also could be an RCsc when
> >>> sc.w.aq is executed:
> >>> A: Pre-Access
> >>> B: lr.w.rl ADDR-0
> >>> ...
> >>> C: sc.w.aq ADDR-0
> >>> D: Post-Acess
> >>> Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
> >>> global memory order should be A->B->C->D when sc.w.aq is executed. For
> >>> the amoswap
> >>
> >> These opcodes aren't actually meaningful, unfortunately.
> >>
> >> Quoting the ISA manual chapter 10.2: "Software should not set the rl bit
> >> on an LR instruction unless the aq bit is also set, nor should software
> >> set the aq bit on an SC instruction unless the rl bit is also set."
> > 1. Oh, I've missed the behind half of the ISA manual. But why can't we
> > utilize lr.rl & sc.aq in software programming to guarantee the
> > sequence?
>
> lr.aq and sc.rl map more naturally to hardware than lr.rl and sc.aq.
> Plus, they just aren't common operations to begin with, e.g., there
> is no smp_store_acquire() or smp_load_release(), nor are there
> equivalents in C/C++ atomics.
First, thx for pointing out that my patch violates the rules defined
in the ISA manual. I've abandoned these parts in v3.

It's easy to let hw support lr.rl & sc.aq (eg: our hardware supports
them). I agree there are no equivalents in C/C++ atomics. But they are
useful for LR/SC pairs to implement atomic_acqurie/release semantics.
Compare below:
A): fence rw, r; lr
B): lr.rl
The A has another "fence ,r" effect in semantics, it's over commit
from a software design view.

ps: Current definition has problems:
#define RISCV_ACQUIRE_BARRIER           "\tfence r , rw\n"
#define RISCV_RELEASE_BARRIER           "\tfence rw,  w\n"

#define __cmpxchg_release(ptr, old, new, size)                          \
...
                __asm__ __volatile__ (                                  \
                        RISCV_RELEASE_BARRIER                           \
                        "0:     lr.w %0, %2\n"                          \

That means "fence rw, w" can't prevent lr.w beyond the fence, we need
a "fence.rw. r" here. Here is the Fixup patch which I'm preparing:

From 14c93aca0c3b10cf134791cf491b459972a36ec4 Mon Sep 17 00:00:00 2001
From: Guo Ren <guoren@linux.alibaba.com>
Date: Thu, 21 Apr 2022 16:44:48 +0800
Subject: [PATCH] riscv: atomic: Fixup wrong __atomic_acquire/release_fence
 implementation

Current RISCV_ACQUIRE/RELEASE_BARRIER is for spin_lock not atomic.

__cmpxchg_release(ptr, old, new, size)
...
        __asm__ __volatile__ (
                        RISCV_RELEASE_BARRIER
                        "0:     lr.w %0, %2\n"

The "fence rw, w -> lr.w" is invalid and lr would beyond fence, so
we need "fence rw, r -> lr.w" here. Atomic acquire is the same.

Fixes: 0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with fences")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Dan Lustig <dlustig@nvidia.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/include/asm/atomic.h  | 4 ++--
 arch/riscv/include/asm/cmpxchg.h | 8 ++++----
 arch/riscv/include/asm/fence.h   | 4 ++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index aef8aa9ac4f4..7cd66eba6ec3 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -20,10 +20,10 @@
 #include <asm/barrier.h>

 #define __atomic_acquire_fence()                                       \
-       __asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
+       __asm__ __volatile__(RISCV_ATOMIC_ACQUIRE_BARRIER "":::"memory")

 #define __atomic_release_fence()                                       \
-       __asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
+       __asm__ __volatile__(RISCV_ATOMIC_RELEASE_BARRIER"" ::: "memory");

 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 9269fceb86e0..605edc2fca3b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -217,7 +217,7 @@
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w %1, %z4, %2\n"                     \
                        "       bnez %1, 0b\n"                          \
-                       RISCV_ACQUIRE_BARRIER                           \
+                       RISCV_ATOMIC_ACQUIRE_BARRIER                    \
                        "1:\n"                                          \
                        : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
                        : "rJ" ((long)__old), "rJ" (__new)              \
@@ -229,7 +229,7 @@
                        "       bne %0, %z3, 1f\n"                      \
                        "       sc.d %1, %z4, %2\n"                     \
                        "       bnez %1, 0b\n"                          \
-                       RISCV_ACQUIRE_BARRIER                           \
+                       RISCV_ATOMIC_ACQUIRE_BARRIER                    \
                        "1:\n"                                          \
                        : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
                        : "rJ" (__old), "rJ" (__new)                    \
@@ -259,7 +259,7 @@
        switch (size) {                                                 \
        case 4:                                                         \
                __asm__ __volatile__ (                                  \
-                       RISCV_RELEASE_BARRIER                           \
+                       RISCV_ATOMIC_RELEASE_BARRIER                    \
                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w %1, %z4, %2\n"                     \
@@ -271,7 +271,7 @@
                break;                                                  \
        case 8:                                                         \
                __asm__ __volatile__ (                                  \
-                       RISCV_RELEASE_BARRIER                           \
+                       RISCV_ATOMIC_RELEASE_BARRIER                    \
                        "0:     lr.d %0, %2\n"                          \
                        "       bne %0, %z3, 1f\n"                      \
                        "       sc.d %1, %z4, %2\n"                     \
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 2b443a3a487f..4e446d64f04f 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -4,9 +4,13 @@
 #ifdef CONFIG_SMP
 #define RISCV_ACQUIRE_BARRIER          "\tfence r , rw\n"
 #define RISCV_RELEASE_BARRIER          "\tfence rw,  w\n"
+#define RISCV_ATOMIC_ACQUIRE_BARRIER   "\tfence w , rw\n"
+#define RISCV_ATOMIC_RELEASE_BARRIER   "\tfence rw,  r\n"
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
+#define RISCV_ATOMIC_ACQUIRE_BARRIER
+#define RISCV_ATOMIC_RELEASE_BARRIER
 #endif

 #endif /* _ASM_RISCV_FENCE_H */


>
> > 2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
> > right? And reducing a fence instruction to gain better performance:
> >                 "0:     lr.w     %[p],  %[c]\n"
> >                  "       sub      %[rc], %[p], %[o]\n"
> >                  "       bltz     %[rc], 1f\n".
> >  -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> >  +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> >                  "       bnez     %[rc], 0b\n"
> >  -               "       fence    rw, rw\n"
>
> Yes, using .aqrl is valid.
Thx and I think the below is also valid, right?

-                       RISCV_RELEASE_BARRIER                           \
-                       "       amoswap.w %0, %2, %1\n"                 \
+                       "       amoswap.w.rl %0, %2, %1\n"              \

-                       "       amoswap.d %0, %2, %1\n"                 \
-                       RISCV_ACQUIRE_BARRIER                           \
+                       "       amoswap.d.aq %0, %2, %1\n"              \

>
> Dan
>
> >>
> >> Dan
> >>
> >>> The purpose of the whole patchset is to reduce the usage of
> >>> independent fence rw, rw instructions, and maximize the usage of the
> >>> .aq/.rl/.aqrl aonntation of RISC-V.
> >>>
> >>>                 __asm__ __volatile__ (                                  \
> >>>                         "0:     lr.w %0, %2\n"                          \
> >>>                         "       bne  %0, %z3, 1f\n"                     \
> >>>                         "       sc.w.rl %1, %z4, %2\n"                  \
> >>>                         "       bnez %1, 0b\n"                          \
> >>>                         "       fence rw, rw\n"                         \
> >>>                         "1:\n"                                          \
> >>>
> >>>> we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
> >>>> following litmus test?
> >>>>
> >>>>     C lr-sc-aqrl-pair-vs-full-barrier
> >>>>
> >>>>     {}
> >>>>
> >>>>     P0(int *x, int *y, atomic_t *u)
> >>>>     {
> >>>>             int r0;
> >>>>             int r1;
> >>>>
> >>>>             WRITE_ONCE(*x, 1);
> >>>>             r0 = atomic_cmpxchg(u, 0, 1);
> >>>>             r1 = READ_ONCE(*y);
> >>>>     }
> >>>>
> >>>>     P1(int *x, int *y, atomic_t *v)
> >>>>     {
> >>>>             int r0;
> >>>>             int r1;
> >>>>
> >>>>             WRITE_ONCE(*y, 1);
> >>>>             r0 = atomic_cmpxchg(v, 0, 1);
> >>>>             r1 = READ_ONCE(*x);
> >>>>     }
> >>>>
> >>>>     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
> >>> I think my patchset won't affect the above sequence guarantee. Current
> >>> RISC-V implementation only gives RCsc when the original value is the
> >>> same at least once. So I prefer RISC-V cmpxchg should be:
> >>>
> >>>
> >>> -                       "0:     lr.w %0, %2\n"                          \
> >>> +                      "0:     lr.w.rl %0, %2\n"                          \
> >>>                         "       bne  %0, %z3, 1f\n"                     \
> >>>                         "       sc.w.rl %1, %z4, %2\n"                  \
> >>>                         "       bnez %1, 0b\n"                          \
> >>> -                       "       fence rw, rw\n"                         \
> >>>                         "1:\n"                                          \
> >>> +                        "       fence w, rw\n"                    \
> >>>
> >>> To give an unconditional RSsc for atomic_cmpxchg.
> >>>
> >>>>
> >>>> Regards,
> >>>> Boqun
> >>>
> >>>
> >>>
> >
> >
> >



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
