Return-Path: <linux-arch+bounces-5401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE2931E40
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 03:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7861F21FEE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2CAD48;
	Tue, 16 Jul 2024 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToyINu31"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE8AD24;
	Tue, 16 Jul 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091905; cv=none; b=Xp40ndxZrH3FNxQLkWAAwSoQv4DXcYK6a5wvVD3mftQGkEos8bw75C59OU00MCX/hblKJqSGlDa3pk6ZvDEpGs03nn/GejNu5h2/Sm8iNZ/sbzy92Zz8fFqiavI6mkiB+6PEsG9zADbP1M475nX00NC+dJWywNNyPHohR+FxzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091905; c=relaxed/simple;
	bh=QG29vkIJ/KvY/97Bru3A84cybIUnamlVoJnN1kflOmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gat1JSeWJMNyVgZJJP0NKoorwJHhciKRRoeTJGtpOttT1aLO+2MgYBW7GG/SCayCo9UYd5cziUToW53Nc78E7+CkV0JU9s32kUPOWtNfGdvpSKyZaqaqk5TIGcKoZCjpIBUkjIeRGY3icnOmK8yKAOaet+Z+vjJjA8JczotbbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToyINu31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53982C4AF0B;
	Tue, 16 Jul 2024 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091905;
	bh=QG29vkIJ/KvY/97Bru3A84cybIUnamlVoJnN1kflOmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ToyINu31o0mwiMTvB5jB7n0JqZmTDkbSgm3t3bwVwzYP75J65cEK6v6oyb8tYVOhv
	 v283nYUQlfOOu5dkmJkSXA7x3GfOcAgcUwSZ23oscxwuTlMrDQv9GuHJ9AuZDnkjU3
	 KGEZWRS6uz9S2DA8GajHIs6NU9sefPICsgdx2qDIbes6U6ElBomuJN3h+6C0pwpDmx
	 abIAgm1tiGWHam/Y9EjCnlpXRq5alYhZmF4YpzXbnIkpfqe18YXG0uxRhfKfoIz+qJ
	 Brbx0sk7a7jc2ovVW4SEzYnEvoOaLtrMtixOVW1ayPOwJnQ7UnVjRjO8mfbe4KjanQ
	 Ei/CYG98ITPjw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so66159281fa.3;
        Mon, 15 Jul 2024 18:05:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKcym/LGhXmcssf/ceKZ7NWc59TOS+A321xZJpD/ZOzICcYpdEHVgWwPvYVkm2NtqXmkQsYuTITfOQJBvRbtehNHibRk5QUmhU7YLZ3lh4YxyaN2opC1i7Mrmb6OqHL0lv/Ho3y0jta1opkKRYE4cO0wK2AnLILdBb5ZWZe7nj4uu7DA==
X-Gm-Message-State: AOJu0YxUXds6735nTgt9PB/5ot5W5pEE6qZgQaAf5q8yvMtQzogiXozI
	eb/K8W87KDZ8CNDe9Qq3MTOKWcHo5QXteuofT1x/F+W2vrpT/dNIkypYfZvTpjnmmXVLe2QLlWa
	zmthnOVEIOAZaxOtI/u19NrK8ZhQ=
X-Google-Smtp-Source: AGHT+IEN6H27w2IkU8okfWfdkHSr98KLu1OkcEMwEZm2647siY5rx5myWRTdnfrOyys1KrSYGu4NevvkqFvZHj/70C0=
X-Received: by 2002:a05:6512:138c:b0:52e:9b92:4990 with SMTP id
 2adb3069b0e04-52edf0192ffmr286040e87.32.1721091903625; Mon, 15 Jul 2024
 18:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-11-alexghiti@rivosinc.com> <CAJF2gTSG7HzV7mgZpkWLbSBNn2dRv_NaSmCimd+kRdU=EZrmmg@mail.gmail.com>
 <CAHVXubizLq=qZgVQ2vBFe5zVuLRP0DGw=UN4U_Wkx2P2xsP3Mw@mail.gmail.com> <a096151c-c349-455f-8939-3b739d73f016@redhat.com>
In-Reply-To: <a096151c-c349-455f-8939-3b739d73f016@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Jul 2024 09:04:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRrZwVk2xyhF_PsJGKCfkvun-rifG8MjDBcGDt3YBuhPg@mail.gmail.com>
Message-ID: <CAJF2gTRrZwVk2xyhF_PsJGKCfkvun-rifG8MjDBcGDt3YBuhPg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
To: Waiman Long <longman@redhat.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:30=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 7/15/24 03:27, Alexandre Ghiti wrote:
> > Hi Guo,
> >
> > On Sun, Jul 7, 2024 at 4:20=E2=80=AFAM Guo Ren <guoren@kernel.org> wrot=
e:
> >> On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> >>> In order to produce a generic kernel, a user can select
> >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> >>> spinlock implementation if Zabha is not present.
> >>>
> >>> Note that we can't use alternatives here because the discovery of
> >>> extensions is done too late and we need to start with the qspinlock
> >> That's not true; we treat spinlock as qspinlock at first.
> > That's what I said: we have to use the qspinlock implementation at
> > first *because* we can't discover the extensions soon enough to use
> > the right spinlock implementation before the kernel uses a spinlock.
> > And since the spinlocks are used *before* the discovery of the
> > extensions, we cannot use the current alternative mechanism or we'd
> > need to extend it to add an "initial" value which does not depend on
> > the available extensions.
>
> With qspinlock, the lock remains zero after a lock/unlock sequence. That
> is not the case with ticket lock. Assuming that all the discovery will
> be done before SMP boot, the qspinlock slowpath won't be activated and
> so we don't need the presence of any extension. I believe that is the
> main reason why qspinlock is used as the initial default and not ticket
> lock.
Thx Waiman,
Yes, qspinlock is a clean guy, but ticket lock is a dirty one.

Hi Alexandre,
Therefore, the switch point(before reset_init()) is late enough to
change the lock mechanism, and this satisfies the requirements of
apply_boot_alternatives(), apply_early_boot_alternatives(), and
apply_module_alternatives().

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren

