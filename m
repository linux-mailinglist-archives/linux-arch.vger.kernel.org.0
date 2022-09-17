Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4E5BB87E
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIQN2F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQN2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 09:28:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7F2FFC8;
        Sat, 17 Sep 2022 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663421282; x=1694957282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CSL533kR23JDzUm+vKap9vYJ0ROzMIpkpCKbvuqvSsk=;
  b=gWwSm8qwUHZTK0f1Yzo1kjU8QHyj3i6q7YYkAjkiUvISKqrdiIXMwiyM
   3gBLRVsI2C/tXaLHY6eybld8JDiARX7taNPmF2WRoF5TIomv4sTQBUxWt
   PBcYHSmfwuzSQ/3s9kx4ckqd0ddXppNhgoTW9gGSfYUil7mld7dJ9T0FZ
   aXAwqS661REBXQe4MSzEIgGvCVGXTDo9SQtzzyyRhabAvfTQUk7JJc3Hc
   SK3ffR3yLKziJyH/bFlaonPwp/EUHSRr0jTuClkZtAPtppFVyvOxD9Q/G
   CwdTKQL54v/PQIcxnCMkM615YYjsBeN2TEAGcQfm5ebB57rXxtQqQtRQR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="278881455"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="278881455"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 06:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="946683466"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2022 06:27:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZXrR-0000MJ-2P;
        Sat, 17 Sep 2022 13:27:57 +0000
Date:   Sat, 17 Sep 2022 21:27:23 +0800
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
Message-ID: <202209172111.ajQbMqwZ-lkp@intel.com>
References: <20220917065250.1671718-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917065250.1671718-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Add-ACPI-based-generic-laptop-driver/20220917-145525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-randconfig-r016-20220916 (https://download.01.org/0day-ci/archive/20220917/202209172111.ajQbMqwZ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/platform/loongarch/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/loongarch/generic-laptop.c:409:5: warning: no previous prototype for 'loongson_laptop_turn_on_backlight' [-Wmissing-prototypes]
     409 | int loongson_laptop_turn_on_backlight(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/loongarch/generic-laptop.c:425:5: warning: no previous prototype for 'loongson_laptop_turn_off_backlight' [-Wmissing-prototypes]
     425 | int loongson_laptop_turn_off_backlight(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/loongson_laptop_turn_on_backlight +409 drivers/platform/loongarch/generic-laptop.c

   408	
 > 409	int loongson_laptop_turn_on_backlight(void)
   410	{
   411		int status;
   412		union acpi_object arg0 = { ACPI_TYPE_INTEGER };
   413		struct acpi_object_list args = { 1, &arg0 };
   414	
   415		arg0.integer.value = 1;
   416		status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
   417		if (ACPI_FAILURE(status)) {
   418			pr_info("Loongson lvds error: 0x%x\n", status);
   419			return -ENODEV;
   420		}
   421	
   422		return 0;
   423	}
   424	
 > 425	int loongson_laptop_turn_off_backlight(void)
   426	{
   427		int status;
   428		union acpi_object arg0 = { ACPI_TYPE_INTEGER };
   429		struct acpi_object_list args = { 1, &arg0 };
   430	
   431		arg0.integer.value = 0;
   432		status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
   433		if (ACPI_FAILURE(status)) {
   434			pr_info("Loongson lvds error: 0x%x\n", status);
   435			return -ENODEV;
   436		}
   437	
   438		return 0;
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
