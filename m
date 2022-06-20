Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CD55152E
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiFTKEB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbiFTKDe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 06:03:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314113F6A;
        Mon, 20 Jun 2022 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655719399; x=1687255399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zzztM5Ztw2pX+OG+K1EH92bRdh0HXV7pnoB7w/qVhi0=;
  b=HUGZvDZjbfPv0H9q+FWFnaIar/OHwp82sBUKIMJMQUR3IwPFiP+EmYdi
   iRQjJrl8/2J6QsQO0UNXclgWd+sm6VVWgUzQBaM7E505LXVCcEG4hxuUg
   7dRpW8YN8xsgSOF/x/0cAVvQEZULmanDX7XyoOCc3g1HpSIqsaWH9i5Je
   3RLmj3BApkBQKB2Jvc+6nAD1LEhZmOsnFT8sQ2kZPvt6GxUgYLTxgZTaZ
   DC95N0yVj9dHByAvXsWT3QXx/eLdVftfpEiVmDZ9lWirYF6LPZDzARqL9
   yf7Dkt3ZWKBUmx/aESNDSTW+YJfir9f5N9iUsaWdjL2dUz9h0hWqd3EJH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262890999"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262890999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:03:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584833961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:03:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3EFP-000h50-US;
        Mon, 20 Jun 2022 13:03:07 +0300
Date:   Mon, 20 Jun 2022 13:03:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
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
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] bitops: define const_*() versions of the
 non-atomics
Message-ID: <YrBF28+iADFHygss@smile.fi.intel.com>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
 <20220617144031.2549432-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617144031.2549432-5-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 17, 2022 at 04:40:28PM +0200, Alexander Lobakin wrote:
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always able to resolve those to compile-time constants as
> well. Those are mostly direct aliases for generic_*() with one
> exception for const_test_bit(): the original one is declared
> atomic-safe and thus doesn't discard the `volatile` qualifier, so
> in order to let optimize code, define it separately disregarding
> the qualifier.
> Add them to the compile-time type checks as well just in case.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
>  include/linux/bitops.h                        |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> index b85b8a2ac239..3d5ebd24652b 100644
> --- a/include/asm-generic/bitops/generic-non-atomic.h
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -127,4 +127,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
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
> + * allow a compiler to optimize code harder. Non-atomic and to be called only
> + * for testing compile-time constants, e.g. by the corresponding macros, not
> + * directly from "regular" code.
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
> index 87087454a288..d393297287d5 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -37,6 +37,7 @@ extern unsigned long __sw_hweight64(__u64 w);
>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)						\
>  	static_assert(__same_type(arch_##name, generic_##name) &&	\
> +		      __same_type(const_##name, generic_##name) &&	\
>  		      __same_type(name, generic_##name))
>  
>  __check_bitop_pr(__set_bit);
> -- 
> 2.36.1
> 

-- 
With Best Regards,
Andy Shevchenko


