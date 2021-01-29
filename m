Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAA308F16
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhA2VLt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhA2VLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:11:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D10FC06174A;
        Fri, 29 Jan 2021 13:11:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y205so7005666pfc.5;
        Fri, 29 Jan 2021 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lLJH6wGpbFuj0IJWQQeHITjZneLVulSJuUvdnDWMbY=;
        b=QtRKN8NH/DzC+3SzwtpiiqfC2nryUUmnIkvftX8d3jsJEq/87GLpMN2GT5qMpiCFm4
         MYUkAoaB3/nZDk5BTvXQJWAKTIJQGfJkBKAnOyK52eo70mngbvfhqPFEyTk5QdhlxZ21
         zXA0275SvvFMvNI1gXOPhhpzWS2Za/aEwmmdTgc9i3YObBnPbdozv6WJ3mtJeKSw23RG
         zhUlD6ylcWKX6dXIDjeqtnQqlFOTs22LRBzoY1JLaXW8Ne3LUhaq8xfyId9CLge/WStT
         GSTEEGc1SAc6XKPpd5hukBrrzhIgrXZMdnfiCv8DXRDQlkPSgnnH0JNDGqtUcANuEsAm
         jUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lLJH6wGpbFuj0IJWQQeHITjZneLVulSJuUvdnDWMbY=;
        b=lOSYR5r2apsCG7r4Ihl+Kt/5PGiNSNFa2bdxh07xnvhJXhMZmQM2gEDyqA+MHFtxs5
         hnf0TqulbZOK6yMlHeNHyt5Ca1mAmLNBepi/IM9+qmN+RF1gD390iPSgQxr6ZaQ9ZioJ
         3gS8UHtU2alLEAB6Pf0Tc5AQekEYoEyifSNdJYPAB4JSgsT2NY65sbzzMVBy5bTiUJni
         oXKRlu9AplEv7FG1Cimi+qRM4fLZAr+xmKm+EEJ3BS9ftr0hKO8sYohNzwpkq0JpBRFP
         EqoszCC1ocF28R0TGS7h0qu5Gd/3YtVVxC7V9wJ5bVxDVq2QeEtOhe8QQ7SiLlftIdv2
         ulcw==
X-Gm-Message-State: AOAM531QUbZELXNPnGBwek+eZhYI+4ryND1ABvH/GCTiwrcZB/AniGT9
        Tzu6LkJh8WcClBb45uLJ4pOi7z2dTDz2SxPHLNo=
X-Google-Smtp-Source: ABdhPJyKW6Z/95t+hHhCZW1namNNCkIlh//UBqOWDRX49nhShezelkJMtz0JqWU9szoU6YK4ygAc/WnsuNls9IwVCBQ=
X-Received: by 2002:a62:5a86:0:b029:1ae:6b45:b6a9 with SMTP id
 o128-20020a625a860000b02901ae6b45b6a9mr5965005pfb.7.1611954662708; Fri, 29
 Jan 2021 13:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20210129204528.2118168-1-yury.norov@gmail.com> <20210129204528.2118168-4-yury.norov@gmail.com>
In-Reply-To: <20210129204528.2118168-4-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jan 2021 23:10:46 +0200
Message-ID: <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
Subject: Re: [PATCH 2/5] bits_per_long.h: introduce SMALL_CONST() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 10:49 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Many algorithms become simplier if they are passed with relatively small

simpler

> input values. One example is bitmap operations when the whole bitmap fits
> into one word. To implement such simplifications, linux/bitmap.h declares
> small_const_nbits() macro.
>
> Other subsystems may also benefit from optimizations of this sort, like
> find_bit API in the following patches. So it looks helpful to generalize
> the macro and extend it's visibility.

> It should probably go to linux/kernel.h, but doing that creates circular
> dependencies. So put it in asm-generic/bitsperlong.h.

No, no, please leave kernel.h alone. It's already quite a mess.

And this shouldn't be in the commit message either.

...

> -       if (small_const_nbits(nbits))
> +       if (SMALL_CONST(nbits - 1))

Not sure if we need to rename it.

...

> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -37,7 +37,7 @@
>  #define GENMASK(h, l) \
>         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>
> -#define BITS_FIRST(nr)         GENMASK(nr), 0)
> +#define BITS_FIRST(nr)         GENMASK((nr), 0)

How come?!

...

> diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
> index 8f2283052333..432d272baf27 100644
> --- a/tools/include/asm-generic/bitsperlong.h
> +++ b/tools/include/asm-generic/bitsperlong.h

I think a tools update would be better to have in a separate patch.

-- 
With Best Regards,
Andy Shevchenko
