Return-Path: <linux-arch+bounces-8036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7750099A3D6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE6E1F25888
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E2216A3B;
	Fri, 11 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIMsPHZt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538A209662;
	Fri, 11 Oct 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649641; cv=none; b=iuJ3WDMpWB5fjQ3tiduWQ5bljszSNem25++opNeP89XqttDBY5pkLW13/hTB/1MB8wFn0C+TwDuJFtww/+HR873GZIv4MlBsxRO/gq5nNIWSKkT+NwVuXXQFzVdGgERgdNHNiesiJIY2c0VhjeCdrR4DywQRuXRFroSlcEXiBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649641; c=relaxed/simple;
	bh=7e++66M02WFRNHfXld6AhxF3W044qoc43KGtBc0hdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgDZj+A1yBmC4Ok2ICcTWx3odb7pdJojLZydc5XCG1CXZ9bT9bw1Yyu6FmWmHuQvRDv9pN5FhM16MvwaYWFCmwIgdkQ6atMarJb/eOgVq14jnrNraA6TdHx4jJZpc1BBoM0SdptJ1RJXVOWg4UFb7El6tCzVaECeI2OgQFZyAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIMsPHZt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728649639; x=1760185639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7e++66M02WFRNHfXld6AhxF3W044qoc43KGtBc0hdAg=;
  b=VIMsPHZtBV8BuvdmIENRlmSqonUIg7kMMyHFRUMOk0KkA2UUcORSWsQv
   j+UMwxT42bT2FI3yowNiKZisqJe2NbMm2J08jnRWTfK0LUoDSeC/qgJAQ
   lAMGJis4qCW630nx/DlyakqpXQitn/gcjuBlBge38oUCH5TWznU/RcXJl
   xYrcF70XicJkERVAkt1idcP40fJX3TXKl/Y7uisclR74xQJo7FxhCJ4OG
   Q2HqEJ7HfoB8BCDGqso//94fEKLhSvPbGXqUUiaNk/fBdEGSR5zVxRf52
   92R6lHAcJMFAvV0h1X2BgrXsduJhaTcE9LK4tGzMcob9Mqy7/yCzjcwod
   g==;
X-CSE-ConnectionGUID: g6Vkz6ahRcWmL4JkopIB8A==
X-CSE-MsgGUID: wqvGoLv5SM2MwgmVTLZA+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38629539"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="38629539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 05:27:18 -0700
X-CSE-ConnectionGUID: v/C/7JSvRcCYDkl/gmPAZw==
X-CSE-MsgGUID: 3/T2zYwITDu384Bdn5xe2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81901400"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2024 05:27:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szEjg-000CID-2e;
	Fri, 11 Oct 2024 12:27:12 +0000
Date: Fri, 11 Oct 2024 20:26:32 +0800
From: kernel test robot <lkp@intel.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 2/2] vdso: Introduce vdso/page.h
Message-ID: <202410112014.ugeJ1luU-lkp@intel.com>
References: <20241010135146.181175-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010135146.181175-3-vincenzo.frascino@arm.com>

