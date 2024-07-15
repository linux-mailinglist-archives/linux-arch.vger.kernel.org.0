Return-Path: <linux-arch+bounces-5396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B68893158E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952B11C2042F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1E18D4BF;
	Mon, 15 Jul 2024 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yEq5yxV1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA018D4BA
	for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049638; cv=none; b=SmgkhM68TXAP0g8KfUlmGOz0FhmvBdm4kokx4+Ozn1p5+oj42gjMDQ6iEMYzK6SiY+ZjG6cx03I4/+SzbywfgJ2A1+vbTcB2zPpNy/lrZ6cfQJDLcP3W2KTGNfz0UREmA5saIElm0+S/v1/LVtflOrBkUuXiGySQfU7Y7jkiH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049638; c=relaxed/simple;
	bh=DKghIp3mdaF6wsn+ZKDLJpLvG1IF6GuDVGLTJivsIDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heBRYI0BSEpVqrYCOPErJuDwk+Ytq1R/Nbd/PFBmOgYYoe/wnQeVyu605BCqtV5rz0lUcN8sjuscCXo3uATWAY/O2VYovtxScYRUJW8w0SmZW50APZ73ZXYsrbhEjT1DayhniKXlsDZBbK7qpJy0gbefeJyjg7+uasRwOsmQfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yEq5yxV1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso542497366b.1
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721049635; x=1721654435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q/umhqYRQFF9gIX3sjpRcWSrKq6ad5xqF6eq9M8uvo=;
        b=yEq5yxV18k9CfK569hB+sE2+tIPJsIvBcjPNHGpO7htFuwVNIqnoWuvQc6/U/U40uD
         NticwcU/oi8MTZmIvUX7yCOo9+0QpXqo0Z8zKrfcaPlcfZNrT1/i/MtZsYoyfX0Qe8EQ
         Nbj1NLJEWDCBrOohfzRWSjIoIHJJMKVMce6GcigpHykneyanexQyC9PMTBldzizhy2gI
         qOZEOhd/XEYN6nJX5/hTFZkmB/NPLxHF+lNUi/QSRwjM/f6S4t5g2Ia9HSWWBxo87JjY
         5j53ayYTLpbnxDLF6lwo4IBbwLhma9GAZANvD2s3NdzERkSKvhpfESWa01Zxb9EN3Lcl
         WBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721049635; x=1721654435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q/umhqYRQFF9gIX3sjpRcWSrKq6ad5xqF6eq9M8uvo=;
        b=l2JrMrDBZ8sXkPL3bxSZZAJnw5aboeVaa/jdfwyh8fPrRIoe8co0/mbkq6//R0zLo7
         keYluVihOiYlhALapYXwUTbTr1ZMbLVu8Z5kg2hO6GDEGd7R2138fAydzUlZ0KXWf/3V
         DacDVDoHK+od/1N1Miw1EkdCYu3pXkThSRxH7/bnpN4uL1rPOKtDFhO7oyBOvf1HINd9
         XOwxDM40MQZCn4QKhSZipDSSADiel/SMc+Qyd8PHxlIVHmo1PLnlcPITk6IVdrTBuvoJ
         5ycqlgNa3KRU7C3qMa/vIMpGBXOi2qOkWh9xCxzktXszCdf/IX4Imc8RhqWCSUQsA8OK
         iHuA==
X-Forwarded-Encrypted: i=1; AJvYcCVqen0sk3+4znGkRMiV0M8eXBcStDC+FyNn0f9+tjS6/lZI9D0mTGxNtY4XBwVS4iFrRrDkDF4yaYOg/83MnyiJYQsa0xpmAJ20VA==
X-Gm-Message-State: AOJu0Yz+EgVTRhqPqtiSEJyQqAA6BCuGyAGFpgifI66/EwMkbhYNRtpM
	O6ctN8/0B2SKSWMwXaPFnKWwUYty1UgOlfRVXa2gmbvXInAo/KoZyUR/Xz1u53CipwqiRAuuw69
	8jWGrRh7lSEZVmOvacGlq5+m6LjTIGFNyuWBZeQ==
X-Google-Smtp-Source: AGHT+IFdF+/LtyeYj3Tk4XoOO84vKXOBe831P7Ek8js3dWW0Y+/JENU6/4aF5U6MzfFFI+qsKGvMaDgUtV6qoyJuIy0=
X-Received: by 2002:a17:907:1c10:b0:a72:4b4a:a626 with SMTP id
 a640c23a62f3a-a780b89dde4mr1606680766b.68.1721049634725; Mon, 15 Jul 2024
 06:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-7-alexghiti@rivosinc.com> <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 15:20:23 +0200
Message-ID: <CAHVXubiVrNzSona97CyuT3rbFJjU4MFB_x8xxLrnce77KmABYA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
To: Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Wed, Jul 10, 2024 at 3:37=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Jun 26, 2024 at 9:10=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > This adds runtime support for Zabha in xchg8/16() operations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 33 +++++++++++++++++++++++++++++---
> >  arch/riscv/include/asm/hwcap.h   |  1 +
> >  arch/riscv/kernel/cpufeature.c   |  1 +
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index da42f32ea53d..eb35e2d30a97 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -11,8 +11,17 @@
> >  #include <asm/fence.h>
> >  #include <asm/alternative.h>
> >
> > -#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)          =
 \
> > +#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,      =
 \
> > +                          swap_append, r, p, n)                       =
 \
> >  ({                                                                    =
 \
> > +       __label__ zabha, end;                                          =
 \
> > +                                                                      =
 \
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                      =
 \
> > +               asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,           =
 \
> > +                                    RISCV_ISA_EXT_ZABHA, 1)           =
 \
> > +                        : : : : zabha);                               =
 \
> > +       }                                                              =
 \
> > +                                                                      =
 \
> Could we exchange the sequence between Zabha & lr/sc?
> I mean:
> nop -> zabha
> j -> lr/sc
>

Yes, you're right, it makes more sense this way. I'll do that.

Thanks,

Alex

>
> >         u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);                  =
   \
> >         ulong __s =3D ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE=
;  \
> >         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)=
   \
> > @@ -28,12 +37,25 @@
> >                "        or   %1, %1, %z3\n"                            =
 \
> >                "        sc.w" sc_sfx " %1, %1, %2\n"                   =
 \
> >                "        bnez %1, 0b\n"                                 =
 \
> > -              append                                                  =
 \
> > +              sc_append                                               =
         \
> >                : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr32b))  =
     \
> >                : "rJ" (__newx), "rJ" (~__mask)                         =
 \
> >                : "memory");                                            =
 \
> >                                                                        =
 \
> >         r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);            =
   \
> > +       goto end;                                                      =
 \
> > +                                                                      =
 \
> > +zabha:
> jump lr/sc implementation because it's already slow.
>                                                                \
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                      =
 \
> > +               __asm__ __volatile__ (                                 =
 \
> > +                       prepend                                        =
 \
> > +                       "       amoswap" swap_sfx " %0, %z2, %1\n"     =
 \
> > +                       swap_append                                    =
         \
> > +                       : "=3D&r" (r), "+A" (*(p))                     =
   \
> > +                       : "rJ" (n)                                     =
 \
> > +                       : "memory");                                   =
 \
> > +       }                                                              =
 \
> > +end:;                                                                 =
 \
> >  })
> >
> >  #define __arch_xchg(sfx, prepend, append, r, p, n)                    =
 \
> > @@ -56,8 +78,13 @@
> >                                                                        =
 \
> >         switch (sizeof(*__ptr)) {                                      =
 \
> >         case 1:                                                        =
 \
> > +               __arch_xchg_masked(sc_sfx, ".b" swap_sfx,              =
 \
> > +                                  prepend, sc_append, swap_append,    =
 \
> > +                                  __ret, __ptr, __new);               =
 \
> > +               break;                                                 =
 \
> >         case 2:                                                        =
 \
> > -               __arch_xchg_masked(sc_sfx, prepend, sc_append,         =
 \
> > +               __arch_xchg_masked(sc_sfx, ".h" swap_sfx,              =
 \
> > +                                  prepend, sc_append, swap_append,    =
 \
> >                                    __ret, __ptr, __new);               =
 \
> >                 break;                                                 =
 \
> >         case 4:                                                        =
 \
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e17d0078a651..f71ddd2ca163 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -81,6 +81,7 @@
> >  #define RISCV_ISA_EXT_ZTSO             72
> >  #define RISCV_ISA_EXT_ZACAS            73
> >  #define RISCV_ISA_EXT_XANDESPMU                74
> > +#define RISCV_ISA_EXT_ZABHA            75
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG     127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 5ef48cb20ee1..c125d82c894b 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >         __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> >         __RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> > +       __RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
> >         __RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >         __RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >         __RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
>  Guo Ren

