Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411DAD2AC3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbfJJNQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 09:16:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:6261 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbfJJNQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 09:16:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 06:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="187960124"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2019 06:16:36 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIYJ1-0006gs-2z; Thu, 10 Oct 2019 16:16:35 +0300
Date:   Thu, 10 Oct 2019 16:16:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v18 10/14] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20191010131635.GR32742@smile.fi.intel.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
 <7ea2df7182a50a1136ca36edc46dffcb2446fd27.1570641097.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea2df7182a50a1136ca36edc46dffcb2446fd27.1570641097.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 09, 2019 at 01:14:46PM -0400, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.
> 

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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


