Return-Path: <linux-arch+bounces-5835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159F9445D6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B0D1C20B56
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E8158529;
	Thu,  1 Aug 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ax5xiLot"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C8163A97
	for <linux-arch@vger.kernel.org>; Thu,  1 Aug 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498529; cv=none; b=mUu/6Gv1g1g9ZfaJWDSJzeZMh2uzeZASR9djMfN2uAQd1NhvojuGSK6GSIAjIjL1mofhBlfEBprs7zTBpsINcm9QshMKLChFsFArELYv81T+IA/pAm2BW4Z0hDU0SBrscaq3nT2+pLwp+1rHRu1enucqodKFhAL50X+3rdGBlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498529; c=relaxed/simple;
	bh=7k1tHCj/IigIKmy4+p+WwobnV7zERZgAs34Fzr2SrVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2F62LPBLoIIhmak5J/o8eONDLMtay0qHhIq8GOXxZ3U4uOR8r1XmtZ/WFMwNnjvQa/eZf7N2YiFHwQ4P3gosMrtfsBmE+tl0XaA5RYqZUWUn1hmGUH5ttt7+U4sllqcpUPUtTCs1Aeo0XEwfq7/TY1MW5OeCNRBKYpL755VmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ax5xiLot; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso878129366b.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2024 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722498526; x=1723103326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpgRYBRoCwuCvyWPTeidprozH3XXG59M+x9HHpyT17c=;
        b=Ax5xiLotZZ+eKmRXiQhW/Wf6baXG5V1OhD2BVf0qkvgSer1B6/Ahpp14MB7FaKwLyM
         kM4vDraUZBBeg1VPaQm1pxQRgvKPY6/7XmvGP7e01aYD9dYP2wtOMbbv2x5zWK4fWg87
         ZGMTcQvgQOlXeYRwI8nOhz70wOszEyV1W8UnP+8eBtaPRMDY6rIYBJ6m/jdfS5rLDIXg
         DS0lZYWsmOILPbXEkFUnlQdrFFOSkWvQL8VZkCTgxioawsFXroZ/pKNOG3SneKqTctAE
         9g3UrOXtEd8b1gGsor2Pvx1hWfqqLmI9fz8FlfgQ6cFsQXz0OfU7Jk+5hSYnjpuPH+nE
         E2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722498526; x=1723103326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpgRYBRoCwuCvyWPTeidprozH3XXG59M+x9HHpyT17c=;
        b=VxNwLJQThmWoj6T6ztbE086maaScvRxpXukJ5GGDkz8Mj3kap/pxhbQGjF5WeyvlD4
         WuW12/ypmFhuwDP1dqRxU9Jpp1C3gHNlc2zdzBLRdMsLtUwnW1xj4l7oIASQZ76JHlmG
         +3Yotiiyw7PImQPfb75s23k1zKwvsvCXtlgrvb8IEPsfI1WrqV0nz7t2e7H+8i82ItUz
         h2X4a+uEFn0ovFJV8OhcMFlJ4jfAcxzlhm2dqyknPjCRa7Rc+4ZO+eqbPJ/4wIVLs8dM
         1ys9Zub0CWSF3+ilakD2JPidkmsIRKFYpnXsEwde7G0dkgGLbH3OCa5fcTl2fFC8lkLw
         QwYg==
X-Forwarded-Encrypted: i=1; AJvYcCXdGkiFaGxZLBXEGOodwzM1cAf6NPNEDwHMWLJ6Dggz3ySFKt2GZ71oM7/kGc3jXwNBWPUnjr6jEam82QGof/WLnBVQ7fbG8JX1qw==
X-Gm-Message-State: AOJu0YxTuagi9AX+DBo/cW52u3X5On+CBk7sLsBg68OP9m+A60xUvn5o
	98wJ95pt3hc+IAeR4+2IeQwfcdFqM7nIt1KnYotfKjQH2gN0T6draoE3mnArc9E=
X-Google-Smtp-Source: AGHT+IGJv3Ero2PFVW3HYlIFYvhbjq3izkAroXjPAXo8JMZv78p6fmd7ZKLSN2GEo8xLlJkmY0TzFw==
X-Received: by 2002:a17:907:6e9e:b0:a79:8318:288f with SMTP id a640c23a62f3a-a7daf51bca7mr126973566b.16.1722498525027;
        Thu, 01 Aug 2024 00:48:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de06sm859070366b.71.2024.08.01.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:48:44 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:48:43 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
Message-ID: <20240801-45b47eced3011c8a400ff836@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com>
 <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>

On Thu, Aug 01, 2024 at 08:53:06AM GMT, Alexandre Ghiti wrote:
> On Wed, Jul 31, 2024 at 5:29 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 09:24:05AM GMT, Alexandre Ghiti wrote:
> > > In order to produce a generic kernel, a user can select
> > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > > spinlock implementation if Zabha or Ziccrse are not present.
> > >
> > > Note that we can't use alternatives here because the discovery of
> > > extensions is done too late and we need to start with the qspinlock
> > > implementation because the ticket spinlock implementation would pollute
> > > the spinlock value, so let's use static keys.
> > >
> > > This is largely based on Guo's work and Leonardo reviews at [1].
> > >
> > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> > >  arch/riscv/Kconfig                            | 29 +++++++++++++
> > >  arch/riscv/include/asm/Kbuild                 |  4 +-
> > >  arch/riscv/include/asm/spinlock.h             | 43 +++++++++++++++++++
> > >  arch/riscv/kernel/setup.c                     | 38 ++++++++++++++++
> > >  include/asm-generic/qspinlock.h               |  2 +
> > >  include/asm-generic/ticket_spinlock.h         |  2 +
> > >  7 files changed, 118 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > >
> > > diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > index 22f2990392ff..cf26042480e2 100644
> > > --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
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
> > > index ef55ab94027e..c9ff8081efc1 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -79,6 +79,7 @@ config RISCV
> > >       select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> > >       select ARCH_WANTS_NO_INSTR
> > >       select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > > +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> >
> > Why do we need this? Also, we presumably would prefer not to have it
> > when we end up using ticket spinlocks when combo spinlocks is selected.
> > Is there no way to avoid it?
> 
> I'll let Andrea answer this as he asked for it.
> 
> >
> > >       select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > >       select BUILDTIME_TABLE_SORT if MMU
> > >       select CLINT_TIMER if RISCV_M_MODE
> > > @@ -488,6 +489,34 @@ config NODES_SHIFT
> > >         Specify the maximum number of NUMA Nodes available on the target
> > >         system.  Increases memory reserved to accommodate various tables.
> > >
> > > +choice
> > > +     prompt "RISC-V spinlock type"
> > > +     default RISCV_COMBO_SPINLOCKS
> > > +
> > > +config RISCV_TICKET_SPINLOCKS
> > > +     bool "Using ticket spinlock"
> > > +
> > > +config RISCV_QUEUED_SPINLOCKS
> > > +     bool "Using queued spinlock"
> > > +     depends on SMP && MMU && NONPORTABLE
> > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > +     help
> > > +       The queued spinlock implementation requires the forward progress
> > > +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
> > > +       LR/SC with Ziccrse provide such guarantee.
> > > +
> > > +       Select this if and only if Zabha or Ziccrse is available on your
> > > +       platform.
> >
> > Maybe some text recommending combo spinlocks here? As it stands it sounds
> > like enabling queued spinlocks is a bad idea for anybody that doesn't know
> > what platforms will run the kernel they're building, which is all distros.
> 
> That's NONPORTABLE, so people enabling this config are supposed to
> know that right?

Yes, both the NONPORTABLE and the scary text will imply that qspinlocks
shouldn't be selected. I'm asking for text which points people configuring
kernels to COMBO. Something like

  qspinlocks provides performance enhancements on platforms which support
  Zabha or Ziccrse. RISCV_QUEUED_SPINLOCKS should not be selected for
  platforms without one of those extensions. If unsure, select
  RISCV_COMBO_SPINLOCKS, which will use qspinlocks when supported and
  otherwise ticket spinlocks.

> 
> >
> > > +
> > > +config RISCV_COMBO_SPINLOCKS
> > > +     bool "Using combo spinlock"
> > > +     depends on SMP && MMU
> > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > +     help
> > > +       Embed both queued spinlock and ticket lock so that the spinlock
> > > +       implementation can be chosen at runtime.
> >
> > nit: Add a blank line here
> 
> Done
> 
> >
> > > +endchoice
> > > +
> > >  config RISCV_ALTERNATIVE
> > >       bool
> > >       depends on !XIP_KERNEL
> > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > > index 5c589770f2a8..1c2618c964f0 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -5,10 +5,12 @@ syscall-y += syscall_table_64.h
> > >  generic-y += early_ioremap.h
> > >  generic-y += flat.h
> > >  generic-y += kvm_para.h
> > > +generic-y += mcs_spinlock.h
> > >  generic-y += parport.h
> > > -generic-y += spinlock.h
> > >  generic-y += spinlock_types.h
> > > +generic-y += ticket_spinlock.h
> > >  generic-y += qrwlock.h
> > >  generic-y += qrwlock_types.h
> > > +generic-y += qspinlock.h
> > >  generic-y += user.h
> > >  generic-y += vmlinux.lds.h
> > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > new file mode 100644
> > > index 000000000000..503aef31db83
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/spinlock.h
> > > @@ -0,0 +1,43 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > +#define __ASM_RISCV_SPINLOCK_H
> > > +
> > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > +
> > > +#define __no_arch_spinlock_redefine
> > > +#include <asm/ticket_spinlock.h>
> > > +#include <asm/qspinlock.h>
> > > +#include <asm/alternative.h>
> >
> > We need asm/jump_label.h instead of asm/alternative.h, but...
> >
> > > +
> > > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > > +
> > > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                   \
> > > +static __always_inline type arch_spin_##op(type_lock lock)           \
> > > +{                                                                    \
> > > +     if (static_branch_unlikely(&qspinlock_key))                     \
> > > +             return queued_spin_##op(lock);                          \
> > > +     return ticket_spin_##op(lock);                                  \
> > > +}
> >
> > ...do you know what impact this inlined static key check has on the
> > kernel size?
> 
> No, I'll check, thanks.
> 
> >
> > Actually, why not use ALTERNATIVE with any nonzero cpufeature value.
> > Then add code to riscv_cpufeature_patch_check() to return true when
> > qspinlocks should be enabled (based on the value of some global set
> > during riscv_spinlock_init)?
> 
> As discussed with Guo in the previous iteration, the patching of the
> alternatives intervenes far after the first use of the spinlocks and
> the ticket spinlock implementation pollutes the spinlock value, so
> we'd have to unconditionally start with the qspinlock implementation
> and after switch to the ticket implementation if not supported by the
> platform. It works but it's dirty, I really don't like this hack.
> 
> We could though:
> - add an initial value to the alternatives (not sure it's feasible though)
> - make the patching of alternatives happen sooner by parsing the isa
> string sooner, either in DT or ACPI (I have a working PoC for very
> early parsing of ACPI).
> 
> I intend to do the latter as I think we should be aware of the
> extensions sooner in the boot process, so I'll change that to the
> alternatives when it's done. WDYT, any other idea?

Yes, we'll likely want early patching for other extensions as well,
so that's a good idea in general. Putting a TODO on this static key
to be changed to an ALTERNATIVE later when possible sounds reasonable
to me.

Thanks,
drew

