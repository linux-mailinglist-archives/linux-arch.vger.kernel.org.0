Return-Path: <linux-arch+bounces-1220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C26F8210D4
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jan 2024 00:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035B62826C4
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 23:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C76C15B;
	Sun, 31 Dec 2023 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVfxCF7M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A8C2C5;
	Sun, 31 Dec 2023 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704064350; x=1735600350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=62bNteZDkhz2KSoLHklFYTxgVS2scwtyvlyZ0y55ohg=;
  b=aVfxCF7MRKSUyHvY8XELb0DRX7xwG3YGxZ2rejirjVOhnrd1d4gJ9kP8
   Ervh6qTXBJd4JxOuQ2zXA9NZbBeH0NN3XjxmFa6fmh3WuoVmqVzLxE5zi
   pX8/BqXBL9LcQzM26e92wM14R8g2dv+RtOO6bMbTf06bcjUGux49II5At
   yJPkXSetRygHEexPjXrduISElqmQPUCcF56MM859tzndsh6VNDAeYCem3
   NAu5+VWVfOXxiHHS82y/yLrkZqUs6ChVOVFDjZlhTfQByl7ePAEcSPsmE
   QEH1qMU6v/Vh0oWHvHriacmSMnFRnyadmOfLLNpvYSAPvXdOdOT9AWHQJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="3588643"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="3588643"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 15:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="902746244"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="902746244"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2023 15:12:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK4yi-000Jo0-34;
	Sun, 31 Dec 2023 23:12:20 +0000
Date: Mon, 1 Jan 2024 07:11:48 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
	luto@kernel.org, datglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org,
	peterz@infradead.org, hannes@cmpxchg.org, sohil.mehta@intel.com,
	rick.p.edgecombe@intel.com, nphamcs@gmail.com, palmer@sifive.com,
	keescook@chromium.org, legion@kernel.org, mark.rutland@arm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4] posix-timers: add multi_clock_gettime system call
Message-ID: <202401010719.QfVc3HOt-lkp@intel.com>
References: <20231231170721.3381-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231170721.3381-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/asm]
[also build test ERROR on tip/timers/core linus/master v6.7-rc7]
[cannot apply to arnd-asm-generic/master next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20240101-011104
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20231231170721.3381-1-maimon.sagi%40gmail.com
patch subject: [PATCH v4] posix-timers: add multi_clock_gettime system call
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240101/202401010719.QfVc3HOt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401010719.QfVc3HOt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010719.QfVc3HOt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/sparc/kernel/setup_64.c:21:
>> include/linux/syscalls.h:1164:48: error: 'struct __ptp_multi_clock_get' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                                                ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/setup_64.c:602:13: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]
     602 | void __init alloc_irqstack_bootmem(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/sparc/kernel/sys_sparc_64.c:25:
>> include/linux/syscalls.h:1164:48: error: 'struct __ptp_multi_clock_get' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                                                ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +1164 include/linux/syscalls.h

  1154	
  1155	/* obsolete */
  1156	asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
  1157			unsigned long third, void __user *ptr, long fifth);
  1158	
  1159	/* obsolete */
  1160	asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
  1161				unsigned long prot, unsigned long flags,
  1162				unsigned long fd, unsigned long pgoff);
  1163	asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
> 1164	asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
  1165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

