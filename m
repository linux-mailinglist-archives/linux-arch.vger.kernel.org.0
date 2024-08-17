Return-Path: <linux-arch+bounces-6278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF48955578
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 07:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA681C21EF6
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C197D3F1;
	Sat, 17 Aug 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj1dGwvB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D7BE5D;
	Sat, 17 Aug 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871328; cv=none; b=PDpXc79COuSpIuQJKBlUoGmZbQeAgaWuRsSxc5BXWtZdVZzxddsRUee98lAWOaESy8MZI83seIh2MtPCMvyAAWiHrZopQUMECWWvU/WDVERi4OGYvOlZvo4ZROr4a2sfC5tusl2DE1aD33lKJ4ALcAxtReNUMQJMa8rO05ydpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871328; c=relaxed/simple;
	bh=EOtE5nJHOFhA5eR67AzrZLQCP4pgwI1WArYLqYUpulY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6UZXRd1VAU30Y63q0+G1/wAKdLRuIM0T0Zph4Zwo+erf1pnoP3i+FfdE5Xe7dzUw2TAlgEqan7M0b+mcU7jPwD5nqk+Fq5ww85YsVpRw+BsrMHS0qafKhmhgFAwgm892icWY9pyUlsEpMaos7N3VTvijHQE43nvk0wSnkHCjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj1dGwvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90295C4AF0D;
	Sat, 17 Aug 2024 05:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723871327;
	bh=EOtE5nJHOFhA5eR67AzrZLQCP4pgwI1WArYLqYUpulY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uj1dGwvBhHpO9G9hUOP+NEw00LnZTkVOzrw3Lgj/I8kl73uLQ45Tj+cBGhZn+rEF0
	 PFzxiRHDZLougkhHrOdOyLHo3dXLG6DhrximSr+fPMDoz2ydbTGS+Pn0On5ZxG3Bge
	 HhpxDZdeS+nJ5dTw1UsDW+MCl7Y/zqPouAsU5KeavmaS2oDrybPxudEUK5PwrbX+Lr
	 VWGKdtPU+iDqJupekrwlXx+Y+uvzrHmpg3VZE1vFhqHzoKFlVb3K8TAe6UF4ojWkOp
	 /OV2kxfbjy0+Tr9NSAt7iS0RCeyt4o/pqRqsasg0dH21Jr5FPCLdlrLWf43uiRoUPL
	 MevJMVQ784htw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a843bef98so306571966b.2;
        Fri, 16 Aug 2024 22:08:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrrGaeAe2WOzrXuYd7G9mn/nRl1Xz14vlBlaEHA4Z5i3UoeUgED38zYUBMrMTeLNClgNb+22aEgXhVOLnTVzCCO/ukM5vVx3MFlfowf+PadLvluWl/jRx1uV1LSO0NsjPfPrurHGkXTmD+L50YZ1IvtUBCJZz+Ke9ixuwVVi/bPFllHNz7CY3HuMwRjG6w1GuzhCceL0P8iRWTEMU5AIU=
X-Gm-Message-State: AOJu0YyLOMH4u9owza541l1WPlcblpW14/IH8SKsAX16MQ7MG/JLfH+B
	P82dSod0x8GaPv0sD7Cb4fLptBq7Vh3P6UmtpAHXacV36Ir54sRo3JHkDYUx+hs7GXXzmlI8Xou
	5jT8IAGMm5QZ3aY9Z4gSp8LZt9cA=
X-Google-Smtp-Source: AGHT+IFnpAwTSzWzvMMMBdA3qrPNleW9O87krsDI6GyN92ABevefYDMvUaKEJvLkWkc5NHkMfxw7qq7zfWQtVh1272I=
X-Received: by 2002:a17:906:6a0c:b0:a80:f6f4:a8d9 with SMTP id
 a640c23a62f3a-a839256aad2mr343868366b.0.1723871326049; Fri, 16 Aug 2024
 22:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com> <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com> <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr>
