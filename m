Return-Path: <linux-arch+bounces-1264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E7823AF9
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 04:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A331C24B24
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366B4C9B;
	Thu,  4 Jan 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUHNfUyp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415425221;
	Thu,  4 Jan 2024 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704337587; x=1735873587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GIFKJWf4IPDktNfbFwm+puuxq1zaaa8xPYrnF49oyY=;
  b=bUHNfUypWwaaV7UGsnUUuR5DyT9m4AD2FWZaWpNCNL3t57g7YFiVqky3
   WHWcstucX8vwB/KyGMSIeeIl9UTDzfOuZfj2jognouaD5wcLDKR38daW8
   y9LVg2yHhcPoGLQJoGomfsQ/Ku5ugMxZxWRwrzklBK9fX6mY8YNlto+RW
   1p1hOBOZjVTOWKuvuXqH/5T+Di4FTI3DfysBdfHt8davO/5QadL+5i16t
   +eixHLIE30pUZxZ0TZDVdfZf/QRSs+CWOk/4Lb6tcdwaR1TUOqGBVIzq9
   39J5JFsZArdY2uuNfNdQbvc6bZZPj18wgDhDRTZKNImRvyfNr/ijFEIxd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4191474"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="4191474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="953427445"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="953427445"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2024 19:06:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLE3l-000Mpw-0G;
	Thu, 04 Jan 2024 03:06:17 +0000
Date: Thu, 4 Jan 2024 11:06:02 +0800
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
Subject: Re: [PATCH v5] posix-timers: add multi_clock_gettime system call
Message-ID: <202401041000.T0GQPIBW-lkp@intel.com>
References: <20240102091855.70418-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102091855.70418-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/asm]
[also build test ERROR on arnd-asm-generic/master tip/timers/core linus/master v6.7-rc8]
[cannot apply to next-20240103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20240102-172105
base:   tip/x86/asm
patch link:    https://lore.kernel.org/r/20240102091855.70418-1-maimon.sagi%40gmail.com
patch subject: [PATCH v5] posix-timers: add multi_clock_gettime system call
config: csky-randconfig-002-20240104 (https://download.01.org/0day-ci/archive/20240104/202401041000.T0GQPIBW-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401041000.T0GQPIBW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401041000.T0GQPIBW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> csky-linux-ld: arch/csky/kernel/syscall_table.o:(.data..page_aligned+0x724): undefined reference to `sys_multi_clock_gettime'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

