Return-Path: <linux-arch+bounces-13761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98292B9C229
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 22:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D823B6B27
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CCC32D5BD;
	Wed, 24 Sep 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cImYsZAx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF732D5AF;
	Wed, 24 Sep 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746132; cv=none; b=bdqOVxhFiLFNlpNaJajXcjfHpaXZ5hXIpK6CgS4Xq1elA8RSe0HyyNN752NVtcKSSJcYKHhrZFJcHXTi6u0pU4IUjk3FrIaKY79UKHZzfAujrLCuhGXRsGpheOrQesnimph/VA8oWz3A25K0ZXDMy2tleogo29pIikiIlvBkxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746132; c=relaxed/simple;
	bh=yIIG1XirvNHRjmi8n5doZRkSjBLwdxxinyVL08mmVww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey5eI7naemrEoKDZ4k4gXJmpZqVHGhhFqIjcr+oRIKkwc3z3tjTgEXjhaQ2x/QscBnrfCJaV7Q1TN2FQLe+gR4dzLwGemxwNf3TLYp9OfPiFfqhntnu5EM6tSPhP2c4WIJ0+HeTr0i6cLnHxxSM22IwLcvAXkiJOpxqKLh4SsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cImYsZAx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758746130; x=1790282130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yIIG1XirvNHRjmi8n5doZRkSjBLwdxxinyVL08mmVww=;
  b=cImYsZAxVyHhV/PeuE6AmvED8MkGu5EMy0N6jSJPah5jAwgSsbLfnUdO
   ERkl5GdkZL7adenQAlozkjP+IHZUdG60MJpmL/0Oax4utRsaH9x12egNn
   c0y5RwVjiewbxb5lw6agnABe4iqpoS0pl1zAzqhkEj7A8uE/Ht38kvibm
   l2QqnmVXbPVaZg+7fS58rmoGW0aCWRWboJgOXWVz8l12e6/B0XzUo7VNJ
   Krx2DRWGsYjTEAzAol84rqN1Aj73uwUYNw7/Mn9sgSq+e+WKKT2NXPQtv
   T0GCaijmbgcVncTUbvGI4GLAuQEEJi5D71D7hnClXPtu8cre3810M/g4R
   Q==;
X-CSE-ConnectionGUID: FLB/VJYlS4K0lARshSDH3w==
X-CSE-MsgGUID: 1DjhRa9dTSCd3Exu4e+mHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61107250"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61107250"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 13:35:29 -0700
X-CSE-ConnectionGUID: fGvhU9vnSUqnQqd/QW8Okg==
X-CSE-MsgGUID: kGVSi16kQa6u+aYiLlNf8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="181405897"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 13:35:22 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1WCt-0004Xt-1P;
	Wed, 24 Sep 2025 20:35:19 +0000
Date: Thu, 25 Sep 2025 04:34:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Message-ID: <202509250413.sOTeU37m-lkp@intel.com>
References: <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923154551.2112388-3-manikanta.guntupalli@amd.com>

Hi Manikanta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master arnd-asm-generic/master v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250923-234944
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250923154551.2112388-3-manikanta.guntupalli%40amd.com
patch subject: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20250925/202509250413.sOTeU37m-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509250413.sOTeU37m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509250413.sOTeU37m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:12,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sparc/include/asm/hardirq_32.h:11,
                    from arch/sparc/include/asm/hardirq.h:7,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from include/linux/perf_event.h:43,
                    from arch/sparc/mm/fault_32.c:22:
>> arch/sparc/include/asm/io.h:16:9: warning: 'readw_be' redefined
      16 | #define readw_be(__addr)        __raw_readw(__addr)
         |         ^~~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:21,
                    from arch/sparc/include/asm/io.h:7:
   include/asm-generic/io.h:304:9: note: this is the location of the previous definition
     304 | #define readw_be readw_be
         |         ^~~~~~~~
>> arch/sparc/include/asm/io.h:17:9: warning: 'readl_be' redefined
      17 | #define readl_be(__addr)        __raw_readl(__addr)
         |         ^~~~~~~~
   include/asm-generic/io.h:319:9: note: this is the location of the previous definition
     319 | #define readl_be readl_be
         |         ^~~~~~~~
