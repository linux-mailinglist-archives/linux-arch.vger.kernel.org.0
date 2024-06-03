Return-Path: <linux-arch+bounces-4646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E884C8D8137
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5481F25CD9
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA784A4F;
	Mon,  3 Jun 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya+cOJEu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479B84A40;
	Mon,  3 Jun 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414106; cv=none; b=Zty8qzUQoIwNvLdchi0Rq40a/AQIfXpYkryiPSzw1lSE/f5qajc+cGtve5T9dj0vCQ1tEEsbB5WiQ+Gla9/vvRoSYW296/HtzmtD6Sy2fy7eD2psvEcnSANLVkFir0e6FNNFpJTb8xc/xvGrmr488OwWS1TapO1dFI+mj+nQMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414106; c=relaxed/simple;
	bh=vCJBPCqrcWxHbDmY1Ip4EPQbmCzgQzOL9PaP3FujjMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObbF36IGDlh2QdEwrA7+8e2t9MR4u4Y6nV/qDl5C6OVntCGzEqGYlMRxYmKaD5RAFgYQ6rattB2vrYdC00eM+UcGaB36JTF+JhZ5qhTgeKV4cIn8E7aYcD38NpzANrCyqqPZ5HIT+ntQWQpsXsvhcukLpE2FZFmSZTbbToOxBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya+cOJEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC142C2BD10;
	Mon,  3 Jun 2024 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717414106;
	bh=vCJBPCqrcWxHbDmY1Ip4EPQbmCzgQzOL9PaP3FujjMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ya+cOJEuvd4WfCG/LBewy/x9fZ3J3L3g997tleXVjzmVg32+whCnRYDtrMBrSMB73
	 /Pbf/sN1Hi0R9FtArneUVY369cPibnAmakUEdHJW0ImtnX+o6dJo8eT9wE8l2frry5
	 GQn7SPUJEs1wVGciSkR54Vri3UP7KWZNO+qVOPX9rRkB0YEkdlOhLkeGabV7rCmQi0
	 qw95CDgAQaoPqY61mS2bee5sGW1oQI8auVMxZboWPh956ZUkg3wmczrE4BQWNAxIXN
	 OICP6OU+F7z0WSJlDLGUYgXSzgOdNfPojDRrT3csOTtwbEvi/+2KafXhoJ0WRO+CTC
	 QPmDocedoG5WQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso3894873a12.1;
        Mon, 03 Jun 2024 04:28:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSkvH6bCj+bzJyVCfLxGlYYzheowuvtpjsJxKR0FgOz69FKwFZjr3dDhq0VPJEnwkokjujxGJX7nAR7hbsBz4oyp7zdmqw4QuJJi/ba0x3VcLsO/2NbTKSTHlMxYhpgktI6m7/YHo+IFvOsmN26Nql6/rsAOboWqTXxFAJj6Qfja1UJA==
X-Gm-Message-State: AOJu0YwWR6pGex8lb01uEpyd7uw+tGpRrcBoKmhv9p+O4gmBtaEXQnb0
	vctBk1TuHKfl0ZvpKDMiGnWA6+NLigHkA7ApRvB2WK5fC/BQ9Rl5/1Kmg5ODB0qN71GfatcF4Kx
	ByRiQREwOGc9CyrMlf2DengYT+JY=
X-Google-Smtp-Source: AGHT+IF7oUISfXlBkgYM3SWyRzez8UB/Ec/lGg22hdHwjeF/SE86WQgKumyklYRSEhJwqDw2mAk0ltkAZWHH52bF7U4=
X-Received: by 2002:a17:906:6b8f:b0:a68:a498:2e9 with SMTP id
 a640c23a62f3a-a68a498036cmr374499666b.40.1717414104472; Mon, 03 Jun 2024
 04:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
 <CAJF2gTT51oZqEq-1TV_UEUufsrq=jRr4FAbmdtrChAHyUC1rXg@mail.gmail.com> <b6b6d273-4d57-4611-8c67-1a67d443b7d0@ghiti.fr>