In-Reply-To: <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 17 Aug 2024 13:08:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
Message-ID: <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:27=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Andrew,
>
> On 01/08/2024 08:53, Alexandre Ghiti wrote:
> > On Wed, Jul 31, 2024 at 5:29=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> >> On Wed, Jul 31, 2024 at 09:24:05AM GMT, Alexandre Ghiti wrote:
> >>> In order to produce a generic kernel, a user can select
> >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> >>> spinlock implementation if Zabha or Ziccrse are not present.
> >>>
> >>> Note that we can't use alternatives here because the discovery of
> >>> extensions is done too late and we need to start with the qspinlock
> >>> implementation because the ticket spinlock implementation would pollu=
te
> >>> the spinlock value, so let's use static keys.
> >>>
> >>> This is largely based on Guo's work and Leonardo reviews at [1].
> >>>
> >>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-gu=
oren@kernel.org/ [1]
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>> ---
> >>>   .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >>>   arch/riscv/Kconfig                            | 29 +++++++++++++
> >>>   arch/riscv/include/asm/Kbuild                 |  4 +-
> >>>   arch/riscv/include/asm/spinlock.h             | 43 ++++++++++++++++=
+++
> >>>   arch/riscv/kernel/setup.c                     | 38 ++++++++++++++++
> >>>   include/asm-generic/qspinlock.h               |  2 +
> >>>   include/asm-generic/ticket_spinlock.h         |  2 +
> >>>   7 files changed, 118 insertions(+), 2 deletions(-)
> >>>   create mode 100644 arch/riscv/include/asm/spinlock.h
> >>>
> >>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-sup=
port.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> >>> index 22f2990392ff..cf26042480e2 100644
> >>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.tx=
t
> >>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.tx=
t
> >>> @@ -20,7 +20,7 @@
> >>>       |    openrisc: |  ok  |
> >>>       |      parisc: | TODO |
> >>>       |     powerpc: |  ok  |
> >>> -    |       riscv: | TODO |
> >>> +    |       riscv: |  ok  |
> >>>       |        s390: | TODO |
> >>>       |          sh: | TODO |
> >>>       |       sparc: |  ok  |
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index ef55ab94027e..c9ff8081efc1 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -79,6 +79,7 @@ config RISCV
> >>>        select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >>>        select ARCH_WANTS_NO_INSTR
> >>>        select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >>> +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> >> Why do we need this? Also, we presumably would prefer not to have it
> >> when we end up using ticket spinlocks when combo spinlocks is selected=
.
> >> Is there no way to avoid it?
> > I'll let Andrea answer this as he asked for it.
> >
> >>>        select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >>>        select BUILDTIME_TABLE_SORT if MMU
> >>>        select CLINT_TIMER if RISCV_M_MODE
> >>> @@ -488,6 +489,34 @@ config NODES_SHIFT
> >>>          Specify the maximum number of NUMA Nodes available on the ta=
rget
> >>>          system.  Increases memory reserved to accommodate various ta=
bles.
> >>>
> >>> +choice
> >>> +     prompt "RISC-V spinlock type"
> >>> +     default RISCV_COMBO_SPINLOCKS
> >>> +
> >>> +config RISCV_TICKET_SPINLOCKS
> >>> +     bool "Using ticket spinlock"
> >>> +
> >>> +config RISCV_QUEUED_SPINLOCKS
> >>> +     bool "Using queued spinlock"
> >>> +     depends on SMP && MMU && NONPORTABLE
> >>> +     select ARCH_USE_QUEUED_SPINLOCKS
> >>> +     help
> >>> +       The queued spinlock implementation requires the forward progr=
ess
> >>> +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Zab=
ha or
> >>> +       LR/SC with Ziccrse provide such guarantee.
> >>> +
> >>> +       Select this if and only if Zabha or Ziccrse is available on y=
our
> >>> +       platform.
> >> Maybe some text recommending combo spinlocks here? As it stands it sou=
nds
> >> like enabling queued spinlocks is a bad idea for anybody that doesn't =
know
> >> what platforms will run the kernel they're building, which is all dist=
ros.
> > That's NONPORTABLE, so people enabling this config are supposed to
> > know that right?
> >
> >>> +
> >>> +config RISCV_COMBO_SPINLOCKS
> >>> +     bool "Using combo spinlock"
> >>> +     depends on SMP && MMU
> >>> +     select ARCH_USE_QUEUED_SPINLOCKS
> >>> +     help
> >>> +       Embed both queued spinlock and ticket lock so that the spinlo=
ck
> >>> +       implementation can be chosen at runtime.
> >> nit: Add a blank line here
> > Done
> >
> >>> +endchoice
> >>> +
> >>>   config RISCV_ALTERNATIVE
> >>>        bool
> >>>        depends on !XIP_KERNEL
> >>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/K=
build
> >>> index 5c589770f2a8..1c2618c964f0 100644
> >>> --- a/arch/riscv/include/asm/Kbuild
> >>> +++ b/arch/riscv/include/asm/Kbuild
> >>> @@ -5,10 +5,12 @@ syscall-y +=3D syscall_table_64.h
> >>>   generic-y +=3D early_ioremap.h
> >>>   generic-y +=3D flat.h
> >>>   generic-y +=3D kvm_para.h
> >>> +generic-y +=3D mcs_spinlock.h
> >>>   generic-y +=3D parport.h
> >>> -generic-y +=3D spinlock.h
> >>>   generic-y +=3D spinlock_types.h
> >>> +generic-y +=3D ticket_spinlock.h
> >>>   generic-y +=3D qrwlock.h
> >>>   generic-y +=3D qrwlock_types.h
> >>> +generic-y +=3D qspinlock.h
> >>>   generic-y +=3D user.h
> >>>   generic-y +=3D vmlinux.lds.h
> >>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/a=
sm/spinlock.h
> >>> new file mode 100644
> >>> index 000000000000..503aef31db83
> >>> --- /dev/null
> >>> +++ b/arch/riscv/include/asm/spinlock.h
> >>> @@ -0,0 +1,43 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +
> >>> +#ifndef __ASM_RISCV_SPINLOCK_H
> >>> +#define __ASM_RISCV_SPINLOCK_H
> >>> +
> >>> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> >>> +#define _Q_PENDING_LOOPS     (1 << 9)
> >>> +
> >>> +#define __no_arch_spinlock_redefine
> >>> +#include <asm/ticket_spinlock.h>
> >>> +#include <asm/qspinlock.h>
> >>> +#include <asm/alternative.h>
> >> We need asm/jump_label.h instead of asm/alternative.h, but...
> >>
> >>> +
> >>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> >>> +
> >>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                  =
 \
