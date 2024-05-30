Return-Path: <linux-arch+bounces-4610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E98D44D0
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 07:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9B71F221E9
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD413698B;
	Thu, 30 May 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KkWzEZ/i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76258C06
	for <linux-arch@vger.kernel.org>; Thu, 30 May 2024 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047026; cv=none; b=pwZh37aCUZRKtjTWwlO1T+KnJfjTOfpMNPjvd+Pf9fIeahe4Tqm1AVM8s1bEOsKwcf2b9BsQSxr/imS16db88TAgtR4dN+ITDttis/1Frh/bxLQqOSTzRdFtfdqfd4PS8KtmIddaJY2MCnDG7xFI6TyjvIMXbbIL9SkXIBHkKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047026; c=relaxed/simple;
	bh=WIb6BUszBIgzp5+4T44N74Rxc5r0cRxeqiTf8dN3JxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prSCGxiGpuz83sfEJIR1Fd0lJ45aYrmsCEZWjx5LGKu4IIZPSydeRAQ1da4Vkgx78FNde0EYqLEjrVLBGeBZxb0+x2qyEyCII1zdO0zqFCuEuBTHInh5SdnP2B7feQSAqkCk6V2G/S/BDG70dYUzf8yRQlk2NFOgQwydxtRrDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KkWzEZ/i; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so794117a12.0
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717047022; x=1717651822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuSja05ZHB7F/dtB/ISByQyEm2D3jWgUODIQiPVlJyM=;
        b=KkWzEZ/i5vP65+OLhYA5dV8em8eKhkV7KPa1ngNitH6/LKsVnzvlDBTGCm+wczFhTO
         8pdC0OFXkrO8FchvbOD7UiO9kGJWcXyuSupvSTH0LCXs/b15qzm2O6X8I19vNtBvW1/e
         tebAztOKTEKXUvpQUL/s8jXZXptJPTpaCGcX9v5E+Z7z/HXdNK7oV9nhYAY6TbFMmeWs
         7OR+gCiimxJkZpDEkmSY3ISH6GR9MFokYen/AoVxL3rgDZxbjPouM7g8S/18TafYRh0s
         WwLltow9y2X6KZ+fCfcHjMLe9aoUy5Do9Q489vZCzRoIhfGesG73J+KNyUF4jO++1vQb
         H/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717047022; x=1717651822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuSja05ZHB7F/dtB/ISByQyEm2D3jWgUODIQiPVlJyM=;
        b=j7BxQiGZu/YkY1XaZ2KmTIsZvmFyA41ZnNg05DAkTF3Bhl4Mydo5NeYBNDHNK8JnDr
         OTRwOX+byoBeuCpiUNczsGKae4ugzEENWPAwYDpjffAwZnK7g+yH++intCyCnwRTeg67
         Geds8sRHpbPIDweQlmmMHoEptFe0Q87xzPPFFoPrlSqVyWj6i0cv5FIGzobhAki+l4Dt
         DxWadJBd30EO/Gau+1BSO42Ji+NvY6Nx5hVg/LK1c7EbQPV/hDy74Oa1yGGATKQg6KZS
         J044Ywr0/YTVU19BIApHbaH6N8JuD6SCsl5btNdTY+36/HcEb5VoIObhdRaQ/4XkCTaS
         i1aA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+hZ3Th+8MRu2UI4xtLyE3fEcMSX81UJ5bP/J2PM7V6rHvxM/xJtdGnXssaAscxnlDCa7YFaQLz8M3+hM38EyTJ+kLQVXTwqw2A==
X-Gm-Message-State: AOJu0YzVE25FOES8AHd090NyF0LhrwxTDfbyPb6QbuwZTPn6BQ2+kk1L
	K7YuEql6lTtg4gHiDgaXuX6+C4fLNnYqrexohTGxDFdmQ0xD+ZiI7h7YF4loWs8zYLtWGPsBKo9
	zV8O/QJbZMyEhTcgORWqFN1hdm28/uryJ5n8VhxDSJEdnneUF
X-Google-Smtp-Source: AGHT+IECbvKfvZEZ0pw9fpWciIoIJjjHdIzDFXS2yD5cD3TY7KN2i4aiM13DfHuCQjTp2nxZ9K1CfnIQsRTx9DE5qvE=
X-Received: by 2002:a50:aad5:0:b0:574:ecf3:f7d1 with SMTP id
 4fb4d7f45d1cf-57a1940df3dmr724081a12.0.1717047021953; Wed, 29 May 2024
 22:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
 <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com> <CAJF2gTRWSZsD3vDcXvawCxt665PZcbwurUqXx3juaoZaDrdttQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRWSZsD3vDcXvawCxt665PZcbwurUqXx3juaoZaDrdttQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 30 May 2024 07:30:10 +0200
Message-ID: <CAHVXubiE2_MJgTj4nq7Vkv0D60niRgZ0QkCXNz6PiNQ8h+Wy1A@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
To: Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Thu, May 30, 2024 at 3:55=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, May 29, 2024 at 9:03=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Guo,
> >
> > On Wed, May 29, 2024 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wr=
ote:
> > >
> > > On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > >
> > > > In order to produce a generic kernel, a user can select
> > > > CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticke=
t
> > > > spinlock implementation if Zabha is not present.
> > > >
> > > > Note that we can't use alternatives here because the discovery of
> > > > extensions is done too late and we need to start with the qspinlock
> > > > implementation because the ticket spinlock implementation would pol=
lute
> > > > the spinlock value, so let's use static keys.
> > > >
> > > > This is largely based on Guo's work and Leonardo reviews at [1].
> > > >
> > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-=
guoren@kernel.org/ [1]
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> > > >  arch/riscv/Kconfig                            |  1 +
> > > >  arch/riscv/include/asm/Kbuild                 |  4 +-
> > > >  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++=
++++
> > > >  arch/riscv/kernel/setup.c                     | 18 +++++++++
> > > >  include/asm-generic/qspinlock.h               |  2 +
> > > >  include/asm-generic/ticket_spinlock.h         |  2 +
> > > >  7 files changed, 66 insertions(+), 2 deletions(-)
> > > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > > >
> > > > diff --git a/Documentation/features/locking/queued-spinlocks/arch-s=
upport.txt b/Documentation/features/locking/queued-spinlocks/arch-support.t=
xt
> > > > index 22f2990392ff..cf26042480e2 100644
> > > > --- a/Documentation/features/locking/queued-spinlocks/arch-support.=
txt
> > > > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.=
txt
> > > > @@ -20,7 +20,7 @@
> > > >      |    openrisc: |  ok  |
> > > >      |      parisc: | TODO |
> > > >      |     powerpc: |  ok  |
> > > > -    |       riscv: | TODO |
> > > > +    |       riscv: |  ok  |
> > > >      |        s390: | TODO |
> > > >      |          sh: | TODO |
> > > >      |       sparc: |  ok  |
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 184a9edb04e0..ccf1703edeb9 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -59,6 +59,7 @@ config RISCV
> > > >         select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_=
STACK
> > > >         select ARCH_USE_MEMTEST
> > > >         select ARCH_USE_QUEUED_RWLOCKS
> > > > +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> > > Using qspinlock or not depends on real hardware capabilities, not the
> > > compiler flag. That's why I introduced combo-spinlock, ticket-spinloc=
k
> > > & qspinlock three Kconfigs, and the combo-spinlock would compat all
> > > hardware platforms but waste some qspinlock code size.
> >
> > You're right, and I think your comment matches what Conor mentioned
> > about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
> > will allow a platform with Zabha capability to use qspinlocks. But if
> > the hardware does not, it will fallback to the ticket spinlocks.
> >
> > But I agree that looking at the config alone may be misleading, even
> > though it will work as expected at runtime. So I agree with you:
> > unless anyone is strongly against the combo spinlocks, I will do what
> > you suggest and add them.
> The problem with the v12 combo-spinlock is using a static_branch
> instead of the full ALTERNATIVE. Frankly, that's a bad example that
> costs more code space. I found that your cmpxchg32/64 also uses a
> condition branch, which has a similar problem, right?
>
> Anyway, your patch series inspired me to update the v13
> combo-spinlock. My plan is:
> 1. Separate native-qspinlock out of paravirt-qspinlock.
> 2. Re-design an ALTERNATIVE(asm) code instead of static_branch generic
> ticket-lock or qspinlock.

What's your plan to make use of alternatives here? The alternatives
patching depends on the discovery of the extensions, which is done too
late, at least after the first use of a spinlock (the printk
spinlock). So you'd need to find a way to first use qspinlocks (but
without knowing Zabha is available) and then do the correct patching:
an idea here could be to add an "init" value to the alternatives and
let the patching process do the right thing when the extensions are
known.

Another solution would be the early discovery of the extensions, but I
took a look and it's easy with a device tree, but not with ACPI.

Let me know what you plan to do and how I can help!

Thanks,

Alex

