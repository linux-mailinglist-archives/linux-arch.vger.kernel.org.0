Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C66C8A1E
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 03:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjCYCJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 22:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjCYCJq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 22:09:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE6C16A
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679710185; x=1711246185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Br1ya3ImARlGZK7KA2enkBJHhH5l0c24iq5F6UDDPWM=;
  b=OYEX8KbTaqMoBhrXI8VO5raQkk5Wp/sx8BXvGEhhk7eLVULkLcXUWisP
   slAy6GDAaEL3hZPeVbSoHd4SeL4VGpVSxp2HbMOOweURBmTPu82LKPjvy
   ATzeMRpuaMZ52br+DHlSroGoq6k2nB02XS8j56KED3v3xgRxsXt0tYTcz
   0GeFGxtacDdmGnwAUrtVkXddakk19uw66Zard1bBm3jciPZ7MJkUHDuxm
   A8lrEgbORcboNF0dkCbLFIOxpAMQnRejaX20ZhbwCq9/XVFS6pt9j0dgO
   a0bgIWIf8x34y1T8csrXii9UDoiHkZWEcjOaTRne0+nZwTOQH+XCd0NGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="328353676"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="328353676"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 19:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="685395576"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="685395576"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2023 19:09:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pftLi-000Frr-2w;
        Sat, 25 Mar 2023 02:09:42 +0000
Date:   Sat, 25 Mar 2023 10:09:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 20/20]
 include/linux/dma-sync.h:24:6: warning: no previous prototype for
 'arch_sync_dma_for_device'
Message-ID: <202303251037.tsdm8i6z-lkp@intel.com>
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
head:   985cd64f3b17b82468e68c6269e09a5556d3720e
commit: 9a711fbea373208c1eeb2fafb0c744bc23a79a43 [20/20] dma-mapping: replace custom code with generic implementation
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20230325/202303251037.tsdm8i6z-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=9a711fbea373208c1eeb2fafb0c744bc23a79a43
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 9a711fbea373208c1eeb2fafb0c744bc23a79a43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash arch/nios2/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251037.tsdm8i6z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/nios2/mm/dma-mapping.c:53:
>> include/linux/dma-sync.h:24:6: warning: no previous prototype for 'arch_sync_dma_for_device' [-Wmissing-prototypes]
      24 | void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/dma-sync.h:86:6: warning: no previous prototype for 'arch_sync_dma_for_cpu' [-Wmissing-prototypes]
      86 | void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/nios2/mm/dma-mapping.c:55:6: warning: no previous prototype for 'arch_dma_prep_coherent' [-Wmissing-prototypes]
      55 | void arch_dma_prep_coherent(struct page *page, size_t size)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/nios2/mm/dma-mapping.c:62:7: warning: no previous prototype for 'arch_dma_set_uncached' [-Wmissing-prototypes]
      62 | void *arch_dma_set_uncached(void *ptr, size_t size)
         |       ^~~~~~~~~~~~~~~~~~~~~


vim +/arch_sync_dma_for_device +24 include/linux/dma-sync.h

  > 24	void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
    25			enum dma_data_direction dir)
    26	{
    27		switch (dir) {
    28		case DMA_TO_DEVICE:
    29			/*
    30			 * This may be an empty function on write-through caches,
    31			 * and it might invalidate the cache if an architecture has
    32			 * a write-back cache but no way to write it back without
    33			 * invalidating
    34			 */
    35			arch_dma_cache_wback(paddr, size);
    36			break;
    37	
    38		case DMA_FROM_DEVICE:
    39			/*
    40			 * FIXME: this should be handled the same across all
    41			 * architectures, see
    42			 * https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
    43			 */
    44			if (!arch_sync_dma_clean_before_fromdevice()) {
    45				arch_dma_cache_inv(paddr, size);
    46				break;
    47			}
    48			fallthrough;
    49	
    50		case DMA_BIDIRECTIONAL:
    51			/* Skip the invalidate here if it's done later */
    52			if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
    53			    arch_sync_dma_cpu_needs_post_dma_flush())
    54				arch_dma_cache_wback(paddr, size);
    55			else
    56				arch_dma_cache_wback_inv(paddr, size);
    57			break;
    58	
    59		default:
    60			break;
    61		}
    62	}
    63	
    64	#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
    65	/*
    66	 * Mark the D-cache clean for these pages to avoid extra flushing.
    67	 */
    68	static void arch_dma_mark_dcache_clean(phys_addr_t paddr, size_t size)
    69	{
    70	#ifdef CONFIG_ARCH_DMA_MARK_DCACHE_CLEAN
    71		unsigned long pfn = PFN_UP(paddr);
    72		unsigned long off = paddr & (PAGE_SIZE - 1);
    73		size_t left = size;
    74	
    75		if (off)
    76			left -= PAGE_SIZE - off;
    77	
    78		while (left >= PAGE_SIZE) {
    79			struct page *page = pfn_to_page(pfn++);
    80			set_bit(PG_dcache_clean, &page->flags);
    81			left -= PAGE_SIZE;
    82		}
    83	#endif
    84	}
    85	
  > 86	void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
