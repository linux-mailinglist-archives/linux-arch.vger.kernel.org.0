Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F76593729
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiHOSxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244769AbiHOSvz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 14:51:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE70D98;
        Mon, 15 Aug 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660588182; x=1692124182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDIkIG90R71GgG9GXHgYkHB/M4grfjiKMxQjFHILMGk=;
  b=FAGF17hKidPkhDrnHsCvh8CFgywL1xMsGKrIaPj9RWslqrZ6XGLvQwor
   1OYTXi3XoDD5dOVQPYbUqmSycBmz1a0FwisAZTvFlagMl8fjkP0TitIp2
   ppaXE43djSvmuSpQXpCI06Ke/RDDshkallr/RifKvn0F8/USwwbMOrYKu
   raryGrXk9M0rqz6QOLV9R0AV7aRziYiwVO70JbJz5OWJSuaYAvWCS3oSV
   5+4o9WB6QuFUt0yI6g+evGhbxUAfWc9sYs3JTMfLHYhEL+Q6na7n90ESc
   Vm8s218XMzn5D1x7pw4rwMF/I8efyb8Lzlps+7rIB2TP5q96OgOptfPud
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="278991988"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="278991988"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="606745713"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2022 11:29:38 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNeqH-0001AF-3C;
        Mon, 15 Aug 2022 18:29:37 +0000
Date:   Tue, 16 Aug 2022 02:29:22 +0800
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
Message-ID: <202208160215.TXzFu9Xd-lkp@intel.com>
References: <20220815124612.3328670-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815124612.3328670-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc1 next-20220815]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220815-204842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220816/202208160215.TXzFu9Xd-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/loongarch/mm/init.c: In function 'fixmap_pte':
>> arch/loongarch/mm/init.c:171:24: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     171 |                 pud_t *new;
         |                        ^~~
>> arch/loongarch/mm/init.c:187:26: warning: passing argument 1 of 'pmd_init' makes integer from pointer without a cast [-Wint-conversion]
     187 |                 pmd_init(new);
         |                          ^~~
         |                          |
         |                          pmd_t *
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/pagemap.h:8,
                    from arch/loongarch/mm/init.c:14:
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


vim +/new +171 arch/loongarch/mm/init.c

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
 > 171			pud_t *new;
   172	
   173			new = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
   174			pgd_populate(&init_mm, pgd, new);
   175	#ifndef __PAGETABLE_PUD_FOLDED
   176			pud_init(new);
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
 > 187			pmd_init(new);
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