In-Reply-To: <b6b6d273-4d57-4611-8c67-1a67d443b7d0@ghiti.fr>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 3 Jun 2024 19:28:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTiz_gkaA8OVkZynKUAFHFGij1W97qVSS3RKyMK5vkpdw@mail.gmail.com>
Message-ID: <CAJF2gTTiz_gkaA8OVkZynKUAFHFGij1W97qVSS3RKyMK5vkpdw@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:49=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Guo,
>
> On 31/05/2024 15:10, Guo Ren wrote:
> > On Wed, May 29, 2024 at 9:03=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> >> Hi Guo,
> >>
> >> On Wed, May 29, 2024 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> w=
rote:
> >>> On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> >>>> In order to produce a generic kernel, a user can select
> >>>> CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
> >>>> spinlock implementation if Zabha is not present.
> >>>>
> >>>> Note that we can't use alternatives here because the discovery of
> >>>> extensions is done too late and we need to start with the qspinlock
> >>>> implementation because the ticket spinlock implementation would poll=
ute
> >>>> the spinlock value, so let's use static keys.
> > Zabha is not a prerequisite for qspinlock; the prerequisite for
> > qspinlock is the *forward progress guarantee* in the atomic operation
> > loop during intense contention. Even with Zabha enabled to meet the
> > requirements of xchg_tail, that still only applies when the number of
> > CPUs is less than 16K. The qspinlock uses cmpxchg loop instead of
> > xchg_tail when the number of cores is more than 16K. Thus, hardware
> > support for Zabha does not equate to the safe use of qspinlock.
>
>
> But if we have Zacas to implement cmpxchg(), we still provide the
> "forward progress guarantee" then right? Let me know if I missed somethin=
g.
The qspinlock needs a "forward progress guarantee," not Zacas, and
Zabha could give a guarantee to qspinlock xchg_tail (CPUs < 16K) with
AMOSWAP.H instruction. But, using "LR/SC pairs" also could give enough
fwd guarantee that depends on the micro-arch design of the riscv core.
I think the help of AMO instead of LR/SC is it could off-load AMO
operations from LSU to CIU(Next Level Cache or Interconnect), which
gains better performance. "LR/SC pairs" only provide Near-Atomic, but
AMO gives Far-Atomic additionally.


