Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00A9595880
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiHPKgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiHPKgY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 06:36:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948E5B79A;
        Tue, 16 Aug 2022 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660640398; x=1692176398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fsbw9VD64WNebEA9SmUmkH3lTdV9uckYpcgbPhxuwEE=;
  b=cbXdimhMXhSdqUijOstcJb6n+4pQ9EPwcVRvjT7YR0ShuLOcI+lfMflJ
   rslMlXVtIQS9VJ4MaKRTIFC98J9Yg9iZZKsCT56qJmrUc6GdHfRtGvoGn
   DVXaKX6YxAoSfnEQVz0TLq5qZ8rPkc/KaSoeorQrAQ8jhEOknW+FsFn/2
   rF+0nbDGlcG7V03qEXG78T41J7Xfw2MryiJ5Lo4Q7JaKMjLoXxU0V0p81
   6uj1q9g64CVt1OV7g9prBctfj0A0Qtt2I0wpcIjk8H2w1oJrN47XDgYax
   fDOX+Or27oDXN7CGVmYobQUTFBckcA9fRZcuSQm+o/ae0LqjmKY72gyVd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292164224"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292164224"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733222124"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2022 01:59:51 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNsQR-0001f6-0Z;
        Tue, 16 Aug 2022 08:59:51 +0000
Date:   Tue, 16 Aug 2022 16:59:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Add perf events support
Message-ID: <202208161648.zq48ilEV-lkp@intel.com>
References: <20220815124702.3330803-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815124702.3330803-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test WARNING on v6.0-rc1 next-20220816]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Add-perf-events-support/20220815-204852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: loongarch-randconfig-s051-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161648.zq48ilEV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/0e6d9490ff3f6129799675b9288135022a0908e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Add-perf-events-support/20220815-204852
        git checkout 0e6d9490ff3f6129799675b9288135022a0908e2
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=loongarch 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/perf_event.c:30:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *user_frame_tail @@     got unsigned long * @@
   arch/loongarch/kernel/perf_event.c:30:50: sparse:     expected unsigned long [noderef] __user *user_frame_tail
   arch/loongarch/kernel/perf_event.c:30:50: sparse:     got unsigned long *
   arch/loongarch/kernel/perf_event.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_d'
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_d'
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:237:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type

vim +30 arch/loongarch/kernel/perf_event.c

    20	
    21	/*
    22	 * Get the return address for a single stackframe and return a pointer to the
    23	 * next frame tail.
    24	 */
    25	static unsigned long
    26	user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp)
    27	{
    28		struct stack_frame buftail;
    29		unsigned long err;
  > 30		unsigned long __user *user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
    31	
    32		/* Also check accessibility of one struct frame_tail beyond */
    33		if (!access_ok(user_frame_tail, sizeof(buftail)))
    34			return 0;
    35	
    36		pagefault_disable();
    37		err = __copy_from_user_inatomic(&buftail, user_frame_tail, sizeof(buftail));
    38		pagefault_enable();
    39	
    40		if (err || (unsigned long)user_frame_tail >= buftail.fp)
    41			return 0;
    42	
    43		perf_callchain_store(entry, buftail.ra);
    44	
    45		return buftail.fp;
    46	}
    47	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
