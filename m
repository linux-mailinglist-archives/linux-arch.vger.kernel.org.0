Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1ED59D269
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiHWHle (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiHWHlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 03:41:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE104AD4B;
        Tue, 23 Aug 2022 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661240487; x=1692776487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dg0EF2P18h121gETOkseC0QTTDy9x3kXjz5K5KTpB50=;
  b=CFsF6oRQ/boShIhT0LrkeKovgDsKqoebMmNjUV+dq89K1skvp+ZdNAUQ
   QGw8xGS7L2462zLZhfkznIIQkM33uRv7Is03E1afxrB3fyYPbcGnOxvmB
   lwRSjNzBp1oeCDNmFN+cRGvhknhXocJoRTvzgr6lSRmP3gMWxprhB7+HB
   /AeEmfVDSiKZKWnSdssqMdZwmB8JzQ8uoZELo37nEyDY9BCH0CCjoyuQo
   mkyDbsjzBu5Vr51kGYYpueZ78f7rvsXYrRit3qO3S02dD6Jcyj8BynIQx
   IDiS6pWm2H+KLGtwwBhSdOgRMzvnpBL+9flpBMvjeQ6rFxvy+liXeZpLt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357596866"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="357596866"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="854773974"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2022 00:41:19 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQOXG-0000Bp-2e;
        Tue, 23 Aug 2022 07:41:18 +0000
Date:   Tue, 23 Aug 2022 15:41:11 +0800
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
Message-ID: <202208231528.Lgm9hRwt-lkp@intel.com>
References: <20220823030319.3872957-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823030319.3872957-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test WARNING on v6.0-rc2 next-20220822]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-TLB-for-ioremap/20220823-110829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 072e51356cd5a4a1c12c1020bc054c99b98333df
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220823/202208231528.Lgm9hRwt-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/ drivers/net/ fs// kernel/ lib// mm//

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:14,
                    from include/asm-generic/io.h:1048,
                    from arch/loongarch/include/asm/io.h:94,
                    from arch/loongarch/include/asm/pgtable.h:62,
                    from arch/loongarch/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/ptrace.h:7,
                    from arch/loongarch/kernel/cpu-probe.c:9:
   include/asm-generic/pgtable_uffd.h:10:40: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      10 | static __always_inline int pmd_uffd_wp(pmd_t pmd)
         |                                        ^~~~~
         |                                        pud_t
   include/asm-generic/pgtable_uffd.h:20:24: error: unknown type name 'pmd_t'
      20 | static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
         |                        ^~~~~
   include/asm-generic/pgtable_uffd.h:20:44: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      20 | static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
         |                                            ^~~~~
         |                                            pud_t
   include/asm-generic/pgtable_uffd.h:30:24: error: unknown type name 'pmd_t'
      30 | static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
         |                        ^~~~~
   include/asm-generic/pgtable_uffd.h:30:48: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      30 | static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
         |                                                ^~~~~
         |                                                pud_t
   include/asm-generic/pgtable_uffd.h:50:15: error: unknown type name 'pmd_t'
      50 | static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
         |               ^~~~~
   include/asm-generic/pgtable_uffd.h:50:39: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      50 | static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
         |                                       ^~~~~
         |                                       pud_t
   include/asm-generic/pgtable_uffd.h:55:35: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      55 | static inline int pmd_swp_uffd_wp(pmd_t pmd)
         |                                   ^~~~~
         |                                   pud_t
   include/asm-generic/pgtable_uffd.h:60:15: error: unknown type name 'pmd_t'
      60 | static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
         |               ^~~~~
   include/asm-generic/pgtable_uffd.h:60:43: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      60 | static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
         |                                           ^~~~~
         |                                           pud_t
   In file included from include/linux/pgtable.h:15:
   include/linux/page_table_check.h:132:67: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     132 |                                               unsigned long addr, pmd_t pmd)
         |                                                                   ^~~~~
         |                                                                   pud_t
   include/linux/page_table_check.h:148:65: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     148 |                                             unsigned long addr, pmd_t *pmdp,
         |                                                                 ^~~~~
         |                                                                 pud_t
   include/linux/page_table_check.h:149:45: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     149 |                                             pmd_t pmd)
         |                                             ^~~~~
         |                                             pud_t
   include/linux/page_table_check.h:161:53: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     161 |                                                     pmd_t pmd)
         |                                                     ^~~~~
         |                                                     pud_t
   include/linux/pgtable.h:90:40: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
      90 | static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
         |                                        ^~~~~
         |                                        pud_t
   include/linux/pgtable.h:109:15: error: unknown type name 'pmd_t'
     109 | static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
         |               ^~~~~
   include/linux/pgtable.h: In function 'pmd_offset':
   include/linux/pgtable.h:111:16: error: implicit declaration of function 'pud_pgtable'; did you mean 'pmd_pgtable'? [-Werror=implicit-function-declaration]
     111 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ^~~~~~~~~~~
         |                pmd_pgtable
