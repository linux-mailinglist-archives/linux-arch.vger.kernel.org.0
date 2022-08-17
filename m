Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF0596664
	for <lists+linux-arch@lfdr.de>; Wed, 17 Aug 2022 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiHQAlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 20:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiHQAlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 20:41:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8190810;
        Tue, 16 Aug 2022 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660696869; x=1692232869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S4BQg3ffuAC6DjQBXUYCKsfem8RO0ADyHIESWLOL+0s=;
  b=FVB2gJvoGXw+cFq/5pqjVpCKeiChfSXln9+SKR+gPDatEN3Xjvt5MerF
   gi/dZw5xajaFGJ5ex6YRIt9f09x573cd3ez2iusWArd3LKR5rCa7f7EVc
   HcJHXQ9lPZ44UCLQqo0oLa+4sZ3gjEecY37mDHnMCOd8RpEYE6TfVblb+
   5rzIVSXjTbglvay1J+mEyjc1HAJU2fvul/DhMKbVENKNjhTIKCLajA6wQ
   aUjpFTO2eF3DgcBFNBBrCdLxyyhkDT353OrbauO2egQU0oolsRqCt2sSX
   p1H/uvco0ce33xWTuvgrTh+lTo7g6FYASVJAwN9PlzFXV2uZnl1+Ys204
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272757133"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272757133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 17:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="749511181"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 17:41:05 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO77J-0000OC-04;
        Wed, 17 Aug 2022 00:41:05 +0000
Date:   Wed, 17 Aug 2022 08:41:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Use TLB for ioremap()
Message-ID: <202208170818.SWTJWEdB-lkp@intel.com>
References: <20220815124612.3328670-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815124612.3328670-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc1 next-20220816]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220815-204842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: loongarch-randconfig-r015-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170818.SWTJWEdB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0cdab71896d6b3b3b3f540f80d6f041a0c592e7a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220815-204842
        git checkout 0cdab71896d6b3b3b3f540f80d6f041a0c592e7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/loongarch/mm/init.c:47:6: warning: no previous prototype for 'setup_zero_pages' [-Wmissing-prototypes]
      47 | void setup_zero_pages(void)
         |      ^~~~~~~~~~~~~~~~
   arch/loongarch/mm/init.c: In function 'fixmap_pte':
   arch/loongarch/mm/init.c:176:26: warning: passing argument 1 of 'pud_init' makes integer from pointer without a cast [-Wint-conversion]
     176 |                 pud_init(new);
         |                          ^~~
         |                          |
         |                          pud_t *
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/pagemap.h:8,
                    from arch/loongarch/mm/init.c:14:
   arch/loongarch/include/asm/pgtable.h:244:36: note: expected 'long unsigned int' but argument is of type 'pud_t *'
     244 | extern void pud_init(unsigned long page, unsigned long pagetable);
         |                      ~~~~~~~~~~~~~~^~~~
>> arch/loongarch/mm/init.c:176:17: error: too few arguments to function 'pud_init'
     176 |                 pud_init(new);
         |                 ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:244:13: note: declared here
     244 | extern void pud_init(unsigned long page, unsigned long pagetable);
         |             ^~~~~~~~
   arch/loongarch/mm/init.c:187:26: warning: passing argument 1 of 'pmd_init' makes integer from pointer without a cast [-Wint-conversion]
     187 |                 pmd_init(new);
         |                          ^~~
         |                          |
         |                          pmd_t *
   arch/loongarch/include/asm/pgtable.h:245:36: note: expected 'long unsigned int' but argument is of type 'pmd_t *'
     245 | extern void pmd_init(unsigned long page, unsigned long pagetable);
         |                      ~~~~~~~~~~~~~~^~~~
   arch/loongarch/mm/init.c:187:17: error: too few arguments to function 'pmd_init'
     187 |                 pmd_init(new);
         |                 ^~~~~~~~
   In file included from arch/loongarch/mm/init.c:35:
   arch/loongarch/include/asm/pgalloc.h:48:13: note: declared here
      48 | extern void pmd_init(unsigned long page, unsigned long pagetable);
         |             ^~~~~~~~


vim +/pud_init +176 arch/loongarch/mm/init.c

   159	
   160	static pte_t *fixmap_pte(unsigned long addr)
   161	{
   162		pgd_t *pgd;
   163		p4d_t *p4d;
   164		pud_t *pud;
   165		pmd_t *pmd;
   166	
   167		pgd = pgd_offset_k(addr);
   168		p4d = p4d_offset(pgd, addr);
   169	
   170		if (pgd_none(*pgd)) {
   171			pud_t *new;
   172	
   173			new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
   174			pgd_populate(&init_mm, pgd, new);
   175	#ifndef __PAGETABLE_PUD_FOLDED
 > 176			pud_init(new);
   177	#endif
   178		}
   179	
   180		pud = pud_offset(p4d, addr);
   181		if (pud_none(*pud)) {
   182			pmd_t *new;
   183	
   184			new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
   185			pud_populate(&init_mm, pud, new);
   186	#ifndef __PAGETABLE_PMD_FOLDED
   187			pmd_init(new);
   188	#endif
   189		}
   190	
   191		pmd = pmd_offset(pud, addr);
   192		if (pmd_none(*pmd)) {
   193			pte_t *new;
   194	
   195			new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
   196			pmd_populate_kernel(&init_mm, pmd, new);
   197		}
   198	
   199		return pte_offset_kernel(pmd, addr);
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
