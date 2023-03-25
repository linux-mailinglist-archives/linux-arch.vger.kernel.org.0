Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FE6C8AC2
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 05:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCYECu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 00:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYECu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 00:02:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A18196B9
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679716967; x=1711252967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o2G1yHVLu9KwuKNJ6AySszy3IweCKDpqTuwDBdk2m1M=;
  b=UoZpl4pZLFrzraI5WKGCq1iHSaf1ylR5iZGb83IHLLthtggT14iT21Ub
   92bxJpQ3KduhMEOZp88XLMT9RKRS7x5EfdQAVv4BfEPYZBWmdsFEg4s3G
   chiFkTMCUratO91ycX43p+rO+z2JSakjJ4B1kL1FwtbuJQ7NC1a8tyfCk
   B36rTlHcPLpBmmegnzsp874sS6TK31I358icSwk1DHSWxLKy6pMF5Laq4
   7EEwc2lUEsR18138rm9Pax/2sGFCMtNba6N3OZAr2Qgo/0tmA9mYHht88
   bWz5fVrHv1R3C3OrgCICFcGG3CzH2oaSYUT9M5D1/q/rQ14bOGeXmLUjT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426194671"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="426194671"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 21:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="633056460"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="633056460"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2023 21:02:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfv77-000FvX-1d;
        Sat, 25 Mar 2023 04:02:45 +0000
Date:   Sat, 25 Mar 2023 12:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework 2/22]
 arch/parisc/include/asm/vdso.h:10:10: fatal error:
 generated/vdso32-offsets.h: No such file or directory
Message-ID: <202303251132.We6NFavu-lkp@intel.com>
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
commit: 30859fbc741ae9358edd55aa0041ecd7ec95e808 [2/22] build workaround
config: parisc-generic-64bit_defconfig (https://download.01.org/0day-ci/archive/20230325/202303251132.We6NFavu-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=30859fbc741ae9358edd55aa0041ecd7ec95e808
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework
        git checkout 30859fbc741ae9358edd55aa0041ecd7ec95e808
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251132.We6NFavu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/parisc/kernel/signal.c:32:
>> arch/parisc/include/asm/vdso.h:10:10: fatal error: generated/vdso32-offsets.h: No such file or directory
      10 | #include <generated/vdso32-offsets.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +10 arch/parisc/include/asm/vdso.h

df24e1783e6e0e Helge Deller 2021-12-08   6  
df24e1783e6e0e Helge Deller 2021-12-08   7  #ifdef CONFIG_64BIT
df24e1783e6e0e Helge Deller 2021-12-08   8  #include <generated/vdso64-offsets.h>
df24e1783e6e0e Helge Deller 2021-12-08   9  #endif
df24e1783e6e0e Helge Deller 2021-12-08 @10  #include <generated/vdso32-offsets.h>
df24e1783e6e0e Helge Deller 2021-12-08  11  

:::::: The code at line 10 was first introduced by commit
:::::: df24e1783e6e0eb3dc0e3ba5a8df3bb0cc537408 parisc: Add vDSO support

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
