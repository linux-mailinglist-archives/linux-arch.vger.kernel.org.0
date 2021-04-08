Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EBC35850B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhDHNoT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 09:44:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:49529 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhDHNoT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Apr 2021 09:44:19 -0400
IronPort-SDR: D0IDdpfWIPGn71mElnTLQpn/Azhp9Ocee2S1xKw4e/VDboEPJy6FnCA6YvydRcfsyuLVzcb7PA
 bB34oavQ42jQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193083305"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="193083305"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:44:08 -0700
IronPort-SDR: pNrSlgTlZdTqtJX7jbiAg0jD68NtTajV16pphbVVkRI//nol6aVyCEb9VhRN50o5sv3qWzJH17
 3Xys1RtdtFPw==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="441760078"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:44:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUUwz-002IhZ-2n; Thu, 08 Apr 2021 16:44:01 +0300
Date:   Thu, 8 Apr 2021 16:44:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     bgolaszewski@baylibre.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        akpm@linux-foundation.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH v4 3/3] gpio: xilinx: Utilize generic
 bitmap_get_value and _set_value
Message-ID: <YG8IoWznJEzwfigA@smile.fi.intel.com>
References: <cover.1617380819.git.syednwaris@gmail.com>
 <d150bd18acc767c86c23ec06cc2abd5ca74ccbbb.1617380819.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d150bd18acc767c86c23ec06cc2abd5ca74ccbbb.1617380819.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 02, 2021 at 10:07:36PM +0530, Syed Nayyar Waris wrote:
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.

As promised, I have looked at this with a fresh eye and NAK from me. Sorry.
This is less than a half baked solution. I spent couple of evenings, so
I'll come up with full conversion of this driver to the bitmap API.
And yes, as I have told you like half a year before, bitmap_get_value32() and
bitmap_set_value32() is much more useful (and I actually implemented them
locally for the sake of conversion).

So, summarize this I do not think we have real users of the proposed API.

-- 
With Best Regards,
Andy Shevchenko


