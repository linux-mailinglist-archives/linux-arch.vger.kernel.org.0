Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E258F553A4F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353677AbiFUTR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353438AbiFUTRN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 15:17:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC1D1CB2F;
        Tue, 21 Jun 2022 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655839002; x=1687375002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwGnL3cKrVpIYdUCZi0g8IIvLiuF1HHfK1nv3YKvvvI=;
  b=Pk1U1pWwT3Rce9cmXQWWOfWqeyXRMMm5Dg75YZL7KRTOIeLiVHLZBfYM
   cU6TEG3Y565fyXAvgai8ybgBddzkccOEvW16Pz+zaT+wD1GX0S5F738AV
   u5lq0y6HmxfN0Kn2lz+ltcHZPoJR9I9qz/XCS7Se83CTHjDEmi4l05wxl
   GYMcZysMo9+VCvgATJQ5G9B5XVUG/o5IyoDTp+Trm2e5iZCtjtqJrIjkY
   3wkH+7BHn+U4G7Ug+52jsrNuBZHCWUlnk+u3X/OLKb1P5iJCeU0lU/U9C
   XVGGqH2QwuILK+8Ildo5cBzmzQnLaGFhjCMSxIbx43j3k7cx+uKyf5Na+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263247276"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="263247276"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833723127"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 12:16:19 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25LJG7oG012650;
        Tue, 21 Jun 2022 20:16:17 +0100
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
Subject: [PATCH v4 7/8] bitmap: don't assume compiler evaluates small mem*() builtins calls
Date:   Tue, 21 Jun 2022 21:15:52 +0200
Message-Id: <20220621191553.69455-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621191553.69455-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Intel kernel bot triggered the build bug on ARC architecture that
in fact is as follows:

	DECLARE_BITMAP(bitmap, BITS_PER_LONG);

	bitmap_clear(bitmap, 0, BITS_PER_LONG);
	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

which can be expanded to:

	unsigned long bitmap[1];

	memset(bitmap, 0, sizeof(*bitmap));
	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

In most cases, a compiler is able to expand small/simple mem*()
calls to simple assignments or bitops, in this case that would mean:

	unsigned long bitmap[1] = { 0 };

	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

and on most architectures this works, but not on ARC, despite having
-O3 for every build.
So, to make this work, in case when the last bit to modify is still
within the first long (small_const_nbits()), just use plain
assignments for the rest of bitmap_*() functions which still use
mem*(), but didn't receive such compile-time optimizations yet.
This doesn't have the same coverage as compilers provide, but at
least something to start:

text: add/remove: 3/7 grow/shrink: 43/78 up/down: 1848/-3370 (-1546)
data: add/remove: 1/11 grow/shrink: 0/8 up/down: 4/-356 (-352)

notably cpumask_*() family when NR_CPUS <= BITS_PER_LONG:

netif_get_num_default_rss_queues              38       4     -34
cpumask_copy                                  90       -     -90
cpumask_clear                                146       -    -146

and the abovementioned assertion started passing.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/linux/bitmap.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..a0f4f3af8d30 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -238,20 +238,32 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0, len);
+
+	if (small_const_nbits(nbits))
+		*dst = 0;
+	else
+		memset(dst, 0, len);
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0xff, len);
+
+	if (small_const_nbits(nbits))
+		*dst = ~0UL;
+	else
+		memset(dst, 0xff, len);
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memcpy(dst, src, len);
+
+	if (small_const_nbits(nbits))
+		*dst = *src;
+	else
+		memcpy(dst, src, len);
 }
 
 /*
@@ -431,6 +443,8 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
+	else if (small_const_nbits(start + nbits))
+		*map |= GENMASK(start + nbits - 1, start);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
@@ -445,6 +459,8 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
+	else if (small_const_nbits(start + nbits))
+		*map &= ~GENMASK(start + nbits - 1, start);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
-- 
2.36.1

