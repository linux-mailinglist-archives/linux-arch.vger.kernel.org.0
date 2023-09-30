Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B87B3D76
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 04:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjI3CB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 22:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3CB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 22:01:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760821B2;
        Fri, 29 Sep 2023 19:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696039286; x=1727575286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GekbOuakCUNDQg4GF3MQMTe2CD00Lneso8LnNx1IsE8=;
  b=jw+hoQ7LeavJfs7xcKJzi9ZWnEL8kNkstw5jRWyXY5tEvwfVmlA9reSD
   AFuD6/Zn7VBWT3wnlk4ExAsYVznygrDJjLd+gqgcDreZYHFS0N73EuNnD
   hBEx0N4l5oztcCfJeIdvDxPOQAd2ocPvHvhsofy/9/QXrk9VxG+hsDdRo
   rR89ygybKmFbUY2B+PXKT06s9M7CVxlRPEjb9uc/on0RyJ2G8y70pyHN9
   VNUkRfoWG5Rs5wW0XyLpQLOsyNl+0rinuYvjIW9Mnn/0SpSTUnP+1YZHO
   VQBriFvo9JLP2Qghfd8pbQMeLdPTcgMP7HqRpUi4xQ+gmGCAF+NyAcUox
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468694576"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="468694576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 19:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743598288"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="743598288"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Sep 2023 19:01:24 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmPIH-0003YZ-2H;
        Sat, 30 Sep 2023 02:01:21 +0000
Date:   Sat, 30 Sep 2023 10:00:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     KaiLong Wang <wangkailong@jari.cn>, arnd@arndb.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: Clean up errors in vmlinux.lds.h
Message-ID: <202309300906.QmMaoccp-lkp@intel.com>
References: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e80688.8a8.18ad9bba905.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi KaiLong,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on soc/for-next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KaiLong-Wang/vmlinux-lds-h-Clean-up-errors-in-vmlinux-lds-h/20230928-110313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/72e80688.8a8.18ad9bba905.Coremail.wangkailong%40jari.cn
patch subject: [PATCH] vmlinux.lds.h: Clean up errors in vmlinux.lds.h
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20230930/202309300906.QmMaoccp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300906.QmMaoccp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300906.QmMaoccp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld:./arch/arm/kernel/vmlinux.lds:20: syntax error

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
