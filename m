Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0D67C860
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjAZKTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 05:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjAZKTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 05:19:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6356ED8;
        Thu, 26 Jan 2023 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674728338; x=1706264338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j918tRzb4uv1IVnsabUGaQ7U+M9E1AkP9bvd8fDGFKY=;
  b=No7Yg5Iv1u8FKg7xAe6xqT9zxPXKan+/2GMyjC5fl11LsxNWhUL7YlED
   Wf256cF2cE8k6BuqJJJh+eyulZe0JU4BCeiv2qVNo02ViQ7eeItkJBaGx
   puagqL7o9wKdAdkpq2CxQABr3Eb5sj7C3r7TyOKHLr5atNUj/CSWutDM6
   U+cnQiO7XNAh0qSteXRseZLJiCYloKmjOfBnE5Jubbegu5hwcg/JmMtpr
   htnPjOFdQ+bdh6k3K8PbdwfTbldna6VAFSxbd7jxL0Hrh7MSMzcrf21KW
   x/GRi3sz2HlXlMriv8rdjN7yj5gwvlJnXM9zWWWGrAYgCwvDTdaGy/0ih
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326810702"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="326810702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 02:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="695039001"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="695039001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 02:17:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKzK1-00FKvq-0w;
        Thu, 26 Jan 2023 12:17:33 +0200
Date:   Thu, 26 Jan 2023 12:17:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Message-ID: <Y9JTPAL7VDXNPy5h@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <05d32a58-c119-4abb-8e62-9d79bd95324f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05d32a58-c119-4abb-8e62-9d79bd95324f@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 09:40:18AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 09:14, Christophe Leroy wrote:
> > Le 25/01/2023 à 21:10, Andy Shevchenko a écrit :
> >> From: Pierluigi Passaro <pierluigi.p@variscite.com>
> >> 
> >> Both the functions gpiochip_request_own_desc and
> >> gpiochip_free_own_desc are exported from
> >>      drivers/gpio/gpiolib.c
> >> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> >> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
> >> reasonable definitions and includes in the "#else" branch.
> >
> > Can you give more details on when and why link fails ?
> >
> > You are adding a WARN(), I understand it mean the function should never 
> > ever be called. Shouldn't it be dropped completely by the compiler ? In 
> > that case, no call to gpiochip_request_own_desc() should be emitted and 
> > so link should be ok.
> >
> > If link fails, it means we still have unexpected calls to 
> > gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we should 
> > fix the root cause instead of hiding it with a WARN().
> 
> There are only a handful of files calling these functions:
> 
> $ git grep -l gpiochip_request_own_desc
> Documentation/driver-api/gpio/driver.rst
> arch/arm/mach-omap1/ams-delta-fiq.c
> arch/arm/mach-omap1/board-ams-delta.c
> drivers/gpio/gpio-mvebu.c
> drivers/gpio/gpiolib-acpi.c
> drivers/gpio/gpiolib.c
> drivers/hid/hid-cp2112.c
> drivers/memory/omap-gpmc.c
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> drivers/power/supply/collie_battery.c
> drivers/spi/spi-bcm2835.c
> include/linux/gpio/driver.h
> 
> All of these should already prevent the link failure through
> a Kconfig 'depends on GPIOLIB' for the driver, or 'select GPIOLIB'
> for the platform code. I checked all of the above and they seem fine.
> If anything else calls the function, I'd add the same dependency
> there.

So, you think it's worth to send a few separate fixes as adding that
dependency? But doesn't it feel like a papering over the issue with
that APIs used in some of the drivers in the first place?

-- 
With Best Regards,
Andy Shevchenko


