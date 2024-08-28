Return-Path: <linux-arch+bounces-6704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC696221B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBAB1F2442C
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22215B0F4;
	Wed, 28 Aug 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nmixoMGF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE03C488
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833015; cv=none; b=TchJKyS/qT81jNRW/asfT7kYLEtwHKEZ119sO09txUoLBpSyQnFSMAOSqkpPxNMIPV8IhuaYxELTqo7jaAqfEWAIHEebatl/V0Ww2EYIRfiSzCagDPxVLPF5NN73qiX8BQsT7y4UhSBEJk5dKjQfet1YFqKjZA7QSuXn+h93uNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833015; c=relaxed/simple;
	bh=2Pbz881cSuYbtr4/HGMFjzsD7auhutBIp/S/9qqHtlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKGoegXXWWN5xWEqNSJQxbwbr/WMsNKx5kxGDjidZK5Ta1Be4qh2UWfl5E3HPtQ2jv0zDe+qRVOFvn9QUntvwt7qXD/RBy8YcDCauoX+97SIoWeHRv6pIubqduhl6GO2d3pl0H3VvoWWb4Yjxy0/ZuIqXY1ieHfBiENr+Ajd0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nmixoMGF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so672004666b.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724833012; x=1725437812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5jgym96iBOUxWXG/8AhYDRNxAzEzE7DFJdRRz9Qldg=;
        b=nmixoMGFwJf4OUEFoTnPArO7ayWg+JOkGjQ9Fxvy7srrw45uE38u9f/EpwBXZ24HwW
         v9hlt4+hb4gUG+mytSUJAHXWbNnWU7/vNqBNWg4Ojj1nN+8vv3yGoEtV7wPbXUWKs2DR
         3OyFWyKbVpn/UvEgaCbMa70yx1fmH5SSD8GDsk3WO1fZOoeFKM+v0QSLTrJX0O/0EWIr
         m/m2UL6NhPGbLISNa6sSNDr9hCpYBzJlW+eyRQXcdaZ7wqBL53FBSPSgTWE4iC6m+qIQ
         vorGyFQGBKeGjl/78oHN4BwznT/8C/+oLIL5UGWenEwimlTj86HAX5Xj1WoKXANpq+cA
         yB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833012; x=1725437812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5jgym96iBOUxWXG/8AhYDRNxAzEzE7DFJdRRz9Qldg=;
        b=Oy16BW0jbh+PyJygV9+P+0M//9Ife+wzqDOUYFRZR4/aGWMJzKh7mfOkvuIA42lMRe
         foX7cSnq5Umn1YHHcXPrjPC1i3YJa7xSq8ikVi+Z9kWZoiIqZV4mtQ8oTopIlEQ25Pcr
         fkt5EAzz+37Z7rWAU0C1Lc5PafCwPtQgHtIOCyWTNksvRJ/nD74Cv4eFw5Ybq8jb6cGy
         Rw+JLS5yvDJn/w2eHv6ubaible7UsPa6oOzOLnuNebjxbOngNysetPcAO8JU6bn0rWlC
         DILL7L8QKOQdQx+B4hwDlsYfRVxXTrqNryY86+V9NRCNaKFgJxtoVrqixFDc53pQCJgY
         aiwg==
X-Forwarded-Encrypted: i=1; AJvYcCXiz/UxfjWHgwoF5pvYgtGZiWzN1arxSaJAOLCjjtPGeeHiyT1PgaIDexPkAsvXNVy7xRngegdQGqRL@vger.kernel.org
X-Gm-Message-State: AOJu0YxQg1fo4dgkUj9fUs4ptdAub+76KPf8zguX2SQqbERRdhDT01c1
	hnBKoeiRzPttvUa/fovnw6XdHh//P72rxJ+AusPPWzcW5oqOEJQjwWzKZnJxuyjcVvy5xrC9i9+
	hZP6hfKO3hkHM5ad1xXmUYXyYkyooYXUWvFa0PQ==
