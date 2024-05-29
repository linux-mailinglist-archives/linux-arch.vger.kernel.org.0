Return-Path: <linux-arch+bounces-4575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0008D32E0
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D7AB2551F
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064515B10C;
	Wed, 29 May 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVhJ4Im8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A0381C8;
	Wed, 29 May 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974646; cv=none; b=fti7O1y5RJpRgt+o2eM+IxWv1MJrD0a17QvaKx1Cy7z6ou3ckQ5WGoE9zBVyk460sLqoXKD2pgxWpdpFzsv9H0PPJdzH/hM7Ss9nWPmIudvRSIZMiEw1pnSWpmmaGpmKac00IvAHeVXUmcy3lS3Hm2xZk49IYMOOOwqzINgwnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974646; c=relaxed/simple;
	bh=rBGQ1VrulL5ksiCDO9ZkVYWgjPIaCkQXBVisyW3pkOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d63gsnKkjz+X0xzxiHG24ITiuDLj51utu8mZDRJEC7qmGH7ZgPc79gb+gZrBSvV6cwa6LnMxTF+0N6iWnSiDKeTvxzn+vuVsHKb6N6jal8lGnQ3Fyg/+RdKFg0jGcZSqWsj5caSIskGvlswbqOZEXFJUmo34Y0A2t9PPfC2FiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVhJ4Im8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5295FC4AF0A;
	Wed, 29 May 2024 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716974646;
	bh=rBGQ1VrulL5ksiCDO9ZkVYWgjPIaCkQXBVisyW3pkOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hVhJ4Im8NPkPQ5JPvOOJWHqqcTJEGJ0gd4qy6m/CrRZS/AJ+PSYotRRPZhaiAogGz
	 mPdLyHS6bi4G8a262UiQUU28NhUFIJh/iICVKqg3k/tojDtPUdrPrNTN/Jt/A/ogIa
	 6xMaQtZNMgOmgieIFUnrjRTIbvGU0zKmSBwbnlnFWy0zHPsoNSPVa3R/cyM7qb4p0d
	 rs45oxuhxYC1oqkpExG+K93qcTxDOj4zLa350F/T7JRCv+KX32Whb+g+F+JII7jqqQ
	 dNYNOwhMVKcxJM+0y9zuE84q4ISHtlCXha94wtaQ4RZAb5vGoMZJBbIXIx+AdBC3lT
	 9sNtLn05KyMUQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5241b49c0daso2170092e87.0;
        Wed, 29 May 2024 02:24:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsg0FI4c7fNRoMEeKwXr6u55feKA6YifVB6Ijso5wbQNrxamqSNX9PCRrodt8rgzxlmD8zSaOxP9qHjrsUhrj0IRUoRc3vSG4jVpaGMq0KQaf8IbCNAxVZXcr+KDmKs2/xbQU1e3E25IJ5Pu3/j72krIULnb9foEqg1nTWwxPVpQynSw==
X-Gm-Message-State: AOJu0YwF+vFkDKbQhQbJ4rRetre2j/+dKWTevjJb9qUw72V7ZCqTWP8k
	BqypQbqyMSNxOCkBj/8CxN8ZGiKULbuBtl8QwEgRRIJRTB6xt0bvsXq98JuzTyLzbbyBP7P38wb
	RBZ3NnyDYnV1tCtaPhrnSban5LrE=
X-Google-Smtp-Source: AGHT+IElA8UwiOiY8gJyoia8LQoKpjSTPgsqCuD06x/Q6vDZD/ahnuW6xbCvDcq/TynBn6IHwJXBE5f8DxOvVGOdUA0=
X-Received: by 2002:a19:ad06:0:b0:52b:6eef:41b5 with SMTP id
 2adb3069b0e04-52b6eef42e5mr201340e87.0.1716974644631; Wed, 29 May 2024
 02:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com> <20240528151052.313031-8-alexghiti@rivosinc.com>
In-Reply-To: <20240528151052.313031-8-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 29 May 2024 17:23:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
Message-ID: <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
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

On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> In order to produce a generic kernel, a user can select
> CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha is not present.
>
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
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
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/include/asm/Kbuild                 |  4 +-
>  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
>  arch/riscv/kernel/setup.c                     | 18 +++++++++
>  include/asm-generic/qspinlock.h               |  2 +
>  include/asm-generic/ticket_spinlock.h         |  2 +
>  7 files changed, 66 insertions(+), 2 deletions(-)
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
> index 184a9edb04e0..ccf1703edeb9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -59,6 +59,7 @@ config RISCV
>         select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
>         select ARCH_USE_MEMTEST
>         select ARCH_USE_QUEUED_RWLOCKS
> +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
Using qspinlock or not depends on real hardware capabilities, not the
compiler flag. That's why I introduced combo-spinlock, ticket-spinlock
& qspinlock three Kconfigs, and the combo-spinlock would compat all
hardware platforms but waste some qspinlock code size.

>         select ARCH_USES_CFI_TRAPS if CFI_CLANG
>         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
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
> index 000000000000..e00429ac20ed
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
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
> index 4f73c0ae44b2..31ce75522fd4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
>  #endif
>  }
>
> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZA=
BHA, 1)
> +                : : : : qspinlock);
> +
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
> @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
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


--=20
Best Regards
 Guo Ren

