Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BFC51E039
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349481AbiEFUmJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiEFUmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 16:42:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7721FA72;
        Fri,  6 May 2022 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651869501; x=1683405501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3gecEvBeha7AK4YfA881Q0ULGviX1PIT7PEfBImIRM=;
  b=PUZ2Tm57i9QBABfGVIxJyNPmK9dAdN2YLpTz7Ikn8JsQq7SQAughrEkc
   n8qE35KtJ+iLv9Wy/GH1GUl4b3VBp0kW6OK3atVPLzIsmeYdIPcOA8IW8
   ROyoFHUZial4PaBuoNSzQFD8TlkXyi3fX7zSscI46EPSDoGqUUnz4hH2c
   G0GQG/dzNNNUKOsjmSN+OVXzxoA3vWxvDNd77E13VM2M/geY/e2CtI2r8
   KVGPvmqnkzu9X5c6oKAvkIdub+aBCF7PU47HTGfG863VK/Spen7zdEGMO
   BcmuVesw95sPpmrUrYLbhUK+6+25NEZThNLTK+oN9GWS8KYaIr3xsc2LQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248474796"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248474796"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="586191905"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2022 13:38:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn4iQ-000DsI-3h;
        Fri, 06 May 2022 20:38:18 +0000
Date:   Sat, 7 May 2022 04:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/7] fork: Pass struct kernel_clone_args into copy_thread
Message-ID: <202205070451.wstjDYm7-lkp@intel.com>
References: <20220506141512.516114-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506141512.516114-2-ebiederm@xmission.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi "Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on deller-parisc/for-next]
[also build test ERROR on linus/master v5.18-rc5]
[cannot apply to tip/x86/core next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-W-Biederman/kthread-Don-t-allocate-kthread_struct-for-init-and-umh/20220506-221832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
config: h8300-randconfig-r025-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070451.wstjDYm7-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/22689080e2beece6919f918620e4c780cf7320eb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-W-Biederman/kthread-Don-t-allocate-kthread_struct-for-init-and-umh/20220506-221832
        git checkout 22689080e2beece6919f918620e4c780cf7320eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/h8300/kernel/process.c:58:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
      58 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
>> arch/h8300/kernel/process.c:108:46: error: unknown type name 'kernel_cloen_args'
     108 | int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
         |                                              ^~~~~~~~~~~~~~~~~
>> arch/h8300/kernel/process.c:108:5: error: conflicting types for 'copy_thread'; have 'int(struct task_struct *, const int *)'
     108 | int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
         |     ^~~~~~~~~~~
   In file included from arch/h8300/kernel/process.c:30:
   include/linux/sched/task.h:71:12: note: previous declaration of 'copy_thread' with type 'int(struct task_struct *, const struct kernel_clone_args *)'
      71 | extern int copy_thread(struct task_struct *, const struct kernel_clone_args *);
         |            ^~~~~~~~~~~
   arch/h8300/kernel/process.c: In function 'copy_thread':
>> arch/h8300/kernel/process.c:110:33: error: request for member 'stack' in something not a structure or union
     110 |         unsigned long usp = args->stack;
         |                                 ^~
   arch/h8300/kernel/process.c:111:36: error: request for member 'stack_size' in something not a structure or union
     111 |         unsigned long topstk = args->stack_size;
         |                                    ^~
   arch/h8300/kernel/process.c: At top level:
   arch/h8300/kernel/process.c:153:16: warning: no previous prototype for 'sys_clone' [-Wmissing-prototypes]
     153 | asmlinkage int sys_clone(unsigned long __user *args)
         |                ^~~~~~~~~


vim +/kernel_cloen_args +108 arch/h8300/kernel/process.c

   107	
 > 108	int copy_thread(struct task_struct *p, const kernel_cloen_args *args)
   109	{
 > 110		unsigned long usp = args->stack;
   111		unsigned long topstk = args->stack_size;
   112		struct pt_regs *childregs;
   113	
   114		childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
   115	
   116		if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
   117			memset(childregs, 0, sizeof(struct pt_regs));
   118			childregs->retpc = (unsigned long) ret_from_kernel_thread;
   119			childregs->er4 = topstk; /* arg */
   120			childregs->er5 = usp; /* fn */
   121		}  else {
   122			*childregs = *current_pt_regs();
   123			childregs->er0 = 0;
   124			childregs->retpc = (unsigned long) ret_from_fork;
   125			p->thread.usp = usp ?: rdusp();
   126		}
   127		p->thread.ksp = (unsigned long)childregs;
   128	
   129		return 0;
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
