Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BC6C8D1B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCYKaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYKaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 06:30:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFF212E
        for <linux-arch@vger.kernel.org>; Sat, 25 Mar 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679740199; x=1711276199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B86j0CzswK+tLvm+gvcV6n5yGxOEQST0QgEjYAfI1uU=;
  b=RCe5s2N67aWwAuSOVy1zSH+ZeuIs4N5iKuSnzPz3gmSaanV4XBhhA4qL
   lcrAjC887tcxUOtuR6I255LwIHmMARoQANvW3yVY0XxQ+myMZA6IoL4FI
   FF/7sU9n2N8xJQ+AuoXo99tbZkZgM1ntQvWZa7sOUCKGuu/v+1OA1A1Do
   j1D7pBFDOyZw82MJTGGLsLzZCQJq81q2iANlokDgBWUBXaDcESUCHFlYx
   cqOFE82vlrQyiKNwAvAZVHoiMjeuVR41hm4cRUcEQg8lC65B5F5mUoZaq
   9mPp8h2dnjoRX1XgQOoek9Xeh8U2qXwgU7/Bt99vbt4IrCo7v3IAAkxVE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="320358610"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="320358610"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 03:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="826523350"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="826523350"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2023 03:29:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg19p-000GCd-2O;
        Sat, 25 Mar 2023 10:29:57 +0000
Date:   Sat, 25 Mar 2023 18:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 7/22]
 arch/powerpc/mm/dma-noncoherent.c:91:59: error: unknown type name
 'dma_cache_op'
Message-ID: <202303251809.m9CxUNxz-lkp@intel.com>
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
head:   985cd64f3b17b82468e68c6269e09a5556d3720e
commit: a0183b361d4212de180444305367f20ad14f89fd [7/22] powerpc: dma-mapping: split out cache operation logic
config: powerpc-taishan_defconfig (https://download.01.org/0day-ci/archive/20230325/202303251809.m9CxUNxz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=a0183b361d4212de180444305367f20ad14f89fd
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout a0183b361d4212de180444305367f20ad14f89fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251809.m9CxUNxz-lkp@intel.com/

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
>> arch/powerpc/mm/dma-noncoherent.c:115:30: error: 'end' undeclared (first use in this function)
     115 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                              ^~~
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
   arch/powerpc/mm/dma-noncoherent.c:140:30: error: 'end' undeclared (first use in this function)
     140 |                 if ((start | end) & (L1_CACHE_BYTES - 1))
         |                              ^~~
   arch/powerpc/mm/dma-noncoherent.c: At top level:
>> arch/powerpc/mm/dma-noncoherent.c:28:13: error: '__dma_op' defined but not used [-Werror=unused-function]
      28 | static void __dma_op(void *vaddr, size_t size, enum dma_cache_op op)
         |             ^~~~~~~~
   cc1: all warnings being treated as errors


vim +/dma_cache_op +91 arch/powerpc/mm/dma-noncoherent.c

    24	
    25	/*
    26	 * make an area consistent.
    27	 */
  > 28	static void __dma_op(void *vaddr, size_t size, enum dma_cache_op op)
    29	{
    30		unsigned long start = (unsigned long)vaddr;
    31		unsigned long end   = start + size;
    32	
    33		switch (op) {
    34		case DMA_CACHE_CLEAN:
    35			clean_dcache_range(start, end);
    36			break;
    37		case DMA_CACHE_INVAL:
    38			invalidate_dcache_range(start, end);
    39			break;
    40		case DMA_CACHE_FLUSH:
    41			flush_dcache_range(start, end);
    42			break;
    43		}
    44	}
    45	
    46	#ifdef CONFIG_HIGHMEM
    47	/*
    48	 * __dma_highmem_op() implementation for systems using highmem.
    49	 * In this case, each page of a buffer must be kmapped/kunmapped
    50	 * in order to have a virtual address for __dma_op(). This must
    51	 * not sleep so kmap_atomic()/kunmap_atomic() are used.
    52	 *
    53	 * Note: yes, it is possible and correct to have a buffer extend
    54	 * beyond the first page.
    55	 */
    56	static inline void __dma_highmem_op(struct page *page,
    57			unsigned long offset, size_t size, enum dma_cache_op op)
    58	{
    59		size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
    60		size_t cur_size = seg_size;
    61		unsigned long flags, start, seg_offset = offset;
    62		int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
    63		int seg_nr = 0;
    64	
    65		local_irq_save(flags);
    66	
    67		do {
    68			start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
    69	
    70			/* Sync this buffer segment */
    71			__dma_op((void *)start, seg_size, op);
    72			kunmap_atomic((void *)start);
    73			seg_nr++;
    74	
    75			/* Calculate next buffer segment size */
    76			seg_size = min((size_t)PAGE_SIZE, size - cur_size);
    77	
    78			/* Add the segment size to our running total */
    79			cur_size += seg_size;
    80			seg_offset = 0;
    81		} while (seg_nr < nr_segs);
    82	
    83		local_irq_restore(flags);
    84	}
    85	#endif /* CONFIG_HIGHMEM */
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
