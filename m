Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31C50B0F0
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 08:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiDVG7E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiDVG7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 02:59:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163204F46D;
        Thu, 21 Apr 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650610571; x=1682146571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=woXVSuBAGz1p/nvMIX6dnxqIxJiltEEBE48SXFVx2FE=;
  b=a3kDZY0ncheDhigOR2yVIM9inmZjZceU+Ao93Ct//OmOoH4CKNB7HGbs
   KJwkHw941KYmQ8rqcJwVnw0RFXwhcgmRw5lNamfkgUr3hQDEDwPF+njRm
   qfGoAoUItlEXQ9KE5qT7/oGjK0R0f13VuKdmsoXT8KT7jKQOohSbUYQSQ
   ag56qwIpSlryomcGFnObk/QjeYfRwKoF+kp7I4cVC3Y1d1G0WS+Yv6P5w
   pbRoBzAXXnezcl9P70aAqlpHiG9+GdyjVfz05YraBUhcrR2TVekJCiImw
   tY3LWsejVfDsyyt3/mq4J6y39jAIVAkVAcOVdIqoJZh1Z7DcU+pcDHlqo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264068824"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264068824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="615277913"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 23:55:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhnCp-0009LO-QU;
        Fri, 22 Apr 2022 06:55:51 +0000
Date:   Fri, 22 Apr 2022 14:55:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH V2 08/30] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <202202211826.rxBv4dl1-lkp@intel.com>
References: <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220221-144133
base:   https://github.com/hnaz/linux-mm master
config: m68k-randconfig-r033-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211826.rxBv4dl1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e75c29d8b212cfab904914acdd5a027fb15d2f16
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220221-144133
        git checkout e75c29d8b212cfab904914acdd5a027fb15d2f16
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/m68k/mm/init.c:138:10: error: redefinition of 'vm_get_page_prot'
     138 | pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |          ^~~~~~~~~~~~~~~~
   In file included from arch/m68k/mm/init.c:14:
   include/linux/mm.h:2801:24: note: previous definition of 'vm_get_page_prot' with type 'pgprot_t(long unsigned int)'
    2801 | static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |                        ^~~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/m68k/mm/init.c:11:
   arch/m68k/mm/init.c: In function 'vm_get_page_prot':
>> arch/m68k/mm/init.c:144:33: error: 'CF_PAGE_VALID' undeclared (first use in this function)
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                 ^~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
   arch/m68k/mm/init.c:144:33: note: each undeclared identifier is reported only once for each function it appears in
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                 ^~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:144:49: error: 'CF_PAGE_ACCESSED' undeclared (first use in this function); did you mean 'FGP_ACCESSED'?
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:145:33: error: 'CF_PAGE_READABLE' undeclared (first use in this function); did you mean 'PAGE_READONLY'?
     145 |                                 CF_PAGE_READABLE);
         |                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:148:33: error: 'CF_PAGE_WRITABLE' undeclared (first use in this function); did you mean 'NR_PAGETABLE'?
     148 |                                 CF_PAGE_WRITABLE);
         |                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:154:33: error: 'CF_PAGE_EXEC' undeclared (first use in this function)
     154 |                                 CF_PAGE_EXEC);
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:174:52: error: 'CF_PAGE_SHARED' undeclared (first use in this function); did you mean 'PAGE_SHARED'?
     174 |                                 CF_PAGE_READABLE | CF_PAGE_SHARED);
         |                                                    ^~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^


