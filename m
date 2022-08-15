Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079CE5937F6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiHOSxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244760AbiHOSvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 14:51:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16222474DA;
        Mon, 15 Aug 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660588182; x=1692124182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hq1BhouQn5UWqtGwWSmXW22KHhi6WXee5+A1Sn+nnIA=;
  b=VaCPA5x5mwGXE29AQz49xLzzhiYsrOYEJG6Y2JopNgiJMPygRJD3mDf5
   ZrKd8iJwRNMh3Ls2sC5HIKsjm9qKsZGXdTZYqkIOwdseVyVqxGlVB0jFG
   1+D6O3icNaRdNbtzE+PHKLPMvVcj/fbLWy//8uKMePI30Eop3hcTHRxKQ
   6vfelmzwV173q1CVFnHQt4g0Nu/DXre+SJIUIo4WdFyCgq14BAZNAsSrf
   +WrBj21jraJID0AZkxgSs3DplpxXcCVX+a0LnzfyPDHtL51AQ0741ish6
   g+xIcMcp3ALyaVtHadznIwooGOKIKTF9QRm2aSBoP0E3Y2gLz0euB5HTy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292028786"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="292028786"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="674923069"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2022 11:29:38 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNeqH-0001AD-39;
        Mon, 15 Aug 2022 18:29:37 +0000
Date:   Tue, 16 Aug 2022 02:29:24 +0800
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
Message-ID: <202208160237.kJBIqapz-lkp@intel.com>
References: <20220815124612.3328670-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815124612.3328670-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: loongarch-buildonly-randconfig-r003-20220815 (https://download.01.org/0day-ci/archive/20220816/202208160237.kJBIqapz-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0cdab71896d6b3b3b3f540f80d6f041a0c592e7a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220815-204842
        git checkout 0cdab71896d6b3b3b3f540f80d6f041a0c592e7a
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=loongarch 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/loongarch/mm/init.c:47:6: warning: no previous prototype for 'setup_zero_pages' [-Wmissing-prototypes]
      47 | void setup_zero_pages(void)
         |      ^~~~~~~~~~~~~~~~
   arch/loongarch/mm/init.c: In function 'fixmap_pte':
>> arch/loongarch/mm/init.c:171:24: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     171 |                 pud_t *new;
         |                        ^~~
   arch/loongarch/mm/init.c:182:24: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     182 |                 pmd_t *new;
         |                        ^~~
--
>> arch/loongarch/pci/acpi.c:91:27: warning: no previous prototype for 'arch_pci_ecam_create' [-Wmissing-prototypes]
      91 | struct pci_config_window *arch_pci_ecam_create(struct device *dev,
         |                           ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/pci/acpi.c: In function 'pci_acpi_setup_ecam_mapping':
   arch/loongarch/pci/acpi.c:166:29: error: 'loongson_pci_ecam_ops' undeclared (first use in this function)
     166 |                 ecam_ops = &loongson_pci_ecam_ops;
         |                             ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/pci/acpi.c:166:29: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PCI_LOONGSON
   Depends on [n]: PCI [=y] && (MACH_LOONGSON64 [=y] || COMPILE_TEST [=y]) && (OF [=y] || ACPI [=y]) && PCI_QUIRKS [=n]
   Selected by [y]:
   - LOONGARCH [=y]


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
