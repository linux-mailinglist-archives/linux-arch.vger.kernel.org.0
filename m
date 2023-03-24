Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B36C8278
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCXQgq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCXQgp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 12:36:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2E119681
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679675791; x=1711211791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E0UJ7VmcciWSYTPf5BbLPlRUDAx29FD8hjDzttjz+Kw=;
  b=EGn22X08vdGJZaSjCaghSVNGx3nLxPaW6VV9qF42EHGZMkXPdxgszimE
   KC4J/4TWKEXluhZ8HDcelWHJbaZBJCJINRYMVS/VZHQTZeFrRf+e8K7rh
   OCuSSWBMqSpEo8AgJji42+1bkElXJn18sf3Vi4OxcZ4N8FJYaZOEs/osG
   apwxwarUodI9esP8GZdVQdthYid1tjf3Sa3/JmKgatwKSBctdZ4Dp4cHl
   6FYi/sBMKNnjzkDYiA8H8pSe7ibGFHVxZP/21bKG0J8Pp7vZYAK2LvJas
   AG6MSjLHOdVLzXHgiiYEVmgGvS4oHSJIlrvUJh3YL6frfsxB381ZoxQpu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="328245812"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="328245812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 09:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="682747399"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="682747399"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 09:35:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfkNv-000FT6-0l;
        Fri, 24 Mar 2023 16:35:23 +0000
Date:   Sat, 25 Mar 2023 00:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 5/20]
 arch/powerpc/mm/dma-noncoherent.c:91:59: error: must use 'enum' tag to refer
 to type 'dma_cache_op'
Message-ID: <202303250004.IpEq1z41-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git dma-sync-rework
head:   9a711fbea373208c1eeb2fafb0c744bc23a79a43
commit: 8c96c581a246a71ec30a3971cdf7b702b22bb537 [5/20] powerpc: dma-mapping: split out cache operation logic
config: powerpc-randconfig-r033-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250004.IpEq1z41-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=8c96c581a246a71ec30a3971cdf7b702b22bb537
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 8c96c581a246a71ec30a3971cdf7b702b22bb537
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250004.IpEq1z41-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/mm/dma-noncoherent.c:91:59: error: must use 'enum' tag to refer to type 'dma_cache_op'
   static void __dma_phys_op(phys_addr_t paddr, size_t size, dma_cache_op op)
                                                             ^
                                                             enum 
   arch/powerpc/mm/dma-noncoherent.c:107:10: error: use of undeclared identifier 'direction'
           switch (direction) {
                   ^
>> arch/powerpc/mm/dma-noncoherent.c:115:8: error: use of undeclared identifier 'start'; did you mean 'short'?
                   if ((start | end) & (L1_CACHE_BYTES - 1))
                        ^~~~~
                        short
   arch/powerpc/mm/dma-noncoherent.c:115:8: error: expected expression
   arch/powerpc/mm/dma-noncoherent.c:116:18: error: use of undeclared identifier 'start'
                           __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                         ^
>> arch/powerpc/mm/dma-noncoherent.c:116:25: error: use of undeclared identifier 'end'
                           __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                                ^
   arch/powerpc/mm/dma-noncoherent.c:118:18: error: use of undeclared identifier 'start'
                           __dma_phys_op(start, end, DMA_CACHE_INVAL);
                                         ^
   arch/powerpc/mm/dma-noncoherent.c:118:25: error: use of undeclared identifier 'end'
                           __dma_phys_op(start, end, DMA_CACHE_INVAL);
                                                ^
   arch/powerpc/mm/dma-noncoherent.c:121:17: error: use of undeclared identifier 'start'
                   __dma_phys_op(start, end, DMA_CACHE_CLEAN);
                                 ^
   arch/powerpc/mm/dma-noncoherent.c:121:24: error: use of undeclared identifier 'end'
                   __dma_phys_op(start, end, DMA_CACHE_CLEAN);
                                        ^
   arch/powerpc/mm/dma-noncoherent.c:124:17: error: use of undeclared identifier 'start'
                   __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                 ^
   arch/powerpc/mm/dma-noncoherent.c:124:24: error: use of undeclared identifier 'end'
                   __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                        ^
   arch/powerpc/mm/dma-noncoherent.c:132:10: error: use of undeclared identifier 'direction'
           switch (direction) {
                   ^
   arch/powerpc/mm/dma-noncoherent.c:140:8: error: use of undeclared identifier 'start'; did you mean 'short'?
                   if ((start | end) & (L1_CACHE_BYTES - 1))
                        ^~~~~
                        short
   arch/powerpc/mm/dma-noncoherent.c:140:8: error: expected expression
   arch/powerpc/mm/dma-noncoherent.c:141:18: error: use of undeclared identifier 'start'
                           __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                         ^
   arch/powerpc/mm/dma-noncoherent.c:141:25: error: use of undeclared identifier 'end'
                           __dma_phys_op(start, end, DMA_CACHE_FLUSH);
                                                ^
   arch/powerpc/mm/dma-noncoherent.c:143:18: error: use of undeclared identifier 'start'
                           __dma_phys_op(start, end, DMA_CACHE_INVAL);
                                         ^
   arch/powerpc/mm/dma-noncoherent.c:143:25: error: use of undeclared identifier 'end'
                           __dma_phys_op(start, end, DMA_CACHE_INVAL);
                                                ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +91 arch/powerpc/mm/dma-noncoherent.c

    86	
    87	/*
    88	 * __dma_phys_op makes memory consistent. identical to __dma_op, but
    89	 * takes a phys_addr_t instead of a virtual address
    90	 */
  > 91	static void __dma_phys_op(phys_addr_t paddr, size_t size, dma_cache_op op)
    92	{
    93		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
    94		unsigned offset = paddr & ~PAGE_MASK;
    95	
    96	#ifdef CONFIG_HIGHMEM
    97		__dma_highmem_op(page, offset, size, op);
    98	#else
    99		unsigned long start = (unsigned long)page_address(page) + offset;
   100		__dma_op((void *)start, size, op);
   101	#endif
   102	}
   103	
   104	void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
   105			enum dma_data_direction dir)
   106	{
   107		switch (direction) {
   108		case DMA_NONE:
   109			BUG();
   110		case DMA_FROM_DEVICE:
   111			/*
   112			 * invalidate only when cache-line aligned otherwise there is
   113			 * the potential for discarding uncommitted data from the cache
   114			 */
 > 115			if ((start | end) & (L1_CACHE_BYTES - 1))
 > 116				__dma_phys_op(start, end, DMA_CACHE_FLUSH);
   117			else
   118				__dma_phys_op(start, end, DMA_CACHE_INVAL);
   119			break;
   120		case DMA_TO_DEVICE:		/* writeback only */
   121			__dma_phys_op(start, end, DMA_CACHE_CLEAN);
   122			break;
   123		case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
   124			__dma_phys_op(start, end, DMA_CACHE_FLUSH);
   125			break;
   126		}
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
