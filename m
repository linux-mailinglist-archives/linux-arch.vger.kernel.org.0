Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF35939A0
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiHOTZC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiHOTXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 15:23:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AE2E9D5;
        Mon, 15 Aug 2022 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660588843; x=1692124843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwR4es3LnXoymy7KB2tbTz0AcwsTWoHfR9MBghCZy/0=;
  b=Y6QCjG8nETmBmd7LcQnlsOsOarKz0Rb1zGMj7nihKnV7U/UzCETE0//+
   xzs9UN+c3+gV29N6zVeeRJPVa2hR4Qjm0ypGGkW3tbAIXPykBhDuNtE3P
   j6W0OsyhLsfCut865d69GCaWjZuB/tznVJTzADKmkWNIF6k+ts87arojv
   2GknRtQ6tQPYF/X3m02Qvf3beUnF6WykdeOI02B+re7zwCjCVmp6CpjNU
   T7gYee6dJG5pkh1TzcW4rZzZ8AhIf6DPVfdWD0NoQiE5vVX7s/odIu6UH
   ZdCX0Lcpay90aLmcVNFCYF8Kw+qcq6N10XYsIM1xhwcw7PC/7FppjN4w5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289601843"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="289601843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="639741479"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 11:40:38 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNf0w-0001An-0R;
        Mon, 15 Aug 2022 18:40:38 +0000
Date:   Tue, 16 Aug 2022 02:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 2/2] LoongArch: Add ACPI-based generic laptop driver
Message-ID: <202208160225.IH6Wo0jU-lkp@intel.com>
References: <20220815124803.3332991-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815124803.3332991-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Add-CPU-HWMon-platform-driver/20220815-205142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220816/202208160225.IH6Wo0jU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a1d11c660bcd67e4483546b5b59b6cbe5c2a882f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/LoongArch-Add-CPU-HWMon-platform-driver/20220815-205142
        git checkout a1d11c660bcd67e4483546b5b59b6cbe5c2a882f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/platform/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/loongarch/generic-laptop.c:443:5: warning: no previous prototype for 'ec_get_brightness' [-Wmissing-prototypes]
     443 | int ec_get_brightness(void)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/platform/loongarch/generic-laptop.c:460:5: warning: no previous prototype for 'ec_set_brightness' [-Wmissing-prototypes]
     460 | int ec_set_brightness(int level)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/platform/loongarch/generic-laptop.c:475:5: warning: no previous prototype for 'ec_backlight_level' [-Wmissing-prototypes]
     475 | int ec_backlight_level(u8 level)
         |     ^~~~~~~~~~~~~~~~~~
>> drivers/platform/loongarch/generic-laptop.c:546:5: warning: no previous prototype for 'turn_on_backlight' [-Wmissing-prototypes]
     546 | int turn_on_backlight(void)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/platform/loongarch/generic-laptop.c:562:5: warning: no previous prototype for 'turn_off_backlight' [-Wmissing-prototypes]
     562 | int turn_off_backlight(void)
         |     ^~~~~~~~~~~~~~~~~~


vim +/ec_get_brightness +443 drivers/platform/loongarch/generic-laptop.c

   442	
 > 443	int ec_get_brightness(void)
   444	{
   445		int status = 0;
   446	
   447		if (!hkey_handle)
   448			return -ENXIO;
   449	
   450		if (!acpi_evalf(hkey_handle, &status, "ECBG", "d"))
   451			return -EIO;
   452	
   453		if (status < 0)
   454			return status;
   455	
   456		return status;
   457	}
   458	EXPORT_SYMBOL(ec_get_brightness);
   459	
 > 460	int ec_set_brightness(int level)
   461	{
   462	
   463		int ret = 0;
   464	
   465		if (!hkey_handle)
   466			return -ENXIO;
   467	
   468		if (!acpi_evalf(hkey_handle, NULL, "ECBS", "vd", level))
   469			ret = -EIO;
   470	
   471		return ret;
   472	}
   473	EXPORT_SYMBOL(ec_set_brightness);
   474	
 > 475	int ec_backlight_level(u8 level)
   476	{
   477		int status = 0;
   478	
   479		if (!hkey_handle)
   480			return -ENXIO;
   481	
   482		if (!acpi_evalf(hkey_handle, &status, "ECLL", "d"))
   483			return -EIO;
   484	
   485		if ((status < 0) || (level > status))
   486			return status;
   487	
   488		if (!acpi_evalf(hkey_handle, &status, "ECSL", "d"))
   489			return -EIO;
   490	
   491		if ((status < 0) || (level < status))
   492			return status;
   493	
   494		return level;
   495	}
   496	EXPORT_SYMBOL(ec_backlight_level);
   497	
   498	static int loongson_laptop_backlight_update(struct backlight_device *bd)
   499	{
   500		int lvl = ec_backlight_level(bd->props.brightness);
   501	
   502		if (lvl < 0)
   503			return -EIO;
   504		if (ec_set_brightness(lvl))
   505			return -EIO;
   506	
   507		return 0;
   508	}
   509	
   510	static int loongson_laptop_get_brightness(struct backlight_device *bd)
   511	{
   512		u8 level;
   513	
   514		level = ec_get_brightness();
   515		if (level < 0)
   516			return -EIO;
   517	
   518		return level;
   519	}
   520	
   521	static const struct backlight_ops backlight_laptop_ops = {
   522		.update_status = loongson_laptop_backlight_update,
   523		.get_brightness = loongson_laptop_get_brightness,
   524	};
   525	
   526	static int laptop_backlight_register(void)
   527	{
   528		int status = 0;
   529		struct backlight_properties props;
   530	
   531		memset(&props, 0, sizeof(props));
   532		props.type = BACKLIGHT_PLATFORM;
   533	
   534		if (!acpi_evalf(hkey_handle, &status, "ECLL", "d"))
   535			return -EIO;
   536	
   537		props.brightness = 1;
   538		props.max_brightness = status;
   539	
   540		backlight_device_register("loongson_laptop",
   541					NULL, NULL, &backlight_laptop_ops, &props);
   542	
   543		return 0;
   544	}
   545	
 > 546	int turn_on_backlight(void)
   547	{
   548		int status;
   549		union acpi_object arg0 = { ACPI_TYPE_INTEGER };
   550		struct acpi_object_list args = { 1, &arg0 };
   551	
   552		arg0.integer.value = 1;
   553		status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
   554		if (ACPI_FAILURE(status)) {
   555			pr_info("Loongson lvds error: 0x%x\n", status);
   556			return -ENODEV;
   557		}
   558	
   559		return 0;
   560	}
   561	
 > 562	int turn_off_backlight(void)
   563	{
   564		int status;
   565		union acpi_object arg0 = { ACPI_TYPE_INTEGER };
   566		struct acpi_object_list args = { 1, &arg0 };
   567	
   568		arg0.integer.value = 0;
   569		status = acpi_evaluate_object(NULL, "\\BLSW", &args, NULL);
   570		if (ACPI_FAILURE(status)) {
   571			pr_info("Loongson lvds error: 0x%x\n", status);
   572			return -ENODEV;
   573		}
   574	
   575		return 0;
   576	}
   577	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
