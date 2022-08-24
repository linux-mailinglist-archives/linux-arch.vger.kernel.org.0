Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2959F01F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiHXAOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiHXAOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 20:14:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE6883FF;
        Tue, 23 Aug 2022 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661300058; x=1692836058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i3M+r0vqX2r/Wry6UGrPxk6dMbhbJTmexTELkr22rbM=;
  b=eLJqRBQCT2Nry3WGKr+oRmFVPh36p9WAn+hfvEtb11iFpY2r3i/8WwCV
   tX2IWZANPvsFfHfu2tkDjxr0g1Zksv8I9//wjh2ZifTh4xz5ENeBvEjce
   la5NTvwaMrbqTEq57W1P73DEcQR8oN7fdnk83/a2ly6pXVyKLkdQAB3Zm
   9EurMxyqqbUVgj+GBtY/NgyIHhnqCVWE/r4n7wserQ0WIDXqtCta/u7/8
   zHhrhNhJ+534+JGRRT1HRwSknh+Pnl3+bgQsQ6HD663XBN9BN4O1Ukeb0
   3von0OJd4dqCLqi4i8sfH8AKakikjLUDM3fZymxP0m0r3XOIJZzZXUfa8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293827379"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="293827379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="751873229"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2022 17:14:11 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQe27-0000kH-0e;
        Wed, 24 Aug 2022 00:14:11 +0000
Date:   Wed, 24 Aug 2022 08:13:40 +0800
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
Message-ID: <202208240804.stCUUthX-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc2 next-20220823]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220823-110829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 072e51356cd5a4a1c12c1020bc054c99b98333df
config: loongarch-buildonly-randconfig-r001-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240804.stCUUthX-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/io.h:1048,
                    from arch/loongarch/include/asm/io.h:94,
                    from arch/loongarch/include/asm/pgtable.h:62,
                    from arch/loongarch/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/ptrace.h:7,
                    from arch/loongarch/kernel/cpu-probe.c:9:
   include/linux/pgtable.h: In function 'pte_offset_kernel':
   include/linux/pgtable.h:92:25: error: implicit declaration of function 'pmd_page_vaddr'; did you mean 'pgd_page_vaddr'? [-Werror=implicit-function-declaration]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                         ^~~~~~~~~~~~~~
         |                         pgd_page_vaddr
>> include/linux/pgtable.h:92:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                ^
   include/linux/pgtable.h: In function 'virt_to_kpte':
   include/linux/pgtable.h:165:16: error: implicit declaration of function 'pmd_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
         |                pud_none
   include/linux/pgtable.h: In function 'ptep_test_and_clear_young':
   include/linux/pgtable.h:207:14: error: implicit declaration of function 'pte_young' [-Werror=implicit-function-declaration]
     207 |         if (!pte_young(pte))
         |              ^~~~~~~~~
   include/linux/pgtable.h:210:17: error: implicit declaration of function 'set_pte_at' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                 ^~~~~~~~~~
   include/linux/pgtable.h:210:55: error: implicit declaration of function 'pte_mkold' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h: In function 'ptep_get_and_clear':
   include/linux/pgtable.h:269:9: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     269 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
         |         pud_clear
   include/linux/pgtable.h: In function 'ptep_set_wrprotect':
   include/linux/pgtable.h:455:39: error: implicit declaration of function 'pte_wrprotect'; did you mean 'ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     455 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
         |                                       ptep_set_wrprotect
   In file included from include/linux/init.h:5,
                    from arch/loongarch/kernel/cpu-probe.c:7:
   include/linux/pgtable.h: In function 'pmd_none_or_clear_bad':
   include/linux/pgtable.h:877:22: error: implicit declaration of function 'pmd_bad'; did you mean 'pud_bad'? [-Werror=implicit-function-declaration]
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/pgtable.h: In function 'pmd_none_or_trans_huge_or_clear_bad':
   include/linux/pgtable.h:1384:67: error: implicit declaration of function 'pmd_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
         |                                                                   pud_present
   arch/loongarch/include/asm/pgtable.h: At top level:
   arch/loongarch/include/asm/pgtable.h:199:19: error: static declaration of 'pmd_none' follows non-static declaration
     199 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   include/linux/pgtable.h:165:16: note: previous implicit declaration of 'pmd_none' with type 'int()'
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:204:19: error: static declaration of 'pmd_bad' follows non-static declaration
     204 | static inline int pmd_bad(pmd_t pmd)
         |                   ^~~~~~~
   include/linux/pgtable.h:877:22: note: previous implicit declaration of 'pmd_bad' with type 'int()'
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/loongarch/include/asm/pgtable.h:209:19: error: static declaration of 'pmd_present' follows non-static declaration
     209 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   include/linux/pgtable.h:1384:67: note: previous implicit declaration of 'pmd_present' with type 'int()'
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
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
--
   In file included from include/asm-generic/io.h:1048,
                    from arch/loongarch/include/asm/io.h:94,
                    from arch/loongarch/include/asm/pgtable.h:62,
                    from arch/loongarch/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/ptrace.h:7,
                    from include/linux/entry-common.h:6,
                    from arch/loongarch/kernel/traps.c:10:
   include/linux/pgtable.h: In function 'pte_offset_kernel':
   include/linux/pgtable.h:92:25: error: implicit declaration of function 'pmd_page_vaddr'; did you mean 'pgd_page_vaddr'? [-Werror=implicit-function-declaration]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                         ^~~~~~~~~~~~~~
         |                         pgd_page_vaddr