Hi Vincenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on vgupta-arc/for-curr]
[also build test ERROR on arm64/for-next/core geert-m68k/for-next geert-m68k/for-linus deller-parisc/for-next powerpc/next powerpc/fixes s390/features uml/next tip/x86/core linus/master openrisc/for-next v6.12-rc2 next-20241011]
[cannot apply to vgupta-arc/for-next uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincenzo-Frascino/drm-i915-Change-fault-type-to-unsigned-long/20241010-215325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git for-curr
patch link:    https://lore.kernel.org/r/20241010135146.181175-3-vincenzo.frascino%40arm.com
patch subject: [PATCH v4 2/2] vdso: Introduce vdso/page.h
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241011/202410112014.ugeJ1luU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410112014.ugeJ1luU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410112014.ugeJ1luU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/include/asm/thread_info.h:31,
                    from include/linux/thread_info.h:60,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/alloc_tag.h:11,
                    from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
>> arch/s390/include/asm/page.h:17:9: warning: "PAGE_SHIFT" redefined
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |         ^~~~~~~~~~
   In file included from arch/s390/include/asm/page.h:14:
   include/vdso/page.h:13:9: note: this is the location of the previous definition
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |         ^~~~~~~~~~
>> arch/s390/include/asm/page.h:18:9: warning: "PAGE_SIZE" redefined
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |         ^~~~~~~~~
   include/vdso/page.h:15:9: note: this is the location of the previous definition
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |         ^~~~~~~~~
>> arch/s390/include/asm/page.h:19:9: warning: "PAGE_MASK" redefined
      19 | #define PAGE_MASK       _PAGE_MASK
         |         ^~~~~~~~~
   include/vdso/page.h:27:9: note: this is the location of the previous definition
      27 | #define PAGE_MASK       (~(PAGE_SIZE - 1))
         |         ^~~~~~~~~
   arch/s390/include/asm/page.h: In function 'pfn_to_virt':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/page.h:239:59: note: in definition of macro '__va'
     239 | #define __va(x)                 ((void *)((unsigned long)(x) + __identity_base))
         |                                                           ^
   arch/s390/include/asm/page.h:244:43: note: in expansion of macro 'PAGE_SHIFT'
     244 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
         |                                           ^~~~~~~~~~
   arch/s390/include/asm/page.h:253:21: note: in expansion of macro 'pfn_to_phys'
     253 |         return __va(pfn_to_phys(pfn));
         |                     ^~~~~~~~~~~
   arch/s390/include/asm/page.h:17:25: note: each undeclared identifier is reported only once for each function it appears in
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/page.h:239:59: note: in definition of macro '__va'
     239 | #define __va(x)                 ((void *)((unsigned long)(x) + __identity_base))
         |                                                           ^
   arch/s390/include/asm/page.h:244:43: note: in expansion of macro 'PAGE_SHIFT'
     244 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
         |                                           ^~~~~~~~~~
   arch/s390/include/asm/page.h:253:21: note: in expansion of macro 'pfn_to_phys'
     253 |         return __va(pfn_to_phys(pfn));
         |                     ^~~~~~~~~~~
   arch/s390/include/asm/page.h: In function 'virt_to_pfn':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/page.h:243:44: note: in expansion of macro 'PAGE_SHIFT'
     243 | #define phys_to_pfn(phys)       ((phys) >> PAGE_SHIFT)
         |                                            ^~~~~~~~~~
   arch/s390/include/asm/page.h:258:16: note: in expansion of macro 'phys_to_pfn'
     258 |         return phys_to_pfn(__pa(kaddr));
         |                ^~~~~~~~~~~
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/s390/include/asm/processor.h: In function 'on_thread_stack':
>> arch/s390/include/asm/page.h:18:25: error: '_PAGE_SIZE' undeclared (first use in this function); did you mean 'HPAGE_SIZE'?
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^~~~~~~~~~
   arch/s390/include/asm/thread_info.h:25:22: note: in expansion of macro 'PAGE_SIZE'
      25 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^~~~~~~~~
   arch/s390/include/asm/processor.h:287:52: note: in expansion of macro 'THREAD_SIZE'
     287 |         return !((ksp ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
         |                                                    ^~~~~~~~~~~
   include/linux/sched.h: At top level:
>> arch/s390/include/asm/page.h:18:25: error: '_PAGE_SIZE' undeclared here (not in a function); did you mean 'HPAGE_SIZE'?
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^~~~~~~~~~
   arch/s390/include/asm/thread_info.h:25:22: note: in expansion of macro 'PAGE_SIZE'
      25 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^~~~~~~~~
   include/linux/sched.h:1890:29: note: in expansion of macro 'THREAD_SIZE'
    1890 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
         |                             ^~~~~~~~~~~
>> arch/s390/include/asm/page.h:18:25: warning: "_PAGE_SIZE" is not defined, evaluates to 0 [-Wundef]
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^~~~~~~~~~
   include/linux/mm_types.h:547:6: note: in expansion of macro 'PAGE_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |      ^~~~~~~~~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/linux/bits.h:5,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/s390/include/asm/bug.h:69,
                    from include/linux/bug.h:5,
                    from include/linux/alloc_tag.h:8:
>> arch/s390/include/asm/page.h:19:25: warning: "_PAGE_MASK" is not defined, evaluates to 0 [-Wundef]
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/mm_types.h:524:41: note: in expansion of macro '__ALIGN_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/linux/mm_types.h:524:62: note: in expansion of macro 'PAGE_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:547:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/include/asm/page.h:19:25: warning: "_PAGE_MASK" is not defined, evaluates to 0 [-Wundef]
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:524:41: note: in expansion of macro '__ALIGN_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/linux/mm_types.h:524:62: note: in expansion of macro 'PAGE_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:547:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/include/asm/page.h:17:25: warning: "_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/mmzone.h:1777:23: note: in expansion of macro 'PAGE_SHIFT'
    1777 | #if (MAX_PAGE_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
         |                       ^~~~~~~~~~
   include/linux/mmzone.h: In function 'pfn_to_section_nr':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/mmzone.h:1767:54: note: in expansion of macro 'PAGE_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^~~~~~~~~~
   include/linux/mmzone.h:1783:23: note: in expansion of macro 'PFN_SECTION_SHIFT'
    1783 |         return pfn >> PFN_SECTION_SHIFT;
         |                       ^~~~~~~~~~~~~~~~~
   include/linux/mmzone.h: In function 'section_nr_to_pfn':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/mmzone.h:1767:54: note: in expansion of macro 'PAGE_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^~~~~~~~~~
   include/linux/mmzone.h:1787:23: note: in expansion of macro 'PFN_SECTION_SHIFT'
    1787 |         return sec << PFN_SECTION_SHIFT;
         |                       ^~~~~~~~~~~~~~~~~
   include/linux/mmzone.h: In function 'subsection_map_index':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/mmzone.h:1767:54: note: in expansion of macro 'PAGE_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^~~~~~~~~~
   include/linux/mmzone.h:1771:41: note: in expansion of macro 'PFN_SECTION_SHIFT'
    1771 | #define PAGES_PER_SECTION       (1UL << PFN_SECTION_SHIFT)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/mmzone.h:1772:36: note: in expansion of macro 'PAGES_PER_SECTION'
    1772 | #define PAGE_SECTION_MASK       (~(PAGES_PER_SECTION-1))
         |                                    ^~~~~~~~~~~~~~~~~
   include/linux/mmzone.h:1996:25: note: in expansion of macro 'PAGE_SECTION_MASK'
    1996 |         return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
         |                         ^~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/memory_model.h:5,
                    from arch/s390/include/asm/page.h:272:
   include/linux/mmzone.h: In function 'pfn_valid':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/pfn.h:22:43: note: in definition of macro 'PHYS_PFN'
      22 | #define PHYS_PFN(x)     ((unsigned long)((x) >> PAGE_SHIFT))
         |                                           ^
   include/linux/pfn.h:21:46: note: in expansion of macro 'PAGE_SHIFT'
      21 | #define PFN_PHYS(x)     ((phys_addr_t)(x) << PAGE_SHIFT)
         |                                              ^~~~~~~~~~
   include/linux/mmzone.h:2037:22: note: in expansion of macro 'PFN_PHYS'
    2037 |         if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
         |                      ^~~~~~~~
   In file included from arch/s390/include/asm/bug.h:5:
   arch/s390/include/asm/uv.h: In function 'share':
>> arch/s390/include/asm/page.h:19:25: error: '_PAGE_MASK' undeclared (first use in this function); did you mean 'HPAGE_MASK'?
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/s390/include/asm/uv.h:440:9: note: in expansion of macro 'BUG_ON'
     440 |         BUG_ON(addr & ~PAGE_MASK);
         |         ^~~~~~
   arch/s390/include/asm/uv.h:440:24: note: in expansion of macro 'PAGE_MASK'
     440 |         BUG_ON(addr & ~PAGE_MASK);
         |                        ^~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'pgd_pfn':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/pgtable.h:710:48: note: in expansion of macro 'PAGE_SHIFT'
     710 |         return (pgd_val(pgd) & origin_mask) >> PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'p4d_pfn':
>> arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/pgtable.h:737:48: note: in expansion of macro 'PAGE_SHIFT'
     737 |         return (p4d_val(p4d) & origin_mask) >> PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'pte_pgprot':
>> arch/s390/include/asm/page.h:19:25: error: '_PAGE_MASK' undeclared (first use in this function); did you mean 'HPAGE_MASK'?
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   arch/s390/include/asm/pgtable.h:205:34: note: in expansion of macro 'PAGE_MASK'
     205 | #define _PAGE_CHG_MASK          (PAGE_MASK | _PAGE_SPECIAL | _PAGE_DIRTY | \
         |                                  ^~~~~~~~~
   arch/s390/include/asm/pgtable.h:961:50: note: in expansion of macro '_PAGE_CHG_MASK'
     961 |         unsigned long pte_flags = pte_val(pte) & _PAGE_CHG_MASK;
         |                                                  ^~~~~~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'pte_modify':
   arch/s390/include/asm/page.h:19:25: error: '_PAGE_MASK' undeclared (first use in this function); did you mean 'HPAGE_MASK'?
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   arch/s390/include/asm/page.h:124:40: note: in definition of macro '__pgprot'
     124 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
   arch/s390/include/asm/pgtable.h:205:34: note: in expansion of macro 'PAGE_MASK'
     205 | #define _PAGE_CHG_MASK          (PAGE_MASK | _PAGE_SPECIAL | _PAGE_DIRTY | \
         |                                  ^~~~~~~~~
   arch/s390/include/asm/pgtable.h:1035:44: note: in expansion of macro '_PAGE_CHG_MASK'
    1035 |         pte = clear_pte_bit(pte, __pgprot(~_PAGE_CHG_MASK));
         |                                            ^~~~~~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function '__ptep_rdp':
   arch/s390/include/asm/page.h:19:25: error: '_PAGE_MASK' undeclared (first use in this function); did you mean 'HPAGE_MASK'?
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^~~~~~~~~~
   arch/s390/include/asm/pgtable.h:1121:58: note: in expansion of macro 'PAGE_MASK'
    1121 |                      : [r1] "a" (pto), [r2] "a" ((addr & PAGE_MASK) | opt),
         |                                                          ^~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'mk_pte':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/page.h:244:43: note: in expansion of macro 'PAGE_SHIFT'
     244 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
         |                                           ^~~~~~~~~~
   arch/s390/include/asm/page.h:248:33: note: in expansion of macro 'pfn_to_phys'
     248 | #define page_to_phys(page)      pfn_to_phys(page_to_pfn(page))
         |                                 ^~~~~~~~~~~
   arch/s390/include/asm/pgtable.h:1419:34: note: in expansion of macro 'page_to_phys'
    1419 |         unsigned long physpage = page_to_phys(page);
         |                                  ^~~~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'pmd_pfn':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/pgtable.h:1447:40: note: in expansion of macro 'PAGE_SHIFT'
    1447 |         return __pa(pmd_deref(pmd)) >> PAGE_SHIFT;
         |                                        ^~~~~~~~~~
   arch/s390/include/asm/pgtable.h: In function 'pud_pfn':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/pgtable.h:1463:40: note: in expansion of macro 'PAGE_SHIFT'
    1463 |         return __pa(pud_deref(pud)) >> PAGE_SHIFT;
         |                                        ^~~~~~~~~~
   include/linux/pgtable.h: In function 'pte_index':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/pgtable.h:69:28: note: in expansion of macro 'PAGE_SHIFT'
      69 |         return (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
         |                            ^~~~~~~~~~
   include/linux/pgtable.h: In function 'pte_advance_pfn':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   arch/s390/include/asm/page.h:119:37: note: in definition of macro '__pte'
     119 | #define __pte(x)        ((pte_t) { (x) } )
         |                                     ^
   arch/s390/include/asm/pgtable.h:1371:33: note: in expansion of macro 'PAGE_SHIFT'
    1371 | #define PFN_PTE_SHIFT           PAGE_SHIFT
         |                                 ^~~~~~~~~~
   include/linux/pgtable.h:239:44: note: in expansion of macro 'PFN_PTE_SHIFT'
     239 |         return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
         |                                            ^~~~~~~~~~~~~
   include/linux/pgtable.h: In function 'is_zero_pfn':
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared (first use in this function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/pgtable.h:1565:59: note: in expansion of macro 'PAGE_SHIFT'
    1565 |         return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
         |                                                           ^~~~~~~~~~
   include/linux/slab.h: At top level:
   arch/s390/include/asm/page.h:17:25: error: '_PAGE_SHIFT' undeclared here (not in a function); did you mean 'HPAGE_SHIFT'?
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/slab.h:528:34: note: in expansion of macro 'PAGE_SHIFT'
     528 | #define KMALLOC_SHIFT_HIGH      (PAGE_SHIFT + 1)
         |                                  ^~~~~~~~~~
   include/linux/slab.h:597:42: note: in expansion of macro 'KMALLOC_SHIFT_HIGH'
     597 | typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
         |                                          ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6:
   arch/s390/include/asm/page.h:17:25: error: expression in static assertion is not an integer
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~


vim +17 arch/s390/include/asm/page.h

c67da7c7c5d4c0 arch/s390/include/asm/page.h Heiko Carstens           2017-06-16  15  
^1da177e4c3f41 include/asm-s390/page.h      Linus Torvalds           2005-04-16  16  /* PAGE_SHIFT determines the page size */
c67da7c7c5d4c0 arch/s390/include/asm/page.h Heiko Carstens           2017-06-16 @17  #define PAGE_SHIFT	_PAGE_SHIFT
c67da7c7c5d4c0 arch/s390/include/asm/page.h Heiko Carstens           2017-06-16 @18  #define PAGE_SIZE	_PAGE_SIZE
c67da7c7c5d4c0 arch/s390/include/asm/page.h Heiko Carstens           2017-06-16 @19  #define PAGE_MASK	_PAGE_MASK
6376402841e1fa arch/s390/include/asm/page.h Heiko Carstens           2023-06-21  20  #define PAGE_DEFAULT_ACC	_AC(0, UL)
e613d83454d7da arch/s390/include/asm/page.h Janis Schoetterl-Glausch 2022-02-11  21  /* storage-protection override */
e613d83454d7da arch/s390/include/asm/page.h Janis Schoetterl-Glausch 2022-02-11  22  #define PAGE_SPO_ACC		9
0b642ede47969d include/asm-s390/page.h      Peter Oberparleiter      2005-05-01  23  #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
^1da177e4c3f41 include/asm-s390/page.h      Linus Torvalds           2005-04-16  24  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

