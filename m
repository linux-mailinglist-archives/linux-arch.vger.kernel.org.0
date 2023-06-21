Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A3737AB6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 07:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFUFoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 01:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFUFoG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 01:44:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA651718;
        Tue, 20 Jun 2023 22:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687326244; x=1718862244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+Hs7VtPqjXBCVMun5WSNlqD7ECDAgylE9+jVB73LoY=;
  b=PqY6Xis7KQ5+lGfvPpx7VlP7RyUrH2yrJ2MZprNIrW9+JpGIo70sRw+h
   Ok8D6Zj6kAvcqFJmH3tnQ/vtKhalytroys9oG5yV1A2qV5gdnDrOwOq78
   lkRn7MzeD2ajpextvl4u/E+q+FHBbaT6ZVX8Y6T++vlQ/0tU16psG5DSy
   8QpVxtU+NZFMSHVFRp4j8pOUeg3dseRPpcD1PZ1V8QmNttcFTpZJd+A/1
   UXthWliLJmsILDA7ygIu+p8NMeyMIDsIR49S0R+Y7TvWOlD8I0iCuj7Do
   uRzFfVySHvsbm5UH91jGIb9SuXHHyy3Os77nO54faWmgLNZ1ysA6Q582U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360087373"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="360087373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 22:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858847224"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="858847224"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2023 22:43:58 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBqdJ-0006ax-1Y;
        Wed, 21 Jun 2023 05:43:57 +0000
Date:   Wed, 21 Jun 2023 13:43:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <202306211329.ticOJCSv-lkp@intel.com>
References: <20230620131356.25440-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620131356.25440-11-bhe@redhat.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/ipwireless/main.c: In function 'ipwireless_probe':
   drivers/tty/ipwireless/main.c:115:30: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
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
   arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
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
                    from include/linux/dma-mapping.h:11,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/smsc/smc91c92_cs.c:38:
   drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'smc91c92_release':
   arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/smsc/smc91c92_cs.c:962:17: note: in expansion of macro 'iounmap'
     962 |                 iounmap(smc->base);
         |                 ^~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_config':
   drivers/net/ethernet/xircom/xirc2ps_cs.c:843:28: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
         |                            ^~~~~~~
         |                            iounmap
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:843:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
         |                          ^
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:11,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/linux/ethtool.h:18,
                    from drivers/net/ethernet/xircom/xirc2ps_cs.c:77:
   drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_release':
   arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
      29 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/net/ethernet/xircom/xirc2ps_cs.c:934:25: note: in expansion of macro 'iounmap'
     934 |                         iounmap(local->dingo_ccr - 0x0800);
         |                         ^~~~~~~
   cc1: some warnings being treated as errors


vim +447 drivers/net/ethernet/smsc/smc91c92_cs.c

b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  422  
fba395eee7d3f3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2006-03-31  423  static int mhz_mfc_config(struct pcmcia_device *link)
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  424  {
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  425      struct net_device *dev = link->priv;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  426      struct smc_private *smc = netdev_priv(dev);
b5cb259e7fac55 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  427      unsigned int offset;
b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  428      int i;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  429  
00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  430      link->config_flags |= CONF_ENABLE_SPKR | CONF_ENABLE_IRQ |
00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  431  	    CONF_AUTO_SET_IO;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  432  
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  433      /* The Megahertz combo cards have modem-like CIS entries, so
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  434         we have to explicitly try a bunch of port combinations. */
b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  435      if (pcmcia_loop_config(link, mhz_mfc_config_check, NULL))
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  436  	    return -ENODEV;
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  437  
9a017a910346af drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  438      dev->base_addr = link->resource[0]->start;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  439  
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  440      /* Allocate a memory window, for accessing the ISR */
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  441      link->resource[2]->flags = WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  442      link->resource[2]->start = link->resource[2]->end = 0;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  443      i = pcmcia_request_window(link, link->resource[2], 0);
4c89e88bfde6a3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-03  444      if (i != 0)
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  445  	    return -ENODEV;
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  446  
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28 @447      smc->base = ioremap(link->resource[2]->start,
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  448  		    resource_size(link->resource[2]));
7feabb6412ea23 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-29  449      offset = (smc->manfid == MANFID_MOTOROLA) ? link->config_base : 0;
cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  450      i = pcmcia_map_mem_page(link, link->resource[2], offset);
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  451      if ((i == 0) &&
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  452  	(smc->manfid == MANFID_MEGAHERTZ) &&
8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  453  	(smc->cardid == PRODID_MEGAHERTZ_EM3288))
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  454  	    mhz_3288_power(link);
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  455  
dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  456      return 0;
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  457  }
^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  458  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
