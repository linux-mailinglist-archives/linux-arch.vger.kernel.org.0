Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31759F1DB
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 05:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiHXDLz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 23:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiHXDL1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 23:11:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C699101C5;
        Tue, 23 Aug 2022 20:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661310499; x=1692846499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MahLqOQl6BQ0rIng3RRbSBPaNoZ9O9wxY+GIKX9UVyI=;
  b=GNqYE4yvg4/Mg9SxT/hEU7BIpSWfZb1G2KnXiOjuS6tm3oDz10ZO1QAF
   XAQKeDMVMJNtP3+S21KUgP0ZphcBtUgU5cG20b4T397gKurIq97f8L0Zo
   e98bYLmyUsVUj4dw6jhVBNenRMil0I1mOnhfxiEg5A9nF/GzFVSVyYnJm
   dYbcW35RObRBKc/+FATmhTFtUiUgH8hUxa2kzxfkRpogYwV5ZnG98Vmlv
   qZwkLh0yJL2i8ADee86bIeDP0/nnSj4ZRbxzTUfNw0/+LpuIPy5gNlhKe
   0/vrVKKd2uf7FlJ/oNwnmRV0skjYNZNAZtB1oN5bJxP01O+u4F7NIIPpS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291416787"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="291416787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 20:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="642687054"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2022 20:08:16 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQgkZ-0000tz-1M;
        Wed, 24 Aug 2022 03:08:15 +0000
Date:   Wed, 24 Aug 2022 11:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] LoongArch: Use TLB for ioremap()
Message-ID: <202208241152.Bp1fUWJ1-lkp@intel.com>
References: <20220823030319.3872957-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823030319.3872957-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test ERROR on v6.0-rc2 next-20220823]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220823-110829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 072e51356cd5a4a1c12c1020bc054c99b98333df
config: loongarch-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220824/202208241152.Bp1fUWJ1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/80f55a8feb23743d963d113c803bf54b1287244d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220823-110829
        git checkout 80f55a8feb23743d963d113c803bf54b1287244d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

    1348 | static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
         |                                                       ^~~~~
         |                                                       pud_t
   include/linux/pgtable.h:1405:38: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1405 | static inline int pmd_trans_unstable(pmd_t *pmd)
         |                                      ^~~~~
         |                                      pud_t
   include/linux/pgtable.h:1420:45: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1420 | static inline int pmd_devmap_trans_unstable(pmd_t *pmd)
         |                                             ^~~~~
         |                                             pud_t
   include/linux/pgtable.h:1439:32: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1439 | static inline int pmd_protnone(pmd_t pmd)
         |                                ^~~~~
         |                                pud_t
   include/linux/pgtable.h:1476:32: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1476 | static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
         |                                ^~~~~
         |                                pud_t
   include/linux/pgtable.h:1485:34: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1485 | static inline int pmd_clear_huge(pmd_t *pmd)
         |                                  ^~~~~
         |                                  pud_t
   include/linux/pgtable.h:1497:37: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1497 | static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
         |                                     ^~~~~
         |                                     pud_t
   arch/loongarch/include/asm/pgtable.h:164:19: error: static declaration of 'pud_none' follows non-static declaration
     164 | static inline int pud_none(pud_t pud)
         |                   ^~~~~~~~
   include/linux/pgtable.h:864:13: note: previous implicit declaration of 'pud_none' with type 'int()'
     864 |         if (pud_none(*pud))
         |             ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:169:19: error: static declaration of 'pud_bad' follows non-static declaration
     169 | static inline int pud_bad(pud_t pud)
         |                   ^~~~~~~
   include/linux/pgtable.h:866:22: note: previous implicit declaration of 'pud_bad' with type 'int()'
     866 |         if (unlikely(pud_bad(*pud))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/loongarch/include/asm/pgtable.h:184:22: error: conflicting types for 'pud_pgtable'; have 'pmd_t *(pud_t)'
     184 | static inline pmd_t *pud_pgtable(pud_t pud)
         |                      ^~~~~~~~~~~
   include/linux/pgtable.h:111:16: note: previous implicit declaration of 'pud_pgtable' with type 'int()'
     111 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ^~~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:199:19: error: static declaration of 'pmd_none' follows non-static declaration
     199 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   include/linux/pgtable.h:165:16: note: previous implicit declaration of 'pmd_none' with type 'int()'
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:303:20: warning: conflicting types for 'set_pte_at'; have 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t)'
     303 | static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:303:20: error: static declaration of 'set_pte_at' follows non-static declaration
   include/linux/pgtable.h:210:17: note: previous implicit declaration of 'set_pte_at' with type 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t)'
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                 ^~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:309:20: warning: conflicting types for 'pte_clear'; have 'void(struct mm_struct *, long unsigned int,  pte_t *)'
     309 | static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
         |                    ^~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:309:20: error: static declaration of 'pte_clear' follows non-static declaration
   include/linux/pgtable.h:269:9: note: previous implicit declaration of 'pte_clear' with type 'void(struct mm_struct *, long unsigned int,  pte_t *)'
     269 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:330:19: error: static declaration of 'pte_young' follows non-static declaration
     330 | static inline int pte_young(pte_t pte)  { return pte_val(pte) & _PAGE_ACCESSED; }
         |                   ^~~~~~~~~
   include/linux/pgtable.h:207:14: note: previous implicit declaration of 'pte_young' with type 'int()'
     207 |         if (!pte_young(pte))
         |              ^~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:333:21: error: conflicting types for 'pte_mkold'; have 'pte_t(pte_t)'
     333 | static inline pte_t pte_mkold(pte_t pte)
         |                     ^~~~~~~~~
   include/linux/pgtable.h:210:55: note: previous implicit declaration of 'pte_mkold' with type 'int()'
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:363:21: error: conflicting types for 'pte_wrprotect'; have 'pte_t(pte_t)'
     363 | static inline pte_t pte_wrprotect(pte_t pte)
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:455:39: note: previous implicit declaration of 'pte_wrprotect' with type 'int()'
     455 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:382: warning: "pte_accessible" redefined
     382 | #define pte_accessible pte_accessible
         | 
   include/linux/pgtable.h:780: note: this is the location of the previous definition
     780 | # define pte_accessible(mm, pte)        ((void)(pte), 1)
         | 
   In file included from include/linux/dax.h:6:
   include/linux/mm.h: In function 'pmd_alloc':
   include/linux/mm.h:2205:21: error: returning 'int *' from a function with incompatible return type 'pmd_t *' [-Werror=incompatible-pointer-types]
    2204 |         return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2205 |                 NULL: pmd_offset(pud, address);
         |                 ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/filemap.c: In function 'filemap_map_pmd':
