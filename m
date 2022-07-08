Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2C56AF69
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 02:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiGHANR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiGHANQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 20:13:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38846EE9A
        for <linux-arch@vger.kernel.org>; Thu,  7 Jul 2022 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657239195; x=1688775195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kHhNQQ1pcG1319c7Uxr7FzaMzLB0M5407ND+aU7n/Ps=;
  b=efkBMMGvu0c3ZO+vcidxGykaaEoC2DhvYje9eAOw7z4gs19hptQl893D
   rPt+RUmdFu4/kLliiN2VelJ5R90m9bXd3f9v4ky7PQHuuckNfV4JpVowY
   xNBxK+n7g4QVdI9gXOcgsr+G6HOtKWS0ryLBkojoipW3gP5EDcbgNd4C9
   c7tNevNWrnHi7HbxX8myPvp0o1CM8EBMoHO7rCOG179jHfA/+O39QEeiL
   4pkSLk/6tPnSebnzEXIFRRVP5R0zLRxteO3ZnvZ/MVMsJSvAUQeKryuay
   lGTqd6rE6eBCqYbZEaTbJ/OT2ichxwZtsUwiFEzJvk/PrfMOYdTysBveU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="263929918"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263929918"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 17:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="920794538"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 17:13:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9bcO-000Mec-St;
        Fri, 08 Jul 2022 00:13:12 +0000
Date:   Fri, 8 Jul 2022 08:12:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [arnd-asm-generic:asm-generic-fixes 1/1] kernel/resource.c:1124:6:
 error: call to undeclared function 'devmem_is_allowed'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202207080855.lobMzAgr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
head:   cdfde8f61a004fa5797d40581077603c142adca1
commit: cdfde8f61a004fa5797d40581077603c142adca1 [1/1] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
config: arm-buildonly-randconfig-r003-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080855.lobMzAgr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=cdfde8f61a004fa5797d40581077603c142adca1
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic asm-generic-fixes
        git checkout cdfde8f61a004fa5797d40581077603c142adca1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/resource.c:1124:6: error: call to undeclared function 'devmem_is_allowed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (devmem_is_allowed(PHYS_PFN(res->start)) &&
               ^
   1 error generated.


vim +/devmem_is_allowed +1124 kernel/resource.c

71a1d8ed900f8c Daniel Vetter 2020-11-27  1102  
71a1d8ed900f8c Daniel Vetter 2020-11-27  1103  #ifdef CONFIG_IO_STRICT_DEVMEM
71a1d8ed900f8c Daniel Vetter 2020-11-27  1104  static void revoke_iomem(struct resource *res)
71a1d8ed900f8c Daniel Vetter 2020-11-27  1105  {
71a1d8ed900f8c Daniel Vetter 2020-11-27  1106  	/* pairs with smp_store_release() in iomem_init_inode() */
71a1d8ed900f8c Daniel Vetter 2020-11-27  1107  	struct inode *inode = smp_load_acquire(&iomem_inode);
71a1d8ed900f8c Daniel Vetter 2020-11-27  1108  
71a1d8ed900f8c Daniel Vetter 2020-11-27  1109  	/*
71a1d8ed900f8c Daniel Vetter 2020-11-27  1110  	 * Check that the initialization has completed. Losing the race
71a1d8ed900f8c Daniel Vetter 2020-11-27  1111  	 * is ok because it means drivers are claiming resources before
71a1d8ed900f8c Daniel Vetter 2020-11-27  1112  	 * the fs_initcall level of init and prevent iomem_get_mapping users
71a1d8ed900f8c Daniel Vetter 2020-11-27  1113  	 * from establishing mappings.
71a1d8ed900f8c Daniel Vetter 2020-11-27  1114  	 */
71a1d8ed900f8c Daniel Vetter 2020-11-27  1115  	if (!inode)
71a1d8ed900f8c Daniel Vetter 2020-11-27  1116  		return;
71a1d8ed900f8c Daniel Vetter 2020-11-27  1117  
71a1d8ed900f8c Daniel Vetter 2020-11-27  1118  	/*
71a1d8ed900f8c Daniel Vetter 2020-11-27  1119  	 * The expectation is that the driver has successfully marked
71a1d8ed900f8c Daniel Vetter 2020-11-27  1120  	 * the resource busy by this point, so devmem_is_allowed()
71a1d8ed900f8c Daniel Vetter 2020-11-27  1121  	 * should start returning false, however for performance this
71a1d8ed900f8c Daniel Vetter 2020-11-27  1122  	 * does not iterate the entire resource range.
71a1d8ed900f8c Daniel Vetter 2020-11-27  1123  	 */
71a1d8ed900f8c Daniel Vetter 2020-11-27 @1124  	if (devmem_is_allowed(PHYS_PFN(res->start)) &&
71a1d8ed900f8c Daniel Vetter 2020-11-27  1125  	    devmem_is_allowed(PHYS_PFN(res->end))) {
71a1d8ed900f8c Daniel Vetter 2020-11-27  1126  		/*
71a1d8ed900f8c Daniel Vetter 2020-11-27  1127  		 * *cringe* iomem=relaxed says "go ahead, what's the
71a1d8ed900f8c Daniel Vetter 2020-11-27  1128  		 * worst that can happen?"
71a1d8ed900f8c Daniel Vetter 2020-11-27  1129  		 */
71a1d8ed900f8c Daniel Vetter 2020-11-27  1130  		return;
71a1d8ed900f8c Daniel Vetter 2020-11-27  1131  	}
71a1d8ed900f8c Daniel Vetter 2020-11-27  1132  
71a1d8ed900f8c Daniel Vetter 2020-11-27  1133  	unmap_mapping_range(inode->i_mapping, res->start, resource_size(res), 1);
71a1d8ed900f8c Daniel Vetter 2020-11-27  1134  }
71a1d8ed900f8c Daniel Vetter 2020-11-27  1135  #else
71a1d8ed900f8c Daniel Vetter 2020-11-27  1136  static void revoke_iomem(struct resource *res) {}
71a1d8ed900f8c Daniel Vetter 2020-11-27  1137  #endif
71a1d8ed900f8c Daniel Vetter 2020-11-27  1138  

:::::: The code at line 1124 was first introduced by commit
:::::: 71a1d8ed900f8cf53151beff17e3e2ff8e9283a1 resource: Move devmem revoke code to resource framework

:::::: TO: Daniel Vetter <daniel.vetter@ffwll.ch>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
