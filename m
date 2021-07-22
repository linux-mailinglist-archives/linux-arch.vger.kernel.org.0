Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597FF3D2491
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhGVMrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:47:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:4019 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhGVMrH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:47:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211646241"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="gz'50?scan'50,208,50";a="211646241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 06:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="gz'50?scan'50,208,50";a="577294426"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2021 06:27:35 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6Yje-0000KN-T6; Thu, 22 Jul 2021 13:27:34 +0000
Date:   Thu, 22 Jul 2021 21:26:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-uaccess-5 1/9]
 arch/csky/lib/usercopy.c:221:17: error: 'src' undeclared
Message-ID: <202107222142.qPL2puxJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-uaccess-5
head:   569f7cb1d4f50aa497092e533d9d4044f5a87b58
commit: 3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a [1/9] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
config: csky-defconfig (attached as .config)
compiler: csky-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a
        git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags asm-generic asm-generic-uaccess-5
        git checkout 3a68cb1dbf65aa5c86ae185e5c51c5c26c31a54a
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the asm-generic/asm-generic-uaccess-5 HEAD 569f7cb1d4f50aa497092e533d9d4044f5a87b58 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/csky/include/asm/uaccess.h:219,
                    from include/linux/uaccess.h:11,
                    from arch/csky/lib/usercopy.c:4:
   arch/csky/lib/usercopy.c: In function 'strnlen_user':
>> arch/csky/lib/usercopy.c:221:17: error: 'src' undeclared (first use in this function)
     221 |  if (!access_ok(src, 1))
         |                 ^~~
   include/asm-generic/uaccess.h:124:59: note: in definition of macro 'access_ok'
     124 | #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
         |                                                           ^~~~
   arch/csky/lib/usercopy.c:221:17: note: each undeclared identifier is reported only once for each function it appears in
     221 |  if (!access_ok(src, 1))
         |                 ^~~
   include/asm-generic/uaccess.h:124:59: note: in definition of macro 'access_ok'
     124 | #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
         |                                                           ^~~~


vim +/src +221 arch/csky/lib/usercopy.c

   205	
   206	/*
   207	 * strnlen_user: - Get the size of a string in user space.
   208	 * @str: The string to measure.
   209	 * @n:   The maximum valid length
   210	 *
   211	 * Get the size of a NUL-terminated string in user space.
   212	 *
   213	 * Returns the size of the string INCLUDING the terminating NUL.
   214	 * On exception, returns 0.
   215	 * If the string is too long, returns a value greater than @n.
   216	 */
   217	long strnlen_user(const char *s, long n)
   218	{
   219		unsigned long res, tmp;
   220	
 > 221		if (!access_ok(src, 1))
   222			return -EFAULT;
   223	
   224		__asm__ __volatile__(
   225		"       cmpnei  %1, 0           \n"
   226		"       bf      3f              \n"
   227		"1:     cmpnei  %0, 0           \n"
   228		"       bf      3f              \n"
   229		"2:     ldb     %3, (%1, 0)     \n"
   230		"       cmpnei  %3, 0           \n"
   231		"       bf      3f              \n"
   232		"       subi    %0,  1          \n"
   233		"       addi    %1,  1          \n"
   234		"       br      1b              \n"
   235		"3:     subu    %2, %0          \n"
   236		"       addi    %2,  1          \n"
   237		"       br      5f              \n"
   238		"4:     movi    %0, 0           \n"
   239		"       br      5f              \n"
   240		".section __ex_table, \"a\"     \n"
   241		".align   2                     \n"
   242		".long    2b, 4b                \n"
   243		".previous                      \n"
   244		"5:                             \n"
   245		: "=r"(n), "=r"(s), "=r"(res), "=r"(tmp)
   246		: "0"(n), "1"(s), "2"(n)
   247		: "memory");
   248	
   249		return res;
   250	}
   251	EXPORT_SYMBOL(strnlen_user);
   252	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nYmfAc1TQIejfV6861nPPkWdKP8H65bBgAygAAA=

--dDRMvlgZJXvWKvBx--
