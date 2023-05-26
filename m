Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2537123F3
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbjEZJqc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 May 2023 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEZJqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 05:46:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1DA4;
        Fri, 26 May 2023 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685094389; x=1716630389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wCWGZqjxmi5S7z4xOw6jSScIIJ8ZtfxFVm7rVDtgoOU=;
  b=dW6nefangcRRlkdI941I+QPLc3cxI1xByis9KerUf40qvLYJzpb2Vam8
   oPNKuF53o19epMDay/PKLZ4zXyAQoW5RSriz+FfsHhBWMEBP6OKCIxbSG
   mkkiM7zIBhj/UKgrxWA6KAJs2Uf5vqQId2Jx3XlSEkrTEEPmYyGz4MvtB
   iM8eg1rYhxsj+n3hdvBlpbZu+Strc6CVlgvD1VbFhVGZ3DVbB4bvQufT1
   uhRoV2OvjscSiEY3Qvb3lfsVYL30NKHx8RjIyFlAdi2ziLyn9XntPJZKq
   TtBGesvic28jS66yldcWJGP8LLMPPGh1BHF+l1/fwf3nONTSUjA718F1x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="382409623"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="382409623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 02:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="708337372"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="708337372"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2023 02:46:25 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2U1g-000JEN-32;
        Fri, 26 May 2023 09:46:24 +0000
Date:   Fri, 26 May 2023 17:45:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Baoquan He <bhe@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
Message-ID: <202305261736.cBisGOAz-lkp@intel.com>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
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

Hi Jiaxun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/mips-add-asm-generic-io-h-including/20230520-035318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230519195135.79600-1-jiaxun.yang%40flygoat.com
patch subject: [PATCH v4] mips: add <asm-generic/io.h> including
config: mips-randconfig-r015-20230525 (https://download.01.org/0day-ci/archive/20230526/202305261736.cBisGOAz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4f10a6993ab8060829908b87cdeea41f7eae38e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiaxun-Yang/mips-add-asm-generic-io-h-including/20230520-035318
        git checkout 4f10a6993ab8060829908b87cdeea41f7eae38e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/mmc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305261736.cBisGOAz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/dw_mmc.c:41:
>> drivers/mmc/host/dw_mmc.h:506:9: warning: '__raw_writeq' macro redefined [-Wmacro-redefined]
   #define __raw_writeq(__value, __reg) \
           ^
   arch/mips/include/asm/io.h:566:9: note: previous definition is here
   #define __raw_writeq __raw_writeq
           ^
   In file included from drivers/mmc/host/dw_mmc.c:41:
>> drivers/mmc/host/dw_mmc.h:508:9: warning: '__raw_readq' macro redefined [-Wmacro-redefined]
   #define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
           ^
   arch/mips/include/asm/io.h:562:9: note: previous definition is here
   #define __raw_readq __raw_readq
           ^
   2 warnings generated.


vim +/__raw_writeq +506 drivers/mmc/host/dw_mmc.h

76184ac17edf3c Ben Dooks   2015-03-25  473  
f95f3850f7a9e1 Will Newton 2011-01-02  474  /* Register access macros */
f95f3850f7a9e1 Will Newton 2011-01-02  475  #define mci_readl(dev, reg)			\
a2f17680f42878 Ben Dooks   2015-03-25  476  	readl_relaxed((dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  477  #define mci_writel(dev, reg, value)			\
a2f17680f42878 Ben Dooks   2015-03-25  478  	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  479  
f95f3850f7a9e1 Will Newton 2011-01-02  480  /* 16-bit FIFO access macros */
f95f3850f7a9e1 Will Newton 2011-01-02  481  #define mci_readw(dev, reg)			\
a2f17680f42878 Ben Dooks   2015-03-25  482  	readw_relaxed((dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  483  #define mci_writew(dev, reg, value)			\
a2f17680f42878 Ben Dooks   2015-03-25  484  	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  485  
f95f3850f7a9e1 Will Newton 2011-01-02  486  /* 64-bit FIFO access macros */
f95f3850f7a9e1 Will Newton 2011-01-02  487  #ifdef readq
f95f3850f7a9e1 Will Newton 2011-01-02  488  #define mci_readq(dev, reg)			\
a2f17680f42878 Ben Dooks   2015-03-25  489  	readq_relaxed((dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  490  #define mci_writeq(dev, reg, value)			\
a2f17680f42878 Ben Dooks   2015-03-25  491  	writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
f95f3850f7a9e1 Will Newton 2011-01-02  492  #else
f95f3850f7a9e1 Will Newton 2011-01-02  493  /*
f95f3850f7a9e1 Will Newton 2011-01-02  494   * Dummy readq implementation for architectures that don't define it.
f95f3850f7a9e1 Will Newton 2011-01-02  495   *
f95f3850f7a9e1 Will Newton 2011-01-02  496   * We would assume that none of these architectures would configure
f95f3850f7a9e1 Will Newton 2011-01-02  497   * the IP block with a 64bit FIFO width, so this code will never be
f95f3850f7a9e1 Will Newton 2011-01-02  498   * executed on those machines. Defining these macros here keeps the
f95f3850f7a9e1 Will Newton 2011-01-02  499   * rest of the code free from ifdefs.
f95f3850f7a9e1 Will Newton 2011-01-02  500   */
f95f3850f7a9e1 Will Newton 2011-01-02  501  #define mci_readq(dev, reg)			\
892b1e312b1791 James Hogan 2011-06-24  502  	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
f95f3850f7a9e1 Will Newton 2011-01-02  503  #define mci_writeq(dev, reg, value)			\
892b1e312b1791 James Hogan 2011-06-24  504  	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
76184ac17edf3c Ben Dooks   2015-03-25  505  
76184ac17edf3c Ben Dooks   2015-03-25 @506  #define __raw_writeq(__value, __reg) \
76184ac17edf3c Ben Dooks   2015-03-25  507  	(*(volatile u64 __force *)(__reg) = (__value))
76184ac17edf3c Ben Dooks   2015-03-25 @508  #define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
f95f3850f7a9e1 Will Newton 2011-01-02  509  #endif
f95f3850f7a9e1 Will Newton 2011-01-02  510  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
