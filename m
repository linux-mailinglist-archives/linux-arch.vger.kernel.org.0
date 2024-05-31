Return-Path: <linux-arch+bounces-4635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41928D6272
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B45A1F218F1
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902E158A16;
	Fri, 31 May 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTWoiwAO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F015886A;
	Fri, 31 May 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161025; cv=none; b=FnBvoxisx8nd3iANo2yu5ojxNfrm1+Na6sEsYpCzE1WkgkMFXGNYG1YxFCsG2ef+oJldUPUh9y6UOMlEh4yQtBTGYLPosjXk+xYVTlpJgEOU+O5mQEgdiDD9xghhS8KR2EYDgNSRx19aHDVHGTJy/JdByb+REY+1yQeBsZpVjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161025; c=relaxed/simple;
	bh=8QCgHXteus+gEYlQO1Foy6LdILp9xlsPkke4GGh3Tho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRNc7ZOB1gRyGV/1O7J/TvKLGv/yIQbkvYHOMPHSo9ED3Xvp1gvensTJiqT3xxAANOz0loQpIzhgdL6fEn3ArJjTKP7dwflW7wI/F8UJ0FTqYvTkGd1WKS7BvzldZe+/sOZESXIdyGr3FgP+HhLqqlW3yh+yQgnsgH5Xv3AW0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTWoiwAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0D2C4AF0B;
	Fri, 31 May 2024 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161025;
	bh=8QCgHXteus+gEYlQO1Foy6LdILp9xlsPkke4GGh3Tho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BTWoiwAOAXY/PUzTkl2tsKzSzPjwcLKi5oWX2dG4hetq2FS0ullMwKL0cepidAyCa
	 M+F7HBP0YwMmJsX9gYQASrARYm3OnzqZE+lm+lzpvOyx61MVqbPbnAkjzgjak1JN+F
	 ZPhofIWqFWYFEDCX/k4SIZgjFQjpv0sctIEEy2NcqtGa7jnzlKpjv78B/Q3e/6SZiy
	 oPzJcR/zLVc8AHZyX3c8LwMlHhH51scrGRBIjiY0qMrK8RMe5+OGl8aiKNRd+jbfLE
	 0QDGezoLKCWhDWnxZ6MwNxZhDFnkZs1PWI57t/NWTIHf+EoYa13nkyWHvPn8cpoBch
	 xvJTwpRCbgAtQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6893c33403so21109566b.3;
        Fri, 31 May 2024 06:10:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkzWLZVs6sskF6FiEk/vsoCkvWqOlE48RcRLtPYp9sxaNueoPw4l6jtnQ8u//OfaxwOCP8yMnMf7T4lS87lBTpnz0faBnI16bOVPbEOo/EjxYDyuHi4fiaGgGPgVhkOmHYarLdh5nDpwHRF0TBV9TP4AHiqmzG05bE89cmHG1u3ZPGQA==
X-Gm-Message-State: AOJu0YwuQijCEgVFz8TvFSbW8J5zcCTDQCRZOY0Y9hD7oPwxzjA6dk36
	W4TEqfQtAFnvQOpM5BLiLtUWTvL1hz0vYzw6lGDM9TIvVw+iOTWMwTtKkmlnz1CE2twG7+pd1NY
	rVUO3rpdM4ZYhA86UV805uzqMAio=
X-Google-Smtp-Source: AGHT+IEiMa+QRMtujbS8gM5zke/mAppMeFLXITFRepz8pWGNyckaNYHydFArdtVCwkKAAG0fF8cBRJx7SXKMGTztCZ8=
X-Received: by 2002:a17:907:15d4:b0:a68:8c5e:1589 with SMTP id
 a640c23a62f3a-a688c5e1a9amr75024566b.44.1717161023509; Fri, 31 May 2024
 06:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
