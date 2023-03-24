Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6B6C80F1
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjCXPON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjCXPNr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 11:13:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB7231D8
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679670802; x=1711206802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lkfjtbLz1Eoif6LurWZ+qcbyMbcPyXpyV9l702WBkIQ=;
  b=n3ksyKYXOzM3DAWGtRXjMHEYbQCLv5wulp/btj13gWT5bAQKH9vv3ujt
   FVSrvTN5Wg09X4CrxB/HHSIZc9TQqLkABAaPp3QS7yuLT4zxtivEA4nu1
   WD3CX17FgPmHWwV6NV2PsLRA//ah+TXLwdRCEZEXOBIff/pCYnpJu7a1s
   WIlBVj9DKb4r33QBZ/tZUD+KFKkAXYrK3APPls1GxoMqKa4eYHj7qs8RK
   20sLZC9QX+jDi8xdCzN1LWK6NhEm2drlaiGAZdBBXnsHGnz6L97g58+27
   obdJHapFXHmVOGFewJ28ElVD0kU6EsGpf5jlFS8ZocaZK5pkwqIHIzqLo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338520141"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="338520141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="660090130"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="660090130"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2023 08:13:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfj6V-000FPc-16;
        Fri, 24 Mar 2023 15:13:19 +0000
Date:   Fri, 24 Mar 2023 23:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 5/20]
 arch/powerpc/mm/dma-noncoherent.c:91:59: error: unknown type name
 'dma_cache_op'
Message-ID: <202303242353.M76EyrYe-lkp@intel.com>
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
commit: 8c96c581a246a71ec30a3971cdf7b702b22bb537 [5/20] powerpc: dma-mapping: split out cache operation logic
config: powerpc-randconfig-r013-20230322 (https://download.01.org/0day-ci/archive/20230324/202303242353.M76EyrYe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=8c96c581a246a71ec30a3971cdf7b702b22bb537
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 8c96c581a246a71ec30a3971cdf7b702b22bb537
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303242353.M76EyrYe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/mm/dma-noncoherent.c:91:59: error: unknown type name 'dma_cache_op'
      91 | static void __dma_phys_op(phys_addr_t paddr, size_t size, dma_cache_op op)
         |                                                           ^~~~~~~~~~~~
   arch/powerpc/mm/dma-noncoherent.c: In function 'arch_sync_dma_for_device':
   arch/powerpc/mm/dma-noncoherent.c:107:17: error: 'direction' undeclared (first use in this function); did you mean 'irqaction'?
     107 |         switch (direction) {
         |                 ^~~~~~~~~
         |                 irqaction
   arch/powerpc/mm/dma-noncoherent.c:107:17: note: each undeclared identifier is reported only once for each function it appears in
>> arch/powerpc/mm/dma-noncoherent.c:115:22: error: 'start' undeclared (first use in this function); did you mean 'stat'?
     115 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                      ^~~~~
         |                      stat
>> arch/powerpc/mm/dma-noncoherent.c:115:30: error: 'end' undeclared (first use in this function); did you mean '_end'?
     115 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                              ^~~
         |                              _end
>> arch/powerpc/mm/dma-noncoherent.c:116:25: error: implicit declaration of function '__dma_phys_op'; did you mean '__dma_op'? [-Werror=implicit-function-declaration]
     116 |                         __dma_phys_op(start, end, DMA_CACHE_FLUSH);
         |                         ^~~~~~~~~~~~~
         |                         __dma_op
   arch/powerpc/mm/dma-noncoherent.c: In function 'arch_sync_dma_for_cpu':
   arch/powerpc/mm/dma-noncoherent.c:132:17: error: 'direction' undeclared (first use in this function); did you mean 'irqaction'?
     132 |         switch (direction) {
         |                 ^~~~~~~~~
         |                 irqaction
   arch/powerpc/mm/dma-noncoherent.c:140:22: error: 'start' undeclared (first use in this function); did you mean 'stat'?
     140 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                      ^~~~~
         |                      stat
   arch/powerpc/mm/dma-noncoherent.c:140:30: error: 'end' undeclared (first use in this function); did you mean '_end'?
     140 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                              ^~~
         |                              _end
   cc1: all warnings being treated as errors


vim +/dma_cache_op +91 arch/powerpc/mm/dma-noncoherent.c

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
