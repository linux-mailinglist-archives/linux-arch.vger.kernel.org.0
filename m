Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8ACDD2E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJGIYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 04:24:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:56608 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGIYd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Oct 2019 04:24:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="222841357"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2019 01:24:28 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHOJf-00059c-CT; Mon, 07 Oct 2019 11:24:27 +0300
Date:   Mon, 7 Oct 2019 11:24:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v16 10/14] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20191007082427.GM32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <13f5d24820e5e3a17a64d025f09efc37eda77739.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f5d24820e5e3a17a64d025f09efc37eda77739.1570374078.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 06, 2019 at 11:11:07AM -0400, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

I can test it somewhat later.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Reid <preid@electromag.com.au>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-74x164.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index e81307f9754e..05637d585152 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2010 Miguel Gaio <miguel.gaio@efixo.com>
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/module.h>
> @@ -72,20 +73,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  				    unsigned long *bits)
>  {
>  	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
> -	unsigned int i, idx, shift;
> -	u8 bank, bankmask;
> +	unsigned long offset;
> +	unsigned long bankmask;
> +	size_t bank;
> +	unsigned long bitmask;
>  
>  	mutex_lock(&chip->lock);
> -	for (i = 0, bank = chip->registers - 1; i < chip->registers;
> -	     i++, bank--) {
> -		idx = i / sizeof(*mask);
> -		shift = i % sizeof(*mask) * BITS_PER_BYTE;
> -		bankmask = mask[idx] >> shift;
> -		if (!bankmask)
> -			continue;
> +	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
> +		bank = chip->registers - 1 - offset / 8;
> +		bitmask = bitmap_get_value8(bits, offset) & bankmask;
>  
>  		chip->buffer[bank] &= ~bankmask;
> -		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
> +		chip->buffer[bank] |= bitmask;
>  	}
>  	__gen_74x164_write_config(chip);
>  	mutex_unlock(&chip->lock);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