>> include/linux/pgtable.h:92:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                ^
   include/linux/pgtable.h: In function 'virt_to_kpte':
   include/linux/pgtable.h:165:16: error: implicit declaration of function 'pmd_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
         |                pud_none
   include/linux/pgtable.h: In function 'ptep_test_and_clear_young':
   include/linux/pgtable.h:207:14: error: implicit declaration of function 'pte_young' [-Werror=implicit-function-declaration]
     207 |         if (!pte_young(pte))
         |              ^~~~~~~~~
   include/linux/pgtable.h:210:17: error: implicit declaration of function 'set_pte_at' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                 ^~~~~~~~~~
   include/linux/pgtable.h:210:55: error: implicit declaration of function 'pte_mkold' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h: In function 'ptep_get_and_clear':
   include/linux/pgtable.h:269:9: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     269 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
         |         pud_clear
   include/linux/pgtable.h: In function 'ptep_set_wrprotect':
   include/linux/pgtable.h:455:39: error: implicit declaration of function 'pte_wrprotect'; did you mean 'ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     455 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
         |                                       ptep_set_wrprotect
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from arch/loongarch/kernel/traps.c:6:
   include/linux/pgtable.h: In function 'pmd_none_or_clear_bad':
   include/linux/pgtable.h:877:22: error: implicit declaration of function 'pmd_bad'; did you mean 'pud_bad'? [-Werror=implicit-function-declaration]
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/pgtable.h: In function 'pmd_none_or_trans_huge_or_clear_bad':
   include/linux/pgtable.h:1384:67: error: implicit declaration of function 'pmd_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
         |                                                                   pud_present
   arch/loongarch/include/asm/pgtable.h: At top level:
   arch/loongarch/include/asm/pgtable.h:199:19: error: static declaration of 'pmd_none' follows non-static declaration
     199 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   include/linux/pgtable.h:165:16: note: previous implicit declaration of 'pmd_none' with type 'int()'
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:204:19: error: static declaration of 'pmd_bad' follows non-static declaration
     204 | static inline int pmd_bad(pmd_t pmd)
         |                   ^~~~~~~
   include/linux/pgtable.h:877:22: note: previous implicit declaration of 'pmd_bad' with type 'int()'
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/loongarch/include/asm/pgtable.h:209:19: error: static declaration of 'pmd_present' follows non-static declaration
     209 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   include/linux/pgtable.h:1384:67: note: previous implicit declaration of 'pmd_present' with type 'int()'
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
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
--
   In file included from include/asm-generic/io.h:1048,
                    from arch/loongarch/include/asm/io.h:94,
                    from arch/loongarch/include/asm/pgtable.h:62,
                    from arch/loongarch/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from arch/loongarch/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from arch/loongarch/kernel/irq.c:6:
   include/linux/pgtable.h: In function 'pte_offset_kernel':
   include/linux/pgtable.h:92:25: error: implicit declaration of function 'pmd_page_vaddr'; did you mean 'pgd_page_vaddr'? [-Werror=implicit-function-declaration]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                         ^~~~~~~~~~~~~~
         |                         pgd_page_vaddr
