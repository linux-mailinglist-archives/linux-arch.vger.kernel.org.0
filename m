Return-Path: <linux-arch+bounces-5304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FB929986
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 21:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F381F21219
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF85C8FC;
	Sun,  7 Jul 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fn4Rllxt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F634545;
	Sun,  7 Jul 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720381280; cv=none; b=RVuwaKp9AkVk/LeJXuu/o4sMuisKAyL6OFKRbawuDL/tekzPR/ySSWgtysnDY3+UMDppqlsl/6SMNvL8KpfBWjOII0vQz9R+OkBrUSupWlJJlMf8w6knvnyiUAejTse6yJO5VQ+bXfOWvMHaztde5EyQGmJhvCErFQ1Glp5QIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720381280; c=relaxed/simple;
	bh=24s7GAiJqumgDMoJwbnNmAYEdsxrDnWAFn3353foY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufz4EIaLCxOrigEa8dx5Z9I2B49GeygEGjZhIj23ozYzIEg8Wpso8N04jXuGF2puriALJ0Quzy6Sw6bzB3oXrXbDScTuiYKGHnFIwFy3hl7Ks3Bd+GXki9lm4oZi4tyOh+HVHoMHnpEdL5YMQURfR5xf2Wstm9ub4aOJe5gBCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fn4Rllxt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720381278; x=1751917278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24s7GAiJqumgDMoJwbnNmAYEdsxrDnWAFn3353foY5U=;
  b=fn4RllxtGPMMkyWpOfzbo3vPZ/+LgbZ3PRFcNSLNcYA37xMP0soQvmxa
   FF9O8EqmVUbu3vG1rFEDoKsvvTl6gH9W2Ix4GpMVfBZrEM7hALDLCVYiv
   FDD5aye+DEX6Gv7h9oBQHKD9TX/d56McOd21C4LUOmowX5R/KqizEe7VD
   OnCGXaTw8CSQs2tm+Z6mJnSir61YSi48hjXneYeLv7rHm3YPpi3GUzQ5x
   o0dihUzo6QkfT4z5OgxGWPRbeE8A3bkD2rVIJqDEn0KXglVq6ktgI8iD6
   VLoG5SQWyWVMJCGt3mrb3ekSlnmpSLzqlPU6cRrOM27jcLEzXADpGD1X/
   Q==;
X-CSE-ConnectionGUID: ATlD/1fZRdCOGEU8F55Gfg==
X-CSE-MsgGUID: MA76KQaZRTGJ3KVJip5IYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28979899"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="28979899"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 12:41:18 -0700
X-CSE-ConnectionGUID: 9mRhFq3/TVWowy/6X5agIg==
X-CSE-MsgGUID: jFpu7DR2TtaMQ7p9tGY2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47080366"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jul 2024 12:41:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQXl3-000VEK-1W;
	Sun, 07 Jul 2024 19:41:13 +0000
Date: Mon, 8 Jul 2024 03:40:29 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when
 optimizing for performance
Message-ID: <202407080355.VUEmeBsv-lkp@intel.com>
References: <20240707171919.1951895-5-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707171919.1951895-5-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on arm/for-next arm/fixes soc/for-next linus/master v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/lib-math-test_div64-add-some-edge-cases-relevant-to-__div64_const32/20240708-013344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20240707171919.1951895-5-nico%40fluxnic.net
patch subject: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when optimizing for performance
config: arm-randconfig-002-20240708 (https://download.01.org/0day-ci/archive/20240708/202407080355.VUEmeBsv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240708/202407080355.VUEmeBsv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407080355.VUEmeBsv-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from include/linux/sched.h:16,
                    from arch/arm/kernel/asm-offsets.c:11:
>> arch/arm/include/asm/div64.h:60:1: error: return type defaults to 'int' [-Werror=implicit-int]
      60 | __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1 shuffle=2335528022
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2 shuffle=2335528022
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=2335528022
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=2335528022
   make: Target 'prepare' not remade because of errors.


vim +/int +60 arch/arm/include/asm/div64.h

    54	
    55	#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
    56	static __always_inline
    57	#else
    58	static inline
    59	#endif
  > 60	__arch_xprod_64(uint64_t m, uint64_t n, bool bias)
    61	{
    62		unsigned long long res;
    63		register unsigned int tmp asm("ip") = 0;
    64		bool no_ovf = __builtin_constant_p(m) &&
    65			      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
    66	
    67		if (!bias) {
    68			asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
    69				"mov	%Q0, #0"
    70				: "=&r" (res)
    71				: "r" (m), "r" (n)
    72				: "cc");
    73		} else if (no_ovf) {
    74			res = m;
    75			asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
    76				"mov	%Q0, #0"
    77				: "+&r" (res)
    78				: "r" (m), "r" (n)
    79				: "cc");
    80		} else {
    81			asm (	"umull	%Q0, %R0, %Q2, %Q3\n\t"
    82				"cmn	%Q0, %Q2\n\t"
    83				"adcs	%R0, %R0, %R2\n\t"
    84				"adc	%Q0, %1, #0"
    85				: "=&r" (res), "+&r" (tmp)
    86				: "r" (m), "r" (n)
    87				: "cc");
    88		}
    89	
    90		if (no_ovf) {
    91			asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
    92				"umlal	%R0, %Q0, %Q1, %R2\n\t"
    93				"mov	%R0, #0\n\t"
    94				"umlal	%Q0, %R0, %R1, %R2"
    95				: "+&r" (res)
    96				: "r" (m), "r" (n)
    97				: "cc");
    98		} else {
    99			asm (	"umlal	%R0, %Q0, %R2, %Q3\n\t"
   100				"umlal	%R0, %1, %Q2, %R3\n\t"
   101				"mov	%R0, #0\n\t"
   102				"adds	%Q0, %1, %Q0\n\t"
   103				"adc	%R0, %R0, #0\n\t"
   104				"umlal	%Q0, %R0, %R2, %R3"
   105				: "+&r" (res), "+&r" (tmp)
   106				: "r" (m), "r" (n)
   107				: "cc");
   108		}
   109	
   110		return res;
   111	}
   112	#define __arch_xprod_64 __arch_xprod_64
   113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

