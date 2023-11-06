Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3727E2066
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFLwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFLwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 06:52:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9986DB;
        Mon,  6 Nov 2023 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699271525; x=1730807525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GNjbmEJtZrouroHCNxWmbCT6s2EU3n4xNfku+20/b0=;
  b=UW42S7Pv+4mnp97vTSMqBcHIwj2ZxfKR8Nrb7gCOWN/KkYU2gnqcvaLV
   GYWn6fIF73GZhGaXiKnJdKb8wAE8RjkvY2lFMebfWAkoevl2anHt2Vqu+
   whSv9BNyVfpLgJTwvbRqdeHWy31rBxt7B+67GFkQtBjXCwTpAFuTS1Uim
   xaUrznyKM6sm3KstHd5Auc4sQgNxqIZOPVAWmdQwkzpvqmA5OF3ykMY/5
   5OsYV8QECD1DPklZi7aZvcn5cixaqNA0Jl80suY/lK+Jqbk4nljLAFqCW
   BDiGzFXviazKJrZlCnn/XMu0RdvEtNXMYk6PaYwM4MdzvkKFLzfpscsye
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="475494043"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="475494043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="852981472"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="852981472"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2023 03:51:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzy97-0006NJ-1u;
        Mon, 06 Nov 2023 11:51:57 +0000
Date:   Mon, 6 Nov 2023 19:51:14 +0800
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
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <202311061950.zy9qRyzo-lkp@intel.com>
References: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on tip/x86/core arm64/for-next/core linus/master v6.6 next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-tlfs-Change-shared-HV_REGISTER_-defines-to-HV_MSR_/20230930-041305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1696010501-24584-16-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to VMMs running on Hyper-V
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311061950.zy9qRyzo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061950.zy9qRyzo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061950.zy9qRyzo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/mshv_vtl_main.c:25:10: fatal error: ../../../kernel/fpu/legacy.h: No such file or directory
      25 | #include "../../../kernel/fpu/legacy.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +25 drivers/hv/mshv_vtl_main.c

    24	
  > 25	#include "../../../kernel/fpu/legacy.h"
    26	#include "mshv.h"
    27	#include "mshv_vtl.h"
    28	#include "hyperv_vmbus.h"
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
