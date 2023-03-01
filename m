Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8B6A6F35
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 16:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCAPTs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCAPTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 10:19:46 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC723C784
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 07:19:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n2so8120176pfo.12
        for <linux-arch@vger.kernel.org>; Wed, 01 Mar 2023 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgz/Djjon8JkpfSssPQphU3ki++kBUAfgIVgXczgsW4=;
        b=lE55rVTqYPSFuy5+14nvjA7f4zrhciYiHT8VxVUE1MJ7P9pqQTtaQwm0UYoMcgO6Os
         OL0u3iwp4bZ4TUCrjpjd6wpnKK6Ill/WF0G+JYw2wlNK7Y6POjtfdCcoc2ttDvGtpLso
         jlmVp7Y1CFCUdUB420Fcg47yHb6eBzqfyU0TzRZ7n8PpWluvmaAhk6ttjub4j4l9ErPQ
         OJc2vrqoK01sDWIMxa4Zg/iGQVbsddxJDdcJd0xQvoO4bl8laDibtpksUiJjlRAPmEXq
         th7bdkji/lLhHZ81E440EAQ3YvSpip90VI5oJrqDCeC7SPptRKu7pAxcF10xZ+PfzErA
         fInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgz/Djjon8JkpfSssPQphU3ki++kBUAfgIVgXczgsW4=;
        b=QumY0PTLFstIPvuTJ8aMHCrkoNEJQMjRTVDb5j0s+xT8oLSBq1y28pI3Dq3JgKVvgj
         BGVd+MjUF1eEteEn+FqwvlSFVKuR0OTCmFgxohLZQl+QpisI5TIeS+qvfUz/lUGAXFeQ
         zWTMsISY5/OBOcA9/axG+DosdXT6VQ3gLFVz+XVms56PRrgIXku1OBNN9/acXzFE0HAh
         McqhtsLKG9tzBvDtNv/ROHW/EBnPCMPEcD+SDVW7fPchjB+q692ZO28CSiiHlRsXmkGI
         ur1J7MwDoEdP7GXbEqs+EJcTqIJZKnuB9kfiauDj4o6pyJ9fgXEj/oBIPSsnfCJiadnV
         rp5Q==
X-Gm-Message-State: AO0yUKXCWuHJ2ve/WMjkdeNDWluxnta+uUoH0kwU5JfWHcKr6qXYT707
        ecZCRUvk8qxNhtnNU7rMAaeIYQ==
X-Google-Smtp-Source: AK7set8D4X5l66tyx1++Qt6S5OywQT89DpL4bGWD4TuPqWS1oorrBx8v0SQeMQr+7yhYkpYfA0BFLw==
X-Received: by 2002:a62:7911:0:b0:5a9:4af:b05b with SMTP id u17-20020a627911000000b005a904afb05bmr7735128pfc.12.1677683984329;
        Wed, 01 Mar 2023 07:19:44 -0800 (PST)
Received: from smtpclient.apple ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b005ae02dc5b94sm8093180pfi.219.2023.03.01.07.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2023 07:19:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] locking/atomic: cmpxchg: Make __generic_cmpxchg_local
 compare against zero-extended 'old' value
From:   Matt Evans <mev@rivosinc.com>
In-Reply-To: <e27d184e-2561-4efe-a191-8c0401f815b0@app.fastmail.com>
Date:   Wed, 1 Mar 2023 15:19:40 +0000
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7DB3543-8DB2-49F8-85A4-E9288843BCDD@rivosinc.com>
References: <8B94CEAB-63AD-400F-A5CD-31AC4490EF4C@rivosinc.com>
 <e27d184e-2561-4efe-a191-8c0401f815b0@app.fastmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

> On 26 Feb 2023, at 10:13, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Wed, Feb 1, 2023, at 19:39, Matt Evans wrote:
>> __generic_cmpxchg_local takes unsigned long old/new arguments which
>> might end up being up-cast from smaller signed types (which will
>> sign-extend).  The loaded compare value must be compared against a
>> truncated smaller type, so down-cast appropriately for each size.
>>=20
>> The issue is apparent on 64-bit machines with code, such as
>> atomic_dec_unless_positive(), that sign-extends from int.
>>=20
>> 64-bit machines generally don't use the generic cmpxchg but
>> development/early ports might make use of it, so make it correct.
>>=20
>> Signed-off-by: Matt Evans <mev@rivosinc.com>
>=20
> Hi Matt,
>=20
> I'm getting emails about nios2 sparse warnings from the
> kernel test robot about your patch. I can also reproduce
> this on armv5:
>=20
>=20
> fs/erofs/zdata.c: note: in included file (through =
/home/arnd/arm-soc/arch/arm/include/asm/cmpxchg.h, =
/home/arnd/arm-soc/arch/arm/include/asm/atomic.h, =
/home/arnd/arm-soc/include/linux/atomic.h, ...):
> include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates =
bits from constant value (5f0ecafe becomes fe)
> include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates =
bits from constant value (5f0ecafe becomes cafe)
> include/asm-generic/cmpxchg-local.h:29:33: warning: cast truncates =
bits from constant value (5f0ecafe becomes fe)
> include/asm-generic/cmpxchg-local.h:30:42: warning: cast truncates =
bits from constant value (5f0edead becomes ad)
> include/asm-generic/cmpxchg-local.h:33:34: warning: cast truncates =
bits from constant value (5f0ecafe becomes cafe)
> include/asm-generic/cmpxchg-local.h:34:44: warning: cast truncates =
bits from constant value (5f0edead becomes dead)
>=20
> This was already warning for the 'new' cast, but now also warns
> for the 'old' cast, so the bot thinks this is a new problem.

Thank you!  Hmm, indeed, it=E2=80=99s =E2=80=9Cmore of the same=E2=80=9D =
warning-wise but your alternative is nicer.

> I managed to shut up the warning by using a binary '&' operator
> instead of the cast, but I wonder if it would be better to do
> also mask this in the caller, when arch_atomic_cmpxchg() with its
> signed argument calls into arch_cmpxchg() with its unsigned argument:

Proposed patch LGTM, but one query:  are the casts in =
arch_[cmp]xchg()=E2=80=99s args necessary?  The new masks should deal =
with the issue (and consistency would imply same for all other users of =
arch_cmpxchg(), not ideal).

> diff --git a/include/asm-generic/atomic.h =
b/include/asm-generic/atomic.h
> index 04b8be9f1a77..e271d6708c87 100644
> --- a/include/asm-generic/atomic.h
> +++ b/include/asm-generic/atomic.h
> @@ -130,7 +130,7 @@ ATOMIC_OP(xor, ^)
> #define arch_atomic_read(v)                    READ_ONCE((v)->counter)
> #define arch_atomic_set(v, i)                  =
WRITE_ONCE(((v)->counter), (i))
>=20
> -#define arch_atomic_xchg(ptr, v)               =
(arch_xchg(&(ptr)->counter, (v)))
> -#define arch_atomic_cmpxchg(v, old, new)       =
(arch_cmpxchg(&((v)->counter), (old), (new)))
> +#define arch_atomic_xchg(ptr, v)               =
(arch_xchg(&(ptr)->counter, (u32)(v)))
> +#define arch_atomic_cmpxchg(v, old, new)       =
(arch_cmpxchg(&((v)->counter), (u32)(old), (u32)(new)))
>=20
> #endif /* __ASM_GENERIC_ATOMIC_H */
> diff --git a/include/asm-generic/cmpxchg-local.h =
b/include/asm-generic/cmpxchg-local.h
> index c3e7315b7c1d..f9d52d1f0472 100644
> --- a/include/asm-generic/cmpxchg-local.h
> +++ b/include/asm-generic/cmpxchg-local.h
> @@ -26,20 +26,20 @@ static inline unsigned long =
__generic_cmpxchg_local(volatile void *ptr,
>        raw_local_irq_save(flags);
>        switch (size) {
>        case 1: prev =3D *(u8 *)ptr;
> -               if (prev =3D=3D (u8)old)
> -                       *(u8 *)ptr =3D (u8)new;
> +               if (prev =3D=3D (old & 0xff))
> +                       *(u8 *)ptr =3D (new & 0xffu);
>                break;
>        case 2: prev =3D *(u16 *)ptr;
> -               if (prev =3D=3D (u16)old)
> -                       *(u16 *)ptr =3D (u16)new;
> +               if (prev =3D=3D (old & 0xffffu))
> +                       *(u16 *)ptr =3D (new & 0xffffu);
>                break;
>        case 4: prev =3D *(u32 *)ptr;
> -               if (prev =3D=3D (u32)old)
> -                       *(u32 *)ptr =3D (u32)new;
> +               if (prev =3D=3D (old & 0xffffffffu))
> +                       *(u32 *)ptr =3D (new & 0xffffffffu);
>                break;
>        case 8: prev =3D *(u64 *)ptr;
>                if (prev =3D=3D old)
> -                       *(u64 *)ptr =3D (u64)new;
> +                       *(u64 *)ptr =3D new;
>                break;
>        default:
>                wrong_size_cmpxchg(ptr);

FWIW (including the casts in atomic.h, if you prefer):

Reviewed-by: Matt Evans <mev@rivosinc.com>


Thanks,


Matt


>=20
>=20
>     Arnd

