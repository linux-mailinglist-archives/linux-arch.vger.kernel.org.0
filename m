Return-Path: <linux-arch+bounces-15024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A47C7B75C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4333A5D12
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE192FF65E;
	Fri, 21 Nov 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGKAZJGP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF732FD7D0;
	Fri, 21 Nov 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752477; cv=none; b=ebO9EusyIVayR9phCDcSFPLPsUkfbbK/rimeJsgW0gxBmc6EEcciYhG/AlyX3rTEi7wSi+dc3XyluNHHZUpz5XyUxlHzaXqyV2Fry/oRK6PG9q4xY7PqbCSS59JpHbP8iZz9NzHdV0L2/rk112JVEMSW/bu6YYY3yJlGpRQIBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752477; c=relaxed/simple;
	bh=fGWNibXFUGAhDYfqhQTSp+K9Mm1aNTTr8crCL6BSz6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/YG5H2sUrEvpSVBAs5wABz2tvZIRQ1fP6IrcnOXwoEdNLgpAyrT5hCqIditqCkOAFv/AmUYqptQPWAm2I28cyRUsr7fk0X8y1bV/Nhr/Qa1flQPecjVMwYMDxq0pXA/dMHbXyM+TbQ6YxZOTuL9WhFCUKWSBC6lH434AqAoApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGKAZJGP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763752475; x=1795288475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGWNibXFUGAhDYfqhQTSp+K9Mm1aNTTr8crCL6BSz6s=;
  b=QGKAZJGPsDs7AIrvvRxTUb74haZct3x/p1NM3ofyLPBqAwYNtepsI+GR
   qtz7ZpqJGG0dPMQSZ5O/if0FE1GZPTRYVrr47juQC+CyTD7yk6iekRa66
   YTAeBiz/LxECM5yHF2OKHY9aT57/2QumayqVUftKgE+P9hHFwzS/Xe6+S
   QLdaOJ3I3+DWetK1Vk6MFXLZcOTOXqUPf4zCQKZVpvWRvSuCzFKF+NKq1
   9dKKAXvSS/6iRU7o2cA/gD2YWptKEzt328aGNDL0Jhjp5nYkRlmm+gwZ4
   AImiZl+IN40Xe2Dc9km+4EmWDhGmlGUM2gsDBdQUmsimb3qGoVBgMKaTM
   Q==;
X-CSE-ConnectionGUID: xX6IkWpqToOA3LzIe+G3uA==
X-CSE-MsgGUID: 1RlK06XmQpOjUfvhIrPWnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="68454996"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="68454996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 11:14:35 -0800
X-CSE-ConnectionGUID: 2Ijzr5YBT3aA7bLtsNb2Hw==
X-CSE-MsgGUID: PUXp5Oq0QOCwVdGLd9G5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="195936493"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Nov 2025 11:14:28 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMWaP-0006m3-1U;
	Fri, 21 Nov 2025 19:14:25 +0000
Date: Sat, 22 Nov 2025 03:13:48 +0800
From: kernel test robot <lkp@intel.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	tglx@linutronix.de, andersson@kernel.org, pmladek@suse.com,
	rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
	mhocko@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH 03/26] mm/percpu: Annotate static information into
 meminspect
Message-ID: <202511220241.7y7acdEZ-lkp@intel.com>
References: <20251119154427.1033475-4-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-4-eugen.hristev@linaro.org>

Hi Eugen,

kernel test robot noticed the following build errors:

[auto build test ERROR on rppt-memblock/fixes]
[also build test ERROR on linus/master v6.18-rc6]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugen-Hristev/kernel-Introduce-meminspect/20251119-235912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
patch link:    https://lore.kernel.org/r/20251119154427.1033475-4-eugen.hristev%40linaro.org
patch subject: [PATCH 03/26] mm/percpu: Annotate static information into meminspect
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20251122/202511220241.7y7acdEZ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220241.7y7acdEZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220241.7y7acdEZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/percpu.c:3350:25: error: use of undeclared identifier '__per_cpu_offset'; did you mean '__per_cpu_start'?
    3350 | MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
         |                         ^~~~~~~~~~~~~~~~
         |                         __per_cpu_start
   include/linux/meminspect.h:101:40: note: expanded from macro 'MEMINSPECT_SIMPLE_ENTRY'
     101 |         MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sizeof(sym))
         |                                               ^~~
   include/linux/meminspect.h:92:29: note: expanded from macro 'MEMINSPECT_ENTRY'
      92 |                                                .va = (void *)&(sym),            \
         |                                                                ^~~
   include/asm-generic/sections.h:42:13: note: '__per_cpu_start' declared here
      42 | extern char __per_cpu_start[], __per_cpu_end[];
         |             ^
>> mm/percpu.c:3350:25: error: use of undeclared identifier '__per_cpu_offset'; did you mean '__per_cpu_start'?
    3350 | MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
         |                         ^~~~~~~~~~~~~~~~
         |                         __per_cpu_start
   include/linux/meminspect.h:101:52: note: expanded from macro 'MEMINSPECT_SIMPLE_ENTRY'
     101 |         MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sizeof(sym))
         |                                                           ^~~
   include/linux/meminspect.h:93:22: note: expanded from macro 'MEMINSPECT_ENTRY'
      93 |                                                .size = (sz),                    \
         |                                                         ^~
   include/asm-generic/sections.h:42:13: note: '__per_cpu_start' declared here
      42 | extern char __per_cpu_start[], __per_cpu_end[];
         |             ^
>> mm/percpu.c:3350:1: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    3350 | MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/meminspect.h:101:51: note: expanded from macro 'MEMINSPECT_SIMPLE_ENTRY'
     101 |         MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sizeof(sym))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/linux/meminspect.h:93:22: note: expanded from macro 'MEMINSPECT_ENTRY'
      93 |                                                .size = (sz),                    \
         |                                                         ^~
   3 errors generated.


vim +3350 mm/percpu.c

  3349	
> 3350	MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
  3351	/*
  3352	 * pcpu_nr_pages - calculate total number of populated backing pages
  3353	 *
  3354	 * This reflects the number of pages populated to back chunks.  Metadata is
  3355	 * excluded in the number exposed in meminfo as the number of backing pages
  3356	 * scales with the number of cpus and can quickly outweigh the memory used for
  3357	 * metadata.  It also keeps this calculation nice and simple.
  3358	 *
  3359	 * RETURNS:
  3360	 * Total number of populated backing pages in use by the allocator.
  3361	 */
  3362	unsigned long pcpu_nr_pages(void)
  3363	{
  3364		return data_race(READ_ONCE(pcpu_nr_populated)) * pcpu_nr_units;
  3365	}
  3366	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

