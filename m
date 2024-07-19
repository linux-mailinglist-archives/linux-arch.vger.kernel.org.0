Return-Path: <linux-arch+bounces-5516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8593774E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 13:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6456DB20FB5
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6B84A4C;
	Fri, 19 Jul 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kPS8bFRx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C382D89
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389710; cv=none; b=DNSEATea6qpZdD5fFLub8uNttTTBxgQZ2iz0dUm8wAGJ+gXgtMLXJ3C/s+HQsmawC4xSMpmfmVqdrMGB9oi1W50Onf4c0x+PPZTBKLou2v03fva/Mb2JhBj6W/dRsFEAVzFKx+4nV/3IzSZcYwa14acnEAaU4k9n3/NKN0Ialug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389710; c=relaxed/simple;
	bh=VIr7avXxyVGtPtQKv2DO3WrLdv5hi1IxLIOGpcqtRR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFYZOYfLWJ4IIY3Y7ONjcfy59esfrFngEoqwAUY3ulMKmGZd/2imyLyaE/o9Q7fflURgzfbDnQEBVCOzqYns5Ky4HHkEskwcSw8Lw4n5O1IB33MsOVdb3JlUqINV/nUEpz0oCY96ompIwaG33bh8aYFHTNwMhjFWIivkxx0p7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kPS8bFRx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77abe5c709so181868066b.2
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721389706; x=1721994506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/Xw96+xbR06X3LlcELpC9ytGPNzFgVehD8LoUveeyY=;
        b=kPS8bFRxa2FW7M2Cd+wT3E0FUCXmUpQ7PHSUPToM6yUg9Hk2WjnHt39dsKiWLmQZHi
         5taBBDSMOi01MAjG5yZHlPnQhEbcpMQIZyeeD646+OM0vvifpxrCzrIwCHkrrOVw7hHl
         qOIkmJrXHqMW6ILUkRweyizEubM9Y2in6/hpI9g27YSjZPS7JRYTaKG3XTXuezFaK74V
         gejYiDWizlySEJp8sA5ZU6KFnDbv/gLedz/MJdkHXhmVxJj/z7EVnq4i6U8YJnucXYDC
         tUsCP/5mt8rPhUIsChTwI46tpwBvFSlOhCaik/qLG/86ftdmdsRkU7XdMx5VpGIVSB5q
         NMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721389706; x=1721994506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/Xw96+xbR06X3LlcELpC9ytGPNzFgVehD8LoUveeyY=;
        b=kZp3s/a5+xFsG5FUf7SDoSyPHYamJ/YtfGxF1OdnrzeP285F0ztHHt5puECJBKSXPZ
         d4+hAwjd1cA1/pAnKyogZ0xiAUNEsGW1LwBbLec5jNq65xbQ+aTELRamSveBCYWsW5y9
         aC7BBq13vQbbtWbfyHpwwvD3PYZKEJTMoix4NLLKeTZzkGUuZdng0cs2Fq5D78LUBZyS
         A8xN2deT/liAnWqmahYm0EH81MpmW2/KXveOftI2cXcJ40e9BSaEUofeOZ7exiT/lDIg
         s6SOtoNqipQii4WrPmeI2AWQAO3+wV7cr9GP0glKg/6INEW2dDk5gVIjZSj1zPnDM83c
         inTw==
X-Forwarded-Encrypted: i=1; AJvYcCVc1Uo+ESeF993T4mrTY19BeNOdDvL8VAOVoY/vD7P52YlN5LWuIoNBShoGf9uwyWU7kd2NGAq580vzbkNkPe8m/CU7zLks4j0MVA==
X-Gm-Message-State: AOJu0Yw3PWmlPaPL3hKp1JoLZIWpl9pk+apLmw4pn32WxWdx+AjHOoyi
	Wb6qk0wYF16LLjQx3cB8Xayw95lSdoCwMq6SICrUILxMUDuxZd+UStl0+kZCyelQ8GxlNoXQi3N
	YxIJORS8TZ1w+J4q+aE6PjdTDcuKf2g/pa/Mseg==
X-Google-Smtp-Source: AGHT+IEdKcseE4INrgAR92Yrajh44cv2+uhdnjrBw05t2SUjURQi/PLFnDuvPESt5SEDtBUypb3cGZn1JGyYqocY6o4=
X-Received: by 2002:a17:906:40d5:b0:a77:cd3c:e9b7 with SMTP id
 a640c23a62f3a-a7a0133ac71mr561742266b.57.1721389706263; Fri, 19 Jul 2024
 04:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-2-alexghiti@rivosinc.com> <8de44944-62b4-44df-88e1-bcf7417fea6e@sifive.com>
In-Reply-To: <8de44944-62b4-44df-88e1-bcf7417fea6e@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 13:48:15 +0200
Message-ID: <CAHVXubgU-g+yqn0GS-9SyehsN4m5bHVYvJjCwFQxi3HV2505bQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] riscv: Implement cmpxchg32/64() using Zacas
To: Samuel Holland <samuel.holland@sifive.com>
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

On Fri, Jul 19, 2024 at 2:45=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> > This adds runtime support for Zacas in cmpxchg operations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig               | 17 +++++++++++++++++
> >  arch/riscv/Makefile              |  3 +++
> >  arch/riscv/include/asm/cmpxchg.h | 26 +++++++++++++++++++++++---
> >  3 files changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 05ccba8ca33a..1caaedec88c7 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -596,6 +596,23 @@ config RISCV_ISA_V_PREEMPTIVE
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
> > +       Enable the use of the Zacas ISA-extension to implement kernel a=
tomic
> > +       cmpxchg operations when it is detected at boot.
> > +
> > +       If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZBB
> >       bool
> >       default y
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 06de9d365088..9fd13d7a9cc6 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -85,6 +85,9 @@ endif
> >  # Check if the toolchain supports Zihintpause extension
> >  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) :=3D $(riscv-march-y)_=
zihintpause
> >
> > +# Check if the toolchain supports Zacas
> > +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv-march-y)_zacas
> > +
> >  # Remove F,D,V from isa string for all. Keep extensions between "fd" a=
nd "v" by
> >  # matching non-v and non-multi-letter extensions out with the filter (=
[^v_]*)
> >  KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/=
(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 808b4c78462e..5d38153e2f13 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/bug.h>
> >
> >  #include <asm/fence.h>
> > +#include <asm/alternative.h>
> >
> >  #define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)         \
> >  ({                                                                   \
> > @@ -134,21 +135,40 @@
> >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);              =
 \
> >  })
> >
> > -#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n=
)      \
> > +#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, =
o, n)  \
> >  ({                                                                   \
> > +     __label__ no_zacas, end;                                        \
> >       register unsigned int __rc;                                     \
> >                                                                       \
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {                       \
> > +             asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,         \
> > +                                  RISCV_ISA_EXT_ZACAS, 1)            \
> > +                      : : : : no_zacas);                             \
> > +                                                                     \
> > +             __asm__ __volatile__ (                                  \
> > +                     prepend                                         \
> > +                     "       amocas" sc_cas_sfx " %0, %z2, %1\n"     \
> > +                     append                                          \
> > +                     : "+&r" (r), "+A" (*(p))                        \
> > +                     : "rJ" (n)                                      \
> > +                     : "memory");                                    \
> > +             goto end;                                               \
> > +     }                                                               \
> > +                                                                     \
> > +no_zacas:                                                            \
> >       __asm__ __volatile__ (                                          \
> >               prepend                                                 \
> >               "0:     lr" lr_sfx " %0, %2\n"                          \
> >               "       bne  %0, %z3, 1f\n"                             \
> > -             "       sc" sc_sfx " %1, %z4, %2\n"                     \
> > +             "       sc" sc_cas_sfx " %1, %z4, %2\n"                 \
> >               "       bnez %1, 0b\n"                                  \
> >               append                                                  \
>
> This would probably be a good place to use inline ALTERNATIVE instead of =
an asm
> goto. It saves overall code size, and a jump in the non-Zacas case, at th=
e cost
> of 3 nops in the Zacas case. (And all the nops can go after the amocas, w=
here
> they will likely be hidden by the amocas latency.)

That's what Conor proposed indeed.

I have just given it a try, but it does not work. The number of
instructions in the zacas asm inline is different in the case of the
fully-ordered version so I cannot set a unique number of nops. I could
pass this information from arch_cmpxchg() down to __arch_cmpxchg() but
those macros are already complex enough so I'd rather not add another
parameter.

This suggestion unfortunately cannot be applied to
__arch_cmpxchg_masked(), nor __arch_xchg_masked().

So unless you and Conor really insist, I'll drop the idea!

Thanks,

Alex


>
> Regards,
> Samuel
>
> >               "1:\n"                                                  \
> >               : "=3D&r" (r), "=3D&r" (__rc), "+A" (*(p))               =
   \
> >               : "rJ" (co o), "rJ" (n)                                 \
> >               : "memory");                                            \
> > +                                                                     \
> > +end:;                                                                 =
       \
> >  })
> >
> >  #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)         =
       \
> > @@ -156,7 +176,7 @@
> >       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> >       __typeof__(*(__ptr)) __old =3D (old);                            =
 \
> >       __typeof__(*(__ptr)) __new =3D (new);                            =
 \
> > -     __typeof__(*(__ptr)) __ret;                                     \
> > +     __typeof__(*(__ptr)) __ret =3D (old);                            =
 \
> >                                                                       \
> >       switch (sizeof(*__ptr)) {                                       \
> >       case 1:                                                         \
>