X-Google-Smtp-Source: AGHT+IFUjeb3IiZYVQcRZsAjA538ftoanq4BGBCZWGQqunYPedh/xtJX0M2l8LZknr6JFvdvydTYcjlRk6eYHLHpL5Y=
X-Received: by 2002:a17:906:db02:b0:a86:b047:74ce with SMTP id
 a640c23a62f3a-a870ab17bcemr89580866b.68.1724833011804; Wed, 28 Aug 2024
 01:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818063538.6651-1-alexghiti@rivosinc.com> <20240818063538.6651-14-alexghiti@rivosinc.com>
 <20240821-ec1ec92842570050429621d1@orel>
In-Reply-To: <20240821-ec1ec92842570050429621d1@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 28 Aug 2024 10:16:40 +0200
Message-ID: <CAHVXubgtw3rZq1+jNv2LrsQBhViu4Sm9Gw3B_7-XLzBw52x6oQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] riscv: Add qspinlock support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Wed, Aug 21, 2024 at 4:51=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sun, Aug 18, 2024 at 08:35:38AM GMT, Alexandre Ghiti wrote:
> > In order to produce a generic kernel, a user can select
> > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha or Ziccrse are not present.
> >
> > Note that we can't use alternatives here because the discovery of
> > extensions is done too late and we need to start with the qspinlock
> > implementation because the ticket spinlock implementation would pollute
> > the spinlock value, so let's use static keys.
> >
> > This is largely based on Guo's work and Leonardo reviews at [1].
> >
> > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guor=
en@kernel.org/ [1]
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >  arch/riscv/Kconfig                            | 34 ++++++++++++++
> >  arch/riscv/include/asm/Kbuild                 |  4 +-
> >  arch/riscv/include/asm/spinlock.h             | 47 +++++++++++++++++++
> >  arch/riscv/kernel/setup.c                     | 37 +++++++++++++++
> >  include/asm-generic/qspinlock.h               |  2 +
> >  include/asm-generic/ticket_spinlock.h         |  2 +
> >  7 files changed, 126 insertions(+), 2 deletions(-)
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
> > index ef55ab94027e..201d0669db7f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -79,6 +79,7 @@ config RISCV
> >       select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >       select ARCH_WANTS_NO_INSTR
> >       select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>
> Hi Alex,
>
> Did you get a chance to experiment this as suggested by Andrea?

We talked about it and that will be a separate patch (not sure when
though, I don't feel really comfortable sending what Andrea
suggested).

>
> >       select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >       select BUILDTIME_TABLE_SORT if MMU
> >       select CLINT_TIMER if RISCV_M_MODE
> > @@ -488,6 +489,39 @@ config NODES_SHIFT
> >         Specify the maximum number of NUMA Nodes available on the targe=
t
> >         system.  Increases memory reserved to accommodate various table=
s.
> >
> > +choice
> > +     prompt "RISC-V spinlock type"
> > +     default RISCV_COMBO_SPINLOCKS
> > +
> > +config RISCV_TICKET_SPINLOCKS
> > +     bool "Using ticket spinlock"
> > +
> > +config RISCV_QUEUED_SPINLOCKS
> > +     bool "Using queued spinlock"
> > +     depends on SMP && MMU && NONPORTABLE
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       The queued spinlock implementation requires the forward progres=
s
> > +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha=
 or