In-Reply-To: <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 31 May 2024 21:10:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT51oZqEq-1TV_UEUufsrq=jRr4FAbmdtrChAHyUC1rXg@mail.gmail.com>
Message-ID: <CAJF2gTT51oZqEq-1TV_UEUufsrq=jRr4FAbmdtrChAHyUC1rXg@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:03=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Guo,
>
> On Wed, May 29, 2024 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrot=
e:
> >
> > On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > >
> > > In order to produce a generic kernel, a user can select
> > > CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
> > > spinlock implementation if Zabha is not present.
> > >
> > > Note that we can't use alternatives here because the discovery of
> > > extensions is done too late and we need to start with the qspinlock
> > > implementation because the ticket spinlock implementation would pollu=
te
> > > the spinlock value, so let's use static keys.
Zabha is not a prerequisite for qspinlock; the prerequisite for
qspinlock is the *forward progress guarantee* in the atomic operation
loop during intense contention. Even with Zabha enabled to meet the
requirements of xchg_tail, that still only applies when the number of
CPUs is less than 16K. The qspinlock uses cmpxchg loop instead of
xchg_tail when the number of cores is more than 16K. Thus, hardware
support for Zabha does not equate to the safe use of qspinlock.

Therefore, I would like to propose a new ISA extension: Zafpg(Atomic
Forward Progress Guarantee). If RISC-V vendors can ensure the progress
of LR/SC or CMPXCHG LOOP at the microarchitectural level or if cache
lines are sufficiently sticky, they could then claim support for this
extension. Linux could then select different spinlock implementations
based on this extension's support or not.

> > >
> > > This is largely based on Guo's work and Leonardo reviews at [1].
> > >
> > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-gu=
oren@kernel.org/ [1]
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> > >  arch/riscv/Kconfig                            |  1 +
> > >  arch/riscv/include/asm/Kbuild                 |  4 +-
> > >  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++=
++
> > >  arch/riscv/kernel/setup.c                     | 18 +++++++++
> > >  include/asm-generic/qspinlock.h               |  2 +
> > >  include/asm-generic/ticket_spinlock.h         |  2 +
> > >  7 files changed, 66 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > >
> > > diff --git a/Documentation/features/locking/queued-spinlocks/arch-sup=
port.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > index 22f2990392ff..cf26042480e2 100644
> > > --- a/Documentation/features/locking/queued-spinlocks/arch-support.tx=
t
> > > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.tx=
t
> > > @@ -20,7 +20,7 @@
> > >      |    openrisc: |  ok  |
> > >      |      parisc: | TODO |
> > >      |     powerpc: |  ok  |
> > > -    |       riscv: | TODO |
> > > +    |       riscv: |  ok  |
> > >      |        s390: | TODO |
> > >      |          sh: | TODO |
> > >      |       sparc: |  ok  |
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 184a9edb04e0..ccf1703edeb9 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -59,6 +59,7 @@ config RISCV
> > >         select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_ST=
ACK
> > >         select ARCH_USE_MEMTEST
> > >         select ARCH_USE_QUEUED_RWLOCKS
> > > +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> > Using qspinlock or not depends on real hardware capabilities, not the
> > compiler flag. That's why I introduced combo-spinlock, ticket-spinlock
> > & qspinlock three Kconfigs, and the combo-spinlock would compat all
> > hardware platforms but waste some qspinlock code size.
>
> You're right, and I think your comment matches what Conor mentioned
> about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
> will allow a platform with Zabha capability to use qspinlocks. But if
> the hardware does not, it will fallback to the ticket spinlocks.
>
> But I agree that looking at the config alone may be misleading, even
> though it will work as expected at runtime. So I agree with you:
> unless anyone is strongly against the combo spinlocks, I will do what
> you suggest and add them.
>
> Thanks again for your initial work,
>
> Alex
>
> >
> > >         select ARCH_USES_CFI_TRAPS if CFI_CLANG
> > >         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> > >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/K=
build
> > > index 504f8b7e72d4..ad72f2bd4cc9 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -2,10 +2,12 @@
> > >  generic-y +=3D early_ioremap.h
> > >  generic-y +=3D flat.h
> > >  generic-y +=3D kvm_para.h
> > > +generic-y +=3D mcs_spinlock.h
> > >  generic-y +=3D parport.h
> > > -generic-y +=3D spinlock.h
> > >  generic-y +=3D spinlock_types.h
> > > +generic-y +=3D ticket_spinlock.h
> > >  generic-y +=3D qrwlock.h
> > >  generic-y +=3D qrwlock_types.h
> > > +generic-y +=3D qspinlock.h
> > >  generic-y +=3D user.h
> > >  generic-y +=3D vmlinux.lds.h
> > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/a=
sm/spinlock.h
> > > new file mode 100644
> > > index 000000000000..e00429ac20ed
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/spinlock.h
> > > @@ -0,0 +1,39 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > +#define __ASM_RISCV_SPINLOCK_H
> > > +
> > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > +#define _Q_PENDING_LOOPS       (1 << 9)
> > > +
> > > +#define __no_arch_spinlock_redefine
> > > +#include <asm/ticket_spinlock.h>
> > > +#include <asm/qspinlock.h>
> > > +#include <asm/alternative.h>
> > > +
> > > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > > +
> > > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                  =
   \
