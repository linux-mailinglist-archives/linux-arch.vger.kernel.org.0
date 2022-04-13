Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41094FF775
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiDMNOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiDMNOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 09:14:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578F5620E;
        Wed, 13 Apr 2022 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649855540; x=1681391540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWgiHZGg2megmlC5cOpZa/9BAqmc+BctVHL1GWqaHXM=;
  b=V3u5jfXmqiw+g18KXiqpl3ZyF4ZweRQfvPzf0g9jA8Dj5S+2LONjL8Wu
   Gwk3pnjCkIAnlboeSt4tK8yZHHne4v3sVOesUu6LIoe1qASAy9Io/kYht
   7jb0nBWT9wcgn17y/kiviYE0kFcn3xscIb6wqElSWWgN+4xPMl61gaGd+
   bm2XSZrFkjkLorihUSZMdgWGWSHgfDY8f+VXKISVS93id/GrU658JBsOV
   cS8Vfphj8VvbtDO5Hg6gqr2wikZZQuZDFHBigShZ06Bcl0/CHn6rX/p8y
   M1GMf9bpv9/G1OQT8VChnpLlqwN+YeW7EQ5oqhZt0O4wFtewtcW9u/5zl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260255466"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="260255466"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 06:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="552196530"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2022 06:12:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1necn9-0000Ic-9o;
        Wed, 13 Apr 2022 13:12:15 +0000
