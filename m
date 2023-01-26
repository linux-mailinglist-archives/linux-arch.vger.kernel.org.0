Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CB67CAB4
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjAZMQP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAZMQP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:16:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9186AC96;
        Thu, 26 Jan 2023 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674735374; x=1706271374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABP8CvdO4Si/bv5fVfqGkHUpMZmmaNKX3k7udBeGQrs=;
  b=Wac9T7G2Fj6+/fDHMO3BbWBH30mBzr5E5NgjGIyPcKHQMWR3KkUuxjFJ
   1SyG2e1rrvSM0wiVkE7cwnyaNXD98Poh75wEUV5ruWC3WWWBOopbyEOSr
   EDBVkP3qyTqUXTnScmCt97P2JbzzLoKVdzBQRPbJUL9GULkfBPZtfxEZY
   JIGf8o9LlZpMYgAwW2VPkGaFOK75d8Nd4+Hk8PnbBfi81aQTmwbIbeClo
   Z4ug+0p7PYbIMA7mfLkKtrQ7bi1ZpsvMDtL4N24dpkYN2rDHXoa1NCoQC
   C3TP8exciO1pyVcpTf+VeLaGSgNfQDBhX05AT/RKTJAQX2Ra5z8w84wiW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="307142325"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="307142325"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 04:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="612773009"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612773009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2023 04:16:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL1An-00FNVe-1D;
        Thu, 26 Jan 2023 14:16:09 +0200
Date:   Thu, 26 Jan 2023 14:16:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
Message-ID: <Y9JvCQSi3DB/6un3@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ1g9BEb28-YzAU8V5geiYzT9drjT3EMxok70ex3fOCKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ1g9BEb28-YzAU8V5geiYzT9drjT3EMxok70ex3fOCKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 11:22:00AM +0100, Linus Walleij wrote:
> On Wed, Jan 25, 2023 at 9:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > There is a few things done:
> > - include only the headers we are direct user of
> > - when pointer is in use, provide a forward declaration
> > - add missing headers
> > - group generic headers and subsystem headers
> > - sort each group alphabetically
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Just to add to the confusion I was also pursuing a series of cleanups directed
> at just removing <linux/gpio/driver.h> from <linux/gpio.h>:
> https://lore.kernel.org/linux-gpio/CACRpkdb6yMqTkrJOg+K46RZ1478-gbxh6=tw4bzWmd--5nj_Bw@mail.gmail.com/
> 
> Right now I don't know what to do :D

I saw your series and find them very good!
Can we have them applied?

Arnd's one probably also needs to be considered sooner.

This one can be postponed.

-- 
With Best Regards,
Andy Shevchenko


