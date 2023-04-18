Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780B6E5758
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 04:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDRCNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDRCNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 22:13:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8940EC;
        Mon, 17 Apr 2023 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681784000; x=1713320000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqlsjQk8Hlncd0Tit9Ob615YFcxS+GeVN0PRT6FhUrY=;
  b=ayzWXYJpIVZLSBDWQiP68VtNfvYbroBYAigNuAN5GsdljrhDOKPtiNc1
   I5LEPhCbLBDMtxHSMm6B+Xb/ZI03ZDGJ7qBYjNXMDDECK+fnCPe5BLE5H
   MkSTr9NICLvH80ZTG4BoxCyl3MjrXoaFYzlh7Rh9rjur/YHE4EZdNGAPO
   GBGMEMZauP38L33qoS2Bo4HdVnVdrGDwNCG8OPY6v1bHZ8QocPRlMZikC
   rO7sMoxU8q9bqrMHL7SZGrW3FRkohLOAqFZu0Fh9Fg6m0j+MUd9aoEJY2
   s3H+y6BLXHqvN4T+E7AY4kPLJsCsPPKQ6rU5eiS/pq9Chx/tEXoQBCcgd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="343806395"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="343806395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:13:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723460357"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="723460357"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2023 19:13:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poaqG-000cqb-33;
        Tue, 18 Apr 2023 02:13:12 +0000
Date:   Tue, 18 Apr 2023 10:13:01 +0800
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 12/33] mm: Create ptdesc equivalents for
 pgtable_{pte,pmd}_page_{ctor,dtor}
