Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5A3D237C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhGVMCw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:02:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:36701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhGVMCw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:02:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211696465"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="gz'50?scan'50,208,50";a="211696465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 05:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="gz'50?scan'50,208,50";a="662668123"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jul 2021 05:43:25 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6Y2u-0000GK-Cl; Thu, 22 Jul 2021 12:43:24 +0000
Date:   Thu, 22 Jul 2021 20:43:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-uaccess-5 1/8]
 arch/um/kernel/skas/uaccess.c:246:17: error: 'src' undeclared
Message-ID: <202107222016.1Ulr7QC7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-uaccess-5
head:   a8cdb21b715276b7638a636237489f2425c24180
commit: 3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a [1/8] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a
        git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags asm-generic asm-generic-uaccess-5
        git checkout 3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/um/include/asm/uaccess.h:39,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/highmem.h:5,
                    from arch/um/kernel/skas/uaccess.c:7:
   arch/um/kernel/skas/uaccess.c: In function 'strnlen_user':
>> arch/um/kernel/skas/uaccess.c:246:17: error: 'src' undeclared (first use in this function)
     246 |  if (!access_ok(src, 1))
         |                 ^~~
   include/asm-generic/uaccess.h:124:59: note: in definition of macro 'access_ok'
     124 | #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
         |                                                           ^~~~
   arch/um/kernel/skas/uaccess.c:246:17: note: each undeclared identifier is reported only once for each function it appears in
     246 |  if (!access_ok(src, 1))
         |                 ^~~
   include/asm-generic/uaccess.h:124:59: note: in definition of macro 'access_ok'
     124 | #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
         |                                                           ^~~~


vim +/src +246 arch/um/kernel/skas/uaccess.c

   241	
   242	long strnlen_user(const void __user *str, long len)
   243	{
   244		int count = 0, n;
   245	
 > 246		if (!access_ok(src, 1))
   247			return -EFAULT;
   248	
   249		if (uaccess_kernel())
   250			return strnlen((__force char*)str, len) + 1;
   251	
   252		n = buffer_op((unsigned long) str, len, 0, strnlen_chunk, &count);
   253		if (n == 0)
   254			return count + 1;
   255		return 0;
   256	}
   257	EXPORT_SYMBOL(strnlen_user);
   258	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IJpNTDwzlM2Ie8A6--