>> include/linux/pgtable.h:111:34: warning: returning 'long unsigned int' from a function with return type 'int *' makes pointer from integer without a cast [-Wint-conversion]
     111 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:151:15: error: unknown type name 'pmd_t'
     151 | static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long va)
         |               ^~~~~
   include/linux/pgtable.h:156:15: error: unknown type name 'pmd_t'
     156 | static inline pmd_t *pmd_off_k(unsigned long va)
         |               ^~~~~
   include/linux/pgtable.h: In function 'virt_to_kpte':
   include/linux/pgtable.h:163:9: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     163 |         pmd_t *pmd = pmd_off_k(vaddr);
         |         ^~~~~
         |         pud_t
   include/linux/pgtable.h:165:16: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
         |                p4d_none
   include/linux/pgtable.h:94:27: error: implicit declaration of function 'pte_offset_kernel' [-Werror=implicit-function-declaration]
      94 | #define pte_offset_kernel pte_offset_kernel
         |                           ^~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:165:40: note: in expansion of macro 'pte_offset_kernel'
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                                        ^~~~~~~~~~~~~~~~~
>> include/linux/pgtable.h:165:38: warning: pointer/integer type mismatch in conditional expression
     165 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                                      ^
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:177:57: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     177 |                                  unsigned long address, pmd_t *pmdp,
         |                                                         ^~~~~
         |                                                         pud_t
   include/linux/pgtable.h:178:34: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     178 |                                  pmd_t entry, int dirty);
         |                                  ^~~~~
         |                                  pud_t
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
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:219:45: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     219 |                                             pmd_t *pmdp)
         |                                             ^~~~~
         |                                             pud_t
   include/linux/pgtable.h:248:58: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     248 |                                   unsigned long address, pmd_t *pmdp);
         |                                                          ^~~~~
         |                                                          pud_t
   include/linux/pgtable.h: In function 'ptep_get_and_clear':
   include/linux/pgtable.h:269:9: error: implicit declaration of function 'pte_clear'; did you mean 'p4d_clear'? [-Werror=implicit-function-declaration]
     269 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
         |         p4d_clear
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:345:15: error: unknown type name 'pmd_t'
     345 | static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
         |               ^~~~~
   include/linux/pgtable.h:347:45: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     347 |                                             pmd_t *pmdp)
         |                                             ^~~~~
         |                                             pud_t
   include/linux/pgtable.h: In function 'pudp_huge_get_and_clear':
   include/linux/pgtable.h:364:9: error: implicit declaration of function 'pud_clear'; did you mean 'p4d_clear'? [-Werror=implicit-function-declaration]
     364 |         pud_clear(pudp);
         |         ^~~~~~~~~
         |         p4d_clear
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:374:15: error: unknown type name 'pmd_t'
     374 | static inline pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
         |               ^~~~~
   include/linux/pgtable.h:375:68: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     375 |                                             unsigned long address, pmd_t *pmdp,
         |                                                                    ^~~~~
         |                                                                    pud_t
   include/linux/pgtable.h:442:8: error: unknown type name 'pmd_t'
     442 | extern pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
         |        ^~~~~
   include/linux/pgtable.h:444:31: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     444 |                               pmd_t *pmdp);
         |                               ^~~~~
         |                               pud_t
   include/linux/pgtable.h: In function 'ptep_set_wrprotect':
   include/linux/pgtable.h:455:39: error: implicit declaration of function 'pte_wrprotect'; did you mean 'ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     455 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
         |                                       ptep_set_wrprotect
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:502:62: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     502 |                                       unsigned long address, pmd_t *pmdp)
         |                                                              ^~~~~
         |                                                              pud_t
   include/linux/pgtable.h:535:8: error: unknown type name 'pmd_t'
     535 | extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
         |        ^~~~~
   include/linux/pgtable.h:536:57: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     536 |                                  unsigned long address, pmd_t *pmdp);
         |                                                         ^~~~~
         |                                                         pud_t
   include/linux/pgtable.h:550:62: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     550 | extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
         |                                                              ^~~~~
         |                                                              pud_t
   include/linux/pgtable.h:555:68: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     555 | extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
         |                                                                    ^~~~~
         |                                                                    pud_t
   include/linux/pgtable.h:564:15: error: unknown type name 'pmd_t'
     564 | static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
         |               ^~~~~
   include/linux/pgtable.h:565:40: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     565 |                 unsigned long address, pmd_t *pmdp, pmd_t pmd)
         |                                        ^~~~~
         |                                        pud_t
   include/linux/pgtable.h:565:53: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     565 |                 unsigned long address, pmd_t *pmdp, pmd_t pmd)
         |                                                     ^~~~~
         |                                                     pud_t
   include/linux/pgtable.h:574:8: error: unknown type name 'pmd_t'
