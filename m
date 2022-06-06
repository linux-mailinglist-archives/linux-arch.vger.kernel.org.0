Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4753F14C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiFFU7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiFFU7t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 16:59:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF469419D;
        Mon,  6 Jun 2022 13:48:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 68so3359620qkk.9;
        Mon, 06 Jun 2022 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g2dcvEx5ujIfq/vGwsQoEKMbkEYSqcC+pGjcA0dBu1c=;
        b=f7b0v5dv8hmLnBlzL8WyYq5cOW64Y5WX7Dmpl69JKaPauL++ld78WKF8ntff7E3FD9
         /EFPnKoGaHbNkPIgpiRh5FlgefHuwLc1yxNkOW+bHut9SVnVZCbu/JkykiPElo5zPWjp
         nCuHLbsnuv21eFXD2iNnywm2Hbn427FK25GFy6T1JFuumczjXmgtp3nChf3HO/XhNBhM
         NXjSU4JD0/Av3t8AAMTU1yL794U7NXS8pa6qxIcfy7ouTJCp/SF65MboQcoKMXA5+/fk
         R0q5tIVK+/ksEV405xlxflOCs1qdnp/FFVTP6I8k8VtwErnFZfCokgUB0civbDGx+Ib2
         7GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g2dcvEx5ujIfq/vGwsQoEKMbkEYSqcC+pGjcA0dBu1c=;
        b=IT4u7CmoWi6HX3yhfCZqnTHklKmxYH70Mp+prygtX+X6iGXyqlLSeFvgwYgtWeyCIe
         zukDYBHOhQpWQ1q4hlEkCBpFtMsevyKSdhfgx7Z+rthrdfpneV1EgNvq6t8I6Rgldw0i
         jcclSJPD3P8m6fnA8vXzh3wBBCb1TJ6obXLFPH0KtRlEjFuc6gEJo5qI4Q0H6hCxpGTL
         msZiPybmC9OmoG/4Ze8naFtdxZLmus0O6Ss3HsawvXDIX9t9LOKyQPjgY0S4qtLOT//E
         cTkdZR/ZoWNoUrPTtdl0YBCwQJcifH8LmS00KuogVNBk0PGGz4c4JRxPrN6uVO7WeJus
         b3pA==
X-Gm-Message-State: AOAM5324/lN02Hp6ppOB50edRazNGpcO8OmeBT+t9dHI8l47wpIwyJVC
        aez+24OtinCucnef5Re+mzw=
X-Google-Smtp-Source: ABdhPJy6iWrSjhT1+WPfkKbI1gHvATNgUCtpwq8y3JhsiD76yT4Gvelb8RZZw4VB5N3/itiqM6ja8g==
X-Received: by 2002:a05:620a:14ad:b0:6a6:b8ab:9c3f with SMTP id x13-20020a05620a14ad00b006a6b8ab9c3fmr5227234qkj.410.1654548537353;
        Mon, 06 Jun 2022 13:48:57 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:be9c:b2d9:3353:7a73])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006a6d20386f6sm900223qkb.42.2022.06.06.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:48:56 -0700 (PDT)
Date:   Mon, 6 Jun 2022 13:48:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
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
Subject: Re: [PATCH 4/6] bitops: unify non-atomic bitops prototypes across
 architectures
Message-ID: <Yp5oMmzNlq+Ut4So@yury-laptop>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
 <20220606114908.962562-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606114908.962562-5-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 01:49:05PM +0200, Alexander Lobakin wrote:
> Currently, there is a mess with the prototypes of the non-atomic
> bitops across the different architectures:
> 
> ret	bool, int, unsigned long
> nr	int, long, unsigned int, unsigned long
> addr	volatile unsigned long *, volatile void *
> 
> Thankfully, it doesn't provoke any bugs, but can sometimes make
> the compiler angry when it's not handy at all.
> Adjust all the prototypes to the following standard:
> 
> ret	bool				retval can be only 0 or 1
> nr	unsigned long			native; signed makes no sense
> addr	volatile unsigned long *	bitmaps are arrays of ulongs
> 
> Finally, add some static assertions in order to prevent people from
> making a mess in this room again.
> I also used the %__always_inline attribute consistently they always
> get resolved to the actual operations.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---

Reviewed-by: Yury Norov <yury.norov@gmail.com>

[...]

> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 7aaed501f768..5520ac9b1c24 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -26,12 +26,25 @@ extern unsigned int __sw_hweight16(unsigned int w);
>  extern unsigned int __sw_hweight32(unsigned int w);
>  extern unsigned long __sw_hweight64(__u64 w);
>  
> +#include <asm-generic/bitops/generic-non-atomic.h>
> +
>  /*
>   * Include this here because some architectures need generic_ffs/fls in
>   * scope
>   */
>  #include <asm/bitops.h>
>  
> +/* Check that the bitops prototypes are sane */
> +#define __check_bitop_pr(name)	static_assert(__same_type(name, gen_##name))
> +__check_bitop_pr(__set_bit);
> +__check_bitop_pr(__clear_bit);
> +__check_bitop_pr(__change_bit);
> +__check_bitop_pr(__test_and_set_bit);
> +__check_bitop_pr(__test_and_clear_bit);
> +__check_bitop_pr(__test_and_change_bit);
> +__check_bitop_pr(test_bit);
> +#undef __check_bitop_pr

This one is amazing trick! And the series is good overall. Do you want me to
take it in bitmap tree, when it's ready, or you'll move it somehow else?

Thanks,
Yury
