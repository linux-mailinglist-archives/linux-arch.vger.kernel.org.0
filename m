Return-Path: <linux-arch+bounces-6646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2479B9603EA
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE7B1F21DFB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FDB19581F;
	Tue, 27 Aug 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wxpy/16k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF23193088
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745847; cv=none; b=BDfv884HyetNkXmqnV+/wB07niq38/CfFMaJ4oqkgxoyr4lg0nBemd0oTPWGhbYUHnX6PCw+XUtyi1lOWYxLWJOdHZhQXrQ36/vzZ/iG7rNZyIRN+BneD84TEPSD6RUz5q2lyz2VKUy0M6NLQpBkobtJ1p6YPnDwk2F8xv8XSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745847; c=relaxed/simple;
	bh=YNI+j3bkYRnw/j3RXWkw/r7jMtOAfzJUrcLuryOCZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8+7Os1qIZBhP7kVYH5Ydh1qI/GLrda//Y+kYI/1r30xzSDNgceCjH0sMmsKvrpGx04KlaN0APC69VQbTch/gd4owL+jllLMt/04JE0jzlfLYQ8K+fAsgsSaz/tV2zdiqOxmyAIynMLtxCmT4WHNe6Ru3Qy4tJkB7qS/ANYmLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wxpy/16k; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a868b739cd9so625201466b.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724745843; x=1725350643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFAjL5jKmdVtAU01RnPeyjQJjLNN6n5ELWoLoKgeIu8=;
        b=wxpy/16kdFqzVbYO8MudpUugvz5JLdTHdsJkrST32xYDxFgIFyNZLLALMzmTo7pxjH
         F5/A+xpFEvkg7TmPtT35J28MyWpRro9qpA0u33xc0tT7Uhz68V9EfI1WMcN+VjyWRWFW
         ovKlbfE0hMfOaB13pWiV1IrlXZekll499RtNiFEbDTS3hv85CErSBLfqxVt5FVwgKkCz
         6tnfBF8SulUxwOinPGatQp1q62C9aR8+sfYWzvZtu1DeV1usSrC7h/UmoKDeTX0YGscC
         +c/tlDmnJ1fqIjs04VnvUIlPms5pbaKI/JMZyc9VokwEik/ri0fjHA3tSHR3X4QgRVKV
         8DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745843; x=1725350643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFAjL5jKmdVtAU01RnPeyjQJjLNN6n5ELWoLoKgeIu8=;
        b=Quc7pykU5PMX71C+SU0Fhdz+zJaavY0NcXD9EzeTo/IYvfInyDTMtRUaSMRXUT7iHa
         KF9PVISoZXbWDqqTH/ixPTQX863ptccJVkmnyDxnTTEU6kTfwJST30prYZnsjSx5VUVn
         hLIrWBf84OM4gcRD0P9Raz9OLSARrF3r5uAAQy+nzxXHl7ZayAFM96PAM25/oejiEVTM
         w/XoANH0P0EVKX09QS2M9QXNtbTio3uGDZoGnDmi9C87GkkBP1LdboDJPhcyyO3VlGXP
         iBg9gVocO3L93kPJCpljCx9bq76UTT1knWOlS6Mrlw5BRsHlMPflKG3sLo9jM6CZrSew
         kUSw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSW1I1GfZi58nnEdX1uZ4nqZYajw66ID3BABwpryM9O/kh5QmGa0vO5j8YGzOwjnEjspwm9iRT5hM@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqLm0VOpPxFVFEOgBTo/CbdKfonoLHWdGNSTMjFuuus1PeynM
	FqrpveJAfyIv4PZv7WsfAiQeSAn9Fzce2qmMqfwl+bwCA6Go0UipOEc1e3ogFTt+X9epivEYr92
	MgiZ1z+CdM/xU/gSS+kUYOAEiI/6TlWWNUPEVTg==
X-Google-Smtp-Source: AGHT+IFihpYv6T1JdpovppsTq+jGQ1YzO4C/0UePHGnkOurm7OJ16Ln/MvCWkmOlTL3SApVC7pHL73nngNzXtDsbapA=
X-Received: by 2002:a17:907:1ca4:b0:a86:a6ee:7dad with SMTP id
 a640c23a62f3a-a86e3be5ec8mr137910366b.52.1724745843332; Tue, 27 Aug 2024
 01:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com> <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
 <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr> <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
