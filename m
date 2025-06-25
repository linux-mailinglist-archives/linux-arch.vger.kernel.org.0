Return-Path: <linux-arch+bounces-12457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39611AE8999
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765D7161BDA
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0C29B201;
	Wed, 25 Jun 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiVDlhRT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89425C6EF;
	Wed, 25 Jun 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868527; cv=none; b=aUmACAGe+jCKJp4Y1RvHnhonxX5kigTXqhOiyo7xUq8if0yvl02HKcnHKc/dJ8c6PLks3NjqZTtChKjTfgHwNkBQIDXIdwgio5XOvSH2ejWym5rltRtguhkfrWPg5UVr8bn55TqxfiJ0wRh6Lt4U6PzcQmKqwTDLTuZv6ixTNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868527; c=relaxed/simple;
	bh=Ou8QHMFdgetDzK5dLd56qGIJObazJQu5Eap283Iz/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKjtWN1n4RujQhQ8IO7k68UrBfUx8TxJSEgV0/JGfGS390gCnyco/0/AYG8CiWYQLBzD7tLjni8nHH3TqOd7F1BjTN9QDUHQ+U8PnoZjlOZs65tx/d5sF51VG58fNT/KkaS2b3gFHnh0FvB2e5s+xmITapgfHW5mos2Ch09Ya5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiVDlhRT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750868526; x=1782404526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ou8QHMFdgetDzK5dLd56qGIJObazJQu5Eap283Iz/b8=;
  b=HiVDlhRTsEfeReLW4sNU9Lf8PYPIlsoq1/YKf+hGdfUEDYrTz6jhbnqm
   RnszxQhiDKKNpHeuIGWcRIlaDqddMGNI05L1kPAORok4A1Q+yteErSZnn
   6hWxCRLwcCXtxG5YKU8/P0pbr74Y64mxjw0TRlGgLGU8TsPbfE070a7it
   UT6pIjJZoqnWag5lVtsmi2hAvsUKOCvdmWg8to0VRZKwTrmmrRotc5L0M
   4blJvQ49ZgEJ3QrSYf4YqL3sOmoIffOZTvsPcwj26vLlra6+Gql3fnPvW
   8pZfMrX+dy2G33qjkFQv4N9oZT+0rWJ88Liqe1hEJYinzddW3VYr8lIjm
   A==;
X-CSE-ConnectionGUID: Wtr9rhBcQfOoW3vkNHvryA==
X-CSE-MsgGUID: STU5GK2lRhK6PpWlVReLCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53013152"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53013152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:22:05 -0700
X-CSE-ConnectionGUID: HE36SdgBRouSxKN5A3ZuUA==
X-CSE-MsgGUID: VNv6kMPsT8Gfurry55xSsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="175913297"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jun 2025 09:21:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUSsm-000TIU-3C;
	Wed, 25 Jun 2025 16:21:56 +0000
Date: Thu, 26 Jun 2025 00:21:23 +0800
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
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 5/8] arm64: Select
 GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <202506260055.YivRG9iE-lkp@intel.com>
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
[cannot apply to nvdimm/dax-misc next-20250625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/memregion-Support-fine-grained-invalidate-by-cpu_cache_invalidate_memregion/20250624-235402
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20250624154805.66985-6-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 5/8] arm64: Select GENERIC_CPU_CACHE_INVALIDATE_MEMREGION
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250626/202506260055.YivRG9iE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260055.YivRG9iE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260055.YivRG9iE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/cache.c:31:5: warning: no previous prototype for 'cpu_cache_invalidate_memregion' [-Wmissing-prototypes]
      31 | int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/cache.c:41:6: warning: no previous prototype for 'cpu_cache_has_invalidate_memregion' [-Wmissing-prototypes]
      41 | bool cpu_cache_has_invalidate_memregion(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cpu_cache_invalidate_memregion +31 drivers/base/cache.c

b51d47491c68ae Yicong Yang 2025-06-24  30  
b51d47491c68ae Yicong Yang 2025-06-24 @31  int cpu_cache_invalidate_memregion(int res_desc, phys_addr_t start, size_t len)
b51d47491c68ae Yicong Yang 2025-06-24  32  {
b51d47491c68ae Yicong Yang 2025-06-24  33  	guard(spinlock_irqsave)(&scfm_lock);
b51d47491c68ae Yicong Yang 2025-06-24  34  	if (!scfm_data)
b51d47491c68ae Yicong Yang 2025-06-24  35  		return -EOPNOTSUPP;
b51d47491c68ae Yicong Yang 2025-06-24  36  
b51d47491c68ae Yicong Yang 2025-06-24  37  	return scfm_data->invalidate_memregion(res_desc, start, len);
b51d47491c68ae Yicong Yang 2025-06-24  38  }
b51d47491c68ae Yicong Yang 2025-06-24  39  EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, "DEVMEM");
b51d47491c68ae Yicong Yang 2025-06-24  40  
b51d47491c68ae Yicong Yang 2025-06-24 @41  bool cpu_cache_has_invalidate_memregion(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

