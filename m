Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8373820C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjFUKpZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjFUKoy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 06:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4910FF
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687344081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfWcdf1P06wr9dZtmw5KwqOofKgTdxLYKDeKIiQRFzU=;
        b=i6d/tXN6y93tVFYYA2lK3MEmZA4fkvVFJcww0PAW3Ym+L+lYdswqW5cY14voRuZ8Eciv6z
        75OKnrD8Z6p5cnyey5onhECdGL7HdhDTYSE3v2nYvy50/PhoHyfii53wThAXqNZmwBZT2y
        rSmizgz9c50zJwB7xxldFioIk+tHgKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-ExH6W32dN0CP7jEMOW8naQ-1; Wed, 21 Jun 2023 06:41:17 -0400
X-MC-Unique: ExH6W32dN0CP7jEMOW8naQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D3A800CA9;
        Wed, 21 Jun 2023 10:41:16 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D3D1C1ED97;
        Wed, 21 Jun 2023 10:41:14 +0000 (UTC)
Date:   Wed, 21 Jun 2023 18:41:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJLTxUOCEMh6l/El@MiWiFi-R3L-srv>
References: <20230620131356.25440-11-bhe@redhat.com>
 <202306211329.ticOJCSv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211329.ticOJCSv-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 06/21/23 at 01:43pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
> patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/reproduce)

Thanks for reporting this.

I followed steps in above reproduce link, it failed as below. Please
help check if anything is missing.

[root@intel-knightslanding-lb-02 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
Compiler will be installed in /root/0day
lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz
/root/linux                                                                                          
tar Jxf /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz -C /root/0day
Please update: libc6 or glibc
ldd /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc
/root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.36' not found (required by /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc)
setup_crosstool failed


> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/tty/ipwireless/main.c: In function 'ipwireless_probe':
>    drivers/tty/ipwireless/main.c:115:30: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
>      115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
>          |                              ^~~~~~~
>          |                              iounmap
> >> drivers/tty/ipwireless/main.c:115:28: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      115 |         ipw->common_memory = ioremap(p_dev->resource[2]->start,
>          |                            ^
>    drivers/tty/ipwireless/main.c:139:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      139 |         ipw->attr_memory = ioremap(p_dev->resource[3]->start,
>          |                          ^
>    In file included from include/linux/io.h:13,
>                     from drivers/tty/ipwireless/main.c:26:
>    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
>       29 | #define iounmap iounmap
>          |                 ^~~~~~~
>    drivers/tty/ipwireless/main.c:155:9: note: in expansion of macro 'iounmap'
>      155 |         iounmap(ipw->attr_memory);
>          |         ^~~~~~~
>    cc1: some warnings being treated as errors
> --
>    drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'mhz_mfc_config':
> >> drivers/net/ethernet/smsc/smc91c92_cs.c:447:17: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
>      447 |     smc->base = ioremap(link->resource[2]->start,
>          |                 ^~~~~~~
>          |                 ifr_map
> >> drivers/net/ethernet/smsc/smc91c92_cs.c:447:15: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      447 |     smc->base = ioremap(link->resource[2]->start,
>          |               ^
>    In file included from include/linux/scatterlist.h:9,
>                     from include/linux/dma-mapping.h:11,
>                     from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/smsc/smc91c92_cs.c:38:
>    drivers/net/ethernet/smsc/smc91c92_cs.c: In function 'smc91c92_release':
>    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
>       29 | #define iounmap iounmap
>          |                 ^~~~~~~
>    drivers/net/ethernet/smsc/smc91c92_cs.c:962:17: note: in expansion of macro 'iounmap'
>      962 |                 iounmap(smc->base);
>          |                 ^~~~~~~
>    cc1: some warnings being treated as errors
> --
>    drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_config':
>    drivers/net/ethernet/xircom/xirc2ps_cs.c:843:28: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
>      843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
>          |                            ^~~~~~~
>          |                            iounmap
> >> drivers/net/ethernet/xircom/xirc2ps_cs.c:843:26: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      843 |         local->dingo_ccr = ioremap(link->resource[2]->start, 0x1000) + 0x0800;
>          |                          ^
>    In file included from include/linux/scatterlist.h:9,
>                     from include/linux/dma-mapping.h:11,
>                     from include/linux/skbuff.h:28,
>                     from include/linux/if_ether.h:19,
>                     from include/linux/ethtool.h:18,
>                     from drivers/net/ethernet/xircom/xirc2ps_cs.c:77:
>    drivers/net/ethernet/xircom/xirc2ps_cs.c: In function 'xirc2ps_release':
>    arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
>       29 | #define iounmap iounmap
>          |                 ^~~~~~~
>    drivers/net/ethernet/xircom/xirc2ps_cs.c:934:25: note: in expansion of macro 'iounmap'
>      934 |                         iounmap(local->dingo_ccr - 0x0800);
>          |                         ^~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +447 drivers/net/ethernet/smsc/smc91c92_cs.c
> 
> b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  422  
> fba395eee7d3f3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2006-03-31  423  static int mhz_mfc_config(struct pcmcia_device *link)
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  424  {
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  425      struct net_device *dev = link->priv;
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  426      struct smc_private *smc = netdev_priv(dev);
> b5cb259e7fac55 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  427      unsigned int offset;
> b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  428      int i;
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  429  
> 00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  430      link->config_flags |= CONF_ENABLE_SPKR | CONF_ENABLE_IRQ |
> 00990e7ce0b0e5 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-30  431  	    CONF_AUTO_SET_IO;
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  432  
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  433      /* The Megahertz combo cards have modem-like CIS entries, so
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  434         we have to explicitly try a bunch of port combinations. */
> b54bf94bf91e4c drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-02  435      if (pcmcia_loop_config(link, mhz_mfc_config_check, NULL))
> dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  436  	    return -ENODEV;
> dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  437  
> 9a017a910346af drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-24  438      dev->base_addr = link->resource[0]->start;
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  439  
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  440      /* Allocate a memory window, for accessing the ISR */
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  441      link->resource[2]->flags = WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  442      link->resource[2]->start = link->resource[2]->end = 0;
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  443      i = pcmcia_request_window(link, link->resource[2], 0);
> 4c89e88bfde6a3 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2008-08-03  444      if (i != 0)
> dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  445  	    return -ENODEV;
> dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  446  
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28 @447      smc->base = ioremap(link->resource[2]->start,
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  448  		    resource_size(link->resource[2]));
> 7feabb6412ea23 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-29  449      offset = (smc->manfid == MANFID_MOTOROLA) ? link->config_base : 0;
> cdb138080b7814 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2010-07-28  450      i = pcmcia_map_mem_page(link, link->resource[2], offset);
> 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  451      if ((i == 0) &&
> 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  452  	(smc->manfid == MANFID_MEGAHERTZ) &&
> 8e95a2026f3b43 drivers/net/pcmcia/smc91c92_cs.c Joe Perches       2009-12-03  453  	(smc->cardid == PRODID_MEGAHERTZ_EM3288))
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  454  	    mhz_3288_power(link);
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  455  
> dddfbd824b96a2 drivers/net/pcmcia/smc91c92_cs.c Dominik Brodowski 2009-10-18  456      return 0;
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  457  }
> ^1da177e4c3f41 drivers/net/pcmcia/smc91c92_cs.c Linus Torvalds    2005-04-16  458  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

