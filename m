Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C37D8BDA
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjJZWww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJZWwv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 18:52:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB31AB;
        Thu, 26 Oct 2023 15:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698360769; x=1729896769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DibA2OwE41Z1sW1cSL7fP09Xo0QOr8th32q8AiyDesY=;
  b=IjuLbUNwLzj+DbV5YkiHvcthr83srf02idP95pJGFoBd0493cXdJr1cf
   O72v7lALS4vfaOkV5poemneRrcQYlMnfBqbaPoKn7xa/g/jm6zASimTtK
   ZQtqMuuhd3bTSufPeITVO2AO5KtiwJRb/9fiFhtfqGbz23uMkrwIQukkQ
   +BlbwSgpzx7nXE6ZOXltICfL0S9fPKkCWcIqeavsJs9C+xpCqE6ZC1Nup
   OI+dgVeTD2dloTACkwyRf1nU22p2YLWYPuSIuWyxwForszLG7wPIaQdW2
   4FV94mGyF3xklGePc/8hkDNEYdQBRwoEjltIZC+jBfWHO4aKO8CS/pyfS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="454130274"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="454130274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825145803"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825145803"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2023 15:52:46 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw9DY-000ACN-1I;
        Thu, 26 Oct 2023 22:52:44 +0000
Date:   Fri, 27 Oct 2023 06:52:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH v2 1/1] kernel/config: Introduce
 CONFIG_DEBUG_INFO_IKCONFIG
Message-ID: <202310270605.GjEqZtAA-lkp@intel.com>
References: <20231025223640.1132047-2-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025223640.1132047-2-stephen.s.brennan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stephen,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on arnd-asm-generic/master linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/kernel-config-Introduce-CONFIG_DEBUG_INFO_IKCONFIG/20231026-063844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231025223640.1132047-2-stephen.s.brennan%40oracle.com
patch subject: [PATCH v2 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231027/202310270605.GjEqZtAA-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270605.GjEqZtAA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270605.GjEqZtAA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/configs-debug.S: Assembler messages:
>> kernel/configs-debug.S:17: Error: file not found: kernel/config_data.gz


vim +17 kernel/configs-debug.S

  > 17		.incbin "kernel/config_data.gz"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
