Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CCA79F8E6
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 05:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjINDcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjINDcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 23:32:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85991BDD;
        Wed, 13 Sep 2023 20:32:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6DEC433B6;
        Thu, 14 Sep 2023 03:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694662321;
        bh=DusEPVDKiSx1swuzcqQMTs8Q8HtpgztTZrMcpKQtpCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dODeb/G3iHr4aVOxB5+3fD8aBvwE6ma7kdoGcz0QYXjCLmgAis218d//25oGy/Z5r
         oBxpqoWU8Ad0/V5+JBkk8ZCLW4GpsyZRWOzRLqOhyoYERI2tjHQoNJSj/LPaBcNVH/
         C9XoPNbesJEIgQya7wYuMf12hE7InGZQ1VEuEYlCYBm9j5iTcT/JoLPkHYssRKnO7f
         1HiJvDi0HhDvhW/uphX8nSqVzpwrxdezYkzGNH+CSApujy3ogQSPif+d1B3LCaWsL2
         Hb2PIw8C62ODHN8oIrJtVQgn+zaAcgC715/V0bIs+JcCDtbFcZ5+MjQEfxA3PhcKlM
         lbQz4i2FZ1p6Q==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52c9be5e6f0so469639a12.1;
        Wed, 13 Sep 2023 20:32:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMvynzR32C9hjT35BUk4ijVQmUefgaGUKZ7Ryq5m2AL95ZxKDw
        sRQI9Szknycm0JYKKnAGW3jQTbJFZ4UAXb0GRX0=
X-Google-Smtp-Source: AGHT+IHGja97w/vJU4h/UzpGxSln5/p0YpAWDgwkkCHzYpJ8KnV3HJDkkes8QC3oPatQObv7GCfNb0eLY/JCPUuA2AU=
X-Received: by 2002:aa7:d38e:0:b0:523:40d0:34d1 with SMTP id
 x14-20020aa7d38e000000b0052340d034d1mr3252243edq.4.1694662319071; Wed, 13 Sep
 2023 20:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <ae320af5-6cca-4689-aa66-9d0193713d40@app.fastmail.com> <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
In-Reply-To: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 14 Sep 2023 11:31:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRF5t3cYy_Y2hHLBKjx2arsu+gugDb_g4EH9M2oyKK1vQ@mail.gmail.com>
Message-ID: <CAJF2gTRF5t3cYy_Y2hHLBKjx2arsu+gugDb_g4EH9M2oyKK1vQ@mail.gmail.com>
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce ERRATA_THEAD_QSPINLOCK
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     sorear@fastmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        xiaoguang.xing@sophgo.com, Bjorn Topel <bjorn@rivosinc.com>,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 2:54=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> On Sun, 06 Aug 2023 22:23:34 PDT (-0700), sorear@fastmail.com wrote:
> > On Wed, Aug 2, 2023, at 12:46 PM, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> According to qspinlock requirements, RISC-V gives out a weak LR/SC
> >> forward progress guarantee which does not satisfy qspinlock. But
> >> many vendors could produce stronger forward guarantee LR/SC to
> >> ensure the xchg_tail could be finished in time on any kind of
> >> hart. T-HEAD is the vendor which implements strong forward
> >> guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
> >> with errata help.
> >>
> >> T-HEAD early version of processors has the merge buffer delay
> >> problem, so we need ERRATA_WRITEONCE to support qspinlock.
> >>
> >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> ---
> >>  arch/riscv/Kconfig.errata              | 13 +++++++++++++
> >>  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
> >>  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
> >>  arch/riscv/include/asm/vendorid_list.h |  3 ++-
> >>  arch/riscv/kernel/cpufeature.c         |  3 ++-
> >>  5 files changed, 61 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> >> index 4745a5c57e7c..eb43677b13cc 100644
> >> --- a/arch/riscv/Kconfig.errata
> >> +++ b/arch/riscv/Kconfig.errata
> >> @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
> >>
> >>        If you don't know what to do here, say "Y".
> >>
> >> +config ERRATA_THEAD_QSPINLOCK
> >> +    bool "Apply T-Head queued spinlock errata"
> >> +    depends on ERRATA_THEAD
> >> +    default y
> >> +    help
> >> +      The T-HEAD C9xx processors implement strong fwd guarantee LR/SC=
 to
> >> +      match the xchg_tail requirement of qspinlock.
> >> +
> >> +      This will apply the QSPINLOCK errata to handle the non-standard
> >> +      behavior via using qspinlock instead of ticket_lock.
> >> +
> >> +      If you don't know what to do here, say "Y".
> >
> > If this is to be applied, I would like to see a detailed explanation so=
mewhere,
> > preferably with citations, of:
> >
> > (a) The memory model requirements for qspinlock
> > (b) Why, with arguments, RISC-V does not architecturally meet (a)
> > (c) Why, with arguments, T-HEAD C9xx meets (a)
> > (d) Why at least one other architecture which defines ARCH_USE_QUEUED_S=
PINLOCKS
> >     meets (a)
>
> I agree.
>
> Just having a magic fence that makes qspinlocks stop livelocking on some
> processors is going to lead to a mess -- I'd argue this means those
> processors just don't provide the forward progress guarantee, but we'd
> really need something written down about what this new custom
> instruction aliasing as a fence does.
The "magic fence" is not related to the LR/SC forward progress
guarantee, and it's our processors' store buffer hardware problem that
needs to be fixed. Not only is qspinlock suffering on it, but also
kernel/locking/osq_lock.c.

This is about this patch:
https://lore.kernel.org/linux-riscv/20230910082911.3378782-10-guoren@kernel=
.org/
I've written down the root cause of that patch: The "new custom fence
instruction" triggers the store buffer flush.

Only the normal store instruction has the problem, and atomic stores
(including LR/SC) are okay.

>
> > As far as I can tell, the RISC-V guarantees concerning constrained LR/S=
C loops
> > (livelock freedom but no starvation freedom) are exactly the same as th=
ose in
> > Armv8 (as of 0487F.c) for equivalent loops, and xchg_tail compiles to a
> > constrained LR/SC loop with guaranteed eventual success (with -O1).  Cl=
early you
> > disagree; I would like to see your perspective.
>
> It sounds to me like this processor might be quite broken: if it's
> permanently holding stores in a buffer we're going to have more issues
> than just qspinlock, pretty much anything concurrent is going to have
> issues -- and that's not just in the kernel, there's concurrent
> userspace code as well.
Yes, the userspace scenarios are our worries because modifying the
userspace atomic library is impossible. Now, we are stress-testing
various userspace parallel applications, especially userspace queued
spinlock, on the 128-core hardware platform.
We haven't detected the problem in the userspace, and it could be
because of timer interrupts, which breaks the store buffer waiting.

>
> > -s
> >
> >> +
> >>  endmenu # "CPU errata selection"
> >> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thea=
d/errata.c
> >> index 881729746d2e..d560dc45c0e7 100644
> >> --- a/arch/riscv/errata/thead/errata.c
> >> +++ b/arch/riscv/errata/thead/errata.c
> >> @@ -86,6 +86,27 @@ static bool errata_probe_write_once(unsigned int st=
age,
> >>      return false;
> >>  }
> >>
> >> +static bool errata_probe_qspinlock(unsigned int stage,
> >> +                               unsigned long arch_id, unsigned long i=
mpid)
> >> +{
> >> +    if (!IS_ENABLED(CONFIG_ERRATA_THEAD_QSPINLOCK))
> >> +            return false;
> >> +
> >> +    /*
> >> +     * The queued_spinlock torture would get in livelock without
> >> +     * ERRATA_THEAD_WRITE_ONCE fixup for the early versions of T-HEAD
> >> +     * processors.
> >> +     */
> >> +    if (arch_id =3D=3D 0 && impid =3D=3D 0 &&
> >> +        !IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> >> +            return false;
> >> +
> >> +    if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> >> +            return true;
> >> +
> >> +    return false;
> >> +}
> >> +
> >>  static u32 thead_errata_probe(unsigned int stage,
> >>                            unsigned long archid, unsigned long impid)
> >>  {
> >> @@ -103,6 +124,9 @@ static u32 thead_errata_probe(unsigned int stage,
> >>      if (errata_probe_write_once(stage, archid, impid))
> >>              cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> >>
> >> +    if (errata_probe_qspinlock(stage, archid, impid))
> >> +            cpu_req_errata |=3D BIT(ERRATA_THEAD_QSPINLOCK);
> >> +
> >>      return cpu_req_errata;
> >>  }
> >>
> >> diff --git a/arch/riscv/include/asm/errata_list.h
> >> b/arch/riscv/include/asm/errata_list.h
> >> index fbb2b8d39321..a696d18d1b0d 100644
> >> --- a/arch/riscv/include/asm/errata_list.h
> >> +++ b/arch/riscv/include/asm/errata_list.h
> >> @@ -141,6 +141,26 @@ asm volatile(ALTERNATIVE(                        =
                       \
> >>      : "=3Dr" (__ovl) :                                               =
 \
> >>      : "memory")
> >>
> >> +static __always_inline bool
> >> +riscv_has_errata_thead_qspinlock(void)
> >> +{
> >> +    if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> >> +            asm_volatile_goto(
> >> +            ALTERNATIVE(
> >> +            "j      %l[l_no]", "nop",
> >> +            THEAD_VENDOR_ID,
> >> +            ERRATA_THEAD_QSPINLOCK,
> >> +            CONFIG_ERRATA_THEAD_QSPINLOCK)
> >> +            : : : : l_no);
> >> +    } else {
> >> +            goto l_no;
> >> +    }
> >> +
> >> +    return true;
> >> +l_no:
> >> +    return false;
> >> +}
> >> +
> >>  #endif /* __ASSEMBLY__ */
> >>
> >>  #endif
> >> diff --git a/arch/riscv/include/asm/vendorid_list.h
> >> b/arch/riscv/include/asm/vendorid_list.h
> >> index 73078cfe4029..1f1d03877f5f 100644
> >> --- a/arch/riscv/include/asm/vendorid_list.h
> >> +++ b/arch/riscv/include/asm/vendorid_list.h
> >> @@ -19,7 +19,8 @@
> >>  #define     ERRATA_THEAD_CMO 1
> >>  #define     ERRATA_THEAD_PMU 2
> >>  #define     ERRATA_THEAD_WRITE_ONCE 3
> >> -#define     ERRATA_THEAD_NUMBER 4
> >> +#define     ERRATA_THEAD_QSPINLOCK 4
> >> +#define     ERRATA_THEAD_NUMBER 5
> >>  #endif
> >>
> >>  #endif
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufea=
ture.c
> >> index f8dbbe1bbd34..d9694fe40a9a 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
> >>               * spinlock value, the only way is to change from queued_=
spinlock to
> >>               * ticket_spinlock, but can not be vice.
> >>               */
> >> -            if (!force_qspinlock) {
> >> +            if (!force_qspinlock &&
> >> +                !riscv_has_errata_thead_qspinlock()) {
> >>                      set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
> >>              }
> >>  #endif
> >> --
> >> 2.36.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren
