Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132067378F4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 04:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFUCP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 22:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUCPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 22:15:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B51989;
        Tue, 20 Jun 2023 19:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687313755; x=1718849755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6m8oZcodhtix0QwhxR/xmxGRXoNB5c0KxxyIl1Y1I6M=;
  b=HIZVnunCgibxfr0aDSLwDwILMB3r7PBEJnTZlNUSSZYzAU8qdOj/aFiU
   lrCplSfC07N/LAiYZ4LgYeeyZez7tZWpmvfeR6egCowGqgRbe4sIENNh6
   U/lVx7QaurWWGuW/+EqMZmGrWqrKu6Q30N11tdcSvCdPumWu1vrA5v6Bu
   JN75E2JGxejYEespY5e/pnlsuWsOPZv+fqGIEx+7M5yiJ7P6mHQ53zp4D
   14VNa1c6gyIQZOy/SVgvLN/7k3iCMqQmsB1Mf6S5wHFvJJsxhV+1HmyTS
   fmW3v17TIsJewrOWHh71BjQjiq2fJZTZpG3QXfDsG2N2pEdLvPd74aohk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362581732"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="362581732"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858802795"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="858802795"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2023 19:15:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBnNt-0006Ro-2C;
        Wed, 21 Jun 2023 02:15:49 +0000
Date:   Wed, 21 Jun 2023 10:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Baoquan He <bhe@redhat.com>, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <202306211030.DioMEPhl-lkp@intel.com>
References: <20230620131356.25440-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620131356.25440-3-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230620131356.25440-3-bhe%40redhat.com
patch subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211030.DioMEPhl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
