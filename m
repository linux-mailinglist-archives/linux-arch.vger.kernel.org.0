Return-Path: <linux-arch+bounces-7709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69F9911E5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB207B21C9C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBE1D89F2;
	Fri,  4 Oct 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmC/2lOF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19141C8315;
	Fri,  4 Oct 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078952; cv=none; b=b775Fwr7mdIsegZX1OSQZSN3GbmbvRW0ne8LdLlkU8g2nCKcfW1WQdPHPb8GxJNgFc4TqLxy7G1K2k7RZljJAZxHzK9ZEmuWFY8rWNaUwxcOgE1zoRxvzRlnd1Kp/gA8FYXBogQ+wD6Ot1udQ6+Ax1/t19Iu+DlfXwRhjZlJNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078952; c=relaxed/simple;
	bh=uSuzR4ZIRRHk3NuI6DTHrLhOvLcovi83ONMhw+IfWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnQ6mEUuvycTcPzvLNKaCtP++3n19X6aeeBA7qWUhQY9Eo67Iv5TtWLxL67WhOjcdx6Jq9AP76RBrjJVnkc/KbPcgfuVwX2KbbqIUkdNBJsr8OgXqntkgsJjxELN8vUyOTPjdACecm4vUdaKtOft8pyoQZgxAbWPVQXkHrxe1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmC/2lOF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728078951; x=1759614951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSuzR4ZIRRHk3NuI6DTHrLhOvLcovi83ONMhw+IfWHk=;
  b=HmC/2lOF6obBCf4b4ltc8XtDMC5s47ewpDSYhGxRUd/xs3945Ywd7Ry9
   hiQHi3sz3wJrucXJxds3to1iKUkI8I25BZdsXaV41vMJKJrGNZBKcrjpU
   BLiwAqvTzyrlzYqQ6deo3oQqH+DmUzp7pC7EK9QFvXNEDWEK/tT24NRA3
   6Ru32M9UhVIRY+l/Gybz4FfBUkLBQDiGjMRuhATYhF6kKdgf42P44dLux
   qAQH0OSm+I7443q1ZaPspEwXtMoiaKjUqLcNX1SUC4ErwDguGxGtDvW70
   8Fh0u6LkHNacx9pJdTdKySDA6MS+V3FIZs2T6shXq8F+6jx/34WnRbZkd
   g==;
X-CSE-ConnectionGUID: XIN/bIDwR8KZiZ27wVxUJg==
X-CSE-MsgGUID: N/nZC+mjQlGzp67TeJ7N0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27199067"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27199067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:55:50 -0700
X-CSE-ConnectionGUID: o7dHfJ4SSpCm7Zsz4y/uEw==
X-CSE-MsgGUID: nBAnNaC+RVucgGwkxbb4fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="98145790"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Oct 2024 14:55:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swqGz-0002G6-05;
	Fri, 04 Oct 2024 21:55:41 +0000
Date: Sat, 5 Oct 2024 05:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
Message-ID: <202410050518.LFXqJEpd-lkp@intel.com>
References: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core kvm/queue linus/master v6.12-rc1 next-20241004]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-Move-hv_connection_id-to-hyperv-tlfs-h/20241004-035418
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/1727985064-18362-6-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410050518.LFXqJEpd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050518.LFXqJEpd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050518.LFXqJEpd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/hyperv/hv_init.c:428:19: error: invalid application of 'sizeof' to an incomplete type 'struct hv_get_vp_registers_input'
     428 |         memset(input, 0, struct_size(input, element, 1));
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:372:9: note: expanded from macro 'struct_size'
     372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                       ^
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
     513 |                 __struct_size(p), __member_size(p))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
>> arch/x86/hyperv/hv_init.c:428:19: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     428 |         memset(input, 0, struct_size(input, element, 1));
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:372:18: note: expanded from macro 'struct_size'
     372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:356:24: note: expanded from macro 'flex_array_size'
     356 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                      ^
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
     513 |                 __struct_size(p), __member_size(p))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
>> arch/x86/hyperv/hv_init.c:428:19: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     428 |         memset(input, 0, struct_size(input, element, 1));
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:372:18: note: expanded from macro 'struct_size'
     372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:356:55: note: expanded from macro 'flex_array_size'
     356 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                     ^
   include/linux/compiler.h:243:59: note: expanded from macro '__must_be_array'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
     513 |                 __struct_size(p), __member_size(p))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
>> arch/x86/hyperv/hv_init.c:428:19: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     428 |         memset(input, 0, struct_size(input, element, 1));
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:372:18: note: expanded from macro 'struct_size'
     372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:357:30: note: expanded from macro 'flex_array_size'
     357 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                            ^
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
     513 |                 __struct_size(p), __member_size(p))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
>> arch/x86/hyperv/hv_init.c:428:19: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     428 |         memset(input, 0, struct_size(input, element, 1));
         |         ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:372:18: note: expanded from macro 'struct_size'
     372 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^
   include/linux/overflow.h:357:61: note: expanded from macro 'flex_array_size'
     357 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                           ^
   include/linux/compiler.h:243:59: note: expanded from macro '__must_be_array'
     243 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                                ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
     513 |                 __struct_size(p), __member_size(p))
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
   arch/x86/hyperv/hv_init.c:429:7: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     429 |         input->header.partitionid = HV_PARTITION_ID_SELF;
         |         ~~~~~^
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
   arch/x86/hyperv/hv_init.c:430:7: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     430 |         input->header.vpindex = HV_VP_INDEX_SELF;
         |         ~~~~~^
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
   arch/x86/hyperv/hv_init.c:431:7: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     431 |         input->header.inputvtl = 0;
         |         ~~~~~^
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
   arch/x86/hyperv/hv_init.c:432:7: error: incomplete definition of type 'struct hv_get_vp_registers_input'
     432 |         input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
         |         ~~~~~^
   arch/x86/hyperv/hv_init.c:419:9: note: forward declaration of 'struct hv_get_vp_registers_input'
     419 |         struct hv_get_vp_registers_input *input;
         |                ^
