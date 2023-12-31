Return-Path: <linux-arch+bounces-1219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F3820F6C
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DA82826DA
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54754CA49;
	Sun, 31 Dec 2023 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1GAGCKv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A75C140;
	Sun, 31 Dec 2023 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704060562; x=1735596562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUCAEfj4wWS0M04e5nED9Qi7YXhqCBQq+48SBHJwc+c=;
  b=c1GAGCKvpRTNW/p51S4RlUj+pshD8cUf5ToSZwx2/HsDhecG1RBRfQ5y
   cB1DHXcuMglPq3rwPqjS3XC0pcRc2kJSj8YgNRsae3mXEbSq6I2m0QWq/
   7EQ/+3/iu26FfNLJ2WgfUB4DbxWjT0GepO2OaKADs4ZqdjBoZwd3ZFyjz
   s9Q9kY+qketIWX+sg7GsC/RRc+f4UX6W9e4XT252tf3fiHu9uAGSVWMkL
   3JTaOjAyPJ8/zr/9CoDpRDgf6AF2ZlTHN4oQxCiw4JzpWtthXvWYIFPSD
   lC2nAmVZI3KGdA5iuwAW0XYmFCk1FhXM0NLoni6l8YTYvPVoBW5Hnw3H6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="395645665"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="395645665"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 14:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026390056"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="1026390056"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Dec 2023 14:09:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK3zc-000Jly-1e;
	Sun, 31 Dec 2023 22:09:12 +0000
Date: Mon, 1 Jan 2024 06:09:06 +0800
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
Message-ID: <202401010512.duJmX3qR-lkp@intel.com>
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
[also build test ERROR on arnd-asm-generic/master tip/timers/core linus/master v6.7-rc7]
[cannot apply to next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20240101-011104
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20231231170721.3381-1-maimon.sagi%40gmail.com
patch subject: [PATCH v4] posix-timers: add multi_clock_gettime system call
config: nios2-randconfig-002-20240101 (https://download.01.org/0day-ci/archive/20240101/202401010512.duJmX3qR-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401010512.duJmX3qR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010512.duJmX3qR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> nios2-linux-ld: arch/nios2/kernel/syscall_table.o:(.data+0x724): undefined reference to `sys_multi_clock_gettime'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

