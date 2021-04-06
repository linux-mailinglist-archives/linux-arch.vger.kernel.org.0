Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6C3558B7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbhDFQDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbhDFQDk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:03:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA24C06174A;
        Tue,  6 Apr 2021 09:03:30 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m13so15605007oiw.13;
        Tue, 06 Apr 2021 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXuMvybWpRt4PM+Qgqf16jsNWFOgCO9JLNdluWmfwc4=;
        b=rSCmibMZ1dZuqDCb7K7iRXGaa8DLdSW4UpceS/oPeHg+aAa3Z5dA+LFLCLjP+BjCFr
         pzg8FZHT4DPAPK5dQ5Hqx7gh6IraXjbGQl/mWrYWcEJhOpuDuNQnkLc8cEVurIJ+7qbc
         ZDTTh7llH8wy3gRD8aGWRRRHICrI1AnHgo3Di5+K0fiPTayiM9VJzzrrDeikkbgndhoi
         b9bBgIPbHAYOfmCffNl/DyIday9v8t4AuQ559y4y8zEQEbVM8uK/XLMobgkBuExjzARa
         XilwGSaxZ4wGJKOwVg60GyAT7QLU9T8/g8beUCVGMhoO9xsC7SaLIIsI9oswNuEFVOvD
         tWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXuMvybWpRt4PM+Qgqf16jsNWFOgCO9JLNdluWmfwc4=;
        b=pFeapIRO+AR1GyIJnjkmLFrttRnz5TNpb8gnY2bBG8cmGMUOWizcG26UiWb/Mnr8Bp
         UzXvHvHxye7BPy8E4EqtYc8zbDWMHgEyQiQKza7XufVsj+CJzbyo+WKTdI29qKK+mYCC
         6tY7VItm+cXaLqdbYN2XEDFFHtIS9iM7ISqAYCJ35S+kVkHeyZnvP3SUBcleN+wzI/R0
         mQjZYOFhIWj9wnRCX+7zOk6ZZVBxi9bQ0ADFHaOkOdyEXLgYilL8EkfrI7gP8cFGsNcC
         v2dzVPpn32Y665AcoCq39iMztxNrKApLwETd6puxxntCLNQFLRteyT6pMshMEJuAyl4M
         Xo/w==
X-Gm-Message-State: AOAM530IONOdKkTEPmnB7pPyO6MiMzqfKawyphLkdss3vmoaT/TKGTw0
        W5zd0DC5t69aJIpiBXB0OiU=
X-Google-Smtp-Source: ABdhPJwtPQ3FMWZbLH53D6bk91CTQ7Dnfs4MpY6aB20C8cA1Che99rkav8rsszNojUM6Cj43TZKsGw==
X-Received: by 2002:aca:1b01:: with SMTP id b1mr3652063oib.177.1617725009996;
        Tue, 06 Apr 2021 09:03:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8sm4630528otp.71.2021.04.06.09.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Apr 2021 09:03:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Apr 2021 09:03:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 11/13] lib: add fast path for find_first_*_bit() and
 find_last_bit()
Message-ID: <20210406160327.GA180841@roeck-us.net>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-12-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316015424.1999082-12-yury.norov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 15, 2021 at 06:54:22PM -0700, Yury Norov wrote:
> Similarly to bitmap functions, users would benefit if we'll handle
> a case of small-size bitmaps that fit into a single word.
> 
> While here, move the find_last_bit() declaration to bitops/find.h
> where other find_*_bit() functions sit.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/asm-generic/bitops/find.h | 50 ++++++++++++++++++++++++++++---
>  include/linux/bitops.h            | 12 --------
>  lib/find_bit.c                    | 12 ++++----
>  3 files changed, 52 insertions(+), 22 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 4148c74a1e4d..8d818b304869 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -5,6 +5,9 @@
>  extern unsigned long _find_next_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long nbits,
>  		unsigned long start, unsigned long invert, unsigned long le);
> +extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
> +extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> +extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
>  
>  #ifndef find_next_bit
>  /**
> @@ -102,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>   * Returns the bit number of the first set bit.
>   * If no bits are set, returns @size.
>   */
> -extern unsigned long find_first_bit(const unsigned long *addr,
> -				    unsigned long size);
> +static inline
> +unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr & BITS_FIRST(size - 1);
> +
> +		return val ? __ffs(val) : size;

This patch results in:

include/asm-generic/bitops/find.h: In function 'find_last_bit':
include/asm-generic/bitops/find.h:164:16: error: implicit declaration of function '__fls'; did you mean '__ffs'?

and:

./include/asm-generic/bitops/__fls.h: At top level:
./include/asm-generic/bitops/__fls.h:13:38: error: conflicting types for '__fls'

when building scripts/mod/devicetable-offsets.o.

Seen with h8300 builds.

Guenter

> +	}
> +
> +	return _find_first_bit(addr, size);
> +}
>  
>  /**
>   * find_first_zero_bit - find the first cleared bit in a memory region
> @@ -113,8 +125,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
>   * Returns the bit number of the first cleared bit.
>   * If no bits are zero, returns @size.
>   */
> -extern unsigned long find_first_zero_bit(const unsigned long *addr,
> -					 unsigned long size);
> +static inline
> +unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr | ~BITS_FIRST(size - 1);
> +
> +		return val == ~0UL ? size : ffz(val);
> +	}
> +
> +	return _find_first_zero_bit(addr, size);
> +}
>  #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
>  #ifndef find_first_bit
> @@ -126,6 +147,27 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>  
>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>  
> +#ifndef find_last_bit
> +/**
> + * find_last_bit - find the last set bit in a memory region
> + * @addr: The address to start the search at
> + * @size: The number of bits to search
> + *
> + * Returns the bit number of the last set bit, or size.
> + */
> +static inline
> +unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr & BITS_FIRST(size - 1);
> +
> +		return val ? __fls(val) : size;
> +	}
> +
> +	return _find_last_bit(addr, size);
> +}
> +#endif
> +
>  /**
>   * find_next_clump8 - find next 8-bit clump with set bits in a memory region
>   * @clump: location to store copy of found clump
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index a5a48303b0f1..26bf15e6cd35 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -286,17 +286,5 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>  })
>  #endif
>  
> -#ifndef find_last_bit
> -/**
> - * find_last_bit - find the last set bit in a memory region
> - * @addr: The address to start the search at
> - * @size: The number of bits to search
> - *
> - * Returns the bit number of the last set bit, or size.
> - */
> -extern unsigned long find_last_bit(const unsigned long *addr,
> -				   unsigned long size);
> -#endif
> -
>  #endif /* __KERNEL__ */
>  #endif
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 2470ae390f3c..e2c301d28568 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -75,7 +75,7 @@ EXPORT_SYMBOL(_find_next_bit);
>  /*
>   * Find the first set bit in a memory region.
>   */
> -unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  {
>  	unsigned long idx;
>  
> @@ -86,14 +86,14 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>  
>  	return size;
>  }
> -EXPORT_SYMBOL(find_first_bit);
> +EXPORT_SYMBOL(_find_first_bit);
>  #endif
>  
>  #ifndef find_first_zero_bit
>  /*
>   * Find the first cleared bit in a memory region.
>   */
> -unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  {
>  	unsigned long idx;
>  
> @@ -104,11 +104,11 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  
>  	return size;
>  }
> -EXPORT_SYMBOL(find_first_zero_bit);
> +EXPORT_SYMBOL(_find_first_zero_bit);
>  #endif
>  
>  #ifndef find_last_bit
> -unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> +unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
>  {
>  	if (size) {
>  		unsigned long val = BITS_FIRST_MASK(size - 1);
> @@ -124,7 +124,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
>  	}
>  	return size;
>  }
> -EXPORT_SYMBOL(find_last_bit);
> +EXPORT_SYMBOL(_find_last_bit);
>  #endif
>  
>  unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
