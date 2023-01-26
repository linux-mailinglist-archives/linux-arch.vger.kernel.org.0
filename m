Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C864467C865
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 11:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjAZKUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 05:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbjAZKUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 05:20:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616B3400F;
        Thu, 26 Jan 2023 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674728397; x=1706264397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VuLpeZj3JRX50JPwSTzWHECxvKb10QjlsCDwYt61HpM=;
  b=AU70xossVgUqPfw7F6ZPOpo+4BPYElAPO9BUbeXJ+dqDwQSqn9z4W4cM
   2uG5ODJvbg9TuTYkvXZgn+ve0gPnt/D4DpN7ILrruZMU0Lt9RTno/kNtj
   /OJvQvvMzBdRRSYZhctRYi8oedKc+ZAkHJx/iYHn+EjOXJ45CzykiwPQC
   3nZOUaz1iwNnNofx02hjBjscZNZgb3rOQ94vfuKzjASlDmc5CPRJjrv7x
   QV8+upXkPSIO/iP2X5CcVW6k8Bhwv2fqKhNUSzonQ2AhBcHjeMRLznLBl
   UAHBbBGMEDe/oJpkEYOBaE4et2/cqrVDbxZjfGwXR92DMozHku/C2cJq8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326811082"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="326811082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 02:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="695040120"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="695040120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 02:19:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKzLf-00FKxS-1p;
        Thu, 26 Jan 2023 12:19:15 +0200
Date:   Thu, 26 Jan 2023 12:19:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Message-ID: <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 08:14:49AM +0000, Christophe Leroy wrote:
> Le 25/01/2023 à 21:10, Andy Shevchenko a écrit :
> > From: Pierluigi Passaro <pierluigi.p@variscite.com>
> > 
> > Both the functions gpiochip_request_own_desc and
> > gpiochip_free_own_desc are exported from
> >      drivers/gpio/gpiolib.c
> > but this file is compiled only when CONFIG_GPIOLIB is enabled.
> > Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
> > reasonable definitions and includes in the "#else" branch.
> 
> Can you give more details on when and why link fails ?
> 
> You are adding a WARN(), I understand it mean the function should never 
> ever be called. Shouldn't it be dropped completely by the compiler ? In 
> that case, no call to gpiochip_request_own_desc() should be emitted and 
> so link should be ok.
> 
> If link fails, it means we still have unexpected calls to 
> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we should 
> fix the root cause instead of hiding it with a WARN().

I agree, but what do you suggest exactly? I think the calls to that functions
shouldn't be in the some drivers as it's layering violation (they are not a
GPIO chips to begin with). Simply adding a dependency not better than this one.

-- 
With Best Regards,
Andy Shevchenko