Message-ID: <202304180959.YFCTfVKw-lkp@intel.com>
References: <20230417205048.15870-13-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417205048.15870-13-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vishal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230417]
[cannot apply to s390/features powerpc/next powerpc/fixes geert-m68k/for-next geert-m68k/for-linus linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/s390-Use-_pt_s390_gaddr-for-gmap-address-tracking/20230418-045832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230417205048.15870-13-vishal.moola%40gmail.com
patch subject: [PATCH 12/33] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230418/202304180959.YFCTfVKw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d53de56a2dbf659b53aee1aa2eac60bcc936f10b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/s390-Use-_pt_s390_gaddr-for-gmap-address-tracking/20230418-045832
        git checkout d53de56a2dbf659b53aee1aa2eac60bcc936f10b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304180959.YFCTfVKw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/sh/kernel/asm-offsets.c:14:
   include/linux/mm.h: In function 'virt_to_ptdesc':
   include/linux/mm.h:2723:16: error: implicit declaration of function 'page_ptdesc' [-Werror=implicit-function-declaration]
    2723 |         return page_ptdesc(virt_to_head_page(x));
         |                ^~~~~~~~~~~
   include/linux/mm.h:2723:16: warning: returning 'int' from a function with return type 'struct ptdesc *' makes pointer from integer without a cast [-Wint-conversion]
    2723 |         return page_ptdesc(virt_to_head_page(x));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sh/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sh/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7:
   include/linux/mm.h: In function 'ptdesc_to_virt':
   include/linux/mm.h:2728:29: error: implicit declaration of function 'ptdesc_page'; did you mean 'pte_page'? [-Werror=implicit-function-declaration]
    2728 |         return page_to_virt(ptdesc_page(pt));
         |                             ^~~~~~~~~~~
   arch/sh/include/asm/page.h:139:27: note: in definition of macro '___va'
     139 | #define ___va(x)        ((x)+PAGE_OFFSET)
         |                           ^
   include/linux/mm.h:117:25: note: in expansion of macro '__va'
     117 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                         ^~~~
   include/linux/mm.h:117:30: note: in expansion of macro 'PFN_PHYS'
     117 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                              ^~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:2728:16: note: in expansion of macro 'page_to_virt'
    2728 |         return page_to_virt(ptdesc_page(pt));
         |                ^~~~~~~~~~~~
   include/asm-generic/memory_model.h:46:35: warning: initialization of 'const struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      46 | ({      const struct page *__pg = (pg);                         \
         |                                   ^
   arch/sh/include/asm/page.h:139:27: note: in definition of macro '___va'
     139 | #define ___va(x)        ((x)+PAGE_OFFSET)
         |                           ^
   include/linux/mm.h:117:25: note: in expansion of macro '__va'
     117 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                         ^~~~
   include/linux/mm.h:117:30: note: in expansion of macro 'PFN_PHYS'
     117 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                              ^~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/mm.h:117:39: note: in expansion of macro 'page_to_pfn'
     117 | #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
         |                                       ^~~~~~~~~~~
   include/linux/mm.h:2728:16: note: in expansion of macro 'page_to_virt'
    2728 |         return page_to_virt(ptdesc_page(pt));
         |                ^~~~~~~~~~~~
   include/linux/mm.h: In function 'ptdesc_address':
   include/linux/mm.h:2733:30: error: implicit declaration of function 'ptdesc_folio'; did you mean 'page_folio'? [-Werror=implicit-function-declaration]
    2733 |         return folio_address(ptdesc_folio(pt));
         |                              ^~~~~~~~~~~~
         |                              page_folio
   include/linux/mm.h:2733:30: warning: passing argument 1 of 'folio_address' makes pointer from integer without a cast [-Wint-conversion]
    2733 |         return folio_address(ptdesc_folio(pt));
         |                              ^~~~~~~~~~~~~~~~
         |                              |
         |                              int
   include/linux/mm.h:2151:55: note: expected 'const struct folio *' but argument is of type 'int'
    2151 | static inline void *folio_address(const struct folio *folio)
         |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/mm.h: In function 'ptdesc_is_reserved':
   include/linux/mm.h:2738:36: warning: passing argument 1 of 'folio_test_reserved' makes pointer from integer without a cast [-Wint-conversion]
    2738 |         return folio_test_reserved(ptdesc_folio(pt));
         |                                    ^~~~~~~~~~~~~~~~
         |                                    |
         |                                    int
   In file included from include/linux/mmzone.h:23:
   include/linux/page-flags.h:375:62: note: expected 'struct folio *' but argument is of type 'int'
     375 | static __always_inline bool folio_test_##lname(struct folio *folio)     \
         |                                                ~~~~~~~~~~~~~~^~~~~
   include/linux/page-flags.h:423:9: note: in expansion of macro 'TESTPAGEFLAG'
     423 |         TESTPAGEFLAG(uname, lname, policy)                              \
         |         ^~~~~~~~~~~~
   include/linux/page-flags.h:494:1: note: in expansion of macro 'PAGEFLAG'
     494 | PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
         | ^~~~~~~~
   include/linux/mm.h: In function 'ptdesc_alloc':
   include/linux/mm.h:2745:16: warning: returning 'int' from a function with return type 'struct ptdesc *' makes pointer from integer without a cast [-Wint-conversion]
    2745 |         return page_ptdesc(page);
         |                ^~~~~~~~~~~~~~~~~
   include/linux/mm.h: In function 'ptdesc_free':
   include/linux/mm.h:2750:29: warning: initialization of 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2750 |         struct page *page = ptdesc_page(pt);
         |                             ^~~~~~~~~~~
   include/linux/mm.h: In function 'ptdesc_pte_ctor':
>> include/linux/mm.h:2826:31: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2826 |         struct folio *folio = ptdesc_folio(ptdesc);
         |                               ^~~~~~~~~~~~
   include/linux/mm.h: In function 'pgtable_pte_page_ctor':
   include/linux/mm.h:2837:32: warning: passing argument 1 of 'ptdesc_pte_ctor' makes pointer from integer without a cast [-Wint-conversion]
    2837 |         return ptdesc_pte_ctor(page_ptdesc(page));
         |                                ^~~~~~~~~~~~~~~~~
         |                                |
         |                                int
   include/linux/mm.h:2824:51: note: expected 'struct ptdesc *' but argument is of type 'int'
    2824 | static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
         |                                    ~~~~~~~~~~~~~~~^~~~~~
   include/linux/mm.h: In function 'ptdesc_pte_dtor':
   include/linux/mm.h:2842:31: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2842 |         struct folio *folio = ptdesc_folio(ptdesc);
         |                               ^~~~~~~~~~~~
   include/linux/mm.h: In function 'pgtable_pte_page_dtor':
   include/linux/mm.h:2851:25: warning: passing argument 1 of 'ptdesc_pte_dtor' makes pointer from integer without a cast [-Wint-conversion]
    2851 |         ptdesc_pte_dtor(page_ptdesc(page));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/mm.h:2840:51: note: expected 'struct ptdesc *' but argument is of type 'int'
    2840 | static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
         |                                    ~~~~~~~~~~~~~~~^~~~~~
   include/linux/mm.h: In function 'ptdesc_pmd_ctor':
   include/linux/mm.h:2935:31: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2935 |         struct folio *folio = ptdesc_folio(ptdesc);
         |                               ^~~~~~~~~~~~
   include/linux/mm.h: In function 'pgtable_pmd_page_ctor':
   include/linux/mm.h:2946:32: warning: passing argument 1 of 'ptdesc_pmd_ctor' makes pointer from integer without a cast [-Wint-conversion]
    2946 |         return ptdesc_pmd_ctor(page_ptdesc(page));
         |                                ^~~~~~~~~~~~~~~~~
         |                                |
         |                                int
   include/linux/mm.h:2933:51: note: expected 'struct ptdesc *' but argument is of type 'int'
    2933 | static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
         |                                    ~~~~~~~~~~~~~~~^~~~~~
   include/linux/mm.h: In function 'ptdesc_pmd_dtor':
   include/linux/mm.h:2951:31: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2951 |         struct folio *folio = ptdesc_folio(ptdesc);
         |                               ^~~~~~~~~~~~
   include/linux/mm.h: In function 'pgtable_pmd_page_dtor':
   include/linux/mm.h:2960:25: warning: passing argument 1 of 'ptdesc_pmd_dtor' makes pointer from integer without a cast [-Wint-conversion]
    2960 |         ptdesc_pmd_dtor(page_ptdesc(page));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/mm.h:2949:51: note: expected 'struct ptdesc *' but argument is of type 'int'
    2949 | static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
         |                                    ~~~~~~~~~~~~~~~^~~~~~
   include/linux/mm.h: In function 'free_reserved_ptdesc':
   include/linux/mm.h:3016:28: warning: passing argument 1 of 'free_reserved_page' makes pointer from integer without a cast [-Wint-conversion]
    3016 |         free_reserved_page(ptdesc_page(pt));
         |                            ^~~~~~~~~~~~~~~
         |                            |
         |                            int
   include/linux/mm.h:2999:52: note: expected 'struct page *' but argument is of type 'int'
    2999 | static inline void free_reserved_page(struct page *page)
         |                                       ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:114: arch/sh/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +2826 include/linux/mm.h

  2823	
  2824	static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
  2825	{
> 2826		struct folio *folio = ptdesc_folio(ptdesc);
  2827	
  2828		if (!ptlock_init(ptdesc))
  2829			return false;
  2830		__SetPageTable(&folio->page);
  2831		lruvec_stat_add_folio(folio, NR_PAGETABLE);
  2832		return true;
  2833	}
  2834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
