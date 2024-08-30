Return-Path: <linux-arch+bounces-6858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17849666B0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BFE1C23960
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B61B7909;
	Fri, 30 Aug 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1H9mzd+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79F1B5813;
	Fri, 30 Aug 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034702; cv=none; b=cHBjj+juGjeyZh9VQj31e+0AzZXttko7XfdX3y2OhAN1NLd8tV0+P1GqRCjdskz5rnmt3emNpK9ZQBWOYgagbdQUqZmZ+oZgIo6V9jHWCdI8O2xKd8WZcrDepmQ8WnxAm+sI5Q7nhINNu2ORzdp7qcK/zrdReCusM74SIFrTgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034702; c=relaxed/simple;
	bh=DO78Muknig9uLuHIr6AaX8YDe6MmUYrrNJiE1yiyh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN+DJ+Z8RdlNzDyJkxWt/ywdg659HfFQc1sH2+yIAMDr7zE5NtKSvccQHO08HGH50XZVssgJj6Et/3se4QfNoTRlM5l+r4sIQO8Xfz6oouwjXmfrtSbHmPsjiiFsby/QehzAFU3YZuSNbWbwt/mbPVUDKClpugLWSfgj/QJtCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1H9mzd+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725034701; x=1756570701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO78Muknig9uLuHIr6AaX8YDe6MmUYrrNJiE1yiyh+w=;
  b=O1H9mzd+Hwlz5gwZ46xdCxwaQMD8UsGj+oBU7oIWyoRManAJJUd/6Keo
   /d9KUE6kB91ilWpMPU/Dm6f4QrMT5wifQq5T4MvQTl1z8yD/0sZhsGBBW
   8eAHeKGV9g700DR6C7T3EEGzwT05mNBjqih5BvppueaQZiyR0O41EMoz6
   Jvvtpi+2yjxOLFqUk7BJqs3OMDZEUAD+kVPrR91OJusSE6AapOU2IetnI
   9fBX6al5QxfKx0s3ZmFwWcgiCDSxocgHdKa2gxyneBy2VJbXE3l0kHcAM
   zcqao9iS0G7rO1qQimNqgUv+KnSQ6pmvfi5kQIsfd9LMDqmbQje87fk7l
   Q==;
X-CSE-ConnectionGUID: OTQTYBxUTmKeOqslJPAZDg==
X-CSE-MsgGUID: E/uTCHznQyedAbwnyAN9pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23201123"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23201123"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:18:20 -0700
X-CSE-ConnectionGUID: ZmpClZ4hQiSdhPeamVJM7Q==
X-CSE-MsgGUID: nUiw9z3xSnu9BstrvjHnZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64134769"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Aug 2024 09:18:17 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4KF-0001dS-0L;
	Fri, 30 Aug 2024 16:18:15 +0000
Date: Sat, 31 Aug 2024 00:18:11 +0800
From: kernel test robot <lkp@intel.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <202408310030.S5ZNwLWz-lkp@intel.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>

Hi Adhemerval,

kernel test robot noticed the following build errors:

[auto build test ERROR on crng-random/master]
[also build test ERROR on next-20240830]
[cannot apply to arm64/for-next/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adhemerval-Zanella/aarch64-vdso-Wire-up-getrandom-vDSO-implementation/20240830-041912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
patch link:    https://lore.kernel.org/r/20240829201728.2825-1-adhemerval.zanella%40linaro.org
patch subject: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408310030.S5ZNwLWz-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 46fe36a4295f05d5d3731762e31fc4e6e99863e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310030.S5ZNwLWz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310030.S5ZNwLWz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.
   In file included from <built-in>:4:
   In file included from lib/vdso/getrandom.c:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from <built-in>:4:
   In file included from lib/vdso/getrandom.c:12:
   In file included from arch/arm64/include/asm/vdso/getrandom.h:8:
>> arch/arm64/include/asm/vdso.h:25:10: fatal error: 'generated/vdso-offsets.h' file not found
      25 | #include <generated/vdso-offsets.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 1 error generated.
   make[3]: *** [scripts/Makefile.build:244: arch/arm64/kernel/vdso/vgetrandom.o] Error 1
   make[3]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[3]: Target 'arch/arm64/kernel/vdso/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:217: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +25 arch/arm64/include/asm/vdso.h

0a7927d2b89e55 Adhemerval Zanella 2024-08-29  24  
9031fefde6f2ac Will Deacon        2012-03-05 @25  #include <generated/vdso-offsets.h>
9031fefde6f2ac Will Deacon        2012-03-05  26  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