vim +/vm_get_page_prot +138 arch/m68k/mm/init.c

  > 11	#include <linux/module.h>
    12	#include <linux/signal.h>
    13	#include <linux/sched.h>
    14	#include <linux/mm.h>
    15	#include <linux/swap.h>
    16	#include <linux/kernel.h>
    17	#include <linux/string.h>
    18	#include <linux/types.h>
    19	#include <linux/init.h>
    20	#include <linux/memblock.h>
    21	#include <linux/gfp.h>
    22	
    23	#include <asm/setup.h>
    24	#include <linux/uaccess.h>
    25	#include <asm/page.h>
    26	#include <asm/pgalloc.h>
    27	#include <asm/traps.h>
    28	#include <asm/machdep.h>
    29	#include <asm/io.h>
    30	#ifdef CONFIG_ATARI
    31	#include <asm/atari_stram.h>
    32	#endif
    33	#include <asm/sections.h>
    34	#include <asm/tlb.h>
    35	
    36	/*
    37	 * ZERO_PAGE is a special page that is used for zero-initialized
    38	 * data and COW.
    39	 */
    40	void *empty_zero_page;
    41	EXPORT_SYMBOL(empty_zero_page);
    42	
    43	#ifdef CONFIG_MMU
    44	
    45	int m68k_virt_to_node_shift;
    46	
    47	void __init m68k_setup_node(int node)
    48	{
    49		node_set_online(node);
    50	}
    51	
    52	#else /* CONFIG_MMU */
    53	
    54	/*
    55	 * paging_init() continues the virtual memory environment setup which
    56	 * was begun by the code in arch/head.S.
    57	 * The parameters are pointers to where to stick the starting and ending
    58	 * addresses of available kernel virtual memory.
    59	 */
    60	void __init paging_init(void)
    61	{
    62		/*
    63		 * Make sure start_mem is page aligned, otherwise bootmem and
    64		 * page_alloc get different views of the world.
    65		 */
    66		unsigned long end_mem = memory_end & PAGE_MASK;
    67		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
    68	
    69		high_memory = (void *) end_mem;
    70	
    71		empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
    72		if (!empty_zero_page)
    73			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
    74			      __func__, PAGE_SIZE, PAGE_SIZE);
    75		max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
    76		free_area_init(max_zone_pfn);
    77	}
    78	
    79	#endif /* CONFIG_MMU */
    80	
    81	void free_initmem(void)
    82	{
    83	#ifndef CONFIG_MMU_SUN3
    84		free_initmem_default(-1);
    85	#endif /* CONFIG_MMU_SUN3 */
    86	}
    87	
    88	#if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
    89	#define VECTORS	&vectors[0]
    90	#else
    91	#define VECTORS	_ramvec
    92	#endif
    93	
    94	static inline void init_pointer_tables(void)
    95	{
    96	#if defined(CONFIG_MMU) && !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
    97		int i, j;
    98	
    99		/* insert pointer tables allocated so far into the tablelist */
   100		init_pointer_table(kernel_pg_dir, TABLE_PGD);
   101		for (i = 0; i < PTRS_PER_PGD; i++) {
   102			pud_t *pud = (pud_t *)&kernel_pg_dir[i];
   103			pmd_t *pmd_dir;
   104	
   105			if (!pud_present(*pud))
   106				continue;
   107	
   108			pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
   109			init_pointer_table(pmd_dir, TABLE_PMD);
   110	
   111			for (j = 0; j < PTRS_PER_PMD; j++) {
   112				pmd_t *pmd = &pmd_dir[j];
   113				pte_t *pte_dir;
   114	
   115				if (!pmd_present(*pmd))
   116					continue;
   117	
   118				pte_dir = (pte_t *)pmd_page_vaddr(*pmd);
   119				init_pointer_table(pte_dir, TABLE_PTE);
   120			}
   121		}
   122	#endif
   123	}
   124	
   125	void __init mem_init(void)
   126	{
   127		/* this will put all memory onto the freelists */
   128		memblock_free_all();
   129		init_pointer_tables();
   130	}
   131	
   132	#ifdef CONFIG_COLDFIRE
   133	/*
   134	 * Page protections for initialising protection_map. See mm/mmap.c
   135	 * for use. In general, the bit positions are xwr, and P-items are
   136	 * private, the S-items are shared.
   137	 */
 > 138	pgprot_t vm_get_page_prot(unsigned long vm_flags)
   139	{
   140		switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
   141		case VM_NONE:
   142			return PAGE_NONE;
   143		case VM_READ:
 > 144			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 145					CF_PAGE_READABLE);
   146		case VM_WRITE:
   147			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 148					CF_PAGE_WRITABLE);
   149		case VM_WRITE | VM_READ:
   150			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   151					CF_PAGE_READABLE | CF_PAGE_WRITABLE);
   152		case VM_EXEC:
   153			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 154					CF_PAGE_EXEC);
   155		case VM_EXEC | VM_READ:
   156			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   157					CF_PAGE_READABLE | CF_PAGE_EXEC);
   158		case VM_EXEC | VM_WRITE:
   159			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   160					CF_PAGE_WRITABLE | CF_PAGE_EXEC);
   161		case VM_EXEC | VM_WRITE | VM_READ:
   162			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   163					CF_PAGE_READABLE | CF_PAGE_WRITABLE |
   164					CF_PAGE_EXEC);
   165		case VM_SHARED:
   166			return PAGE_NONE;
   167		case VM_SHARED | VM_READ:
   168			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   169					CF_PAGE_READABLE);
   170		case VM_SHARED | VM_WRITE:
   171			return PAGE_SHARED;
   172		case VM_SHARED | VM_WRITE | VM_READ:
   173			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 174					CF_PAGE_READABLE | CF_PAGE_SHARED);
   175		case VM_SHARED | VM_EXEC:
   176			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   177					CF_PAGE_EXEC);
   178		case VM_SHARED | VM_EXEC | VM_READ:
   179			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   180					CF_PAGE_READABLE | CF_PAGE_EXEC);
   181		case VM_SHARED | VM_EXEC | VM_WRITE:
   182			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   183					CF_PAGE_SHARED | CF_PAGE_EXEC);
   184		case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
   185			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   186					CF_PAGE_READABLE | CF_PAGE_SHARED |
   187					CF_PAGE_EXEC);
   188		default:
   189			BUILD_BUG();
   190		}
   191	}
   192	#endif
   193	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
