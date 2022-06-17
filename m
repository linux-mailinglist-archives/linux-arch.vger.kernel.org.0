Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07954F95A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382591AbiFQOlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382355AbiFQOk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:40:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEB52503;
        Fri, 17 Jun 2022 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655476855; x=1687012855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THeq/t7OeFGS7kF1qxlxBPZVHuRcSkjtN1FGjFL0hbM=;
  b=WiB2oJ65/7rC7dKmiifE/o5i4GQSJvwbBbKJWyw63DekzX0cSPtYA1um
   BtS5NwkP0JEnPh+MqOH4qyq3/K6RPkWQYwodgPATdRdTl/0QrEeEMnDNv
   6c0wKm8f1rixz6eqLujFLBoXEPmMyh/+gQqbP44aNbBgbT50nXVQzgAmT
   P3gj514DMqVc6wDvQyTkkjiQfLpi8vLY+yvoRndyzxIthb3IphXlqeNqq
   AbqlfsQdbspNcn41oPrV+AK8WlvlSxnC0ZwMmIo4guHXfxHEKh6qBwVtN
   SzzqJWLx1Iile7Lttt85XIWlI+/ydRNBp0ATJ45Z26kB4F/fCQ/5BikUK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280246910"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280246910"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763274890"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2022 07:40:49 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25HEeXl9024161;
        Fri, 17 Jun 2022 15:40:47 +0100
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
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] lib: test_bitmap: add compile-time optimization/evaluations assertions
Date:   Fri, 17 Jun 2022 16:40:31 +0200
Message-Id: <20220617144031.2549432-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 lib/test_bitmap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index d5923a640457..3a7b09b82794 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -869,6 +869,50 @@ static void __init test_bitmap_print_buf(void)
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
+	/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
+	bitmap_clear(bitmap, 0, BITS_PER_LONG);
+	if (!test_bit(7, bitmap))
+		bitmap_set(bitmap, 5, 1);
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
+	/* __const_hweight<32|64>(BIT(5)) == 1 */
+	res = bitmap_weight(bitmap, 20);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+
+	/* !(BIT(31) & BIT(18)) == 1 */
+	res = !test_bit(18, &bitopvar);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+
+	/* BIT(2) & GENMASK(14, 8) == 0 */
+	BUILD_BUG_ON(!__builtin_constant_p(initvar & GENMASK(14, 8)));
+	/* ~BIT(25) */
+	BUILD_BUG_ON(!__builtin_constant_p(~var));
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -884,6 +928,7 @@ static void __init selftest(void)
 	test_for_each_set_clump8();
 	test_bitmap_cut();
 	test_bitmap_print_buf();
+	test_bitmap_const_eval();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.36.1

