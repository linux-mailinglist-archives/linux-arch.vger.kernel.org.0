Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9385BBC52
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIRHi2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRHi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 03:38:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06212528B;
        Sun, 18 Sep 2022 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663486706; x=1695022706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsB3/ShV3FI/8cLSVqJ3Gx16WtcHCb1HN64rmJh99OI=;
  b=Gi+vFt0mDT/J7s+WYniTjvwWPgAmvcBbjNYUojV1NLvYHPQ0pjQZMKHo
   sJDGsS/tuTqrFrQXFpUunkd+LqCf79aTE5gC2uTyaR1N3FXMkD9NLICsl
   ISsLWX0Id7M0XWg/+n6iMs3mijwuILiG6Mkon81oB/tZemSTvogsphgR3
   uH2LwJI92Fywh3Qpiu7Hg6Z9vDsIkheExRa2iqP/KwxsP5NI7nSJHsXit
   90tdHx/naZTSPpu52krh/kiaUf0HXADzF7Ek5aimHp+7B6Bsl8yGBzphf
   N86t0iWpnPcddIpUieJgBChcX17hYgSZqtAQNghnMD3fY5yhTkDD8LBB/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="360950241"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="360950241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 00:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="651315171"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Sep 2022 00:38:22 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZosf-00010J-1x;
        Sun, 18 Sep 2022 07:38:21 +0000
Date:   Sun, 18 Sep 2022 15:38:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3] LoongArch: Add ACPI-based generic laptop driver
Message-ID: <202209181507.gIRt7LRP-lkp@intel.com>
References: <20220917065250.1671718-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917065250.1671718-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Add-ACPI-based-generic-laptop-driver/20220917-145525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20220918/202209181507.gIRt7LRP-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3ebe2785d58311650d0f98635c9817e0c2c12f91
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Add-ACPI-based-generic-laptop-driver/20220917-145525
        git checkout 3ebe2785d58311650d0f98635c9817e0c2c12f91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/platform/loongarch/generic-laptop.o: in function `.L133':
>> generic-laptop.c:(.init.text+0x40c): undefined reference to `acpi_video_get_backlight_type'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
