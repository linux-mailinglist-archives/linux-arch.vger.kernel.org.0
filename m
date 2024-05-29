Return-Path: <linux-arch+bounces-4576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388968D363A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD5F28715A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B0180A91;
	Wed, 29 May 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="12nXlH7B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758CE17F371
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985248; cv=none; b=rqBUmTqZCZuQswXhYrhpq7GlZVneEnzOIBoyoa3UYYFq10+se1Jyw+aX8k90fvJ6zepReJ4Ik3M0HduYcgrEsADNayksC9zxUQfLinIqa1tqT4S6HNC5K1uZ7UAHTmVmDIoBznhyJqtPrOc/YOsQubwx2TdiFGb2vpYNc5scEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985248; c=relaxed/simple;
	bh=xO5fp7uBa3XCH/X+NfgCayeQBNhqWpmgs+2sqk4vjf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwU890Y2uDcgrdUErV3lEPbjTzQdvH4FHxybMH+FOprN1t0n3M5PcupSd8IKFjGEGWED2uzI56rz9i4kP15FHNGxNFY7xHkKnzXmKqjuq9mUdmQAksCLbsgXSbUC5QMqLBiVgrpiYevVWx56ItfLN85pm1ckn9X3ybmZMoY61Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=12nXlH7B; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a62db0c8c9cso219035666b.2
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716985245; x=1717590045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyH5HBgVMHtwGihnpxCP6snZm//fPikPnLspFypYdbE=;
        b=12nXlH7Bo3OrSn6yxeSqOSXdgebMmUrAa4XyzPp5Es1oPhwY5ZvZgrZWufKb1X/Iul
         tyMygbId8NXTfhJMMyjp1BQbAXsEypW0XdbgHbVFB6v3WWvsvdo/gyyNHRofXvfACdrT
         +z2VpvGTRtTMi6NolIb+FPBBVtw76p5XaZ+pADzZbs65un1LfieKVvNyqCi5c6sTRnTZ
         yfvoaVDGBnc3Dl1RdPDt4xvW003ziyL3Ek/2zstZSPEPUoElV4SrbMUieIfPNRYZ/vqe
         ZTz7NyhkU3lXsQM9xb+gByAAp3M8P0HelsuOnF5+p/3Ci2dEkLPYIZKRk0WR0T3tJYm0
         RqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985245; x=1717590045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyH5HBgVMHtwGihnpxCP6snZm//fPikPnLspFypYdbE=;
        b=qGot4TxrgiCZGTmOAYZN3s0zgx4rQw6eDpsB5u91AoZT5Qt23WMgXfdklmheTsexhn
         NIsyaxj5qWODXrqX159JOQGQGLrSoChy1gbdE/8K/e3DNvaEGFpkvwURW+TMZaSpsy6M
         zdeeWmMGQbiQKzJCGgFy4TND/lDvTqbRUsqfRnLodWnyBj9J0RxgRH8dTUPEObZbWQKA
         Kj1zEMeBY3qC3lr0C3mRwYwp/LmOaKzUaxmtcZV6b0X978dvEbE0M272jK3KVeE9n6iD
         mSNkcdcO8DFjuWT37rKUFtMqhHvF9L/NdSpFsi8yATAKa4R4RCaBrBcczt4thnjI8bS0
         /44w==
X-Forwarded-Encrypted: i=1; AJvYcCVhpqkxX/HWGeIjRaTI55jTVQwsZwFzQumC0PEUn9/qZcnqgLdrtUxBEwh5JROU04YA8vIRU72edr7W6KVkIgo1IMC11afuwvfW5w==
X-Gm-Message-State: AOJu0Yzh6Fj+rb+flapgH8aOupLNQpEYZTwHtUphEjZplCXTnW+B5gCW
	j7s3n+1mPb2g2ucsXjIlGLuNFQPgeRsuNdIbi4Rtjjghb7V25qSJMwNL+roU9CPMfiiulR3miX5
	W6DV7B0B/+q5ayUJH+W2gAqoa3k2zADcwzGDwiw==
X-Google-Smtp-Source: AGHT+IFC/KMs8gmNj6Vvn/KGAlKw45g7h3EXyl2Z0Axc2c+Mm6KjfYRkin/T4F2URBRtFg5oeh4RMhucp9mDS+H/nTM=
X-Received: by 2002:a17:906:66c7:b0:a59:ba2b:5915 with SMTP id
 a640c23a62f3a-a6265119463mr1826137066b.50.1716985244596; Wed, 29 May 2024
 05:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-2-alexghiti@rivosinc.com> <20240528-repaint-graffiti-ec4f0e038e5a@spud>
In-Reply-To: <20240528-repaint-graffiti-ec4f0e038e5a@spud>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:20:33 +0200
Message-ID: <CAHVXubjk-2EAJ0U08p7uATkJM1_La94SVcVNLO5yieGbfqUGYw@mail.gmail.com>
Subject: Re: [PATCH 1/7] riscv: Implement cmpxchg32/64() using Zacas
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tue, May 28, 2024 at 5:34=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, May 28, 2024 at 05:10:46PM +0200, Alexandre Ghiti wrote:
> > This adds runtime support for Zacas in cmpxchg operations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig               | 17 +++++++++++++++++
> >  arch/riscv/Makefile              | 11 +++++++++++
> >  arch/riscv/include/asm/cmpxchg.h | 23 ++++++++++++++++++++---
> >  3 files changed, 48 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 8a0f403432e8..b443def70139 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -579,6 +579,23 @@ config RISCV_ISA_V_PREEMPTIVE
> >         preemption. Enabling this config will result in higher memory
> >         consumption due to the allocation of per-task's kernel Vector c=
ontext.
> >
> > +config TOOLCHAIN_HAS_ZACAS
> > +     bool
> > +     default y
> > +     depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_za=
cas)
> > +     depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_z=
acas)
> > +     depends on AS_HAS_OPTION_ARCH
> > +
> > +config RISCV_ISA_ZACAS
> > +     bool "Zacas extension support for atomic CAS"
> > +     depends on TOOLCHAIN_HAS_ZACAS
> > +     default y
> > +     help
> > +       Adds support to use atomic CAS instead of LR/SC to implement ke=
rnel
> > +       atomic cmpxchg operation.
>
> If you were a person compiling a kernel, would you be able to read this
> and realise that this is safe to enable when their system does not
> support atomic CAS? Please take a look at other how other extensions
> handle this, or the patch that I have been sending that tries to make
> things clearer:
> https://patchwork.kernel.org/project/linux-riscv/patch/20240528-varnish-s=
tatus-9c22973093a0@spud/

Ok, I will go for: "Enable the use of the Zacas ISA-extension to
implement atomic cmpxchg operations when it is detected at boot."
And I will do the same for Zabha.

>
> > +
> > +       If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZBB
> >       bool
> >       default y
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 5b3115a19852..d5b60b87998c 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -78,6 +78,17 @@ endif
> >  # Check if the toolchain supports Zihintpause extension
> >  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) :=3D $(riscv-march-y)_=
zihintpause
> >
> > +# Check if the toolchain supports Zacas
> > +ifdef CONFIG_AS_IS_LLVM
> > +# Support for experimental Zacas was merged in LLVM 17, but the remova=
l of
> > +# the "experimental" was merged in LLVM 19.
> > +KBUILD_CFLAGS +=3D -menable-experimental-extensions
> > +KBUILD_AFLAGS +=3D -menable-experimental-extensions
> > +riscv-march-y :=3D $(riscv-march-y)_zacas1p0
> > +else
> > +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv-march-y)_zacas
> > +endif
>
> I'm almost certain that we discussed this before for vector and it was
> decided to not enable experimental extensions (particularly as it is a
> global option), and instead require the non-experimental versions.
> This isn't even consistent with your TOOLCHAIN_HAS_ZACAS checks, that
> will only enable the option for the ratified version.

Zacas was ratified, hence the removal of "experimental" in LLVM 19.
But unfortunately Zabha lacks such changes in LLVM, so that will make
this inconsistent (ratified extension but still experimental).

I'll remove the enablement of the experimental extensions then so that
will fail for LLVM < 19. And for Zabha, I'll try to push the removal
of experimental from LLVM.

> I think we should
> continue to avoid enabling experimental extensions, even if that imposes
> a requirement of having a bleeding edge toolchain to actually use the
> extension.

Would it make sense to have a
CONFIG_RISCV_LLVM_ENABLE_EXPERIMENTAL_EXTENSIONS or similar? So that
people who want to play with those extensions will still be able to do
so without patching the kernel?

Thanks,

Alex

>
> Thanks,
> Conor.

