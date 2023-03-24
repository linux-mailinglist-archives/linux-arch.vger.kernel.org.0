Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F546C7F8D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 15:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjCXOLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCXOLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 10:11:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D1BB
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679667079; x=1711203079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oeKK0XxdE2OZCdERTy0WYBknFH3V6NT9BywJ7A3s4bI=;
  b=donnLhIU2Nxxsxsq27WjJG07MQ5StG57H4YvxuFGnp+74u5349/EZd3T
   zxHiOuDNcvFXqgpPXPxXEZbNy0LAp0aqGhy1V/WLMfV5jpL9Lzo8ZJdk4
   Zd/VANH+ku8ckGd/bd/cLFGP/SGbITqP5VG/Vcj5fLlilSWtaDVf7n8KX
   jvpvb8t0YGAGE13vGwvFhWTfaQvvjro85xHuWYP/IQNSP9cGwwLRJPGCR
   DbuGO9pCntLy/IKk2Pbfq7QbGp6hK1WkHUU+UeZR60Vj2kw+iUL7qUsl7
   E4QOGpW9LmCLtE5OsZPWnlRgMbG7zPq1iJ7J8I1OPdQnJM42bflFRCQ4k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426053245"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="426053245"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 07:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806680684"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="806680684"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 07:11:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfi8T-000FMK-0a;
        Fri, 24 Mar 2023 14:11:17 +0000
Date:   Fri, 24 Mar 2023 22:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 20/20]
 arch/csky/mm/dma-mapping.c:65:18: error: 'paddr' undeclared
Message-ID: <202303242224.lSidB94K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git dma-sync-rework
head:   9a711fbea373208c1eeb2fafb0c744bc23a79a43
commit: 9a711fbea373208c1eeb2fafb0c744bc23a79a43 [20/20] dma-mapping: replace custom code with generic implementation
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230324/202303242224.lSidB94K-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=9a711fbea373208c1eeb2fafb0c744bc23a79a43
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 9a711fbea373208c1eeb2fafb0c744bc23a79a43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303242224.lSidB94K-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/csky/mm/dma-mapping.c: In function 'arch_dma_cache_inv':
>> arch/csky/mm/dma-mapping.c:65:18: error: 'paddr' undeclared (first use in this function)
      65 |         cache_op(paddr, size, dma_inv_range);
         |                  ^~~~~
   arch/csky/mm/dma-mapping.c:65:18: note: each undeclared identifier is reported only once for each function it appears in
   arch/csky/mm/dma-mapping.c: In function 'arch_dma_cache_wback_inv':
   arch/csky/mm/dma-mapping.c:70:18: error: 'paddr' undeclared (first use in this function)
      70 |         cache_op(paddr, size, dma_wbinv_range);
         |                  ^~~~~


vim +/paddr +65 arch/csky/mm/dma-mapping.c

013de2d6671d89 Guo Ren       2018-09-05  62  
9a711fbea37320 Arnd Bergmann 2023-03-22  63  static inline void arch_dma_cache_inv(phys_addr_t start, size_t size)
013de2d6671d89 Guo Ren       2018-09-05  64  {
ae76f635d4e1cf Guo Ren       2019-07-30 @65  	cache_op(paddr, size, dma_inv_range);
013de2d6671d89 Guo Ren       2018-09-05  66  }
9a711fbea37320 Arnd Bergmann 2023-03-22  67  

:::::: The code at line 65 was first introduced by commit
:::::: ae76f635d4e1cffa6870cc5472567ca9d6940a22 csky: Optimize arch_sync_dma_for_cpu/device with dma_inv_range

:::::: TO: Guo Ren <ren_guo@c-sky.com>
:::::: CC: Guo Ren <ren_guo@c-sky.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
