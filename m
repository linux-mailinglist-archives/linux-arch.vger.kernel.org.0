Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53D5465C6
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbiFJLgQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349373AbiFJLgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 07:36:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A4719C4;
        Fri, 10 Jun 2022 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860955; x=1686396955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7c74IH5zXtMHvz1DnqxXwajlv0u5rM/yQqyI4XwsmRY=;
  b=ew0YcM9TqehF+f6t4QSA93r81E0W2vZ04BdhHjHZKLo6tsFVIbfnC3dH
   k1hLT/sh6SL7VpY3PXbX0oUeDJ+C7m8wuLU/RlKnOaCehNZVIMsZ/NCcG
   dBvKID/1U90lsK4tXrhR//fAhCVeYaQTlYB7diTGTPltMfRHvcIauLiqI
   2bVWDoP76bICjhxVFcjNtxkckzePyfUCjA7IQcR47QHPW+SAQ+Proptb2
   63qjgG4y6D9VvFYsdUoX5p5kECr7mbiTRrliZyNpu7CG5AmxB/ff8qORt
   BYzhx1Dur+VaJsMRzPAxIZPZH0ZhSyL+VzejDcY1Itd4RnjOm2gIFjRhu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363934337"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="363934337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="556339717"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2022 04:35:31 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25ABZKim030333;
        Fri, 10 Jun 2022 12:35:29 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Fri, 10 Jun 2022 13:34:27 +0200
Message-Id: <20220610113427.908751-7-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610113427.908751-1-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, many architecture-specific non-atomic bitop
implementations use inline asm or other hacks which are faster or
more robust when working with "real" variables (i.e. fields from
the structures etc.), but the compilers have no clue how to optimize
them out when called on compile-time constants. That said, the
following code:

	DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
	unsigned long bar = BIT(BAR_BIT);
	unsigned long baz = 0;

	__set_bit(FOO_BIT, foo);
	baz |= BIT(BAZ_BIT);

	BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
	BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
	BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));

triggers the first assertion on x86_64, which means that the
compiler is unable to evaluate it to a compile-time initializer
when the architecture-specific bitop is used even if it's obvious.
In order to let the compiler optimize out such cases, expand the
bitop() macro to use the "constant" C non-atomic bitop
implementations when all of the arguments passed are compile-time
constants, which means that the result will be a compile-time
constant as well, so that it produces more efficient and simple
code in 100% cases, comparing to the architecture-specific
counterparts.

The savings are architecture, compiler and compiler flags dependent,
for example, on x86_64 -O2:

GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)

and ARM64 (courtesy of Mark):

GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/linux/bitops.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 753f98e0dcf5..364bdc3606b4 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -33,8 +33,24 @@ extern unsigned long __sw_hweight64(__u64 w);
 
 #include <asm-generic/bitops/generic-non-atomic.h>
 
+/*
+ * Many architecture-specific non-atomic bitops contain inline asm code and due
+ * to that the compiler can't optimize them to compile-time expressions or
+ * constants. In contrary, gen_*() helpers are defined in pure C and compilers
+ * optimize them just well.
+ * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
+ * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
+ * the arguments can be resolved at compile time. That expression itself is a
+ * constant and doesn't bring any functional changes to the rest of cases.
+ * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
+ * passing a bitmap from .bss or .data (-> `!!addr` is always true).
+ */
 #define bitop(op, nr, addr)						\
-	op(nr, addr)
+	((__builtin_constant_p(nr) &&					\
+	  __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) &&	\
+	  (uintptr_t)(addr) != (uintptr_t)NULL &&			\
+	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
+	 const##op(nr, addr) : op(nr, addr))
 
 #define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
 #define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
-- 
2.36.1