>> arch/x86/hyperv/hv_init.c:436:15: error: incomplete definition of type 'struct hv_get_vp_registers_output'
     436 |                 ret = output->as64.low & HV_X64_VTL_MASK;
         |                       ~~~~~~^
   arch/x86/hyperv/hv_init.c:420:9: note: forward declaration of 'struct hv_get_vp_registers_output'
     420 |         struct hv_get_vp_registers_output *output;
         |                ^
   10 errors generated.
--
>> arch/x86/hyperv/hv_vtl.c:154:27: error: use of undeclared identifier 'HVCALL_ENABLE_VP_VTL'
     154 |         status = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL);
         |                                  ^
>> arch/x86/hyperv/hv_vtl.c:189:25: error: invalid application of 'sizeof' to an incomplete type 'struct hv_get_vp_from_apic_id_in'
     189 |         memset(input, 0, sizeof(*input));
         |                                ^~~~~~~~
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                                                    ^
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   arch/x86/hyperv/hv_vtl.c:183:9: note: forward declaration of 'struct hv_get_vp_from_apic_id_in'
     183 |         struct hv_get_vp_from_apic_id_in *input;
         |                ^
>> arch/x86/hyperv/hv_vtl.c:190:7: error: incomplete definition of type 'struct hv_get_vp_from_apic_id_in'
     190 |         input->partition_id = HV_PARTITION_ID_SELF;
         |         ~~~~~^
   arch/x86/hyperv/hv_vtl.c:183:9: note: forward declaration of 'struct hv_get_vp_from_apic_id_in'
     183 |         struct hv_get_vp_from_apic_id_in *input;
         |                ^
   arch/x86/hyperv/hv_vtl.c:191:7: error: incomplete definition of type 'struct hv_get_vp_from_apic_id_in'
     191 |         input->apic_ids[0] = apic_id;
         |         ~~~~~^
   arch/x86/hyperv/hv_vtl.c:183:9: note: forward declaration of 'struct hv_get_vp_from_apic_id_in'
     183 |         struct hv_get_vp_from_apic_id_in *input;
         |                ^
>> arch/x86/hyperv/hv_vtl.c:195:38: error: use of undeclared identifier 'HVCALL_GET_VP_ID_FROM_APIC_ID'
     195 |         control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
         |                                             ^
   5 errors generated.


vim +428 arch/x86/hyperv/hv_init.c

99a0f46af6a771 Wei Liu        2021-02-03  414  
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  415  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
8387ce06d70bbb Tianyu Lan     2023-08-18  416  static u8 __init get_vtl(void)
8387ce06d70bbb Tianyu Lan     2023-08-18  417  {
8387ce06d70bbb Tianyu Lan     2023-08-18  418  	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
8387ce06d70bbb Tianyu Lan     2023-08-18 @419  	struct hv_get_vp_registers_input *input;
8387ce06d70bbb Tianyu Lan     2023-08-18  420  	struct hv_get_vp_registers_output *output;
8387ce06d70bbb Tianyu Lan     2023-08-18  421  	unsigned long flags;
8387ce06d70bbb Tianyu Lan     2023-08-18  422  	u64 ret;
8387ce06d70bbb Tianyu Lan     2023-08-18  423  
8387ce06d70bbb Tianyu Lan     2023-08-18  424  	local_irq_save(flags);
8387ce06d70bbb Tianyu Lan     2023-08-18  425  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
8387ce06d70bbb Tianyu Lan     2023-08-18  426  	output = (struct hv_get_vp_registers_output *)input;
8387ce06d70bbb Tianyu Lan     2023-08-18  427  
8387ce06d70bbb Tianyu Lan     2023-08-18 @428  	memset(input, 0, struct_size(input, element, 1));
8387ce06d70bbb Tianyu Lan     2023-08-18  429  	input->header.partitionid = HV_PARTITION_ID_SELF;
8387ce06d70bbb Tianyu Lan     2023-08-18  430  	input->header.vpindex = HV_VP_INDEX_SELF;
8387ce06d70bbb Tianyu Lan     2023-08-18  431  	input->header.inputvtl = 0;
8387ce06d70bbb Tianyu Lan     2023-08-18  432  	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
8387ce06d70bbb Tianyu Lan     2023-08-18  433  
8387ce06d70bbb Tianyu Lan     2023-08-18  434  	ret = hv_do_hypercall(control, input, output);
8387ce06d70bbb Tianyu Lan     2023-08-18  435  	if (hv_result_success(ret)) {
8387ce06d70bbb Tianyu Lan     2023-08-18 @436  		ret = output->as64.low & HV_X64_VTL_MASK;
8387ce06d70bbb Tianyu Lan     2023-08-18  437  	} else {
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  438  		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  439  		BUG();
8387ce06d70bbb Tianyu Lan     2023-08-18  440  	}
8387ce06d70bbb Tianyu Lan     2023-08-18  441  
8387ce06d70bbb Tianyu Lan     2023-08-18  442  	local_irq_restore(flags);
8387ce06d70bbb Tianyu Lan     2023-08-18  443  	return ret;
8387ce06d70bbb Tianyu Lan     2023-08-18  444  }
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  445  #else
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  446  static inline u8 get_vtl(void) { return 0; }
f2a55d08d7e1a5 Saurabh Sengar 2023-09-19  447  #endif
8387ce06d70bbb Tianyu Lan     2023-08-18  448  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

