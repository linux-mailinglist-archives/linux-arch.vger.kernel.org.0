Return-Path: <linux-arch+bounces-5392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64149930EBB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F751F21284
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9C183097;
	Mon, 15 Jul 2024 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZeHeWruE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A818309D
	for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028488; cv=none; b=hlsEu7HnJuvQ6KJNU6uzvYmRMa7I2YuBx1Y1cXRlYJFJS6gQMUaJv1U8oE0M/1OU9qNN4EKS/mFnFSHKrgbBRT4aSU6El2UWXFfYyDJg4CgvgIYcMBKHlfLi6tpHks+HTkJ/etxN+yGYRn0h5aNRBVbjfUEd2c29XmDc3uencZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028488; c=relaxed/simple;
	bh=PbDGKHZB8Hpq9zzEBbWSyH1k1i4pAGIE8iCeeLPulnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuQxf8kPLTuI7Gv5hZwK+KGyAvkEHNJaelyLuKZi0rPSNyOom7KKHSGoToIKNox/Hk4/uASY/yk7ujjkgWqRVvUuTmGnuW/GnJ1P/hRvcGRYKP/H4+v9ZOD3eCJ3QDbvyryIfZnpR9roLhgU1XpopYyNU4c6RgrP0AzIBKDcE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZeHeWruE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c25beae1so412485166b.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721028484; x=1721633284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGtB8/Vj7xNRULtS4CUlLPOKsKC26qy/7NHpx/Q40ug=;
        b=ZeHeWruEL7K3ht0KhEWQOCxUxjKO+kLYIQEqWdvjXL67eeVgfeRpRvGPUyuBC0V9gj
         FWT9Lx2FMH6gBFPKir9cmnU9Jdz31/oN66mvOiuDiXJa/V34oaWYj8++eOt9rsbri4TK
         mnDLSK3vn/PLAoBJBAr/7qfuJ7Ni/eQyOxh1AhOg45wEV3gW7t5aFNNVHXuC2w8vb9Gn
         CLtotNTMdM1VABEvLb8OhV3iWpHb4/jZTDcca8SavB1LgeICnJaGxumWBTa5hxBfC+DC
         a0qk008hJy9/ojc7Dj/1H+bMa4GragWXmYkY4zaV9/JTyTPwUbgaFNUXcW5KESRqUv9C
         AUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028484; x=1721633284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGtB8/Vj7xNRULtS4CUlLPOKsKC26qy/7NHpx/Q40ug=;
        b=uuMH4hpbGMwsH4Gu4GMdRSVUwr/zsFFUSsfJ75Oeq6xIDiHkVVR2h6yNNgLsvq976A
         VZDCXMLmWmDapMVb7hjXEzZODfGRZIlNkg7IIUvUPy6DOTs1CLHrr+BzSw+LDdmaXBmi
         ySDu7EIFzTwt8zFvu0mUH9DT8MiAw7Z4bz4yAjahMguIFr6Q6U5GfiUOD6+TnCvoBnLQ
         5cl2k3TNyBnX+nS0gXoB6oAluF9otHxqV6rDH/xTWE2wxe5k7pwgnEA3POyvNUhgNUFw
         +qE5nAwWuHdYJ2WBU8Oohb1qhRe7fG7M/CP9V59//YzSYHyhHoW9RNs4FjO5REnTJwJp
         fWUw==
X-Forwarded-Encrypted: i=1; AJvYcCU/CLV7xZELmCNozqJVsW71d5rft9akFZ/qItAq7VPMJwdM7onL18h9L7TSj9uk4RhQ39RgqmE0fEnWqc6N6GyOwzP5tHNrUO4tDw==
X-Gm-Message-State: AOJu0Yx0oR5kRHJwjZWQ4U6bTZYtycU/uifJ8Nn5ErCvbeWH3qcZw0l8
	eqyQMzgR1+RjPxoz4rjsLv45Q/BEyY21JopXVpYRz+VhAXesJIaCMt4gqRbYpdM1z6jfBPlh+Nt
	SOohvlgkwhvnbdm3pZ7usl0tpvBuxFjAuaTxMsg==
X-Google-Smtp-Source: AGHT+IH3GSAYwcRos+SFhIt4fp03og9JyYVCmGEFlKAvcEmbtvrGJ/+88ITUFpKfk7MaL2TvK2hvQ5rXLToktmuzQKM=
X-Received: by 2002:a17:906:46c9:b0:a77:e2b2:8ec with SMTP id
 a640c23a62f3a-a780b68899dmr1175821566b.3.1721028483799; Mon, 15 Jul 2024
 00:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com> <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
