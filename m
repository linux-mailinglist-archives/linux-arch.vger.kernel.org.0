Return-Path: <linux-arch+bounces-7288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC0978163
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA5B1C22734
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42D71DB92C;
	Fri, 13 Sep 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvT8BnQl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534371D9358;
	Fri, 13 Sep 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234922; cv=none; b=ITDFLDySsup0wF1vG5MjjBDvISLJZ7bQooxT+4QzOdE9Hv3JKKIy+Wmn/ZDAjF5/Rbzpbn/pG0uRpPjCf7p2i26uIH6+BjPvykLVb3f8QygFwP/1jFZFw8NSknhSCIAO+4Aqc7MaKqwuh57QuQpVmHl7u2bgA6Bd+R0LVTi2SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234922; c=relaxed/simple;
	bh=0izZwJbUGeZqqwiDNV+yXiHife2eO1rK6MoQCaafoMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDQQ3CXRY55JHjnImLIjkawJXZnfFwTylCyhwPX9r3Y9keb7I0qnIPtt+D2EUj/LIYwjHmMoicesyCw1BNw5x/XEUDg3tRN8K3lIZAZB2PQW7h3QfcnjxF4iShc/6BFGJD2HWYuJJvk+Tp3wybZH6og28e0rmaBSQ6g/SU3+4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvT8BnQl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726234921; x=1757770921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0izZwJbUGeZqqwiDNV+yXiHife2eO1rK6MoQCaafoMw=;
  b=EvT8BnQlXduQByrqMuNDntOZ974lONbfL1h2YE4z6GF+znfZp1nFCGgg
   vWYlAqXB1ulHR+tQ0+FaR1ALkDyVnkVqzp6vTCta57o9AAQ7vhABwuX+M
   WxMmce1IW9V/wKmGxeuH2rHitutLefwhNrbOzTTt/q2fhPqFp0RkXgvoU
   8JXSrQNos7hq4sp+Zt++QRQphkQvdXEUTAizAcHj8UMadI6h5IzczDaI/
   z9lfytXunyNNY3waq3fpEV8fuXSZZHTuUtECPW16hrK7jnsYZBueWsSta
   m0tKntjlrCpptsL9WBpv9gh+VydX6dCVaXE+wAmLqD8WuFyu27zvEPsTa
   A==;
X-CSE-ConnectionGUID: SldJq2i1RNuXqj0P3Cc4Zg==
X-CSE-MsgGUID: Bn+rlysLSEaAYk0Sr+jQiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25004146"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25004146"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 06:42:00 -0700
X-CSE-ConnectionGUID: 09Us8nKxQVKipNQZKbDWBQ==
X-CSE-MsgGUID: FbdWSZFvSoO1EmjZw05Kqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68826248"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Sep 2024 06:41:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp6Yc-0006Xu-2v;
	Fri, 13 Sep 2024 13:41:54 +0000
Date: Fri, 13 Sep 2024 21:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <202409132135.ki3Mp5EA-lkp@intel.com>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on 77f587896757708780a7e8792efe62939f25a5ab]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Lameter-via-B4-Relay/Avoid-memory-barrier-in-read_seqcount-through-load-acquire/20240913-064557
base:   77f587896757708780a7e8792efe62939f25a5ab
patch link:    https://lore.kernel.org/r/20240912-seq_optimize-v3-1-8ee25e04dffa%40gentwo.org
patch subject: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240913/202409132135.ki3Mp5EA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409132135.ki3Mp5EA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409132135.ki3Mp5EA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/gt/intel_gt.c:36:
   drivers/gpu/drm/i915/gt/intel_tlb.h: In function 'intel_gt_tlb_seqno':
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:47: error: macro "seqprop_sequence" requires 2 arguments, but only 1 given
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                                               ^
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/drm/drm_managed.h:6,
                    from drivers/gpu/drm/i915/gt/intel_gt.c:6:
   include/linux/seqlock.h:280: note: macro "seqprop_sequence" defined here
     280 | #define seqprop_sequence(s, a)          __seqprop(s, sequence)(s, a)
         | 
   In file included from drivers/gpu/drm/i915/gt/intel_gt.c:36:
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:16: error: 'seqprop_sequence' undeclared (first use in this function)
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_tlb.h:21:16: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from drivers/gpu/drm/i915/gt/intel_tlb.c:14:
   drivers/gpu/drm/i915/gt/intel_tlb.h: In function 'intel_gt_tlb_seqno':
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:47: error: macro "seqprop_sequence" requires 2 arguments, but only 1 given
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                                               ^
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/pm_qos.h:17,
                    from drivers/gpu/drm/i915/i915_drv.h:35,
                    from drivers/gpu/drm/i915/gt/intel_tlb.c:6:
   include/linux/seqlock.h:280: note: macro "seqprop_sequence" defined here
     280 | #define seqprop_sequence(s, a)          __seqprop(s, sequence)(s, a)
         | 
   In file included from drivers/gpu/drm/i915/gt/intel_tlb.c:14:
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:16: error: 'seqprop_sequence' undeclared (first use in this function)
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_tlb.h:21:16: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/i915/gt/intel_tlb.h:22:1: warning: control reaches end of non-void function [-Wreturn-type]
      22 | }
         | ^


vim +/seqprop_sequence +21 drivers/gpu/drm/i915/gt/intel_tlb.h

568a2e6f0b12ee Chris Wilson 2023-08-01  18  
568a2e6f0b12ee Chris Wilson 2023-08-01  19  static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
568a2e6f0b12ee Chris Wilson 2023-08-01  20  {
568a2e6f0b12ee Chris Wilson 2023-08-01 @21  	return seqprop_sequence(&gt->tlb.seqno);
568a2e6f0b12ee Chris Wilson 2023-08-01 @22  }
568a2e6f0b12ee Chris Wilson 2023-08-01  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

