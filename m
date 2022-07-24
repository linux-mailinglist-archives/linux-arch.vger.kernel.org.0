Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5457F30C
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jul 2022 06:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiGXEig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jul 2022 00:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGXEid (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2022 00:38:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7A13F6D;
        Sat, 23 Jul 2022 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658637512; x=1690173512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKItJCecvltUAB2bB/UxycCz6i1zC2y0CtUaVcxBqms=;
  b=ITqYXNnkHH2ZP0+FBku1jLvS5sHocWOK6HMuAKFRfaceylzNIGmZ74N/
   /mpbpTDAmNzHsJWM8eCAh7l3NCaHxJyp6kOF47v7TAi6nbREGAGkd0ykS
   oieo1XZ+VJJ6LrnIxof9snwC+d6eLqXMD6aWrQnPfm8e55QldKxa5VNpF
   cAkv2eTNdPlsZIz8CSUz0+28n92ejFBXQ8LsrslBixZHHfktsQDRbKdlD
   /MT1jSxxumvl8iKObknUYh6SttHEJszOk4fT7gzeIyohJ3S2nNLwPc193
   Gd6gymF+yr3HQbppSr5L1lrpS06JbrJdQl/XUDB+o9VSLataWw7BZWMDd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313255913"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="313255913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="596344915"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Jul 2022 21:38:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFTNq-0003Xv-0N;
        Sun, 24 Jul 2022 04:38:26 +0000
Date:   Sun, 24 Jul 2022 12:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Min Zhou <zhoumin@loongson.cn>
Subject: Re: [PATCH V5 2/4] LoongArch: Add sparse memory vmemmap support
Message-ID: <202207241246.ZV8cRK1g-lkp@intel.com>
References: <20220721130419.1904711-3-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130419.1904711-3-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on kvm/queue arm64/for-next/core linus/master v5.19-rc7 next-20220722]
[cannot apply to akpm-mm/mm-everything tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220721-211006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20220724/202207241246.ZV8cRK1g-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46a065b827f834b046cffafc7fa165b6fadd9c5c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220721-211006
        git checkout 46a065b827f834b046cffafc7fa165b6fadd9c5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:102:
>> arch/nios2/include/asm/pgalloc.h:32:13: error: conflicting types for 'pmd_init'; have 'void(long unsigned int,  long unsigned int)'
      32 | extern void pmd_init(unsigned long page, unsigned long pagetable);
         |             ^~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/nios2/include/uapi/asm/elf.h:24,
                    from arch/nios2/include/asm/elf.h:9,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from kernel/fork.c:30:
   include/linux/mm.h:3206:6: note: previous declaration of 'pmd_init' with type 'void(void *)'
    3206 | void pmd_init(void *addr);
         |      ^~~~~~~~
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:852:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     852 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:947:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     947 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/filemap.c:45:
>> arch/nios2/include/asm/pgalloc.h:32:13: error: conflicting types for 'pmd_init'; have 'void(long unsigned int,  long unsigned int)'
      32 | extern void pmd_init(unsigned long page, unsigned long pagetable);
         |             ^~~~~~~~
   In file included from include/linux/dax.h:6,
                    from mm/filemap.c:15:
   include/linux/mm.h:3206:6: note: previous declaration of 'pmd_init' with type 'void(void *)'
    3206 | void pmd_init(void *addr);
         |      ^~~~~~~~


vim +32 arch/nios2/include/asm/pgalloc.h

cbd15b3fadc27e Ley Foon Tan 2014-11-06  28  
cbd15b3fadc27e Ley Foon Tan 2014-11-06  29  /*
cbd15b3fadc27e Ley Foon Tan 2014-11-06  30   * Initialize a new pmd table with invalid pointers.
cbd15b3fadc27e Ley Foon Tan 2014-11-06  31   */
cbd15b3fadc27e Ley Foon Tan 2014-11-06 @32  extern void pmd_init(unsigned long page, unsigned long pagetable);
cbd15b3fadc27e Ley Foon Tan 2014-11-06  33  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
