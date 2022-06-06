Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80E53E62E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiFFLun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiFFLuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 07:50:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5D2432C9;
        Mon,  6 Jun 2022 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654516225; x=1686052225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UfNxvkyTgN3+Cr6Fria9sdwavpE+KYijn4w/ioe52M=;
  b=LMdAzzAnYg9rbvevBxctjV6grB9+O2OF8x9+ZItRFySIwIjljrRS8KjC
   1FnubVQim8Gyax6LD+zckium+4qZs32c5GEXJtCDayl8IANljKO2Oj2tZ
   ysHiYgsfFS34cI3SHuvXDM3jgHrBp/x0/333y5Yc+ol1XaifhcaX9/1zs
   kS3kb5U0wq2bBS30TV/oJvpirQglTorCDjiTxa8DYmfBQoX1o8cJHOaup
   xnxjEIcRoq47S+pByQv7bqtRwGA9q9CZ6k09bismqNSg72U8QxEh8R7WR
   3ANr6Da/J/XGN+LTyKJNFbeUod2azVCcRf4XYzNGo3P1gDriwrKY6I3ID
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339919670"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="339919670"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 04:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583594985"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2022 04:50:18 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 256BoDHi010626;
        Mon, 6 Jun 2022 12:50:17 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
Subject: [PATCH 3/6] bitops: define gen_test_bit() the same way as the rest of functions
Date:   Mon,  6 Jun 2022 13:49:04 +0200
Message-Id: <20220606114908.962562-4-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606114908.962562-1-alexandr.lobakin@intel.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, the generic test_bit() function is defined as a one-liner
and in case with constant bitmaps the compiler is unable to optimize
it to a constant. At the same time, gen_test_and_*_bit() are being
optimized pretty good.
Define gen_test_bit() the same way as they are defined.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/asm-generic/bitops/generic-non-atomic.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
index 7a60adfa6e7d..202d8a3b40e1 100644
--- a/include/asm-generic/bitops/generic-non-atomic.h
+++ b/include/asm-generic/bitops/generic-non-atomic.h
@@ -118,7 +118,11 @@ gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
 static __always_inline int
 gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
 {
-	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long val = *p;
+
+	return !!(val & mask);
 }
 
 #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
-- 
2.36.1

