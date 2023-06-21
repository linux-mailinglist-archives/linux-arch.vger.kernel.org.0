Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE3738FF1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFUTVn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjFUTVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 15:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE79D;
        Wed, 21 Jun 2023 12:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E18A6168A;
        Wed, 21 Jun 2023 19:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D6C433C0;
        Wed, 21 Jun 2023 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687375296;
        bh=dXl/RcITYryeZDp/bcQ5wJ7/OYXFDVjxEVm67BCHVZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvsYqzA5QWIMPhJaQm+yBP+QxYh0+8vZjVBb6WWe4CedNcVdeci9dJ55DW57FAWlH
         v8h77PSL8j7tiWr/EWfYm0kjUtUtJ7x0O8kK2jLCao9kYL5VQXpoQEgaoVfQ6PQxHd
         P6rwvXUHOA+W0sa6wF9T6klertLGMbXpEFJWrlEX2Cirbdw1lEIPRi9cIhX+PMlojc
         AHzY/67zJtoa+bh5OVu1uMVGSA9PY91VUZ330171wKCtbyAycNIbNB6R99iacR0h0e
         xWKrUyx+06M8Lp/695TzkCE/sY5ma5sfThgWJNWEGXO88Mqt1JUwwGV+qs1QgB+krz
         UfItkGn73Ul4Q==
Date:   Wed, 21 Jun 2023 19:21:33 +0000
From:   Nathan Chancellor <nathan@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, glaubitz@physik.fu-berlin.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <20230621192133.GB842758@dev-arch.thelio-3990X>
References: <20230620131356.25440-11-bhe@redhat.com>
 <202306211329.ticOJCSv-lkp@intel.com>
 <ZJLTxUOCEMh6l/El@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJLTxUOCEMh6l/El@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 06:41:09PM +0800, Baoquan He wrote:
