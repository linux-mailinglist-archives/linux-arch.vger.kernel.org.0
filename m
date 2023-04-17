Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA86E54A0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 00:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDQWTa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDQWT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 18:19:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661F5275;
        Mon, 17 Apr 2023 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681769968; x=1713305968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMAw32GB6bnYHTIaJx+3YJu4UkN11Fi/gjV1eDLzAFs=;
  b=brz8CcyL1HOoLlpbB2TIzyxT1Iu3Qf66g66JzOZm3y58A/jPkO7eDQ6p
   GsEeVdywLd/4vlMPkttjhIc3KVbG6H2Hk0Zmdw0qvQ4Bd5bJaMEC5pnKT
   vR8EIM0bEyldMhjCrbq7rWCP6WBVWbpxISZnaP01+ozpZdaaUcqYzC0st
   y1sOvAB3BRWTViGLf5rDUWSBpLZdSjciEy2DM6hRTFK7OfD+eGwL/+Jv2
   C11tPeZrthUd92qhp6pXDZhf5WaRBOXQOC3RXKclEZFYXcpl55ewvy/dP
   X5nRPMuisdAvgw/OBjZEEckfZceKwJR4boC0QvjCbJlJhGQJJ2pzTgHv+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347767943"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="347767943"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 15:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684313012"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="684313012"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2023 15:19:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poXBh-000chh-0f;
        Mon, 17 Apr 2023 22:19:05 +0000
Date:   Tue, 18 Apr 2023 06:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 24/33] m68k: Convert various functions to use ptdescs
Message-ID: <202304180652.LeoLmaNQ-lkp@intel.com>
References: <20230417205048.15870-25-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417205048.15870-25-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vishal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230417]
[cannot apply to s390/features powerpc/next powerpc/fixes geert-m68k/for-next geert-m68k/for-linus linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/s390-Use-_pt_s390_gaddr-for-gmap-address-tracking/20230418-045832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230417205048.15870-25-vishal.moola%40gmail.com
patch subject: [PATCH 24/33] m68k: Convert various functions to use ptdescs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230418/202304180652.LeoLmaNQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/630b38053b213e6138d3deb3e4325b24ad6dcb1f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/s390-Use-_pt_s390_gaddr-for-gmap-address-tracking/20230418-045832
        git checkout 630b38053b213e6138d3deb3e4325b24ad6dcb1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304180652.LeoLmaNQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/m68k/mm/motorola.c: In function 'free_pointer_table':
>> arch/m68k/mm/motorola.c:204:56: warning: passing argument 1 of 'virt_to_ptdesc' makes pointer from integer without a cast [-Wint-conversion]
     204 |                         ptdesc_pte_dtor(virt_to_ptdesc(page));
         |                                                        ^~~~
         |                                                        |
         |                                                        long unsigned int
   In file included from arch/m68k/mm/motorola.c:15:
   include/linux/mm.h:2721:57: note: expected 'const void *' but argument is of type 'long unsigned int'
    2721 | static inline struct ptdesc *virt_to_ptdesc(const void *x)
         |                                             ~~~~~~~~~~~~^
   arch/m68k/mm/motorola.c: At top level:
   arch/m68k/mm/motorola.c:418:13: warning: no previous prototype for 'paging_init' [-Wmissing-prototypes]
     418 | void __init paging_init(void)
         |             ^~~~~~~~~~~


vim +/virt_to_ptdesc +204 arch/m68k/mm/motorola.c

   185	
   186	int free_pointer_table(void *table, int type)
   187	{
   188		ptable_desc *dp;
   189		unsigned long ptable = (unsigned long)table;
   190		unsigned long page = ptable & PAGE_MASK;
   191		unsigned int mask = 1U << ((ptable - page)/ptable_size(type));
   192	
   193		dp = PD_PTABLE(page);
   194		if (PD_MARKBITS (dp) & mask)
   195			panic ("table already free!");
   196	
   197		PD_MARKBITS (dp) |= mask;
   198	
   199		if (PD_MARKBITS(dp) == ptable_mask(type)) {
   200			/* all tables in page are free, free page */
   201			list_del(dp);
   202			mmu_page_dtor((void *)page);
   203			if (type == TABLE_PTE)
 > 204				ptdesc_pte_dtor(virt_to_ptdesc(page));
   205			free_page (page);
   206			return 1;
   207		} else if (ptable_list[type].next != dp) {
   208			/*
   209			 * move this descriptor to the front of the list, since
   210			 * it has one or more free tables.
   211			 */
   212			list_move(dp, &ptable_list[type]);
   213		}
   214		return 0;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
