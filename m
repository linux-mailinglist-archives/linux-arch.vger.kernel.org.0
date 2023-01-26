Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334867CC32
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjAZNay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 08:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjAZNax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 08:30:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427585FCE;
        Thu, 26 Jan 2023 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674739829; x=1706275829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0Fx8ujWWrIfCNQGiegaCYWBi3cW9KEAV5S2q2lUqAGg=;
  b=ZZmxCWAEhqoErHYVPwzoNscQP0MderEhdgNnbJPD0lVGppuoCw9CgqCB
   qSNFmG7FXP9reB8Od7/i8G+QO5sw/zeubmC6akv1T2uRMyOoeWixkiKaB
   k96ngg54l4T6EmzOC+EQ5NXbQxsNPzYcEWCEmUxrravkYzjyIMl6IcTC2
   O2Z4iRv6/VOSwD17fXdQDpHWMoraunvlvW1SyybfJdbzdkd3FYKqwpdQ2
   6cJ3k2BN2y96yvnQE2uKwTKvB9inRNp5IEvyQg4+BJl801/W19md8eB9x
   Fjc0MRq8bXuMfRupmYOMHfuCY+pXo24u09Zwn+8n6ONO/81Ni4t4ouuxI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328892609"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="328892609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="836711509"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="836711509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2023 05:29:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2Jq-00FPgm-2e;
        Thu, 26 Jan 2023 15:29:34 +0200
Date:   Thu, 26 Jan 2023 15:29:34 +0200
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
Message-ID: <Y9KAPge5zy0cIqi8@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
 <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
 <a9ec7f46-dd07-40e7-ae48-a1e48d2101c5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9ec7f46-dd07-40e7-ae48-a1e48d2101c5@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 01:56:26PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 13:44, Christophe Leroy wrote:
> > Le 26/01/2023 à 11:19, Andy Shevchenko a écrit :
> >> On Thu, Jan 26, 2023 at 08:14:49AM +0000, Christophe Leroy wrote:
> >>> Le 25/01/2023 à 21:10, Andy Shevchenko a écrit :
> >>>> From: Pierluigi Passaro <pierluigi.p@variscite.com>
> >>>>
> >>>> Both the functions gpiochip_request_own_desc and
> >>>> gpiochip_free_own_desc are exported from
> >>>>       drivers/gpio/gpiolib.c
> >>>> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> >>>> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
> >>>> reasonable definitions and includes in the "#else" branch.
> >>>
> >>> Can you give more details on when and why link fails ?
> >>>
> >>> You are adding a WARN(), I understand it mean the function should never
> >>> ever be called. Shouldn't it be dropped completely by the compiler ? In
> >>> that case, no call to gpiochip_request_own_desc() should be emitted and
> >>> so link should be ok.
> >>>
> >>> If link fails, it means we still have unexpected calls to
> >>> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we should
> >>> fix the root cause instead of hiding it with a WARN().
> >> 
> >> I agree, but what do you suggest exactly? I think the calls to that functions
> >> shouldn't be in the some drivers as it's layering violation (they are not a
> >> GPIO chips to begin with). Simply adding a dependency not better than this one.
> >> 
> >
> > My suggestion is to go step by step. First step is to explicitely list 
> > drivers that call those functions without selecting GPIOLIB.
> 
> I tried that and sent the list of the drivers that call these functions,
> but as I wrote, all of them already require GPIOLIB to be set.
> 
> This means either I made a mistake in my search, or the problem
> has already been fixed. Either way, I think Andy should provide
> the exact build failure he observed so we know what caller caused
> the issue.

I believe it's not me, who first reported it. So, Pierluigi, can you point
out to the LKP message that reported the issue?

P.S> LKP sometimes finds a really twisted configurations to probe on.

-- 
With Best Regards,
Andy Shevchenko


