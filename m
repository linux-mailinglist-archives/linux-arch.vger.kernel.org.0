Return-Path: <linux-arch+bounces-247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDCA7F042A
	for <lists+linux-arch@lfdr.de>; Sun, 19 Nov 2023 04:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A351F22140
	for <lists+linux-arch@lfdr.de>; Sun, 19 Nov 2023 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73F1876;
	Sun, 19 Nov 2023 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crKG24SE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260DB3;
	Sat, 18 Nov 2023 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700363662; x=1731899662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DgMR+20joI22QFpxuYG34MFkzxuJ+eU5dAVuggNsAkY=;
  b=crKG24SEVzDB+/qpn5UkJtaCvz4M5b+dCf1WRzbgH/97u50JW2nzuMR2
   OsiyuOcCJqNzgEKS7AzwKzQUzoQm5dN2FmgRCakBDYJATQjlVWC39UQl0
   O+WjvD0TTEcmq6wZwUePSt61/FoKDnFL8BkLoEj67fJgmUla1hTxflQro
   0it5PAlXhVj/JDPWqnCgUUGK5DpHc74ShAz7iAqoMTAIXKkJkhbsaqp4W
   om2CW063g7wFvgC1mfE8i5jsOx1+jwrA5bVPjkPiY1/tk2oYMR+JiIQ1/
   kmW07znCra8rmfHDNFj8/dRKLsgP1N56aEksIrEjn/TZ8DEGcxXyK29Fu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="370812188"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="370812188"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 19:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="800823006"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="800823006"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2023 19:14:14 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r4YGC-0004aP-0K;
	Sun, 19 Nov 2023 03:14:12 +0000
Date: Sun, 19 Nov 2023 11:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-hexagon@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-m68k@lists.linux-m68k.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-arm-kernel@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>, linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and
 unxlate_dev_mem_ptr()
Message-ID: <202311191145.pppExJS6-lkp@intel.com>
References: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on geert-m68k/for-next geert-m68k/for-linus deller-parisc/for-next powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/asm-io-remove-unnecessary-xlate_dev_mem_ptr-and-unxlate_dev_mem_ptr/20231118-183038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231118100827.1599422-1-wangkefeng.wang%40huawei.com
patch subject: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem_ptr()
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20231119/202311191145.pppExJS6-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191145.pppExJS6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191145.pppExJS6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/mem.c:159:10: error: call to undeclared function 'xlate_dev_mem_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           ptr = xlate_dev_mem_ptr(p);
                                 ^
>> drivers/char/mem.c:159:8: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                           ptr = xlate_dev_mem_ptr(p);
                               ^ ~~~~~~~~~~~~~~~~~~~~
>> drivers/char/mem.c:164:4: error: call to undeclared function 'unxlate_dev_mem_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           unxlate_dev_mem_ptr(p, ptr);
                           ^
   drivers/char/mem.c:235:10: error: call to undeclared function 'xlate_dev_mem_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           ptr = xlate_dev_mem_ptr(p);
                                 ^
   drivers/char/mem.c:235:8: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                           ptr = xlate_dev_mem_ptr(p);
                               ^ ~~~~~~~~~~~~~~~~~~~~
   drivers/char/mem.c:243:4: error: call to undeclared function 'unxlate_dev_mem_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           unxlate_dev_mem_ptr(p, ptr);
                           ^
   6 errors generated.


vim +/xlate_dev_mem_ptr +159 drivers/char/mem.c

