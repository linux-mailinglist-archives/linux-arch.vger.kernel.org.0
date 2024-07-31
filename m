Return-Path: <linux-arch+bounces-5767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF86942D78
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 13:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDAD1C219D5
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C01AD3FE;
	Wed, 31 Jul 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPqxpVgK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C51A8BE6;
	Wed, 31 Jul 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426580; cv=none; b=EAyEYQYRAZtX7DlzkLDVWKc9loUIZ724ACObwObw3mgGLzk+vPkAFkPSS7hPXE6wiW8XFiviDDbuKKUiroUBmw+3CMGBcJo8xZWXJ2Q9Ifqrqgvd3htijuxT9tFyTP+RY7sCQR6x40UdMXfVKhz+wtvJCRPkiemsFgLfW5RSVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426580; c=relaxed/simple;
	bh=e67UYR2/mGbTeMkfZUAD9ZABeKgD5Is/HIrW9D+FLhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFas6aULpHpgLkzH4jkl3HmSMYuA004BGqi2zl39YHTyJGHOO8hw4+dyFBfHuyLgEdtPWnLBhWLmL8KoPMpi3xX8NrX5FTTIicZjpx4oMFiOT5mq4ulgs2pHU4Uf+YjKCIiRlG2HBYGzcE1BLTq+xwDQwrLBgFyJLCReNoNIDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPqxpVgK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722426578; x=1753962578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e67UYR2/mGbTeMkfZUAD9ZABeKgD5Is/HIrW9D+FLhA=;
  b=DPqxpVgKYwCGRnc+j3nqgbyRMqDBKSge3GbgYdDZM0JPkSz9DCV++x5r
   9CW7x23nxYgNKAEFp12I8BMxpZ8z3g99bVUeFdmpBN6f794cxx0dZ6Fhk
   C7aYGnMVAHwXZ/diN1Al+br2EhiVAbCojE33s3upJ+64TAPxZpQhKaiOq
   BngK8QouH1MTLfv1PtxniHnsLz8URaZIiqTZGw6MzjQCId7SHb/e2/CwE
   qItlIXmVVa1UA0RahSQ8i34Aw2zGI0WbYbyobY2YFBBvo8eRH37Xqf/1V
   SaGXQaQw5QAGMrnd2TRvg4ykXvXOXEyE0IPutDNZA+iAORNWXDzbjJ7Lz
   A==;
X-CSE-ConnectionGUID: hO+q1pJ9Tqu4nDX1CPSPAQ==
X-CSE-MsgGUID: Np79VUWgSvK0QTQX0hmsew==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="30878948"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="30878948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:49:38 -0700
X-CSE-ConnectionGUID: 9H+AyAjmRp6rJpQ8R1oIJQ==
X-CSE-MsgGUID: Y12CPz/NRAuLuY1TnDmE/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54583516"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 04:49:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZ7pj-000uCc-1d;
	Wed, 31 Jul 2024 11:49:31 +0000
Date: Wed, 31 Jul 2024 19:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiguo Jiang <justinjiang@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org,
	cgroups@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
Message-ID: <202407311947.VPJNRqad-lkp@intel.com>
References: <20240730114426.511-3-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730114426.511-3-justinjiang@vivo.com>

Hi Zhiguo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-move-task_is_dying-to-h-headfile/20240730-215136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240730114426.511-3-justinjiang%40vivo.com
patch subject: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240731/202407311947.VPJNRqad-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407311947.VPJNRqad-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407311947.VPJNRqad-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/include/asm/tlb.h:39,
                    from mm/oom_kill.c:49:
>> include/asm-generic/tlb.h:327:6: warning: no previous prototype for '__tlb_remove_swap_entries' [-Wmissing-prototypes]
     327 | bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__tlb_remove_swap_entries +327 include/asm-generic/tlb.h

   323	
   324	extern bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
   325			swp_entry_t entry, int nr);
   326	#else
 > 327	bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
   328			swp_entry_t entry, int nr)
   329	{
   330		return false;
   331	}
   332	#endif
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

