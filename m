Return-Path: <linux-arch+bounces-4579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF58D36BA
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149D3286223
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A171847;
	Wed, 29 May 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ebZnCnLj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B653A9
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987014; cv=none; b=vDTh6yfv9cEF3saAeerGfP5QmgREqBMHtZpDm8Pu00yYrY1msSkkd0G33wbV3/SBtI3/z/fgWUhQ3eBocCaTW1r3z+d2BUcjNCo8Crc3QYkG++NwqI3d263cLcq2DsjNALMdMqTc3B7A4xbaJjAK1x/N1Xot8NzAIIBhZ1O3ecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987014; c=relaxed/simple;
	bh=wDOh3GgxeeojaaGvJLYrqx3gp0ldmjEWoy3FOFKhGH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AncwHwrlMuqkNf66PHO/PV1nxlJlV5pvTafmgxPgbkmOqWbbnQtYLt8IMSqgrrIMgI1E87DVNGB7hj169Hc1l9zBEEjqBCF18CY/Vi3Iwqpf8Z4wYrAMyztM5YOz8fqHjum94+LargYQGX1UP8VHRUEvjp03OcCQtausAHv57cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ebZnCnLj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a621cb07d8fso229911666b.2
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716987010; x=1717591810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNItZxu06YRXLGqNeIhgtHR87fPjOnrEFWQ8pXCNo7A=;
        b=ebZnCnLjnAb8W35JdZrO/gXhF/VuzlPUlAd832zKCps8LMgrE1XbcQIagd7skiXHCR
         MsD8+FyDvemYitHIbK8HsYzeCBQwmM2kpyDRGx2Q2WtHi8Ge8+PYotXSdKPJ4xhjTkTD
         tMEohgMfZQCjwyqdCQB5+oq0UqUHxCrsl1FLFdxLUctVZscXZ+UwnATRBhx6j/upilW0
         +Vg4O2pkGsDPHQzwdrPhIVDLTalQZq6qry8n7rKxQqsYRVpHRpng1ONyk6Af7h7ehfSL
         uqvy8NJT+Vnt0CR55ogm7L67I8ZSdmWumuXSDUSIvCc/sW77MCG9NYbwMnnyyxG8qpsn
         yp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987010; x=1717591810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNItZxu06YRXLGqNeIhgtHR87fPjOnrEFWQ8pXCNo7A=;
        b=opwn3hK5WqveI2npT0XVxCYrlPQMAO36l1aFWcCT548aueW/rDzQqXLR9E9ZvRyLjV
         WrPMPGL5sBbnwVfbYKxTOranyzjZSqd0hiHX6yNdWcVK0w2viTqqMvOjSOkGaucGShyO
         jYMoj3z9/LULnR1TJ+8yxqwzdk58sBnpfYA0XgO+dIXO9zmG5dJLjx6EmdIBND9IY4nK
         1zSyuZUkgZ+2CJh5DYYYsL7b5jEJ8B0kkPwXDdi9u62mp5IvJwSjK+2emyt9ptRF5SLs
         NtLAVeOVI9K/NZOgoY+YN/SS2WFjblvk3NJKJmzYzLJcgioGke/l7a+L7T3+yqRlIuCA
         atsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvvwd1JJ3TgUqqcQDA0Ayb8ZwdMVzMd+UfHkQsKsZgEzpwFveBdgZ6rzhmHWHavcLge0MWtfiSnJ0rHjJrYGIv47Z391vil7nYrg==
X-Gm-Message-State: AOJu0YxhMLJ0EfMdnM97Celpqv/XQmqjekI+7r0OpNQIjZ0YjIX6Y7uT
	YJfIq1Or8/MSrfBfUpxd0eEh4Q9mqaz1qHmNd4o7yl3OxFO4zD9vCDTZzA8/W+deESoR2MCly8y
	tJ90SNA73QNO76MRN4o4QCDK8Yf6rc+Lp4yNEKg==
X-Google-Smtp-Source: AGHT+IFo7SAqMDV9cCjNymAf4nsO+/p56SCIQeUO+4/vtGcG6LahU0XxGcz6O9HPFeYpq9htcwA09N4+2mEm7/5JEL0=
X-Received: by 2002:a17:906:b00d:b0:a59:df1d:f5ae with SMTP id
 a640c23a62f3a-a62641bbae3mr1046027366b.31.1716987010122; Wed, 29 May 2024
 05:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com> <20240528193110.GA2196855@thelio-3990X>