In-Reply-To: <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 09:27:53 +0200
Message-ID: <CAHVXubizLq=qZgVQ2vBFe5zVuLRP0DGw=UN4U_Wkx2P2xsP3Mw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
To: Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Sun, Jul 7, 2024 at 4:20=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > In order to produce a generic kernel, a user can select
> > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha is not present.
> >
> > Note that we can't use alternatives here because the discovery of
> > extensions is done too late and we need to start with the qspinlock
> That's not true; we treat spinlock as qspinlock at first.

That's what I said: we have to use the qspinlock implementation at
first *because* we can't discover the extensions soon enough to use
the right spinlock implementation before the kernel uses a spinlock.
And since the spinlocks are used *before* the discovery of the
extensions, we cannot use the current alternative mechanism or we'd
need to extend it to add an "initial" value which does not depend on
the available extensions.

> qspinlock_unlock would make the lock value zero (clean), but
> ticket_lock would make a dirty one. (I've spent much time on this
> mechanism, and you've preserved it in this patch.) So, making the
> qspinlock -> ticket_lock change point safe until sched_init() is late
> enough to make alternatives. The key problem of alternative
> implementation is tough coding because you can't reuse the C code. The
> whole ticket_lock must be rewritten in asm and include the qspinlock
> fast path.
>
> I think we should discuss some points before continuing the patch:
> 1. Using alternative mechanisms for combo spinlock

We can easily get the extension string from the DT, and I have a PoC
that works with ACPI, that would make this possible.

> 2. Using three Kconfigs for
> ticket_spinlock/queune_spinlock/combo_spinlock during compile stage.

This makes sense, I'll do that.

> 3. The forward progress guarantee requirement is written in
> qspinlock.h comment. That is not about our CAS/BHA.
>
> > implementation because the ticket spinlock implementation would pollute
> > the spinlock value, so let's use static keys.
> >
> > This is largely based on Guo's work and Leonardo reviews at [1].
> >
> > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guor=
en@kernel.org/ [1]
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >  arch/riscv/Kconfig                            | 10 +++++
> >  arch/riscv/include/asm/Kbuild                 |  4 +-
> >  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
> >  arch/riscv/kernel/setup.c                     | 21 ++++++++++
> >  include/asm-generic/qspinlock.h               |  2 +
> >  include/asm-generic/ticket_spinlock.h         |  2 +
> >  7 files changed, 78 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/spinlock.h
> >
> > diff --git a/Documentation/features/locking/queued-spinlocks/arch-suppo=
rt.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > index 22f2990392ff..cf26042480e2 100644
> > --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > @@ -20,7 +20,7 @@
> >      |    openrisc: |  ok  |
> >      |      parisc: | TODO |
> >      |     powerpc: |  ok  |
> > -    |       riscv: | TODO |
> > +    |       riscv: |  ok  |
> >      |        s390: | TODO |
> >      |          sh: | TODO |
> >      |       sparc: |  ok  |
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0bbaec0444d0..c2ba673e58ca 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -72,6 +72,7 @@ config RISCV
> >         select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >         select ARCH_WANTS_NO_INSTR
> >         select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +       select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> >         select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >         select BUILDTIME_TABLE_SORT if MMU
> >         select CLINT_TIMER if RISCV_M_MODE
> > @@ -482,6 +483,15 @@ config NODES_SHIFT
> >           Specify the maximum number of NUMA Nodes available on the tar=
get
> >           system.  Increases memory reserved to accommodate various tab=
les.
> >
> > +config RISCV_COMBO_SPINLOCKS
> > +       bool "Using combo spinlock"
> > +       depends on SMP && MMU && TOOLCHAIN_HAS_ZABHA
> > +       select ARCH_USE_QUEUED_SPINLOCKS
> > +       default y
> > +       help
> > +         Embed both queued spinlock and ticket lock so that the spinlo=
ck
> > +         implementation can be chosen at runtime.
> > +
>
> COMBO SPINLOCK has side effects, which would expand spinlock code size
> a lot. Ref: ARCH_INLINE_SPIN_LOCK
>
> So, we shouldn't remove the three configs' selection.
>
> +choice
> + prompt "RISC-V spinlock type"
> + default RISCV_COMBO_SPINLOCKS
> +
> +config RISCV_TICKET_SPINLOCKS
> + bool "Using ticket spinlock"
> +
> +config RISCV_QUEUED_SPINLOCKS
> + bool "Using queued spinlock"
> + depends on SMP && MMU
> + select ARCH_USE_QUEUED_SPINLOCKS
> + help
> +  Make sure your micro arch give cmpxchg/xchg forward progress
> +  guarantee. Otherwise, stay at ticket-lock.
> +
> +config RISCV_COMBO_SPINLOCKS
> + bool "Using combo spinlock"
> + depends on SMP && MMU
> + select ARCH_USE_QUEUED_SPINLOCKS
> + help
> +  Select queued spinlock or ticket-lock by cmdline.
> +endchoice
> +
>
>
>
> >  config RISCV_ALTERNATIVE
> >         bool
> >         depends on !XIP_KERNEL
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbu=
ild
> > index 504f8b7e72d4..ad72f2bd4cc9 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -2,10 +2,12 @@
> >  generic-y +=3D early_ioremap.h
> >  generic-y +=3D flat.h
> >  generic-y +=3D kvm_para.h
> > +generic-y +=3D mcs_spinlock.h
> >  generic-y +=3D parport.h
> > -generic-y +=3D spinlock.h
> >  generic-y +=3D spinlock_types.h
> > +generic-y +=3D ticket_spinlock.h
> >  generic-y +=3D qrwlock.h
> >  generic-y +=3D qrwlock_types.h
> > +generic-y +=3D qspinlock.h
> >  generic-y +=3D user.h
> >  generic-y +=3D vmlinux.lds.h
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm=
/spinlock.h
> > new file mode 100644
> > index 000000000000..4856d50006f2
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RISCV_SPINLOCK_H
> > +#define __ASM_RISCV_SPINLOCK_H
> > +
> > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +#define _Q_PENDING_LOOPS       (1 << 9)
> > +
> > +#define __no_arch_spinlock_redefine
> > +#include <asm/ticket_spinlock.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/alternative.h>
> > +
> > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > +
> > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                    =
 \
> > +static __always_inline type arch_spin_##op(type_lock lock)            =
 \
> > +{                                                                     =
 \
> > +       if (static_branch_unlikely(&qspinlock_key))                    =
 \
> > +               return queued_spin_##op(lock);                         =
 \
> > +       return ticket_spin_##op(lock);                                 =
 \
> > +}
> > +
> > +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > +
> > +#else
> > +
> > +#include <asm/ticket_spinlock.h>
> > +
> > +#endif
> > +
> > +#include <asm/qrwlock.h>
> > +
> > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 4f73c0ae44b2..929bccd4c9e5 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -244,6 +244,26 @@ static void __init parse_dtb(void)
> >  #endif
> >  }
> >
> > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > +EXPORT_SYMBOL(qspinlock_key);
> > +
> > +static void __init riscv_spinlock_init(void)
> > +{
> > +       asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_Z=
ACAS, 1)
> > +                : : : : no_zacas);
> > +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_=
ZABHA, 1)
> > +                : : : : qspinlock);
> The requirement of qspinlock concerns the forward progress guarantee
> in micro-arch design, which includes cmpxchg_loop & xchg_tail. So, I
> don't think these features have a relationship with Qspinlock.
>
> If your machine doesn't have enough stickiness for a young exclusive
> cacheline, fall back to ticket_lock.

