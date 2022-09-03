Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9305AC075
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiICR7C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiICR7B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 13:59:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296653028;
        Sat,  3 Sep 2022 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662227941; x=1693763941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HlaM+epqGJ7fpGSR39vLYKuzrDeEOiiUHDjsICgQbs4=;
  b=fDn08d2ONpHfiKhg0YBtCMUndEekWnkoKomhIWrmb0fkRfmp+LhDWH6w
   uQRngi06XVRv32qur8cXtbRTiozbRlXfxsZDvwhe+tTWecfAeFs99Yr0x
   g24PpqMOrKwoWeMF7ikKUBpQEmQI/XTVNmbS7qXo2N6jzOrAsMPJoBGES
   c8O5Y3d1H3Oe6cb/oOdTB3V5JRyEcwcVP+kvWTcc3rSyuDfOtPy6fmOmt
   3CDzKhJM/k1Fu6XZL56Fj4g/a7D57aTutloqrbU5OtQknGYXFQ8Icg1Ct
   wPFFDHLC2N62cDkbtZS90ASjv7wbcceBD98t6cgket7ZsMCx7MJ+utRR2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="297472589"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="297472589"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="564299002"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 10:58:58 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUXQ1-00020D-1F;
        Sat, 03 Sep 2022 17:58:57 +0000
Date:   Sun, 4 Sep 2022 01:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, luto@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 3/3] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Message-ID: <202209040118.GmG1Lby1-lkp@intel.com>
References: <20220903163808.1954131-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903163808.1954131-4-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040118.GmG1Lby1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6ed1ef93b372116f7d4586b13bfd352e19453740
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
        git checkout 6ed1ef93b372116f7d4586b13bfd352e19453740
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/irq.c:48:6: warning: no previous prototype for 'do_softirq_own_stack' [-Wmissing-prototypes]
      48 | void do_softirq_own_stack(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/irq.c:74:25: warning: no previous prototype for 'handle_riscv_irq' [-Wmissing-prototypes]
      74 | asmlinkage void noinstr handle_riscv_irq(struct pt_regs *regs)
         |                         ^~~~~~~~~~~~~~~~
   arch/riscv/kernel/irq.c:85:25: warning: no previous prototype for 'do_riscv_irq' [-Wmissing-prototypes]
      85 | asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
         |                         ^~~~~~~~~~~~


vim +/do_softirq_own_stack +48 arch/riscv/kernel/irq.c

    47	
  > 48	void do_softirq_own_stack(void)
    49	{
    50		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
    51	
    52		call_on_stack(NULL, sp, do_riscv_softirq, 0);
    53	}
    54	#endif /* CONFIG_PREEMPT_RT */
    55	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
