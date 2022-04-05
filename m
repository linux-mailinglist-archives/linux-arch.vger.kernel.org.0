Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E634F23B7
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiDEGzV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiDEGzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 02:55:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440F8FE60;
        Mon,  4 Apr 2022 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649141572; x=1680677572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R6S4jkz8rJH+vQOPg4Dg3MbNO5ps2IIpCkrCjpQeDxI=;
  b=Au3+AZkEmxAAk0QdzQz9jMvJCDHORG959UCWhKJKRdSIj3sYI07KCubM
   +EuiXt2pABGQzk7t+Ltm3+WAweb0Vsx+oFCohuRuvpaqHeKRK6vyIhj2d
   O2XRIyOuZfgYfZqmnpztftrDBk9rf99UBlhgiB0VeYPVX3Lay+3jc/SHa
   8YrGrivaoKVJt9S8TW3hbUSx+AqYZ7sf07Yiah+dcTx9Od4wkVpH+9MZ3
   RqyAa0p0Lb8K+qHowQABhfzsAE+hHPopkQwoETdi4pRDuX4T3l8Tss5kK
   zR5gCSqN76Ioqm1jVDAMDT7BaYgi/dTVlSDv1gsMh7bVv1FxU8j2OCUZI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="241264862"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="241264862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 23:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="657822773"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2022 23:52:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbd3X-0002kg-Gq;
        Tue, 05 Apr 2022 06:52:47 +0000
Date:   Tue, 5 Apr 2022 14:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: Add C based string functions
Message-ID: <202204051450.UN2k1raL-lkp@intel.com>
References: <20220404142354.2792428-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404142354.2792428-1-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master linux/master v5.18-rc1 next-20220404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/csky-Add-C-based-string-functions/20220404-222518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220405/202204051450.UN2k1raL-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e8231df5e8121c094f8668e0c850381873aa4249
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review guoren-kernel-org/csky-Add-C-based-string-functions/20220404-222518
        git checkout e8231df5e8121c094f8668e0c850381873aa4249
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/csky/lib/string.c:30:7: warning: no previous prototype for '__memcpy' [-Wmissing-prototypes]
      30 | void *__memcpy(void *dest, const void *src, size_t count)
         |       ^~~~~~~~
>> arch/csky/lib/string.c:94:7: warning: no previous prototype for '__memmove' [-Wmissing-prototypes]
      94 | void *__memmove(void *dest, const void *src, size_t count)
         |       ^~~~~~~~~
>> arch/csky/lib/string.c:113:7: warning: no previous prototype for '__memset' [-Wmissing-prototypes]
     113 | void *__memset(void *s, int c, size_t count)
         |       ^~~~~~~~


vim +/__memcpy +30 arch/csky/lib/string.c

    29	
  > 30	void *__memcpy(void *dest, const void *src, size_t count)
    31	{
    32		union const_types s = { .as_u8 = src };
    33		union types d = { .as_u8 = dest };
    34		int distance = 0;
    35	
    36		if (count < MIN_THRESHOLD)
    37			goto copy_remainder;
    38	
    39		/* Copy a byte at time until destination is aligned. */
    40		for (; d.as_uptr & WORD_MASK; count--)
    41			*d.as_u8++ = *s.as_u8++;
    42	
    43		distance = s.as_uptr & WORD_MASK;
    44	
    45		if (distance) {
    46			unsigned long last, next;
    47	
    48			/*
    49			 * s is distance bytes ahead of d, and d just reached
    50			 * the alignment boundary. Move s backward to word align it
    51			 * and shift data to compensate for distance, in order to do
    52			 * word-by-word copy.
    53			 */
    54			s.as_u8 -= distance;
    55	
    56			next = s.as_ulong[0];
    57			for (; count >= BYTES_LONG; count -= BYTES_LONG) {
    58				last = next;
    59				next = s.as_ulong[1];
    60	
    61				d.as_ulong[0] = last >> (distance * 8) |
    62					next << ((BYTES_LONG - distance) * 8);
    63	
    64				d.as_ulong++;
    65				s.as_ulong++;
    66			}
    67	
    68			/* Restore s with the original offset. */
    69			s.as_u8 += distance;
    70		} else {
    71			/*
    72			 * If the source and dest lower bits are the same, do a simple
    73			 * 32/64 bit wide copy.
    74			 */
    75			for (; count >= BYTES_LONG; count -= BYTES_LONG)
    76				*d.as_ulong++ = *s.as_ulong++;
    77		}
    78	
    79	copy_remainder:
    80		while (count--)
    81			*d.as_u8++ = *s.as_u8++;
    82	
    83		return dest;
    84	}
    85	EXPORT_SYMBOL(__memcpy);
    86	
    87	void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
    88	EXPORT_SYMBOL(memcpy);
    89	
    90	/*
    91	 * Simply check if the buffer overlaps an call memcpy() in case,
    92	 * otherwise do a simple one byte at time backward copy.
    93	 */
  > 94	void *__memmove(void *dest, const void *src, size_t count)
    95	{
    96		if (dest < src || src + count <= dest)
    97			return memcpy(dest, src, count);
    98	
    99		if (dest > src) {
   100			const char *s = src + count;
   101			char *tmp = dest + count;
   102	
   103			while (count--)
   104				*--tmp = *--s;
   105		}
   106		return dest;
   107	}
   108	EXPORT_SYMBOL(__memmove);
   109	
   110	void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmove);
   111	EXPORT_SYMBOL(memmove);
   112	
 > 113	void *__memset(void *s, int c, size_t count)
   114	{
   115		union types dest = { .as_u8 = s };
   116	
   117		if (count >= MIN_THRESHOLD) {
   118			unsigned long cu = (unsigned long)c;
   119	
   120			/* Compose an ulong with 'c' repeated 4/8 times */
   121			cu |= cu << 8;
   122			cu |= cu << 16;
   123			/* Suppress warning on 32 bit machines */
   124			cu |= (cu << 16) << 16;
   125	
   126			for (; count && dest.as_uptr & WORD_MASK; count--)
   127				*dest.as_u8++ = c;
   128	
   129			/* Copy using the largest size allowed */
   130			for (; count >= BYTES_LONG; count -= BYTES_LONG)
   131				*dest.as_ulong++ = cu;
   132		}
   133	
   134		/* copy the remainder */
   135		while (count--)
   136			*dest.as_u8++ = c;
   137	
   138		return s;
   139	}
   140	EXPORT_SYMBOL(__memset);
   141	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
