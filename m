Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7135550CC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376422AbiFVQFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376435AbiFVQEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 12:04:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696134BA1;
        Wed, 22 Jun 2022 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655913873; x=1687449873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eG4q6c4UvYGtzxug36fSTUwHXCGqtjeRSHre942YGGg=;
  b=llCY6TcTc2B4dCCWVQhv81yKwEdAtn5yadjhiwtGPA2l/qyoghHhxrd1
   58Z4Na2DLG2+ZhTMrx76BJo0TP7j0a3agC8bITw6touar09aTBRlbgNfQ
   ZqQsT96X7p/X4CTRPUj3B/yjdCm89Kik0CtOIJdghFGVmbhl5jLPNKFwM
   NJ4tuZJN9CafMU2Bb/w4e/3MGkZj6YVUmNTXWL7rfnkyqzpyKV+ZqcUSK
   3PpfnYj2mdU2IEd8nxFggTf+BCCmgscpB80AhNrSu6U/KuqigKxY/6vv3
   hbw+poKqsbtk6Y+gjsoW9KL2XpyeZiPFIWDSpyvqVf+3nMn12NPH+fy+i
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281191468"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281191468"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="764940851"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2022 09:04:20 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25MG4Ip9006187;
        Wed, 22 Jun 2022 17:04:18 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 8/8] lib: test_bitmap: add compile-time optimization/evaluations assertions
Date:   Wed, 22 Jun 2022 18:04:15 +0200
Message-Id: <20220622160415.589430-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621191553.69455-9-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com> <20220621191553.69455-9-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 21 Jun 2022 21:15:53 +0200

> Add a function to the bitmap test suite, which will ensure that
> compilers are able to evaluate operations performed by the
> bitops/bitmap helpers to compile-time constants when all of the
> arguments are compile-time constants as well, or trigger a build
> bug otherwise. This should work on all architectures and all the
> optimization levels supported by Kbuild.
> The function doesn't perform any runtime tests and gets optimized
> out to nothing after passing the build assertions.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index d5923a640457..3a7b09b82794 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -869,6 +869,50 @@ static void __init test_bitmap_print_buf(void)
>  	}
>  }
>  
> +static void __init test_bitmap_const_eval(void)
> +{
> +	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> +	unsigned long initvar = BIT(2);
> +	unsigned long bitopvar = 0;
> +	unsigned long var = 0;
> +	int res;
> +
> +	/*
> +	 * Compilers must be able to optimize all of those to compile-time
> +	 * constants on any supported optimization level (-O2, -Os) and any
> +	 * architecture. Otherwise, trigger a build bug.
> +	 * The whole function gets optimized out then, there's nothing to do
> +	 * in runtime.
> +	 */
> +
> +	/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
> +	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> +	if (!test_bit(7, bitmap))
> +		bitmap_set(bitmap, 5, 1);

So for now, when building for s390, Clang (up to the latest Git
snapshot) generates some incorrect code here.
It does expand both test_bit() and bitmap_set() to const_test_bit()
and const___set_bit(), but at the same time thinks that starting
from this point, @bitmap and @bitopvar (???) are *not* constants
and fails the assertions below, which is not true and weird.
Any other architecture + compiler couples work fine, including
s390 on GCC.
So would it be acceptable for now to do:

	/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
	bitmap_clear(bitmap, 0, BITS_PER_LONG);
	/*
	 * Some comment saying that this is currently broken
	 * on s390 + Clang
	 */
#if !(defined(__s390__) && defined(__clang__))
	if (!test_bit(7, bitmap))
		bitmap_set(bitmap, 5, 1);
#endif

	/* Equals to `unsigned long bitopvar = BIT(20)` */
	__change_bit(31, &bitopvar);
	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);

[...]

or there could be any better solutions?

(+Cc LLVM folks)

> +
> +	/* Equals to `unsigned long bitopvar = BIT(20)` */
> +	__change_bit(31, &bitopvar);
> +	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
> +
> +	/* Equals to `unsigned long var = BIT(25)` */
> +	var |= BIT(25);
> +	if (var & BIT(0))
> +		var ^= GENMASK(9, 6);
> +
> +	/* __const_hweight<32|64>(BIT(5)) == 1 */
> +	res = bitmap_weight(bitmap, 20);
> +	BUILD_BUG_ON(!__builtin_constant_p(res));
> +
> +	/* !(BIT(31) & BIT(18)) == 1 */
> +	res = !test_bit(18, &bitopvar);
> +	BUILD_BUG_ON(!__builtin_constant_p(res));
> +
> +	/* BIT(2) & GENMASK(14, 8) == 0 */
> +	BUILD_BUG_ON(!__builtin_constant_p(initvar & GENMASK(14, 8)));
> +	/* ~BIT(25) */
> +	BUILD_BUG_ON(!__builtin_constant_p(~var));
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -884,6 +928,7 @@ static void __init selftest(void)
>  	test_for_each_set_clump8();
>  	test_bitmap_cut();
>  	test_bitmap_print_buf();
> +	test_bitmap_const_eval();
>  }
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
> -- 
> 2.36.1

Thanks,
Olek
