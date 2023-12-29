Return-Path: <linux-arch+bounces-1206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E481FCF4
	for <lists+linux-arch@lfdr.de>; Fri, 29 Dec 2023 05:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D742847E1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Dec 2023 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D41C26;
	Fri, 29 Dec 2023 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiFXUIp/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7F5C9B;
	Fri, 29 Dec 2023 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703822753; x=1735358753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hahtoToS7LBmBNlG0a/hax2YTgm+rOGmZDL7DnlF8s=;
  b=SiFXUIp/ni9VSI3JLvGsFfKRndIsb0Vo4hDO2121cdo9WyQIqmSiM/2R
   s4Xitu8vhGbOOVDFLaMRBddzZe0k2TPm002JB6l9l67cn3hrxa0wOyzbY
   FcZ/0XLb9591oLk6EdI3B09Y6y1e9vYNunXpuvyE5BDAZlg85GUiYYmWy
   bQL4IXgVhtzmqDxSyrnqOyc/iQ0DZsZmCCJ7DUkmRS6di+jZb+kX4USwi
   UVerezUVexFmML8tjAt9MzObfsC++ihdonGLnifhN8srLiGBR20bPumPm
   i1QEu1aq8nI5TmUy/tQXeCefrlEAoLP8V3xAfLhHdcInSQn7Rb0yuFib8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="396339537"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="396339537"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 20:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="782215180"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="782215180"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2023 20:05:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ47P-000H5J-36;
	Fri, 29 Dec 2023 04:05:34 +0000
Date: Fri, 29 Dec 2023 12:03:11 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
	luto@kernel.org, datglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org,
	peterz@infradead.org, hannes@cmpxchg.org, sohil.mehta@intel.com,
	rick.p.edgecombe@intel.com, nphamcs@gmail.com, palmer@sifive.com,
	keescook@chromium.org, legion@kernel.org, mark.rutland@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
Message-ID: <202312291154.hCJdKLKM-lkp@intel.com>
References: <20231228122411.3189-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228122411.3189-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/asm]
[also build test ERROR on arnd-asm-generic/master tip/timers/core linus/master v6.7-rc7]
[cannot apply to next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20231228-202632
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20231228122411.3189-1-maimon.sagi%40gmail.com
patch subject: [PATCH v3] posix-timers: add multi_clock_gettime system call
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231229/202312291154.hCJdKLKM-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 8a4266a626914765c0c69839e8a51be383013c1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291154.hCJdKLKM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291154.hCJdKLKM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/time/time.c:33:
>> include/linux/syscalls.h:1164:48: warning: declaration of 'struct __ptp_multi_clock_get' will not be visible outside of this function [-Wvisibility]
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                                                ^
   1 warning generated.
--
   In file included from kernel/time/hrtimer.c:30:
>> include/linux/syscalls.h:1164:48: warning: declaration of 'struct __ptp_multi_clock_get' will not be visible outside of this function [-Wvisibility]
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                                                ^
   kernel/time/hrtimer.c:147:20: warning: unused function 'is_migration_base' [-Wunused-function]
     147 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
         |                    ^~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:1876:20: warning: unused function '__hrtimer_peek_ahead_timers' [-Wunused-function]
    1876 | static inline void __hrtimer_peek_ahead_timers(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
   In file included from kernel/time/posix-timers.c:26:
>> include/linux/syscalls.h:1164:48: warning: declaration of 'struct __ptp_multi_clock_get' will not be visible outside of this function [-Wvisibility]
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                                                ^
>> kernel/time/posix-timers.c:1430:1: error: conflicting types for 'sys_multi_clock_gettime'
    1430 | SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
         | ^
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE1'
     219 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:244:18: note: expanded from macro '__SYSCALL_DEFINEx'
     244 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
         |                         ^
   <scratch space>:135:1: note: expanded from here
     135 | sys_multi_clock_gettime
         | ^
   include/linux/syscalls.h:1164:17: note: previous declaration is here
    1164 | asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
         |                 ^
   1 warning and 1 error generated.


vim +/sys_multi_clock_gettime +1430 kernel/time/posix-timers.c

  1429	
> 1430	SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
  1431	{
  1432		const struct k_clock *kc;
  1433		struct timespec64 kernel_tp;
  1434		struct __ptp_multi_clock_get multi_clk_get;
  1435		unsigned int i, j;
  1436		int error;
  1437	
  1438		if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
  1439			return -EFAULT;
  1440	
  1441		if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
  1442			return -EINVAL;
  1443		if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
  1444			return -EINVAL;
  1445	
  1446		for (j = 0; j < multi_clk_get.n_samples; j++) {
  1447			for (i = 0; i < multi_clk_get.n_clocks; i++) {
  1448				kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
  1449				if (!kc)
  1450					return -EINVAL;
  1451				error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
  1452				if (!error && put_timespec64(&kernel_tp, (struct __kernel_timespec __user *)
  1453							     &ptp_multi_clk_get->ts[j][i]))
  1454					error = -EFAULT;
  1455			}
  1456		}
  1457	
  1458		return error;
  1459	}
  1460	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

