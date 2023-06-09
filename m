Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A972A17B
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFIRnN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 13:43:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CA3ABD;
        Fri,  9 Jun 2023 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686332570; x=1717868570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MoHyr7GmCph1FDZsWafSAO79Q/Hkw31EwuhmAhQLP4Y=;
  b=nf1yje4U0KEeiJyZo5PUpUo/WcJnf4flQOTZGuks0qgANY4KS5cXzvWn
   OsrZPc6AWe9chs3ldz1uHx5Fp9DMmc+JTQIVGAJCnZpMo27/uq3I+anXI
   NgBUqWAR6sLLpE27Z0JC2CLBArMc9VvOt8CsSEZr+MlvGuylCm9AfFdU1
   VgBz2L8bzmL5H32yZckgAIMaWGEalYtyfBuFKsxzFIAYZK59UJi6Z5lB/
   CHXbvyjYRq8qvKw6+dw+HRcSGgryJSF8zfC39+g1KHcwgDPXqEJvUxBpW
   OSEvd/cp5M/i4LcYQBddYdvtItlInsP0bArXuO5FpD3Hvr/9xyBhqdp0r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347299526"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="347299526"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713593837"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="713593837"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 10:42:38 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7g8D-0009GR-2h;
        Fri, 09 Jun 2023 17:42:37 +0000
Date:   Sat, 10 Jun 2023 01:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, Baoquan He <bhe@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <202306100146.Eag3T7hY-lkp@intel.com>
References: <20230609075528.9390-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-11-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230610/202306100146.Eag3T7hY-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230609075528.9390-11-bhe@redhat.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/arcnet/ drivers/net/ethernet/8390/ drivers/net/ethernet/fujitsu/ drivers/net/ethernet/smsc/ drivers/net/ethernet/xircom/ drivers/pcmcia/ drivers/tty/ipwireless/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306100146.Eag3T7hY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:13,
                    from include/linux/pci.h:39,
                    from drivers/pcmcia/cistpl.c:21:
   drivers/pcmcia/cistpl.c: In function 'release_cis_mem':
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/pcmcia/cistpl.c:72:17: note: in expansion of macro 'iounmap'
      72 |                 iounmap(s->cis_virt);
         |                 ^~~~~~~
   drivers/pcmcia/cistpl.c: In function 'set_cis_map':
>> drivers/pcmcia/cistpl.c:103:31: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     103 |                 s->cis_virt = ioremap(mem->res->start, s->map_size);
         |                               ^~~~~~~
         |                               iounmap
>> drivers/pcmcia/cistpl.c:103:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     103 |                 s->cis_virt = ioremap(mem->res->start, s->map_size);
         |                             ^
   drivers/pcmcia/cistpl.c:118:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     118 |                 s->cis_virt = ioremap(mem->static_start, s->map_size);
         |                             ^
   cc1: some warnings being treated as errors
--
   drivers/net/arcnet/com90xx.c: In function 'com90xx_probe':
>> drivers/net/arcnet/com90xx.c:225:24: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
     225 |                 base = ioremap(*p, MIRROR_SIZE);
         |                        ^~~~~~~
         |                        ifr_map
