Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1C6C811B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjCXPX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPX0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 11:23:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E66594
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679671402; x=1711207402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=67Ifw9mmyJRELTQW5P+QTodIwWBkaBtEAdB+tLBaqIw=;
  b=WMFq6th7xePhctoMivdOVkFovIHgQBIablObWYy4bmfg64qXJGhmOXPM
   ctMB8OKB2YTkSmJ3pt8nDCaxX8lJLPRbu07V73QH0a0gGDmUiNl4ZsPXW
   jlx+tP/r19XfFf3eLn8Bsy5MPi/dNi7TE7k2HA5hP98S+HAr7sM6d+8DN
   Is5stDLpuRCh7bCJXIAw/XlqaiWdDLu+3YE4JDhJzvCYoyQhoTlKq1PTX
   uQ2KSKGdSqWGOnv575rXEMnxkA/9xrowDVUf3rppyMudGasfHTKb/xt5G
   BJ9C5G21CEQAqaiU89u3yjMVWcEL42HfKCf6wDo92VkmEDzY5Y+mim6Zl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="402390707"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="402390707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="632867022"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="632867022"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2023 08:23:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfjGB-000FQ8-33;
        Fri, 24 Mar 2023 15:23:19 +0000
Date:   Fri, 24 Mar 2023 23:22:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 20/20]
 arch/hexagon/kernel/dma.c:19:27: error: use of undeclared identifier 'paddr'
Message-ID: <202303242303.IAFZ31Wv-lkp@intel.com>
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
config: hexagon-randconfig-r033-20230324 (https://download.01.org/0day-ci/archive/20230324/202303242303.IAFZ31Wv-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=9a711fbea373208c1eeb2fafb0c744bc23a79a43
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 9a711fbea373208c1eeb2fafb0c744bc23a79a43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303242303.IAFZ31Wv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/hexagon/kernel/dma.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/hexagon/kernel/dma.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/hexagon/kernel/dma.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> arch/hexagon/kernel/dma.c:19:27: error: use of undeclared identifier 'paddr'
           hexagon_inv_dcache_range(paddr, paddr + size);
                                    ^
   arch/hexagon/kernel/dma.c:19:34: error: use of undeclared identifier 'paddr'
           hexagon_inv_dcache_range(paddr, paddr + size);
                                           ^
>> arch/hexagon/kernel/dma.c:24:2: error: call to undeclared function 'hexagon_flush_dcache_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           hexagon_flush_dcache_range(paddr, paddr + size);
           ^
   arch/hexagon/kernel/dma.c:24:2: note: did you mean 'hexagon_clean_dcache_range'?
   arch/hexagon/include/asm/cacheflush.h:75:13: note: 'hexagon_clean_dcache_range' declared here
   extern void hexagon_clean_dcache_range(unsigned long start, unsigned long end);
               ^
   arch/hexagon/kernel/dma.c:24:29: error: use of undeclared identifier 'paddr'
           hexagon_flush_dcache_range(paddr, paddr + size);
                                      ^
   arch/hexagon/kernel/dma.c:24:36: error: use of undeclared identifier 'paddr'
           hexagon_flush_dcache_range(paddr, paddr + size);
                                             ^
   6 warnings and 5 errors generated.


vim +/paddr +19 arch/hexagon/kernel/dma.c

    16	
    17	static inline void arch_dma_cache_inv(phys_addr_t start, size_t size)
    18	{
  > 19		hexagon_inv_dcache_range(paddr, paddr + size);
    20	}
    21	
    22	static inline void arch_dma_cache_wback_inv(phys_addr_t start, size_t size)
    23	{
  > 24		hexagon_flush_dcache_range(paddr, paddr + size);
    25	}
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
