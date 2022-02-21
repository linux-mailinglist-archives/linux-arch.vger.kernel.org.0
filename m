Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753F44BE95A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379002AbiBUPVp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 10:21:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiBUPVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 10:21:44 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA01DA76
        for <linux-arch@vger.kernel.org>; Mon, 21 Feb 2022 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645456881; x=1676992881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R+ap/lmYjKAIkMq91jwszVD6BzQYhqbeQJY5NcEOHX4=;
  b=cUmY3Y2I+Gaz6O5643IgaYzifSYhbOZPYATuF23LD2Y0ZHFmfl+xEaSS
   1Vv+GZnCVFGVahKgtSPcT5r0lpBaRwdCeeZCr0nSt6gu8+lhSPSx6z3ed
   IolhX1I3oif0htQCT2UDwqFaghslk9s7ZbBPDKHeaKa3TdXgnnYWCS99s
   R+Yb00243UPIorpjZMafRNxRJvKd3wjUxx/iv85xcceRD2vLm3fzCjtLe
   Uj5h0mS1Da+BZ7mcKjGV4vLx9DqvmJ2BTxLnEcCRWf4hxQQjS+TK+9JnZ
   Ll8UW4xOnH6lXhIqTLpnDzf1Ml0y+TW/1wXghvXBJWehztj7yDzItjva7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="312271490"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="312271490"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507665607"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 07:21:19 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMAV4-0001ik-Ff; Mon, 21 Feb 2022 15:21:18 +0000
Date:   Mon, 21 Feb 2022 23:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [arnd-asm-generic:set_fs-3 13/18]
 arch/csky/kernel/perf_callchain.c:55:14: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202202212337.Vmr94Qq8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git set_fs-3
head:   81ba80d2dbd7f4536edb20b54754ad03b910e4aa
commit: 189d2606eda6b4611e560224718cd82dea30ffd0 [13/18] uaccess: generalize access_ok()
config: csky-randconfig-s032-20220221 (https://download.01.org/0day-ci/archive/20220221/202202212337.Vmr94Qq8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=189d2606eda6b4611e560224718cd82dea30ffd0
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic set_fs-3
        git checkout 189d2606eda6b4611e560224718cd82dea30ffd0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/csky/kernel/perf_callchain.c:55:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned long *user_frame_tail @@
   arch/csky/kernel/perf_callchain.c:55:14: sparse:     expected void const [noderef] __user *ptr
   arch/csky/kernel/perf_callchain.c:55:14: sparse:     got unsigned long *user_frame_tail
   arch/csky/kernel/perf_callchain.c:57:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long *user_frame_tail @@
   arch/csky/kernel/perf_callchain.c:57:49: sparse:     expected void const [noderef] __user *from
   arch/csky/kernel/perf_callchain.c:57:49: sparse:     got unsigned long *user_frame_tail
   arch/csky/kernel/perf_callchain.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/ptrace.h, ...):
   include/linux/uaccess.h:96:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:96:39: sparse:     expected void const *from
   include/linux/uaccess.h:96:39: sparse:     got void const [noderef] __user *from

vim +55 arch/csky/kernel/perf_callchain.c

cfa4d93b977a1b Mao Han 2019-02-21  42  
cfa4d93b977a1b Mao Han 2019-02-21  43  /*
cfa4d93b977a1b Mao Han 2019-02-21  44   * Get the return address for a single stackframe and return a pointer to the
cfa4d93b977a1b Mao Han 2019-02-21  45   * next frame tail.
cfa4d93b977a1b Mao Han 2019-02-21  46   */
cfa4d93b977a1b Mao Han 2019-02-21  47  static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
cfa4d93b977a1b Mao Han 2019-02-21  48  			unsigned long fp, unsigned long reg_lr)
cfa4d93b977a1b Mao Han 2019-02-21  49  {
cfa4d93b977a1b Mao Han 2019-02-21  50  	struct stackframe buftail;
cfa4d93b977a1b Mao Han 2019-02-21  51  	unsigned long lr = 0;
cfa4d93b977a1b Mao Han 2019-02-21  52  	unsigned long *user_frame_tail = (unsigned long *)fp;
cfa4d93b977a1b Mao Han 2019-02-21  53  
cfa4d93b977a1b Mao Han 2019-02-21  54  	/* Check accessibility of one struct frame_tail beyond */
cfa4d93b977a1b Mao Han 2019-02-21 @55  	if (!access_ok(user_frame_tail, sizeof(buftail)))
cfa4d93b977a1b Mao Han 2019-02-21  56  		return 0;
cfa4d93b977a1b Mao Han 2019-02-21  57  	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
cfa4d93b977a1b Mao Han 2019-02-21  58  				      sizeof(buftail)))
cfa4d93b977a1b Mao Han 2019-02-21  59  		return 0;
cfa4d93b977a1b Mao Han 2019-02-21  60  
cfa4d93b977a1b Mao Han 2019-02-21  61  	if (reg_lr != 0)
cfa4d93b977a1b Mao Han 2019-02-21  62  		lr = reg_lr;
cfa4d93b977a1b Mao Han 2019-02-21  63  	else
cfa4d93b977a1b Mao Han 2019-02-21  64  		lr = buftail.lr;
cfa4d93b977a1b Mao Han 2019-02-21  65  
cfa4d93b977a1b Mao Han 2019-02-21  66  	fp = buftail.fp;
cfa4d93b977a1b Mao Han 2019-02-21  67  	perf_callchain_store(entry, lr);
cfa4d93b977a1b Mao Han 2019-02-21  68  
cfa4d93b977a1b Mao Han 2019-02-21  69  	return fp;
cfa4d93b977a1b Mao Han 2019-02-21  70  }
cfa4d93b977a1b Mao Han 2019-02-21  71  

:::::: The code at line 55 was first introduced by commit
:::::: cfa4d93b977a1b1129e7207d11b5daecdf0c56c4 csky: Add perf callchain support

:::::: TO: Mao Han <han_mao@c-sky.com>
:::::: CC: Guo Ren <ren_guo@c-sky.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
