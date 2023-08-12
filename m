Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25EC779BD4
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 02:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjHLAWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 20:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjHLAWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 20:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1526B6;
        Fri, 11 Aug 2023 17:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94EA65DE3;
        Sat, 12 Aug 2023 00:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29941C43395;
        Sat, 12 Aug 2023 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691799770;
        bh=tBl6fDOge6fU4Mt5y9o3KWwFWgJfkdE6eLTtmGZjrnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PNtuCwuwdtySXipytZ6NGHDx2GYKi2KvM/Y1Ri209YGD0Sx40NSr92RG1Eyxb+bKd
         /w+W+P3lmt6WYXhqEmJL5AwnqazlWLeLE4zHnaE0vXjseFBYaUCG2/QlMnLIDy7Ws/
         Trg0mrkpg0F0bJn4L4FAvoW3RNBZEvACg7Y3ZdgWqXCsYvCEC0i13uDvAEaDwfh7qo
         OK1qNufGl18VJ4XozODdkn24YifCQbC6myWDLoj9fr/q2wQC++F4k5kHvF+nFCElwE
         Nh5yEI9jBm+HWKf1yYWDK3R3U6CG/kM/7IKY4LRVWAaXii6a6GVxjeC5Ndg2VNqhzB
         enmW7OfSTh0eA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so3091292a12.0;
        Fri, 11 Aug 2023 17:22:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YykREbEHStwGkSOjkP9doyUKSihPXy7QieefW14W+UiSKa90UNc
        b2IkJV52ioNpCHvwsTSKMWDe5RdEl4Y0cHHlv7A=
X-Google-Smtp-Source: AGHT+IFQ6XJo1DZORXlzzHVQinnQXom+U3CPk//8XJrl+P68T/e6sEK3ABZLuwiMs6jrw8ZzTA7VImyje/i5+L8/K2Y=
X-Received: by 2002:a05:6402:50a:b0:523:38ea:48bb with SMTP id
 m10-20020a056402050a00b0052338ea48bbmr3047271edv.24.1691799768276; Fri, 11
 Aug 2023 17:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802164701.192791-1-guoren@kernel.org> <20230802164701.192791-6-guoren@kernel.org>
 <4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com>
In-Reply-To: <4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Aug 2023 08:22:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRJCG297BAALvs97U+bYxjPW+W+N5yzZkgB3fb+XvJmJQ@mail.gmail.com>
Message-ID: <CAJF2gTRJCG297BAALvs97U+bYxjPW+W+N5yzZkgB3fb+XvJmJQ@mail.gmail.com>
Subject: Re: [PATCH V10 05/19] riscv: qspinlock: Introduce combo spinlock
To:     Waiman Long <longman@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023 at 3:51=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 8/2/23 12:46, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Combo spinlock could support queued and ticket in one Linux Image and
> > select them during boot time via errata mechanism. Here is the func
> > size (Bytes) comparison table below:
> >
> > TYPE                  : COMBO | TICKET | QUEUED
> > arch_spin_lock                : 106   | 60     | 50
> > arch_spin_unlock      : 54    | 36     | 26
> > arch_spin_trylock     : 110   | 72     | 54
> > arch_spin_is_locked   : 48    | 34     | 20
> > arch_spin_is_contended        : 56    | 40     | 24
> > rch_spin_value_unlocked       : 48    | 34     | 24
> >
> > One example of disassemble combo arch_spin_unlock:
> >     0xffffffff8000409c <+14>:    nop                # detour slot
> >     0xffffffff800040a0 <+18>:    fence   rw,w       # queued spinlock s=
tart
> >     0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinlock e=
nd
> >     0xffffffff800040a8 <+26>:    ld      s0,8(sp)
> >     0xffffffff800040aa <+28>:    addi    sp,sp,16
> >     0xffffffff800040ac <+30>:    ret
> >     0xffffffff800040ae <+32>:    lw      a5,0(a4)   # ticket spinlock s=
tart
> >     0xffffffff800040b0 <+34>:    sext.w  a5,a5
> >     0xffffffff800040b2 <+36>:    fence   rw,w
> >     0xffffffff800040b6 <+40>:    addiw   a5,a5,1
> >     0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
> >     0xffffffff800040ba <+44>:    srli    a5,a5,0x30
> >     0xffffffff800040bc <+46>:    sh      a5,0(a4)   # ticket spinlock e=
nd
> >     0xffffffff800040c0 <+50>:    ld      s0,8(sp)
> >     0xffffffff800040c2 <+52>:    addi    sp,sp,16
> >     0xffffffff800040c4 <+54>:    ret
> >
> > The qspinlock is smaller and faster than ticket-lock when all are in
> > fast-path, and combo spinlock could provide a compatible Linux Image
> > for different micro-arch design (weak/strict fwd guarantee) processors.
> >
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >   arch/riscv/Kconfig                |  9 +++-
> >   arch/riscv/include/asm/hwcap.h    |  1 +
> >   arch/riscv/include/asm/spinlock.h | 87 ++++++++++++++++++++++++++++++=
-
> >   arch/riscv/kernel/cpufeature.c    | 10 ++++
> >   4 files changed, 104 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e89a3bea3dc1..119e774a3dcf 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -440,7 +440,7 @@ config NODES_SHIFT
> >
> >   choice
> >       prompt "RISC-V spinlock type"
> > -     default RISCV_TICKET_SPINLOCKS
> > +     default RISCV_COMBO_SPINLOCKS
> >
> >   config RISCV_TICKET_SPINLOCKS
> >       bool "Using ticket spinlock"
> > @@ -452,6 +452,13 @@ config RISCV_QUEUED_SPINLOCKS
> >       help
> >         Make sure your micro arch LL/SC has a strong forward progress g=
uarantee.
> >         Otherwise, stay at ticket-lock.
> > +
> > +config RISCV_COMBO_SPINLOCKS
> > +     bool "Using combo spinlock"
> > +     depends on SMP && MMU
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       Select queued spinlock or ticket-lock via errata.
> >   endchoice
> >
> >   config RISCV_ALTERNATIVE
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index f041bfa7f6a0..08ae75a694c2 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -54,6 +54,7 @@
> >   #define RISCV_ISA_EXT_ZIFENCEI              41
> >   #define RISCV_ISA_EXT_ZIHPM         42
> >
> > +#define RISCV_ISA_EXT_XTICKETLOCK    63
> >   #define RISCV_ISA_EXT_MAX           64
> >   #define RISCV_ISA_EXT_NAME_LEN_MAX  32
> >
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm=
/spinlock.h
> > index c644a92d4548..9eb3ad31e564 100644
> > --- a/arch/riscv/include/asm/spinlock.h
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -7,11 +7,94 @@
> >   #define _Q_PENDING_LOOPS    (1 << 9)
> >   #endif
> >
>
> I see why you separated the _Q_PENDING_LOOPS out.
haha, yes, I even forget this, :).

