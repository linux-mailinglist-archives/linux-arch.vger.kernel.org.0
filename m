Return-Path: <linux-arch+bounces-5340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3592C7FC
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 03:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655301C20D24
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA23D7A;
	Wed, 10 Jul 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3ieyxy3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9EE10FF;
	Wed, 10 Jul 2024 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575454; cv=none; b=AOvbn65nLKH8Ue/Xry788RfvZrL0RXEV2ouQqwjFFjl76WfAKyxLZE3rpcG3B6a/rzwdg8eylnbGtw9rX6pMDc8WsM3+pZPtyIF2aoxSoEAEyGd8ckldNSyOapH/pBgOcZbQFMdXxgRTUZ75ds9oy2fuTMKItICvroFcjkFsQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575454; c=relaxed/simple;
	bh=7x3GEkDVh0i0eAqUuwQkrzhqPJO/oHPH+D8jftX54Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq2CkeuJoPFnYqpg36DDKuPqEvEEURB6Oz2RT/UoyNaf6RLQjdH+hrpJf22zkbMeDuUvEkyWDECuZuDyhfh54/OzAy8JaWRQyqfZ0RRSh8YpGeTWCqpC5T4sYk+pRfJ+QOhklsO4t2tAPchuLSlp4ke3liw1K8Tc9taTIFSKdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3ieyxy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98984C4AF0A;
	Wed, 10 Jul 2024 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575453;
	bh=7x3GEkDVh0i0eAqUuwQkrzhqPJO/oHPH+D8jftX54Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q3ieyxy3hJZaA8ysPOrc2YXxe1pB3d1xOvGF9DCxL9Kvq4f0vQFdITMNwBPClFs+Q
	 cXMSx7MALQlD9VmQkzJp5P1HkU1YKc5mO3yaWA7v/02JKLboxIqA+ZwcoBdnx/DuDp
	 V011/7qP2DcMuMPT3pCJ7d1pe1P23lI/BejJAzBAjGeo/P7it5uacwi95nt3SAQOhr
	 xVXTzgQmVgXjbVrpRqU+iGYyQomBHvB5qxRTI3mfOJgZaLthyPCQjppM3OkJ2AgAVq
	 FStxWUmQIcIa9yeA7gSdQoMxnIFKr1r+gVFvBSP3lH/M2I+Lf2uagwoNoK9qEuk3CM
	 qvvUR64fbp9Yw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso569318266b.2;
        Tue, 09 Jul 2024 18:37:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4Xw2fWxUmvZQMvyPjfbuhSdULLTA0IhVtGAGlCYPc6B7h43RRB6vgcJoKVr4ookbF2MTY17bi2xe5Yn8i+TBADWWsp2x9wRbwxutcDS3Tlh3cmCw11yHMuO3X4xiCU61GU+EfeTwXN324aTnkQDDZJpSSkVBha0GQOnRMPSdsIc3sEw==
X-Gm-Message-State: AOJu0Yw3LGdSj09vF2kBFw4roNmgEx3nyl6IFWe5danHQTU2NSOtJWD4
	1w1DLoWg6wut5695rGsolfdplIgskkLFMQB/LUe9PYUlqhWyo7m4iXeB6fbxtZ/2xntRfIJWW3u
	tB0Dn8GeO4lYWgMhLSxExX9QFthw=
X-Google-Smtp-Source: AGHT+IHmd+/WXCkt/CKbzdND2sKIp/WdDdZr/w4zRmSZLHYnLmmE0cqn+UtqINsSDCF8jhyBLrwCDzYaroRAc5X3Z8E=
X-Received: by 2002:a17:907:2dab:b0:a77:d481:d69f with SMTP id
 a640c23a62f3a-a780b89e7cemr299719566b.70.1720575452132; Tue, 09 Jul 2024
 18:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com> <20240626130347.520750-7-alexghiti@rivosinc.com>
In-Reply-To: <20240626130347.520750-7-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 10 Jul 2024 09:37:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
Message-ID: <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
To: Alexandre Ghiti <alexghiti@rivosinc.com>
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

On Wed, Jun 26, 2024 at 9:10=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> This adds runtime support for Zabha in xchg8/16() operations.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 33 +++++++++++++++++++++++++++++---
>  arch/riscv/include/asm/hwcap.h   |  1 +
>  arch/riscv/kernel/cpufeature.c   |  1 +
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index da42f32ea53d..eb35e2d30a97 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -11,8 +11,17 @@
>  #include <asm/fence.h>
>  #include <asm/alternative.h>
>
> -#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)           \
> +#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,       \
> +                          swap_append, r, p, n)                        \
>  ({                                                                     \
> +       __label__ zabha, end;                                           \
> +                                                                       \
> +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                       \
> +               asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,            \
> +                                    RISCV_ISA_EXT_ZABHA, 1)            \
> +                        : : : : zabha);                                \
> +       }                                                               \
> +                                                                       \
Could we exchange the sequence between Zabha & lr/sc?
I mean:
nop -> zabha
j -> lr/sc


>         u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);                    =
 \
>         ulong __s =3D ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE; =
 \
>         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)  =
 \
> @@ -28,12 +37,25 @@
>                "        or   %1, %1, %z3\n"                             \
>                "        sc.w" sc_sfx " %1, %1, %2\n"                    \
>                "        bnez %1, 0b\n"                                  \
> -              append                                                   \
> +              sc_append                                                 =
       \
>                : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr32b))    =
   \
>                : "rJ" (__newx), "rJ" (~__mask)                          \
>                : "memory");                                             \
>                                                                         \
>         r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);              =
 \
> +       goto end;                                                       \
> +                                                                       \
> +zabha:
jump lr/sc implementation because it's already slow.
                                                               \
> +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                       \
> +               __asm__ __volatile__ (                                  \
> +                       prepend                                         \
> +                       "       amoswap" swap_sfx " %0, %z2, %1\n"      \
> +                       swap_append                                      =
       \
> +                       : "=3D&r" (r), "+A" (*(p))                       =
 \
> +                       : "rJ" (n)                                      \
> +                       : "memory");                                    \
> +       }                                                               \
> +end:;                                                                  \
>  })
>
>  #define __arch_xchg(sfx, prepend, append, r, p, n)                     \
> @@ -56,8 +78,13 @@
>                                                                         \
>         switch (sizeof(*__ptr)) {                                       \
>         case 1:                                                         \
> +               __arch_xchg_masked(sc_sfx, ".b" swap_sfx,               \
> +                                  prepend, sc_append, swap_append,     \
> +                                  __ret, __ptr, __new);                \
> +               break;                                                  \
>         case 2:                                                         \
> -               __arch_xchg_masked(sc_sfx, prepend, sc_append,          \
> +               __arch_xchg_masked(sc_sfx, ".h" swap_sfx,               \
> +                                  prepend, sc_append, swap_append,     \
>                                    __ret, __ptr, __new);                \
>                 break;                                                  \
>         case 4:                                                         \
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e17d0078a651..f71ddd2ca163 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@
>  #define RISCV_ISA_EXT_ZTSO             72
>  #define RISCV_ISA_EXT_ZACAS            73
>  #define RISCV_ISA_EXT_XANDESPMU                74
> +#define RISCV_ISA_EXT_ZABHA            75
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 5ef48cb20ee1..c125d82c894b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>         __RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> +       __RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
>         __RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>         __RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>         __RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

