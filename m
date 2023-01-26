Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76E67C847
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjAZKRp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjAZKRj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 05:17:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2F14491;
        Thu, 26 Jan 2023 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674728232; x=1706264232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/mVui7KHyg/685hFsXA62gG5MkPwHTsQ8fsOw6kk7o=;
  b=j58poB+wqVja46qdWNa/H9DDea6SyONu+oXNC262PPzYpehoYZPpDNgg
   dUuqEcpytvzmL3y8XxxwDrGcT2VSfPhHg6abaK7XRd2ACQWuFji3igkUz
   IGsJMCaIvxZuPuvOdLiaPDQvokCZxQI5agoQtgRgpvkwQESyea2Qtf8WH
   HS2hSqb55w97rAnOVgEqS9ca7CdZflIp+Ei/9E585uTaoxubmhevwpU+E
   ZR8xnDhFHnNi1MqUIBBOpjDaBq1LHy65XO8nBhoWaCAzIhu5NVdWMPlPU
   ER86munb+p5tbQItq6KyKNjN/xk3GSZo7VNrzkbGl7Z80K1zSMmNUj5TE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328029234"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="328029234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 02:16:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726223665"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="726223665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2023 02:16:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKzIm-00FKtE-0t;
        Thu, 26 Jan 2023 12:16:16 +0200
Date:   Thu, 26 Jan 2023 12:16:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
Message-ID: <Y9JS8HEPMu+/zEFb@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
 <8454db45-a967-4542-8f16-538043542e14@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8454db45-a967-4542-8f16-538043542e14@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 09:42:32AM +0100, Arnd Bergmann wrote:
> On Wed, Jan 25, 2023, at 21:10, Andy Shevchenko wrote:
> > There is a few things done:
> > - include only the headers we are direct user of
> > - when pointer is in use, provide a forward declaration
> > - add missing headers
> > - group generic headers and subsystem headers
> > - sort each group alphabetically
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/asm-generic/gpio.h    |  8 --------
> >  include/linux/gpio.h          |  9 +++------
> >  include/linux/gpio/consumer.h | 14 ++++++++++----
> >  include/linux/gpio/driver.h   | 34 ++++++++++++++++++++++++----------
> >  4 files changed, 37 insertions(+), 28 deletions(-)
> 
> This change looks fine, but it conflicts with a slightly
> broader cleanup that I meant to have already submitted,
> folding include/asm-generic/gpio.h into linux/gpio.h and
> removing the driver-side interface from that.
> 
> Let me try to dig out my series again, we should be able to
> either use my version, or merge parts of this patch into it.

Can you share your patches, so I will rebase mine on top and see what's left?

-- 
With Best Regards,
Andy Shevchenko