>
>
> > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +#include <asm-generic/ticket_spinlock.h>
> > +
> > +#undef arch_spin_is_locked
> > +#undef arch_spin_is_contended
> > +#undef arch_spin_value_unlocked
> > +#undef arch_spin_lock
> > +#undef arch_spin_trylock
> > +#undef arch_spin_unlock
> > +
> > +#include <asm-generic/qspinlock.h>
> > +#include <asm/hwcap.h>
> > +
> > +#undef arch_spin_is_locked
> > +#undef arch_spin_is_contended
> > +#undef arch_spin_value_unlocked
> > +#undef arch_spin_lock
> > +#undef arch_spin_trylock
> > +#undef arch_spin_unlock
> Perhaps you can add a macro like __no_arch_spinlock_redefine to disable
> the various arch_spin_* definition in qspinlock.h and ticket_spinlock.h.
That's great; I will try it in the next version.

> > +
> > +#define COMBO_DETOUR                         \
> > +     asm_volatile_goto(ALTERNATIVE(          \
> > +             "nop",                          \
> > +             "j %l[ticket_spin_lock]",       \
> > +             0,                              \
> > +             RISCV_ISA_EXT_XTICKETLOCK,      \
> > +             CONFIG_RISCV_COMBO_SPINLOCKS)   \
> > +             : : : : ticket_spin_lock);
> > +
> > +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > +{
> > +     COMBO_DETOUR
> > +     queued_spin_lock(lock);
> > +     return;
> > +ticket_spin_lock:
> > +     ticket_spin_lock(lock);
> > +}
> > +
> > +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> > +{
> > +     COMBO_DETOUR
> > +     return queued_spin_trylock(lock);
> > +ticket_spin_lock:
> > +     return ticket_spin_trylock(lock);
> > +}
> > +
> > +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> > +{
> > +     COMBO_DETOUR
> > +     queued_spin_unlock(lock);
> > +     return;
> > +ticket_spin_lock:
> > +     ticket_spin_unlock(lock);
> > +}
> > +
> > +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lo=
ck)
> > +{
> > +     COMBO_DETOUR
> > +     return queued_spin_value_unlocked(lock);
> > +ticket_spin_lock:
> > +     return ticket_spin_value_unlocked(lock);
> > +}
> > +
> > +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> > +{
> > +     COMBO_DETOUR
> > +     return queued_spin_is_locked(lock);
> > +ticket_spin_lock:
> > +     return ticket_spin_is_locked(lock);
> > +}
> > +
> > +static __always_inline int arch_spin_is_contended(arch_spinlock_t *loc=
k)
> > +{
> > +     COMBO_DETOUR
> > +     return queued_spin_is_contended(lock);
> > +ticket_spin_lock:
> > +     return ticket_spin_is_contended(lock);
> > +}
> > +#else /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > +
> >   #ifdef CONFIG_QUEUED_SPINLOCKS
> >   #include <asm/qspinlock.h>
> > -#include <asm/qrwlock.h>
> >   #else
> > -#include <asm-generic/spinlock.h>
> > +#include <asm-generic/ticket_spinlock.h>
> >   #endif
> >
> > +#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > +
> > +#include <asm/qrwlock.h>
> > +
> >   #endif /* __ASM_RISCV_SPINLOCK_H */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index bdcf460ea53d..e65b0e54152d 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -324,6 +324,16 @@ void __init riscv_fill_hwcap(void)
> >               set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> >               set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
> >
> > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +             /*
> > +              * The RISC-V Linux used queued spinlock at first; then, =
we used ticket_lock
> > +              * as default or queued spinlock by choice. Because ticke=
t_lock would dirty
> > +              * spinlock value, the only way is to change from queued_=
spinlock to
> > +              * ticket_spinlock, but can not be vice.
>
> The phrase "but can not be vice" is confusing. I think you mean "but not
> vice versa". Right?
Yes, thx for the grammar correction.

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren
