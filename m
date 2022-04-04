Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EF4F13CF
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbiDDLdL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDLdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 07:33:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382AC3C732;
        Mon,  4 Apr 2022 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649071875; x=1680607875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ErXKJwnxX8hclXQqvYKDIF2ZZ3KufEcKMWs1slKVfPY=;
  b=aqWWVANRfW6tRnubDWdO6j7jy0kxKl8xbvrBYM3sb5UJWB9VkrF7AeTM
   rSxVJ8PFembyJom9T3RiOFtLPXdAiZoGxZ5MUeEhRPoyAPz5bkGwuI4ht
   Ijev9M+w2dM2ZFTkRyrJ9cjxeJLJnMtvnbKYrJyLurkEAZBE169fIVe77
   R9313lQ1DcxqcDW3FdJIwpUaCkkBZ/6Y/IRsOFz5oc6mw2GLJ/qkpx66y
   TX9qUwnC4CWqob1avAVXWWoU7Twdt9muazRRpVX6kGf5esjDWrEfchcJe
   uLvwuduWMgTV7Q5PEJ6gL6UC96wRMEt7KvO+L1vKxPqiSpptUmbj7QyEO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="242634145"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="242634145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="556127945"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2022 04:31:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbKvP-00020N-Ri;
        Mon, 04 Apr 2022 11:31:11 +0000
Date:   Mon, 4 Apr 2022 19:30:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 7/8] posix_types.h: add __kernel_uintptr_t to UAPI
 posix_types.h
Message-ID: <202204041919.bIUKxOch-lkp@intel.com>
References: <20220404061948.2111820-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-8-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on linux/master v5.18-rc1 next-20220404]
[cannot apply to soc/for-next drm/drm-next powerpc/next uclinux-h8/h8300-next s390/features arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220404/202204041919.bIUKxOch-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e8154d995f34b79843e473d85645fb543d554e7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
        git checkout e8154d995f34b79843e473d85645fb543d554e7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/fsl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/fsl/imx-audmux.c:148:40: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
                   snprintf(buf, sizeof(buf), "ssi%lu", i);
                                                  ~~~   ^
                                                  %u
   1 warning generated.


vim +148 sound/soc/fsl/imx-audmux.c

7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  139  
b8909783a22b4f sound/soc/fsl/imx-audmux.c    Lars-Peter Clausen 2014-04-24  140  static void audmux_debugfs_init(void)
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  141  {
e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01  142  	uintptr_t i;
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  143  	char buf[20];
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  144  
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  145  	audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  146  
409b78cc17a4a3 sound/soc/fsl/imx-audmux.c    Torben Hohn        2012-07-18  147  	for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01 @148  		snprintf(buf, sizeof(buf), "ssi%lu", i);
227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  149  		debugfs_create_file(buf, 0444, audmux_debugfs_root,
227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  150  				    (void *)i, &audmux_debugfs_fops);
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  151  	}
7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  152  }
3bc34a6143359d arch/arm/plat-mxc/audmux.c    Richard Zhao       2012-03-05  153  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
