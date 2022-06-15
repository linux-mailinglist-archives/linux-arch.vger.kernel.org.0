Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0247954C027
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350908AbiFOD1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 23:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbiFOD1A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 23:27:00 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BCF3C483;
        Tue, 14 Jun 2022 20:26:56 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k18so7512000qtm.9;
        Tue, 14 Jun 2022 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2BMd5PQI/AN3W5kxMglFR7hp5GiYxPCuJsRFhG3zU0=;
        b=NrbTIj9uosp/fBmWwEhojKx49KKtr/6VlileB+SXfC0XY9lv7WwMdRcn1I5aVe3RGK
         gAQ0iuYC5bbbg4b/hH0sxr/MGzujxQVNhV95YeupbmAHDJbTdhJ32sR/jqLzx0agtx8U
         aewJifOXqdx8EMaDoN0W3fDFSltOtXmH51jePLoIPjx2+65IO15qNBGRLnT2GtU9Frsf
         2t/SGUNsUbqEdHPREitJ/RGJ2Nr4o8hnTBn9EeloM1gR65GNF2ZaTLq1aBGWtKVIJtjL
         NPuDrE90hwtb5AM8LI6bV9w7PjIPnDYbOTddZk24Hm6V7v/v4bgH0LybLN6nQXLXqdJ9
         tH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2BMd5PQI/AN3W5kxMglFR7hp5GiYxPCuJsRFhG3zU0=;
        b=eRG4Ur+pSFi/9EZOViEpZACbi/cXyI6ZSyMFZLLzuWtGbboWZcMUqA2yZKV09364XO
         RK80s5qu/FsdUHh4OJKPT2fQr8YQMoXcjJgA2I1kcUFQafPwNyeh1pWT1NezWaCVm6xN
         ZZ875XGy9EKsEh9rFj8WEUjiicC1TDsTmW0mHyaDJ+yVONPioNLYB9kb+TOFETV9JN2j
         vWF5hXRq7UJcdeagKbVhHCJ4xrUQBVPBLGxj9Fxe7oWcFs8C2Rz5aZOXLNfqg6kWfJ33
         BAKeYpMO5JUdq3G7nNTihK8gnBLkv4tU4Ffr8kZ5hx5zTjYex1McDsJWJq1JMdu/Ur6c
         JZiQ==
X-Gm-Message-State: AOAM532lrFCgmoX+DJyC1pzixNZm/D/9bU0LL+/MT68oPzyY6rCkMMYH
        3Sv5nbAqeRs39JNVoe6Snro=
X-Google-Smtp-Source: ABdhPJzV0mHnB4jH1W9MDP6SaV/TVsZlCcXhe7YLdHSDXFUJdxPer0qWeEW1SiIyIyuPLut0Lz7xVg==
X-Received: by 2002:ac8:5a50:0:b0:305:20c4:791d with SMTP id o16-20020ac85a50000000b0030520c4791dmr7221901qta.437.1655263615762;
        Tue, 14 Jun 2022 20:26:55 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:6d39:b768:5789:ec2a])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a410500b006a787380a5csm7875637qko.67.2022.06.14.20.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 20:26:55 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:26:54 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <YqlRfoB5+VBIw8gJ@yury-laptop>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-7-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610113427.908751-7-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexander,

On Fri, Jun 10, 2022 at 01:34:27PM +0200, Alexander Lobakin wrote:
> Currently, many architecture-specific non-atomic bitop
> implementations use inline asm or other hacks which are faster or
> more robust when working with "real" variables (i.e. fields from
> the structures etc.), but the compilers have no clue how to optimize
> them out when called on compile-time constants. That said, the
> following code:
> 
> 	DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
> 	unsigned long bar = BIT(BAR_BIT);
> 	unsigned long baz = 0;
> 
> 	__set_bit(FOO_BIT, foo);
> 	baz |= BIT(BAZ_BIT);
> 
> 	BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
> 	BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
> 	BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));

Can you put this snippet into lib/test_bitops.c?

Thanks,
Yury

> triggers the first assertion on x86_64, which means that the
> compiler is unable to evaluate it to a compile-time initializer
> when the architecture-specific bitop is used even if it's obvious.
> In order to let the compiler optimize out such cases, expand the
> bitop() macro to use the "constant" C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well, so that it produces more efficient and simple
> code in 100% cases, comparing to the architecture-specific
> counterparts.
> 
> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
> 
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> 
> and ARM64 (courtesy of Mark):
> 
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  include/linux/bitops.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 753f98e0dcf5..364bdc3606b4 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -33,8 +33,24 @@ extern unsigned long __sw_hweight64(__u64 w);
>  
>  #include <asm-generic/bitops/generic-non-atomic.h>
>  
> +/*
> + * Many architecture-specific non-atomic bitops contain inline asm code and due
> + * to that the compiler can't optimize them to compile-time expressions or
> + * constants. In contrary, gen_*() helpers are defined in pure C and compilers
> + * optimize them just well.
> + * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
> + * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
> + * the arguments can be resolved at compile time. That expression itself is a
> + * constant and doesn't bring any functional changes to the rest of cases.
> + * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
> + * passing a bitmap from .bss or .data (-> `!!addr` is always true).
> + */
>  #define bitop(op, nr, addr)						\
> -	op(nr, addr)
> +	((__builtin_constant_p(nr) &&					\
> +	  __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) &&	\
> +	  (uintptr_t)(addr) != (uintptr_t)NULL &&			\
> +	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
> +	 const##op(nr, addr) : op(nr, addr))
>  
>  #define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
>  #define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
> -- 
> 2.36.1