--
         |             p4d_none
   In file included from include/linux/init.h:5,
                    from arch/loongarch/kernel/cpu-probe.c:7:
   include/linux/pgtable.h:866:22: error: implicit declaration of function 'pud_bad'; did you mean 'p4d_bad'? [-Werror=implicit-function-declaration]
     866 |         if (unlikely(pud_bad(*pud))) {
         |                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:873:41: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
     873 | static inline int pmd_none_or_clear_bad(pmd_t *pmd)
         |                                         ^~~~~
         |                                         pud_t
   include/linux/pgtable.h:1083:34: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1083 | static inline int pmd_soft_dirty(pmd_t pmd)
         |                                  ^~~~~
         |                                  pud_t
   include/linux/pgtable.h:1093:15: error: unknown type name 'pmd_t'
    1093 | static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
         |               ^~~~~
   include/linux/pgtable.h:1093:38: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1093 | static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
         |                                      ^~~~~
         |                                      pud_t
   include/linux/pgtable.h:1103:15: error: unknown type name 'pmd_t'
    1103 | static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
         |               ^~~~~
   include/linux/pgtable.h:1103:42: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1103 | static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
         |                                          ^~~~~
         |                                          pud_t
   include/linux/pgtable.h:1123:15: error: unknown type name 'pmd_t'
    1123 | static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
         |               ^~~~~
   include/linux/pgtable.h:1123:42: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1123 | static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
         |                                          ^~~~~
         |                                          pud_t
   include/linux/pgtable.h:1128:38: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1128 | static inline int pmd_swp_soft_dirty(pmd_t pmd)
         |                                      ^~~~~
         |                                      pud_t
   include/linux/pgtable.h:1133:15: error: unknown type name 'pmd_t'
    1133 | static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
         |               ^~~~~
   include/linux/pgtable.h:1133:46: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1133 | static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
         |                                              ^~~~~
         |                                              pud_t
   include/linux/pgtable.h:1264:30: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1264 | static inline int pmd_devmap(pmd_t pmd)
         |                              ^~~~~
         |                              pud_t
   include/linux/pgtable.h:1313:15: error: unknown type name 'pmd_t'
    1313 | static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
         |               ^~~~~
   include/linux/pgtable.h:1313:37: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
    1313 | static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
         |                                     ^~~~~
         |                                     pud_t
   include/linux/pgtable.h:1348:55: error: unknown type name 'pmd_t'; did you mean 'pud_t'?
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
>> arch/loongarch/include/asm/pgtable.h:179:20: warning: conflicting types for 'pud_clear'; have 'void(pud_t *)'
     179 | static inline void pud_clear(pud_t *pudp)
         |                    ^~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:179:20: error: static declaration of 'pud_clear' follows non-static declaration
   include/linux/pgtable.h:364:9: note: previous implicit declaration of 'pud_clear' with type 'void(pud_t *)'
     364 |         pud_clear(pudp);
         |         ^~~~~~~~~
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
>> arch/loongarch/include/asm/pgtable.h:303:20: warning: conflicting types for 'set_pte_at'; have 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t)'
     303 | static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:303:20: error: static declaration of 'set_pte_at' follows non-static declaration
   include/linux/pgtable.h:210:17: note: previous implicit declaration of 'set_pte_at' with type 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t)'
     210 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                 ^~~~~~~~~~
