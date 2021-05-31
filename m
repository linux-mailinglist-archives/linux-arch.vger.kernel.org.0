Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93414395D67
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEaNp2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 09:45:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:39490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhEaNnV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 May 2021 09:43:21 -0400
IronPort-SDR: KMflE9IHLDYfp290OegFJc339JiE3ECxviQzzmn63wZikgn2fvMqkLSb9imcYJVHR5vrpXgkyq
 OI4B2jdqae8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="264549754"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="gz'50?scan'50,208,50";a="264549754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 06:30:03 -0700
IronPort-SDR: c0TG5I4R/nBxn+Oso9wXhhrF/o0r652zaqu6YMW3c4/qTTcTTgV54ij7F3UIbkP/cdnbrcN+qp
 Psli6KfQc3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="gz'50?scan'50,208,50";a="635163468"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2021 06:30:02 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lnhzV-0004qN-G1; Mon, 31 May 2021 13:30:01 +0000
Date:   Mon, 31 May 2021 21:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org
Subject: [asm-generic:clkdev 1/5] arch/mips/ar7/clock.c:428:28: error: array
 type has incomplete element type 'struct clkdev_table'
Message-ID: <202105312142.h4zqTYQG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git clkdev
head:   3c150d2578b204c2e18c7ac6d967b43a614befbe
commit: 991cb086b5cfcd6ad953a64c6ce384bbd8595ded [1/5] mips: ar7: convert to clkdev_lookup
config: mips-ar7_defconfig (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=991cb086b5cfcd6ad953a64c6ce384bbd8595ded
        git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags asm-generic clkdev
        git checkout 991cb086b5cfcd6ad953a64c6ce384bbd8595ded
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/ar7/clock.c:428:28: error: array type has incomplete element type 'struct clkdev_table'
     428 | static struct clkdev_table clkdev_table[] = {
         |                            ^~~~~~~~~~~~
   In file included from arch/mips/ar7/clock.c:17:
>> include/linux/clkdev.h:28:3: error: field name not in record or union initializer
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:28:3: note: (near initialization for 'clkdev_table')
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: error: field name not in record or union initializer
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: note: (near initialization for 'clkdev_table')
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: error: field name not in record or union initializer
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: note: (near initialization for 'clkdev_table')
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:429:2: note: in expansion of macro 'CLKDEV_INIT'
     429 |  CLKDEV_INIT(NULL, "bus", &bus_clk),
         |  ^~~~~~~~~~~
>> include/linux/clkdev.h:28:3: error: field name not in record or union initializer
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:28:3: note: (near initialization for 'clkdev_table')
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: error: field name not in record or union initializer
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: note: (near initialization for 'clkdev_table')
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: error: field name not in record or union initializer
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: note: (near initialization for 'clkdev_table')
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:431:2: note: in expansion of macro 'CLKDEV_INIT'
     431 |  CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
>> include/linux/clkdev.h:28:3: error: field name not in record or union initializer
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:28:3: note: (near initialization for 'clkdev_table')
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: error: field name not in record or union initializer
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: note: (near initialization for 'clkdev_table')
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: error: field name not in record or union initializer
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: note: (near initialization for 'clkdev_table')
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:432:2: note: in expansion of macro 'CLKDEV_INIT'
     432 |  CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
         |  ^~~~~~~~~~~
>> include/linux/clkdev.h:28:3: error: field name not in record or union initializer
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:28:3: note: (near initialization for 'clkdev_table')
      28 |   .dev_id = d, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: error: field name not in record or union initializer
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:29:3: note: (near initialization for 'clkdev_table')
      29 |   .con_id = n, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: error: field name not in record or union initializer
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
   include/linux/clkdev.h:30:3: note: (near initialization for 'clkdev_table')
      30 |   .clk = c, \
         |   ^
   arch/mips/ar7/clock.c:433:2: note: in expansion of macro 'CLKDEV_INIT'
     433 |  CLKDEV_INIT(NULL, "cpu", &cpu_clk)
         |  ^~~~~~~~~~~
>> include/linux/clkdev.h:27:2: error: expected '}' before '{' token
      27 |  {   \
         |  ^
   arch/mips/ar7/clock.c:434:2: note: in expansion of macro 'CLKDEV_INIT'
     434 |  CLKDEV_INIT(NULL, "dsp", &dsp_clk),
         |  ^~~~~~~~~~~
   arch/mips/ar7/clock.c:428:45: note: to match this '{'
     428 | static struct clkdev_table clkdev_table[] = {
         |                                             ^
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/kernel.h:12,
                    from arch/mips/ar7/clock.c:8:
   arch/mips/ar7/clock.c: In function 'ar7_init_clocks':
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:240:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     240 | #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                            ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:42:59: note: in expansion of macro '__must_be_array'
      42 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   arch/mips/ar7/clock.c:455:34: note: in expansion of macro 'ARRAY_SIZE'
     455 |  clkdev_add_table(&clkdev_table, ARRAY_SIZE(clkdev_table);
         |                                  ^~~~~~~~~~
>> arch/mips/ar7/clock.c:455:58: error: expected ')' before ';' token
     455 |  clkdev_add_table(&clkdev_table, ARRAY_SIZE(clkdev_table);
         |                                                          ^
>> arch/mips/ar7/clock.c:455:59: error: expected ';' before '}' token
     455 |  clkdev_add_table(&clkdev_table, ARRAY_SIZE(clkdev_table);
         |                                                           ^
         |                                                           ;
     456 | }
         | ~                                                          
   At top level:
   arch/mips/ar7/clock.c:428:28: warning: 'clkdev_table' defined but not used [-Wunused-variable]
     428 | static struct clkdev_table clkdev_table[] = {
         |                            ^~~~~~~~~~~~


vim +428 arch/mips/ar7/clock.c

   427	
 > 428	static struct clkdev_table clkdev_table[] = {
   429		CLKDEV_INIT(NULL, "bus", &bus_clk),
   430		/* cpmac and vbus share the same rate */
   431		CLKDEV_INIT("cpmac.0", "cpmac", &vbus_clk),
   432		CLKDEV_INIT("cpmac.1", "cpmac", &vbus_clk),
   433		CLKDEV_INIT(NULL, "cpu", &cpu_clk)
   434		CLKDEV_INIT(NULL, "dsp", &dsp_clk),
   435		CLKDEV_INIT(NULL, "vbus", &vbus_clk),
   436	};
   437	
   438	void __init ar7_init_clocks(void)
   439	{
   440		switch (ar7_chip_id()) {
   441		case AR7_CHIP_7100:
   442		case AR7_CHIP_7200:
   443			tnetd7200_init_clocks();
   444			break;
   445		case AR7_CHIP_7300:
   446			dsp_clk.rate = tnetd7300_dsp_clock();
   447			tnetd7300_init_clocks();
   448			break;
   449		default:
   450			break;
   451		}
   452		/* adjust vbus clock rate */
   453		vbus_clk.rate = bus_clk.rate / 2;
   454	
 > 455		clkdev_add_table(&clkdev_table, ARRAY_SIZE(clkdev_table);
   456	}
   457	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XLNvEqWMV6JMIkDYOPMf46NRD13rAAA=

--vtzGhvizbBRQ85DL--
