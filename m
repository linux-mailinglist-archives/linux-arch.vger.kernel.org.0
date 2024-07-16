Return-Path: <linux-arch+bounces-5403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871E932081
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AABB2195F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC651CD29;
	Tue, 16 Jul 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mduuE7GG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7C1CA8A
	for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112198; cv=none; b=J0EONbu9Ac2CqZTZb8Mi2FL/BQpiiSkSGOpuyMiuREF84mnw9oBv6aNSM5sYFJj8qTKkilDeGOUcuRMp/7qShsc3U7hnqXsX9KLsG7H2hAlZtMb6pLnmcavXods0q8JRp8vdSwM4A5vUgiaSmxZ/Eo5tZb7a2WLxbZaAcNCMDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112198; c=relaxed/simple;
	bh=cX22zFtwRimUJm86XkOeZW6MomrWL+u3D25yx7dtpx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Liv6A+C7jUacndnLpHd0FnMqYah/E9yHtmRCUpXW+rFo+L+Ozulk62qKQkCxcq0+ztR4dUEY2fMlQ9K5OrEJx3Iu+ggDO8W1ZDC+7uC4mpGysZm74DYJ37ISZPZaFZ408qThlLY//57zQXCl49foPqMOoJ3zaFU9jg/ksKOfoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mduuE7GG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c080b521so550359666b.3
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721112194; x=1721716994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCRSoAuECKcouO/voz6zEzYgSUjC3FMdxbyfDTdU7og=;
        b=mduuE7GGAjVzi3bl1ujtG7kPW1V32jLVMMytoJFuMyyRn5WP1Lg0uPv0pZZBMgMyFI
         VI5MiFafzskKFKJG6tXWgAu2aW3nUtLiwfzi7qB/ivvof6jQQkV8JGjk8PjgcCDxvomU
         s9S4cUyE/p2Tg/1+wJNvY3nbuljE7E+7mNA6JRQEj0MF46+hzf0XUL8pCZR9LdAXBIMc
         uoSh1+rZuG6Da3ZPqmdiL9SP2U60VcQ0jnTlhRUUWfXRHnYMpguGQSZayr9bCIVvQL8L
         jBcq0jEPcaUvJFSP18ZRjr+DbjZC/AH/K7SItf7SfR0OB8Hc0O7FQ/hmE37OGDi7BRpU
         nnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721112194; x=1721716994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCRSoAuECKcouO/voz6zEzYgSUjC3FMdxbyfDTdU7og=;
        b=KLAyAyYDKU9qqAzcMJJir7LbDGrHS4MJpfkV4gcx6myRN4g1/+cr0STL0dVgszLtzY
         D3mxqjikUR7eMWR11965xB4lw59+MOukpbKL+5BaWHg3VRet7STksUhIYUnKI8+JbuZC
         VhZ4tjZIfLIpRIvO5FkjCxgyhKBzUPKS4ZC0CpB7tMHeIMz1vU1sXhJ4Ks4G37BP/vny
         aNNpfa7kF4KPMfgf0Grf0f73k6g+U2DnDFaHxd914ctRpdKmABTfGW+E/v29pHzOlPrh
         RiYCRoOs/mVn5w6buqXO+pwZccOOcDe79AOTywierYBjxpYGjTjhSULql/7bhg5J6uoS
         2HKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7l6TFFYuY4Eo/hKWxHK02f6MfuGIGF79iPGi0tcgjsoOnxOFvlqmQGNHGuqiCO8zVc4OiBHKCHtU6Oc4EEyPC1ckaPqdXPEmFPw==
X-Gm-Message-State: AOJu0Yz7r3FCuGX1Z0Tvf++T4Xf2fKHtHXvOTtOV4SNGDgE8eyBXYvki
	v4CxgVEMF8CXsxNuY+2KHb8zWiybPynPL0KNZKzfEb7Bd4TsLdhGijvSnosPA7fFnA2OAfALmfl
	oI34YT6V6zCYYLDBGg35vlGvi3AcAs7KQDowh4A==
X-Google-Smtp-Source: AGHT+IGqVByFr0luOwoskb/AgZKNB8jHzqqvJMaLn4zx34p82HWK9+YsdjHaH5Pd8zOz5r4AWhXGqXuvh7iA0eU4fIA=
X-Received: by 2002:a17:906:c784:b0:a72:676a:7d7b with SMTP id
 a640c23a62f3a-a79ea3da90fmr69418966b.9.1721112194052; Mon, 15 Jul 2024
 23:43:14 -0700 (PDT)
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
In-Reply-To: <CAJF2gTRrZwVk2xyhF_PsJGKCfkvun-rifG8MjDBcGDt3YBuhPg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 16 Jul 2024 08:43:02 +0200
Message-ID: <CAHVXubh00OyazGP2C6sg0N2=kWqV-HXpzEiZCDdex8hcmLEM2g@mail.gmail.com>
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

Hi Guo, Waiman,

On Tue, Jul 16, 2024 at 3:05=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Jul 16, 2024 at 3:30=E2=80=AFAM Waiman Long <longman@redhat.com> =
wrote:
> >
> > On 7/15/24 03:27, Alexandre Ghiti wrote:
> > > Hi Guo,
> > >
> > > On Sun, Jul 7, 2024 at 4:20=E2=80=AFAM Guo Ren <guoren@kernel.org> wr=
ote:
> > >> On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > >>> In order to produce a generic kernel, a user can select
> > >>> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > >>> spinlock implementation if Zabha is not present.
> > >>>
> > >>> Note that we can't use alternatives here because the discovery of
> > >>> extensions is done too late and we need to start with the qspinlock
> > >> That's not true; we treat spinlock as qspinlock at first.
> > > That's what I said: we have to use the qspinlock implementation at
> > > first *because* we can't discover the extensions soon enough to use
> > > the right spinlock implementation before the kernel uses a spinlock.
> > > And since the spinlocks are used *before* the discovery of the
> > > extensions, we cannot use the current alternative mechanism or we'd
> > > need to extend it to add an "initial" value which does not depend on
> > > the available extensions.
> >
> > With qspinlock, the lock remains zero after a lock/unlock sequence. Tha=
t
> > is not the case with ticket lock. Assuming that all the discovery will
> > be done before SMP boot, the qspinlock slowpath won't be activated and
> > so we don't need the presence of any extension. I believe that is the
> > main reason why qspinlock is used as the initial default and not ticket
> > lock.
> Thx Waiman,
> Yes, qspinlock is a clean guy, but ticket lock is a dirty one.

Guys, we all agree on that, that's why I kept this behaviour in this patchs=
et.

>
> Hi Alexandre,
> Therefore, the switch point(before reset_init()) is late enough to
> change the lock mechanism, and this satisfies the requirements of
> apply_boot_alternatives(), apply_early_boot_alternatives(), and
> apply_module_alternatives().

I can't find reset_init().

The discovery of the extensions is done in riscv_fill_hwcap() called
from setup_arch()
https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.c#L2=
88.
So *before* this point, we have no knowledge of the available
extensions on the platform.  Let's imagine now that we use an
alternative for the qspinlock implementation, it will look like this
(I use only zabha here, that's an example):

--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -16,8 +16,12 @@ DECLARE_STATIC_KEY_TRUE(qspinlock_key);
 #define SPINLOCK_BASE_DECLARE(op, type, type_lock)                     \
 static __always_inline type arch_spin_##op(type_lock lock)             \
 {                                                                      \
-       if (static_branch_unlikely(&qspinlock_key))                     \
-               return queued_spin_##op(lock);                          \
+       asm goto(ALTERNATIVE("j %[no_zabha]", "nop", 0,                 \
+                                     RISCV_ISA_EXT_ZABHA, 1)            \
+                         : : : : no_zabha);                            \
+                                                                       \
+       return queued_spin_##op(lock);                                  \
+no_zabha:                                                              \
        return ticket_spin_##op(lock);                                  \
 }

apply_early_boot_alternatives() can't be used to patch the above
alternative since it is called from setup_vm(), way before we know the
available extensions.
apply_boot_alternatives(), instead, is called after riscv_fill_hwcap()
and then will be able to patch the alternatives correctly
https://elixir.bootlin.com/linux/latest/source/arch/riscv/kernel/setup.c#L2=
90.

But then, before apply_boot_alternatives(), any use of a spinlock
(printk does so) will use a ticket spinlock implementation, and not
the qspinlock implementation. How do you fix that?

>
> >
> > Cheers,
> > Longman
> >
>
>
> --
> Best Regards
>  Guo Ren

