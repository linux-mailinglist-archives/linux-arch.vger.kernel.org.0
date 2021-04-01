Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7693510F1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAIgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 04:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhDAIfs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 04:35:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE0C0613E6;
        Thu,  1 Apr 2021 01:35:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f10so1101300pgl.9;
        Thu, 01 Apr 2021 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVWxBV7AAcEU+9GV07Fj7VLJdKFcDyXYfOYCJpN3/Vw=;
        b=R0SX9ZHt4mk0/lyKsmkproGfhH9a2F/mQbKzjw5o5yJQjwY+F1zwV8PQA3FJ/pyXOu
         6gUnMFePtYjKX9l7A1g9jeNliSZku4IaeHDwKOsHFpzd0Q/zl51sdTOWb1VC/nowQ+BJ
         bb8eEqS6618xUhOHQ99O6QKNkzgCXSOS+wEayuvjsqpYOYEHKGRrSsnmxmPhbRMdtx01
         yQsZ3OdcEUkF9JqIvQiog89sYu4j/0UyGW+2HKEQ4KocIrfMj8XeGq03nNpkN7w8e0Rl
         vT44K0k6vDvutPyo+BfCYZFc6hNocrNmfwucin2RtRcMuawcOwuaxsfwRn0jUCrWECqg
         Vt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVWxBV7AAcEU+9GV07Fj7VLJdKFcDyXYfOYCJpN3/Vw=;
        b=O4MEp9+Ho9tUAfzD0bq0pgTYzRXS2UIL6zfpwzUnMkQwHdUGD4lFl2xr38eWrwFq/a
         DnUhw41U325gD5anV3vmQHjYpKAutHqB0yPpwmA6lNg/SJwVIJYqzxC8qhQzqzuO/pAg
         m2rLW9NFJt38iGG8pBUfblqnybTbisXpjHwzxzAMN+V+lwZfvg1D2DNJUDpmRT+Hf6Jb
         hZ3qfAje+O+dSOjYUdnYq3nuMSvkzkiQjUAf5RQbe41cP7h2PJ0jqM9iUJxqMW9UuxsX
         4PKzpMvmuy1HspYfr+9RhMtQKwcfMCAOgjcLpgOkE006HTFrjBh8wwpJD96nvbe+cf6A
         4iaQ==
X-Gm-Message-State: AOAM532d8TUts41e4t8ZccufoEeJ89cii2Z1GOKUXiwklgkOop6fkmaY
        KhCOE6aJd8Fq9ZEPqjFPh7MPcJk/e0gru1pvQ09u1WcMYLY=
X-Google-Smtp-Source: ABdhPJxJ0LERe+QskxE4j9CC+8mm9/t+p7kYOj9gx8UnJVa90NEQL87WRUv6loCfopemfWX1wM7oOMVRATjPvqA9WXY=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr6410772pfb.7.1617266147657; Thu, 01
 Apr 2021 01:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-6-yury.norov@gmail.com>
In-Reply-To: <20210401003153.97325-6-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 11:35:31 +0300
Message-ID: <CAHp75Veq1ghvLq0Ms77ANx3Lb-QMWOq0CnxPeL0X7V-XeipUAA@mail.gmail.com>
Subject: Re: [PATCH 05/12] lib: extend the scope of small_const_nbits() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 3:41 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> find_bit would also benefit from small_const_nbits() optimizations.
> The detailed comment is provided by Rasmus Villemoes.

Thanks, now it looks good!
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/asm-generic/bitsperlong.h | 12 ++++++++++++
>  include/linux/bitmap.h            |  8 --------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> index 3905c1c93dc2..1023e2a4bd37 100644
> --- a/include/asm-generic/bitsperlong.h
> +++ b/include/asm-generic/bitsperlong.h
> @@ -23,4 +23,16 @@
>  #define BITS_PER_LONG_LONG 64
>  #endif
>
> +/*
> + * small_const_nbits(n) is true precisely when it is known at compile-time
> + * that BITMAP_SIZE(n) is 1, i.e. 1 <= n <= BITS_PER_LONG. This allows
> + * various bit/bitmap APIs to provide a fast inline implementation. Bitmaps
> + * of size 0 are very rare, and a compile-time-known-size 0 is most likely
> + * a sign of error. They will be handled correctly by the bit/bitmap APIs,
> + * but using the out-of-line functions, so that the inline implementations
> + * can unconditionally dereference the pointer(s).
> + */
> +#define small_const_nbits(nbits) \
> +       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> +
>  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2cb1d7cfe8f9..a36cfcec4e77 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -230,14 +230,6 @@ int bitmap_print_to_pagebuf(bool list, char *buf,
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>
> -/*
> - * The static inlines below do not handle constant nbits==0 correctly,
> - * so make such users (should any ever turn up) call the out-of-line
> - * versions.
> - */
> -#define small_const_nbits(nbits) \
> -       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> -
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
>         unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