> >>> +static __always_inline type arch_spin_##op(type_lock lock)          =
 \
> >>> +{                                                                   =
 \
> >>> +     if (static_branch_unlikely(&qspinlock_key))                    =
 \
> >>> +             return queued_spin_##op(lock);                         =
 \
> >>> +     return ticket_spin_##op(lock);                                 =
 \
> >>> +}
> >> ...do you know what impact this inlined static key check has on the
> >> kernel size?
> > No, I'll check, thanks.
>
>
> So I have just checked the size of the jump table section:
>
> * defconfig:
>
> - ticket: 26928 bytes
> - combo: 28320 bytes
>
> So that's a ~5% increase.
>
> * ubuntu config
>
> - ticket: 107840 bytes
> - combo: 174752 bytes
>
> And that's a ~62% increase.
The size of the jump table section has increased from 5% to 62%. I
think some configuration triggers the jump table's debug code. If it's
not a debugging configuration, that's a bug of the Ubuntu config.

>
> This is the ELF size difference between ticket and combo spinlocks:
>
> * ticket: 776915592 bytes
> * combo: 786958968 bytes
>
> So that's an increase of ~1.3% on the ELF.
>
> And the .text section size:
>
> * ticket: 12290960 bytes
> * combo: 12366644 bytes
>
> And that's a ~0.6% increase!
>
> Finally, I'd say the impact is very limited :)
>
> Thanks,
>
> Alex
>
>
> >
> >> Actually, why not use ALTERNATIVE with any nonzero cpufeature value.
> >> Then add code to riscv_cpufeature_patch_check() to return true when
> >> qspinlocks should be enabled (based on the value of some global set
> >> during riscv_spinlock_init)?
> > As discussed with Guo in the previous iteration, the patching of the
> > alternatives intervenes far after the first use of the spinlocks and
> > the ticket spinlock implementation pollutes the spinlock value, so
> > we'd have to unconditionally start with the qspinlock implementation
> > and after switch to the ticket implementation if not supported by the
> > platform. It works but it's dirty, I really don't like this hack.
> >
> > We could though:
> > - add an initial value to the alternatives (not sure it's feasible thou=
gh)
> > - make the patching of alternatives happen sooner by parsing the isa
> > string sooner, either in DT or ACPI (I have a working PoC for very
> > early parsing of ACPI).
> >
> > I intend to do the latter as I think we should be aware of the
> > extensions sooner in the boot process, so I'll change that to the
> > alternatives when it's done. WDYT, any other idea?
> >
> >
> >>> +
> >>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> >>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> >>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> >>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> >>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> >>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> >>> +
> >>> +#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> >>> +
> >>> +#include <asm/qspinlock.h>
> >>> +
> >>> +#else
> >>> +
> >>> +#include <asm/ticket_spinlock.h>
> >>> +
> >>> +#endif
> >>> +
> >>> +#include <asm/qrwlock.h>
> >>> +
> >>> +#endif /* __ASM_RISCV_SPINLOCK_H */
> >>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >>> index a2cde65b69e9..b811fa331982 100644
> >>> --- a/arch/riscv/kernel/setup.c
> >>> +++ b/arch/riscv/kernel/setup.c
> >>> @@ -244,6 +244,43 @@ static void __init parse_dtb(void)
> >>>   #endif
> >>>   }
> >>>
> >>> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> >>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> >>> +EXPORT_SYMBOL(qspinlock_key);
> >>> +#endif
> >>> +
> >>> +static void __init riscv_spinlock_init(void)
> >>> +{
> >>> +     char *using_ext =3D NULL;
> >>> +
> >>> +     if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> >>> +             pr_info("Ticket spinlock: enabled\n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> >>> +         IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> >>> +         riscv_isa_extension_available(NULL, ZABHA) &&
> >>> +         riscv_isa_extension_available(NULL, ZACAS)) {
> >>> +             using_ext =3D "using Zabha";
> >>> +     } else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> >>> +             using_ext =3D "using Ziccrse";
> >>> +     }
> >>> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> >>> +     else {
> >> else if (IS_ENABLED(CONFIG_RISCV_COMBO_SPINLOCKS))
> >>
> >>> +             static_branch_disable(&qspinlock_key);
> >>> +             pr_info("Ticket spinlock: enabled\n");
> >>> +
> >> nit: remove this blank line
> >>
> >>> +             return;
> >>> +     }
> >>> +#endif
> >>> +
> >>> +     if (!using_ext)
> >>> +             pr_err("Queued spinlock without Zabha or Ziccrse");
> >>> +     else
> >>> +             pr_info("Queued spinlock %s: enabled\n", using_ext);
> >>> +}
> >>> +
> >>>   extern void __init init_rt_signal_env(void);
> >>>
> >>>   void __init setup_arch(char **cmdline_p)
> >>> @@ -297,6 +334,7 @@ void __init setup_arch(char **cmdline_p)
> >>>        riscv_set_dma_cache_alignment();
> >>>
> >>>        riscv_user_isa_enable();
> >>> +     riscv_spinlock_init();
> >>>   }
> >>>
> >>>   bool arch_cpu_is_hotpluggable(int cpu)
> >>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qs=
pinlock.h
> >>> index 0655aa5b57b2..bf47cca2c375 100644
> >>> --- a/include/asm-generic/qspinlock.h
> >>> +++ b/include/asm-generic/qspinlock.h
> >>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct=
 qspinlock *lock)