> > +       LR/SC with Ziccrse provide such guarantee.
> > +
> > +       Select this if and only if Zabha or Ziccrse is available on you=
r
> > +       platform, RISCV_QUEUED_SPINLOCKS must not be selected for platf=
orms
> > +       without one of those extensions.
> > +
> > +       If unsure, select RISCV_COMBO_SPINLOCKS, which will use qspinlo=
cks
> > +       when supported and otherwise ticket spinlocks.
> > +
> > +config RISCV_COMBO_SPINLOCKS
> > +     bool "Using combo spinlock"
> > +     depends on SMP && MMU
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       Embed both queued spinlock and ticket lock so that the spinlock
> > +       implementation can be chosen at runtime.
> > +
> > +endchoice
> > +
> >  config RISCV_ALTERNATIVE
> >       bool
> >       depends on !XIP_KERNEL
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbu=
ild
> > index 5c589770f2a8..1c2618c964f0 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -5,10 +5,12 @@ syscall-y +=3D syscall_table_64.h
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
> > index 000000000000..e5121b89acea
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RISCV_SPINLOCK_H
> > +#define __ASM_RISCV_SPINLOCK_H
> > +
> > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +#define _Q_PENDING_LOOPS     (1 << 9)
> > +
> > +#define __no_arch_spinlock_redefine
> > +#include <asm/ticket_spinlock.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/jump_label.h>
> > +
> > +/*
> > + * TODO: Use an alternative instead of a static key when we are able t=
o parse
> > + * the extensions string earlier in the boot process.
> > + */
> > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > +
> > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                   \
> > +static __always_inline type arch_spin_##op(type_lock lock)           \
> > +{                                                                    \
> > +     if (static_branch_unlikely(&qspinlock_key))                     \
> > +             return queued_spin_##op(lock);                          \
> > +     return ticket_spin_##op(lock);                                  \
> > +}
>
> I guess there were still a couple questions on the kernel size impact of
> this.
>
> > +
> > +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > +
> > +#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> > +
> > +#include <asm/qspinlock.h>
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
> > index a2cde65b69e9..438e4f6ad2ad 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -244,6 +244,42 @@ static void __init parse_dtb(void)
> >  #endif
> >  }
> >
> > +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > +EXPORT_SYMBOL(qspinlock_key);
> > +#endif
> > +
> > +static void __init riscv_spinlock_init(void)
> > +{
> > +     char *using_ext =3D NULL;
> > +
> > +     if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> > +             pr_info("Ticket spinlock: enabled\n");
> > +             return;
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> > +         IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> > +         riscv_isa_extension_available(NULL, ZABHA) &&
> > +         riscv_isa_extension_available(NULL, ZACAS)) {
> > +             using_ext =3D "using Zabha";
> > +     } else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> > +             using_ext =3D "using Ziccrse";
> > +     }
> > +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > +     else {
> > +             static_branch_disable(&qspinlock_key);
> > +             pr_info("Ticket spinlock: enabled\n");
> > +             return;
> > +     }
> > +#endif
> > +
> > +     if (!using_ext)
> > +             pr_err("Queued spinlock without Zabha or Ziccrse");
> > +     else
> > +             pr_info("Queued spinlock %s: enabled\n", using_ext);
> > +}
> > +
> >  extern void __init init_rt_signal_env(void);
> >
> >  void __init setup_arch(char **cmdline_p)
> > @@ -297,6 +333,7 @@ void __init setup_arch(char **cmdline_p)
> >       riscv_set_dma_cache_alignment();
> >
> >       riscv_user_isa_enable();
> > +     riscv_spinlock_init();
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
> >  #define arch_spin_lock(l)            queued_spin_lock(l)
> >  #define arch_spin_trylock(l)         queued_spin_trylock(l)
> >  #define arch_spin_unlock(l)          queued_spin_unlock(l)
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
> >       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >  }
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * ticket spinlock functions.
> > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(=
arch_spinlock_t *lock)
> >  #define arch_spin_lock(l)            ticket_spin_lock(l)
> >  #define arch_spin_trylock(l)         ticket_spin_trylock(l)
> >  #define arch_spin_unlock(l)          ticket_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > --
> > 2.39.2
> >
>
> The patch looks good to me, so
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> It'd still be good to hear more about ARCH_WEAK_RELEASE_ACQUIRE and the
> kernel size though.
>

I sent the kernel size impact using -Os as asked and
ARCH_WEAK_RELEASE_ACQUIRE should be handled by Andrea.

Thanks for all the reviews drew, the patchset is way better now! I
won't respin a new version since there is only a minor comment change
requested in "riscv: Improve zacas fully-ordered cmpxchg()" unless you
insist.

Thanks again,

Alex

> Thanks,
> drew

