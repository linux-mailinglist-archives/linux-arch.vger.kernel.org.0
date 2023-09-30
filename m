Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E527B401C
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjI3L1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3L1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 07:27:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BAECA;
        Sat, 30 Sep 2023 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696073271; x=1727609271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uL+N1pJNzEJQPyW2JWtFPyNjmNId4HAagDTl+PkZMhc=;
  b=CMNMgx/+cLVhyvQUtg1tFhTgiVCG0fZKzv4amCTzbub0j+gf8jqArud1
   klDnHTyVw+AX2fqNVG2sS8Wsp5WBQrkrpzSPyCLCHaZeItKk8fDWzSd6Z
   ZkfMppEaLHtAFAtPso1TCL0Kx2LJWca8eTOTX3vwxmxtAd+4j73HQTXLB
   Cg2sp0zqSc+M5gdndiPJqV+hOZQyJPDq3jFfwcElB6MOFKsnge44tC4Ky
   XM4q4Mj0CQwTILq/n74wf5AyG4XhIJgu796pMQbM8TEJAesPbYO/rouG4
   ULo0gijfZLrY5EVaMFHeOjSG0vJT6n9W92U+UEZSiRHALyrhZ8L4BLONF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379722978"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="379722978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 04:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="873926489"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="873926489"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2023 04:27:43 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmY8L-00045R-03;
        Sat, 30 Sep 2023 11:27:41 +0000
Date:   Sat, 30 Sep 2023 19:26:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 08/15] Drivers: hv: Introduce per-cpu event ring tail
Message-ID: <202309301948.CyCE3Y0P-lkp@intel.com>
References: <1696010501-24584-9-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on arm64/for-next/core linus/master v6.6-rc3 next-20230929]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-tlfs-Change-shared-HV_REGISTER_-defines-to-HV_MSR_/20230930-041305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1696010501-24584-9-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v4 08/15] Drivers: hv: Introduce per-cpu event ring tail
config: x86_64-randconfig-123-20230930 (https://download.01.org/0day-ci/archive/20230930/202309301948.CyCE3Y0P-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301948.CyCE3Y0P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301948.CyCE3Y0P-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hv/hv_common.c:98:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got unsigned char [noderef] [usertype] __percpu **extern [addressable] [toplevel] hv_synic_eventring_tail @@
   drivers/hv/hv_common.c:98:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/hv/hv_common.c:98:21: sparse:     got unsigned char [noderef] [usertype] __percpu **extern [addressable] [toplevel] hv_synic_eventring_tail
>> drivers/hv/hv_common.c:349:41: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __percpu **extern [addressable] [assigned] [toplevel] hv_synic_eventring_tail @@     got unsigned char [usertype] *[noderef] __percpu * @@
   drivers/hv/hv_common.c:349:41: sparse:     expected unsigned char [noderef] [usertype] __percpu **extern [addressable] [assigned] [toplevel] hv_synic_eventring_tail
   drivers/hv/hv_common.c:349:41: sparse:     got unsigned char [usertype] *[noderef] __percpu *
>> drivers/hv/hv_common.c:399:55: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned char [noderef] [usertype] __percpu ** @@
   drivers/hv/hv_common.c:399:55: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/hv/hv_common.c:399:55: sparse:     got unsigned char [noderef] [usertype] __percpu **

vim +98 drivers/hv/hv_common.c

    74	
    75	/*
    76	 * Hyper-V specific initialization and shutdown code that is
    77	 * common across all architectures.  Called from architecture
    78	 * specific initialization functions.
    79	 */
    80	
    81	void __init hv_common_free(void)
    82	{
    83		unregister_sysctl_table(hv_ctl_table_hdr);
    84		hv_ctl_table_hdr = NULL;
    85	
    86		if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
    87			hv_kmsg_dump_unregister();
    88	
    89		kfree(hv_vp_index);
    90		hv_vp_index = NULL;
    91	
    92		free_percpu(hyperv_pcpu_output_arg);
    93		hyperv_pcpu_output_arg = NULL;
    94	
    95		free_percpu(hyperv_pcpu_input_arg);
    96		hyperv_pcpu_input_arg = NULL;
    97	
  > 98		free_percpu(hv_synic_eventring_tail);
    99		hv_synic_eventring_tail = NULL;
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
