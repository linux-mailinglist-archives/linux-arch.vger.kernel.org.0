Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D3D7A35FB
	for <lists+linux-arch@lfdr.de>; Sun, 17 Sep 2023 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjIQO66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjIQO6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 10:58:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2954E123;
        Sun, 17 Sep 2023 07:58:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF5C43397;
        Sun, 17 Sep 2023 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694962713;
        bh=KlwF03cA38LAbVNYQ0y1gs6pl2aebfxqLISOHWTDsTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BElNy19Zi6WXfi5QvaX6dSm5kY31l5uVcjX4a9byHPOZfr/t8PUkoQYKaflIAJuqK
         +bh71YFgrcbIs9l1D9dZqFOlDft2nsZEAxV4+RL3DtatWWFvKWLvkJEnbwr/vkvY/q
         t0eynRlIQKhqssPWqET2/z0i0wWcU2vCI1ofh7WoIIta9iCArwL0dZQA5J76Zt4jo/
         DFZk7ESCWqW7UU6NcOQHstTEdbyeub2ZbvfdfZjkFdTs9I+PM7t/7pL1ndSQAJbvLO
         L2ywltEnz+mE7FaTxhoVJvSyYv2uXbOGcFdPn5Aj/M9F3CxQ1yepaIw46z8wibV9VD
         0yFHZ6930D9sQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-502e6d632b6so5457163e87.0;
        Sun, 17 Sep 2023 07:58:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZGIQMJ5g7K3/k9hTxTK8Dkh3o1a5uWVUa3HfZatiNtiD7TU0s
        W3oZPRusPJ21eKyXP/qxKYTIJz7G4AFnF8RJyM4=
X-Google-Smtp-Source: AGHT+IFTwZZCE3hh6xs2ZyRlSuSnjazLmRxzgJV9zrr2hr8LYPakqHAE+jjNxivy5lS1QyXq2HYkSXCT5opEECDSrac=
X-Received: by 2002:a05:6512:2207:b0:503:985:92c9 with SMTP id
 h7-20020a056512220700b00503098592c9mr2556045lfu.22.1694962711680; Sun, 17 Sep
 2023 07:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-12-guoren@kernel.org>
 <ZQPuvCNq5IAYlMR6@redhat.com>