In-Reply-To: <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 27 Aug 2024 10:03:52 +0200
Message-ID: <CAHVXubiPfY-1Ji5tmO2_NVqh9fi6aHqMcc2eYqGOcuatkDs-LA@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
To: Guo Ren <guoren@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
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

Hi Guo,

On Sat, Aug 17, 2024 at 7:08=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 15, 2024 at 9:27=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > Hi Andrew,
> >
> > On 01/08/2024 08:53, Alexandre Ghiti wrote:
> > > On Wed, Jul 31, 2024 at 5:29=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > >> On Wed, Jul 31, 2024 at 09:24:05AM GMT, Alexandre Ghiti wrote:
> > >>> In order to produce a generic kernel, a user can select
> > >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > >>> spinlock implementation if Zabha or Ziccrse are not present.
> > >>>
> > >>> Note that we can't use alternatives here because the discovery of
> > >>> extensions is done too late and we need to start with the qspinlock
> > >>> implementation because the ticket spinlock implementation would pol=
lute
> > >>> the spinlock value, so let's use static keys.
> > >>>
> > >>> This is largely based on Guo's work and Leonardo reviews at [1].
> > >>>
> > >>> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-=
guoren@kernel.org/ [1]
> > >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > >>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >>> ---
> > >>>   .../locking/queued-spinlocks/arch-support.txt |  2 +-
> > >>>   arch/riscv/Kconfig                            | 29 +++++++++++++
> > >>>   arch/riscv/include/asm/Kbuild                 |  4 +-
> > >>>   arch/riscv/include/asm/spinlock.h             | 43 ++++++++++++++=
+++++
> > >>>   arch/riscv/kernel/setup.c                     | 38 ++++++++++++++=
++
> > >>>   include/asm-generic/qspinlock.h               |  2 +
> > >>>   include/asm-generic/ticket_spinlock.h         |  2 +
> > >>>   7 files changed, 118 insertions(+), 2 deletions(-)
> > >>>   create mode 100644 arch/riscv/include/asm/spinlock.h
> > >>>
> > >>> diff --git a/Documentation/features/locking/queued-spinlocks/arch-s=
upport.txt b/Documentation/features/locking/queued-spinlocks/arch-support.t=
xt
> > >>> index 22f2990392ff..cf26042480e2 100644
> > >>> --- a/Documentation/features/locking/queued-spinlocks/arch-support.=
txt
> > >>> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.=
txt
> > >>> @@ -20,7 +20,7 @@
> > >>>       |    openrisc: |  ok  |
> > >>>       |      parisc: | TODO |
> > >>>       |     powerpc: |  ok  |
> > >>> -    |       riscv: | TODO |
> > >>> +    |       riscv: |  ok  |
> > >>>       |        s390: | TODO |
> > >>>       |          sh: | TODO |
> > >>>       |       sparc: |  ok  |
> > >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >>> index ef55ab94027e..c9ff8081efc1 100644
> > >>> --- a/arch/riscv/Kconfig
> > >>> +++ b/arch/riscv/Kconfig
> > >>> @@ -79,6 +79,7 @@ config RISCV
> > >>>        select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> > >>>        select ARCH_WANTS_NO_INSTR
> > >>>        select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > >>> +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> > >> Why do we need this? Also, we presumably would prefer not to have it
> > >> when we end up using ticket spinlocks when combo spinlocks is select=
ed.
> > >> Is there no way to avoid it?
> > > I'll let Andrea answer this as he asked for it.
> > >
> > >>>        select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > >>>        select BUILDTIME_TABLE_SORT if MMU
> > >>>        select CLINT_TIMER if RISCV_M_MODE
> > >>> @@ -488,6 +489,34 @@ config NODES_SHIFT
> > >>>          Specify the maximum number of NUMA Nodes available on the =
target
> > >>>          system.  Increases memory reserved to accommodate various =
tables.
> > >>>
> > >>> +choice
> > >>> +     prompt "RISC-V spinlock type"
> > >>> +     default RISCV_COMBO_SPINLOCKS
> > >>> +
> > >>> +config RISCV_TICKET_SPINLOCKS
> > >>> +     bool "Using ticket spinlock"
> > >>> +
> > >>> +config RISCV_QUEUED_SPINLOCKS
> > >>> +     bool "Using queued spinlock"
> > >>> +     depends on SMP && MMU && NONPORTABLE
> > >>> +     select ARCH_USE_QUEUED_SPINLOCKS
> > >>> +     help
> > >>> +       The queued spinlock implementation requires the forward pro=
gress
> > >>> +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Z=
abha or
> > >>> +       LR/SC with Ziccrse provide such guarantee.
> > >>> +
> > >>> +       Select this if and only if Zabha or Ziccrse is available on=
 your
