Return-Path: <linux-arch+bounces-5293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0D92965F
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 04:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144D2281D91
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEADF29B0;
	Sun,  7 Jul 2024 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT+tjRNc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1223D0;
	Sun,  7 Jul 2024 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720318849; cv=none; b=ImLvh1zTLfiv1EIk+qdTPML8/YpXLT0KfD2cyYNohc+VnG6XtBsD8+LwEKnM0FjSXSzWjq6Y3u5jVs+llMIxIIJIYczCAQQKoyJwjFFRrOMEYbOUt32eaPBfFc3hfMorCJlfN8XyS6aq6QFhFoyrag22Ep0sJ1ksxvYPMzp5gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720318849; c=relaxed/simple;
	bh=cY0o9hgmLHD1Z12v22MXJydXZ/kFSz1lLKpRSOVKIzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3VVaNKexObUqpbMfSfZX0bJzcZE3TnRF9OGgCN/pi0cuy2VxB7dGViw5gLgsmEkwBmzNKfav0B04pVtOlonGjCaTKqpWHO1DCMJk9Yu1vedp74aE6tM4wfYWkCzAnT2pZlxa0v/WNl9fXmGhUPKXZ/4ukhodkySyM1/wt+PKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT+tjRNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03940C4AF0C;
	Sun,  7 Jul 2024 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720318849;
	bh=cY0o9hgmLHD1Z12v22MXJydXZ/kFSz1lLKpRSOVKIzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BT+tjRNcGEbbDph1vVSWPXHMUGG13wO6vVb3UdqHmoJ8+aasOMNoeajn+Hc82Pa+M
	 HSGp0DCMRhlpGiRFoqFM98e0kAagIQj1zCSX0io9vUlX/jom1UIXzI/l3pmcAs1sGU
	 u1u1ZsN352yp0uUCPRpHgL+LfaRbS8k8gtt6YPZ1TeEjpdPLPB5mVjq2YbNbv31SyN
	 8leTEtTc36SS8dlFgz0DD5sYV1KTKY6eoj8IkfXgyNwbDrS8LGCklJ72hydmCZ2XK8
	 BIoPNBmEbenTtaxTAJvSmr7Vi+by/eLVgUooHBsxRBbrJXxaQeFcYMEFbs+m2l70dq
	 62n6RD3n00qLA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a75131ce948so335639866b.2;
        Sat, 06 Jul 2024 19:20:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuurcmRM9s/M6+FqGyGk4nV0F7n6J1yZRxF7acyIK1YsNtIKMbOH/ltaRqAYtzKhoCdjRJuZ2NHQtB5elZMClhsAm6O24hnfEQTU6tV73DgKU/Jkq6BhD/9IdWiyKGsEaOf6u5QKhhETUywOQwjor+RzIf26OT1SWDaGq22Hk3GhqaSw==
X-Gm-Message-State: AOJu0YxJBdGTjdUI4rhmADe3vx8YNU7rVERZefud/dOi5uERQzdvKc9P
	PKIpNv6PD/fiV0BWy2MdvW385+S7dJrsV+7hCf5BJKzNKvohO7R42795uy36gsWOgvC5gGKnbgW
	1YsKjPkJoaniK5jne/SDlb2UHNO8=
X-Google-Smtp-Source: AGHT+IFKmvSy9AQyjIsVbStPZwYIWOG6JUkoomgpQKSUetymycnfWbAiSYM+kcEHu3oyixaS1CiEJAoQ1O5+aZJm6Ss=
X-Received: by 2002:a17:907:971b:b0:a77:da14:8403 with SMTP id
 a640c23a62f3a-a77da1485d0mr331581566b.2.1720318847441; Sat, 06 Jul 2024
 19:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com> <20240626130347.520750-11-alexghiti@rivosinc.com>
In-Reply-To: <20240626130347.520750-11-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 7 Jul 2024 10:20:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
Message-ID: <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
To: Alexandre Ghiti <alexghiti@rivosinc.com>
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

On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha is not present.
>
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
That's not true; we treat spinlock as qspinlock at first.
qspinlock_unlock would make the lock value zero (clean), but
ticket_lock would make a dirty one. (I've spent much time on this
mechanism, and you've preserved it in this patch.) So, making the
qspinlock -> ticket_lock change point safe until sched_init() is late
enough to make alternatives. The key problem of alternative
implementation is tough coding because you can't reuse the C code. The
whole ticket_lock must be rewritten in asm and include the qspinlock
fast path.

I think we should discuss some points before continuing the patch:
1. Using alternative mechanisms for combo spinlock
2. Using three Kconfigs for
ticket_spinlock/queune_spinlock/combo_spinlock during compile stage.
3. The forward progress guarantee requirement is written in
qspinlock.h comment. That is not about our CAS/BHA.

> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.
>
> This is largely based on Guo's work and Leonardo reviews at [1].
>
> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren=
@kernel.org/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  .../locking/queued-spinlocks/arch-support.txt |  2 +-
>  arch/riscv/Kconfig                            | 10 +++++
>  arch/riscv/include/asm/Kbuild                 |  4 +-
>  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>  arch/riscv/kernel/setup.c                     | 21 ++++++++++
>  include/asm-generic/qspinlock.h               |  2 +
>  include/asm-generic/ticket_spinlock.h         |  2 +
>  7 files changed, 78 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/spinlock.h
>
> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support=
.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> index 22f2990392ff..cf26042480e2 100644
> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> @@ -20,7 +20,7 @@
>      |    openrisc: |  ok  |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bbaec0444d0..c2ba673e58ca 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -72,6 +72,7 @@ config RISCV
>         select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +       select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>         select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>         select BUILDTIME_TABLE_SORT if MMU
>         select CLINT_TIMER if RISCV_M_MODE
> @@ -482,6 +483,15 @@ config NODES_SHIFT
>           Specify the maximum number of NUMA Nodes available on the targe=
t
>           system.  Increases memory reserved to accommodate various table=
s.
>
> +config RISCV_COMBO_SPINLOCKS
> +       bool "Using combo spinlock"
> +       depends on SMP && MMU && TOOLCHAIN_HAS_ZABHA
> +       select ARCH_USE_QUEUED_SPINLOCKS
> +       default y
> +       help
> +         Embed both queued spinlock and ticket lock so that the spinlock
> +         implementation can be chosen at runtime.
> +

COMBO SPINLOCK has side effects, which would expand spinlock code size
a lot. Ref: ARCH_INLINE_SPIN_LOCK

So, we shouldn't remove the three configs' selection.

+choice
+ prompt "RISC-V spinlock type"
+ default RISCV_COMBO_SPINLOCKS
+
+config RISCV_TICKET_SPINLOCKS
+ bool "Using ticket spinlock"
+
+config RISCV_QUEUED_SPINLOCKS
+ bool "Using queued spinlock"
+ depends on SMP && MMU
+ select ARCH_USE_QUEUED_SPINLOCKS
+ help
+  Make sure your micro arch give cmpxchg/xchg forward progress
+  guarantee. Otherwise, stay at ticket-lock.
+
+config RISCV_COMBO_SPINLOCKS
+ bool "Using combo spinlock"
+ depends on SMP && MMU
+ select ARCH_USE_QUEUED_SPINLOCKS
+ help
+  Select queued spinlock or ticket-lock by cmdline.
+endchoice
+



>  config RISCV_ALTERNATIVE
>         bool
>         depends on !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuil=
d
> index 504f8b7e72d4..ad72f2bd4cc9 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -2,10 +2,12 @@
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D flat.h
>  generic-y +=3D kvm_para.h
> +generic-y +=3D mcs_spinlock.h
>  generic-y +=3D parport.h
> -generic-y +=3D spinlock.h
>  generic-y +=3D spinlock_types.h
> +generic-y +=3D ticket_spinlock.h
>  generic-y +=3D qrwlock.h
>  generic-y +=3D qrwlock_types.h
> +generic-y +=3D qspinlock.h
>  generic-y +=3D user.h
>  generic-y +=3D vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/s=
pinlock.h
> new file mode 100644
> index 000000000000..4856d50006f2
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#define _Q_PENDING_LOOPS       (1 << 9)
> +
> +#define __no_arch_spinlock_redefine
> +#include <asm/ticket_spinlock.h>
> +#include <asm/qspinlock.h>
> +#include <asm/alternative.h>
> +
> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> +
> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
> +static __always_inline type arch_spin_##op(type_lock lock)             \
> +{                                                                      \
> +       if (static_branch_unlikely(&qspinlock_key))                     \
> +               return queued_spin_##op(lock);                          \
> +       return ticket_spin_##op(lock);                                  \
> +}
> +
> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> +
> +#else
> +
> +#include <asm/ticket_spinlock.h>
> +
> +#endif
> +
> +#include <asm/qrwlock.h>
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..929bccd4c9e5 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,26 @@ static void __init parse_dtb(void)
>  #endif
>  }
>
> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +       asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZAC=
AS, 1)
> +                : : : : no_zacas);
> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZA=
BHA, 1)
> +                : : : : qspinlock);
The requirement of qspinlock concerns the forward progress guarantee
in micro-arch design, which includes cmpxchg_loop & xchg_tail. So, I
don't think these features have a relationship with Qspinlock.

If your machine doesn't have enough stickiness for a young exclusive
cacheline, fall back to ticket_lock.

> +
> +no_zacas:
> +       static_branch_disable(&qspinlock_key);
> +       pr_info("Ticket spinlock: enabled\n");
> +
> +       return;
> +
> +qspinlock:
> +       pr_info("Queued spinlock: enabled\n");
> +}
> +
>  extern void __init init_rt_signal_env(void);
>
>  void __init setup_arch(char **cmdline_p)
> @@ -295,6 +315,7 @@ void __init setup_arch(char **cmdline_p)
>         riscv_set_dma_cache_alignment();
>
>         riscv_user_isa_enable();
> +       riscv_spinlock_init();
>  }
>
>  bool arch_cpu_is_hotpluggable(int cpu)
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinl=
ock.h
> index 0655aa5b57b2..bf47cca2c375 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qsp=
inlock *lock)
>  }
>  #endif
>
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the correspondi=
ng
>   * queued spinlock functions.
> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qsp=
inlock *lock)
>  #define arch_spin_lock(l)              queued_spin_lock(l)
>  #define arch_spin_trylock(l)           queued_spin_trylock(l)
>  #define arch_spin_unlock(l)            queued_spin_unlock(l)
> +#endif
>
>  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/=
ticket_spinlock.h
> index cfcff22b37b3..325779970d8a 100644
> --- a/include/asm-generic/ticket_spinlock.h
> +++ b/include/asm-generic/ticket_spinlock.h
> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arc=
h_spinlock_t *lock)
>         return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the correspondi=
ng
>   * ticket spinlock functions.
> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(ar=
ch_spinlock_t *lock)
>  #define arch_spin_lock(l)              ticket_spin_lock(l)
>  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
>  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> +#endif
>
>  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> --
> 2.39.2
>


--
Best Regards
 Guo Ren

