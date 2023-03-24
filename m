Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1319A6C7FE8
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCXOcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXOcU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 10:32:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05B14235
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679668339; x=1711204339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iss6ZZCyK2nkk17pJKVbsmbvgd8SvoQv3pUkA9mNt+8=;
  b=Yx4gD2niBI/l6qmf4j/6DakrvECrYD7durjqqw8D+jBaPy3JZamsn36j
   NnfLw2XkvzVVpTwQqgG/poPUYES1gQlsbRpnoahZClP+SuUsKfhKBY+/h
   Co9rm/xnKz4++mQNu4zdIKKZLLENnuDwPFFbuYYLX8A62hE44WdAwLBRy
   BMalOOg5f60SOBjh/uZld8IS0Q9Bmyuc3bqrBaBz7bj2mttSHE3UoJqtx
   qrwP6KTYDb8n+faRkB9ADdhIT0b3B3f0tjT4bDQD0MaJjnTq69VfxXHXf
   Vpv7rgQn7Nj3ObVdtGsPvI8gl7yhg4XRfv3bxHa1sC3BIN0oqVBTbSy+V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="404707372"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="404707372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 07:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="826276319"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="826276319"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 07:32:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfiSn-000FMu-1i;
        Fri, 24 Mar 2023 14:32:17 +0000
Date:   Fri, 24 Mar 2023 22:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 20/20]
 arch/openrisc/kernel/dma.c:126:9: warning: this 'for' clause does not
 guard...
Message-ID: <202303242205.5V2cu64T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git dma-sync-rework
head:   9a711fbea373208c1eeb2fafb0c744bc23a79a43
commit: 9a711fbea373208c1eeb2fafb0c744bc23a79a43 [20/20] dma-mapping: replace custom code with generic implementation
config: openrisc-randconfig-r002-20230322 (https://download.01.org/0day-ci/archive/20230324/202303242205.5V2cu64T-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=9a711fbea373208c1eeb2fafb0c744bc23a79a43
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 9a711fbea373208c1eeb2fafb0c744bc23a79a43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash arch/openrisc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303242205.5V2cu64T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/openrisc/kernel/dma.c: In function 'arch_dma_cache_inv':
   arch/openrisc/kernel/dma.c:115:19: error: 'addr' undeclared (first use in this function); did you mean 'paddr'?
     115 |         for (cl = addr; cl < addr + size;
         |                   ^~~~
         |                   paddr
   arch/openrisc/kernel/dma.c:115:19: note: each undeclared identifier is reported only once for each function it appears in
   arch/openrisc/kernel/dma.c: In function 'arch_dma_cache_wback_inv':
   arch/openrisc/kernel/dma.c:126:19: error: 'addr' undeclared (first use in this function); did you mean 'paddr'?
     126 |         for (cl = addr; cl < addr + size;
         |                   ^~~~
         |                   paddr
>> arch/openrisc/kernel/dma.c:126:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     126 |         for (cl = addr; cl < addr + size;
         |         ^~~
   arch/openrisc/kernel/dma.c:129:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     129 |                 break;
         |                 ^~~~~
   arch/openrisc/kernel/dma.c:129:17: error: break statement not within loop or switch


vim +/for +126 arch/openrisc/kernel/dma.c

9a711fbea373208 Arnd Bergmann 2023-03-22  119  
9a711fbea373208 Arnd Bergmann 2023-03-22  120  static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
9a711fbea373208 Arnd Bergmann 2023-03-22  121  {
9a711fbea373208 Arnd Bergmann 2023-03-22  122  	unsigned long cl;
9a711fbea373208 Arnd Bergmann 2023-03-22  123  	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
9a711fbea373208 Arnd Bergmann 2023-03-22  124  
586fa29b78e5976 Arnd Bergmann 2023-03-21  125  	/* Flush the dcache for the requested range */
586fa29b78e5976 Arnd Bergmann 2023-03-21 @126  	for (cl = addr; cl < addr + size;
586fa29b78e5976 Arnd Bergmann 2023-03-21  127  	     cl += cpuinfo->dcache_block_size)
586fa29b78e5976 Arnd Bergmann 2023-03-21  128  		mtspr(SPR_DCBFR, cl);
586fa29b78e5976 Arnd Bergmann 2023-03-21  129  		break;
a39af6f7b806f2a Jonas Bonn    2011-06-04  130  }
9a711fbea373208 Arnd Bergmann 2023-03-22  131  

:::::: The code at line 126 was first introduced by commit
:::::: 586fa29b78e59767a0a6d19e82c81e469bae6e08 openrisc: dma-mapping: flush bidirectional mappings

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