> > > +static __always_inline type arch_spin_##op(type_lock lock)          =
   \
> > > +{                                                                   =
   \
> > > +       if (static_branch_unlikely(&qspinlock_key))                  =
   \
> > > +               return queued_spin_##op(lock);                       =
   \
> > > +       return ticket_spin_##op(lock);                               =
   \
> > > +}
> > > +
> > > +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > > +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > > +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > > +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > > +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > > +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > > +
> > > +#else
> > > +
> > > +#include <asm/ticket_spinlock.h>
> > > +
> > > +#endif
> > > +
> > > +#include <asm/qrwlock.h>
> > > +
> > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 4f73c0ae44b2..31ce75522fd4 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
> > >  #endif
> > >  }
> > >
> > > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > > +EXPORT_SYMBOL(qspinlock_key);
> > > +
> > > +static void __init riscv_spinlock_init(void)
> > > +{
> > > +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EX=
T_ZABHA, 1)
> > > +                : : : : qspinlock);
> > > +
> > > +       static_branch_disable(&qspinlock_key);
> > > +       pr_info("Ticket spinlock: enabled\n");
> > > +
> > > +       return;
> > > +
> > > +qspinlock:
> > > +       pr_info("Queued spinlock: enabled\n");
> > > +}
> > > +
> > >  extern void __init init_rt_signal_env(void);
> > >
> > >  void __init setup_arch(char **cmdline_p)
> > > @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
> > >         riscv_set_dma_cache_alignment();
> > >
> > >         riscv_user_isa_enable();
> > > +       riscv_spinlock_init();
> > >  }
> > >
> > >  bool arch_cpu_is_hotpluggable(int cpu)
> > > diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qs=
pinlock.h
> > > index 0655aa5b57b2..bf47cca2c375 100644
> > > --- a/include/asm-generic/qspinlock.h
> > > +++ b/include/asm-generic/qspinlock.h
> > > @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct=
 qspinlock *lock)
> > >  }
> > >  #endif
> > >
> > > +#ifndef __no_arch_spinlock_redefine
> > >  /*
> > >   * Remapping spinlock architecture specific functions to the corresp=
onding
> > >   * queued spinlock functions.
> > > @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct=
 qspinlock *lock)
> > >  #define arch_spin_lock(l)              queued_spin_lock(l)
> > >  #define arch_spin_trylock(l)           queued_spin_trylock(l)
> > >  #define arch_spin_unlock(l)            queued_spin_unlock(l)
> > > +#endif
> > >
> > >  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> > > diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-gene=
ric/ticket_spinlock.h
> > > index cfcff22b37b3..325779970d8a 100644
> > > --- a/include/asm-generic/ticket_spinlock.h
> > > +++ b/include/asm-generic/ticket_spinlock.h
> > > @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended=
(arch_spinlock_t *lock)
> > >         return (s16)((val >> 16) - (val & 0xffff)) > 1;
> > >  }
> > >
> > > +#ifndef __no_arch_spinlock_redefine
> > >  /*
> > >   * Remapping spinlock architecture specific functions to the corresp=
onding
> > >   * ticket spinlock functions.
> > > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contende=
d(arch_spinlock_t *lock)
> > >  #define arch_spin_lock(l)              ticket_spin_lock(l)
> > >  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> > >  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> > > +#endif
> > >
> > >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren

