Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D647559962
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiFXMOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiFXMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 08:13:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7892A414;
        Fri, 24 Jun 2022 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072819; x=1687608819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9jL8NMkwUoLyGdxlrOaxo4xSZkgTsdTKbiPOLXLDqI=;
  b=YNQCERsDf/K1JB7qK3JUbMNW5zIE8F6lHWRASRsEd4TY0posRZ5hoKkB
   nBxPan+zdn4bkdmbvPb5MrUP6qVrUMMt3o6x69F1eejQp73lO0524NphN
   c6asKNQIcf55cFtQmEj2GLe/tg8JyyqzK1/XilVpSaCQbjxH+M55fVBlH
   7jeZTmkxa3v552eRZC5Ih5kOmpgdXMHucrzFIR+HwOx45Of6xBF/V60ql
   kyqTiG+NRW1shvUxK+ReEOXsLrGiOerFskFcD7GMzMrwIvJjiti/fX1zJ
   aWewNn9QyuNgEZV2iWm074f7zy6+2FbpuNcKeXCheKGM0NO63428yUm2k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306454400"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="306454400"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="563831558"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 24 Jun 2022 05:13:32 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25OCDEo9014999;
        Fri, 24 Jun 2022 13:13:29 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 9/9] lib: test_bitmap: add compile-time optimization/evaluations assertions
Date:   Fri, 24 Jun 2022 14:13:13 +0200
Message-Id: <20220624121313.2382500-10-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a function to the bitmap test suite, which will ensure that
compilers are able to evaluate operations performed by the
bitops/bitmap helpers to compile-time constants when all of the
arguments are compile-time constants as well, or trigger a build
bug otherwise. This should work on all architectures and all the
optimization levels supported by Kbuild.
The function doesn't perform any runtime tests and gets optimized
out to nothing after passing the build assertions.
Unfortunately, Clang for s390 is currently broken (up to the latest
Git snapshots) -- see the comment in the code -- so for now there's
a small workaround for it which doesn't alter the logics. Hope we'll
be able to remove it one day (bugreport is on its way).

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d5923a640457..25967cfa4ab2 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -869,6 +869,67 @@ static void __init test_bitmap_print_buf(void)
 	}
 }
 
+static void __init test_bitmap_const_eval(void)
+{
+	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
+	unsigned long initvar = BIT(2);
+	unsigned long bitopvar = 0;
+	unsigned long var = 0;
+	int res;
+
+	/*
+	 * Compilers must be able to optimize all of those to compile-time
+	 * constants on any supported optimization level (-O2, -Os) and any
+	 * architecture. Otherwise, trigger a build bug.
+	 * The whole function gets optimized out then, there's nothing to do
+	 * in runtime.
+	 */
+
+	/*
+	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
+	 * Clang on s390 optimizes bitops at compile-time as intended, but at
+	 * the same time stops treating @bitmap and @bitopvar as compile-time
+	 * constants after regular test_bit() is executed, thus triggering the
+	 * build bugs below. So, call const_test_bit() there directly until
+	 * the compiler is fixed.
+	 */
+	bitmap_clear(bitmap, 0, BITS_PER_LONG);
+#if defined(__s390__) && defined(__clang__)
+	if (!const_test_bit(7, bitmap))
+#else
+	if (!test_bit(7, bitmap))
+#endif
+		bitmap_set(bitmap, 5, 2);
+
+	/* Equals to `unsigned long bitopvar = BIT(20)` */
+	__change_bit(31, &bitopvar);
+	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
+
+	/* Equals to `unsigned long var = BIT(25)` */
+	var |= BIT(25);
+	if (var & BIT(0))
+		var ^= GENMASK(9, 6);
+
+	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
+	res = bitmap_weight(bitmap, 20);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(res != 2);
+
+	/* !(BIT(31) & BIT(18)) == 1 */
+	res = !test_bit(18, &bitopvar);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* BIT(2) & GENMASK(14, 8) == 0 */
+	res = initvar & GENMASK(14, 8);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(res);
+
+	/* ~BIT(25) */
+	BUILD_BUG_ON(!__builtin_constant_p(~var));
+	BUILD_BUG_ON(~var != ~BIT(25));
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -884,6 +945,7 @@ static void __init selftest(void)
 	test_for_each_set_clump8();
 	test_bitmap_cut();
 	test_bitmap_print_buf();
+	test_bitmap_const_eval();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.36.1