>
> What do you think?
>
>
> >
> > Thanks again for your initial work,
> >
> > Alex
> >
> > >
> > > >         select ARCH_USES_CFI_TRAPS if CFI_CLANG
> > > >         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> > > >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> > > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm=
/Kbuild
> > > > index 504f8b7e72d4..ad72f2bd4cc9 100644
> > > > --- a/arch/riscv/include/asm/Kbuild
> > > > +++ b/arch/riscv/include/asm/Kbuild
> > > > @@ -2,10 +2,12 @@
> > > >  generic-y +=3D early_ioremap.h
> > > >  generic-y +=3D flat.h
> > > >  generic-y +=3D kvm_para.h
> > > > +generic-y +=3D mcs_spinlock.h
> > > >  generic-y +=3D parport.h
> > > > -generic-y +=3D spinlock.h
> > > >  generic-y +=3D spinlock_types.h
> > > > +generic-y +=3D ticket_spinlock.h
> > > >  generic-y +=3D qrwlock.h
> > > >  generic-y +=3D qrwlock_types.h
> > > > +generic-y +=3D qspinlock.h
> > > >  generic-y +=3D user.h
> > > >  generic-y +=3D vmlinux.lds.h
> > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include=
/asm/spinlock.h
> > > > new file mode 100644
> > > > index 000000000000..e00429ac20ed
> > > > --- /dev/null
> > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > @@ -0,0 +1,39 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > > +#define __ASM_RISCV_SPINLOCK_H
> > > > +
> > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +#define _Q_PENDING_LOOPS       (1 << 9)
> > > > +
> > > > +#define __no_arch_spinlock_redefine
> > > > +#include <asm/ticket_spinlock.h>
> > > > +#include <asm/qspinlock.h>
> > > > +#include <asm/alternative.h>
> > > > +
> > > > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > > > +
> > > > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                =
     \
> > > > +static __always_inline type arch_spin_##op(type_lock lock)        =
     \
> > > > +{                                                                 =
     \
> > > > +       if (static_branch_unlikely(&qspinlock_key))                =
     \
> > > > +               return queued_spin_##op(lock);                     =
     \
> > > > +       return ticket_spin_##op(lock);                             =
     \
> > > > +}
> > > > +
> > > > +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > > > +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > > > +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > > > +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > > > +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > > > +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > > > +
> > > > +#else
> > > > +
> > > > +#include <asm/ticket_spinlock.h>
> > > > +
> > > > +#endif
> > > > +
> > > > +#include <asm/qrwlock.h>
> > > > +
> > > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index 4f73c0ae44b2..31ce75522fd4 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
> > > >  #endif
> > > >  }
> > > >
> > > > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > > > +EXPORT_SYMBOL(qspinlock_key);
> > > > +
> > > > +static void __init riscv_spinlock_init(void)
> > > > +{
> > > > +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_=
EXT_ZABHA, 1)
> > > > +                : : : : qspinlock);
> > > > +
> > > > +       static_branch_disable(&qspinlock_key);
> > > > +       pr_info("Ticket spinlock: enabled\n");
> > > > +
> > > > +       return;
> > > > +
> > > > +qspinlock:
> > > > +       pr_info("Queued spinlock: enabled\n");
> > > > +}
> > > > +
> > > >  extern void __init init_rt_signal_env(void);
> > > >
> > > >  void __init setup_arch(char **cmdline_p)
> > > > @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
> > > >         riscv_set_dma_cache_alignment();
> > > >
> > > >         riscv_user_isa_enable();
> > > > +       riscv_spinlock_init();
> > > >  }
> > > >
> > > >  bool arch_cpu_is_hotpluggable(int cpu)
> > > > diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/=
qspinlock.h
> > > > index 0655aa5b57b2..bf47cca2c375 100644
> > > > --- a/include/asm-generic/qspinlock.h
> > > > +++ b/include/asm-generic/qspinlock.h
> > > > @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(stru=
ct qspinlock *lock)
> > > >  }
> > > >  #endif
> > > >
> > > > +#ifndef __no_arch_spinlock_redefine
> > > >  /*
> > > >   * Remapping spinlock architecture specific functions to the corre=
sponding
> > > >   * queued spinlock functions.
> > > > @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(stru=
ct qspinlock *lock)
> > > >  #define arch_spin_lock(l)              queued_spin_lock(l)
> > > >  #define arch_spin_trylock(l)           queued_spin_trylock(l)
> > > >  #define arch_spin_unlock(l)            queued_spin_unlock(l)
> > > > +#endif
> > > >
> > > >  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> > > > diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-ge=
neric/ticket_spinlock.h
> > > > index cfcff22b37b3..325779970d8a 100644
> > > > --- a/include/asm-generic/ticket_spinlock.h
> > > > +++ b/include/asm-generic/ticket_spinlock.h
> > > > @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contend=
ed(arch_spinlock_t *lock)
> > > >         return (s16)((val >> 16) - (val & 0xffff)) > 1;
> > > >  }
> > > >
> > > > +#ifndef __no_arch_spinlock_redefine
> > > >  /*
> > > >   * Remapping spinlock architecture specific functions to the corre=
sponding
> > > >   * ticket spinlock functions.
> > > > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_conten=
ded(arch_spinlock_t *lock)
> > > >  #define arch_spin_lock(l)              ticket_spin_lock(l)
> > > >  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> > > >  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> > > > +#endif
> > > >
> > > >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > > > --
> > > > 2.39.2
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren

