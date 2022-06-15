Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0354BFDF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 04:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbiFOC5t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiFOC5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 22:57:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187DB248DA;
        Tue, 14 Jun 2022 19:57:46 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x75so7822576qkb.12;
        Tue, 14 Jun 2022 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ls3qnOc3Y8ik7fKx57iztJUjc3L1QowbApEutA1WMAM=;
        b=D+5npGiiuE3tRYO8NhlD6qhHvcccG8Vxfnv6wfrSVuKzX7LyVC4KT9zql8SPiKUIxI
         8FNDjNNBwMD/dn55TSvmtyrbYhBz+80Pg17k0lWHU6mKosqKTeGKv2N80Uy5nUKXpjLb
         HqPsQ9rHG6pk693Wuq5M7P/HHFcaAqU3Mnw15XB9A7Cy4pqAs0912OYP7J1EQMKE9Pbz
         Ko4FsA2HMLxcR+DQLSYuI1U13ZqSIcAblkDZ+u02usZBsfMDi3kb3Si39YITI3LczE0V
         g2OuLpHyxbiURFKAfc13ksdi0gTez8MJ+lkA51ElWu50xSz4Q3cmIwWwjJxDMpukzg4p
         qtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ls3qnOc3Y8ik7fKx57iztJUjc3L1QowbApEutA1WMAM=;
        b=FzoxvHRBfenEW9AICCuLSMPlmrczpmXpuPPTHXCUiKcmCfWFZJ8yMl5Ui7C7w9v7dz
         WhVrwWULx56KXYx+lBEnw/xvci+7NWBPx3j1rgs+IlZ8oJRmbxIrJrMGI1wh87N1f8/K
         JE33xrWtTvPH8nHg2AZmbtmQD6fk3S16CHOaW/WDapGftN3XOR+RERX3eu7K9hMQGpX+
         MT7YfxTzwqSrjMvCT0lynIiAMXM0Kp0ywFt9+vM7rmOj/w910Qb3k1h3va30lU6qqTtv
         X2g/U6yXtLAG9nO8Mz5vPkUYSgJJId933Bx+PqVgIvaFuJv7EviObVkdCixC5IN3Nz9r
         2QDw==
X-Gm-Message-State: AOAM530fjfRRgi1dQqHliNxW8q2UmfRX1NeqWii1DzbqnuDEOrlZjUWR
        MQTwhWt3a6AAC3vwjtUnP/s=
X-Google-Smtp-Source: ABdhPJwV9cU/wWxXkh2q4YyhQFXlXjXiQMMsoxo4sdQjN2TqrKDzK/oA8wxG66gqqSjqKy4P1WAP1A==
X-Received: by 2002:a05:620a:17ac:b0:6a7:5a21:8cbb with SMTP id ay44-20020a05620a17ac00b006a75a218cbbmr6528178qkb.570.1655261865117;
        Tue, 14 Jun 2022 19:57:45 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:6d39:b768:5789:ec2a])
        by smtp.gmail.com with ESMTPSA id n7-20020a37a407000000b006a66f3d3708sm10044500qke.129.2022.06.14.19.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:57:44 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:57:43 -0700
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
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the
 non-atomics
Message-ID: <YqlKpwjQ4Hu+Lr8u@yury-laptop>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610113427.908751-5-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always to resolve those to compile-time constants as well.

will be always able?

> Those are mostly direct aliases for generic_*() with one exception
> for const_test_bit(): the original one is declared atomic-safe and
> thus doesn't discard the `volatile` qualifier, so in order to let
> optimize the code, define it separately disregarding the qualifier.
> Add them to the compile-time type checks as well just in case.
> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
>  include/linux/bitops.h                        |  3 +-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> index 3ce0fa0ab35f..9a77babfff35 100644
> --- a/include/asm-generic/bitops/generic-non-atomic.h
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -121,4 +121,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
>  
> +/*
> + * const_*() definitions provide good compile-time optimizations when
> + * the passed arguments can be resolved at compile time.
> + */
> +#define const___set_bit			generic___set_bit
> +#define const___clear_bit		generic___clear_bit
> +#define const___change_bit		generic___change_bit
> +#define const___test_and_set_bit	generic___test_and_set_bit
> +#define const___test_and_clear_bit	generic___test_and_clear_bit
> +#define const___test_and_change_bit	generic___test_and_change_bit
> +
> +/**
> + * const_test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + *
> + * A version of generic_test_bit() which discards the `volatile` qualifier to
> + * allow the compiler to optimize code harder. Non-atomic and to be used only
> + * for testing compile-time constants, e.g. from the corresponding macro, or
> + * when you really know what you are doing.

Not sure I understand the last sentence... Can you please rephrase?

> + */
> +static __always_inline bool
> +const_test_bit(unsigned long nr, const volatile unsigned long *addr)
> +{
> +	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long val = *p;
> +
> +	return !!(val & mask);
> +}
> +
>  #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 87087454a288..51c22b8667b4 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -36,7 +36,8 @@ extern unsigned long __sw_hweight64(__u64 w);
>  
>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)						\
> -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> +	static_assert(__same_type(const_##name, generic_##name) &&	\
> +		      __same_type(arch_##name, generic_##name) &&	\
>  		      __same_type(name, generic_##name))
>  
>  __check_bitop_pr(__set_bit);
> -- 
> 2.36.1
