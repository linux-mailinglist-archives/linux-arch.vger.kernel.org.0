Return-Path: <linux-arch+bounces-5839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211EB9446D5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE01285790
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539061FEB;
	Thu,  1 Aug 2024 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="alT/x6tA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE216DECA
	for <linux-arch@vger.kernel.org>; Thu,  1 Aug 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501798; cv=none; b=KY7KmKC/c4yhb7ka+TlxhH7x9IiOQORfWWWfFDjy7w/FDfeyyNiDsPri2beoiPMURQfDfmpfwXH1vnilRaC9LI8yVe7mA89zUrNG6aU7kWmQButPnLmb+zQt505fy5vkkrSPlx0mEMNIgBCtilmuKZiCZ53eJBn99Qw+hrEShoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501798; c=relaxed/simple;
	bh=j8UWvDP5N8/4G+lQx8Th13Q1V9jS4j4/WLgRpHQuNow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbiyQu6OqWLA9OzasT5+Ez4dYIwWFYWibzAd0tWj4/lA4/DNUaQr25J+DhGk4H98mU/OgmFni3EvHBGKPvg16WA29RlKNiBOl3QoPKpJxIC56ihr6gCpGC2cZszc3pAQu/1pUFHCb2M3WjHzDe1otj1R2tlkEDXbcZZylUzOZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=alT/x6tA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso885272866b.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2024 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722501795; x=1723106595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6bvTZ4l/CVrkhMu5HQ0MXOZvFi/KTF7TFtYLECqAyY=;
        b=alT/x6tAR8eROglEWLGFXqHqeYFr9BSQh5U1xWu6/r8rmUwLHV32yi7D1kd1T7V/8g
         dLLJwrfmBPgTdpzWmPO1++covrC4b4iCWddCtQWVcQD8D6oRvIo9/fuvA4Ab8PFkFTcE
         agSOSxJ66hAGmsxQewvq6Bm5ONovBOFU9SxGLWl/7Gvg9gojCSSyrrhMu9o8xYQ7jnt9
         WYXUGlXZsjwyL0YeqZFJbGi6PBY43UG3GDwzXyqrC24I/8jCsDUaXfe7PxrbG4q0Gm4C
         hVWvXcLNUswSxe9DK3RCx60nKJGtW2Nni8poQy1ef99b64CuJSmy2XhIXxLgyGx1B2gE
         OAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501795; x=1723106595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6bvTZ4l/CVrkhMu5HQ0MXOZvFi/KTF7TFtYLECqAyY=;
        b=JkeMkGoeUPrnK6Yx7ncH1KEY+bWeeHm8dI+UXHsM2RXnZSA6tIVX+I+2HHEpoCcL4z
         6SAK+uDh32j2yoZbxHCdv/+a5dl5zWhvH8i6IAke0IYAFeuW8wNjQtUUc3RE403nSXNF
         vBu+wejCFuj3pHOmz+a3L66Qz0bVMhHLJRWINZj2wrML8RC7d7OrAvqFI6RhZOJypTHH
         i0bGAA2m65ySwi1J3I8vWi+ri2rvEOScBFdmcqdqiFV9Rs7Bi9T2lhKMKMCv4bYPfeCy
         AxewJXSySlM5b5NkhDK8p0s1yUeLVyNglgIsRFjDyDwQpnVB6xR+gf9RnAY4QELaS7jr
         s/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEGCW0dyL7mQjZlQhyAdLs02kFOyKNQ0hm6Mk0gDRBsBRomqsC6GjpZhICZvBRGH+zzKVh7t4VrLkGYZXZE6wEmeetVcWiVUtE9Q==
X-Gm-Message-State: AOJu0YwUVleHqsDeaye3st16YDv79v6mTYz2rn/igbYWKE6lM7h81KVE
	uFIF8YxyGgdROUuXNGMSOiIsI4THQ2i0KXyeXoqw22szS+PaWop06uwmJz/1OL9aEYKsas3j+VE
	0ayJww8O7Semo6hcd1Snnu4MqMSVtwaRAaiKiXQ==
X-Google-Smtp-Source: AGHT+IEvCLLCFktXUvEYWByT8+6Xpkr5epHEHx/siu0weAx+/LoUugkplwG/uJ4EmMuxtwJLkmfyQHpeaIeuEfrfUeo=
X-Received: by 2002:a17:906:6290:b0:a7a:a7b8:ada6 with SMTP id
 a640c23a62f3a-a7daf57ebc9mr127153766b.39.1722501794614; Thu, 01 Aug 2024
 01:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com> <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
