Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C464594EFE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 05:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiHPDQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 23:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiHPDPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 23:15:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62572F2C3B;
        Mon, 15 Aug 2022 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660607089; x=1692143089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VcaajQsR43BnO5OdC1e+zV/tF1MrHWgkAAqLLvoHHRI=;
  b=GzxCr8HcFCIlMJI5An95jDzvZhIR5cf08ehVpYo+OLSzxwVNGe2g6nm8
   MwnaOCraDJJmGJvidtXwoLJFfIPuGYmqd3npD1+RnVFA6cmXLiI0s8KeO
   p4OYTjlHlk3rSSbVU5MQCmEZhIqRBCCDkWpUMZYHlhp3I8XllHwaqhD0k
   vLs0Qnzpr7TZ9G/PRYfFRcFcdA+MdINhP0iNcgCotN0totnibS5LyvDyR
   olF4waMHQdejcGaeNt1fZ8kY8Wt8u7NnncVJhNKXZUG2jdF/E8EaZ5p5B
   HLWA8lAmhYsHosId1YMrIylHJxunP/SieyGG0lAHZ1fT+bmBLfTBChaTq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279043720"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="279043720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 16:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="606824195"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2022 16:44:41 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNjlA-0001HU-2U;
        Mon, 15 Aug 2022 23:44:40 +0000
Date:   Tue, 16 Aug 2022 07:44:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux@armlinux.org.uk, arnd@arndb.de,
        linus.walleij@linaro.org, ardb@kernel.org,
        rmk+kernel@armlinux.org.uk, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        chenzhongjin@huawei.com
Subject: Re: [PATCH] x86/unwind/orc: Add 'unwind_debug' cmdline option
Message-ID: <202208160719.jJFohEBB-lkp@intel.com>
References: <20220815105808.17385-2-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815105808.17385-2-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Chen,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on soc/for-next clk/clk-next linus/master v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Zhongjin/x86-unwind-orc-Add-unwind_debug-cmdline-option/20220815-190328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a1a5482a2c6e38a3ebed32e571625c56a8cc41a6
config: x86_64-randconfig-a003-20220815 (https://download.01.org/0day-ci/archive/20220816/202208160719.jJFohEBB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3295e738f5b51f1f1f223bf52a8ecee2ab93fbca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Zhongjin/x86-unwind-orc-Add-unwind_debug-cmdline-option/20220815-190328
        git checkout 3295e738f5b51f1f1f223bf52a8ecee2ab93fbca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/unwind_orc.c:17:9: error: expected identifier or '(' before 'if'
      17 |         if (state->task == current && !state->error)                    \
         |         ^~
   In file included from include/asm-generic/bug.h:7,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:257,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:40,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from arch/x86/kernel/unwind_orc.c:3:
>> include/linux/once_lite.h:34:10: error: expected identifier or '(' before ')' token
      34 |         })
         |          ^
   include/linux/once_lite.h:11:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/printk.h:605:9: note: in expansion of macro 'DO_ONCE_LITE'
     605 |         DO_ONCE_LITE(printk_deferred, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:12:9: note: in expansion of macro 'printk_deferred_once'
      12 |         printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:18:17: note: in expansion of macro 'orc_warn'
      18 |                 orc_warn(args);                                         \
         |                 ^~~~~~~~
   arch/x86/kernel/unwind_orc.c:19:17: error: expected identifier or '(' before 'if'
      19 |                 if (unwind_debug && !dumped_before)                     \
         |                 ^~
   arch/x86/kernel/unwind_orc.c:21:17: warning: data definition has no type or storage class
      21 |                 dumped_before = true;                                   \
         |                 ^~~~~~~~~~~~~
>> arch/x86/kernel/unwind_orc.c:21:17: error: type defaults to 'int' in declaration of 'dumped_before' [-Werror=implicit-int]
>> arch/x86/kernel/unwind_orc.c:22:9: error: expected identifier or '(' before '}' token
      22 |         }                                                               \
         |         ^
   arch/x86/kernel/unwind_orc.c:23:1: error: expected identifier or '(' before '}' token
      23 | })
         | ^
>> arch/x86/kernel/unwind_orc.c:23:2: error: expected identifier or '(' before ')' token
      23 | })
         |  ^
   arch/x86/kernel/unwind_orc.c: In function 'orc_find':
>> arch/x86/kernel/unwind_orc.c:219:35: error: '__start_orc_unwind_ip' undeclared (first use in this function); did you mean '__start_orc_unwind'?
     219 |                 return __orc_find(__start_orc_unwind_ip + start,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
         |                                   __start_orc_unwind
   arch/x86/kernel/unwind_orc.c:219:35: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kernel/unwind_orc.c: At top level:
>> arch/x86/kernel/unwind_orc.c:239:32: error: '__start_orc_unwind_ip' undeclared here (not in a function); did you mean '__start_orc_unwind'?
     239 | static int *cur_orc_ip_table = __start_orc_unwind_ip;
         |                                ^~~~~~~~~~~~~~~~~~~~~
         |                                __start_orc_unwind
   arch/x86/kernel/unwind_orc.c: In function 'unwind_next_frame':
>> arch/x86/kernel/unwind_orc.c:534:18: error: expected ')' before 'break'
     534 |                 }
         |                  ^
         |                  )
     535 |                 break;
         |                 ~~~~~
   arch/x86/kernel/unwind_orc.c:16:21: warning: unused variable 'dumped_before' [-Wunused-variable]
      16 |         static bool dumped_before;
         |                     ^~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:531:25: note: in expansion of macro 'orc_warn_current'
     531 |                         orc_warn_current("missing R10 value at %pB\n",
         |                         ^~~~~~~~~~~~~~~~
>> arch/x86/kernel/unwind_orc.c:767:1: error: expected declaration or statement at end of input
     767 | EXPORT_SYMBOL_GPL(__unwind_start);
         | ^~~~~~~~~~~~~~~~~
>> arch/x86/kernel/unwind_orc.c:767:1: error: expected declaration or statement at end of input
>> arch/x86/kernel/unwind_orc.c:767:1: error: expected declaration or statement at end of input
>> arch/x86/kernel/unwind_orc.c:533:25: error: label 'err' used but not defined
     533 |                         goto err;
         |                         ^~~~
>> arch/x86/kernel/unwind_orc.c:506:17: error: label 'the_end' used but not defined
     506 |                 goto the_end;
         |                 ^~~~
   arch/x86/kernel/unwind_orc.c:468:14: warning: variable 'indirect' set but not used [-Wunused-but-set-variable]
     468 |         bool indirect = false;
         |              ^~~~~~~~
   arch/x86/kernel/unwind_orc.c:466:25: warning: unused variable 'prev_type' [-Wunused-variable]
     466 |         enum stack_type prev_type = state->stack_info.type;
         |                         ^~~~~~~~~
   arch/x86/kernel/unwind_orc.c:465:59: warning: unused variable 'prev_sp' [-Wunused-variable]
     465 |         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
         |                                                           ^~~~~~~
   arch/x86/kernel/unwind_orc.c:465:38: warning: unused variable 'orig_ip' [-Wunused-variable]
     465 |         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
         |                                      ^~~~~~~
   arch/x86/kernel/unwind_orc.c:465:33: warning: unused variable 'tmp' [-Wunused-variable]
     465 |         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
         |                                 ^~~
   arch/x86/kernel/unwind_orc.c:465:23: warning: unused variable 'ip_p' [-Wunused-variable]
     465 |         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
         |                       ^~~~
   arch/x86/kernel/unwind_orc.c:768: error: control reaches end of non-void function [-Werror=return-type]
   At top level:
   arch/x86/kernel/unwind_orc.c:16:21: warning: 'dumped_before' defined but not used [-Wunused-variable]
      16 |         static bool dumped_before;
         |                     ^~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:531:25: note: in expansion of macro 'orc_warn_current'
     531 |                         orc_warn_current("missing R10 value at %pB\n",
         |                         ^~~~~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:421:13: warning: 'deref_stack_iret_regs' defined but not used [-Wunused-function]
     421 | static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr,
         |             ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:405:13: warning: 'deref_stack_regs' defined but not used [-Wunused-function]
     405 | static bool deref_stack_regs(struct unwind_state *state, unsigned long addr,
         |             ^~~~~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:395:13: warning: 'deref_stack_reg' defined but not used [-Wunused-function]
     395 | static bool deref_stack_reg(struct unwind_state *state, unsigned long addr,
         |             ^~~~~~~~~~~~~~~
   arch/x86/kernel/unwind_orc.c:42:13: warning: 'unwind_dump' defined but not used [-Wunused-function]
      42 | static void unwind_dump(struct unwind_state *state)
         |             ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +17 arch/x86/kernel/unwind_orc.c

ee9f8fce996408 Josh Poimboeuf 2017-07-24  10  
ee9f8fce996408 Josh Poimboeuf 2017-07-24  11  #define orc_warn(fmt, ...) \
b08418b5483125 Josh Poimboeuf 2020-04-25  12  	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
b08418b5483125 Josh Poimboeuf 2020-04-25  13  
b08418b5483125 Josh Poimboeuf 2020-04-25  14  #define orc_warn_current(args...)					\
b08418b5483125 Josh Poimboeuf 2020-04-25  15  ({									\
3295e738f5b51f Josh Poimboeuf 2022-08-15 @16  	static bool dumped_before;
b59cc97674c947 Josh Poimboeuf 2021-02-05 @17  	if (state->task == current && !state->error)			\
b08418b5483125 Josh Poimboeuf 2020-04-25 @18  		orc_warn(args);						\
3295e738f5b51f Josh Poimboeuf 2022-08-15 @19  		if (unwind_debug && !dumped_before)			\
3295e738f5b51f Josh Poimboeuf 2022-08-15  20  			unwind_dump(state);				\
3295e738f5b51f Josh Poimboeuf 2022-08-15 @21  		dumped_before = true;					\
3295e738f5b51f Josh Poimboeuf 2022-08-15 @22  	}								\
b08418b5483125 Josh Poimboeuf 2020-04-25 @23  })
ee9f8fce996408 Josh Poimboeuf 2017-07-24  24  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
