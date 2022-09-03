Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9885AC06B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiICRs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiICRs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 13:48:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B553D16;
        Sat,  3 Sep 2022 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662227338; x=1693763338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vBns7j9FUt8fPAWHIlfUjC3o9Q8+8wFBJc0wtm12Fns=;
  b=dGlP1PDUkOqd/DsMkLj4AQg/cphpq+Dmo/tAqL1YbRAZCwPoisexWIQ7
   YnoryWHzQeI7TXBvdREyEIL5tewSRDXbL3qq3D34ygYLG8/WU4PjwfUP3
   MoiyhyeM1vM3fwLY2fla/LHUhrIkaiVCj6Sp2mIW6RBcJGrT4c6movwZO
   BomXP0q2fcLvMh1wCpTk7B7ROZs3kJ/6c1flZb9nInUlcFuVsonT36JpH
   LJGTb/0aDVQ4XMUU5EoeN3CsehGplVS+v01NU+meLWUJVkidrvrY4sYmY
   UistAoe0wyjomd6e0krxaiATmNoiksojSWWyhxl7H8uH+yklkW3vdyCAX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279190954"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279190954"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="613359713"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2022 10:48:55 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUXGI-0001yL-1a;
        Sat, 03 Sep 2022 17:48:54 +0000
Date:   Sun, 4 Sep 2022 01:48:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, luto@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 1/3] riscv: convert to generic entry
Message-ID: <202209040122.Nhovi9f6-lkp@intel.com>
References: <20220903163808.1954131-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903163808.1954131-2-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040122.Nhovi9f6-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8390e92d0bcc635f457df18c8c1baefc78a94e48
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
        git checkout 8390e92d0bcc635f457df18c8c1baefc78a94e48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/signal.c:275:6: warning: no previous prototype for 'arch_do_signal_or_restart' [-Wmissing-prototypes]
     275 | void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_do_signal_or_restart +275 arch/riscv/kernel/signal.c

   274	
 > 275	void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
