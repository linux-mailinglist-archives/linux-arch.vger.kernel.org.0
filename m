Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD43359806C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbiHRIwo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 04:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiHRIwm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 04:52:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8FB0288;
        Thu, 18 Aug 2022 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660812762; x=1692348762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GE+hFY3e8Ezc85/XqYxBVbQOU5pumCSMq2Mr13ztxhE=;
  b=OG0MLpBs3b1ecnya8oD2SmYADytx7ux8VZPlQwDuWUZOFKATtbPE+QFX
   xF1pWp2kjrflvW5qSBcnKZcnRG3e/aV9c8Mo8fCUx8iV+dkaqEBDkK67o
   /CCmL54lWDFVZh74O2tJv01we6CyTodQ8SAIJ59hJ0myBkW2v7y1AlaL/
   8c9Zxe4TsX7uLUkfNErQy490kJD6Z9hIoQ1L+Rar8ZWZXfSxTN7fpubaE
   XeMJG5VsQhlwIc7+SrbiteHsrKPburhWfo1D9pknseZAC3lMep/1B+0pR
   gNGLHIwzmBNnr8n4lpAYLnx7ZgFSSF2YZbRwG6uhSBils9EMiT5n0bWsP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279672290"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="279672290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 01:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="935726838"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2022 01:52:38 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oObGX-0000It-1s;
        Thu, 18 Aug 2022 08:52:37 +0000
Date:   Thu, 18 Aug 2022 16:51:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, xianting.tian@linux.alibaba.com,
        palmer@dabbelt.com, heiko@sntech.de
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        liaochang1@huawei.com, mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 2/2] riscv: kexec: Implement crash_smp_send_stop with
 percpu crash_save_cpu
Message-ID: <202208181655.NrkPo4lG-lkp@intel.com>
References: <20220816012701.561435-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816012701.561435-3-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc1 next-20220818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-kexec-Support-crash_save-percpu-and-machine_kexec_mask_interrupts/20220816-144442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: riscv-buildonly-randconfig-r002-20220818 (https://download.01.org/0day-ci/archive/20220818/202208181655.NrkPo4lG-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0abdaf7e1f44634e1cee484e3cf01b7e8c851950
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review guoren-kernel-org/riscv-kexec-Support-crash_save-percpu-and-machine_kexec_mask_interrupts/20220816-144442
        git checkout 0abdaf7e1f44634e1cee484e3cf01b7e8c851950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/elfcore.h:6,
                    from include/linux/crash_core.h:6,
                    from include/linux/kexec.h:18,
                    from arch/riscv/kernel/machine_kexec.c:7:
   arch/riscv/kernel/machine_kexec.c: In function 'machine_kexec':
>> arch/riscv/kernel/machine_kexec.c:217:14: error: implicit declaration of function 'smp_crash_stop_failed' [-Werror=implicit-function-declaration]
     217 |         WARN(smp_crash_stop_failed(),
         |              ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:174:32: note: in definition of macro 'WARN'
     174 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/smp_crash_stop_failed +217 arch/riscv/kernel/machine_kexec.c

   193	
   194	/*
   195	 * machine_kexec - Jump to the loaded kimage
   196	 *
   197	 * This function is called by kernel_kexec which is called by the
   198	 * reboot system call when the reboot cmd is LINUX_REBOOT_CMD_KEXEC,
   199	 * or by crash_kernel which is called by the kernel's arch-specific
   200	 * trap handler in case of a kernel panic. It's the final stage of
   201	 * the kexec process where the pre-loaded kimage is ready to be
   202	 * executed. We assume at this point that all other harts are
   203	 * suspended and this hart will be the new boot hart.
   204	 */
   205	void __noreturn
   206	machine_kexec(struct kimage *image)
   207	{
   208		struct kimage_arch *internal = &image->arch;
   209		unsigned long jump_addr = (unsigned long) image->start;
   210		unsigned long first_ind_entry = (unsigned long) &image->head;
   211		unsigned long this_cpu_id = __smp_processor_id();
   212		unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
   213		unsigned long fdt_addr = internal->fdt_addr;
   214		void *control_code_buffer = page_address(image->control_code_page);
   215		riscv_kexec_method kexec_method = NULL;
   216	
 > 217		WARN(smp_crash_stop_failed(),

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
