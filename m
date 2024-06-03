Return-Path: <linux-arch+bounces-4648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0538D8176
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D95A1F25288
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFB84E0D;
	Mon,  3 Jun 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePCs3Sta"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D084E07;
	Mon,  3 Jun 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415078; cv=none; b=U/J9Wi4Ginj4qQ+F1qJpg+g+M1AXeXDuMCtos3uDT8JkZkuyvrmSZrCaHrCoLSgNKNx1bNWBM9h/3qCJrlaKbVG8DXpry9t397zHIdDwO0wjZioLEUAkCUd54VrN4C8ZJjYnMyezYw4p7xYC3CFBHyoLv0HpyC6HzeESTrQ+Zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415078; c=relaxed/simple;
	bh=KunT4nlCg7911ALJa7lOcyXfpiQdVZ5znExOTbbLGV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS1otxpgAm1CSZ4I0VAelB+ryq8d7W5ATv6B3Xl9VrgfPxpCVFvjTGdBub5HehtyeNEOr6/bCF6RgS5deN7mZ8UrdDGH8RRv8ENPfxzecfDmNpQSBI+iqMSAHfvA1F8PjZ/2Nb27f26HJyG242vJsHNwTk/jykfvrEy9hoIoaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePCs3Sta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F941C4AF0F;
	Mon,  3 Jun 2024 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717415078;
	bh=KunT4nlCg7911ALJa7lOcyXfpiQdVZ5znExOTbbLGV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ePCs3StafjXPiSuIR3m+UDXUptsbPwB+J4owwXzQyO4HLyKwu8aRXbJbkzKZXt1xW
	 Pja7YvCqTx3qawexmh3abjlxifBpZLBCO2P7aOzEQSeZOgnRO1Vvs5Dj6S5ZZd6mqm
	 3RWPx1yac6MBEGh1UoseIt8s1TLZmkLkXz4e3h3afchdT2EIthZXWsXm8qbYsQjFKZ
	 OoTrQT70nfoPWmEp+GafKXo5EKYOqZ4z5lkXnJoU13kcI/AAWNlU368p+7PhYpOw2U
	 veeBcDi6he7jPkP3bXixb8gK+FEKuJw6MOQjru81EzfOGSetmsWcZeB3vm20wJUIjp
	 3yRb6VLrHLahw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso4199931a12.1;
        Mon, 03 Jun 2024 04:44:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQEFn3OBuF6CvDcBtOz68IjCx7cpPDto3EPWRseBNFjck3NThvDHm8WTT9zgNJQnr/5mmi0pIREjGSQ11ghTZc3XLjlf+gehmTsTaS+w2dPnC4Q37YVxoQfMbsncWfp9hpocFW2dxcoq9Om/ppjsXD1+kAt8F60eBDXIVHs5Xm+VnsbQ==
X-Gm-Message-State: AOJu0Yx5ITkzZJZJKSddW0DDjRwpcHJBI/If+1xAw/ghryp1wWTysDA4
	5ld4ueAd8PsGjU4x42kV26VCiSvXpWQD8rz5XAbW9AZSKETKpTbL6NQFmmrKabcikoLt8wy7x/4
	E4VbE/l3VaVe/KY4PfBapSt/kauc=
X-Google-Smtp-Source: AGHT+IG7/H90hc63WWNMkeMAnOX13JzopJNEYk51UGPzqfuIlsmZ8ozivL78F9eXs+/MfUByP3kU+MuoZdk04N08DSY=
X-Received: by 2002:a50:9e05:0:b0:57a:2400:3a56 with SMTP id
 4fb4d7f45d1cf-57a3651f208mr6105897a12.23.1717415076817; Mon, 03 Jun 2024
 04:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
 <CAJF2gTT51oZqEq-1TV_UEUufsrq=jRr4FAbmdtrChAHyUC1rXg@mail.gmail.com>
 <b6b6d273-4d57-4611-8c67-1a67d443b7d0@ghiti.fr> <CAJF2gTTiz_gkaA8OVkZynKUAFHFGij1W97qVSS3RKyMK5vkpdw@mail.gmail.com>
 <1cb05816-6f2f-4940-8051-b645f9f52c14@ghiti.fr>
In-Reply-To: <1cb05816-6f2f-4940-8051-b645f9f52c14@ghiti.fr>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 3 Jun 2024 19:44:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS-8KHs8LqiR70AxKQB9=sAZznXAXSbk=Q8PVwdKQSrbg@mail.gmail.com>
Message-ID: <CAJF2gTS-8KHs8LqiR70AxKQB9=sAZznXAXSbk=Q8PVwdKQSrbg@mail.gmail.com>
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