>> include/linux/pgtable.h:92:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      92 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                ^
   include/linux/pgtable.h: In function 'virt_to_kpte':
   include/linux/pgtable.h:165:16: error: implicit declaration of function 'pmd_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
         |                pud_none
   include/linux/pgtable.h: In function 'ptep_test_and_clear_young':
   include/linux/pgtable.h:207:14: error: implicit declaration of function 'pte_young' [-Werror=implicit-function-declaration]
     207 |         if (!pte_young(pte))
         |              ^~~~~~~~~
   include/linux/pgtable.h:210:17: error: implicit declaration of function 'set_pte_at' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                 ^~~~~~~~~~
   include/linux/pgtable.h:210:55: error: implicit declaration of function 'pte_mkold' [-Werror=implicit-function-declaration]
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h: In function 'ptep_get_and_clear':
   include/linux/pgtable.h:269:9: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     269 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
         |         pud_clear
   include/linux/pgtable.h: In function 'ptep_set_wrprotect':
   include/linux/pgtable.h:455:39: error: implicit declaration of function 'pte_wrprotect'; did you mean 'ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     455 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
         |                                       ptep_set_wrprotect
   In file included from include/linux/kernel.h:20,
                    from arch/loongarch/kernel/irq.c:5:
   include/linux/pgtable.h: In function 'pmd_none_or_clear_bad':
   include/linux/pgtable.h:877:22: error: implicit declaration of function 'pmd_bad'; did you mean 'pud_bad'? [-Werror=implicit-function-declaration]
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/pgtable.h: In function 'pmd_none_or_trans_huge_or_clear_bad':
   include/linux/pgtable.h:1384:67: error: implicit declaration of function 'pmd_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
         |                                                                   pud_present
   arch/loongarch/include/asm/pgtable.h: At top level:
   arch/loongarch/include/asm/pgtable.h:199:19: error: static declaration of 'pmd_none' follows non-static declaration
     199 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   include/linux/pgtable.h:165:16: note: previous implicit declaration of 'pmd_none' with type 'int()'
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
   arch/loongarch/include/asm/pgtable.h:204:19: error: static declaration of 'pmd_bad' follows non-static declaration
     204 | static inline int pmd_bad(pmd_t pmd)
         |                   ^~~~~~~
   include/linux/pgtable.h:877:22: note: previous implicit declaration of 'pmd_bad' with type 'int()'
     877 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/loongarch/include/asm/pgtable.h:209:19: error: static declaration of 'pmd_present' follows non-static declaration
     209 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   include/linux/pgtable.h:1384:67: note: previous implicit declaration of 'pmd_present' with type 'int()'
    1384 |                 (IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !pmd_present(pmdval)))
         |                                                                   ^~~~~~~~~~~
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
..


vim +92 include/linux/pgtable.h

974b9b2c68f3d3 Mike Rapoport 2020-06-08  88  
974b9b2c68f3d3 Mike Rapoport 2020-06-08  89  #ifndef pte_offset_kernel
974b9b2c68f3d3 Mike Rapoport 2020-06-08  90  static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
974b9b2c68f3d3 Mike Rapoport 2020-06-08  91  {
974b9b2c68f3d3 Mike Rapoport 2020-06-08 @92  	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
974b9b2c68f3d3 Mike Rapoport 2020-06-08  93  }
974b9b2c68f3d3 Mike Rapoport 2020-06-08  94  #define pte_offset_kernel pte_offset_kernel
974b9b2c68f3d3 Mike Rapoport 2020-06-08  95  #endif
974b9b2c68f3d3 Mike Rapoport 2020-06-08  96  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
