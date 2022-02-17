Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F704BA0D3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiBQNQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 08:16:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNQM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 08:16:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1CC2AE2A5
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645103752; x=1676639752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OlzL+YaFaWsAGdNtfVRETYm4nuSddRVVTp91oezXFFQ=;
  b=lxa8BAdZnLoTZjliRrvBPRVuAzWbtDv3CST026VJaNG1e4/4DCLsEnaJ
   ReCM+LYU0YFsXIYGk/WgAOOmfGe1OnZKGDD1Ajz/TlQIAEOZWWggUE1bA
   IdpX+BDKAKaYYOzGBwkbD6jOBykxIiujQ47EOxygsb1Gdthg+XKLPNMkH
   p9+820JUvk3Dmpok2hB3RS6o50BBiXJ/Dj508700XOgBxUAuYCaKXt6K+
   q5oPBjymofGZ9tsN/c796WfS/4OasEraSYgHTIK5yYgVo+0eSWmCSjJ5d
   zUObqOL+svV2uXiJbKIl1ydHPy+qvUXeGKWWw24BF3dywqFpXpmMBn/JP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249705669"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249705669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="545591734"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 05:15:50 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKgdR-0000Dc-Ct; Thu, 17 Feb 2022 13:15:49 +0000
Date:   Thu, 17 Feb 2022 21:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [arnd-asm-generic:master 19/26]
 arch/sparc/include/uapi/asm/posix_types.h:14: Error: Unknown opcode:
 `typedef'
Message-ID: <202202172154.lJ3Z0yXe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   3f2b41135db9099b8d216fffeede5c2cb38ed277
commit: 72113d0a7d90d950c7c9a87ab905bffb6bc5752d [19/26] signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test coverage
config: sparc64-randconfig-r036-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172154.lJ3Z0yXe-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=72113d0a7d90d950c7c9a87ab905bffb6bc5752d
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic master
        git checkout 72113d0a7d90d950c7c9a87ab905bffb6bc5752d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/include/uapi/asm/posix_types.h: Assembler messages:
>> arch/sparc/include/uapi/asm/posix_types.h:14: Error: Unknown opcode: `typedef'
   arch/sparc/include/uapi/asm/posix_types.h:15: Error: Unknown opcode: `typedef'
   arch/sparc/include/uapi/asm/posix_types.h:19: Error: Unknown opcode: `typedef'
   arch/sparc/include/uapi/asm/posix_types.h:22: Error: Unknown opcode: `typedef'
   arch/sparc/include/uapi/asm/posix_types.h:23: Error: Unknown opcode: `typedef'
>> arch/sparc/include/uapi/asm/posix_types.h:26: Error: Unknown opcode: `struct'
>> arch/sparc/include/uapi/asm/posix_types.h:27: Error: Unknown opcode: `__kernel_long_t tv_sec'
>> arch/sparc/include/uapi/asm/posix_types.h:28: Error: Unknown opcode: `__kernel_suseconds_t tv_usec'
>> arch/sparc/include/uapi/asm/posix_types.h:29: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/asm-generic/posix_types.h:20: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:24: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:28: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:32: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:36: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:37: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:45: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:49: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:50: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:59: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:72: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:73: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:74: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:79: Error: Unknown opcode: `typedef'
>> include/uapi/asm-generic/posix_types.h:80: Error: Unknown opcode: `int'
>> include/uapi/asm-generic/posix_types.h:81: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/asm-generic/posix_types.h:87: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:88: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:89: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:93: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:94: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:95: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:96: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:97: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:98: Error: Unknown opcode: `typedef'
   include/uapi/asm-generic/posix_types.h:99: Error: Unknown opcode: `typedef'


vim +14 arch/sparc/include/uapi/asm/posix_types.h

a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  13  
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02 @14  typedef unsigned short 	       __kernel_old_uid_t;
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  15  typedef unsigned short         __kernel_old_gid_t;
8c4c7a9a0fd421 arch/sparc/include/asm/posix_types.h      H. Peter Anvin 2012-02-07  16  #define __kernel_old_uid_t __kernel_old_uid_t
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  17  
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  18  /* Note this piece of asymmetry from the v9 ABI.  */
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  19  typedef int		       __kernel_suseconds_t;
8c4c7a9a0fd421 arch/sparc/include/asm/posix_types.h      H. Peter Anvin 2012-02-07  20  #define __kernel_suseconds_t __kernel_suseconds_t
a508228a9ed2c2 arch/sparc/include/asm/posix_types.h      Sam Ravnborg   2009-01-02  21  
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  22  typedef long		__kernel_long_t;
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  23  typedef unsigned long	__kernel_ulong_t;
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  24  #define __kernel_long_t __kernel_long_t
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  25  
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02 @26  struct __kernel_old_timeval {
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02 @27  	__kernel_long_t tv_sec;
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02 @28  	__kernel_suseconds_t tv_usec;
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02 @29  };
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  30  #define __kernel_old_timeval __kernel_old_timeval
bcb3fc3247e5a7 arch/sparc/include/uapi/asm/posix_types.h Deepa Dinamani 2019-02-02  31  

:::::: The code at line 14 was first introduced by commit
:::::: a508228a9ed2c2b582cec7833b60f55d12789219 sparc: unify posix_types.h

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