In-Reply-To: <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 1 Aug 2024 10:43:03 +0200
Message-ID: <CAHVXubhQefQ6i3Vow_p-uSACQyPcMJNC2UwB99xt_=jDtRUDFw@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
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

(I missed a bunch of comments addressed here)

On Wed, Jul 31, 2024 at 5:29=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jul 31, 2024 at 09:24:05AM GMT, Alexandre Ghiti wrote:
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
> >  arch/riscv/Kconfig                            | 29 +++++++++++++
> >  arch/riscv/include/asm/Kbuild                 |  4 +-
> >  arch/riscv/include/asm/spinlock.h             | 43 +++++++++++++++++++
> >  arch/riscv/kernel/setup.c                     | 38 ++++++++++++++++
> >  include/asm-generic/qspinlock.h               |  2 +
> >  include/asm-generic/ticket_spinlock.h         |  2 +
> >  7 files changed, 118 insertions(+), 2 deletions(-)
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
> > index ef55ab94027e..c9ff8081efc1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -79,6 +79,7 @@ config RISCV
> >       select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >       select ARCH_WANTS_NO_INSTR
> >       select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
>
> Why do we need this? Also, we presumably would prefer not to have it
> when we end up using ticket spinlocks when combo spinlocks is selected.
> Is there no way to avoid it?
>
> >       select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >       select BUILDTIME_TABLE_SORT if MMU
> >       select CLINT_TIMER if RISCV_M_MODE
> > @@ -488,6 +489,34 @@ config NODES_SHIFT
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
> > +       platform.
>
> Maybe some text recommending combo spinlocks here? As it stands it sounds
> like enabling queued spinlocks is a bad idea for anybody that doesn't kno=
w
> what platforms will run the kernel they're building, which is all distros=
.
>
> > +
> > +config RISCV_COMBO_SPINLOCKS
> > +     bool "Using combo spinlock"
> > +     depends on SMP && MMU
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       Embed both queued spinlock and ticket lock so that the spinlock
> > +       implementation can be chosen at runtime.
>
> nit: Add a blank line here
>
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
> > index 000000000000..503aef31db83
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,43 @@
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
> > +#include <asm/alternative.h>
>
> We need asm/jump_label.h instead of asm/alternative.h, but...

Done

>
> > +
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
> ...do you know what impact this inlined static key check has on the
> kernel size?
>
> Actually, why not use ALTERNATIVE with any nonzero cpufeature value.
> Then add code to riscv_cpufeature_patch_check() to return true when
> qspinlocks should be enabled (based on the value of some global set
> during riscv_spinlock_init)?
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
> > index a2cde65b69e9..b811fa331982 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -244,6 +244,43 @@ static void __init parse_dtb(void)
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
>
> else if (IS_ENABLED(CONFIG_RISCV_COMBO_SPINLOCKS))

It fails to compile because the static key is only declared when
CONFIG_RISCV_COMBO_SPINLOCKS is set.

>
> > +             static_branch_disable(&qspinlock_key);
> > +             pr_info("Ticket spinlock: enabled\n");
> > +
>
> nit: remove this blank line

Done

>
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
> > @@ -297,6 +334,7 @@ void __init setup_arch(char **cmdline_p)
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
>
> I'm not sure what's better/worse, but instead of inventing this
> __no_arch_spinlock_redefine thing we could just name all the functions
> something like __arch_spin* and then add defines for both to asm/spinlock=
.h,
> i.e.
>
> #define queued_spin_lock(l) __arch_spin_lock(l)
> ...
>
> #define ticket_spin_lock(l) __arch_spin_lock(l)
> ...

__arch_spin_lock() would use queued_spin_lock() so that would make an
"infinite recursive definition" right? And that would override the
"real" queued_spin_lock() implementation too.

But maybe I missed something!

>
> Besides not having to touch asm-generic/qspinlock.h and
> asm-generic/ticket_spinlock.h it allows one to find the implementations
> a bit easier as following a tag to arch_spin_lock() will take them to
> queued_spin_lock() which will then take them to
> arch/riscv/include/asm/spinlock.h and there they'll figure out how
> __arch_spin_lock() was defined.
>
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
> Thanks,
> drew

