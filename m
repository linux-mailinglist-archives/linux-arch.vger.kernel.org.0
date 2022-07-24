Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E257F2D8
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jul 2022 06:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiGXEIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jul 2022 00:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXEId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2022 00:08:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31AA478;
        Sat, 23 Jul 2022 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658635712; x=1690171712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KlaCr93h2cHkrhlcXaJEJvCc/bHmdCLnUwsrSjluqpg=;
  b=PIM6a0reWcP4yMA8dORMpuUCwRdV3yIpnTup8XF66VyfDiyjOrjMdhbW
   mmr4pEzJEajMsi0SJdHnXzdqVjVEBnucJTkKZFyHPGms0awBkObc0+bay
   bPBac5wkxF8h3y9ksdP7X0gboleVbNDjMpWeEhYnRLqFbgg+dVekwJQg6
   K93Ec4zNt2qMCR6TvoPyOM9i8Z7arjTSZbnezC+6jGF/3/mnxnJoD6ffA
   YJV+A70zz4EuP+YaXvHXNnmzTYjWq7u4wVfi0PyRH14wnztI1nPUP7tT2
   mElfPU+9lqgBcErYUU1THkf8ZhM6RK3omSeX5BLCQc/AnSVrPlbwUoZGZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="270549128"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="270549128"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="688687566"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jul 2022 21:08:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFSun-0003Wn-1L;
        Sun, 24 Jul 2022 04:08:25 +0000
Date:   Sun, 24 Jul 2022 12:07:35 +0800
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
Message-ID: <202207241100.dTmn1Js6-lkp@intel.com>
References: <20220721130419.1904711-3-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130419.1904711-3-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v5.19-rc7 next-20220722]
[cannot apply to akpm-mm/mm-everything tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220721-211006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20220724/202207241100.dTmn1Js6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46a065b827f834b046cffafc7fa165b6fadd9c5c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220721-211006
        git checkout 46a065b827f834b046cffafc7fa165b6fadd9c5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
   In file included from arch/loongarch/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/proc/meminfo.c:2:
   fs/proc/meminfo.c: In function 'meminfo_proc_show':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   include/linux/vmalloc.h:286:24: note: in expansion of macro 'VMALLOC_END'
     286 | #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
         |                        ^~~~~~~~~~~
   fs/proc/meminfo.c:127:35: note: in expansion of macro 'VMALLOC_TOTAL'
     127 |                    (unsigned long)VMALLOC_TOTAL >> 10);
         |                                   ^~~~~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:95:119: note: each undeclared identifier is reported only once for each function it appears in
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   include/linux/vmalloc.h:286:24: note: in expansion of macro 'VMALLOC_END'
     286 | #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
         |                        ^~~~~~~~~~~
   fs/proc/meminfo.c:127:35: note: in expansion of macro 'VMALLOC_TOTAL'
     127 |                    (unsigned long)VMALLOC_TOTAL >> 10);
         |                                   ^~~~~~~~~~~~~
--
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from mm/util.c:2:
   mm/util.c: In function 'kvmalloc_node':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/util.c:634:61: note: in expansion of macro 'VMALLOC_END'
     634 |         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
         |                                                             ^~~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:95:119: note: each undeclared identifier is reported only once for each function it appears in
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/util.c:634:61: note: in expansion of macro 'VMALLOC_END'
     634 |         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
         |                                                             ^~~~~~~~~~~
   mm/util.c:637:1: error: control reaches end of non-void function [-Werror=return-type]
     637 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from mm/vmalloc.c:12:
   mm/vmalloc.c: In function 'is_vmalloc_addr':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:79:48: note: in expansion of macro 'VMALLOC_END'
      79 |         return addr >= VMALLOC_START && addr < VMALLOC_END;
         |                                                ^~~~~~~~~~~
   arch/loongarch/include/asm/pgtable.h:95:119: note: each undeclared identifier is reported only once for each function it appears in
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:79:48: note: in expansion of macro 'VMALLOC_END'
      79 |         return addr >= VMALLOC_START && addr < VMALLOC_END;
         |                                                ^~~~~~~~~~~
   mm/vmalloc.c: In function 'new_vmap_block':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:1915:56: note: in expansion of macro 'VMALLOC_END'
    1915 |                                         VMALLOC_START, VMALLOC_END,
         |                                                        ^~~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:55,
                    from include/linux/vmalloc.h:5,
                    from mm/vmalloc.c:11:
   mm/vmalloc.c: In function 'vm_unmap_ram':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   mm/vmalloc.c:2166:9: note: in expansion of macro 'BUG_ON'
    2166 |         BUG_ON(addr > VMALLOC_END);
         |         ^~~~~~
   mm/vmalloc.c:2166:23: note: in expansion of macro 'VMALLOC_END'
    2166 |         BUG_ON(addr > VMALLOC_END);
         |                       ^~~~~~~~~~~
   mm/vmalloc.c: In function 'vm_map_ram':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:2213:48: note: in expansion of macro 'VMALLOC_END'
    2213 |                                 VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
         |                                                ^~~~~~~~~~~
   mm/vmalloc.c: In function 'vm_area_register_early':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   mm/vmalloc.c:2309:9: note: in expansion of macro 'BUG_ON'
    2309 |         BUG_ON(addr > VMALLOC_END - vm->size);
         |         ^~~~~~
   mm/vmalloc.c:2309:23: note: in expansion of macro 'VMALLOC_END'
    2309 |         BUG_ON(addr > VMALLOC_END - vm->size);
         |                       ^~~~~~~~~~~
   mm/vmalloc.c: In function 'get_vm_area':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:2498:50: note: in expansion of macro 'VMALLOC_END'
    2498 |                                   VMALLOC_START, VMALLOC_END,
         |                                                  ^~~~~~~~~~~
   mm/vmalloc.c: In function 'get_vm_area_caller':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:2507:50: note: in expansion of macro 'VMALLOC_END'
    2507 |                                   VMALLOC_START, VMALLOC_END,
         |                                                  ^~~~~~~~~~~
   mm/vmalloc.c: In function '__vmalloc_node':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:3230:65: note: in expansion of macro 'VMALLOC_END'
    3230 |         return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
         |                                                                 ^~~~~~~~~~~
   mm/vmalloc.c: In function 'vmalloc_huge':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:3282:61: note: in expansion of macro 'VMALLOC_END'
    3282 |         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
         |                                                             ^~~~~~~~~~~
   mm/vmalloc.c: In function 'vmalloc_user':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:3319:67: note: in expansion of macro 'VMALLOC_END'
    3319 |         return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
         |                                                                   ^~~~~~~~~~~
   mm/vmalloc.c: In function 'vmalloc_32_user':
>> arch/loongarch/include/asm/pgtable.h:95:119: error: 'VMEMMAP_SIZE' undeclared (first use in this function); did you mean 'VMEMMAP_END'?
      95 |          min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
         |                                                                                                                       ^~~~~~~~~~~~
   mm/vmalloc.c:3403:67: note: in expansion of macro 'VMALLOC_END'
    3403 |         return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
         |                                                                   ^~~~~~~~~~~
   mm/vmalloc.c: In function 'is_vmalloc_addr':
   mm/vmalloc.c:80:1: error: control reaches end of non-void function [-Werror=return-type]
      80 | }
         | ^
   mm/vmalloc.c: In function 'get_vm_area':
   mm/vmalloc.c:2501:1: error: control reaches end of non-void function [-Werror=return-type]
    2501 | }
         | ^
   mm/vmalloc.c: In function 'get_vm_area_caller':
   mm/vmalloc.c:2509:1: error: control reaches end of non-void function [-Werror=return-type]
    2509 | }
         | ^
   mm/vmalloc.c: In function '__vmalloc_node':
   mm/vmalloc.c:3232:1: error: control reaches end of non-void function [-Werror=return-type]
    3232 | }
         | ^
   mm/vmalloc.c: In function 'vmalloc_huge':
   mm/vmalloc.c:3285:1: error: control reaches end of non-void function [-Werror=return-type]
    3285 | }
         | ^
   mm/vmalloc.c: In function 'vmalloc_user':
   mm/vmalloc.c:3323:1: error: control reaches end of non-void function [-Werror=return-type]
    3323 | }
         | ^
   mm/vmalloc.c: In function 'vmalloc_32_user':
   mm/vmalloc.c:3407:1: error: control reaches end of non-void function [-Werror=return-type]
    3407 | }
         | ^
   cc1: some warnings being treated as errors


vim +95 arch/loongarch/include/asm/pgtable.h

    91	
    92	#define VMALLOC_START	MODULES_END
    93	#define VMALLOC_END	\
    94		(vm_map_base +	\
  > 95		 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
    96	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