> >>>   }
> >>>   #endif
> >>>
> >>> +#ifndef __no_arch_spinlock_redefine
> >> I'm not sure what's better/worse, but instead of inventing this
> >> __no_arch_spinlock_redefine thing we could just name all the functions
> >> something like __arch_spin* and then add defines for both to asm/spinl=
ock.h,
> >> i.e.
> >>
> >> #define queued_spin_lock(l) __arch_spin_lock(l)
> >> ...
> >>
> >> #define ticket_spin_lock(l) __arch_spin_lock(l)
> >> ...
> >>
> >> Besides not having to touch asm-generic/qspinlock.h and
> >> asm-generic/ticket_spinlock.h it allows one to find the implementation=
s
> >> a bit easier as following a tag to arch_spin_lock() will take them to
> >> queued_spin_lock() which will then take them to
> >> arch/riscv/include/asm/spinlock.h and there they'll figure out how
> >> __arch_spin_lock() was defined.
> >>
> >>>   /*
> >>>    * Remapping spinlock architecture specific functions to the corres=
ponding
> >>>    * queued spinlock functions.
> >>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct=
 qspinlock *lock)
> >>>   #define arch_spin_lock(l)            queued_spin_lock(l)
> >>>   #define arch_spin_trylock(l)         queued_spin_trylock(l)
> >>>   #define arch_spin_unlock(l)          queued_spin_unlock(l)
> >>> +#endif
> >>>
> >>>   #endif /* __ASM_GENERIC_QSPINLOCK_H */
> >>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-gene=
ric/ticket_spinlock.h
> >>> index cfcff22b37b3..325779970d8a 100644
> >>> --- a/include/asm-generic/ticket_spinlock.h
> >>> +++ b/include/asm-generic/ticket_spinlock.h
> >>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended=
(arch_spinlock_t *lock)
> >>>        return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >>>   }
> >>>
> >>> +#ifndef __no_arch_spinlock_redefine
> >>>   /*
> >>>    * Remapping spinlock architecture specific functions to the corres=
ponding
> >>>    * ticket spinlock functions.
> >>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contende=
d(arch_spinlock_t *lock)
> >>>   #define arch_spin_lock(l)            ticket_spin_lock(l)
> >>>   #define arch_spin_trylock(l)         ticket_spin_trylock(l)
> >>>   #define arch_spin_unlock(l)          ticket_spin_unlock(l)
> >>> +#endif
> >>>
> >>>   #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> >>> --
> >>> 2.39.2
> >>>
> >> Thanks,
> >> drew
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren

