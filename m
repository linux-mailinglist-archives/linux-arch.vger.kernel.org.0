Return-Path: <linux-arch+bounces-5435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A29336C2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043071C20D91
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945712B75;
	Wed, 17 Jul 2024 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UthKgIQG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31A125C9
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197195; cv=none; b=gSgE+BidxtbC1YkfjGuq46JpUpVz2DYkiJbou1YXfDQ6btX8kxd7xsxHyqeaVpcyf5uSJhBpX4NKZa0NCGwKPe3H+o1tgMxI+x4QDKjzpGa6QlobQEljEsIUfzSgWcZho7Epycwp2SMI6bb+OlVgbXgvYZ9RKiHmYFqY8s67rYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197195; c=relaxed/simple;
	bh=+Sn6Vf/bipEMI9l0v7K5QZbcuQASnNZtDyvbVvWM/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjfm+0WITUkbe6w6/BFs5egPsy7iKorVHCfvq5m7YbQSxAxYpGXF3rL0GdfwFqKGYwzwT7AnwzUwbZAxd1YUVKTiGy2fCytyBTpVZImixhfFlRae/I4Jk3Cb2QrDqacadPvYqt4x4hekR/hUyWGKHRyYsDfPfxML1xaYInQbSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UthKgIQG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso7863054a12.0
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197192; x=1721801992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731iNxkRio1CVh7O96GIueitOfVCcVF5gDjduzXxip0=;
        b=UthKgIQGzhFxxtKf1ND1Iuj/gp2QWIpMxmG9CynONm63b6SDtdRrmC5VdG4SIH6xqG
         /u0lzYUhzHPAexVVlCxH9FOINA1FsWC4AECymuQ4Cxr1iKLah29a85hUv95c7pbWyF14
         QFxpBUJR1d9IN+VcguasKdrGJvsv8J7uo5ESACnOP0QsK+4gsxbBYXVJS45iRLaJzGUl
         EtsNvn1zI5+bpZSPFfQi7Byhgz8+TCqevvowiOSK31Nr0kNTii6Trj+YzKOQPLfvkTlI
         xg+BR9atnAMUQUTLPhr+JdLKRYP/daGmEIok8FKIf5LeuBbTbbrqzyI7E5Tmo8VS+qDF
         8OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197192; x=1721801992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731iNxkRio1CVh7O96GIueitOfVCcVF5gDjduzXxip0=;
        b=mwYhMr9uswfIVaiATMoSSP/mtpNn1+OYuw4LCgqyVjnVqw0sgR24O2AP7oJbg31QEG
         YOsWEbi3IrhOnBJHG7j6xwiuS2lELmGdxz6BV1ec2LNCqVqwoB4tog0P96f/aXQIg5IN
         w7NWm+pI86bmqNrjv8nAm4YuP9gT61Nd+q50vdlDqmK0CvQm8Xm394Vb+e23mLYNEEke
         PUWlSWRZZzgPw6wQlnVaDKCp2UZ4jUMM70eKwbTli7w+uF9S0dNmCEEHAhQAlyK/s7Oy
         eH4m23wdsAao/YDDWKu+CBj8fP6T94fwtnCyCzLeTJZwrhhWo+FhkZGJmpfdrwrPwSTX
         HUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbcqq+ynUs6ddhzTpDdn70cz58/MMxNSglBor+pJdqMIx+MycJ6M0JouBnPCr0UuvC4T62Mrn2NCPRhfpgZgpiIXU/crBfwijDHA==
X-Gm-Message-State: AOJu0YzahBPpm6MahodeFmlL4sI4S0zRK3ekVBkwXhGBqaDzxZz+Wxov
	xBtdUbJII9xAuBSE+7zvia9mEYTXeFjnFlfvGP3AG7+PNXLUqlcwaKwa9EJTjzkzBDzzYLlKDzN
	YikDkOwm1kiojPaU/VTgWF3MATCxw3SLCwwjXtQ==
X-Google-Smtp-Source: AGHT+IGmCAjPv7zwB8K75fubJVOq5OlXEphacZcFqc1Ig0qaFbGDPSRSsM3ncZkf/6nf74oTzNfnAo1WxpGDhcAy0Fs=
X-Received: by 2002:a17:906:d297:b0:a77:9d57:97ad with SMTP id
 a640c23a62f3a-a7a011cbfa5mr48554866b.40.1721197191549; Tue, 16 Jul 2024
 23:19:51 -0700 (PDT)
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
 <CAHVXubh00OyazGP2C6sg0N2=kWqV-HXpzEiZCDdex8hcmLEM2g@mail.gmail.com> <CAJF2gTRpXBS-YotgEO=cPGnwjYiUyda_wk_fQfA6j_QqdYHoQw@mail.gmail.com>
In-Reply-To: <CAJF2gTRpXBS-YotgEO=cPGnwjYiUyda_wk_fQfA6j_QqdYHoQw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 17 Jul 2024 08:19:40 +0200
Message-ID: <CAHVXubia24OTad=NGAjcvYpPqJFutyZCy7KCH09R_=R3PAEanA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
To: Guo Ren <guoren@kernel.org>
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

On Tue, Jul 16, 2024 at 10:31=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Jul 16, 2024 at 2:43=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Guo, Waiman,
> >
> > On Tue, Jul 16, 2024 at 3:05=E2=80=AFAM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > On Tue, Jul 16, 2024 at 3:30=E2=80=AFAM Waiman Long <longman@redhat.c=
om> wrote:
> > > >
> > > > On 7/15/24 03:27, Alexandre Ghiti wrote:
> > > > > Hi Guo,
> > > > >
> > > > > On Sun, Jul 7, 2024 at 4:20=E2=80=AFAM Guo Ren <guoren@kernel.org=
> wrote:
> > > > >> On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghi=
ti@rivosinc.com> wrote:
> > > > >>> In order to produce a generic kernel, a user can select
> > > > >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ti=
cket
> > > > >>> spinlock implementation if Zabha is not present.
> > > > >>>
> > > > >>> Note that we can't use alternatives here because the discovery =
of
> > > > >>> extensions is done too late and we need to start with the qspin=
lock
> > > > >> That's not true; we treat spinlock as qspinlock at first.
> > > > > That's what I said: we have to use the qspinlock implementation a=
t
> > > > > first *because* we can't discover the extensions soon enough to u=
se
> > > > > the right spinlock implementation before the kernel uses a spinlo=
ck.
> > > > > And since the spinlocks are used *before* the discovery of the
> > > > > extensions, we cannot use the current alternative mechanism or we=
'd
> > > > > need to extend it to add an "initial" value which does not depend=
 on
> > > > > the available extensions.
> > > >
> > > > With qspinlock, the lock remains zero after a lock/unlock sequence.=
 That
> > > > is not the case with ticket lock. Assuming that all the discovery w=
ill
> > > > be done before SMP boot, the qspinlock slowpath won't be activated =
and
> > > > so we don't need the presence of any extension. I believe that is t=
he
> > > > main reason why qspinlock is used as the initial default and not ti=
cket
> > > > lock.
> > > Thx Waiman,
> > > Yes, qspinlock is a clean guy, but ticket lock is a dirty one.
> >
> > Guys, we all agree on that, that's why I kept this behaviour in this pa=
tchset.
> >
> > >
> > > Hi Alexandre,
> > > Therefore, the switch point(before reset_init()) is late enough to
> > > change the lock mechanism, and this satisfies the requirements of
> > > apply_boot_alternatives(), apply_early_boot_alternatives(), and
> > > apply_module_alternatives().
> >
> > I can't find reset_init().
> Sorry for the typo, rest_init()
> >
> > The discovery of the extensions is done in riscv_fill_hwcap() called
> > from setup_arch()
> > https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.=
c#L288.
> > So *before* this point, we have no knowledge of the available
> > extensions on the platform.  Let's imagine now that we use an
> > alternative for the qspinlock implementation, it will look like this
> > (I use only zabha here, that's an example):
> >
> > --- a/arch/riscv/include/asm/spinlock.h
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -16,8 +16,12 @@ DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> >  #define SPINLOCK_BASE_DECLARE(op, type, type_lock)                    =
 \
> >  static __always_inline type arch_spin_##op(type_lock lock)            =
 \
> >  {                                                                     =
 \
> > -       if (static_branch_unlikely(&qspinlock_key))                    =
 \
> > -               return queued_spin_##op(lock);                         =
 \
> > +       asm goto(ALTERNATIVE("j %[no_zabha]", "nop", 0,                =
 \
> > +                                     RISCV_ISA_EXT_ZABHA, 1)          =
  \
> > +                         : : : : no_zabha);                           =
 \
> > +                                                                      =
 \
> > +       return queued_spin_##op(lock);                                 =
 \
> > +no_zabha:                                                             =
 \
> >         return ticket_spin_##op(lock);                                 =
 \
> >  }
> >
> > apply_early_boot_alternatives() can't be used to patch the above
> > alternative since it is called from setup_vm(), way before we know the
> > available extensions.
> > apply_boot_alternatives(), instead, is called after riscv_fill_hwcap()
> > and then will be able to patch the alternatives correctly
> > https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.=
c#L290.
> >
> > But then, before apply_boot_alternatives(), any use of a spinlock
> > (printk does so) will use a ticket spinlock implementation, and not
> > the qspinlock implementation. How do you fix that?
> Why "before apply_boot_alternatives(), any use of a spinlock (printk
> does so) will use a ticket spinlock implementation" ?
> We treat qspinlock as the initial spinlock forever, so there is only
> qspinlock -> ticket_lock direction and no reverse.

Can you please provide an implementation of what you suggest using the
current alternatives tools? I'm about to send the v3 of this series,
you can use this as a base.

Thanks,

Alex

>
> >
> > >
> > > >
> > > > Cheers,
> > > > Longman
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

