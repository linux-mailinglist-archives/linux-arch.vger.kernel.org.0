Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27C31F2CB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 00:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBRXIM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 18:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBRXIK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2021 18:08:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC3AC061756
        for <linux-arch@vger.kernel.org>; Thu, 18 Feb 2021 15:07:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ly28so8307399ejb.13
        for <linux-arch@vger.kernel.org>; Thu, 18 Feb 2021 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sJ5d0ZObxlJmFwJLKE12O8RmYqwub+T3UwgmplQq6AE=;
        b=Jo5g6iOuyD0BqTUzqL5h57SSH+EeNnhpMwvLvFVX6MxUWBTDBsqzDxkvg8FpT/imeV
         liNLub0Tlg4eSf0srTc9b7UGVY2O8Njj4v1Pg1ZuNmLScVnb1WDVaszWS5AJZwbQt33H
         qp17CzaTpYHW1EsfgC4jpRW4lgndPH6DdJYhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sJ5d0ZObxlJmFwJLKE12O8RmYqwub+T3UwgmplQq6AE=;
        b=OhLYmjQnNTSD0YYG/KeHMyppcyHNuit6QCVWH/Xp8qdqKOJOY3tgbPc+tjctcaE1l+
         EWinpccx+MgCbZyB8GemBF6krgLZsRGOgjSo/hjUPzwZuZO4BVAnjPFHmUgZH/GMxhSe
         MQphKM+rXhnUnrUIoUxRrjch1hqx/ZuUy2Z9lt8bqXZUIxRztb/xNVeiciGs6Fs7oX4r
         ZpTd4UZeC26hidviJjNeSqoeomJ1CqB/BwUBlwrAhszEQJUSj6qJEJFQCex3lQctKndN
         aEYYTvj0qczdRQFLNstDKnVqUBOa5sJpaMeXFvkvVcuZyZ4Lswo1Vkp03ei/9UUR8H6v
         ntkw==
X-Gm-Message-State: AOAM531eda2UEaqOAE3tuHcKAIqOLvzDRFmoRwgqUQ+LHLYCgdCJ1IUo
        ZEl9lcouvMqQqeZD6NQ4XpCy0UsgrT1u8w==
X-Google-Smtp-Source: ABdhPJzYHdNT9GqXgfQD21oEC7iYSyGizicKOn318FZ+K56DF/69E5Vl8IATzjttfzUAWvPTfps3Mw==
X-Received: by 2002:a17:906:2a8b:: with SMTP id l11mr6170970eje.1.1613689648835;
        Thu, 18 Feb 2021 15:07:28 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id a23sm3383140ejy.60.2021.02.18.15.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 15:07:28 -0800 (PST)
Subject: Re: [PATCH 06/14] bitsperlong.h: introduce SMALL_CONST() macro
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
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-7-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <55f1e25a-3211-8247-9dd3-3777e29287db@rasmusvillemoes.dk>
Date:   Fri, 19 Feb 2021 00:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218040512.709186-7-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18/02/2021 05.05, Yury Norov wrote:
> Many algorithms become simpler if they are passed with relatively small
> input values. One example is bitmap operations when the whole bitmap fits
> into one word. To implement such simplifications, linux/bitmap.h declares
> small_const_nbits() macro.
> 
> Other subsystems may also benefit from optimizations of this sort, like
> find_bit API in the following patches. So it looks helpful to generalize
> the macro and extend it's visibility.

Perhaps, but SMALL_CONST is too generic a name, it needs to keep "bits"
somewhere in there. So why not just keep it at small_const_nbits?

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/asm-generic/bitsperlong.h |  2 ++
>  include/linux/bitmap.h            | 33 ++++++++++++++-----------------
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> index 3905c1c93dc2..0eeb77544f1d 100644
> --- a/include/asm-generic/bitsperlong.h
> +++ b/include/asm-generic/bitsperlong.h
> @@ -23,4 +23,6 @@
>  #define BITS_PER_LONG_LONG 64
>  #endif
>  
> +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
> +
>  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index adf7bd9f0467..e89f1dace846 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>   * so make such users (should any ever turn up) call the out-of-line
>   * versions.
>   */
> -#define small_const_nbits(nbits) \
> -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> -
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
>  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> @@ -278,7 +275,7 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
>  static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
>  			const unsigned long *src2, unsigned int nbits)
>  {
> -	if (small_const_nbits(nbits))
> +	if (SMALL_CONST(nbits - 1))

Please don't force most users to be changed to something less readable.
What's wrong with just keeping small_const_nbits() the way it is,
avoiding all this churn and keeping the readability?

At a quick reading, one of the very few places where you end up not
passing nbits-1 but just nbits is this

 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
+	if (SMALL_CONST(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;

which is a regression, for much the same reason the nbits==0 case was
excluded from small_const_nbits in the first place. If size is 0, we
used to just return 0 early in _find_next_bit. But you've introduced a
dereference of addr before that check is now done, which is
theoretically an oops.

If find_next_zero_bit_le cannot handle nbits==BITS_PER_LONG efficiently
but requires one off-limits bit position, fine, so be it, add an extra
"small_const_nbits() && nbits < BITS_PER_LONG" (and a comment).

Rasmus
