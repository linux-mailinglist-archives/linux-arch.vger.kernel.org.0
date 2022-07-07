Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486456AF04
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 01:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiGGXcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiGGXcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 19:32:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D21D339
        for <linux-arch@vger.kernel.org>; Thu,  7 Jul 2022 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657236733; x=1688772733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lS2G4PC4wnWEp7j3ChY9b8OoDDrHvyKbmN7vOp6iaew=;
  b=RtQf4CygqKoWKgi0QodHMbS7Pg/V0LFlE21iMk4hs5JcZWaH6khW0qIS
   CenhWLv8o/liii7xvABMJW7SZJiZj/uDUSdBpKnD4K0RqX7t+PCLX4SUG
   ++90wg1rD5YTF9pCfA9A73FHSQuosnsqaQ4l4xc6W8wQPCl7VcZO/MTRS
   fa55L7Zy4vCBu5r8s3IZjdF+TUc7L2GBJZgNHs+14lI28qNFCu82uvFRc
   l1Lb7HwrngjBRpU9IO51oQhbLe29NcAOPyXahu1DiAJ6dCaBPZLJZR+pT
   mPjx6vmV+cXlvD+sfS1DVviMEUMfb+rsO8hLvdXueohPCs9Y+DXNksabm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285271672"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="285271672"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 16:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="620989561"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 16:32:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9ayg-000Mbk-PP;
        Thu, 07 Jul 2022 23:32:10 +0000
Date:   Fri, 8 Jul 2022 07:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [arnd-asm-generic:asm-generic-fixes 1/1] drivers/char/mem.c:66:16:
 error: implicit declaration of function 'devmem_is_allowed'; did you mean
 'page_is_allowed'?
Message-ID: <202207080744.tSGEdxng-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
head:   cdfde8f61a004fa5797d40581077603c142adca1
commit: cdfde8f61a004fa5797d40581077603c142adca1 [1/1] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207080744.tSGEdxng-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=cdfde8f61a004fa5797d40581077603c142adca1
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic asm-generic-fixes
        git checkout cdfde8f61a004fa5797d40581077603c142adca1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/ kernel//

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/char/mem.c: In function 'page_is_allowed':
>> drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'page_is_allowed'? [-Werror=implicit-function-declaration]
      66 |         return devmem_is_allowed(pfn);
         |                ^~~~~~~~~~~~~~~~~
         |                page_is_allowed
   cc1: some warnings being treated as errors


vim +66 drivers/char/mem.c

^1da177e4c3f415 Linus Torvalds   2005-04-16  62  
d092633bff3b19f Ingo Molnar      2008-07-18  63  #ifdef CONFIG_STRICT_DEVMEM
a4866aa812518ed Kees Cook        2017-04-05  64  static inline int page_is_allowed(unsigned long pfn)
a4866aa812518ed Kees Cook        2017-04-05  65  {
a4866aa812518ed Kees Cook        2017-04-05 @66  	return devmem_is_allowed(pfn);
a4866aa812518ed Kees Cook        2017-04-05  67  }
e2beb3eae627211 Venki Pallipadi  2008-03-06  68  static inline int range_is_allowed(unsigned long pfn, unsigned long size)
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  69  {
e2beb3eae627211 Venki Pallipadi  2008-03-06  70  	u64 from = ((u64)pfn) << PAGE_SHIFT;
e2beb3eae627211 Venki Pallipadi  2008-03-06  71  	u64 to = from + size;
e2beb3eae627211 Venki Pallipadi  2008-03-06  72  	u64 cursor = from;
e2beb3eae627211 Venki Pallipadi  2008-03-06  73  
e2beb3eae627211 Venki Pallipadi  2008-03-06  74  	while (cursor < to) {
39380b80d727232 Jiri Kosina      2016-07-08  75  		if (!devmem_is_allowed(pfn))
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  76  			return 0;
e2beb3eae627211 Venki Pallipadi  2008-03-06  77  		cursor += PAGE_SIZE;
e2beb3eae627211 Venki Pallipadi  2008-03-06  78  		pfn++;
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  79  	}
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  80  	return 1;
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  81  }
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  82  #else
a4866aa812518ed Kees Cook        2017-04-05  83  static inline int page_is_allowed(unsigned long pfn)
a4866aa812518ed Kees Cook        2017-04-05  84  {
a4866aa812518ed Kees Cook        2017-04-05  85  	return 1;
a4866aa812518ed Kees Cook        2017-04-05  86  }
e2beb3eae627211 Venki Pallipadi  2008-03-06  87  static inline int range_is_allowed(unsigned long pfn, unsigned long size)
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  88  {
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  89  	return 1;
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  90  }
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  91  #endif
ae531c26c5c2a28 Arjan van de Ven 2008-04-24  92  

:::::: The code at line 66 was first introduced by commit
:::::: a4866aa812518ed1a37d8ea0c881dc946409de94 mm: Tighten x86 /dev/mem with zeroing reads

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