> > >>> +       platform.
> > >> Maybe some text recommending combo spinlocks here? As it stands it s=
ounds
> > >> like enabling queued spinlocks is a bad idea for anybody that doesn'=
t know
> > >> what platforms will run the kernel they're building, which is all di=
stros.
> > > That's NONPORTABLE, so people enabling this config are supposed to
> > > know that right?
> > >
> > >>> +
> > >>> +config RISCV_COMBO_SPINLOCKS
> > >>> +     bool "Using combo spinlock"
> > >>> +     depends on SMP && MMU
> > >>> +     select ARCH_USE_QUEUED_SPINLOCKS
> > >>> +     help
> > >>> +       Embed both queued spinlock and ticket lock so that the spin=
lock
> > >>> +       implementation can be chosen at runtime.
> > >> nit: Add a blank line here
> > > Done
> > >
> > >>> +endchoice
> > >>> +
> > >>>   config RISCV_ALTERNATIVE
> > >>>        bool
> > >>>        depends on !XIP_KERNEL
> > >>> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm=
/Kbuild
> > >>> index 5c589770f2a8..1c2618c964f0 100644
> > >>> --- a/arch/riscv/include/asm/Kbuild
> > >>> +++ b/arch/riscv/include/asm/Kbuild
> > >>> @@ -5,10 +5,12 @@ syscall-y +=3D syscall_table_64.h
> > >>>   generic-y +=3D early_ioremap.h
> > >>>   generic-y +=3D flat.h
> > >>>   generic-y +=3D kvm_para.h
> > >>> +generic-y +=3D mcs_spinlock.h
> > >>>   generic-y +=3D parport.h
> > >>> -generic-y +=3D spinlock.h
> > >>>   generic-y +=3D spinlock_types.h
> > >>> +generic-y +=3D ticket_spinlock.h
> > >>>   generic-y +=3D qrwlock.h
> > >>>   generic-y +=3D qrwlock_types.h
> > >>> +generic-y +=3D qspinlock.h
> > >>>   generic-y +=3D user.h
> > >>>   generic-y +=3D vmlinux.lds.h
> > >>> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include=
/asm/spinlock.h
> > >>> new file mode 100644
> > >>> index 000000000000..503aef31db83
> > >>> --- /dev/null
> > >>> +++ b/arch/riscv/include/asm/spinlock.h
> > >>> @@ -0,0 +1,43 @@
> > >>> +/* SPDX-License-Identifier: GPL-2.0 */
> > >>> +
> > >>> +#ifndef __ASM_RISCV_SPINLOCK_H
> > >>> +#define __ASM_RISCV_SPINLOCK_H
> > >>> +
> > >>> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > >>> +#define _Q_PENDING_LOOPS     (1 << 9)
> > >>> +
> > >>> +#define __no_arch_spinlock_redefine
> > >>> +#include <asm/ticket_spinlock.h>
> > >>> +#include <asm/qspinlock.h>
> > >>> +#include <asm/alternative.h>
> > >> We need asm/jump_label.h instead of asm/alternative.h, but...
> > >>
> > >>> +
> > >>> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > >>> +
> > >>> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                =
   \
> > >>> +static __always_inline type arch_spin_##op(type_lock lock)        =
   \
