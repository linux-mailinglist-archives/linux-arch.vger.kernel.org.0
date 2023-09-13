Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EA79DE02
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbjIMBzv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 21:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjIMBzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 21:55:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDA10EB;
        Tue, 12 Sep 2023 18:55:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1B2C433D9;
        Wed, 13 Sep 2023 01:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694570146;
        bh=2OddQKIH3uYXJT7ExCA6HUaFdELFgK8aV8tLID+9nMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eD0PQCfBKvsqVbB7ZvJNoRjXJLBBGZHn7YlSY1d/Tz+qrf4w3SSr4rHMQrwHZomTq
         /gGngHgQe0yZjZ49G1DqOAiFSCDvaQAw3+Jbovt3FzsC97hDsUmgVouzDdA9qdhNmT
         K8mB8yEC9C1lWaVjm78l1Vdj84WFdaOwFhvcegWoOdwmTSLOP0+0kNYKKoOnRpMcwL
         Zg0Dt3s0KZro1KI9dnHd1Uw0K2Q80a5Ig7UDUuRwuMeu9ravHyLun9fMqlp5S4c+y0
         sPVzgLLUrB0JtdlQNL8M+GAGtjiD3zVCe2dgZARFgoDCAwc4ceSWMHg2400pjtpAeb
         jqMIYKeY0hFcw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-501be2d45e0so10633674e87.3;
        Tue, 12 Sep 2023 18:55:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw1bh1PU/GbvxMYx3w1CgGt6HjH/YoD48410ij48/Q03WgcO5Pu
        ubEJ5Lghbx5g9id7w8YlSUESiRWzKs51lIs/zYI=
X-Google-Smtp-Source: AGHT+IGiIM8YEctQvL/CVmwan/hG+6jqbFGBYTrZFX/O9x6gC7L4g0XHDwgTYPZ+T/UmOPyj0gLtC9syNiSq7NGyTW8=
X-Received: by 2002:ac2:58e8:0:b0:500:bffa:5b86 with SMTP id
 v8-20020ac258e8000000b00500bffa5b86mr760589lfo.6.1694570144735; Tue, 12 Sep
 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-2-guoren@kernel.org>
 <5c082cb1fd306cb75abbcaa80229d791260f8756.camel@redhat.com>
In-Reply-To: <5c082cb1fd306cb75abbcaa80229d791260f8756.camel@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Sep 2023 09:55:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSynMnYy+ARhFb0JjbAGjEYrfgsiGa2ZWv4wB3HdheU2A@mail.gmail.com>
Message-ID: <CAJF2gTSynMnYy+ARhFb0JjbAGjEYrfgsiGa2ZWv4wB3HdheU2A@mail.gmail.com>
Subject: Re: [PATCH V11 01/17] asm-generic: ticket-lock: Reuse arch_spinlock_t
 of qspinlock
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 12, 2023 at 3:05=E2=80=AFAM Leonardo Br=C3=A1s <leobras@redhat.=
com> wrote:
>
> On Sun, 2023-09-10 at 04:28 -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The arch_spinlock_t of qspinlock has contained the atomic_t val, which
> > satisfies the ticket-lock requirement. Thus, unify the arch_spinlock_t
> > into qspinlock_types.h. This is the preparation for the next combo
> > spinlock.
> >
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  include/asm-generic/spinlock.h       | 14 +++++++-------
> >  include/asm-generic/spinlock_types.h | 12 ++----------
> >  2 files changed, 9 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinl=
ock.h
> > index 90803a826ba0..4773334ee638 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -32,7 +32,7 @@
> >
> >  static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> >  {
> > -     u32 val =3D atomic_fetch_add(1<<16, lock);
> > +     u32 val =3D atomic_fetch_add(1<<16, &lock->val);
> >       u16 ticket =3D val >> 16;
> >
> >       if (ticket =3D=3D (u16)val)
> > @@ -46,31 +46,31 @@ static __always_inline void arch_spin_lock(arch_spi=
nlock_t *lock)
> >        * have no outstanding writes due to the atomic_fetch_add() the e=
xtra
> >        * orderings are free.
> >        */
> > -     atomic_cond_read_acquire(lock, ticket =3D=3D (u16)VAL);
> > +     atomic_cond_read_acquire(&lock->val, ticket =3D=3D (u16)VAL);
> >       smp_mb();
> >  }
> >
> >  static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> >  {
> > -     u32 old =3D atomic_read(lock);
> > +     u32 old =3D atomic_read(&lock->val);
> >
> >       if ((old >> 16) !=3D (old & 0xffff))
> >               return false;
> >
> > -     return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for =
RCsc */
> > +     return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC=
, for RCsc */
> >  }
> >
> >  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> >       u16 *ptr =3D (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> > -     u32 val =3D atomic_read(lock);
> > +     u32 val =3D atomic_read(&lock->val);
> >
> >       smp_store_release(ptr, (u16)val + 1);
> >  }
> >
> >  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lo=
ck)
> >  {
> > -     u32 val =3D lock.counter;
> > +     u32 val =3D lock.val.counter;
> >
> >       return ((val >> 16) =3D=3D (val & 0xffff));
> >  }
>
> This one seems to be different in torvalds/master, but I suppose it's bec=
ause of
> the requirement patches I have not merged.
>
> > @@ -84,7 +84,7 @@ static __always_inline int arch_spin_is_locked(arch_s=
pinlock_t *lock)
> >
> >  static __always_inline int arch_spin_is_contended(arch_spinlock_t *loc=
k)
> >  {
> > -     u32 val =3D atomic_read(lock);
> > +     u32 val =3D atomic_read(&lock->val);
> >
> >       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >  }
> > diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic=
/spinlock_types.h
> > index 8962bb730945..f534aa5de394 100644
> > --- a/include/asm-generic/spinlock_types.h
> > +++ b/include/asm-generic/spinlock_types.h
> > @@ -3,15 +3,7 @@
> >  #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
> >  #define __ASM_GENERIC_SPINLOCK_TYPES_H
> >
> > -#include <linux/types.h>
> > -typedef atomic_t arch_spinlock_t;
> > -
> > -/*
> > - * qrwlock_types depends on arch_spinlock_t, so we must typedef that b=
efore the
> > - * include.
> > - */
> > -#include <asm/qrwlock_types.h>
> > -
> > -#define __ARCH_SPIN_LOCK_UNLOCKED    ATOMIC_INIT(0)
> > +#include <asm-generic/qspinlock_types.h>
> > +#include <asm-generic/qrwlock_types.h>
> >
> >  #endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
>
> FWIW, LGTM:
>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
>
>
> Just a suggestion: In this patch I could see a lot of usage changes to
> arch_spinlock_t, and only at the end I could see the actual change in the=
 .h
> file.
 include/asm-generic/spinlock.h       | 14 +++++++-------
 include/asm-generic/spinlock_types.h | 12 ++----------

All are .h files. So, how to use git.orderfile?

>
> In cases like this, it looks nicer to see the .h file first.
>
> I recently found out about this git diff.orderFile option, which helps to
> achieve exactly this.
>
> I use the following git.orderfile, adapted from qemu:
>
> #########################################################################=
###
> #
> # order file for git, to produce patches which are easier to review
> # by diffing the important stuff like interface changes first.
> #
> # one-off usage:
> #   git diff -O scripts/git.orderfile ...
> #
> # add to git config:
> #   git config diff.orderFile scripts/git.orderfile
> #
>
> MAINTAINERS
>
> # Documentation
> Documentation/*
> *.rst
> *.rst.inc
>
> # build system
> Kbuild
> Makefile*
> *.mak
>
> # semantic patches
> *.cocci
>
> # headers
> *.h
> *.h.inc
>
> # code
> *.c
> *.c.inc
>
>


--=20
Best Regards
 Guo Ren
