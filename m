Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B06BB7B8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjCOP1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjCOP1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:27:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8937B102;
        Wed, 15 Mar 2023 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678894037; x=1710430037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmafdlE9K7jY5w4f+o52ZlOCBd18WnbGUnpIwlNMkYU=;
  b=PXYYGp1HHn8FVEPL8Wg9R/HBDt9Yqzzo9ctIeXzZ28aRaEAQz3N7SlH4
   JQhEJltK2MLQTp6WA/anrfK9hMyEPrZBWU1Byr003/6AxgMpCJADLf4xW
   hsOWysHiUvUTiVdvvK0THMjURdFfCxsY1XhTC9yNnSnIDaXuEXfTB5iO+
   XHcIZTl7CIp5mBnB163NXFI2Bh3BKLJ6XyC0QH46M5orTvAORd0MCpIwB
   C5ltbGAEgIlyITVZnlns3d9cWHZCyTfho9yEC1Oi+RbrnY4qRhcsidf/n
   J7+L5WEYIhQFJLqR2Cw2xK13l65qdmKgKBQrSh2sjSMEKAQ9unuPJx5gW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424005286"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424005286"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 08:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853652434"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="853652434"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2023 08:26:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcT1i-0007oZ-0V;
        Wed, 15 Mar 2023 15:26:54 +0000
Date:   Wed, 15 Mar 2023 23:26:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <202303152343.D93IbJmn-lkp@intel.com>
References: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kirill,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on powerpc/next powerpc/fixes linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230315113133.11326-11-kirill.shutemov%40linux.intel.com
patch subject: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
config: arm-randconfig-r033-20230313 (https://download.01.org/0day-ci/archive/20230315/202303152343.D93IbJmn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
        git checkout ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memblock.c:2046:11: warning: comparison of distinct pointer types ('typeof (11) *' (aka 'int *') and 'typeof (__ffs(start)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   order = min(MAX_ORDER, __ffs(start));
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +2046 mm/memblock.c

  2040	
  2041	static void __init __free_pages_memory(unsigned long start, unsigned long end)
  2042	{
  2043		int order;
  2044	
  2045		while (start < end) {
> 2046			order = min(MAX_ORDER, __ffs(start));
  2047	
  2048			while (start + (1UL << order) > end)
  2049				order--;
  2050	
  2051			memblock_free_pages(pfn_to_page(start), start, order);
  2052	
  2053			start += (1UL << order);
  2054		}
  2055	}
  2056	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
