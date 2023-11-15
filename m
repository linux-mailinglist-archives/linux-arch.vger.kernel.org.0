Return-Path: <linux-arch+bounces-229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A9E7EC64D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F5281453
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E812747F;
	Wed, 15 Nov 2023 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFWBzk+7"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682E2E64B
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 14:51:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07AD8E;
	Wed, 15 Nov 2023 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700059862; x=1731595862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkIPOw810249sk90oDTDuwzqTKjcTyNRgT3NVxcT2Gk=;
  b=oFWBzk+7OfA4UHxsIT2/iAs8kgNUQXuj9O3wU3hWlAw/6OKwbTQRbPtx
   NiNZRoNoMYgOc+ZseV65BB+1OEGt9P086Zlh0wweABqrYsuKZu7o5tRHh
   hXdhdUNutALXPx0MCtaU1mreKmhsSs5o+/QZuPfybVKUGPISFxg329m2Y
   OXW+4gFFnWKzHX7wu3n9oVuCiP/B10TlAwZixZ2k21scv2MNgufRmHrpR
   tPkorRHILw8g9DmiFIBiwRvqqyFORHz9lr2KFHNznS3IXc0NkoF8JVG4q
   gpoaV9BFV+R3Jf0M1Ug0v0sJJc6wsQTs8XGfp4gCx5iq2RSWleAR9l+ks
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371075734"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="371075734"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 06:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="908801239"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="908801239"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2023 06:50:59 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3HEG-0000Ps-2c;
	Wed, 15 Nov 2023 14:50:56 +0000
Date: Wed, 15 Nov 2023 22:50:37 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com
Cc: oe-kbuild-all@lists.linux.dev, will@kernel.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, arnd@arndb.de,
	mark.rutland@arm.com, broonie@kernel.org, keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, patches@amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH] arm64: irq: set the correct node for VMAP stack
Message-ID: <202311152250.ozO781vZ-lkp@intel.com>
References: <20231114091643.59530-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114091643.59530-1-shijie@os.amperecomputing.com>

Hi Huang,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus arnd-asm-generic/master linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huang-Shijie/arm64-irq-set-the-correct-node-for-VMAP-stack/20231114-171932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231114091643.59530-1-shijie%40os.amperecomputing.com
patch subject: [PATCH] arm64: irq: set the correct node for VMAP stack
config: arm64-randconfig-001-20231115 (https://download.01.org/0day-ci/archive/20231115/202311152250.ozO781vZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311152250.ozO781vZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152250.ozO781vZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/irq.c: In function 'init_irq_stacks':
>> arch/arm64/kernel/irq.c:60:59: error: implicit declaration of function 'early_cpu_to_node'; did you mean 'early_pfn_to_nid'? [-Werror=implicit-function-declaration]
      60 |                 p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
         |                                                           ^~~~~~~~~~~~~~~~~
         |                                                           early_pfn_to_nid
   cc1: some warnings being treated as errors


vim +60 arch/arm64/kernel/irq.c

    52	
    53	#ifdef CONFIG_VMAP_STACK
    54	static void init_irq_stacks(void)
    55	{
    56		int cpu;
    57		unsigned long *p;
    58	
    59		for_each_possible_cpu(cpu) {
  > 60			p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
    61			per_cpu(irq_stack_ptr, cpu) = p;
    62		}
    63	}
    64	#else
    65	/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
    66	DEFINE_PER_CPU_ALIGNED(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

