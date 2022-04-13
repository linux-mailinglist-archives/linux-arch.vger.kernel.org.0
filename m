Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBAA4FF923
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiDMOnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiDMOnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 10:43:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531C40E52;
        Wed, 13 Apr 2022 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860877; x=1681396877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=linNOV4EomB16L2HapHfKkK9INH52m95HA/3C7Gt7dc=;
  b=Gf1QutFsWw4xQHNwPWm9xJbrKtf8v3m+AQWMLuHe/JfZhrtmTB+/ZlE6
   CS5pBlET/nxZTQhDKVRkgdC9eWZQ7jmPfNWaVEdRMRyMJ/lkKWWe2VsMK
   pCUHjx6VeZfWblhIPknj/rYww0YkT2sfl8Fw93yV1SMnQy6VAgI5RPPOV
   9GX9ulniC/SrNEkuj0mz8iNHIi6GK5oWL+8u9zOZ8Gf/56HBBd5Gf8Nkx
   QLUXDfIrJRsIplAv+tzP6AhcxgG21wHMJ0qC8uSyU1Vjh9MQCjGu0V5EF
   dolLZg3G9NP+C/oXvatb3NHjFMqEJsAHlzvENFUFM5+glN0oMc/8Qe/hb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242619758"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242619758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="645191086"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 07:34:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nee4Y-0000NU-RM;
        Wed, 13 Apr 2022 14:34:18 +0000
Date:   Wed, 13 Apr 2022 22:33:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Libo Chen <libo.chen@oracle.com>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Message-ID: <202204132236.KPzXaw0b-lkp@intel.com>
References: <20220412231508.32629-2-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412231508.32629-2-libo.chen@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: parisc-randconfig-r014-20220413 (https://download.01.org/0day-ci/archive/20220413/202204132236.KPzXaw0b-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6636f7cf28d2a79cde937c0f212e8a87080da06d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Libo-Chen/lib-Kconfig-remove-DEBUG_PER_CPU_MAPS-dependency-for-CPUMASK_OFFSTACK/20220413-073657
        git checkout 6636f7cf28d2a79cde937c0f212e8a87080da06d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/workqueue.o: in function `free_workqueue_attrs':
>> kernel/workqueue.c:3370: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/workqueue.o: in function `alloc_workqueue_attrs':
>> kernel/workqueue.c:3390: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: kernel/workqueue.o: in function `workqueue_set_unbound_cpumask':
>> kernel/workqueue.c:5390: undefined reference to `zalloc_cpumask_var'
>> hppa-linux-ld: kernel/workqueue.c:5406: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/workqueue.o: in function `wq_unbound_cpumask_store':
   kernel/workqueue.c:5664: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: kernel/workqueue.c:5671: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/workqueue.o: in function `workqueue_init_early':
   kernel/workqueue.c:5995: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: kernel/sched/core.o: in function `sched_setaffinity':
>> kernel/sched/core.c:7948: undefined reference to `alloc_cpumask_var'
>> hppa-linux-ld: kernel/sched/core.c:7951: undefined reference to `alloc_cpumask_var'
>> hppa-linux-ld: kernel/sched/core.c:7978: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/sched/core.c:7980: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/sched/core.o: in function `__se_sys_sched_setaffinity':
   kernel/sched/core.c:8051: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: kernel/sched/core.c:8057: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/sched/core.o: in function `__se_sys_sched_getaffinity':
   kernel/sched/core.c:8108: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: kernel/sched/core.c:8120: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/sched/core.o: in function `sched_init':
>> kernel/sched/core.c:9499: undefined reference to `load_balance_mask'
>> hppa-linux-ld: kernel/sched/core.c:9499: undefined reference to `load_balance_mask'
>> hppa-linux-ld: kernel/sched/core.c:9501: undefined reference to `select_idle_mask'
>> hppa-linux-ld: kernel/sched/core.c:9501: undefined reference to `select_idle_mask'
   hppa-linux-ld: kernel/sched/build_utility.o: in function `housekeeping_setup_type':
>> kernel/sched/isolation.c:104: undefined reference to `alloc_bootmem_cpumask_var'
   hppa-linux-ld: kernel/sched/build_utility.o: in function `housekeeping_setup':
   kernel/sched/isolation.c:122: undefined reference to `alloc_bootmem_cpumask_var'
>> hppa-linux-ld: kernel/sched/isolation.c:128: undefined reference to `alloc_bootmem_cpumask_var'
>> hppa-linux-ld: kernel/sched/isolation.c:173: undefined reference to `free_bootmem_cpumask_var'
   hppa-linux-ld: kernel/sched/isolation.c:175: undefined reference to `free_bootmem_cpumask_var'
   hppa-linux-ld: kernel/taskstats.o: in function `taskstats_user_cmd':
>> kernel/taskstats.c:441: undefined reference to `alloc_cpumask_var'
>> hppa-linux-ld: kernel/taskstats.c:457: undefined reference to `alloc_cpumask_var'
>> hppa-linux-ld: kernel/taskstats.c:464: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/events/core.o: in function `perf_event_init':
>> kernel/events/core.c:13237: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: fs/io_uring.o: in function `__io_uring_register':
>> fs/io_uring.c:11472: undefined reference to `alloc_cpumask_var'
>> hppa-linux-ld: fs/io_uring.c:11488: undefined reference to `free_cpumask_var'
   hppa-linux-ld: fs/io_uring.c:11493: undefined reference to `free_cpumask_var'
   hppa-linux-ld: fs/io-wq.o: in function `io_wq_create':
   fs/io-wq.c:1180: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: fs/io-wq.c:1214: undefined reference to `free_cpumask_var'
   hppa-linux-ld: fs/io-wq.o: in function `io_wq_put_and_exit':
   fs/io-wq.c:1290: undefined reference to `free_cpumask_var'
   hppa-linux-ld: block/blk-mq.o: in function `blk_mq_alloc_hctx':
   block/blk-mq.c:3528: undefined reference to `zalloc_cpumask_var_node'
   hppa-linux-ld: block/blk-mq.c:3575: undefined reference to `free_cpumask_var'
   hppa-linux-ld: drivers/base/cpu.o: in function `print_cpus_offline':
   drivers/base/cpu.c:245: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: drivers/base/cpu.c:249: undefined reference to `free_cpumask_var'
   hppa-linux-ld: drivers/base/cpu.o: in function `print_cpus_isolated':
   drivers/base/cpu.c:274: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: drivers/base/cpu.c:281: undefined reference to `free_cpumask_var'
   hppa-linux-ld: drivers/net/ethernet/emulex/benet/be_main.o: in function `be_clear_queues':
   drivers/net/ethernet/emulex/benet/be_main.c:2943: undefined reference to `free_cpumask_var'
   hppa-linux-ld: drivers/net/ethernet/emulex/benet/be_main.o: in function `be_setup_queues':
   drivers/net/ethernet/emulex/benet/be_main.c:2981: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: drivers/net/ethernet/sfc/falcon/efx.o: in function `ef4_probe_nic':
   drivers/net/ethernet/sfc/falcon/efx.c:1329: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: drivers/net/ethernet/sfc/falcon/efx.c:1344: undefined reference to `free_cpumask_var'
   hppa-linux-ld: net/core/dev.o: in function `netif_get_num_default_rss_queues':
   net/core/dev.c:3001: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: net/core/dev.c:3009: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/profile.o: in function `prof_cpu_mask_proc_write':
   kernel/profile.c:361: undefined reference to `zalloc_cpumask_var'
   hppa-linux-ld: kernel/profile.c:369: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/profile.o: in function `profile_init':
   kernel/profile.c:114: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: kernel/profile.c:132: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/torture.o: in function `torture_cleanup_begin':
   kernel/torture.c:591: undefined reference to `free_cpumask_var'
   hppa-linux-ld: kernel/torture.o: in function `torture_shuffle_init':
   kernel/torture.c:572: undefined reference to `alloc_cpumask_var'
   hppa-linux-ld: block/blk-mq-sysfs.o: in function `blk_mq_hw_sysfs_release':
   block/blk-mq-sysfs.c:41: undefined reference to `free_cpumask_var'


vim +3370 kernel/workqueue.c

1fa44ecad2b864 James Bottomley     2006-02-23  3360  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3361  /**
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3362   * free_workqueue_attrs - free a workqueue_attrs
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3363   * @attrs: workqueue_attrs to free
226223ab3c4118 Tejun Heo           2013-03-12  3364   *
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3365   * Undo alloc_workqueue_attrs().
226223ab3c4118 Tejun Heo           2013-03-12  3366   */
513c98d0868295 Daniel Jordan       2019-09-05  3367  void free_workqueue_attrs(struct workqueue_attrs *attrs)
226223ab3c4118 Tejun Heo           2013-03-12  3368  {
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3369  	if (attrs) {
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02 @3370  		free_cpumask_var(attrs->cpumask);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3371  		kfree(attrs);
226223ab3c4118 Tejun Heo           2013-03-12  3372  	}
226223ab3c4118 Tejun Heo           2013-03-12  3373  }
226223ab3c4118 Tejun Heo           2013-03-12  3374  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3375  /**
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3376   * alloc_workqueue_attrs - allocate a workqueue_attrs
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3377   *
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3378   * Allocate a new workqueue_attrs, initialize with default settings and
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3379   * return it.
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3380   *
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3381   * Return: The allocated new workqueue_attr on success. %NULL on failure.
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3382   */
513c98d0868295 Daniel Jordan       2019-09-05  3383  struct workqueue_attrs *alloc_workqueue_attrs(void)
226223ab3c4118 Tejun Heo           2013-03-12  3384  {
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3385  	struct workqueue_attrs *attrs;
226223ab3c4118 Tejun Heo           2013-03-12  3386  
be69d00d976957 Thomas Gleixner     2019-06-26  3387  	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3388  	if (!attrs)
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3389  		goto fail;
be69d00d976957 Thomas Gleixner     2019-06-26 @3390  	if (!alloc_cpumask_var(&attrs->cpumask, GFP_KERNEL))
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3391  		goto fail;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3392  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3393  	cpumask_copy(attrs->cpumask, cpu_possible_mask);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3394  	return attrs;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3395  fail:
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3396  	free_workqueue_attrs(attrs);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  3397  	return NULL;
226223ab3c4118 Tejun Heo           2013-03-12  3398  }
226223ab3c4118 Tejun Heo           2013-03-12  3399  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