>> drivers/net/arcnet/com90xx.c:225:22: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     225 |                 base = ioremap(*p, MIRROR_SIZE);
         |                      ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/arcnet/com90xx.c:36:
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/arcnet/com90xx.c:260:17: note: in expansion of macro 'iounmap'
     260 |                 iounmap(base);
         |                 ^~~~~~~
   drivers/net/arcnet/com90xx.c: In function 'check_mirror':
   drivers/net/arcnet/com90xx.c:444:11: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     444 |         p = ioremap(addr, size);
         |           ^
   drivers/net/arcnet/com90xx.c: In function 'com90xx_found':
   drivers/net/arcnet/com90xx.c:526:23: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     526 |         lp->mem_start = ioremap(dev->mem_start,
         |                       ^
   cc1: some warnings being treated as errors
--
   drivers/net/arcnet/arc-rimi.c: In function 'check_mirror':
>> drivers/net/arcnet/arc-rimi.c:107:13: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
     107 |         p = ioremap(addr, size);
         |             ^~~~~~~
         |             ifr_map
>> drivers/net/arcnet/arc-rimi.c:107:11: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     107 |         p = ioremap(addr, size);
         |           ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/arcnet/arc-rimi.c:35:
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/arcnet/arc-rimi.c:113:17: note: in expansion of macro 'iounmap'
     113 |                 iounmap(p);
         |                 ^~~~~~~
   drivers/net/arcnet/arc-rimi.c: In function 'arcrimi_found':
   drivers/net/arcnet/arc-rimi.c:131:11: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     131 |         p = ioremap(dev->mem_start, MIRROR_SIZE);
         |           ^
   drivers/net/arcnet/arc-rimi.c:202:23: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     202 |         lp->mem_start = ioremap(dev->mem_start,
         |                       ^
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/8390/pcnet_cs.c: In function 'get_hwinfo':
>> drivers/net/ethernet/8390/pcnet_cs.c:291:12: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
     291 |     virt = ioremap(link->resource[2]->start,
         |            ^~~~~~~
         |            ifr_map
>> drivers/net/ethernet/8390/pcnet_cs.c:291:10: warning: assignment to 'u_char *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     291 |     virt = ioremap(link->resource[2]->start,
         |          ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/8390/pcnet_cs.c:39:
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/8390/pcnet_cs.c:312:5: note: in expansion of macro 'iounmap'
     312 |     iounmap(virt);
         |     ^~~~~~~
   drivers/net/ethernet/8390/pcnet_cs.c: In function 'setup_shmem_window':
>> drivers/net/ethernet/8390/pcnet_cs.c:1441:16: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1441 |     info->base = ioremap(link->resource[3]->start,
         |                ^
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/fujitsu/fmvj18x_cs.c: In function 'fmvj18x_get_hwinfo':
>> drivers/net/ethernet/fujitsu/fmvj18x_cs.c:549:12: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     549 |     base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
         |            ^~~~~~~
         |            iounmap
>> drivers/net/ethernet/fujitsu/fmvj18x_cs.c:549:10: warning: assignment to 'u_char *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     549 |     base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
         |          ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/linux/ethtool.h:18,
                    from drivers/net/ethernet/fujitsu/fmvj18x_cs.c:45:
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/fujitsu/fmvj18x_cs.c:579:5: note: in expansion of macro 'iounmap'
     579 |     iounmap(base);
         |     ^~~~~~~
   drivers/net/ethernet/fujitsu/fmvj18x_cs.c: In function 'fmvj18x_setup_mfc':
   drivers/net/ethernet/fujitsu/fmvj18x_cs.c:600:14: warning: assignment to 'u_char *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     600 |     lp->base = ioremap(link->resource[3]->start,
         |              ^
   cc1: some warnings being treated as errors
--
   drivers/tty/ipwireless/main.c: In function 'ipwireless_probe':
>> drivers/tty/ipwireless/main.c:115:30: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
         |                              ^~~~~~~
         |                              iounmap
>> drivers/tty/ipwireless/main.c:115:28: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
         |                            ^
   drivers/tty/ipwireless/main.c:139:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     139 |         ipw->attr_memory = ioremap(p_dev->resource[3]->start,
         |                          ^
   In file included from include/linux/io.h:13,
                    from drivers/tty/ipwireless/main.c:26:
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/tty/ipwireless/main.c:155:9: note: in expansion of macro 'iounmap'
     155 |         iounmap(ipw->attr_memory);
         |         ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'mhz_mfc_config':
>> drivers/net/ethernet/smsc/smc91c92_cs.c:447:17: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
     447 |     smc->base = ioremap(link->resource[2]->start,
         |                 ^~~~~~~
         |                 ifr_map
>> drivers/net/ethernet/smsc/smc91c92_cs.c:447:15: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     447 |     smc->base = ioremap(link->resource[2]->start,
         |               ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/smsc/smc91c92_cs.c:38:
   drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'smc91c92_release':
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/smsc/smc91c92_cs.c:962:17: note: in expansion of macro 'iounmap'
     962 |                 iounmap(smc->base);
         |                 ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_config':
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:843:28: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
         |                            ^~~~~~~
         |                            iounmap
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:843:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
         |                          ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/linux/ethtool.h:18,
                    from drivers/net/ethernet/xircom/xirc2ps_cs.c:77:
   drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_release':
>> arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/xircom/xirc2ps_cs.c:934:25: note: in expansion of macro 'iounmap'
     934 |                         iounmap(local->dingo_ccr - 0x0800);
         |                         ^~~~~~~
   cc1: some warnings being treated as errors


vim +29 arch/s390/include/asm/io.h

    24	
    25	/*
    26	 * I/O memory mapping functions.
    27	 */
    28	#define ioremap_prot ioremap_prot
  > 29	#define iounmap iounmap
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
