Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854F5BB7B8
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQKXB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQKXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 06:23:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D337194;
        Sat, 17 Sep 2022 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663410179; x=1694946179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Uz6iGVEKvXwwNJYBLPjkXa0o0TOzOGbJsUCeZnGgc0=;
  b=e5ZZg1yJzY6EzpmmsYRUcRnhKGWbDl32o7iVb8burrRD2hT4hhJbksgi
   p4AT5JjLe+FtQrhz3cog4/b+OeV/Lz7W8UNifcCwJ7RDOIMz713DP6uxD
   GkJpCWOAK9Rv6IAPB6IAIpP4tZ6xdUUhOfBx1IyID7nlIiNE3PXb/GP2J
   r5PULWs8b+esvDlJ4lZVkbtWTICIj269tgIASKP5+GvIsqklf2cQTzGYR
   wbgXe/S2C7G4rqTpH4GiBoySu0wcuteXvuZbehU05q1PN1xx+Esdadr4U
   aCdApTqZsH0UfCMYqsjVlr/w60cyvhPUVPm9+bvBU9LKrUQg781KisO0X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325422157"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="325422157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 03:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="651135444"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Sep 2022 03:22:53 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZUyK-0000EY-13;
        Sat, 17 Sep 2022 10:22:52 +0000
Date:   Sat, 17 Sep 2022 18:22:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Refactor cache probe and flush methods
Message-ID: <202209171822.T8lQdBUd-lkp@intel.com>
References: <20220917065550.1681906-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917065550.1681906-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Refactor-cache-probe-and-flush-methods/20220917-145926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-randconfig-r023-20220916 (https://download.01.org/0day-ci/archive/20220917/202209171822.T8lQdBUd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d3b59542d7583a2251e0a1f69331e57565de0f51
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Refactor-cache-probe-and-flush-methods/20220917-145926
        git checkout d3b59542d7583a2251e0a1f69331e57565de0f51
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/loongarch/mm/cache.c:28:6: warning: no previous prototype for 'cache_error_setup' [-Wmissing-prototypes]
      28 | void cache_error_setup(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/mm/cache.c: In function 'flush_cache_leaf':
>> arch/loongarch/mm/cache.c:62:34: error: 'NODE_ADDRSPACE_SHIFT' undeclared (first use in this function)
      62 |                 addr += (1ULL << NODE_ADDRSPACE_SHIFT);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/mm/cache.c:62:34: note: each undeclared identifier is reported only once for each function it appears in


vim +/NODE_ADDRSPACE_SHIFT +62 arch/loongarch/mm/cache.c

    43	
    44	static void flush_cache_leaf(unsigned int leaf)
    45	{
    46		int i, j, nr_nodes;
    47		uint64_t addr = CSR_DMW0_BASE;
    48		struct cache_desc *cdesc = current_cpu_data.cache_leaves + leaf;
    49	
    50		nr_nodes = cache_private(cdesc) ? 1 : loongson_sysconf.nr_nodes;
    51	
    52		do {
    53			for (i = 0; i < cdesc->sets; i++) {
    54				for (j = 0; j < cdesc->ways; j++) {
    55					flush_cache_line(leaf, addr);
    56					addr++;
    57				}
    58	
    59				addr -= cdesc->ways;
    60				addr += cdesc->linesz;
    61			}
  > 62			addr += (1ULL << NODE_ADDRSPACE_SHIFT);
    63		} while (--nr_nodes > 0);
    64	}
    65	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