On Mon, Jun 3, 2024 at 7:34=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> On 03/06/2024 13:28, Guo Ren wrote:
> > On Mon, Jun 3, 2024 at 5:49=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> =
wrote:
> >> Hi Guo,
> >>
> >> On 31/05/2024 15:10, Guo Ren wrote:
> >>> On Wed, May 29, 2024 at 9:03=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> >>>> Hi Guo,
> >>>>
> >>>> On Wed, May 29, 2024 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org>=
 wrote:
> >>>>> On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> >>>>>> In order to produce a generic kernel, a user can select
> >>>>>> CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the tick=
et
> >>>>>> spinlock implementation if Zabha is not present.
> >>>>>>
> >>>>>> Note that we can't use alternatives here because the discovery of
> >>>>>> extensions is done too late and we need to start with the qspinloc=
k
> >>>>>> implementation because the ticket spinlock implementation would po=
llute
> >>>>>> the spinlock value, so let's use static keys.
> >>> Zabha is not a prerequisite for qspinlock; the prerequisite for
> >>> qspinlock is the *forward progress guarantee* in the atomic operation
> >>> loop during intense contention. Even with Zabha enabled to meet the
> >>> requirements of xchg_tail, that still only applies when the number of
> >>> CPUs is less than 16K. The qspinlock uses cmpxchg loop instead of
> >>> xchg_tail when the number of cores is more than 16K. Thus, hardware
> >>> support for Zabha does not equate to the safe use of qspinlock.
> >>
> >> But if we have Zacas to implement cmpxchg(), we still provide the
> >> "forward progress guarantee" then right? Let me know if I missed somet=
hing.
> > The qspinlock needs a "forward progress guarantee," not Zacas, and
> > Zabha could give a guarantee to qspinlock xchg_tail (CPUs < 16K) with
> > AMOSWAP.H instruction. But, using "LR/SC pairs" also could give enough
> > fwd guarantee that depends on the micro-arch design of the riscv core.
> > I think the help of AMO instead of LR/SC is it could off-load AMO
> > operations from LSU to CIU(Next Level Cache or Interconnect), which
> > gains better performance. "LR/SC pairs" only provide Near-Atomic, but
> > AMO gives Far-Atomic additionally.
>
>
> I understand qspinlocks require forward progress and that your company's
> LR/SC implementations provide such guarantee, I'm not arguing against
> your new extension proposal.
>
> It seemed to me in your previous message that you implied that when
> NR_CPUS > 16k, we should not use qspinlocks. My question was: "Don't
> Zacas provide such guarantee"? I think it does, so qspinlocks should
> actually depend on Zabha *and* Zacas. Is that correct to you?
See kernel/locking/qspinlock.c
#if _Q_PENDING_BITS =3D=3D 8 (NR_CPUS < 16K)
static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
{
        /*
         * We can use relaxed semantics since the caller ensures that the
         * MCS node is properly initialized before updating the tail.
         */
        return (u32)xchg_relaxed(&lock->tail,
                                 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
}
#else /* NR_CPUS >=3D 16K */
static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
{
        u32 old, new;

        old =3D atomic_read(&lock->val);
        do {
                new =3D (old & _Q_LOCKED_PENDING_MASK) | tail;
                /*
                 * We can use relaxed semantics since the caller ensures th=
at
                 * the MCS node is properly initialized before updating the
                 * tail.
                 */
        } while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));

        return old;
}
#endif

Look! You, Zacas, still need an additional FWD guarantee to break the
loop. That is, how *stickiness* your cache line is?