>> arch/loongarch/include/asm/pgtable.h:309:20: warning: conflicting types for 'pte_clear'; have 'void(struct mm_struct *, long unsigned int,  pte_t *)'
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
>> arch/loongarch/include/asm/pgtable.h:382: warning: "pte_accessible" redefined
     382 | #define pte_accessible pte_accessible
         | 
   include/linux/pgtable.h:780: note: this is the location of the previous definition
     780 | # define pte_accessible(mm, pte)        ((void)(pte), 1)
         | 
   In file included from include/linux/mm.h:703,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10:
   include/linux/huge_mm.h: In function 'pmd_trans_huge_lock':
   include/linux/huge_mm.h:236:58: error: implicit declaration of function 'pmd_devmap'; did you mean 'pgd_devmap'? [-Werror=implicit-function-declaration]
     236 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
         |                                                          pgd_devmap
   include/linux/mm.h: In function 'pmd_alloc':
   include/linux/mm.h:2205:21: error: returning 'int *' from a function with incompatible return type 'pmd_t *' [-Werror=incompatible-pointer-types]
    2204 |         return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2205 |                 NULL: pmd_offset(pud, address);
         |                 ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +179 arch/loongarch/include/asm/pgtable.h

09cfefb7fa70c3 Huacai Chen 2022-05-31  168  
09cfefb7fa70c3 Huacai Chen 2022-05-31 @169  static inline int pud_bad(pud_t pud)
09cfefb7fa70c3 Huacai Chen 2022-05-31  170  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  171  	return pud_val(pud) & ~PAGE_MASK;
09cfefb7fa70c3 Huacai Chen 2022-05-31  172  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  173  
09cfefb7fa70c3 Huacai Chen 2022-05-31  174  static inline int pud_present(pud_t pud)
09cfefb7fa70c3 Huacai Chen 2022-05-31  175  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  176  	return pud_val(pud) != (unsigned long)invalid_pmd_table;
09cfefb7fa70c3 Huacai Chen 2022-05-31  177  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  178  
09cfefb7fa70c3 Huacai Chen 2022-05-31 @179  static inline void pud_clear(pud_t *pudp)
09cfefb7fa70c3 Huacai Chen 2022-05-31  180  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  181  	pud_val(*pudp) = ((unsigned long)invalid_pmd_table);
09cfefb7fa70c3 Huacai Chen 2022-05-31  182  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  183  
09cfefb7fa70c3 Huacai Chen 2022-05-31  184  static inline pmd_t *pud_pgtable(pud_t pud)
09cfefb7fa70c3 Huacai Chen 2022-05-31  185  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  186  	return (pmd_t *)pud_val(pud);
09cfefb7fa70c3 Huacai Chen 2022-05-31  187  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  188  
09cfefb7fa70c3 Huacai Chen 2022-05-31  189  #define set_pud(pudptr, pudval) do { *(pudptr) = (pudval); } while (0)
09cfefb7fa70c3 Huacai Chen 2022-05-31  190  
09cfefb7fa70c3 Huacai Chen 2022-05-31  191  #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
09cfefb7fa70c3 Huacai Chen 2022-05-31  192  #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
09cfefb7fa70c3 Huacai Chen 2022-05-31  193  
09cfefb7fa70c3 Huacai Chen 2022-05-31  194  #endif
09cfefb7fa70c3 Huacai Chen 2022-05-31  195  
09cfefb7fa70c3 Huacai Chen 2022-05-31  196  /*
09cfefb7fa70c3 Huacai Chen 2022-05-31  197   * Empty pmd entries point to the invalid_pte_table.
09cfefb7fa70c3 Huacai Chen 2022-05-31  198   */
09cfefb7fa70c3 Huacai Chen 2022-05-31 @199  static inline int pmd_none(pmd_t pmd)
09cfefb7fa70c3 Huacai Chen 2022-05-31  200  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  201  	return pmd_val(pmd) == (unsigned long)invalid_pte_table;
09cfefb7fa70c3 Huacai Chen 2022-05-31  202  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  203  
09cfefb7fa70c3 Huacai Chen 2022-05-31  204  static inline int pmd_bad(pmd_t pmd)
09cfefb7fa70c3 Huacai Chen 2022-05-31  205  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  206  	return (pmd_val(pmd) & ~PAGE_MASK);
09cfefb7fa70c3 Huacai Chen 2022-05-31  207  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  208  
09cfefb7fa70c3 Huacai Chen 2022-05-31  209  static inline int pmd_present(pmd_t pmd)
09cfefb7fa70c3 Huacai Chen 2022-05-31  210  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  211  	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
09cfefb7fa70c3 Huacai Chen 2022-05-31  212  		return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
09cfefb7fa70c3 Huacai Chen 2022-05-31  213  
09cfefb7fa70c3 Huacai Chen 2022-05-31  214  	return pmd_val(pmd) != (unsigned long)invalid_pte_table;
09cfefb7fa70c3 Huacai Chen 2022-05-31  215  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  216  
09cfefb7fa70c3 Huacai Chen 2022-05-31  217  static inline void pmd_clear(pmd_t *pmdp)
09cfefb7fa70c3 Huacai Chen 2022-05-31  218  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  219  	pmd_val(*pmdp) = ((unsigned long)invalid_pte_table);
09cfefb7fa70c3 Huacai Chen 2022-05-31  220  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  221  
09cfefb7fa70c3 Huacai Chen 2022-05-31  222  #define set_pmd(pmdptr, pmdval) do { *(pmdptr) = (pmdval); } while (0)
09cfefb7fa70c3 Huacai Chen 2022-05-31  223  
09cfefb7fa70c3 Huacai Chen 2022-05-31  224  #define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
09cfefb7fa70c3 Huacai Chen 2022-05-31  225  
09cfefb7fa70c3 Huacai Chen 2022-05-31  226  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
09cfefb7fa70c3 Huacai Chen 2022-05-31  227  #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
09cfefb7fa70c3 Huacai Chen 2022-05-31  228  #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
09cfefb7fa70c3 Huacai Chen 2022-05-31  229  
09cfefb7fa70c3 Huacai Chen 2022-05-31  230  #define pmd_page_vaddr(pmd)	pmd_val(pmd)
09cfefb7fa70c3 Huacai Chen 2022-05-31  231  
09cfefb7fa70c3 Huacai Chen 2022-05-31  232  extern pmd_t mk_pmd(struct page *page, pgprot_t prot);
09cfefb7fa70c3 Huacai Chen 2022-05-31  233  extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pmd_t pmd);
09cfefb7fa70c3 Huacai Chen 2022-05-31  234  
09cfefb7fa70c3 Huacai Chen 2022-05-31  235  #define pte_page(x)		pfn_to_page(pte_pfn(x))
09cfefb7fa70c3 Huacai Chen 2022-05-31  236  #define pte_pfn(x)		((unsigned long)(((x).pte & _PFN_MASK) >> _PFN_SHIFT))
09cfefb7fa70c3 Huacai Chen 2022-05-31  237  #define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
09cfefb7fa70c3 Huacai Chen 2022-05-31  238  #define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
09cfefb7fa70c3 Huacai Chen 2022-05-31  239  
09cfefb7fa70c3 Huacai Chen 2022-05-31  240  /*
09cfefb7fa70c3 Huacai Chen 2022-05-31  241   * Initialize a new pgd / pmd table with invalid pointers.
09cfefb7fa70c3 Huacai Chen 2022-05-31  242   */
09cfefb7fa70c3 Huacai Chen 2022-05-31  243  extern void pgd_init(unsigned long page);
09cfefb7fa70c3 Huacai Chen 2022-05-31  244  extern void pud_init(unsigned long page, unsigned long pagetable);
09cfefb7fa70c3 Huacai Chen 2022-05-31  245  extern void pmd_init(unsigned long page, unsigned long pagetable);
09cfefb7fa70c3 Huacai Chen 2022-05-31  246  
09cfefb7fa70c3 Huacai Chen 2022-05-31  247  /*
09cfefb7fa70c3 Huacai Chen 2022-05-31  248   * Non-present pages:  high 40 bits are offset, next 8 bits type,
09cfefb7fa70c3 Huacai Chen 2022-05-31  249   * low 16 bits zero.
09cfefb7fa70c3 Huacai Chen 2022-05-31  250   */
09cfefb7fa70c3 Huacai Chen 2022-05-31  251  static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
09cfefb7fa70c3 Huacai Chen 2022-05-31  252  { pte_t pte; pte_val(pte) = (type << 16) | (offset << 24); return pte; }
09cfefb7fa70c3 Huacai Chen 2022-05-31  253  
09cfefb7fa70c3 Huacai Chen 2022-05-31  254  #define __swp_type(x)		(((x).val >> 16) & 0xff)
09cfefb7fa70c3 Huacai Chen 2022-05-31  255  #define __swp_offset(x)		((x).val >> 24)
09cfefb7fa70c3 Huacai Chen 2022-05-31  256  #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
09cfefb7fa70c3 Huacai Chen 2022-05-31  257  #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
09cfefb7fa70c3 Huacai Chen 2022-05-31  258  #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
09cfefb7fa70c3 Huacai Chen 2022-05-31  259  #define __pmd_to_swp_entry(pmd) ((swp_entry_t) { pmd_val(pmd) })
09cfefb7fa70c3 Huacai Chen 2022-05-31  260  #define __swp_entry_to_pmd(x)	((pmd_t) { (x).val | _PAGE_HUGE })
09cfefb7fa70c3 Huacai Chen 2022-05-31  261  
09cfefb7fa70c3 Huacai Chen 2022-05-31  262  extern void paging_init(void);
09cfefb7fa70c3 Huacai Chen 2022-05-31  263  
09cfefb7fa70c3 Huacai Chen 2022-05-31  264  #define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
09cfefb7fa70c3 Huacai Chen 2022-05-31  265  #define pte_present(pte)	(pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROTNONE))
09cfefb7fa70c3 Huacai Chen 2022-05-31  266  #define pte_no_exec(pte)	(pte_val(pte) & _PAGE_NO_EXEC)
09cfefb7fa70c3 Huacai Chen 2022-05-31  267  
09cfefb7fa70c3 Huacai Chen 2022-05-31  268  static inline void set_pte(pte_t *ptep, pte_t pteval)
09cfefb7fa70c3 Huacai Chen 2022-05-31  269  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  270  	*ptep = pteval;
09cfefb7fa70c3 Huacai Chen 2022-05-31  271  	if (pte_val(pteval) & _PAGE_GLOBAL) {
09cfefb7fa70c3 Huacai Chen 2022-05-31  272  		pte_t *buddy = ptep_buddy(ptep);
09cfefb7fa70c3 Huacai Chen 2022-05-31  273  		/*
09cfefb7fa70c3 Huacai Chen 2022-05-31  274  		 * Make sure the buddy is global too (if it's !none,
09cfefb7fa70c3 Huacai Chen 2022-05-31  275  		 * it better already be global)
09cfefb7fa70c3 Huacai Chen 2022-05-31  276  		 */
46859ac8af52ae Huacai Chen 2022-05-31  277  #ifdef CONFIG_SMP
46859ac8af52ae Huacai Chen 2022-05-31  278  		/*
46859ac8af52ae Huacai Chen 2022-05-31  279  		 * For SMP, multiple CPUs can race, so we need to do
46859ac8af52ae Huacai Chen 2022-05-31  280  		 * this atomically.
46859ac8af52ae Huacai Chen 2022-05-31  281  		 */
46859ac8af52ae Huacai Chen 2022-05-31  282  		unsigned long page_global = _PAGE_GLOBAL;
46859ac8af52ae Huacai Chen 2022-05-31  283  		unsigned long tmp;
46859ac8af52ae Huacai Chen 2022-05-31  284  
46859ac8af52ae Huacai Chen 2022-05-31  285  		__asm__ __volatile__ (
46859ac8af52ae Huacai Chen 2022-05-31  286  		"1:"	__LL	"%[tmp], %[buddy]		\n"
46859ac8af52ae Huacai Chen 2022-05-31  287  		"	bnez	%[tmp], 2f			\n"
46859ac8af52ae Huacai Chen 2022-05-31  288  		"	 or	%[tmp], %[tmp], %[global]	\n"
46859ac8af52ae Huacai Chen 2022-05-31  289  			__SC	"%[tmp], %[buddy]		\n"
46859ac8af52ae Huacai Chen 2022-05-31  290  		"	beqz	%[tmp], 1b			\n"
46859ac8af52ae Huacai Chen 2022-05-31  291  		"	nop					\n"
46859ac8af52ae Huacai Chen 2022-05-31  292  		"2:						\n"
46859ac8af52ae Huacai Chen 2022-05-31  293  		__WEAK_LLSC_MB
46859ac8af52ae Huacai Chen 2022-05-31  294  		: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
46859ac8af52ae Huacai Chen 2022-05-31  295  		: [global] "r" (page_global));
46859ac8af52ae Huacai Chen 2022-05-31  296  #else /* !CONFIG_SMP */
09cfefb7fa70c3 Huacai Chen 2022-05-31  297  		if (pte_none(*buddy))
09cfefb7fa70c3 Huacai Chen 2022-05-31  298  			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
46859ac8af52ae Huacai Chen 2022-05-31  299  #endif /* CONFIG_SMP */
09cfefb7fa70c3 Huacai Chen 2022-05-31  300  	}
09cfefb7fa70c3 Huacai Chen 2022-05-31  301  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  302  
09cfefb7fa70c3 Huacai Chen 2022-05-31 @303  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
09cfefb7fa70c3 Huacai Chen 2022-05-31  304  			      pte_t *ptep, pte_t pteval)
09cfefb7fa70c3 Huacai Chen 2022-05-31  305  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  306  	set_pte(ptep, pteval);
09cfefb7fa70c3 Huacai Chen 2022-05-31  307  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  308  
09cfefb7fa70c3 Huacai Chen 2022-05-31 @309  static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
09cfefb7fa70c3 Huacai Chen 2022-05-31  310  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  311  	/* Preserve global status for the pair */
09cfefb7fa70c3 Huacai Chen 2022-05-31  312  	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
09cfefb7fa70c3 Huacai Chen 2022-05-31  313  		set_pte_at(mm, addr, ptep, __pte(_PAGE_GLOBAL));
09cfefb7fa70c3 Huacai Chen 2022-05-31  314  	else
09cfefb7fa70c3 Huacai Chen 2022-05-31  315  		set_pte_at(mm, addr, ptep, __pte(0));
09cfefb7fa70c3 Huacai Chen 2022-05-31  316  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  317  
09cfefb7fa70c3 Huacai Chen 2022-05-31  318  #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
09cfefb7fa70c3 Huacai Chen 2022-05-31  319  #define PMD_T_LOG2	(__builtin_ffs(sizeof(pmd_t)) - 1)
09cfefb7fa70c3 Huacai Chen 2022-05-31  320  #define PTE_T_LOG2	(__builtin_ffs(sizeof(pte_t)) - 1)
09cfefb7fa70c3 Huacai Chen 2022-05-31  321  
09cfefb7fa70c3 Huacai Chen 2022-05-31  322  extern pgd_t swapper_pg_dir[];
09cfefb7fa70c3 Huacai Chen 2022-05-31  323  extern pgd_t invalid_pg_dir[];
09cfefb7fa70c3 Huacai Chen 2022-05-31  324  
09cfefb7fa70c3 Huacai Chen 2022-05-31  325  /*
09cfefb7fa70c3 Huacai Chen 2022-05-31  326   * The following only work if pte_present() is true.
09cfefb7fa70c3 Huacai Chen 2022-05-31  327   * Undefined behaviour if not..
09cfefb7fa70c3 Huacai Chen 2022-05-31  328   */
09cfefb7fa70c3 Huacai Chen 2022-05-31  329  static inline int pte_write(pte_t pte)	{ return pte_val(pte) & _PAGE_WRITE; }
09cfefb7fa70c3 Huacai Chen 2022-05-31  330  static inline int pte_young(pte_t pte)	{ return pte_val(pte) & _PAGE_ACCESSED; }
09cfefb7fa70c3 Huacai Chen 2022-05-31  331  static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & _PAGE_MODIFIED; }
09cfefb7fa70c3 Huacai Chen 2022-05-31  332  
09cfefb7fa70c3 Huacai Chen 2022-05-31  333  static inline pte_t pte_mkold(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  334  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  335  	pte_val(pte) &= ~_PAGE_ACCESSED;
09cfefb7fa70c3 Huacai Chen 2022-05-31  336  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  337  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  338  
09cfefb7fa70c3 Huacai Chen 2022-05-31  339  static inline pte_t pte_mkyoung(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  340  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  341  	pte_val(pte) |= _PAGE_ACCESSED;
09cfefb7fa70c3 Huacai Chen 2022-05-31  342  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  343  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  344  
09cfefb7fa70c3 Huacai Chen 2022-05-31  345  static inline pte_t pte_mkclean(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  346  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  347  	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_MODIFIED);
09cfefb7fa70c3 Huacai Chen 2022-05-31  348  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  349  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  350  
09cfefb7fa70c3 Huacai Chen 2022-05-31  351  static inline pte_t pte_mkdirty(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  352  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  353  	pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
09cfefb7fa70c3 Huacai Chen 2022-05-31  354  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  355  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  356  
09cfefb7fa70c3 Huacai Chen 2022-05-31  357  static inline pte_t pte_mkwrite(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  358  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  359  	pte_val(pte) |= (_PAGE_WRITE | _PAGE_DIRTY);
09cfefb7fa70c3 Huacai Chen 2022-05-31  360  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  361  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  362  
09cfefb7fa70c3 Huacai Chen 2022-05-31 @363  static inline pte_t pte_wrprotect(pte_t pte)
09cfefb7fa70c3 Huacai Chen 2022-05-31  364  {
09cfefb7fa70c3 Huacai Chen 2022-05-31  365  	pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_DIRTY);
09cfefb7fa70c3 Huacai Chen 2022-05-31  366  	return pte;
09cfefb7fa70c3 Huacai Chen 2022-05-31  367  }
09cfefb7fa70c3 Huacai Chen 2022-05-31  368  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
