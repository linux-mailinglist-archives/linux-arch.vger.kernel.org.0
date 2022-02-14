Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C54B420A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiBNGlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 01:41:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbiBNGlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 01:41:09 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592256C0A;
        Sun, 13 Feb 2022 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644820861; x=1676356861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nBA3n6tZG5Us89pqMhk2G1gHJ6B1V6kzYmtcd6yMN4=;
  b=IBrnm+l5tw0O6oBEJTkKztl+TQ0+wcwJrPVPhACx50ZW8BQ7oVCJ3ihT
   U1nP0NuORYs84uki9SSvl4uep8+fbiiGTUzCeE8BZKpq29tUH4thPr8vs
   V6R4FO5IVPeq/40yJRi+nFMZyQQHDKaCcqwyo3imYdx4ReRiFe3CAzY3/
   cfqkCcnu+NQMLeCP7nGwsltYXkbr36kfjBwp/CsjPz/9S3icZ9dUJTui5
   8L7BZS+vLo3GfBhKHZEouT0GeHq+uzYK1+q/MGkGUXzYizYgAPw9glFA1
   C5cLp6DukHGWtt5lrSnqdJDXHW0N1T9986Adn0Oz+ObJITl2T3l8ZMi5O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310763377"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="310763377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="569928493"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 22:40:47 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJV2U-0008F1-J1; Mon, 14 Feb 2022 06:40:46 +0000
Date:   Mon, 14 Feb 2022 14:40:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 23/30] um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <202202141426.Q2fKI6yq-lkp@intel.com>
References: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220214-103534
base:   https://github.com/hnaz/linux-mm master
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220214/202202141426.Q2fKI6yq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f96d6fa064e3f24686f111d1b4c06b865ca103ec
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220214-103534
        git checkout f96d6fa064e3f24686f111d1b4c06b865ca103ec
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/mem_32.c: In function 'gate_vma_init':
>> arch/x86/um/mem_32.c:20:26: error: '__P101' undeclared (first use in this function)
      20 |  gate_vma.vm_page_prot = __P101;
         |                          ^~~~~~
   arch/x86/um/mem_32.c:20:26: note: each undeclared identifier is reported only once for each function it appears in


vim +/__P101 +20 arch/x86/um/mem_32.c

548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  10  
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  11  static int __init gate_vma_init(void)
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  12  {
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  13  	if (!FIXADDR_USER_START)
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  14  		return 0;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  15  
2c4541e24c55e2 arch/x86/um/mem_32.c   Kirill A. Shutemov 2018-07-26  16  	vma_init(&gate_vma, NULL);
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  17  	gate_vma.vm_start = FIXADDR_USER_START;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  18  	gate_vma.vm_end = FIXADDR_USER_END;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  19  	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25 @20  	gate_vma.vm_page_prot = __P101;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  21  
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  22  	return 0;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  23  }
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  24  __initcall(gate_vma_init);
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  25  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
