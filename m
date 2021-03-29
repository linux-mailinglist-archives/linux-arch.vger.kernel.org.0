Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0264634D3B9
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC2PZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 11:25:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:12677 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhC2PYn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 11:24:43 -0400
IronPort-SDR: YVscrSSmhap16pLG+zKabDcKBTygoNDypzHLJTM+KwJjzcFJ8dnhG1ik+488GbdOXQ/alQkDvK
 LKlVM+M4zhkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="211767564"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="211767564"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:24:43 -0700
IronPort-SDR: 4eVELRd9pZsPnZNimTuGuxMOd9iNPeuOxgA4FtQTcj7L3pfqpUVHF2LA55K8olLS3KTzG9awJ8
 lLSCJwsi/2BA==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="444813722"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 08:24:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lQtkq-00H3Y5-8r; Mon, 29 Mar 2021 18:24:36 +0300
Date:   Mon, 29 Mar 2021 18:24:36 +0300
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
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value
 and _set_value
Message-ID: <YGHxNFXAjcg4PfnE@smile.fi.intel.com>
References: <cover.1615038553.git.syednwaris@gmail.com>
 <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 06, 2021 at 07:36:30PM +0530, Syed Nayyar Waris wrote:
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.

...

> +	u32 *const state = chip->gpio_state;

Looking at this... What's the point of the const here?

Am I right that this tells: pointer is a const, while the data underneath
can be modified?

> +	unsigned int *const width = chip->gpio_width;

Ditto.

Putting const:s here and there for sake of the const is not good practice.
It makes code harder to read.

-- 
With Best Regards,
Andy Shevchenko