Date:   Wed, 13 Apr 2022 21:11:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Libo Chen <libo.chen@oracle.com>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Message-ID: <202204132113.V7jyB6Zc-lkp@intel.com>
References: <20220412231508.32629-2-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412231508.32629-2-libo.chen@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Libo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc2 next-20220413]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Libo-Chen/lib-Kconfig-remove-DEBUG_PER_CPU_MAPS-dependency-for-CPUMASK_OFFSTACK/20220413-073657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
config: nios2-randconfig-r023-20220413 (https://download.01.org/0day-ci/archive/20220413/202204132113.V7jyB6Zc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6636f7cf28d2a79cde937c0f212e8a87080da06d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Libo-Chen/lib-Kconfig-remove-DEBUG_PER_CPU_MAPS-dependency-for-CPUMASK_OFFSTACK/20220413-073657
        git checkout 6636f7cf28d2a79cde937c0f212e8a87080da06d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 71
   kernel/workqueue.o: in function `free_workqueue_attrs':
   workqueue.c:(.text+0x3fb8): undefined reference to `free_cpumask_var'
   workqueue.c:(.text+0x3fb8): relocation truncated to fit: R_NIOS2_CALL26 against `free_cpumask_var'
   nios2-linux-ld: kernel/workqueue.o: in function `alloc_workqueue_attrs':
>> workqueue.c:(.text+0x40d4): undefined reference to `alloc_cpumask_var'
   workqueue.c:(.text+0x40d4): relocation truncated to fit: R_NIOS2_CALL26 against `alloc_cpumask_var'
   nios2-linux-ld: kernel/workqueue.o: in function `workqueue_set_unbound_cpumask':
   workqueue.c:(.text+0x5584): undefined reference to `zalloc_cpumask_var'
   workqueue.c:(.text+0x5584): relocation truncated to fit: R_NIOS2_CALL26 against `zalloc_cpumask_var'
   nios2-linux-ld: workqueue.c:(.text+0x5680): undefined reference to `free_cpumask_var'
   workqueue.c:(.text+0x5680): relocation truncated to fit: R_NIOS2_CALL26 against `free_cpumask_var'
   nios2-linux-ld: kernel/workqueue.o: in function `wq_unbound_cpumask_store':
   workqueue.c:(.text+0x56e0): undefined reference to `zalloc_cpumask_var'
   workqueue.c:(.text+0x56e0): relocation truncated to fit: R_NIOS2_CALL26 against `zalloc_cpumask_var'
   nios2-linux-ld: workqueue.c:(.text+0x5718): undefined reference to `free_cpumask_var'
   workqueue.c:(.text+0x5718): relocation truncated to fit: R_NIOS2_CALL26 against `free_cpumask_var'
   nios2-linux-ld: kernel/workqueue.o: in function `workqueue_init_early':
>> workqueue.c:(.init.text+0x1e8): undefined reference to `alloc_cpumask_var'
   workqueue.c:(.init.text+0x1e8): relocation truncated to fit: R_NIOS2_CALL26 against `alloc_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 15310
   kernel/sched/core.o: in function `sched_setaffinity':
>> core.c:(.text+0x3b40): undefined reference to `alloc_cpumask_var'
   core.c:(.text+0x3b40): relocation truncated to fit: R_NIOS2_CALL26 against `alloc_cpumask_var'
>> nios2-linux-ld: core.c:(.text+0x3b54): undefined reference to `alloc_cpumask_var'
   core.c:(.text+0x3b54): relocation truncated to fit: R_NIOS2_CALL26 against `alloc_cpumask_var'
>> nios2-linux-ld: core.c:(.text+0x3be0): undefined reference to `free_cpumask_var'
   core.c:(.text+0x3be0): relocation truncated to fit: R_NIOS2_CALL26 against `free_cpumask_var'
   nios2-linux-ld: core.c:(.text+0x3bf0): undefined reference to `free_cpumask_var'
   core.c:(.text+0x3bf0): additional relocation overflows omitted from the output
   nios2-linux-ld: kernel/sched/core.o: in function `__se_sys_sched_setaffinity':
   core.c:(.text+0x3c64): undefined reference to `alloc_cpumask_var'
   nios2-linux-ld: core.c:(.text+0x3cc4): undefined reference to `free_cpumask_var'
   nios2-linux-ld: kernel/sched/core.o: in function `__se_sys_sched_getaffinity':
   core.c:(.text+0x3dd4): undefined reference to `alloc_cpumask_var'
   nios2-linux-ld: core.c:(.text+0x3e20): undefined reference to `free_cpumask_var'
   nios2-linux-ld: kernel/sched/core.o: in function `sched_init':
>> core.c:(.init.text+0x27c): undefined reference to `load_balance_mask'
>> nios2-linux-ld: core.c:(.init.text+0x284): undefined reference to `load_balance_mask'
>> nios2-linux-ld: core.c:(.init.text+0x28c): undefined reference to `select_idle_mask'
   nios2-linux-ld: core.c:(.init.text+0x290): undefined reference to `select_idle_mask'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 18
   kernel/sched/build_utility.o: in function `housekeeping_setup_type':
   build_utility.c:(.init.text+0x130): undefined reference to `alloc_bootmem_cpumask_var'
   nios2-linux-ld: kernel/sched/build_utility.o: in function `housekeeping_setup':
   build_utility.c:(.init.text+0x198): undefined reference to `alloc_bootmem_cpumask_var'
   nios2-linux-ld: build_utility.c:(.init.text+0x1b4): undefined reference to `alloc_bootmem_cpumask_var'
   nios2-linux-ld: build_utility.c:(.init.text+0x2f4): undefined reference to `free_bootmem_cpumask_var'
   nios2-linux-ld: build_utility.c:(.init.text+0x304): undefined reference to `free_bootmem_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 91
   kernel/profile.o: in function `prof_cpu_mask_proc_write':
   profile.c:(.text+0x40c): undefined reference to `zalloc_cpumask_var'
   nios2-linux-ld: profile.c:(.text+0x450): undefined reference to `free_cpumask_var'
   nios2-linux-ld: kernel/profile.o: in function `profile_init':
>> profile.c:(.ref.text+0xc0): undefined reference to `alloc_cpumask_var'
>> nios2-linux-ld: profile.c:(.ref.text+0x134): undefined reference to `free_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 700424681
   kernel/time/hrtimer.o: in function `clock_was_set':
>> hrtimer.c:(.text+0xc48): undefined reference to `zalloc_cpumask_var'
>> nios2-linux-ld: hrtimer.c:(.text+0xd50): undefined reference to `free_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 361628
   kernel/torture.o: in function `torture_cleanup_begin':
>> torture.c:(.text+0x758): undefined reference to `free_cpumask_var'
   nios2-linux-ld: kernel/torture.o: in function `torture_shuffle_init':
>> torture.c:(.text+0xbe4): undefined reference to `alloc_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 13757
   block/blk-mq.o: in function `blk_mq_alloc_hctx':
   blk-mq.c:(.text+0x1550): undefined reference to `zalloc_cpumask_var_node'
   nios2-linux-ld: blk-mq.c:(.text+0x16d4): undefined reference to `free_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 264202560
   block/blk-mq-sysfs.o: in function `blk_mq_hw_sysfs_release':
   blk-mq-sysfs.c:(.text+0x2c0): undefined reference to `free_cpumask_var'
   nios2-linux-ld: nios2-linux-ld: DWARF error: could not find abbrev number 3666
   drivers/base/cpu.o: in function `print_cpus_offline':
   cpu.c:(.text+0x94): undefined reference to `alloc_cpumask_var'
   nios2-linux-ld: cpu.c:(.text+0xec): undefined reference to `free_cpumask_var'
   nios2-linux-ld: drivers/base/cpu.o: in function `print_cpus_isolated':
   cpu.c:(.text+0x1b8): undefined reference to `alloc_cpumask_var'
   nios2-linux-ld: cpu.c:(.text+0x20c): undefined reference to `free_cpumask_var'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
