Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17941F9B5C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 21:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKLU6v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 15:58:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:62244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfKLU6v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 15:58:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="gz'50?scan'50,208,50";a="229528181"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2019 12:58:45 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iUdFM-000HXZ-Fo; Wed, 13 Nov 2019 04:58:44 +0800
Date:   Wed, 13 Nov 2019 04:58:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     kbuild-all@lists.01.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrei Vagin <avagin@gmail.com>, devel@openvz.org
Subject: Re: [PATCH] fs: add new O_MNT flag for opening mount root from
 mountpoint fd
Message-ID: <201911130459.OmluIus2%lkp@intel.com>
References: <20191111110029.16483-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qzgwpyzoj6d7yzve"
Content-Disposition: inline
In-Reply-To: <20191111110029.16483-1-ptikhomirov@virtuozzo.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--qzgwpyzoj6d7yzve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.4-rc7 next-20191112]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tikhomirov/fs-add-new-O_MNT-flag-for-opening-mount-root-from-mountpoint-fd/20191113-022147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git de620fb99ef2bd52b2c5bc52656e89dcfc0e223a
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:74,
                    from fs/fcntl.c:8:
   fs/fcntl.c: In function 'fcntl_init':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_1037' declared with attribute error: BUILD_BUG_ON failed: 22 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC | __FMODE_NONOTIFY)
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:331:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> fs/fcntl.c:1034:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
     ^~~~~~~~~~~~

vim +/__compiletime_assert_1037 +350 include/linux/compiler.h

9a8ab1c39970a4 Daniel Santos 2013-02-21  336  
9a8ab1c39970a4 Daniel Santos 2013-02-21  337  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c39970a4 Daniel Santos 2013-02-21  338  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c39970a4 Daniel Santos 2013-02-21  339  
9a8ab1c39970a4 Daniel Santos 2013-02-21  340  /**
9a8ab1c39970a4 Daniel Santos 2013-02-21  341   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  342   * @condition: a compile-time constant condition to check
9a8ab1c39970a4 Daniel Santos 2013-02-21  343   * @msg:       a message to emit if condition is false
9a8ab1c39970a4 Daniel Santos 2013-02-21  344   *
9a8ab1c39970a4 Daniel Santos 2013-02-21  345   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  346   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c39970a4 Daniel Santos 2013-02-21  347   * compiler has support to do so.
9a8ab1c39970a4 Daniel Santos 2013-02-21  348   */
9a8ab1c39970a4 Daniel Santos 2013-02-21  349  #define compiletime_assert(condition, msg) \
9a8ab1c39970a4 Daniel Santos 2013-02-21 @350  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c39970a4 Daniel Santos 2013-02-21  351  

:::::: The code at line 350 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--qzgwpyzoj6d7yzve
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qf8D5aKNs2L8AAA=

--qzgwpyzoj6d7yzve--