>
> Thanks,
>
> Alex
>
>
> >
> > Therefore, I would like to propose a new ISA extension: Zafpg(Atomic
> > Forward Progress Guarantee). If RISC-V vendors can ensure the progress
> > of LR/SC or CMPXCHG LOOP at the microarchitectural level or if cache
> > lines are sufficiently sticky, they could then claim support for this
> > extension. Linux could then select different spinlock implementations
> > based on this extension's support or not.
> >
> >>>> This is largely based on Guo's work and Leonardo reviews at [1].
> >>>>
> >>>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-g=
uoren@kernel.org/ [1]
> >>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>>> ---
> >>>>   .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >>>>   arch/riscv/Kconfig                            |  1 +
> >>>>   arch/riscv/include/asm/Kbuild                 |  4 +-
> >>>>   arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++=
++++
> >>>>   arch/riscv/kernel/setup.c                     | 18 +++++++++
> >>>>   include/asm-generic/qspinlock.h               |  2 +
> >>>>   include/asm-generic/ticket_spinlock.h         |  2 +
> >>>>   7 files changed, 66 insertions(+), 2 deletions(-)
> >>>>   create mode 100644 arch/riscv/include/asm/spinlock.h
> >>>>
> >>>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-su=
pport.txt b/Documentation/features/locking/queued-spinlocks/arch-support.tx=
t
> >>>> index 22f2990392ff..cf26042480e2 100644
> >>>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.t=
xt
> >>>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.t=
xt
> >>>> @@ -20,7 +20,7 @@
> >>>>       |    openrisc: |  ok  |
> >>>>       |      parisc: | TODO |
> >>>>       |     powerpc: |  ok  |
> >>>> -    |       riscv: | TODO |
> >>>> +    |       riscv: |  ok  |
> >>>>       |        s390: | TODO |
> >>>>       |          sh: | TODO |
> >>>>       |       sparc: |  ok  |
> >>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>> index 184a9edb04e0..ccf1703edeb9 100644
> >>>> --- a/arch/riscv/Kconfig
> >>>> +++ b/arch/riscv/Kconfig
> >>>> @@ -59,6 +59,7 @@ config RISCV
> >>>>          select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_=
STACK
> >>>>          select ARCH_USE_MEMTEST
> >>>>          select ARCH_USE_QUEUED_RWLOCKS
> >>>> +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> >>> Using qspinlock or not depends on real hardware capabilities, not the
> >>> compiler flag. That's why I introduced combo-spinlock, ticket-spinloc=
k
> >>> & qspinlock three Kconfigs, and the combo-spinlock would compat all
> >>> hardware platforms but waste some qspinlock code size.
> >> You're right, and I think your comment matches what Conor mentioned
> >> about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
> >> will allow a platform with Zabha capability to use qspinlocks. But if
> >> the hardware does not, it will fallback to the ticket spinlocks.
> >>
> >> But I agree that looking at the config alone may be misleading, even
> >> though it will work as expected at runtime. So I agree with you:
> >> unless anyone is strongly against the combo spinlocks, I will do what
> >> you suggest and add them.
> >>
> >> Thanks again for your initial work,
> >>
> >> Alex
> >>
> >>>>          select ARCH_USES_CFI_TRAPS if CFI_CLANG
> >>>>          select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> >>>>          select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> >>>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/=
Kbuild
> >>>> index 504f8b7e72d4..ad72f2bd4cc9 100644
> >>>> --- a/arch/riscv/include/asm/Kbuild
> >>>> +++ b/arch/riscv/include/asm/Kbuild
> >>>> @@ -2,10 +2,12 @@
> >>>>   generic-y +=3D early_ioremap.h
> >>>>   generic-y +=3D flat.h
> >>>>   generic-y +=3D kvm_para.h
> >>>> +generic-y +=3D mcs_spinlock.h
> >>>>   generic-y +=3D parport.h
> >>>> -generic-y +=3D spinlock.h
> >>>>   generic-y +=3D spinlock_types.h
> >>>> +generic-y +=3D ticket_spinlock.h
> >>>>   generic-y +=3D qrwlock.h
> >>>>   generic-y +=3D qrwlock_types.h
> >>>> +generic-y +=3D qspinlock.h
> >>>>   generic-y +=3D user.h
> >>>>   generic-y +=3D vmlinux.lds.h
> >>>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/=
asm/spinlock.h
> >>>> new file mode 100644
> >>>> index 000000000000..e00429ac20ed
> >>>> --- /dev/null
> >>>> +++ b/arch/riscv/include/asm/spinlock.h
> >>>> @@ -0,0 +1,39 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +
> >>>> +#ifndef __ASM_RISCV_SPINLOCK_H
> >>>> +#define __ASM_RISCV_SPINLOCK_H
> >>>> +
> >>>> +#ifdef CONFIG_QUEUED_SPINLOCKS
> >>>> +#define _Q_PENDING_LOOPS       (1 << 9)
> >>>> +
> >>>> +#define __no_arch_spinlock_redefine
> >>>> +#include <asm/ticket_spinlock.h>
> >>>> +#include <asm/qspinlock.h>
> >>>> +#include <asm/alternative.h>
> >>>> +
> >>>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> >>>> +
> >>>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                 =
    \
> >>>> +static __always_inline type arch_spin_##op(type_lock lock)         =
    \
