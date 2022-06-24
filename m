Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F555995C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiFXMOG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiFXMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 08:13:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317822510;
        Fri, 24 Jun 2022 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072815; x=1687608815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1zzpdfJLbGPP5uEwMaw/RHBA/HUWtG2WXRsHiWWAyc=;
  b=iM0G0IgcsTuIu4t/KJnpoKyc4/6oXNyrPZ1JrXtQbJo5MyAdsUNkVlU6
   SUKiarlqOKWnGYke2QgDXsUmN3m+0OBmYMIDv6hAJKhAqfMQT17SO9FXv
   71hOzslsE7UZS57eGI6wbtf3hfSBX5aDWj4tdE/Pi+dMfg7Xdn8OiJsSB
   dVAM1687BsiG8oT5OsH5uKIwPSUU6u4zMkE0wBqSdGJ5sz28RkK+bCYG3
   g4n2n+y6RGM4bPeA8HcvJqnfmXcWnw7r8YiUCq/ruC2ZwKjs9yDWhT4uv
   XjQQ63YveR7kcuBiPA7hZ9W5D3TsKSDO1kPFqYXJEudwS0RhUDb491eIc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342676783"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342676783"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="678522227"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2022 05:13:28 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25OCDEo7014999;
        Fri, 24 Jun 2022 13:13:26 +0100
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
Subject: [PATCH v5 7/9] net/ice: fix initializing the bitmap in the switch code
Date:   Fri, 24 Jun 2022 14:13:11 +0200
Message-Id: <20220624121313.2382500-8-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kbuild spotted the following bug during the testing of one of
the optimizations:

In file included from include/linux/cpumask.h:12,
[...]
                from drivers/net/ethernet/intel/ice/ice_switch.c:4:
drivers/net/ethernet/intel/ice/ice_switch.c: In function 'ice_find_free_recp_res_idx.constprop':
include/linux/bitmap.h:447:22: warning: 'possible_idx[0]' is used uninitialized [-Wuninitialized]
  447 |                 *map |= GENMASK(start + nbits - 1, start);
      |                      ^~
In file included from drivers/net/ethernet/intel/ice/ice.h:7,
                 from drivers/net/ethernet/intel/ice/ice_lib.h:7,
                 from drivers/net/ethernet/intel/ice/ice_switch.c:4:
drivers/net/ethernet/intel/ice/ice_switch.c:4929:24: note: 'possible_idx[0]' was declared here
 4929 |         DECLARE_BITMAP(possible_idx, ICE_MAX_FV_WORDS);
      |                        ^~~~~~~~~~~~
include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
   11 |         unsigned long name[BITS_TO_LONGS(bits)]
      |                       ^~~~

%ICE_MAX_FV_WORDS is 48, so bitmap_set() here was initializing only
48 bits, leaving a junk in the rest 16.
It was previously hidden due to that filling 48 bits makes
bitmap_set() call external __bitmap_set(), but after making it use
plain bit arithmetics on small bitmaps, compilers started seeing
the issue. It was still working because those 16 weren't used
anywhere anyhow.
bitmap_{clear,set}() are not really intended to initialize bitmaps,
rather to modify already initialized ones, as they don't do anything
past the passed number of bits. The correct function to do this in
that particular case is bitmap_fill(), so use it here. It will do
`*possible_idx = ~0UL` instead of `*possible_idx |= GENMASK(47, 0)`,
not leaving anything in an undefined state.

Fixes: fd2a6b71e300 ("ice: create advanced switch recipe")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 8d8f3eec79ee..9b2872e89151 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4934,7 +4934,7 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 	bitmap_zero(recipes, ICE_MAX_NUM_RECIPES);
 	bitmap_zero(used_idx, ICE_MAX_FV_WORDS);
 
-	bitmap_set(possible_idx, 0, ICE_MAX_FV_WORDS);
+	bitmap_fill(possible_idx, ICE_MAX_FV_WORDS);
 
 	/* For each profile we are going to associate the recipe with, add the
 	 * recipes that are associated with that profile. This will give us
-- 
2.36.1

