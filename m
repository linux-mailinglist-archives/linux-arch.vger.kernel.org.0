Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E356B985
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiGHMRz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jul 2022 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiGHMRy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2022 08:17:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290124D151;
        Fri,  8 Jul 2022 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657282670; x=1688818670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8S0rzRQA2BUxiTwGUL7gX6AOqoRLNeIl8BEePutlzuI=;
  b=ODeL5SrFBXGxeSYbl7RRA68oK129r8BlzMKquZy6d0jhYp4S95DxjAui
   EfTXFQrpHg+8F01NMa9njxQabSURQXqcQUlkq418kcAbKX22rHojwXB8x
   aJ67L1HDaLC4nRpsLkrx7LC5WSx28k1zKOHyHhoubNIL9KfrBpqwRnP5+
   hkl1vGploog5lBzPha8lwrs9K5dye9GWhXtZnDeE3i/YAHXGaH7pVBnnV
   CoVjAOrDG2W+VrW33AIQPFl57BNEwoX3YpeOMBUqm3xLEBc447xVBPwqW
   yvijkBAaRsBfNMhuUsL6SWXo/lvKlJmew0gAczT6zLthRzB5/Z6tQqEQA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348252291"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="348252291"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 05:17:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="683644812"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 05:17:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o9mvU-00183D-2w;
        Fri, 08 Jul 2022 15:17:40 +0300
Date:   Fri, 8 Jul 2022 15:17:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Subject: Re: [bitops]  0e862838f2:
 BUG:KASAN:wild-memory-access_in_dmar_parse_one_rhsa
Message-ID: <YsggZNUQcsKIU9xU@smile.fi.intel.com>
References: <YsbpTNmDaam8pl+f@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsbpTNmDaam8pl+f@xsang-OptiPlex-9020>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 07, 2022 at 10:10:20PM +0800, kernel test robot wrote:
> 
> (please be noted we reported
> "[bitops]  001bea109d: BUG:KASAN:wild-memory-access_in_dmar_parse_one_rhsa"
> on
> https://lore.kernel.org/all/YrnGLtDXAveqXGok@xsang-OptiPlex-9020/
> now we noticed this commit has already been merged into linux-next/master,
> and the issue is still existing. report again FYI)
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 0e862838f290147ea9c16db852d8d494b552d38d ("bitops: unify non-atomic bitops prototypes across architectures")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: xfstests
> version: xfstests-x86_64-c1144bf-1_20220627
> with following parameters:
> 
> 	disk: 2pmem
> 	fs: ext4
> 	test: ext4-dax
> 	ucode: 0x700001c
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 48G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [ 4.668325][ T0] BUG: KASAN: wild-memory-access in dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497) 
> [    4.676149][    T0] Read of size 8 at addr 1fffffff85115558 by task swapper/0/0
> [    4.683454][    T0]
> [    4.685638][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc3-00004-g0e862838f290 #1
> [    4.694331][    T0] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [    4.703196][    T0] Call Trace:
> [    4.706334][    T0]  <TASK>
> [ 4.709133][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497) 
> [ 4.714272][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
> [ 4.718632][ T0] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493) 
> [ 4.722903][ T0] ? dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497) 
> [ 4.728042][ T0] kasan_check_range (mm/kasan/generic.c:190) 
> [ 4.732750][ T0] dmar_parse_one_rhsa (arch/x86/include/asm/bitops.h:214 arch/x86/include/asm/bitops.h:226 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/nodemask.h:415 drivers/iommu/intel/dmar.c:497) 
> [ 4.737715][ T0] dmar_walk_remapping_entries (drivers/iommu/intel/dmar.c:609) 
> [ 4.743375][ T0] parse_dmar_table (drivers/iommu/intel/dmar.c:671) 
> [ 4.748079][ T0] ? dmar_table_detect (drivers/iommu/intel/dmar.c:633) 
> [ 4.752872][ T0] ? dmar_free_dev_scope (drivers/iommu/intel/dmar.c:408) 
> [ 4.758010][ T0] ? init_dmars (drivers/iommu/intel/iommu.c:3359) 
> [ 4.762370][ T0] ? iommu_resume (drivers/iommu/intel/iommu.c:3419) 
> [ 4.766903][ T0] ? dmar_walk_dsm_resource+0x300/0x300 
> [ 4.772909][ T0] ? dmar_acpi_insert_dev_scope (drivers/iommu/intel/dmar.c:466) 
> [ 4.778655][ T0] ? dmar_check_one_atsr (drivers/iommu/intel/iommu.c:3521) 
> [ 4.783795][ T0] dmar_table_init (drivers/iommu/intel/dmar.c:846) 
> [ 4.788239][ T0] intel_prepare_irq_remapping (drivers/iommu/intel/irq_remapping.c:742) 
> [ 4.793811][ T0] irq_remapping_prepare (drivers/iommu/irq_remapping.c:102) 
> [ 4.798778][ T0] enable_IR_x2apic (arch/x86/kernel/apic/apic.c:1928) 
> [ 4.803395][ T0] default_setup_apic_routing (arch/x86/kernel/apic/probe_64.c:25 (discriminator 1)) 
> [ 4.808883][ T0] apic_intr_mode_init (arch/x86/kernel/apic/apic.c:1446) 
> [ 4.813761][ T0] x86_late_time_init (arch/x86/kernel/time.c:101) 
> [ 4.818467][ T0] start_kernel (init/main.c:1101) 
> [ 4.822827][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 

Seems like related to nodemask APIs.

-- 
With Best Regards,
Andy Shevchenko


