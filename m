Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2333D032
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhCPI5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhCPI4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 04:56:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685AC061756
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 01:56:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p7so59474934eju.6
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vr+DDhX4zCUcoDYqyVxp3WEAsa/2/5gUa+nZx6tBWmE=;
        b=Nq34Egdh9YX3VVX62IcMgmxwB/4u6FR0wjqNsrSRjEpOBYIu8LhRgW60T8wqxDOHZz
         gO2EaShHGJTkpCB6y6ajMK57915siiFZyV/1tRAsFH6VsfE+u1HGx2e2+zVumH98rY1D
         AHHRkwEXJZKMZjZVIContITRe4Bb8aCXYcHKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vr+DDhX4zCUcoDYqyVxp3WEAsa/2/5gUa+nZx6tBWmE=;
        b=ni6QR0rXilyWH+U23onIswyDlOtZh5VFFuInVKSlonKMPfydT5swN2IU1wZr+3KpOv
         gm99APkfA1VnBgqV5tqlSgQNbpFsXzUp2xIJgj8HGcF77IPnwjFcau3A56cdFKWie/8I
         B5EJp5B1a5Y6d0u6uoHQnADZY/QckxgdP+q94mdIUPRspInrtiKRFnqTL04zEfCiC7YC
         LN6VAU4gMiHxhD1+gL3BUhZx6BmLvjHNI4ZeZKJfpmHKYtxedcFA+ZjNENQ7MM8efmd/
         C63dGgGcChLx4KFzQewvaYVlVhtAhW9b8gGwqivGunz2dRgcT5kX/s3gQt9MA13NYPrM
         xUYg==
X-Gm-Message-State: AOAM530H1E2r9ycwjdXLUOtcIwyTTHv59z/QEOHYhh2MbtcRfHCtd8u8
        cnFoVVC7lRBx/FJtm7JNZ3lN7g==
X-Google-Smtp-Source: ABdhPJxHvQ2aE5lisF3Pz70RSm0bjPVX5M/gyrEzCyLBzCKdnJILukPK03qeLTL3O/Kl+uRdMg6SzQ==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr25564420ejc.326.1615885011190;
        Tue, 16 Mar 2021 01:56:51 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id q25sm5857563edt.51.2021.03.16.01.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:56:50 -0700 (PDT)
Subject: Re: [PATCH 06/13] lib: extend the scope of small_const_nbits() macro
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-7-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e89b04d4-c2d5-1999-ed72-45bdc03a7bab@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 09:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316015424.1999082-7-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/03/2021 02.54, Yury Norov wrote:
> find_bit would also benefit from small_const_nbits() optimizations.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/asm-generic/bitsperlong.h | 9 +++++++++
>  include/linux/bitmap.h            | 3 ---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> index 3905c1c93dc2..96032f4f908f 100644
> --- a/include/asm-generic/bitsperlong.h
> +++ b/include/asm-generic/bitsperlong.h
> @@ -23,4 +23,13 @@
>  #define BITS_PER_LONG_LONG 64
>  #endif
>  
> +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
> +
> +/*
> + * The valid number of bits for a bitmap to be small enough, or in other words,
> + * fit into a single machine word is 1 to BITS_PER_LONG inclusively. 0 is not a
> + * valid number for size, and most probably a sing of error.
> + */
> +#define small_const_nbits(n) SMALL_CONST((n) - 1)
> +

I still don't see the point of introducing SMALL_CONST and still don't
like the much-too-generic-name - especially since AFAICT you don't
actually use it anywhere outside the definition of small_const_nbits()?

>  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index adf7bd9f0467..bc13a890ecc1 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>   * so make such users (should any ever turn up) call the out-of-line
>   * versions.
>   */

You added another comment near its new definition, but the left-behind
comment in bitmap.h is now somewhat confusing, no? I suggest expanding
your new comment a bit so it's clear why we're interested in whether a
bitmap is known at compile-time to consist of exactly one word:

/*
small_const_nbits(n) is true precisely when it is known at compile-time
that BITMAP_SIZE(n) is 1, i.e. 1 <= n <= BITS_PER_LONG. This allows
various bit/bitmap APIs to provide a fast inline implementation. Bitmaps
of size 0 are very rare, and a compile-time-known-size 0 is most likely
a sign of error. They will be handled correctly by the bit/bitmap APIs,
but using the out-of-line functions, so that the inline implementations
can unconditionally dereference the pointer(s).
*/

> -#define small_const_nbits(nbits) \
> -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> -
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
>  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> 

Rasmus
