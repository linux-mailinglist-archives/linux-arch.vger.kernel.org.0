Return-Path: <linux-arch+bounces-12494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D4AEC567
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 09:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892724A2735
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 07:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58100221282;
	Sat, 28 Jun 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyBV4paP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDD1487D1;
	Sat, 28 Jun 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751094640; cv=none; b=kcm25403x5R0YeQT1IpWaXdcZMi6GO8f98uzV0eR31jSBwmdjHOZEcnaDTRNytAsSmHqDwVInKRNF3ryG3XRCu/QfiLveAMgqPtt364yRIbLsw80eoCakfMJuAT5HuPvNUEwpi0r30WFG3YtlNHLOo6WM41eCoYAPePCbhO43i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751094640; c=relaxed/simple;
	bh=2tVRa6wsMqTyE/oQPrMRT6Uokojksj6kxjX9glGnRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6W+r8Y9Ld4ACwzzdDrg4KLGDOz+w5muMpbrlm8F+ARXlXHHxbQj2zXii8ydtPuLICMPQg8CDmCEElwpxDalq1CZg6gVxJf46fW0ygHY7RhaSZrOxk0aNk0BtLn9HkzXnkvqJ0GRGhCXxlNkXF6rpvYeDt86h63kkquDEwiyQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyBV4paP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751094638; x=1782630638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2tVRa6wsMqTyE/oQPrMRT6Uokojksj6kxjX9glGnRB0=;
  b=DyBV4paPGjWMC6O/bOl+XmiCUfAwyQDpstusmSVGi5pifVEnUQPDcKJn
   gscjGr+2pSKHA0I3IDyUEpDJbVQlAv9krxP+/Kga5E0ECHDTCrh7tpH3o
   xzGxc3xcOsYyxr1j8ke+mn/gNkEhngVdpe59BYhTomRPaxMrrRqZKFcG8
   4Jc4PFN+6hIaRJHrNQdeP+ERITzBvBnHzqc3GDdoiYGSFfc+ma9yGli7S
   pZywI7DHrSD9jySxXi3XkW7Vh/X1bgF53GT3K4bQuAfaDyfFnEgJMw+2q
   9FekIx5m9kIUW5KWiAjRPVoE39VlzCRtU6pXQluGX/rUTmhhRl9JNhkdr
   Q==;
X-CSE-ConnectionGUID: tK32tqxARyWY4MDSJCWxPw==
X-CSE-MsgGUID: m5SdEdJoTuet0G97mPo7WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="57080301"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="57080301"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 00:10:37 -0700
X-CSE-ConnectionGUID: ohOsf+HWQWOFrhTjoH3+RA==
X-CSE-MsgGUID: zP+1cSr+RoWpV9omkLPlxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="158488584"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jun 2025 00:10:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVPhm-000Wsw-0M;
	Sat, 28 Jun 2025 07:10:30 +0000
Date: Sat, 28 Jun 2025 15:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: oe-kbuild-all@lists.linux.dev, Yicong Yang <yangyicong@huawei.com>,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, H Peter Anvin <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/8] arm64: Select
 GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <202506281452.zc1D1sSz-lkp@intel.com>
References: <20250624154805.66985-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624154805.66985-6-Jonathan.Cameron@huawei.com>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus arm64/for-next/core linus/master nvdimm/libnvdimm-for-next v6.16-rc3]
[cannot apply to nvdimm/dax-misc next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/memregion-Support-fine-grained-invalidate-by-cpu_cache_invalidate_memregion/20250624-235402
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20250624154805.66985-6-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 5/8] arm64: Select GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
config: arm64-randconfig-r111-20250628 (https://download.01.org/0day-ci/archive/20250628/202506281452.zc1D1sSz-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e04c938cc08a90ae60440ce22d072ebc69d67ee8)
reproduce: (https://download.01.org/0day-ci/archive/20250628/202506281452.zc1D1sSz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506281452.zc1D1sSz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/cache.c:12:1: sparse: sparse: symbol 'scfm_lock' was not declared. Should it be static?
   drivers/base/cache.c:14:6: sparse: sparse: context imbalance in 'generic_set_sys_cache_flush_method' - wrong count at exit
   drivers/base/cache.c:27:9: sparse: sparse: context imbalance in 'generic_clr_sys_cache_flush_method' - wrong count at exit
   drivers/base/cache.c:31:5: sparse: sparse: context imbalance in 'cpu_cache_invalidate_memregion' - wrong count at exit
   drivers/base/cache.c:41:6: sparse: sparse: context imbalance in 'cpu_cache_has_invalidate_memregion' - wrong count at exit

vim +/scfm_lock +12 drivers/base/cache.c

b51d47491c68aef Yicong Yang 2025-06-24   9  
b51d47491c68aef Yicong Yang 2025-06-24  10  
b51d47491c68aef Yicong Yang 2025-06-24  11  static const struct system_cache_flush_method *scfm_data;
b51d47491c68aef Yicong Yang 2025-06-24 @12  DEFINE_SPINLOCK(scfm_lock);
b51d47491c68aef Yicong Yang 2025-06-24  13  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