>> arch/sparc/include/asm/io.h:19:9: warning: 'writel_be' redefined
      19 | #define writel_be(__w, __addr)  __raw_writel(__w, __addr)
         |         ^~~~~~~~~
   include/asm-generic/io.h:363:9: note: this is the location of the previous definition
     363 | #define writel_be writel_be
         |         ^~~~~~~~~
>> arch/sparc/include/asm/io.h:20:9: warning: 'writew_be' redefined
      20 | #define writew_be(__l, __addr)  __raw_writew(__l, __addr)
         |         ^~~~~~~~~
   include/asm-generic/io.h:351:9: note: this is the location of the previous definition
     351 | #define writew_be writew_be
         |         ^~~~~~~~~
--
   In file included from include/linux/io.h:12,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sparc/include/asm/hardirq_32.h:11,
                    from arch/sparc/include/asm/hardirq.h:7,
                    from include/linux/hardirq.h:11,
                    from include/linux/highmem.h:12,
                    from include/linux/pagemap.h:11,
                    from arch/sparc/mm/srmmu.c:15:
>> arch/sparc/include/asm/io.h:16:9: warning: 'readw_be' redefined
      16 | #define readw_be(__addr)        __raw_readw(__addr)
         |         ^~~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:21,
                    from arch/sparc/include/asm/io.h:7:
   include/asm-generic/io.h:304:9: note: this is the location of the previous definition
     304 | #define readw_be readw_be
         |         ^~~~~~~~
>> arch/sparc/include/asm/io.h:17:9: warning: 'readl_be' redefined
      17 | #define readl_be(__addr)        __raw_readl(__addr)
         |         ^~~~~~~~
   include/asm-generic/io.h:319:9: note: this is the location of the previous definition
     319 | #define readl_be readl_be
         |         ^~~~~~~~
>> arch/sparc/include/asm/io.h:19:9: warning: 'writel_be' redefined
      19 | #define writel_be(__w, __addr)  __raw_writel(__w, __addr)
         |         ^~~~~~~~~
   include/asm-generic/io.h:363:9: note: this is the location of the previous definition
     363 | #define writel_be writel_be
         |         ^~~~~~~~~
>> arch/sparc/include/asm/io.h:20:9: warning: 'writew_be' redefined
      20 | #define writew_be(__l, __addr)  __raw_writew(__l, __addr)
         |         ^~~~~~~~~
   include/asm-generic/io.h:351:9: note: this is the location of the previous definition
     351 | #define writew_be writew_be
         |         ^~~~~~~~~
   arch/sparc/mm/srmmu.c: In function 'poke_hypersparc':
   arch/sparc/mm/srmmu.c:1074:32: warning: variable 'clear' set but not used [-Wunused-but-set-variable]
    1074 |         volatile unsigned long clear;
         |                                ^~~~~


vim +/readw_be +16 arch/sparc/include/asm/io.h

21dccddf45aae2 Jan Andersson 2011-05-10   9  
21dccddf45aae2 Jan Andersson 2011-05-10  10  /*
21dccddf45aae2 Jan Andersson 2011-05-10  11   * Defines used for both SPARC32 and SPARC64
21dccddf45aae2 Jan Andersson 2011-05-10  12   */
21dccddf45aae2 Jan Andersson 2011-05-10  13  
21dccddf45aae2 Jan Andersson 2011-05-10  14  /* Big endian versions of memory read/write routines */
21dccddf45aae2 Jan Andersson 2011-05-10  15  #define readb_be(__addr)	__raw_readb(__addr)
21dccddf45aae2 Jan Andersson 2011-05-10 @16  #define readw_be(__addr)	__raw_readw(__addr)
21dccddf45aae2 Jan Andersson 2011-05-10 @17  #define readl_be(__addr)	__raw_readl(__addr)
21dccddf45aae2 Jan Andersson 2011-05-10  18  #define writeb_be(__b, __addr)	__raw_writeb(__b, __addr)
21dccddf45aae2 Jan Andersson 2011-05-10 @19  #define writel_be(__w, __addr)	__raw_writel(__w, __addr)
21dccddf45aae2 Jan Andersson 2011-05-10 @20  #define writew_be(__l, __addr)	__raw_writew(__l, __addr)
21dccddf45aae2 Jan Andersson 2011-05-10  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

