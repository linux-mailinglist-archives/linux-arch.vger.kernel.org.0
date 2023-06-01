Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C554719FD5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjFAOYk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjFAOYj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 10:24:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6161FC;
        Thu,  1 Jun 2023 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629478; x=1717165478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BaD1zw6V2jf+wne8NUiF1WEc49QRybnZ2yKptn30Dmk=;
  b=g1aybGChwSwwHLtrLrIonUYSm1lYhIMMZTtMV4TPym8PLnzuLenQ5iHe
   nNMYHLT0quEiRdF1lKyNG/Aeql87GJVSx6MCsQcp0n7kBbC7emNU5gC4J
   +VSQmF/A3I+2fbt8d9bSDTMPO8zDM25CUSFd1adPzKJc2iMVzwDoZXYns
   N7siqRkUQVx0wb9SPPGZ1wZ8TdC3t8ywtN+XkPPVaxBJeT91jaoq0bLGr
   T5G898YHxNqpz4HZIHhYF3CPl02VXWoIgOlTrxXPvL+2Qng0uJUX+3DT8
   uc/qTX0VgID7snj30MS2pH9rK0Wk3HlIrJU6zPsXfkCvl6ou3yXMFpqtt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419088767"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419088767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657813870"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657813870"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 07:19:17 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j92-0002Lp-1h;
        Thu, 01 Jun 2023 14:19:16 +0000
Date:   Thu, 1 Jun 2023 22:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
Message-ID: <202306011704.i8xMWKPl-lkp@intel.com>
References: <20230531213032.25338-26-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531213032.25338-26-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vishal,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230531]
[cannot apply to akpm-mm/mm-everything s390/features powerpc/next powerpc/fixes geert-m68k/for-next geert-m68k/for-linus linus/master v6.4-rc4 v6.4-rc3 v6.4-rc2 v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230601-053454
base:   next-20230531
patch link:    https://lore.kernel.org/r/20230531213032.25338-26-vishal.moola%40gmail.com
patch subject: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
config: m68k-randconfig-r002-20230531 (https://download.01.org/0day-ci/archive/20230601/202306011704.i8xMWKPl-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/915ab62dc3315fe0a0544fccb4ee5f3ee32694b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230601-053454
        git checkout 915ab62dc3315fe0a0544fccb4ee5f3ee32694b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011704.i8xMWKPl-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/pgalloc.h:12,
                    from arch/m68k/mm/init.c:26:
   arch/m68k/include/asm/mcf_pgalloc.h: In function 'pgd_alloc':
>> arch/m68k/include/asm/mcf_pgalloc.h:83:59: error: 'GFP_NOWARN' undeclared (first use in this function); did you mean 'GFP_NOWAIT'?
      83 |         struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | GFP_NOWARN, 0);
         |                                                           ^~~~~~~~~~
         |                                                           GFP_NOWAIT
   arch/m68k/include/asm/mcf_pgalloc.h:83:59: note: each undeclared identifier is reported only once for each function it appears in
   arch/m68k/include/asm/mcf_pgalloc.h: At top level:
>> arch/m68k/include/asm/mcf_pgalloc.h:22:27: warning: 'ptdesc_address' is static but used in inline function 'pte_alloc_one_kernel' which is not static
      22 |         return (pte_t *) (ptdesc_address(ptdesc));
         |                           ^~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:17:33: warning: 'pagetable_alloc' is static but used in inline function 'pte_alloc_one_kernel' which is not static
      17 |         struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | __GFP_ZERO, 0);
         |                                 ^~~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:10:24: warning: 'virt_to_ptdesc' is static but used in inline function 'pte_free_kernel' which is not static
      10 |         pagetable_free(virt_to_ptdesc(pte));
         |                        ^~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:10:9: warning: 'pagetable_free' is static but used in inline function 'pte_free_kernel' which is not static
      10 |         pagetable_free(virt_to_ptdesc(pte));
         |         ^~~~~~~~~~~~~~
--
   In file included from arch/m68k/mm/mcfmmu.c:21:
   arch/m68k/include/asm/mcf_pgalloc.h: In function 'pgd_alloc':