>
> Let me know if I misunderstood something again.
>
> Thanks,
>
> Alex
>
>
> >
> >
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> >>> Therefore, I would like to propose a new ISA extension: Zafpg(Atomic
> >>> Forward Progress Guarantee). If RISC-V vendors can ensure the progres=
s
> >>> of LR/SC or CMPXCHG LOOP at the microarchitectural level or if cache
> >>> lines are sufficiently sticky, they could then claim support for this
> >>> extension. Linux could then select different spinlock implementations
> >>> based on this extension's support or not.
> >>>
> >>>>>> This is largely based on Guo's work and Leonardo reviews at [1].
> >>>>>>
> >>>>>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1=
-guoren@kernel.org/ [1]
> >>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>>>>> ---
> >>>>>>    .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >>>>>>    arch/riscv/Kconfig                            |  1 +
> >>>>>>    arch/riscv/include/asm/Kbuild                 |  4 +-
> >>>>>>    arch/riscv/include/asm/spinlock.h             | 39 ++++++++++++=
+++++++
> >>>>>>    arch/riscv/kernel/setup.c                     | 18 +++++++++
> >>>>>>    include/asm-generic/qspinlock.h               |  2 +
> >>>>>>    include/asm-generic/ticket_spinlock.h         |  2 +
> >>>>>>    7 files changed, 66 insertions(+), 2 deletions(-)
> >>>>>>    create mode 100644 arch/riscv/include/asm/spinlock.h
> >>>>>>
> >>>>>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-=
support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.=
txt
> >>>>>> index 22f2990392ff..cf26042480e2 100644
> >>>>>> --- a/Documentation/features/locking/queued-spinlocks/arch-support=
.txt
> >>>>>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support=
.txt
> >>>>>> @@ -20,7 +20,7 @@
> >>>>>>        |    openrisc: |  ok  |
> >>>>>>        |      parisc: | TODO |
> >>>>>>        |     powerpc: |  ok  |
> >>>>>> -    |       riscv: | TODO |
> >>>>>> +    |       riscv: |  ok  |
> >>>>>>        |        s390: | TODO |
> >>>>>>        |          sh: | TODO |
> >>>>>>        |       sparc: |  ok  |
> >>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>>>> index 184a9edb04e0..ccf1703edeb9 100644
> >>>>>> --- a/arch/riscv/Kconfig
> >>>>>> +++ b/arch/riscv/Kconfig
> >>>>>> @@ -59,6 +59,7 @@ config RISCV
> >>>>>>           select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CA=
LL_STACK
> >>>>>>           select ARCH_USE_MEMTEST
> >>>>>>           select ARCH_USE_QUEUED_RWLOCKS
> >>>>>> +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> >>>>> Using qspinlock or not depends on real hardware capabilities, not t=
he
> >>>>> compiler flag. That's why I introduced combo-spinlock, ticket-spinl=
ock
> >>>>> & qspinlock three Kconfigs, and the combo-spinlock would compat all
> >>>>> hardware platforms but waste some qspinlock code size.
> >>>> You're right, and I think your comment matches what Conor mentioned
> >>>> about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
> >>>> will allow a platform with Zabha capability to use qspinlocks. But i=
f
> >>>> the hardware does not, it will fallback to the ticket spinlocks.
> >>>>
> >>>> But I agree that looking at the config alone may be misleading, even
> >>>> though it will work as expected at runtime. So I agree with you:
> >>>> unless anyone is strongly against the combo spinlocks, I will do wha=
t
> >>>> you suggest and add them.
> >>>>
> >>>> Thanks again for your initial work,
> >>>>
> >>>> Alex
> >>>>
> >>>>>>           select ARCH_USES_CFI_TRAPS if CFI_CLANG
> >>>>>>           select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> >>>>>>           select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> >>>>>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/as=
m/Kbuild
> >>>>>> index 504f8b7e72d4..ad72f2bd4cc9 100644
> >>>>>> --- a/arch/riscv/include/asm/Kbuild
> >>>>>> +++ b/arch/riscv/include/asm/Kbuild
> >>>>>> @@ -2,10 +2,12 @@
> >>>>>>    generic-y +=3D early_ioremap.h
> >>>>>>    generic-y +=3D flat.h
> >>>>>>    generic-y +=3D kvm_para.h
> >>>>>> +generic-y +=3D mcs_spinlock.h
> >>>>>>    generic-y +=3D parport.h
> >>>>>> -generic-y +=3D spinlock.h
> >>>>>>    generic-y +=3D spinlock_types.h
> >>>>>> +generic-y +=3D ticket_spinlock.h
> >>>>>>    generic-y +=3D qrwlock.h
> >>>>>>    generic-y +=3D qrwlock_types.h
> >>>>>> +generic-y +=3D qspinlock.h
> >>>>>>    generic-y +=3D user.h
> >>>>>>    generic-y +=3D vmlinux.lds.h
> >>>>>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/includ=
e/asm/spinlock.h
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..e00429ac20ed
> >>>>>> --- /dev/null
> >>>>>> +++ b/arch/riscv/include/asm/spinlock.h
> >>>>>> @@ -0,0 +1,39 @@
> >>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>>> +
> >>>>>> +#ifndef __ASM_RISCV_SPINLOCK_H
> >>>>>> +#define __ASM_RISCV_SPINLOCK_H
> >>>>>> +
> >>>>>> +#ifdef CONFIG_QUEUED_SPINLOCKS
> >>>>>> +#define _Q_PENDING_LOOPS       (1 << 9)
> >>>>>> +
> >>>>>> +#define __no_arch_spinlock_redefine
> >>>>>> +#include <asm/ticket_spinlock.h>
> >>>>>> +#include <asm/qspinlock.h>
> >>>>>> +#include <asm/alternative.h>
> >>>>>> +
> >>>>>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> >>>>>> +
> >>>>>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)               =
      \
