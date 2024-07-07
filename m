Return-Path: <linux-arch+bounces-5305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93099929988
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FE9281646
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743F6F30F;
	Sun,  7 Jul 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQx+P4wN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B26026A;
	Sun,  7 Jul 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720381283; cv=none; b=j1KzNpTIv2uPIg6GVcIwqu7ksLB23/F3KugZWUTEtOMt9vOFo8qIT6jk0Lq1p76vLtix/66F0uz+JVfcU2toQQGCuA7aQbz9BuX8aZ+RgvGtGW84p68hNgJq8tjMPeMh3DlRhVK4oTM7cht6xY/w1U5zPplqZJ399okFmK065J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720381283; c=relaxed/simple;
	bh=kYO/PXycSIMCVZ1dSA2pHriPbtYjljDjWcl/Y1G1BWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHNeUzN5P/mriUtoVPksbGpEih2KwjyRJ/XvkqG6fYAxZPrGYGhdOUO5dI9qxpQSLTvTvTF8/2hhc5hgch3Xxoo2ZJxHGzZehgf3n94BG+OVp+EGV/sryJcbumtxlRvzJl/KxXtiiTsRw13fFSQIbeC5tgIOO7Dvdxh4wd8028Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQx+P4wN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720381281; x=1751917281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYO/PXycSIMCVZ1dSA2pHriPbtYjljDjWcl/Y1G1BWg=;
  b=XQx+P4wNP6NgLj1pEYDwSkRlqtA77iXHAnVrdjIginkSPoEiJC4G77+b
   Lzb1wIiY18S4EOvslDiP7pR92v3n/CI/27JGqosWocpr08/oPeYOyJAWJ
   VRb+yqrr4Ue3c40xLAOFCxPA5PEblsWsaY3prYSsL/xLcbLnta3X3Ocw3
   p7yP7DifUTwbmtgM63BhiTinnDNDNAzMGkZQvAKxgOaLCiVT9wjCaB+YN
   yeKMckQolvQSCMybLqV2Xs6/dg9GgLAPwaFdJWpkQ88mDTQOSFI2hW/sP
   bpvvOO0noJKXd3dhPEQo5nTc/aGl5QEdjra2y6bhEXWBprHbjLVcuI90C
   Q==;
X-CSE-ConnectionGUID: 2yAc5R4RRTuwMHgLQzpQOw==
X-CSE-MsgGUID: wHABy4yNTxeOZr+WjfaTvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28979905"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="28979905"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 12:41:18 -0700
X-CSE-ConnectionGUID: 4+vQzwEASpyZbLDuxJjJAw==
X-CSE-MsgGUID: 3a7ExpBfSPeXZbUFG1sNlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47080364"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jul 2024 12:41:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQXl3-000VEI-1S;
	Sun, 07 Jul 2024 19:41:13 +0000
Date: Mon, 8 Jul 2024 03:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nicolas Pitre <npitre@baylibre.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when
 optimizing for performance
Message-ID: <202407080326.fBdpm1Tq-lkp@intel.com>
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
config: arm-randconfig-003-20240708 (https://download.01.org/0day-ci/archive/20240708/202407080326.fBdpm1Tq-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240708/202407080326.fBdpm1Tq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407080326.fBdpm1Tq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:16:
   In file included from include/linux/cpumask.h:11:
   In file included from include/linux/kernel.h:27:
   In file included from include/linux/math.h:6:
>> arch/arm/include/asm/div64.h:60:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
   ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
                   a3 = a->sig[3]; a2 = a->sig[2];                         \
                        ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1120:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:


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