In-Reply-To: <20240528193110.GA2196855@thelio-3990X>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 14:49:58 +0200
Message-ID: <CAHVXubjYVjOH8RKaF1h=iogO3xBM6k+xrGwkPnc-md2oRxbxrQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Tue, May 28, 2024 at 9:31=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Alexandre,
>
> On Tue, May 28, 2024 at 05:10:47PM +0200, Alexandre Ghiti wrote:
> > This adds runtime support for Zabha in cmpxchg8/16 operations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig               | 16 ++++++++++++++++
> >  arch/riscv/Makefile              | 10 ++++++++++
> >  arch/riscv/include/asm/cmpxchg.h | 26 ++++++++++++++++++++++++--
> >  3 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b443def70139..05597719bb1c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -579,6 +579,22 @@ config RISCV_ISA_V_PREEMPTIVE
> >         preemption. Enabling this config will result in higher memory
> >         consumption due to the allocation of per-task's kernel Vector c=
ontext.
> >
> > +config TOOLCHAIN_HAS_ZABHA
> > +     bool
> > +     default y
> > +     depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_za=
bha)
> > +     depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_z=
abha)
>
> This test does not take into account the need for
> '-menable-experimental-extensions' and '1p0' in the '-march=3D' value wit=
h
> clang 19, so it can never be enabled even if it is available.

Then I missed that, I should have checked the generated code. Is the
extension version "1p0" in '-march=3D' only required for experimental
extensions?

>
> I am not really sure how to succinctly account for this though, other
> than duplicating and modifying the cc-option checks with a dependency on
> either CC_IS_GCC or CC_IS_CLANG. Another option is taking the same
> approach as the _SUPPORTS_DYNAMIC_FTRACE symbols and introduce
> CLANG_HAS_ZABHA and GCC_HAS_ZABHA? That might not make it too ugly.
>
> I think the ZACAS patch has a similar issue, it just isn't noticeable
> with clang 19 but it should be with clang 17 and 18.

But from Conor comment here [1], we should not enable extensions that
are only experimental. In that case, we should be good with this.

[1] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@r=
ivosinc.com/T/#mefb283477bce852f3713cbbb4ff002252281c9d5

>
> > +     depends on AS_HAS_OPTION_ARCH
> > +
> > +config RISCV_ISA_ZABHA
> > +     bool "Zabha extension support for atomic byte/half-word operation=
s"
> > +     depends on TOOLCHAIN_HAS_ZABHA
> > +     default y
> > +     help
> > +       Adds support to use atomic byte/half-word operations in the ker=
nel.
> > +
> > +       If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZACAS
> >       bool
> >       default y
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index d5b60b87998c..f58ac921dece 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -89,6 +89,16 @@ else
> >  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv-march-y)_zacas
> >  endif
> >
> > +# Check if the toolchain supports Zabha
> > +ifdef CONFIG_AS_IS_LLVM
> > +# Support for experimental Zabha was merged in LLVM 19.
> > +KBUILD_CFLAGS +=3D -menable-experimental-extensions
> > +KBUILD_AFLAGS +=3D -menable-experimental-extensions
> > +riscv-march-y :=3D $(riscv-march-y)_zabha1p0
>
> This block should have some dependency on CONFIG_TOOLCHAIN_HAS_ZABHA as
> well right? Otherwise, the build breaks with LLVM toolchains that do not
> support zabha, like LLVM 18.1.x:
>
>   clang: error: invalid arch name 'rv64imac_zihintpause_zacas1p0_zabha1p0=
', unsupported version number 1.0 for extension 'zabha'
>
> I think the zacas patch has the same bug.

Ok, I will fix that, thanks.

>
> I think that it would be good to consolidate the adding of
> '-menable-experimental-extensions' to the compiler and assembler flags
> to perhaps having a hidden symbol like CONFIG_EXPERIMENTAL_EXTENSIONS
> that is selected by any extension that is experimental for the
> particular toolchain version.
>
> config EXPERIMENTAL_EXTENSIONS
>     bool
>
> config TOOLCHAIN_HAS_ZABHA
>     def_bool y
>     select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG
>     ...
>
> config TOOLCHAIN_HAS_ZACAS
>     def_bool_y
>     # ZACAS was experimental until Clang 19: https://github.com/llvm/llvm=
-project/commit/95aab69c109adf29e183090c25dc95c773215746
>     select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG && CLANG_VERSION < 1900=
00
>     ...
>
> Then in the Makefile:
>
> ifdef CONFIG_EXPERIMENTAL_EXTENSIONS
> KBUILD_AFLAGS +=3D -menable-experimental-extensions
> KBUILD_CFLAGS +=3D -menable-experimental-extensions
> endif

That's a good idea to me, let's see what Conor thinks [2]

[2] https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@r=
ivosinc.com/T/#m1d798dfc4c27e5b6d9e14117d81b577ace123322

>
> > +else
> > +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) :=3D $(riscv-march-y)_zabha
> > +endif
> > +
> >  # Remove F,D,V from isa string for all. Keep extensions between "fd" a=
nd "v" by
> >  # matching non-v and non-multi-letter extensions out with the filter (=
[^v_]*)
> >  KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/=
(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 1c50b4821ac8..65de9771078e 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -103,8 +103,14 @@
> >   * indicated by comparing RETURN with OLD.
> >   */
> >
> > -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)   \
> > +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, =
o, n)  \
> >  ({                                                                   \
> > +     __label__ zabha, end;                                           \
> > +                                                                     \
> > +     asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,                    \
> > +                          RISCV_ISA_EXT_ZABHA, 1)                    \
> > +                     : : : : zabha);                                 \
> > +                                                                     \
> >       u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);                    =
 \
> >       ulong __s =3D ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE; =
 \
> >       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)  =
 \
> > @@ -131,6 +137,17 @@
> >               : "memory");                                            \
> >                                                                       \
> >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);              =
 \
> > +     goto end;                                                       \
> > +                                                                     \
> > +zabha:                                                                =
       \
> > +     __asm__ __volatile__ (                                          \
> > +             prepend                                                 \
> > +             "       amocas" cas_sfx " %0, %z2, %1\n"                \
>
> This should probably have some dependency on CONFIG_RISCV_ISA_ZABHA? I ge=
t the
> following with GCC 13.2.0:
>
>   include/linux/atomic/atomic-arch-fallback.h: Assembler messages:
>   include/linux/atomic/atomic-arch-fallback.h:2108: Error: unrecognized o=
pcode `amocas.w a4,a3,0(s1)'

Indeed, my test setup lacks a few things apparently, I will fix that, thank=
s.

>
> > +             append                                                  \
> > +             : "+&r" (r), "+A" (*(p))                                \
> > +             : "rJ" (n)                                              \
> > +             : "memory");                                            \
> > +end:                                                                 \
>
> I get a lot of warnings from this statement and the one added by the
> previous patch for zacas, which is a C23 extension:
>
>   include/linux/atomic/atomic-arch-fallback.h:4234:9: warning: label at e=
nd of compound statement is a C23 extension [-Wc23-extensions]
>   include/linux/atomic/atomic-arch-fallback.h:89:29: note: expanded from =
macro 'raw_cmpxchg_relaxed'
>      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
>         |                             ^
>   arch/riscv/include/asm/cmpxchg.h:219:2: note: expanded from macro 'arch=
_cmpxchg_relaxed'
>     219 |         _arch_cmpxchg((ptr), (o), (n), "", "", "")
>         |         ^
>   arch/riscv/include/asm/cmpxchg.h:200:3: note: expanded from macro '_arc=
h_cmpxchg'
>     200 |                 __arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,     =
         \
>         |                 ^
>   arch/riscv/include/asm/cmpxchg.h:150:14: note: expanded from macro '__a=
rch_cmpxchg_masked'
>     150 | end:                                                           =
         \
>         |                                                                =
         ^
>
> This resolves it:
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index ba3ffc2fcdd0..57aa4a554278 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -147,7 +147,7 @@ zabha:                                               =
                       \
>                 : "+&r" (r), "+A" (*(p))                                \
>                 : "rJ" (n)                                              \
>                 : "memory");                                            \
> -end:                                                                   \
> +end:;                                                                  \
>  })
>
>  #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o,=
 n)    \
> @@ -180,7 +180,7 @@ zacas:                                               =
                       \
>                 : "+&r" (r), "+A" (*(p))                                \
>                 : "rJ" (n)                                              \
>                 : "memory");                                            \
> -end:                                                                   \
> +end:;                                                                  \
>  })
>
>  #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)          \

Weird, I missed this too, I will fix that, thanks.

>
> >  })
> >
> >  #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, =
o, n)  \
> > @@ -175,8 +192,13 @@ end:                                              =
                       \
> >                                                                       \
> >       switch (sizeof(*__ptr)) {                                       \
> >       case 1:                                                         \
> > +             __arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,              \
> > +                                     prepend, append,                \
> > +                                     __ret, __ptr, __old, __new);    \
> > +             break;                                                  \
> >       case 2:                                                         \
> > -             __arch_cmpxchg_masked(sc_sfx, prepend, append,          \
> > +             __arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,              \
> > +                                     prepend, append,                \
> >                                       __ret, __ptr, __old, __new);    \
> >               break;                                                  \
> >       case 4:                                                         \
> > --
> > 2.39.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks for your thorough review!

Alex

