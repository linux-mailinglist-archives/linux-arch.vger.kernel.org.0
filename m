Return-Path: <linux-arch+bounces-4640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F018D6E68
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 08:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F4EB26B29
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964113ACC;
	Sat,  1 Jun 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3l21jx6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B569134BC;
	Sat,  1 Jun 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222724; cv=none; b=Yqngz9KLYlkvjr7uZCWW/rPegnwEnSQ050CezQ7oH4toToP1nR1e16Tnd8ZbI3cci51ht0x4bn13trDA5j+ZN4DrCqwTWwX62tCkOlv49/1P5W2lN39MUlgM0ijVACTn/Ft+Fql3YLk6NN7kc4Pv1wabVEPEReOPm67q1Jrkofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222724; c=relaxed/simple;
	bh=qv/TpTCLIjAt2eWLAMdx+nkTx3R9H3xNd5p/PM0KR/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0vohHBlIUnbimfzeCKVv+lJfd0xavFKPQPuwCm+ivb5T/xoo8IJsZ6UlN8/gHmaX5dcQXGxy3QXwWhQf6ne/+rIlTpejm4INb03MoTDcPTfGkVuhJaHHgahzFgqJv1yOrDy0a0fzwhNm0mERhse4S0ZaFXIa8izneQ/hvyLxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3l21jx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC514C4AF11;
	Sat,  1 Jun 2024 06:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717222723;
	bh=qv/TpTCLIjAt2eWLAMdx+nkTx3R9H3xNd5p/PM0KR/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3l21jx6DRIWYURgryuGOT3ad9rDOO3VpyZ+i7KLuV3CcXvTubeGccG9yaHbBfJpY
	 LsrboZ2sQWcX9Ec/3B69HuI2DM9AN2sbX2oU2rv+UPKctEENjsZN3ASah5wZia7ZK3
	 RNc651eTlMdCQiTtGD9ElY2qefzF2jz335808HGpaAPQZDz9k6TXGPKefYGoTbxyvg
	 l0IAo0pij8zWp3qwUG62akh6IMydtrt0QifAulzwqW5jbbYmLZfoENjqQ7JyCHmInL
	 jznE2vMfiu0ThzP5s4rWrOEo4GqI3tS5wfe6DIgNbuelsCyxK0vo7pd/AyLGoiISdF
	 o0D+603L2oJlw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a653972487fso228595366b.1;
        Fri, 31 May 2024 23:18:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmfREBp6USUf3OnTP63Gx95HISStyRzVj8AY6KotvZpuXgFZf3nW7yWNR5aBIMWDb8RVmih7ArtGxC8cS06GAifyQZpkwr6LA0nixNJw6KGX/9bruaYwfYwulkLSzQf/q97ZgCXErIUKWh2EkGHcPiSPoojRFy6qu+472yM4892xupPw==
X-Gm-Message-State: AOJu0YytL21p8ZuEH/VB0HE6rMYkLcaMNzgIIWzeWwxSCfdEJox1hcp+
	2l2tzEehhLZ4kGUrcSDpzne8jpN7qy9rV7NbXCUa6LFVJCaF0i/x3KfeRZFCjRj9t82ZsdRKmLt
	egIlezFRPXcvy9+MtzyW5zzRIor4=
X-Google-Smtp-Source: AGHT+IEA4/ILSczbK0xOrDgN8sjL32cYwfghwWG8IasCH/Si+Iwy3qd1z6J8H3j9DILXwkN3hkhqqm3H1a7TEeNrKmU=
X-Received: by 2002:a17:906:4114:b0:a68:b6c7:516b with SMTP id
 a640c23a62f3a-a68b6c75209mr37608866b.73.1717222722373; Fri, 31 May 2024
 23:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <ZlZ8/Nv3QS99AgY9@andrea>
 <39a9b28c-2792-45ce-a8c6-1703cab0f2de@ghiti.fr> <ZlnyKclZOQdrJTtU@andrea>
In-Reply-To: <ZlnyKclZOQdrJTtU@andrea>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 1 Jun 2024 14:18:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTz2H5McxgsrEcMeCNMnchS6sr3vRn53J=FWk_6HPoP6A@mail.gmail.com>
Message-ID: <CAJF2gTTz2H5McxgsrEcMeCNMnchS6sr3vRn53J=FWk_6HPoP6A@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:52=E2=80=AFPM Andrea Parri <parri.andrea@gmail.c=
om> wrote:
>
> > > > + select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> > > IIUC, we should make sure qspinlocks run with ARCH_WEAK_RELEASE_ACQUI=
RE,
> > > perhaps a similar select for the latter?  (not a kconfig expert)
> >
> >
> > Where did you see this dependency? And if that is really a dependency o=
f
> > qspinlocks, shouldn't this be under CONFIG_QUEUED_SPINLOCKS? (not a Kco=
nfig
> > expert too).
>
> The comment on smp_mb__after_unlock_lock() in include/linux/rcupdate.h
> (the barrier is currently only used by the RCU subsystem) recalls:
>
>   /*
>    * Place this after a lock-acquisition primitive to guarantee that
>    * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
>    * if the UNLOCK and LOCK are executed by the same CPU or if the
>    * UNLOCK and LOCK operate on the same lock variable.
>    */
>   #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE
>   #define smp_mb__after_unlock_lock()   smp_mb()  /* Full ordering for lo=
ck. */
>   #else /* #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>   #define smp_mb__after_unlock_lock()   do { } while (0)
>   #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>
> Architectures whose UNLOCK+LOCK implementation does not (already) meet
> the required "full barrier" ordering property (currently, only powerpc)
> can overwrite the "default"/common #define for this barrier (NOP) and
> meet the ordering by opting in for ARCH_WEAK_RELEASE_ACQUIRE.
>
> The (current) "generic" ticket lock implementation provides "the full
> barrier" in its LOCK operations (hence in part. in UNLOCK+LOCK), cf.
>
>   arch_spin_trylock() -> atomic_try_cmpxchg()
>   arch_spin_lock() -> atomic_fetch_add()
>                    -> atomic_cond_read_acquire(); smp_mb()
>
> but the "UNLOCK+LOCK pairs act as a full barrier" property doesn't hold
> true for riscv (and powerpc) when switching over to queued spinlock.
Yes.

> OTOH, I see no particular reason for other "users" of queued spinlocks
> (notably, x86 and arm64) for selecting ARCH_WEAK_RELEASE_ACQUIRE.
I looked at the riscv-unprivileged ppo section, seems RISC-V .rl ->
.aq has RCsc annotations.
ref:
Explicit Synchronization
 5. has an acquire annotation
 6. has a release annotation
 7. a and b both have RCsc annotations

And for qspinlock:
unlock:
        smp_store_release(&lock->locked, 0);

lock:
        if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_V=
AL)))

If the hardware has Store-Release and CAS instructions, they all obey
Explicit Synchronization rules. Then RISC-V "UNLOCK+LOCK" pairs act as
a full barrier, right?

>
> But does this address your concern?  Let me know if I misunderstood it.
>
>   Andrea



--=20
Best Regards
 Guo Ren

