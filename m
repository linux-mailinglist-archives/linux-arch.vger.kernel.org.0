Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD6729ED7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbjFIPmG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjFIPle (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 11:41:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8130FA;
        Fri,  9 Jun 2023 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325291; x=1717861291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jA1MIe3DQG1EJItjGDEn8VXGdBffgmF7jysNuMJjaB0=;
  b=U/971AQwz3SA/5/+XBO8qc11RI3/WAcPrVSNm3xC08WYh+6JdlzKKtde
   gUG4fPGWJ+yrCT9pQHQ6eg+F8lzT7qwUH3s0697rO9VwDy16rpEzjN8nT
   KnuH9+zww7WaP/FvFJPRwlctlDc6U41ByREN73xpaD+xezx6a6sxYQam0
   L6ERYrwhIo1jcO65yDJCvUQwbL5azyBG/yH2AAtt7wAWo3vys9grt4w/S
   lqplsKcjldtAFk6kQs4Tjy4Ir43HH+5qDd0YeWlWaAPSMIOOekd6BjLfi
   6ED9ispk1OpUKQy7bROZIyJR1Ovi1xbf+7zALqAnABYcF7/DuU0kwCnce
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355114041"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="355114041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="660799416"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="660799416"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 08:41:23 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7eEs-0009AN-2V;
        Fri, 09 Jun 2023 15:41:22 +0000
Date:   Fri, 9 Jun 2023 23:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <202306092349.88mhfjhr-lkp@intel.com>
References: <20230609075528.9390-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-11-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230609-160014
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230609075528.9390-11-bhe%40redhat.com
patch subject: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
config: s390-randconfig-r014-20230608 (https://download.01.org/0day-ci/archive/20230609/202306092349.88mhfjhr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230609075528.9390-11-bhe@redhat.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pcmcia/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306092349.88mhfjhr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pcmcia/cistpl.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/pcmcia/cistpl.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/pcmcia/cistpl.c:21:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/pcmcia/cistpl.c:72:3: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      72 |                 iounmap(s->cis_virt);
         |                 ^
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   drivers/pcmcia/cistpl.c:72:3: note: did you mean 'vunmap'?
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   include/linux/vmalloc.h:167:13: note: 'vunmap' declared here
     167 | extern void vunmap(const void *addr);
         |             ^
>> drivers/pcmcia/cistpl.c:103:17: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     103 |                 s->cis_virt = ioremap(mem->res->start, s->map_size);
         |                               ^
>> drivers/pcmcia/cistpl.c:103:15: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     103 |                 s->cis_virt = ioremap(mem->res->start, s->map_size);
         |                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pcmcia/cistpl.c:110:3: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     110 |                 iounmap(s->cis_virt);
         |                 ^
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   drivers/pcmcia/cistpl.c:117:4: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     117 |                         iounmap(s->cis_virt);
         |                         ^
   arch/s390/include/asm/io.h:29:17: note: expanded from macro 'iounmap'
      29 | #define iounmap iounmap
         |                 ^
   drivers/pcmcia/cistpl.c:118:15: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     118 |                 s->cis_virt = ioremap(mem->static_start, s->map_size);
         |                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 warnings and 6 errors generated.


vim +/iounmap +72 drivers/pcmcia/cistpl.c

^1da177e4c3f41 Linus Torvalds    2005-04-16   60  
^1da177e4c3f41 Linus Torvalds    2005-04-16   61  void release_cis_mem(struct pcmcia_socket *s)
^1da177e4c3f41 Linus Torvalds    2005-04-16   62  {
6b8e087b86c59c Dominik Brodowski 2010-01-12   63  	mutex_lock(&s->ops_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16   64  	if (s->cis_mem.flags & MAP_ACTIVE) {
^1da177e4c3f41 Linus Torvalds    2005-04-16   65  		s->cis_mem.flags &= ~MAP_ACTIVE;
^1da177e4c3f41 Linus Torvalds    2005-04-16   66  		s->ops->set_mem_map(s, &s->cis_mem);
^1da177e4c3f41 Linus Torvalds    2005-04-16   67  		if (s->cis_mem.res) {
^1da177e4c3f41 Linus Torvalds    2005-04-16   68  			release_resource(s->cis_mem.res);
^1da177e4c3f41 Linus Torvalds    2005-04-16   69  			kfree(s->cis_mem.res);
^1da177e4c3f41 Linus Torvalds    2005-04-16   70  			s->cis_mem.res = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16   71  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  @72  		iounmap(s->cis_virt);
^1da177e4c3f41 Linus Torvalds    2005-04-16   73  		s->cis_virt = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16   74  	}
6b8e087b86c59c Dominik Brodowski 2010-01-12   75  	mutex_unlock(&s->ops_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16   76  }
^1da177e4c3f41 Linus Torvalds    2005-04-16   77  
cc448baf85c8f2 Lee Jones         2021-03-12   78  /*
6e83ee075ed749 Dominik Brodowski 2010-03-02   79   * set_cis_map() - map the card memory at "card_offset" into virtual space.
6e83ee075ed749 Dominik Brodowski 2010-03-02   80   *
^1da177e4c3f41 Linus Torvalds    2005-04-16   81   * If flags & MAP_ATTRIB, map the attribute space, otherwise
^1da177e4c3f41 Linus Torvalds    2005-04-16   82   * map the memory space.
7ab24855482fbc Dominik Brodowski 2010-02-17   83   *
7ab24855482fbc Dominik Brodowski 2010-02-17   84   * Must be called with ops_mutex held.
^1da177e4c3f41 Linus Torvalds    2005-04-16   85   */
6e83ee075ed749 Dominik Brodowski 2010-03-02   86  static void __iomem *set_cis_map(struct pcmcia_socket *s,
6e83ee075ed749 Dominik Brodowski 2010-03-02   87  				unsigned int card_offset, unsigned int flags)
^1da177e4c3f41 Linus Torvalds    2005-04-16   88  {
^1da177e4c3f41 Linus Torvalds    2005-04-16   89  	pccard_mem_map *mem = &s->cis_mem;
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27   90  	int ret;
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27   91  
2e5a3e79091615 Dominik Brodowski 2005-07-28   92  	if (!(s->features & SS_CAP_STATIC_MAP) && (mem->res == NULL)) {
6e83ee075ed749 Dominik Brodowski 2010-03-02   93  		mem->res = pcmcia_find_mem_region(0, s->map_size,
6e83ee075ed749 Dominik Brodowski 2010-03-02   94  						s->map_size, 0, s);
^1da177e4c3f41 Linus Torvalds    2005-04-16   95  		if (mem->res == NULL) {
f2e6cf76751d47 Joe Perches       2014-10-10   96  			dev_notice(&s->dev, "cs: unable to map card memory!\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16   97  			return NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16   98  		}
2e5a3e79091615 Dominik Brodowski 2005-07-28   99  		s->cis_virt = NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  100  	}
2e5a3e79091615 Dominik Brodowski 2005-07-28  101  
2e5a3e79091615 Dominik Brodowski 2005-07-28  102  	if (!(s->features & SS_CAP_STATIC_MAP) && (!s->cis_virt))
2e5a3e79091615 Dominik Brodowski 2005-07-28 @103  		s->cis_virt = ioremap(mem->res->start, s->map_size);
2e5a3e79091615 Dominik Brodowski 2005-07-28  104  
^1da177e4c3f41 Linus Torvalds    2005-04-16  105  	mem->card_start = card_offset;
^1da177e4c3f41 Linus Torvalds    2005-04-16  106  	mem->flags = flags;
2e5a3e79091615 Dominik Brodowski 2005-07-28  107  
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  108  	ret = s->ops->set_mem_map(s, mem);
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  109  	if (ret) {
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  110  		iounmap(s->cis_virt);
2e5a3e79091615 Dominik Brodowski 2005-07-28  111  		s->cis_virt = NULL;
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  112  		return NULL;
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  113  	}
2ad0a0a793cbd8 Dominik Brodowski 2005-06-27  114  
^1da177e4c3f41 Linus Torvalds    2005-04-16  115  	if (s->features & SS_CAP_STATIC_MAP) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  116  		if (s->cis_virt)
^1da177e4c3f41 Linus Torvalds    2005-04-16  117  			iounmap(s->cis_virt);
^1da177e4c3f41 Linus Torvalds    2005-04-16  118  		s->cis_virt = ioremap(mem->static_start, s->map_size);
^1da177e4c3f41 Linus Torvalds    2005-04-16  119  	}
2e5a3e79091615 Dominik Brodowski 2005-07-28  120  
^1da177e4c3f41 Linus Torvalds    2005-04-16  121  	return s->cis_virt;
^1da177e4c3f41 Linus Torvalds    2005-04-16  122  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
