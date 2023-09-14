Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6A79F9A9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 06:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjINEuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 00:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjINEuF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 00:50:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305E1BC9;
        Wed, 13 Sep 2023 21:50:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9389C433AB;
        Thu, 14 Sep 2023 04:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694667000;
        bh=/3L0VWTa5Pjgz0Ojj0P0qiZhV/tsP6cp/tAvQ0qFAtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nGIQy+Sf7wMTjcR1wJZy4gsYF1HPbnpC5MQN2K8WSLCJEO3Wq9kiJwch04iELYi2i
         lOP9759mjnNBVyk3ySURSFx1YjNfJOvxisLC9Wyz/TYbBy3eu1t5ZZvEzkP0J/v+Ow
         BP0fID2K43Ni+EVMp7Dw9JkxiCNeH7vJfHRHsEnty6dQn8p+8cd0wmPk2BVA5Z6pzQ
         jkJBrfsR7HejgJBiygk8I0GGUzOySrfAcYZfQGwcsKjyEt5xzIsF+UH0W5b18mwAAT
         iZECZIrkbgRfuY2FyaZ5S2gZkweM7lJBGwO7d+2A6xN5pzljWjI2w6CyM32PoCK44D
         2MNY55ZIHk1Bg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so559510a12.0;
        Wed, 13 Sep 2023 21:50:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YxAHFDa/HUYUDHefc0TIIy5WXncaU4MErqkaDMqbQ0IXbgsLFNR
        tXyMDU2VpEbdc80+60WB5Lh8P6Xrf/nq+47Y3xg=
X-Google-Smtp-Source: AGHT+IHqtlFzol8KaeTbgXDkl2F9lTvq9ZdsSc4Be/Nr8WcmAYdkRL1jMLYJ9tV1XRVoshc7ZshEoUidVOyHAWlkf+0=
X-Received: by 2002:aa7:dcd4:0:b0:522:20a0:7eb8 with SMTP id
 w20-20020aa7dcd4000000b0052220a07eb8mr3816360edu.33.1694666999197; Wed, 13
 Sep 2023 21:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-7-guoren@kernel.org>
 <ZP2jL06TYGYVBhTN@gmail.com> <ZQIdbbzW79s5tfiI@redhat.com> <ZQIgTyJ-DETrK8k3@redhat.com>
