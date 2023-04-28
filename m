Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87B6F1DA6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjD1Rxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjD1Rxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 13:53:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155153C1E;
        Fri, 28 Apr 2023 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682704427; x=1714240427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aRx7+mpDK8aR3HdTkR8Ocvm6w1M4ROBM1nP0BJX1Q1U=;
  b=cxDfTD8UPJVQpc41IkSLZthX5SKrCss4/k48m+erTyhK/YjgBmJI+4YG
   oWWp9lEsZ8HgrfbMW2K30BaGXyb18AP98s69hYV8QzMs/+OhdzJN598lO
   23yb4LejbT+WieooB25rdjgbnchGsZnOMJLYWDnv4v4vK5XIrej2hT/Bp
   6U+JsotFNjYQqPMOgvMbc5HDVWaX/I4qmHFRkW1Q+KyjvQLEMx9vXt3tZ
   PvtO3q697AJCcwwVBkmylVA4upvu0zWHvwAN69SZNE0ocmuhxslfWi5hH
   oiipUSuXQ5Mtfg4FwYoIi49SjBidLXeb/l2orGp+EdUw3yph6esuWfKRF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349839385"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349839385"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 10:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="688899459"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="688899459"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2023 10:53:40 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psSHr-0000aR-0S;
        Fri, 28 Apr 2023 17:53:39 +0000
Date:   Sat, 29 Apr 2023 01:53:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor
 support
Message-ID: <202304290120.5Ad0n6XR-lkp@intel.com>
References: <20230428103622.18291-4-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428103622.18291-4-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yi-De,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on robh/for-next arnd-asm-generic/master linus/master v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230428-183738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230428103622.18291-4-yi-de.wu%40mediatek.com
patch subject: [PATCH v2 3/7] virt: geniezone: Introduce GenieZone hypervisor support
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20230429/202304290120.5Ad0n6XR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0e3f05a6e4547eb309032d047115a47d8f59641d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230428-183738
        git checkout 0e3f05a6e4547eb309032d047115a47d8f59641d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304290120.5Ad0n6XR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> usr/include/linux/gzvm.h:15: included file 'asm-x86/gzvm_arch.h' is not exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
