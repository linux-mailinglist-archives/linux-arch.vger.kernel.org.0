Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FD58B390
	for <lists+linux-arch@lfdr.de>; Sat,  6 Aug 2022 05:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiHFDlt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Aug 2022 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiHFDlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2022 23:41:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A3B1D6;
        Fri,  5 Aug 2022 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659757307; x=1691293307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bxuIsQ3vSf1Kyabb4SQPd1SdGjo2Pj/GTdgl6KVSO0k=;
  b=MjPLNXtlF3h6L3pWKbB81QXZb+rglfue/Wo6M9SeOz7fPflaPSgFDD14
   TRoGJa2ksj8pNE8RZu4jcw25hvMxj1kMYSaOcDomX45VLsVxodeLpG+uH
   9N/qiLNqn8yEMKyyof6QNXu2VBenbv8F3mqQC4CHC62EaZzdUNz1CJzUT
   aFh+nJoWdMYQfrwZxwHSRxB+R2nIaPm/EtRxFGN50Qsw42KIYMu9asaRi
   99tKmm2w1ofqt5nVzjyvZmEXcVJ0xAf4g+KCmWHgglWXPigM4OwGKmazD
   ThUfShU7kOrsIijsIpAS2B2nf/5I6R4RBiE5IR25/h7nkbICsD61Z23uQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376630299"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="376630299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 20:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="746062001"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2022 20:41:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKAh3-000Jz6-29;
        Sat, 06 Aug 2022 03:41:41 +0000
Date:   Sat, 6 Aug 2022 11:41:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: Re: [PATCH V7 1/4] MIPS&LoongArch&NIOS2: Adjust prototypes of
 p?d_init()
Message-ID: <202208061111.tJqmWcij-lkp@intel.com>
References: <20220802100513.1303717-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802100513.1303717-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on kvm/queue arm64/for-next/core linus/master v5.19 next-20220805]
[cannot apply to akpm-mm/mm-everything tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220802-180930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: mips-buildonly-randconfig-r001-20220805 (https://download.01.org/0day-ci/archive/20220806/202208061111.tJqmWcij-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/284d2afe87bf580321065fb587ffb8ed5a1d0874
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220802-180930
        git checkout 284d2afe87bf580321065fb587ffb8ed5a1d0874
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/mm/init.c:42:
   arch/mips/include/asm/pgalloc.h: In function 'pud_alloc_one':
>> arch/mips/include/asm/pgalloc.h:96:26: warning: passing argument 1 of 'pud_init' makes pointer from integer without a cast [-Wint-conversion]
      96 |                 pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
         |                          ^~~~~~~~~~~~~~~~~~
         |                          |
         |                          long unsigned int
   In file included from arch/mips/include/asm/pgtable.h:17,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/pagemap.h:8,
                    from arch/mips/mm/init.c:21:
   arch/mips/include/asm/pgtable-64.h:329:28: note: expected 'void *' but argument is of type 'long unsigned int'
     329 | extern void pud_init(void *addr);
         |                      ~~~~~~^~~~
   arch/mips/include/asm/pgalloc.h:96:17: error: too many arguments to function 'pud_init'
      96 |                 pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
         |                 ^~~~~~~~
   arch/mips/include/asm/pgtable-64.h:329:13: note: declared here
     329 | extern void pud_init(void *addr);
         |             ^~~~~~~~
   arch/mips/mm/init.c: At top level:
   arch/mips/mm/init.c:60:6: warning: no previous prototype for 'setup_zero_pages' [-Wmissing-prototypes]
      60 | void setup_zero_pages(void)
         |      ^~~~~~~~~~~~~~~~
--
   In file included from arch/mips/mm/pgtable.c:9:
   arch/mips/include/asm/pgalloc.h: In function 'pud_alloc_one':
>> arch/mips/include/asm/pgalloc.h:96:26: warning: passing argument 1 of 'pud_init' makes pointer from integer without a cast [-Wint-conversion]
      96 |                 pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
         |                          ^~~~~~~~~~~~~~~~~~
         |                          |
         |                          long unsigned int
   In file included from arch/mips/include/asm/pgtable.h:17,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from arch/mips/mm/pgtable.c:7:
   arch/mips/include/asm/pgtable-64.h:329:28: note: expected 'void *' but argument is of type 'long unsigned int'
     329 | extern void pud_init(void *addr);
         |                      ~~~~~~^~~~
   arch/mips/include/asm/pgalloc.h:96:17: error: too many arguments to function 'pud_init'
      96 |                 pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
         |                 ^~~~~~~~
   arch/mips/include/asm/pgtable-64.h:329:13: note: declared here
     329 | extern void pud_init(void *addr);
         |             ^~~~~~~~


vim +/pud_init +96 arch/mips/include/asm/pgalloc.h

3377e227af441a Alex Belits  2017-02-16  89  
3377e227af441a Alex Belits  2017-02-16  90  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
3377e227af441a Alex Belits  2017-02-16  91  {
3377e227af441a Alex Belits  2017-02-16  92  	pud_t *pud;
3377e227af441a Alex Belits  2017-02-16  93  
473738eb78c3e3 Michal Hocko 2017-07-12  94  	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
3377e227af441a Alex Belits  2017-02-16  95  	if (pud)
3377e227af441a Alex Belits  2017-02-16 @96  		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
3377e227af441a Alex Belits  2017-02-16  97  	return pud;
3377e227af441a Alex Belits  2017-02-16  98  }
3377e227af441a Alex Belits  2017-02-16  99  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