> Hi,
> 
> On 06/21/23 at 01:43pm, kernel test robot wrote:
> > Hi Baoquan,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on akpm-mm/mm-everything]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
> > patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
> > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/reproduce)
> 
> Thanks for reporting this.
> 
> I followed steps in above reproduce link, it failed as below. Please
> help check if anything is missing.
> 
> [root@intel-knightslanding-lb-02 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
> Compiler will be installed in /root/0day
> lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz
> /root/linux                                                                                          
> tar Jxf /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz -C /root/0day
> Please update: libc6 or glibc
> ldd /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc
> /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.36' not found (required by /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc)
> setup_crosstool failed

Certain recent versions of the kernel.org crosstool toolchains were
built against a pretty recent glibc so attempting to run it on a system
with an older glibc will result in the error above:

https://lore.kernel.org/87mt2eoopo.fsf@kernel.org/

Arnd resolved this and reuploaded the binaries, I suspect the Intel
folks need to mirror the updated tarballs to 01.org:

https://lore.kernel.org/e9601db2-ff7d-4490-abd5-8d3c5946e108@app.fastmail.com/

According to make.cross, you can override the URL it uses with a
variable, you could try removing these files

  /root/0day/gcc-12.3.0-nolibc/s390-linux
  /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz

and running

  $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 URL=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig

to see if that works now.

Cheers,
Nathan

> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    drivers/tty/ipwireless/main.c: In function 'ipwireless_probe':
> >    drivers/tty/ipwireless/main.c:115:30: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
> >      115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
> >          |                              ^~~~~~~
> >          |                              iounmap
> > >> drivers/tty/ipwireless/main.c:115:28: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
> >          |                            ^
> >    drivers/tty/ipwireless/main.c:139:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      139 |         ipw->attr_memory = ioremap(p_dev->resource[3]->start,
> >          |                          ^
> >    In file included from include/linux/io.h:13,
> >                     from drivers/tty/ipwireless/main.c:26:
> >    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
> >       29 | #define iounmap iounmap
> >          |                 ^~~~~~~
> >    drivers/tty/ipwireless/main.c:155:9: note: in expansion of macro 'iounmap'
> >      155 |         iounmap(ipw->attr_memory);
> >          |         ^~~~~~~
> >    cc1: some warnings being treated as errors
> > --
> >    drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'mhz_mfc_config':
> > >> drivers/net/ethernet/smsc/smc91c92_cs.c:447:17: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
> >      447 |     smc->base = ioremap(link->resource[2]->start,
> >          |                 ^~~~~~~
> >          |                 ifr_map
> > >> drivers/net/ethernet/smsc/smc91c92_cs.c:447:15: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      447 |     smc->base = ioremap(link->resource[2]->start,
> >          |               ^
> >    In file included from include/linux/scatterlist.h:9,
> >                     from include/linux/dma-mapping.h:11,
> >                     from include/linux/skbuff.h:28,
> >                     from include/net/net_namespace.h:43,
> >                     from include/linux/netdevice.h:38,
> >                     from drivers/net/ethernet/smsc/smc91c92_cs.c:38:
> >    drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'smc91c92_release':
> >    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
> >       29 | #define iounmap iounmap
> >          |                 ^~~~~~~
> >    drivers/net/ethernet/smsc/smc91c92_cs.c:962:17: note: in expansion of macro 'iounmap'
> >      962 |                 iounmap(smc->base);
> >          |                 ^~~~~~~
> >    cc1: some warnings being treated as errors
> > --
> >    drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_config':
> >    drivers/net/ethernet/xircom/xirc2ps_cs.c:843:28: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
> >      843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
> >          |                            ^~~~~~~
> >          |                            iounmap
> > >> drivers/net/ethernet/xircom/xirc2ps_cs.c:843:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >      843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
> >          |                          ^
> >    In file included from include/linux/scatterlist.h:9,
> >                     from include/linux/dma-mapping.h:11,
> >                     from include/linux/skbuff.h:28,
> >                     from include/linux/if_ether.h:19,
> >                     from include/linux/ethtool.h:18,
> >                     from drivers/net/ethernet/xircom/xirc2ps_cs.c:77:
> >    drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_release':
> >    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
> >       29 | #define iounmap iounmap
> >          |                 ^~~~~~~
> >    drivers/net/ethernet/xircom/xirc2ps_cs.c:934:25: note: in expansion of macro 'iounmap'
> >      934 |                         iounmap(local->dingo_ccr - 0x0800);
> >          |                         ^~~~~~~
> >    cc1: some warnings being treated as errors
> > 
> > 
> > vim +447 drivers/net/ethernet/smsc/smc91c92_cs.c
> > 
> > b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  422  
> > fba395eee7d3f3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2006-03-31  423  static int mhz_mfc_config(struct pcmcia_device *link)
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  424  {
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  425      struct net_device *dev = link->priv;
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  426      struct smc_private *smc = netdev_priv(dev);
> > b5cb259e7fac55 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  427      unsigned int offset;
> > b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  428      int i;
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  429  
> > 00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  430      link->config_flags |= CONF_ENABLE_SPKR | CONF_ENABLE_IRQ |
> > 00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  431  	    CONF_AUTO_SET_IO;
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  432  
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  433      /* The Megahertz combo cards have modem-like CIS entries, so
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  434         we have to explicitly try a bunch of port combinations. */
> > b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  435      if (pcmcia_loop_config(link, mhz_mfc_config_check, NULL))
> > dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  436  	    return -ENODEV;
> > dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  437  
> > 9a017a910346af drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  438      dev->base_addr = link->resource[0]->start;
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  439  
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  440      /* Allocate a memory window, for accessing the ISR */
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  441      link->resource[2]->flags = WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  442      link->resource[2]->start = link->resource[2]->end = 0;
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  443      i = pcmcia_request_window(link, link->resource[2], 0);
> > 4c89e88bfde6a3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-03  444      if (i != 0)
> > dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  445  	    return -ENODEV;
> > dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  446  
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28 @447      smc->base = ioremap(link->resource[2]->start,
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  448  		    resource_size(link->resource[2]));
> > 7feabb6412ea23 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-29  449      offset = (smc->manfid == MANFID_MOTOROLA) ? link->config_base : 0;
> > cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  450      i = pcmcia_map_mem_page(link, link->resource[2], offset);
> > 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  451      if ((i == 0) &&
> > 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  452  	(smc->manfid == MANFID_MEGAHERTZ) &&
> > 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  453  	(smc->cardid == PRODID_MEGAHERTZ_EM3288))
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  454  	    mhz_3288_power(link);
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  455  
> > dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  456      return 0;
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  457  }
> > ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  458  
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 