>> mm/filemap.c:3237:13: error: implicit declaration of function 'pmd_trans_huge'; did you mean 'pud_trans_huge'? [-Werror=implicit-function-declaration]
    3237 |         if (pmd_trans_huge(*vmf->pmd)) {
         |             ^~~~~~~~~~~~~~
         |             pud_trans_huge
   mm/filemap.c:3256:13: error: implicit declaration of function 'pmd_devmap_trans_unstable'; did you mean 'pud_trans_unstable'? [-Werror=implicit-function-declaration]
    3256 |         if (pmd_devmap_trans_unstable(vmf->pmd)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |             pud_trans_unstable
   mm/filemap.c: In function 'filemap_map_pages':
   include/linux/pgtable.h:94:27: warning: initialization of 'pte_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      94 | #define pte_offset_kernel pte_offset_kernel
         |                           ^~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:103:41: note: in expansion of macro 'pte_offset_kernel'
     103 | #define pte_offset_map(dir, address)    pte_offset_kernel((dir), (address))
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/mm.h:2298:24: note: in expansion of macro 'pte_offset_map'
    2298 |         pte_t *__pte = pte_offset_map(pmd, address);    \
         |                        ^~~~~~~~~~~~~~
   mm/filemap.c:3347:20: note: in expansion of macro 'pte_offset_map_lock'
    3347 |         vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
         |                    ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +3237 mm/filemap.c

54cb8821de07f2 Nicholas Piggin    2007-07-19  3231  
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3232  static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3233  {
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3234  	struct mm_struct *mm = vmf->vma->vm_mm;
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3235  
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3236  	/* Huge page is mapped? No need to proceed. */
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19 @3237  	if (pmd_trans_huge(*vmf->pmd)) {
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3238  		unlock_page(page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3239  		put_page(page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3240  		return true;
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3241  	}
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3242  
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3243  	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3244  		vm_fault_t ret = do_set_pmd(vmf, page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3245  		if (!ret) {
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3246  			/* The page is mapped successfully, reference consumed. */
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3247  			unlock_page(page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3248  			return true;
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3249  		}
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3250  	}
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3251  
03c4f20454e023 Qi Zheng           2021-11-05  3252  	if (pmd_none(*vmf->pmd))
03c4f20454e023 Qi Zheng           2021-11-05  3253  		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3254  
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3255  	/* See comment in handle_pte_fault() */
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3256  	if (pmd_devmap_trans_unstable(vmf->pmd)) {
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3257  		unlock_page(page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3258  		put_page(page);
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3259  		return true;
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3260  	}
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3261  
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3262  	return false;
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3263  }
f9ce0be71d1fbb Kirill A. Shutemov 2020-12-19  3264  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