> >>>> +{                                                                  =
    \
> >>>> +       if (static_branch_unlikely(&qspinlock_key))                 =
    \
> >>>> +               return queued_spin_##op(lock);                      =
    \
> >>>> +       return ticket_spin_##op(lock);                              =
    \
> >>>> +}
> >>>> +
> >>>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> >>>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> >>>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> >>>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> >>>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> >>>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> >>>> +
> >>>> +#else
> >>>> +
> >>>> +#include <asm/ticket_spinlock.h>
> >>>> +
> >>>> +#endif
> >>>> +
> >>>> +#include <asm/qrwlock.h>
> >>>> +
> >>>> +#endif /* __ASM_RISCV_SPINLOCK_H */
> >>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >>>> index 4f73c0ae44b2..31ce75522fd4 100644
> >>>> --- a/arch/riscv/kernel/setup.c
> >>>> +++ b/arch/riscv/kernel/setup.c
> >>>> @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
> >>>>   #endif
> >>>>   }
> >>>>
> >>>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> >>>> +EXPORT_SYMBOL(qspinlock_key);
> >>>> +
> >>>> +static void __init riscv_spinlock_init(void)
> >>>> +{
> >>>> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_E=
XT_ZABHA, 1)
> >>>> +                : : : : qspinlock);
> >>>> +
> >>>> +       static_branch_disable(&qspinlock_key);
> >>>> +       pr_info("Ticket spinlock: enabled\n");
> >>>> +
> >>>> +       return;
> >>>> +
> >>>> +qspinlock:
> >>>> +       pr_info("Queued spinlock: enabled\n");
> >>>> +}
> >>>> +
> >>>>   extern void __init init_rt_signal_env(void);
> >>>>
> >>>>   void __init setup_arch(char **cmdline_p)
> >>>> @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
> >>>>          riscv_set_dma_cache_alignment();
> >>>>
> >>>>          riscv_user_isa_enable();
> >>>> +       riscv_spinlock_init();
> >>>>   }
> >>>>
> >>>>   bool arch_cpu_is_hotpluggable(int cpu)
> >>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/q=
spinlock.h
> >>>> index 0655aa5b57b2..bf47cca2c375 100644
> >>>> --- a/include/asm-generic/qspinlock.h
> >>>> +++ b/include/asm-generic/qspinlock.h
> >>>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struc=
t qspinlock *lock)
> >>>>   }
> >>>>   #endif
> >>>>
> >>>> +#ifndef __no_arch_spinlock_redefine
> >>>>   /*
> >>>>    * Remapping spinlock architecture specific functions to the corre=
sponding
> >>>>    * queued spinlock functions.
> >>>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struc=
t qspinlock *lock)
> >>>>   #define arch_spin_lock(l)              queued_spin_lock(l)
> >>>>   #define arch_spin_trylock(l)           queued_spin_trylock(l)
> >>>>   #define arch_spin_unlock(l)            queued_spin_unlock(l)
> >>>> +#endif
> >>>>
> >>>>   #endif /* __ASM_GENERIC_QSPINLOCK_H */
> >>>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-gen=
eric/ticket_spinlock.h
> >>>> index cfcff22b37b3..325779970d8a 100644
> >>>> --- a/include/asm-generic/ticket_spinlock.h
> >>>> +++ b/include/asm-generic/ticket_spinlock.h
> >>>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contende=
d(arch_spinlock_t *lock)
> >>>>          return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >>>>   }
> >>>>
> >>>> +#ifndef __no_arch_spinlock_redefine
> >>>>   /*
> >>>>    * Remapping spinlock architecture specific functions to the corre=
sponding
> >>>>    * ticket spinlock functions.
> >>>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contend=
ed(arch_spinlock_t *lock)
> >>>>   #define arch_spin_lock(l)              ticket_spin_lock(l)
> >>>>   #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> >>>>   #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> >>>> +#endif
> >>>>
> >>>>   #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>
> >>> --
> >>> Best Regards
> >>>   Guo Ren
> >
> >



--=20
Best Regards
 Guo Ren

