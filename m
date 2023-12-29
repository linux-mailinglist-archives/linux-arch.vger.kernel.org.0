Return-Path: <linux-arch+bounces-1205-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32581FCBF
	for <lists+linux-arch@lfdr.de>; Fri, 29 Dec 2023 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3757E1C21474
	for <lists+linux-arch@lfdr.de>; Fri, 29 Dec 2023 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB017FA;
	Fri, 29 Dec 2023 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT5+mcNK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1C17D1;
	Fri, 29 Dec 2023 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703820337; x=1735356337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GI0BYWNxggUK+/8olzYfOrKAOiCpg0a33yjnkKk3bOs=;
  b=fT5+mcNK4gtD4uOn/f5gtiLmdqFvmvBoAH/RYpv2m+AaaKOt/OIgdc3m
   f/5s7Wxzb5/YXkMatCm0phhYEHRgWfcuoUZCBqi+IzUpjH1NWS4vS7rGx
   8X5S4m5QtYA/VadzjJo2E2EU6F76StfA/HClvbrPxm27kmX/ePupw/OUm
   m1mBW3qwIyI0oOKwGhuI9L9juppGhglrTr15GcxcV82L4blMEPW2VgVOl
   zbtiVJeEkc+hOY/knTEc+ePSCVtIfiwlHibVXM0ntVO7LELDIOIO7gWG0
   WnSqziZgRJLlX9H/RkgzV1SpMMq6LeRqPXEbSI3hfiYL2fzOQnVyG+3bY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="463028802"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="463028802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 19:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="13178180"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Dec 2023 19:25:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ3TK-000H3V-2U;
	Fri, 29 Dec 2023 03:24:13 +0000
Date: Fri, 29 Dec 2023 11:21:24 +0800
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
Message-ID: <202312291148.zfhZ9vDJ-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-002-20231229 (https://download.01.org/0day-ci/archive/20231229/202312291148.zfhZ9vDJ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291148.zfhZ9vDJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291148.zfhZ9vDJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/multi_clock.h:14:2: error: unknown type name 'clockid_t'
      14 |         clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
         |         ^
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