> >>>>>> +static __always_inline type arch_spin_##op(type_lock lock)       =
      \
> >>>>>> +{                                                                =
      \
> >>>>>> +       if (static_branch_unlikely(&qspinlock_key))               =
      \
> >>>>>> +               return queued_spin_##op(lock);                    =
      \
> >>>>>> +       return ticket_spin_##op(lock);                            =
      \
> >>>>>> +}
> >>>>>> +
> >>>>>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> >>>>>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> >>>>>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> >>>>>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> >>>>>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> >>>>>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> >>>>>> +
> >>>>>> +#else
> >>>>>> +
> >>>>>> +#include <asm/ticket_spinlock.h>
> >>>>>> +
> >>>>>> +#endif
> >>>>>> +
> >>>>>> +#include <asm/qrwlock.h>
> >>>>>> +
> >>>>>> +#endif /* __ASM_RISCV_SPINLOCK_H */
> >>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >>>>>> index 4f73c0ae44b2..31ce75522fd4 100644
> >>>>>> --- a/arch/riscv/kernel/setup.c
> >>>>>> +++ b/arch/riscv/kernel/setup.c
> >>>>>> @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
> >>>>>>    #endif
> >>>>>>    }
> >>>>>>
> >>>>>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> >>>>>> +EXPORT_SYMBOL(qspinlock_key);
> >>>>>> +
> >>>>>> +static void __init riscv_spinlock_init(void)
> >>>>>> +{
> >>>>>> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA=
_EXT_ZABHA, 1)
> >>>>>> +                : : : : qspinlock);
> >>>>>> +
> >>>>>> +       static_branch_disable(&qspinlock_key);
> >>>>>> +       pr_info("Ticket spinlock: enabled\n");
> >>>>>> +
> >>>>>> +       return;
> >>>>>> +
> >>>>>> +qspinlock:
> >>>>>> +       pr_info("Queued spinlock: enabled\n");
> >>>>>> +}
> >>>>>> +
> >>>>>>    extern void __init init_rt_signal_env(void);
> >>>>>>
> >>>>>>    void __init setup_arch(char **cmdline_p)
> >>>>>> @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
> >>>>>>           riscv_set_dma_cache_alignment();
> >>>>>>
> >>>>>>           riscv_user_isa_enable();
> >>>>>> +       riscv_spinlock_init();
> >>>>>>    }
> >>>>>>
> >>>>>>    bool arch_cpu_is_hotpluggable(int cpu)
> >>>>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic=
/qspinlock.h
> >>>>>> index 0655aa5b57b2..bf47cca2c375 100644
> >>>>>> --- a/include/asm-generic/qspinlock.h
> >>>>>> +++ b/include/asm-generic/qspinlock.h
> >>>>>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(str=
uct qspinlock *lock)
> >>>>>>    }
> >>>>>>    #endif
> >>>>>>
> >>>>>> +#ifndef __no_arch_spinlock_redefine
> >>>>>>    /*
> >>>>>>     * Remapping spinlock architecture specific functions to the co=
rresponding
> >>>>>>     * queued spinlock functions.
> >>>>>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(str=
uct qspinlock *lock)
> >>>>>>    #define arch_spin_lock(l)              queued_spin_lock(l)
> >>>>>>    #define arch_spin_trylock(l)           queued_spin_trylock(l)
> >>>>>>    #define arch_spin_unlock(l)            queued_spin_unlock(l)
> >>>>>> +#endif
> >>>>>>
> >>>>>>    #endif /* __ASM_GENERIC_QSPINLOCK_H */
> >>>>>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-g=
eneric/ticket_spinlock.h
> >>>>>> index cfcff22b37b3..325779970d8a 100644
> >>>>>> --- a/include/asm-generic/ticket_spinlock.h
> >>>>>> +++ b/include/asm-generic/ticket_spinlock.h
> >>>>>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_conten=
ded(arch_spinlock_t *lock)
> >>>>>>           return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >>>>>>    }
> >>>>>>
> >>>>>> +#ifndef __no_arch_spinlock_redefine
> >>>>>>    /*
> >>>>>>     * Remapping spinlock architecture specific functions to the co=
rresponding
> >>>>>>     * ticket spinlock functions.
> >>>>>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_conte=
nded(arch_spinlock_t *lock)
> >>>>>>    #define arch_spin_lock(l)              ticket_spin_lock(l)
> >>>>>>    #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> >>>>>>    #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> >>>>>> +#endif
> >>>>>>
> >>>>>>    #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> >>>>>> --
> >>>>>> 2.39.2
> >>>>>>
> >>>>> --
> >>>>> Best Regards
> >>>>>    Guo Ren
> >>>
> >
> >



--=20
Best Regards
 Guo Ren

