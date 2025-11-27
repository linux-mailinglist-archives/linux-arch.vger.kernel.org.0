Return-Path: <linux-arch+bounces-15092-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4733C8DCEC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879313A9D12
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356332ABDB;
	Thu, 27 Nov 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1NaUxFj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78677329C7D;
	Thu, 27 Nov 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239855; cv=none; b=h7CwBWrwqkhq+fyM9IzJDDLp5+mXcMRCeMBrVC9IZLq0iHLQXBExjKEo9E0seC2g1VwggcRIa33IbnGT51K83jmgK8LvCGrQ7dDW5gXaAMuMeiIki1IwKTbTgl34fWdgPYBLi5l1uTjg2KFySsU/o/tZPHUu88hCXVTLO7zgWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239855; c=relaxed/simple;
	bh=f7hhmDtXODYt87CdFOKiBsu/XuhbqKkmbcAJ1l7uZgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI/NpMExI/xVUr/q+MEo80D9ZDopGhBoyXTF5EO2AP9CYGrpW30NG1ayRI0D+DPyIj4+gCuYzz0XIXZsikt39ZPwxD/oEASH8qUyRvwTirdpxDXqiBhbHVMXCe6Ak4oqAUS/Vpr+NfRJ5H1iZQBGt9mQ5s4AO5e4xuwYQSLaf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1NaUxFj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764239853; x=1795775853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f7hhmDtXODYt87CdFOKiBsu/XuhbqKkmbcAJ1l7uZgo=;
  b=R1NaUxFjHwWyOXBBN8j1nh135rVNe6/ESTq4kMp1MKJ60A0EKbDVUe+f
   mXCdW2vWsatSJi4XidWIn30O8LMHwJ2TGQvJzr72LxH9mRvQRJ1lNqJgK
   4pT0NeX/ZpoRBdQvzdIz30FmEAKcEpnULCovdivuzVWCqpbLAMECB0VNM
   y/4lYaGkJhdeqe4HoxxmF/KW0AzoSUuT1mYbhBHEEWVnQyhn+5pOd1XJr
   xbg2SsJFdZ5UOx6F+rgSYNR0yyfW4VP+4MBY5VmY17SkMHL/emLVchSLx
   rgIJ2F0IEqRvbe34Idqj9WVtEl1tLUufcopb6ibsGPWBoWknKSwlWQGgJ
   g==;
X-CSE-ConnectionGUID: Aa0gfsQvSE+0G8nomiNmbg==
X-CSE-MsgGUID: eRxrYDh1SDyYZoh5PC4n6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70152343"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="70152343"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:37:30 -0800
X-CSE-ConnectionGUID: 4CJrhnLqSEWuE6kRo2ej5A==
X-CSE-MsgGUID: u7Oyl7xuTPaKP9+NYaIsRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193422643"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2025 02:37:25 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOZNL-000000004XD-1Ooj;
	Thu, 27 Nov 2025 10:37:23 +0000
Date: Thu, 27 Nov 2025 18:36:47 +0800
From: kernel test robot <lkp@intel.com>
To: Anirudh Raybharam <anirudh@anirudhrb.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, Arnd Bergmann <arnd@arndb.de>,
	akpm@linux-foundation.org, agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com, osandov@fb.com, bsz@amazon.de,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] irqchip/gic-v3: allocate one SGI for MSHV
Message-ID: <202511271745.71G6M2De-lkp@intel.com>
References: <20251125170124.2443340-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125170124.2443340-3-anirudh@anirudhrb.com>

Hi Anirudh,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251125]
[also build test ERROR on v6.18-rc7]
[cannot apply to arm64/for-next/core tip/irq/core arnd-asm-generic/master linus/master v6.18-rc7 v6.18-rc6 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Raybharam/arm64-hyperv-move-hyperv-detection-earlier-in-boot/20251126-011057
base:   next-20251125
patch link:    https://lore.kernel.org/r/20251125170124.2443340-3-anirudh%40anirudhrb.com
patch subject: [PATCH 2/3] irqchip/gic-v3: allocate one SGI for MSHV
config: arm-randconfig-002-20251127 (https://download.01.org/0day-ci/archive/20251127/202511271745.71G6M2De-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b3428bb966f1de8aa48375ffee0eba04ede133b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511271745.71G6M2De-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511271745.71G6M2De-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-gic-v3.c:37:10: fatal error: 'asm/mshyperv.h' file not found
      37 | #include <asm/mshyperv.h>
         |          ^~~~~~~~~~~~~~~~
   1 error generated.


vim +37 drivers/irqchip/irq-gic-v3.c

    32	
    33	#include <asm/cputype.h>
    34	#include <asm/exception.h>
    35	#include <asm/smp_plat.h>
    36	#include <asm/virt.h>
  > 37	#include <asm/mshyperv.h>
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

