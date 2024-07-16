Return-Path: <linux-arch+bounces-5404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BC9321E4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814C81C21B45
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FA1822D0;
	Tue, 16 Jul 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZGyLnFT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945851822CA;
	Tue, 16 Jul 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118696; cv=none; b=tRmcIc68S8OlNRIEJTpDxayLOa09nVCwwdp5l1Udu5Ltxfp2ch72FJ3VxSxsz9M2EXKFyb/fbUrbqYBvSGN7ygWzEKZWtbKjyJ1dJAHsZfiXkd0H8qM6jbzshA3bPlFcW9oEyhiJv7h7/+OFUJPPhpVK4bU78qxLc3Ash/lEi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118696; c=relaxed/simple;
	bh=2kz+oo4hvXnKaRt5/hsLQHWOz+6APQEp0QYjh31yuQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCxpOgp/ns90sA/JdG454RHOVhjy4H6ekUe4JOA+vCdm7ZXyCUW+ZyJgMXpv6CI1v54PbWf8jGUEBDz7Q/GghSRMLZcJbVNWrC9OIGKhB/Wuf9pBt63ojaWqm/QjQVRIL1fTQUILQKlbmST0D9uPhxsUZqocty4J/P0P6z/WUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZGyLnFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23238C4AF0F;
	Tue, 16 Jul 2024 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721118696;
	bh=2kz+oo4hvXnKaRt5/hsLQHWOz+6APQEp0QYjh31yuQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AZGyLnFTUSndoi1qq1vTC86m17H3N0Ata4QJ7QsM8alCuSaiVb+pHGrSKqxIEgn2C
	 M6BNQjylV8CG5PBVEkVOmabBrIEvekvJl6oVsbCRtnwSubT6Hphze/dBLi0ZSCpaQg
	 rUNqVlzaWXrYFV8oEfC6705OQPbVBp1GmpXM5F5IjQ7c9uEjHGXiRWEEMnE5W2TV7q
	 /OXvZkBaLDQlBgypt5bYmbPv6TnmzKdJJD9MQgeuogjeOwT/kq90TZ9FIs8WjQ2o8A
	 iKiwlnliEU1yjOyCjuhkFgLEOgbWzEjHDOurI2yb5GlbR4hxYeGr7J1jAuGCVJ8dSi
	 QR9b0EPiDI9jA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77c2d89af8so587982966b.2;
        Tue, 16 Jul 2024 01:31:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOIlTOE8TcL4PYZwsw4z/nASZ0BQNzAKNRI9nSoVlyK8IbpesvMIoUBaYn1U7rdVMNlhlhCUeznOHR42l11dtDxotJgPC3OHgA2WlQWRa4NclcfQaKXEqrzIgK/fZGFEhLiqeRL8+FteGd4Tuu2m73liOt/JKB0ih8ITebE3O4DJ9owQ==
X-Gm-Message-State: AOJu0YxAOkMgyoSJ4eWa9zpJGfewN2k1NGT0/6jBQGq39KfVMr0BfeBz
	pB7Z7LKqcZAXQaUNsKBNDCQ6ovmdWily7PtZIVX4tWz3X3DLwtybKVufzEa/fWj+b05R/PiyVUb
	MyINNlw07JBhFskfdjw/Cf8qNN0A=
X-Google-Smtp-Source: AGHT+IENmfFJO4NtBiyFIS7wDT+ResmSXEAvfaBWCMxivVTmQOzvNuWjmQb6hEDeD8CCrbTlhkCAiDs7OZdyZsj1qSQ=
X-Received: by 2002:a17:906:37d6:b0:a6f:12:8c45 with SMTP id
 a640c23a62f3a-a79eaa856a1mr80302366b.72.1721118694537; Tue, 16 Jul 2024
 01:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com> <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
 <CAHVXubizLq=qZgVQ2vBFe5zVuLRP0DGw=UN4U_Wkx2P2xsP3Mw@mail.gmail.com>
 <a096151c-c349-455f-8939-3b739d73f016@redhat.com> <CAJF2gTRrZwVk2xyhF_PsJGKCfkvun-rifG8MjDBcGDt3YBuhPg@mail.gmail.com>
 <CAHVXubh00OyazGP2C6sg0N2=kWqV-HXpzEiZCDdex8hcmLEM2g@mail.gmail.com>
In-Reply-To: <CAHVXubh00OyazGP2C6sg0N2=kWqV-HXpzEiZCDdex8hcmLEM2g@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Jul 2024 16:31:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRpXBS-YotgEO=cPGnwjYiUyda_wk_fQfA6j_QqdYHoQw@mail.gmail.com>
Message-ID: <CAJF2gTRpXBS-YotgEO=cPGnwjYiUyda_wk_fQfA6j_QqdYHoQw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:43=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Guo, Waiman,
>
> On Tue, Jul 16, 2024 at 3:05=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Tue, Jul 16, 2024 at 3:30=E2=80=AFAM Waiman Long <longman@redhat.com=
> wrote:
> > >
> > > On 7/15/24 03:27, Alexandre Ghiti wrote:
> > > > Hi Guo,
> > > >
> > > > On Sun, Jul 7, 2024 at 4:20=E2=80=AFAM Guo Ren <guoren@kernel.org> =
wrote:
> > > >> On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> > > >>> In order to produce a generic kernel, a user can select
> > > >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the tick=
et
> > > >>> spinlock implementation if Zabha is not present.
> > > >>>
> > > >>> Note that we can't use alternatives here because the discovery of
> > > >>> extensions is done too late and we need to start with the qspinlo=
ck
> > > >> That's not true; we treat spinlock as qspinlock at first.
> > > > That's what I said: we have to use the qspinlock implementation at
> > > > first *because* we can't discover the extensions soon enough to use
> > > > the right spinlock implementation before the kernel uses a spinlock=
.
> > > > And since the spinlocks are used *before* the discovery of the
> > > > extensions, we cannot use the current alternative mechanism or we'd
> > > > need to extend it to add an "initial" value which does not depend o=
n
> > > > the available extensions.
> > >
> > > With qspinlock, the lock remains zero after a lock/unlock sequence. T=
hat
> > > is not the case with ticket lock. Assuming that all the discovery wil=
l
> > > be done before SMP boot, the qspinlock slowpath won't be activated an=
d
> > > so we don't need the presence of any extension. I believe that is the
> > > main reason why qspinlock is used as the initial default and not tick=
et
> > > lock.
> > Thx Waiman,
> > Yes, qspinlock is a clean guy, but ticket lock is a dirty one.
>
> Guys, we all agree on that, that's why I kept this behaviour in this patc=
hset.
>
> >
> > Hi Alexandre,
> > Therefore, the switch point(before reset_init()) is late enough to
> > change the lock mechanism, and this satisfies the requirements of
> > apply_boot_alternatives(), apply_early_boot_alternatives(), and
> > apply_module_alternatives().
>
> I can't find reset_init().
Sorry for the typo, rest_init()
>
> The discovery of the extensions is done in riscv_fill_hwcap() called
> from setup_arch()
> https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.c#=
L288.
> So *before* this point, we have no knowledge of the available
> extensions on the platform.  Let's imagine now that we use an
> alternative for the qspinlock implementation, it will look like this
> (I use only zabha here, that's an example):
>
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -16,8 +16,12 @@ DECLARE_STATIC_KEY_TRUE(qspinlock_key);
>  #define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
>  static __always_inline type arch_spin_##op(type_lock lock)             \
>  {                                                                      \
> -       if (static_branch_unlikely(&qspinlock_key))                     \
> -               return queued_spin_##op(lock);                          \
> +       asm goto(ALTERNATIVE("j %[no_zabha]", "nop", 0,                 \
> +                                     RISCV_ISA_EXT_ZABHA, 1)            =
\
> +                         : : : : no_zabha);                            \
> +                                                                       \
> +       return queued_spin_##op(lock);                                  \
> +no_zabha:                                                              \
>         return ticket_spin_##op(lock);                                  \
>  }
>
> apply_early_boot_alternatives() can't be used to patch the above
> alternative since it is called from setup_vm(), way before we know the
> available extensions.
> apply_boot_alternatives(), instead, is called after riscv_fill_hwcap()
> and then will be able to patch the alternatives correctly
> https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.c#=
L290.
>
> But then, before apply_boot_alternatives(), any use of a spinlock
> (printk does so) will use a ticket spinlock implementation, and not
> the qspinlock implementation. How do you fix that?
Why "before apply_boot_alternatives(), any use of a spinlock (printk
does so) will use a ticket spinlock implementation" ?
We treat qspinlock as the initial spinlock forever, so there is only
qspinlock -> ticket_lock direction and no reverse.

>
> >
> > >
> > > Cheers,
> > > Longman
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren

