Return-Path: <linux-arch+bounces-5491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FF934930
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76D51F21BDF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F075804;
	Thu, 18 Jul 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K6cy95hU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAC36B17
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288937; cv=none; b=rHAtEh04lE+lsfDT+zLysZ1zQL/kB1M3GKA2GnsxCqJtpDZTK2mqrbRSMliaXtxGeWudLjMy+pRkSt8UEUgsqeusnUC2xNzFmlKetRvOeV6yPkuKnki+yKOcqqMSICRz7hdNzpfBn9O+WpZIs5eCv/eTcSKcUuGXn8l2UcdBdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288937; c=relaxed/simple;
	bh=5wc0bWipxv0v6692QEnjJWw+FVL+UXe+lBnbGCz4Hso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHAN2Zs8kp1+KctFLrRANzJLDyED8c4iggofnd1KDf4CVILMlXdJoe8VFgjpXOOT//lTVqPnVy2nqbWgYO/5hUvryNmmhUpptD3dPaY2fLm5Eh/PkIL5zp8+3ALnwdOlrGYYgFTeGNRw+K1IzgjSkC04Z6y/TQlwUSUC/FK/JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=K6cy95hU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea929ea56so43091e87.0
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721288934; x=1721893734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD+nX/SK0sYHyfzpnXWu07tByOYZBtjRYGWr13b6ybo=;
        b=K6cy95hUU3syJq1XDMclAs5byh2xv9Y2BA3WvPkAtNitrKvj7fW3h9vZ/Ejw1r5V/J
         4nNcEK3R8xwVtcBg4+eafIdbSuRPmV6brGdiMN2oEBjM0CRPDaCTGKadfo/ie3t8T2+J
         jmH8RNrrsRSYuDF7q+TMA3E9TAEcLOjH2ABsX6t/TbualUYBtjWxvXWpkUbAKUXDbpta
         rJnXhL9KPQ8+DlXE1KdpM2uoejZJuMI+kRK30rhUNqyrEXrSPaUNY1FY5Jj9JCXe+X1r
         yNQW1zRrupPc9MaysCcUQraq8x033GCxyvIisTM7W0+UCZZnN0k2geVgV2MDgMnYV7Wc
         GOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288934; x=1721893734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD+nX/SK0sYHyfzpnXWu07tByOYZBtjRYGWr13b6ybo=;
        b=A4jvLE5dYmPVjDgnwcwf0jFc4amazm3LDb3U3ze1EawHBtSt9STRSgdBvko0ZsoSCM
         41xa/ap7iNXLdogndSNBpG0dEM6OI/xZB8xkYfJ/aM8hiOHhMbGpLTsy9n8eIgH+M6uJ
         0nZGWaxWShB5F1hCcsKVpjeSuwx+xuSrMmdRKxWtpr2tApWaFrz6wrtkLheNv50N2MC+
         UbE2zO6x8GPY1NEx/9kHaFr/MfsKGmnx0vxfLmVvjVDNEbk+l/XsAF7RX57Y0mO5kQIp
         3r+mR1i4dzYxKyAcHqSF4Pf0R84bghcwUOLBXW3MJimPhLgZcBPQPm1N15pKyDDt/pQL
         r24g==
X-Forwarded-Encrypted: i=1; AJvYcCXLMoUsS62mMrkH9Rw+57q4MF97plqT2UeKfy83uKePz0w6AnX6o5NVCdi/JBGH+H5XrMzEKvjgVaQPuUC8wG5cdqUBCsi4o7eEEA==
X-Gm-Message-State: AOJu0YxoaeDckzmMT85cUPPYiPDPq2c5i2lM2ncJjRGBGRyFU/eHQnjQ
	a5fvbmm9Twx+/LtpW59djML4u2DE5T29HRKnOHOMimje/GXT3WQk2scul/0TGX7kvAVZiPXWPP0
	rpdCrurG0iIuEPVXKXgpDHCV3U52DIpdonocJpg==
X-Google-Smtp-Source: AGHT+IGHBgLtHfAhy/c4ubrhUk0ff0vQyOPXy+FGOXQxd0riXqum8s1MSYaqMyOjVLvFxDxlkfCgtZdggwCRrMfqEhI=
X-Received: by 2002:a05:6512:b22:b0:52e:9f7a:6e6 with SMTP id
 2adb3069b0e04-52ee5433efemr3817500e87.41.1721288933743; Thu, 18 Jul 2024
 00:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-6-alexghiti@rivosinc.com> <20240717-94b49fbac3c6bf97a0f96281@orel>
In-Reply-To: <20240717-94b49fbac3c6bf97a0f96281@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 18 Jul 2024 09:48:42 +0200
Message-ID: <CAHVXubi33T-5y9g1cqa+meM7q7b=0M54o+wrBeYmwfYpWAgAmQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] riscv: Implement arch_cmpxchg128() using Zacas
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Jul 17, 2024 at 10:34=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Wed, Jul 17, 2024 at 08:19:51AM GMT, Alexandre Ghiti wrote:
> > Now that Zacas is supported in the kernel, let's use the double word
> > atomic version of amocas to improve the SLUB allocator.
> >
> > Note that we have to select fixed registers, otherwise gcc fails to pic=
k
> > even registers and then produces a reserved encoding which fails to
> > assemble.
>
> Oh, that's quite unfortunate... I guess we should try to get some new
> RISC-V inline assembly register constraints added to support register
> pairs.

I internally informed the compilers people, I'll check their progress.

>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig               |  1 +
> >  arch/riscv/include/asm/cmpxchg.h | 39 ++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d3b0f92f92da..0bbaec0444d0 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -104,6 +104,7 @@ config RISCV
> >       select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
> >       select HARDIRQS_SW_RESEND
> >       select HAS_IOPORT if MMU
> > +     select HAVE_ALIGNED_STRUCT_PAGE
> >       select HAVE_ARCH_AUDITSYSCALL
> >       select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
> >       select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 97b24da38897..608d98522557 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -289,4 +289,43 @@ end:;                                             =
                       \
> >       arch_cmpxchg_release((ptr), (o), (n));                          \
> >  })
> >
> > +#ifdef CONFIG_RISCV_ISA_ZACAS
>
> This is also 64-bit only, so needs a CONFIG_64BIT check too.

Yep, thanks

>
> > +
> > +#define system_has_cmpxchg128()                                       =
       \
> > +                     riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)
>
> nit: let's let this stick out since we have 100 chars

Ok

>
> > +
> > +union __u128_halves {
> > +     u128 full;
> > +     struct {
> > +             u64 low, high;
>
> Should we consider big endian too?

Should we care about big endian? We don't deal with big endian
anywhere in our kernel right now.

>
> > +     };
> > +};
> > +
> > +#define __arch_cmpxchg128(p, o, n, cas_sfx)                           =
       \
> > +({                                                                    =
       \
> > +     __typeof__(*(p)) __o =3D (o);                                    =
         \
> > +     union __u128_halves __hn =3D { .full =3D (n) };                  =
           \
> > +     union __u128_halves __ho =3D { .full =3D (__o) };                =
           \
> > +     register unsigned long x6 asm ("x6") =3D __hn.low;               =
         \
> > +     register unsigned long x7 asm ("x7") =3D __hn.high;              =
         \
> > +     register unsigned long x28 asm ("x28") =3D __ho.low;             =
         \
> > +     register unsigned long x29 asm ("x29") =3D __ho.high;            =
         \
>
> Can we use t1,t2,t3,t4 rather than the x names?

We can, I did not because it was a bit misleading in the sense that
amocas expects an *even* register and using the tX registers, we'll
pass an *odd* register (which actually is even but still).

Anyway, I'll change that, I don't like the xX notation.

Thanks for the review,

Alex

>
> > +                                                                      =
       \
> > +     __asm__ __volatile__ (                                           =
       \
> > +             "       amocas.q" cas_sfx " %0, %z3, %2"                 =
       \
> > +             : "+&r" (x28), "+&r" (x29), "+A" (*(p))                  =
       \
> > +             : "rJ" (x6), "rJ" (x7)                                   =
       \
> > +             : "memory");                                             =
       \
> > +                                                                      =
       \
> > +     ((u128)x29 << 64) | x28;                                         =
       \
> > +})
> > +
> > +#define arch_cmpxchg128(ptr, o, n)                                    =
       \
> > +     __arch_cmpxchg128((ptr), (o), (n), ".aqrl")
> > +
> > +#define arch_cmpxchg128_local(ptr, o, n)                              =
       \
> > +     __arch_cmpxchg128((ptr), (o), (n), "")
> > +
> > +#endif /* CONFIG_RISCV_ISA_ZACAS */
> > +
> >  #endif /* _ASM_RISCV_CMPXCHG_H */
> > --
> > 2.39.2
>
> Thanks,
> drew