^1da177e4c3f41 Linus Torvalds                2005-04-16  133  
22ec1a2aea73b9 Kees Cook                     2017-12-01  134  	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
22ec1a2aea73b9 Kees Cook                     2017-12-01  135  	if (!bounce)
22ec1a2aea73b9 Kees Cook                     2017-12-01  136  		return -ENOMEM;
22ec1a2aea73b9 Kees Cook                     2017-12-01  137  
^1da177e4c3f41 Linus Torvalds                2005-04-16  138  	while (count > 0) {
fa29e97bb8c70f Wu Fengguang                  2009-12-14  139  		unsigned long remaining;
b5b38200ebe548 Kees Cook                     2018-03-27  140  		int allowed, probe;
fa29e97bb8c70f Wu Fengguang                  2009-12-14  141  
f222318e9c3a31 Wu Fengguang                  2009-12-14  142  		sz = size_inside_page(p, count);
^1da177e4c3f41 Linus Torvalds                2005-04-16  143  
22ec1a2aea73b9 Kees Cook                     2017-12-01  144  		err = -EPERM;
a4866aa812518e Kees Cook                     2017-04-05  145  		allowed = page_is_allowed(p >> PAGE_SHIFT);
a4866aa812518e Kees Cook                     2017-04-05  146  		if (!allowed)
22ec1a2aea73b9 Kees Cook                     2017-12-01  147  			goto failed;
22ec1a2aea73b9 Kees Cook                     2017-12-01  148  
22ec1a2aea73b9 Kees Cook                     2017-12-01  149  		err = -EFAULT;
a4866aa812518e Kees Cook                     2017-04-05  150  		if (allowed == 2) {
a4866aa812518e Kees Cook                     2017-04-05  151  			/* Show zeros for restricted memory. */
a4866aa812518e Kees Cook                     2017-04-05  152  			remaining = clear_user(buf, sz);
a4866aa812518e Kees Cook                     2017-04-05  153  		} else {
^1da177e4c3f41 Linus Torvalds                2005-04-16  154  			/*
a4866aa812518e Kees Cook                     2017-04-05  155  			 * On ia64 if a page has been mapped somewhere as
a4866aa812518e Kees Cook                     2017-04-05  156  			 * uncached, then it must also be accessed uncached
a4866aa812518e Kees Cook                     2017-04-05  157  			 * by the kernel or data corruption may occur.
^1da177e4c3f41 Linus Torvalds                2005-04-16  158  			 */
^1da177e4c3f41 Linus Torvalds                2005-04-16 @159  			ptr = xlate_dev_mem_ptr(p);
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18  160  			if (!ptr)
22ec1a2aea73b9 Kees Cook                     2017-12-01  161  				goto failed;
a4866aa812518e Kees Cook                     2017-04-05  162  
fe557319aa06c2 Christoph Hellwig             2020-06-17  163  			probe = copy_from_kernel_nofault(bounce, ptr, sz);
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18 @164  			unxlate_dev_mem_ptr(p, ptr);
b5b38200ebe548 Kees Cook                     2018-03-27  165  			if (probe)
22ec1a2aea73b9 Kees Cook                     2017-12-01  166  				goto failed;
22ec1a2aea73b9 Kees Cook                     2017-12-01  167  
22ec1a2aea73b9 Kees Cook                     2017-12-01  168  			remaining = copy_to_user(buf, bounce, sz);
a4866aa812518e Kees Cook                     2017-04-05  169  		}
a4866aa812518e Kees Cook                     2017-04-05  170  
fa29e97bb8c70f Wu Fengguang                  2009-12-14  171  		if (remaining)
22ec1a2aea73b9 Kees Cook                     2017-12-01  172  			goto failed;
e045fb2a988a9a venkatesh.pallipadi@intel.com 2008-03-18  173  
^1da177e4c3f41 Linus Torvalds                2005-04-16  174  		buf += sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  175  		p += sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  176  		count -= sz;
^1da177e4c3f41 Linus Torvalds                2005-04-16  177  		read += sz;
8619e5bdeee8b2 Tetsuo Handa                  2019-08-26  178  		if (should_stop_iteration())
8619e5bdeee8b2 Tetsuo Handa                  2019-08-26  179  			break;
^1da177e4c3f41 Linus Torvalds                2005-04-16  180  	}
22ec1a2aea73b9 Kees Cook                     2017-12-01  181  	kfree(bounce);
^1da177e4c3f41 Linus Torvalds                2005-04-16  182  
^1da177e4c3f41 Linus Torvalds                2005-04-16  183  	*ppos += read;
^1da177e4c3f41 Linus Torvalds                2005-04-16  184  	return read;
22ec1a2aea73b9 Kees Cook                     2017-12-01  185  
22ec1a2aea73b9 Kees Cook                     2017-12-01  186  failed:
22ec1a2aea73b9 Kees Cook                     2017-12-01  187  	kfree(bounce);
22ec1a2aea73b9 Kees Cook                     2017-12-01  188  	return err;
^1da177e4c3f41 Linus Torvalds                2005-04-16  189  }
^1da177e4c3f41 Linus Torvalds                2005-04-16  190  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