>> arch/m68k/include/asm/mcf_pgalloc.h:83:59: error: 'GFP_NOWARN' undeclared (first use in this function); did you mean 'GFP_NOWAIT'?
      83 |         struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | GFP_NOWARN, 0);
         |                                                           ^~~~~~~~~~
         |                                                           GFP_NOWAIT
   arch/m68k/include/asm/mcf_pgalloc.h:83:59: note: each undeclared identifier is reported only once for each function it appears in
   arch/m68k/mm/mcfmmu.c: At top level:
   arch/m68k/mm/mcfmmu.c:36:13: warning: no previous prototype for 'paging_init' [-Wmissing-prototypes]
      36 | void __init paging_init(void)
         |             ^~~~~~~~~~~
   arch/m68k/mm/mcfmmu.c: In function 'paging_init':
   arch/m68k/mm/mcfmmu.c:41:37: warning: variable 'bootmem_end' set but not used [-Wunused-but-set-variable]
      41 |         unsigned long next_pgtable, bootmem_end;
         |                                     ^~~~~~~~~~~
   arch/m68k/include/asm/mcf_pgalloc.h: At top level:
>> arch/m68k/include/asm/mcf_pgalloc.h:22:27: warning: 'ptdesc_address' is static but used in inline function 'pte_alloc_one_kernel' which is not static
      22 |         return (pte_t *) (ptdesc_address(ptdesc));
         |                           ^~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:17:33: warning: 'pagetable_alloc' is static but used in inline function 'pte_alloc_one_kernel' which is not static
      17 |         struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | __GFP_ZERO, 0);
         |                                 ^~~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:10:24: warning: 'virt_to_ptdesc' is static but used in inline function 'pte_free_kernel' which is not static
      10 |         pagetable_free(virt_to_ptdesc(pte));
         |                        ^~~~~~~~~~~~~~
>> arch/m68k/include/asm/mcf_pgalloc.h:10:9: warning: 'pagetable_free' is static but used in inline function 'pte_free_kernel' which is not static
      10 |         pagetable_free(virt_to_ptdesc(pte));
         |         ^~~~~~~~~~~~~~


vim +83 arch/m68k/include/asm/mcf_pgalloc.h

     7	
     8	extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
     9	{
  > 10		pagetable_free(virt_to_ptdesc(pte));
    11	}
    12	
    13	extern const char bad_pmd_string[];
    14	
    15	extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
    16	{
  > 17		struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | __GFP_ZERO, 0);
    18	
    19		if (!ptdesc)
    20			return NULL;
    21	
  > 22		return (pte_t *) (ptdesc_address(ptdesc));
    23	}
    24	
    25	extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
    26	{
    27		return (pmd_t *) pgd;
    28	}
    29	
    30	#define pmd_populate(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
    31	
    32	#define pmd_populate_kernel pmd_populate
    33	
    34	static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
    35					  unsigned long address)
    36	{
    37		struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
    38	
    39		pagetable_pte_dtor(ptdesc);
    40		pagetable_free(ptdesc);
    41	}
    42	
    43	static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
    44	{
    45		struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA, 0);
    46		pte_t *pte;
    47	
    48		if (!ptdesc)
    49			return NULL;
    50		if (!pagetable_pte_ctor(ptdesc)) {
    51			pagetable_free(ptdesc);
    52			return NULL;
    53		}
    54	
    55		pte = ptdesc_address(ptdesc);
    56		pagetable_clear(pte);
    57	
    58		return pte;
    59	}
    60	
    61	static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
    62	{
    63		struct ptdesc *ptdesc = virt_to_ptdesc(ptdesc);
    64	
    65		pagetable_pte_dtor(ptdesc);
    66		pagetable_free(ptdesc);
    67	}
    68	
    69	/*
    70	 * In our implementation, each pgd entry contains 1 pmd that is never allocated
    71	 * or freed.  pgd_present is always 1, so this should never be called. -NL
    72	 */
    73	#define pmd_free(mm, pmd) BUG()
    74	
    75	static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
    76	{
    77		pagetable_free(virt_to_ptdesc(pgd));
    78	}
    79	
    80	static inline pgd_t *pgd_alloc(struct mm_struct *mm)
    81	{
    82		pgd_t *new_pgd;
  > 83		struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | GFP_NOWARN, 0);
    84	
    85		if (!ptdesc)
    86			return NULL;
    87		new_pgd = (pgd_t *) ptdesc_address(ptdesc);
    88	
    89		memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
    90		memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
    91		return new_pgd;
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