In-Reply-To: <ZQPuvCNq5IAYlMR6@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Sep 2023 22:58:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR-CAw3nGPBfxszEOfOaPBxios3fSKiHXFVTG7LsCc+FQ@mail.gmail.com>
Message-ID: <CAJF2gTR-CAw3nGPBfxszEOfOaPBxios3fSKiHXFVTG7LsCc+FQ@mail.gmail.com>
Subject: Re: [PATCH V11 11/17] RISC-V: paravirt: pvqspinlock: Add paravirt
 qspinlock skeleton
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 1:42=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Sun, Sep 10, 2023 at 04:29:05AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Using static_call to switch between:
> >   native_queued_spin_lock_slowpath()    __pv_queued_spin_lock_slowpath(=
)
> >   native_queued_spin_unlock()           __pv_queued_spin_unlock()
> >
> > Finish the pv_wait implementation, but pv_kick needs the SBI
> > definition of the next patches.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/Kbuild               |  1 -
> >  arch/riscv/include/asm/qspinlock.h          | 35 +++++++++++++
> >  arch/riscv/include/asm/qspinlock_paravirt.h | 29 +++++++++++
> >  arch/riscv/include/asm/spinlock.h           |  2 +-
> >  arch/riscv/kernel/qspinlock_paravirt.c      | 57 +++++++++++++++++++++
> >  arch/riscv/kernel/setup.c                   |  4 ++
> >  6 files changed, 126 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/qspinlock.h
> >  create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
> >  create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c
> >
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbu=
ild
> > index a0dc85e4a754..b89cb3b73c13 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -7,6 +7,5 @@ generic-y +=3D parport.h
> >  generic-y +=3D spinlock_types.h
> >  generic-y +=3D qrwlock.h
> >  generic-y +=3D qrwlock_types.h
> > -generic-y +=3D qspinlock.h
> >  generic-y +=3D user.h
> >  generic-y +=3D vmlinux.lds.h
> > diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/as=
m/qspinlock.h
> > new file mode 100644
> > index 000000000000..7d4f416c908c
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qspinlock.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c), 2023 Alibaba Cloud
> > + * Authors:
> > + *   Guo Ren <guoren@linux.alibaba.com>
> > + */
> > +
> > +#ifndef _ASM_RISCV_QSPINLOCK_H
> > +#define _ASM_RISCV_QSPINLOCK_H
> > +
> > +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> > +#include <asm/qspinlock_paravirt.h>
> > +
> > +/* How long a lock should spin before we consider blocking */
> > +#define SPIN_THRESHOLD               (1 << 15)
> > +
> > +void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)=
;
> > +void __pv_init_lock_hash(void);
> > +void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> > +
> > +static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u=
32 val)
> > +{
> > +     static_call(pv_queued_spin_lock_slowpath)(lock, val);
> > +}
> > +
> > +#define queued_spin_unlock   queued_spin_unlock
> > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > +{
> > +     static_call(pv_queued_spin_unlock)(lock);
> > +}
> > +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
> > +
> > +#include <asm-generic/qspinlock.h>
> > +
> > +#endif /* _ASM_RISCV_QSPINLOCK_H */
> > diff --git a/arch/riscv/include/asm/qspinlock_paravirt.h b/arch/riscv/i=
nclude/asm/qspinlock_paravirt.h
> > new file mode 100644
> > index 000000000000..9681e851f69d
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qspinlock_paravirt.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c), 2023 Alibaba Cloud
> > + * Authors:
> > + *   Guo Ren <guoren@linux.alibaba.com>
> > + */
> > +
> > +#ifndef _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> > +#define _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> > +
> > +void pv_wait(u8 *ptr, u8 val);
> > +void pv_kick(int cpu);
> > +
> > +void dummy_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> > +void dummy_queued_spin_unlock(struct qspinlock *lock);
> > +
> > +DECLARE_STATIC_CALL(pv_queued_spin_lock_slowpath, dummy_queued_spin_lo=
ck_slowpath);
> > +DECLARE_STATIC_CALL(pv_queued_spin_unlock, dummy_queued_spin_unlock);
> > +
> > +void __init pv_qspinlock_init(void);
> > +
> > +static inline bool pv_is_native_spin_unlock(void)
> > +{
> > +     return false;
> > +}
> > +
> > +void __pv_queued_spin_unlock(struct qspinlock *lock);
> > +
> > +#endif /* _ASM_RISCV_QSPINLOCK_PARAVIRT_H */
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm=
/spinlock.h
> > index 6b38d6616f14..ed4253f491fe 100644
> > --- a/arch/riscv/include/asm/spinlock.h
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -39,7 +39,7 @@ static inline bool virt_spin_lock(struct qspinlock *l=
ock)
> >  #undef arch_spin_trylock
> >  #undef arch_spin_unlock
> >
> > -#include <asm-generic/qspinlock.h>
> > +#include <asm/qspinlock.h>
> >  #include <linux/jump_label.h>
> >
> >  #undef arch_spin_is_locked
> > diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel=
/qspinlock_paravirt.c
> > new file mode 100644
> > index 000000000000..85ff5a3ec234
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c), 2023 Alibaba Cloud
> > + * Authors:
> > + *   Guo Ren <guoren@linux.alibaba.com>
> > + */
> > +
> > +#include <linux/static_call.h>
> > +#include <asm/qspinlock_paravirt.h>
> > +#include <asm/sbi.h>
> > +
> > +void pv_kick(int cpu)
> > +{
> > +     return;
> > +}
> > +
> > +void pv_wait(u8 *ptr, u8 val)
> > +{
> > +     unsigned long flags;
> > +
> > +     if (in_nmi())
> > +             return;
> > +
> > +     local_irq_save(flags);
> > +     if (READ_ONCE(*ptr) !=3D val)
> > +             goto out;
> > +
> > +     /* wait_for_interrupt(); */
> > +out:
> > +     local_irq_restore(flags);
> > +}
> > +
> > +static void native_queued_spin_unlock(struct qspinlock *lock)
> > +{
> > +     smp_store_release(&lock->locked, 0);
> > +}
> > +
> > +DEFINE_STATIC_CALL(pv_queued_spin_lock_slowpath, native_queued_spin_lo=
ck_slowpath);
> > +EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
> > +
> > +DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
> > +EXPORT_STATIC_CALL(pv_queued_spin_unlock);
> > +
> > +void __init pv_qspinlock_init(void)
> > +{
> > +     if (num_possible_cpus() =3D=3D 1)
> > +             return;
> > +
> > +     if(sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)
>
> Checks like this seem to be very common on this patchset.
> For someone not much familiar with this, it can be hard to
> understand.
>
> I mean, on patch 8/17 you introduce those IDs, which look to be
> incremental ( ID =3D=3D N includes stuff from ID < N ), but I am not sure=
 as I
> couln't find much documentation on that.
It's from sbi spec:
https://github.com/riscv-non-isa/riscv-sbi-doc/releases

0 Berkeley Boot Loader (BBL)
1 OpenSBI
2 Xvisor
3 KVM
4 RustSBI
5 Diosix
6 Coffer
7 Xen Project
8 PolarFire Hart Software Service

>
> Then above you test for the id being different than
> SBI_EXT_BASE_IMPL_ID_KVM, but if they are actually incremental and a new
> version lands, the new version will also return early because it passes t=
he
> test.
>
> I am no sure if above is right, but it's all I could understand without
> documentation.
>
> Well, my point is: this seems hard to understand & review, so it would be
> nice to have a macro like this to be used instead:
>
> #define sbi_fw_implements_kvm() \
>         (sbi_get_firmware_id() >=3D SBI_EXT_BASE_IMPL_ID_KVM)
No, it's not correct. It must be:
(sbi_get_firmware_id() =3D=3D SBI_EXT_BASE_IMPL_ID_KVM)

>
> if(!sbi_fw_implements_kvm())
I'm okay with sbi_fw_implements_kvm().

>         return;
>
> What do you think?
>
> Other than that, LGTM.
>
> Thanks!
> Leo
>
> > +             return;
> > +
> > +     pr_info("PV qspinlocks enabled\n");
> > +     __pv_init_lock_hash();
> > +
> > +     static_call_update(pv_queued_spin_lock_slowpath, __pv_queued_spin=
_lock_slowpath);
> > +     static_call_update(pv_queued_spin_unlock, __pv_queued_spin_unlock=
);
> > +}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index c57d15b05160..88690751f2ee 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -321,6 +321,10 @@ static void __init riscv_spinlock_init(void)
> >  #ifdef CONFIG_QUEUED_SPINLOCKS
> >       virt_spin_lock_init();
> >  #endif
> > +
> > +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> > +     pv_qspinlock_init();
> > +#endif
> >  }
> >
> >  extern void __init init_rt_signal_env(void);
> > --
> > 2.36.1
> >
>


--=20
Best Regards
 Guo Ren
