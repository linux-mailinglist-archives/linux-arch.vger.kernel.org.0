Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A76296B10
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375888AbgJWITv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369877AbgJWITu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Oct 2020 04:19:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FDC0613CE
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 01:19:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so803396wrl.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c04+KAnI/YvtT+KXpxHEmQlq7f8efi6nrfby4HpMQ+M=;
        b=KdSPGpNlX1wlRZC80Im3mkC0rHOX3I6+VHgDyeDFAsOwsVKlcD0ZlgvbenjZHwKgXb
         L0FUqlQL5D3e3H/lmjXBb5lC5pBuw+0JjIc8xzDikPQxu+w8gIcNrpG2eXXKcDMoCkBG
         FmlN3i4HcZH5JPkJroF3N5NLN0WLs/zf1AF0PY1Js104sOd+jRRVIEs/qmd0n/2ZQhm3
         acdOcqtjMERwdLJkUU6OY/32SjyPFxK4nogplxj8eCp1OqH9pzFwn1LnMExE8C5KHtp8
         Mg4R7KWZPYkZZKWKPBi0cSrHm8pY/dTaowehfa647U3JKXLgdVQXpJl2/bGCpzriNOWO
         ZVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c04+KAnI/YvtT+KXpxHEmQlq7f8efi6nrfby4HpMQ+M=;
        b=pmCwnRjW4QJssnppMeOrNbNImKa6IOvTziTSz2kJAHbVs7n2y6d46HK+vOkNU4GPNr
         zcAQl5e8+JKyy+kz0oWDCuc/tZrc4ZlhB92fU6G3Etr5hDwVMc7gFIUI8xHUfA6eSxYk
         e7I26GVt5WIcjFrWVdTfM44mLJCsqpnXbRyWhwGO2PRrQUuk22tNlbUQ3Ro0a04tZ3M2
         HZ6QDKZNbUntOoJWHlgkFF/y2EySL3utl4lyap2rl3cyf9gphORG4TGy29nde53cHxIW
         rHFhIYYT2SBx/D0D04NzA4f5Hzr8BMPjU+63mcODGRsryJjkdL2l5162Ta7MIGK8EqUL
         fYQw==
X-Gm-Message-State: AOAM531qh2+qaBFk3dWtTQ4d6PURvlTtsIRNwn+SLXh3CCEPWh2K29Dm
        f5lzwwxkiOolCdvmGwqdAOgoHQ5UGTUdhedtkHT1Zw==
X-Google-Smtp-Source: ABdhPJyx6xrzHENLvmCTKNKQGYNBnXcfF3pvPdkMAurICf9diwE560i3HqF33Tzi+YjwmeJj7wuwgbOA8/erWwn+wQM=
X-Received: by 2002:a05:6000:1109:: with SMTP id z9mr1197789wrw.388.1603441188297;
 Fri, 23 Oct 2020 01:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201023081628.1296884-1-glider@google.com>
In-Reply-To: <20201023081628.1296884-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 23 Oct 2020 10:19:36 +0200
Message-ID: <CAG_fn=Vu8Of2tMDsHsXroQNb++uKAnGg1vMAatCQAH2ZDSU=BA@mail.gmail.com>
Subject: Re: [PATCH v4] x86: add failure injection to get/put/clear_user
To:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert Linde <albert.linde@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(Albert's @google.com address is gone, removing it from CC list)

On Fri, Oct 23, 2020 at 10:16 AM Alexander Potapenko <glider@google.com> wr=
ote:
>
> From: Albert van der Linde <alinde@google.com>
>
> To test fault-tolerance of user memory acceses in x86, add support for
> fault injection.
>
> Make both put_user() and get_user() fail with -EFAULT, and clear_user()
> fail by not clearing any bytes.
>
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Albert van der Linde <alinde@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
>
> ---
> v2:
>  - no significant changes
>
> v3:
>  - no changes
>
> v4:
>  - instrument the new out-of-line implementations of get_user()/put_user(=
)
>  - fix a minor checkpatch warning in the inline assembly
>
> ---
> ---
>  arch/x86/include/asm/uaccess.h | 36 ++++++++++++++++++++++------------
>  arch/x86/lib/usercopy_64.c     |  3 +++
>  2 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index f13659523108..7041ebc48b75 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -5,6 +5,7 @@
>   * User space memory access functions
>   */
>  #include <linux/compiler.h>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/string.h>
>  #include <asm/asm.h>
> @@ -126,11 +127,16 @@ extern int __get_user_bad(void);
>         int __ret_gu;                                                   \
>         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);            \
>         __chk_user_ptr(ptr);                                            \
> -       asm volatile("call __" #fn "_%P4"                               \
> -                    : "=3Da" (__ret_gu), "=3Dr" (__val_gu),             =
   \
> -                       ASM_CALL_CONSTRAINT                             \
> -                    : "0" (ptr), "i" (sizeof(*(ptr))));                \
> -       (x) =3D (__force __typeof__(*(ptr))) __val_gu;                   =
 \
> +       if (should_fail_usercopy()) {                                   \
> +               (x) =3D 0;                                               =
 \
> +               __ret_gu =3D -EFAULT;                                    =
 \
> +       } else {                                                        \
> +               asm volatile("call __" #fn "_%P4"                       \
> +                            : "=3Da" (__ret_gu), "=3Dr" (__val_gu),     =
   \
> +                               ASM_CALL_CONSTRAINT                     \
> +                            : "0" (ptr), "i" (sizeof(*(ptr))));        \
> +               (x) =3D (__force __typeof__(*(ptr))) __val_gu;           =
 \
> +       }                                                               \
>         __builtin_expect(__ret_gu, 0);                                  \
>  })
>
> @@ -213,14 +219,18 @@ extern void __put_user_nocheck_8(void);
>         int __ret_pu;                                                   \
>         register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);           \
>         __chk_user_ptr(ptr);                                            \
> -       __val_pu =3D (x);                                                =
 \
> -       asm volatile("call __" #fn "_%P[size]"                          \
> -                    : "=3Dc" (__ret_pu),                                =
 \
> -                       ASM_CALL_CONSTRAINT                             \
> -                    : "0" (ptr),                                       \
> -                      "r" (__val_pu),                                  \
> -                      [size] "i" (sizeof(*(ptr)))                      \
> -                    :"ebx");                                           \
> +       if (unlikely(should_fail_usercopy())) {                         \
> +               __ret_pu =3D -EFAULT;                                    =
 \
> +       } else {                                                        \
> +               __val_pu =3D (x);                                        =
 \
> +               asm volatile("call __" #fn "_%P[size]"                  \
> +                            : "=3Dc" (__ret_pu),                        =
 \
> +                               ASM_CALL_CONSTRAINT                     \
> +                            : "0" (ptr),                               \
> +                              "r" (__val_pu),                          \
> +                              [size] "i" (sizeof(*(ptr)))              \
> +                            : "ebx");                                  \
> +       }                                                               \
>         __builtin_expect(__ret_pu, 0);                                  \
>  })
>
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index 508c81e97ab1..5617b3864586 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -7,6 +7,7 @@
>   * Copyright 2002 Andi Kleen <ak@suse.de>
>   */
>  #include <linux/export.h>
> +#include <linux/fault-inject-usercopy.h>
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
>
> @@ -50,6 +51,8 @@ EXPORT_SYMBOL(__clear_user);
>
>  unsigned long clear_user(void __user *to, unsigned long n)
>  {
> +       if (should_fail_usercopy())
> +               return n;
>         if (access_ok(to, n))
>                 return __clear_user(to, n);
>         return n;
> --
> 2.29.0.rc2.309.g374f81d7ae-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