How riscv zacas/zabha implementation would not provide forward
progress guarantee when all other architecture's atomic memory
operations do?

>
> > +
> > +no_zacas:
> > +       static_branch_disable(&qspinlock_key);
> > +       pr_info("Ticket spinlock: enabled\n");
> > +
> > +       return;
> > +
> > +qspinlock:
> > +       pr_info("Queued spinlock: enabled\n");
> > +}
> > +
> >  extern void __init init_rt_signal_env(void);
> >
> >  void __init setup_arch(char **cmdline_p)
> > @@ -295,6 +315,7 @@ void __init setup_arch(char **cmdline_p)
> >         riscv_set_dma_cache_alignment();
> >
> >         riscv_user_isa_enable();
> > +       riscv_spinlock_init();
> >  }
> >
> >  bool arch_cpu_is_hotpluggable(int cpu)
> > diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspi=
nlock.h
> > index 0655aa5b57b2..bf47cca2c375 100644
> > --- a/include/asm-generic/qspinlock.h
> > +++ b/include/asm-generic/qspinlock.h
> > @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct q=
spinlock *lock)
> >  }
> >  #endif
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * queued spinlock functions.
> > @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct q=
spinlock *lock)
> >  #define arch_spin_lock(l)              queued_spin_lock(l)
> >  #define arch_spin_trylock(l)           queued_spin_trylock(l)
> >  #define arch_spin_unlock(l)            queued_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> > diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generi=
c/ticket_spinlock.h
> > index cfcff22b37b3..325779970d8a 100644
> > --- a/include/asm-generic/ticket_spinlock.h
> > +++ b/include/asm-generic/ticket_spinlock.h
> > @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(a=
rch_spinlock_t *lock)
> >         return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >  }
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * ticket spinlock functions.
> > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(=
arch_spinlock_t *lock)
> >  #define arch_spin_lock(l)              ticket_spin_lock(l)
> >  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> >  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
>  Guo Ren

