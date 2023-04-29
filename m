Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327E6F2363
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjD2GfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Apr 2023 02:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjD2GfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Apr 2023 02:35:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D92680;
        Fri, 28 Apr 2023 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682750102; x=1714286102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QMrfHmB3IlGnj2ZKNRmcbudyqMRVvUMmyJ4H/dCOm0=;
  b=f39fxwnzm6PxjhwmkJZfk0Fy3FPqazCQ6maOZKiFkvpY8Dm+4r58Bkns
   uYx7NOlJ5n0IwhH3a0MgysHZRRT2oLbf6aFo/durtAYCn2wG7WN7V/i5E
   GyZrvDtUp8gQQsUfAUoe/e6X85T1l7EZlhtu4POqGtMJcVJbX798jhHBg
   eAlCf2QYpnBnXZoAuXbpnFWUaVXQCGcVXnvjMH/HZdAHdk2au1ZlVrgFc
   lxDldVxiRuCSe7OAM/50hmDU1mStBoj3kR0Su/ryN+v2Qr0ovLHGg/EEZ
   bjM+8aK7uFOkNPJxegOsN4Auge6kraZ22M1G6BRBIs/U8h3IkQTtHCIjh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328254570"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="328254570"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 23:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="1024923249"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="1024923249"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2023 23:34:56 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pseAZ-0000xX-1N;
        Sat, 29 Apr 2023 06:34:55 +0000
Date:   Sat, 29 Apr 2023 14:34:39 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: Re: [PATCH v2 4/7] virt: geniezone: Add vcpu support
Message-ID: <202304291412.EiKEO9uy-lkp@intel.com>
References: <20230428103622.18291-5-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428103622.18291-5-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yi-De,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on robh/for-next arnd-asm-generic/master linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230428-183738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230428103622.18291-5-yi-de.wu%40mediatek.com
patch subject: [PATCH v2 4/7] virt: geniezone: Add vcpu support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230429/202304291412.EiKEO9uy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d4ced06ba2f149b099e9bf745a0e451c43e9d823
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230428-183738
        git checkout d4ced06ba2f149b099e9bf745a0e451c43e9d823
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304291412.EiKEO9uy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/geniezone/../../../drivers/virt/geniezone/gzvm_vcpu.c:145:6: warning: no previous prototype for 'gzvm_destroy_vcpu' [-Wmissing-prototypes]
     145 | void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
         |      ^~~~~~~~~~~~~~~~~


vim +/gzvm_destroy_vcpu +145 arch/arm64/geniezone/../../../drivers/virt/geniezone/gzvm_vcpu.c

   143	
   144	/* caller must hold the vm lock */
 > 145	void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
   146	{
   147		if (!vcpu)
   148			return;
   149	
   150		gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
   151		/* clean guest's data */
   152		memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
   153		free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
   154		kfree(vcpu);
   155	}
   156	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