> > >>> +{                                                                 =
   \
> > >>> +     if (static_branch_unlikely(&qspinlock_key))                  =
   \
> > >>> +             return queued_spin_##op(lock);                       =
   \
> > >>> +     return ticket_spin_##op(lock);                               =
   \
> > >>> +}
> > >> ...do you know what impact this inlined static key check has on the
> > >> kernel size?
> > > No, I'll check, thanks.
> >
> >
> > So I have just checked the size of the jump table section:
> >
> > * defconfig:
> >
> > - ticket: 26928 bytes
> > - combo: 28320 bytes
> >
> > So that's a ~5% increase.
> >
> > * ubuntu config
> >
> > - ticket: 107840 bytes
> > - combo: 174752 bytes
> >
> > And that's a ~62% increase.
> The size of the jump table section has increased from 5% to 62%. I
> think some configuration triggers the jump table's debug code. If it's
> not a debugging configuration, that's a bug of the Ubuntu config.

Let's cc @Emil Renner Berthing to make him aware of this "issue" and
maybe he even has an idea :)

>
> >
> > This is the ELF size difference between ticket and combo spinlocks:
> >
> > * ticket: 776915592 bytes
> > * combo: 786958968 bytes
> >
> > So that's an increase of ~1.3% on the ELF.
> >
> > And the .text section size:
> >
> > * ticket: 12290960 bytes
> > * combo: 12366644 bytes
> >
> > And that's a ~0.6% increase!
> >
> > Finally, I'd say the impact is very limited :)
> >
> > Thanks,
> >
> > Alex
> >
> >
> > >
> > >> Actually, why not use ALTERNATIVE with any nonzero cpufeature value.
> > >> Then add code to riscv_cpufeature_patch_check() to return true when
> > >> qspinlocks should be enabled (based on the value of some global set
> > >> during riscv_spinlock_init)?
> > > As discussed with Guo in the previous iteration, the patching of the
> > > alternatives intervenes far after the first use of the spinlocks and
> > > the ticket spinlock implementation pollutes the spinlock value, so
> > > we'd have to unconditionally start with the qspinlock implementation
> > > and after switch to the ticket implementation if not supported by the
> > > platform. It works but it's dirty, I really don't like this hack.
> > >
> > > We could though:
> > > - add an initial value to the alternatives (not sure it's feasible th=
ough)
> > > - make the patching of alternatives happen sooner by parsing the isa
> > > string sooner, either in DT or ACPI (I have a working PoC for very
> > > early parsing of ACPI).
> > >
> > > I intend to do the latter as I think we should be aware of the
> > > extensions sooner in the boot process, so I'll change that to the
> > > alternatives when it's done. WDYT, any other idea?
> > >
> > >
> > >>> +
> > >>> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > >>> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > >>> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > >>> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > >>> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > >>> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > >>> +
> > >>> +#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> > >>> +
> > >>> +#include <asm/qspinlock.h>
> > >>> +
> > >>> +#else
> > >>> +
> > >>> +#include <asm/ticket_spinlock.h>
> > >>> +
> > >>> +#endif
> > >>> +
> > >>> +#include <asm/qrwlock.h>
> > >>> +
> > >>> +#endif /* __ASM_RISCV_SPINLOCK_H */
> > >>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > >>> index a2cde65b69e9..b811fa331982 100644
> > >>> --- a/arch/riscv/kernel/setup.c
> > >>> +++ b/arch/riscv/kernel/setup.c
> > >>> @@ -244,6 +244,43 @@ static void __init parse_dtb(void)
> > >>>   #endif
> > >>>   }
> > >>>
> > >>> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > >>> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > >>> +EXPORT_SYMBOL(qspinlock_key);
> > >>> +#endif
> > >>> +
> > >>> +static void __init riscv_spinlock_init(void)
> > >>> +{
> > >>> +     char *using_ext =3D NULL;
> > >>> +
> > >>> +     if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> > >>> +             pr_info("Ticket spinlock: enabled\n");
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> > >>> +         IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> > >>> +         riscv_isa_extension_available(NULL, ZABHA) &&
> > >>> +         riscv_isa_extension_available(NULL, ZACAS)) {
> > >>> +             using_ext =3D "using Zabha";
> > >>> +     } else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> > >>> +             using_ext =3D "using Ziccrse";
> > >>> +     }
> > >>> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > >>> +     else {
> > >> else if (IS_ENABLED(CONFIG_RISCV_COMBO_SPINLOCKS))
> > >>
> > >>> +             static_branch_disable(&qspinlock_key);
> > >>> +             pr_info("Ticket spinlock: enabled\n");
> > >>> +
> > >> nit: remove this blank line
> > >>
> > >>> +             return;
> > >>> +     }
> > >>> +#endif
> > >>> +
> > >>> +     if (!using_ext)
> > >>> +             pr_err("Queued spinlock without Zabha or Ziccrse");
> > >>> +     else
> > >>> +             pr_info("Queued spinlock %s: enabled\n", using_ext);
> > >>> +}
> > >>> +
> > >>>   extern void __init init_rt_signal_env(void);
> > >>>
> > >>>   void __init setup_arch(char **cmdline_p)
> > >>> @@ -297,6 +334,7 @@ void __init setup_arch(char **cmdline_p)
> > >>>        riscv_set_dma_cache_alignment();
> > >>>
> > >>>        riscv_user_isa_enable();
> > >>> +     riscv_spinlock_init();
> > >>>   }
> > >>>
> > >>>   bool arch_cpu_is_hotpluggable(int cpu)
> > >>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/=
qspinlock.h
> > >>> index 0655aa5b57b2..bf47cca2c375 100644
> > >>> --- a/include/asm-generic/qspinlock.h
> > >>> +++ b/include/asm-generic/qspinlock.h
> > >>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(stru=
ct qspinlock *lock)
> > >>>   }
> > >>>   #endif
> > >>>
> > >>> +#ifndef __no_arch_spinlock_redefine
> > >> I'm not sure what's better/worse, but instead of inventing this
> > >> __no_arch_spinlock_redefine thing we could just name all the functio=
ns
> > >> something like __arch_spin* and then add defines for both to asm/spi=
nlock.h,
> > >> i.e.
> > >>
> > >> #define queued_spin_lock(l) __arch_spin_lock(l)
> > >> ...
> > >>
> > >> #define ticket_spin_lock(l) __arch_spin_lock(l)
> > >> ...
> > >>
> > >> Besides not having to touch asm-generic/qspinlock.h and
> > >> asm-generic/ticket_spinlock.h it allows one to find the implementati=
ons
> > >> a bit easier as following a tag to arch_spin_lock() will take them t=
o
> > >> queued_spin_lock() which will then take them to
> > >> arch/riscv/include/asm/spinlock.h and there they'll figure out how
> > >> __arch_spin_lock() was defined.
> > >>
> > >>>   /*
> > >>>    * Remapping spinlock architecture specific functions to the corr=
esponding
> > >>>    * queued spinlock functions.
> > >>> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(stru=
ct qspinlock *lock)
> > >>>   #define arch_spin_lock(l)            queued_spin_lock(l)
> > >>>   #define arch_spin_trylock(l)         queued_spin_trylock(l)
> > >>>   #define arch_spin_unlock(l)          queued_spin_unlock(l)
> > >>> +#endif
> > >>>
> > >>>   #endif /* __ASM_GENERIC_QSPINLOCK_H */
> > >>> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-ge=
neric/ticket_spinlock.h
> > >>> index cfcff22b37b3..325779970d8a 100644
> > >>> --- a/include/asm-generic/ticket_spinlock.h
> > >>> +++ b/include/asm-generic/ticket_spinlock.h
> > >>> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contend=
ed(arch_spinlock_t *lock)
> > >>>        return (s16)((val >> 16) - (val & 0xffff)) > 1;
> > >>>   }
> > >>>
> > >>> +#ifndef __no_arch_spinlock_redefine
> > >>>   /*
> > >>>    * Remapping spinlock architecture specific functions to the corr=
esponding
> > >>>    * ticket spinlock functions.
> > >>> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_conten=
ded(arch_spinlock_t *lock)
> > >>>   #define arch_spin_lock(l)            ticket_spin_lock(l)
> > >>>   #define arch_spin_trylock(l)         ticket_spin_trylock(l)
> > >>>   #define arch_spin_unlock(l)          ticket_spin_unlock(l)
> > >>> +#endif
> > >>>
> > >>>   #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > >>> --
> > >>> 2.39.2
> > >>>
> > >> Thanks,
> > >> drew
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Best Regards
>  Guo Ren

