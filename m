Return-Path: <linux-arch+bounces-9029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 982409C4C07
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 02:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8E1F21A47
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F35202F77;
	Tue, 12 Nov 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDxDDeN4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AD487A5;
	Tue, 12 Nov 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376169; cv=none; b=frmXxk9oOJP895MY4sFXc9hqqseHCYbqaXQcfktewh5wFUy6SnX4G7maXvPU2J6gD3yGNoblL4YkMCxsS0bwpoAJDqGIkiEEzhMKG7dx0EIzUkHc7qj1KSqjfwk31dmlryDn9l3fepeCSk0t0i/n5ZlAMZ8BVMPQ2hnKEjy7L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376169; c=relaxed/simple;
	bh=ByKIsg+PetC3KQaRoDtbKrjNkQjVD4fuhk6Vg3U7JJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBWT3oxQmx8oAY+mdZ5EnTHiUwgtI3lBe68N41SmY646t27Tv6n3WUAM37rY37huBu+7k56PdSxDBQxPMApLcln0m86buodIYTzf7OtbE6rKnjPTkBKl36blnzvqRiRX2mK1iwwAwQ0KfvDA5FkJHfUY4c9INrGXgMHc6tKLSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDxDDeN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3348EC4CED9;
	Tue, 12 Nov 2024 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731376169;
	bh=ByKIsg+PetC3KQaRoDtbKrjNkQjVD4fuhk6Vg3U7JJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DDxDDeN4mEvU6Kc2yLJX8rrfify0h0aWcVNfF1CMLSZWHg34z2y+fxEbDGf/4bEXj
	 KqYjJV6P/Q+8CuscNdNFoZqtHu63aLwUhcC+gyseaOQxKZ+oKpi3dTAUK/eXZGbCdw
	 bKONFMn05p3OtcZQhf/5KQXvIKX2KJxygw73nT9qTqez2IpU4un7e13pTJwu98HZmI
	 1Vnq1RAqSljFewaHJJwCX0tvMEW7zJXSPvPVDxSgnQCiVmCBU7+lR5INEwNnV3GM6g
	 KAMG3LxRUTKWsiSD65eRqC911CJm/ESAZUtLSxzL3g6lw871/NKD65r+EAnuBUbqm4
	 VP0NTHOLnm4OA==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso3798957f8f.1;
        Mon, 11 Nov 2024 17:49:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJzpMwEq31U2c2jC8mh1drCHjNGCuhbyWe+WLnm09oob1DlXDEXjVu1wlQzqITCWIpqmfDGQhGC5Ih@vger.kernel.org, AJvYcCVvGmKihp4puTq6Xnr+93ADkBYoMnYjU3TP5BodGInKZaajtKGfOZq4H/l9engnbn2JBrJ4AcAdwS8bCg==@vger.kernel.org, AJvYcCW99RezUVDysU/zCL9EwjYWNhcgjyvoYbXfAi6xQwkCcwZqQBM7immxQrlukE95CN5Xq1uAGjLwDzxx@vger.kernel.org, AJvYcCXzQvuX4hZ28HZDelqp80Xb+/gD3CrLRtwhON54mWD7e45e15jUYXFUHCZNZFqolKCtaNgrcOsPEPIx/MDa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97v3kFRXu/Byu2n127UEz+5lFizp6QAUqoZ6rM9RBgUZT+V0P
	mxHqKE8dr0IYXYSZzclJ/gIISL02ztxWDFfolus2jp5ZmJlvMx/M5DgapfkBz/J3dU4p51A3XSr
	WeXfAiNBT7P3VFPAMb5rcQgg+jcQ=
X-Google-Smtp-Source: AGHT+IHkAppdGB9GR9FwSzrOwP4MyzWExRQCh4+xsHRQeI1xYcQFKz01kJl5kYDubLhJev1P+/wAGQeEYzYwz9A8wSk=
X-Received: by 2002:a5d:6d0c:0:b0:37d:4657:ea7d with SMTP id
 ffacd0b85a97d-381f1835301mr12111736f8f.49.1731376167620; Mon, 11 Nov 2024
 17:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com> <20241111164259.GA20042@willie-the-truck>
In-Reply-To: <20241111164259.GA20042@willie-the-truck>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 12 Nov 2024 09:49:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTuvmtmKVFMZCTMxEWHrpSpqPE8QO4MC5njPAskGEmpig@mail.gmail.com>
Message-ID: <CAJF2gTTuvmtmKVFMZCTMxEWHrpSpqPE8QO4MC5njPAskGEmpig@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
To: Will Deacon <will@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:43=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > In order to produce a generic kernel, a user can select
> > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha or Ziccrse are not present.
> >
> > Note that we can't use alternatives here because the discovery of
> > extensions is done too late and we need to start with the qspinlock
> > implementation because the ticket spinlock implementation would pollute
> > the spinlock value, so let's use static keys.
>
> I think the static key toggling takes a mutex (jump_label_lock()) which
> can take a spinlock (lock->wait_lock) internally, so I don't grok how
> this works:
>
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
>
> i.e. we've potentially already used the qspinlock at this point.
Yes, I've used qspinlock here. But riscv_spinlock_init is called with
irq_disabled and smp_off. That means this qspinlock only performs a
test-set lock behavior by qspinlock fast-path.

The qspinlock is a clean implementation. After qspin_unlock, the lock
value remains at zero, but the ticket lock makes the value dirty. So
we use Qspinlock at first or change it to ticket-lock before irq & smp
up.

>
> Will



--=20
Best Regards
 Guo Ren