In-Reply-To: <ZQIgTyJ-DETrK8k3@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 14 Sep 2023 12:49:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ=K_2km_AUZj1Vg8q2XgWB49-+nxViAa1mSAfppp6dnA@mail.gmail.com>
Message-ID: <CAJF2gTQ=K_2km_AUZj1Vg8q2XgWB49-+nxViAa1mSAfppp6dnA@mail.gmail.com>
Subject: Re: [PATCH V11 06/17] riscv: qspinlock: Introduce combo spinlock
To:     Leonardo Bras <leobras@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Wed, Sep 13, 2023 at 05:37:01PM -0300, Leonardo Bras wrote:
> > On Sun, Sep 10, 2023 at 07:06:23AM -0400, Guo Ren wrote:
> > > On Sun, Sep 10, 2023 at 04:29:00AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Combo spinlock could support queued and ticket in one Linux Image a=
nd
> > > > select them during boot time via errata mechanism. Here is the func
> > > > size (Bytes) comparison table below:
> > > >
> > > > TYPE                      : COMBO | TICKET | QUEUED
> > > > arch_spin_lock            : 106   | 60     | 50
> > > > arch_spin_unlock  : 54    | 36     | 26
> > > > arch_spin_trylock : 110   | 72     | 54
> > > > arch_spin_is_locked       : 48    | 34     | 20
> > > > arch_spin_is_contended    : 56    | 40     | 24
> > > > rch_spin_value_unlocked   : 48    | 34     | 24
> > > >
> > > > One example of disassemble combo arch_spin_unlock:
> > > >    0xffffffff8000409c <+14>:    nop                # detour slot
> > > >    0xffffffff800040a0 <+18>:    fence   rw,w       # queued spinloc=
k start
> > > >    0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinloc=
k end
> > > >    0xffffffff800040a8 <+26>:    ld      s0,8(sp)
> > > >    0xffffffff800040aa <+28>:    addi    sp,sp,16
> > > >    0xffffffff800040ac <+30>:    ret
> > > >    0xffffffff800040ae <+32>:    lw      a5,0(a4)   # ticket spinloc=
k start
> > > >    0xffffffff800040b0 <+34>:    sext.w  a5,a5
> > > >    0xffffffff800040b2 <+36>:    fence   rw,w
> > > >    0xffffffff800040b6 <+40>:    addiw   a5,a5,1
> > > >    0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
> > > >    0xffffffff800040ba <+44>:    srli    a5,a5,0x30
> > > >    0xffffffff800040bc <+46>:    sh      a5,0(a4)   # ticket spinloc=
k end
> > > >    0xffffffff800040c0 <+50>:    ld      s0,8(sp)
> > > >    0xffffffff800040c2 <+52>:    addi    sp,sp,16
> > > >    0xffffffff800040c4 <+54>:    ret
> > > >
> > > > The qspinlock is smaller and faster than ticket-lock when all are i=
n
> > > > fast-path, and combo spinlock could provide a compatible Linux Imag=
e
> > > > for different micro-arch design (weak/strict fwd guarantee LR/SC)
> > > > processors.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > ---
> > > >  arch/riscv/Kconfig                |  9 +++-
> > > >  arch/riscv/include/asm/spinlock.h | 78 +++++++++++++++++++++++++++=
+++-
> > > >  arch/riscv/kernel/setup.c         | 14 ++++++
> > > >  3 files changed, 98 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 7f39bfc75744..4bcff2860f48 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -473,7 +473,7 @@ config NODES_SHIFT
> > > >
> > > >  choice
> > > >   prompt "RISC-V spinlock type"
> > > > - default RISCV_TICKET_SPINLOCKS
> > > > + default RISCV_COMBO_SPINLOCKS
> > > >
> > > >  config RISCV_TICKET_SPINLOCKS
> > > >   bool "Using ticket spinlock"
> > > > @@ -485,6 +485,13 @@ config RISCV_QUEUED_SPINLOCKS
> > > >   help
> > > >     Make sure your micro arch LL/SC has a strong forward progress g=
uarantee.
> > > >     Otherwise, stay at ticket-lock.
> > > > +
> > > > +config RISCV_COMBO_SPINLOCKS
> > > > + bool "Using combo spinlock"
> > > > + depends on SMP && MMU
> > > > + select ARCH_USE_QUEUED_SPINLOCKS
> > > > + help
> > > > +   Select queued spinlock or ticket-lock via errata.
> > > >  endchoice
> > > >
> > > >  config RISCV_ALTERNATIVE
> > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include=
/asm/spinlock.h
> > > > index c644a92d4548..8ea0fee80652 100644
> > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > @@ -7,11 +7,85 @@
> > > >  #define _Q_PENDING_LOOPS (1 << 9)
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > +#include <asm-generic/ticket_spinlock.h>
> > > > +
> > > > +#undef arch_spin_is_locked
> > > > +#undef arch_spin_is_contended
> > > > +#undef arch_spin_value_unlocked
> > > > +#undef arch_spin_lock
> > > > +#undef arch_spin_trylock
> > > > +#undef arch_spin_unlock
> > > > +
> > > > +#include <asm-generic/qspinlock.h>
> > > > +#include <linux/jump_label.h>
> > > > +
> > > > +#undef arch_spin_is_locked
> > > > +#undef arch_spin_is_contended
> > > > +#undef arch_spin_value_unlocked
> > > > +#undef arch_spin_lock
> > > > +#undef arch_spin_trylock
> > > > +#undef arch_spin_unlock
> > > Sorry, I forgot __no_arch_spinlock_redefine advice here. I would add =
it in v12.
> > > https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd26=
c7a@redhat.com/
> > >
> >
> > Please check a reply to a previous patch I sent earlier: I think these
> > #undef can be avoided.
> >
> > > > +
> > > > +DECLARE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > > +
> > > > +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         queued_spin_lock(lock);
> > > > + else
> > > > +         ticket_spin_lock(lock);
> > > > +}
> > > > +
> > > > +static __always_inline bool arch_spin_trylock(arch_spinlock_t *loc=
k)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         return queued_spin_trylock(lock);
> > > > + else
> > > > +         return ticket_spin_trylock(lock);
> > > > +}
> > > > +
> > > > +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock=
)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         queued_spin_unlock(lock);
> > > > + else
> > > > +         ticket_spin_unlock(lock);
> > > > +}
> > > > +
> > > > +static __always_inline int arch_spin_value_unlocked(arch_spinlock_=
t lock)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         return queued_spin_value_unlocked(lock);
> > > > + else
> > > > +         return ticket_spin_value_unlocked(lock);
> > > > +}
> > > > +
> > > > +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lo=
ck)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         return queued_spin_is_locked(lock);
> > > > + else
> > > > +         return ticket_spin_is_locked(lock);
> > > > +}
> > > > +
> > > > +static __always_inline int arch_spin_is_contended(arch_spinlock_t =
*lock)
> > > > +{
> > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > +         return queued_spin_is_contended(lock);
> > > > + else
> > > > +         return ticket_spin_is_contended(lock);
> > > > +}
> > > > +#else /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > > > +
>
> Also, those functions all reproduce the same behavior, so maybe it would =
be
> better to keep that behavior in a macro such as:
>
> #define COMBO_SPINLOCK_DECLARE(f)                                       \
> static __always_inline int arch_spin_ ## f(arch_spinlock_t *lock)       \
> {                                                                       \
>         if (static_branch_likely(&combo_qspinlock_key))                 \
>                 return queued_spin_ ## f(lock);                         \
>         else                                                            \
>                 return ticket_spin_ ## f(lock);                         \
> }
>
> COMBO_SPINLOCK_DECLARE(lock)
> COMBO_SPINLOCK_DECLARE(trylock)
> COMBO_SPINLOCK_DECLARE(unlock)
> COMBO_SPINLOCK_DECLARE(value_unlocked)
> COMBO_SPINLOCK_DECLARE(is_locked)
> COMBO_SPINLOCK_DECLARE(is_contended)
>
> Does that make sense?
Yeah, thanks. I would try. You improved my macro skills. :)

>
> Thanks!
> Leo
>
>
> > > >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > > >  #include <asm/qspinlock.h>
> > > > -#include <asm/qrwlock.h>
> > > >  #else
> > > > -#include <asm-generic/spinlock.h>
> > > > +#include <asm-generic/ticket_spinlock.h>
> > > >  #endif
> > > >
> > > > +#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > > > +
> > > > +#include <asm/qrwlock.h>
> > > > +
> > > >  #endif /* __ASM_RISCV_SPINLOCK_H */
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index 32c2e1eb71bd..a447cf360a18 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -269,6 +269,18 @@ static void __init parse_dtb(void)
> > > >  #endif
> > > >  }
> > > >
> > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > +DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > > +EXPORT_SYMBOL(combo_qspinlock_key);
> > > > +#endif
> > > > +
> > > > +static void __init riscv_spinlock_init(void)
> > > > +{
> > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > + static_branch_disable(&combo_qspinlock_key);
> > > > +#endif
> > > > +}
> > > > +
> > > >  extern void __init init_rt_signal_env(void);
> > > >
> > > >  void __init setup_arch(char **cmdline_p)
> > > > @@ -317,6 +329,8 @@ void __init setup_arch(char **cmdline_p)
> > > >       riscv_isa_extension_available(NULL, ZICBOM))
> > > >           riscv_noncoherent_supported();
> > > >   riscv_set_dma_cache_alignment();
> > > > +
> > > > + riscv_spinlock_init();
> > > >  }
> > > >
> > > >  static int __init topology_init(void)
> > > > --
> > > > 2.36.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > >
>


--=20
Best Regards
 Guo Ren
