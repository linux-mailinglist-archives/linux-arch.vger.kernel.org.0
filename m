Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8348F559967
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiFXMOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiFXMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 08:13:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F8D22BE5;
        Fri, 24 Jun 2022 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072818; x=1687608818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwGnL3cKrVpIYdUCZi0g8IIvLiuF1HHfK1nv3YKvvvI=;
  b=OTR8kwk8G6qwygQIVU7DL7WOO1p+YBBOIoTHAu6jphg7NHpi4vcr41Lx
   XyT+QhnziYKbP++UZdYnZ4si4YXsKezzuoLPPDMgyNteQsR9DywDO8ga+
   3FGyDP+EP5DfuN25xHiI4Fi0wLW7DUV9np7F+GmXPv0qWG47032dpt9ak
   q+1t3DvOX1KeeN7hp33TUw2URRbHTpOsnwJHrEo4nbuRZSB7m8FiyhJn9
   DTv1LQcUXyT+3F/lluDCoRLiiSYdV3T9yONZ+dKVXhBMonZVt6g/ykmY6
   azzNJDE7wkSNXGlvBmb1Zdxg3qkpFsYx9uJivQ4Xkda20ShRRR0UxGQms
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="264027543"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="264027543"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="765726377"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2022 05:13:30 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25OCDEo8014999;
        Fri, 24 Jun 2022 13:13:28 +0100
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
Subject: [PATCH v5 8/9] bitmap: don't assume compiler evaluates small mem*() builtins calls
Date:   Fri, 24 Jun 2022 14:13:12 +0200
Message-Id: <20220624121313.2382500-9-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
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

