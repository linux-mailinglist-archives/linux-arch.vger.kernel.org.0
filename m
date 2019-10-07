Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468BBCDD97
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfJGIpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 04:45:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:57972 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGIpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Oct 2019 04:45:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="192226354"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 01:45:47 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHOeI-0005Oq-FC; Mon, 07 Oct 2019 11:45:46 +0300
Date:   Mon, 7 Oct 2019 11:45:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Subject: Re: [PATCH v16 14/14] gpio: pca953x: Utilize the for_each_set_clump8
 macro
Message-ID: <20191007084546.GO32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 06, 2019 at 11:11:11AM -0400, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

I can test this along with 74x164 at the same time.

> Cc: Phil Reid <preid@electromag.com.au>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..10b669b8f27d 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -456,7 +457,8 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  				      unsigned long *mask, unsigned long *bits)
>  {
>  	struct pca953x_chip *chip = gpiochip_get_data(gc);
> -	unsigned int bank_mask, bank_val;
> +	unsigned long offset;
> +	unsigned long bank_mask;
>  	int bank;
>  	u8 reg_val[MAX_BANK];
>  	int ret;
> @@ -466,15 +468,10 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
>  	if (ret)
>  		goto exit;
>  
> -	for (bank = 0; bank < NBANK(chip); bank++) {
> -		bank_mask = mask[bank / sizeof(*mask)] >>
> -			   ((bank % sizeof(*mask)) * 8);
> -		if (bank_mask) {
> -			bank_val = bits[bank / sizeof(*bits)] >>
> -				  ((bank % sizeof(*bits)) * 8);
> -			bank_val &= bank_mask;
> -			reg_val[bank] = (reg_val[bank] & ~bank_mask) | bank_val;
> -		}
> +	for_each_set_clump8(offset, bank_mask, mask, gc->ngpio) {
> +		bank = offset / 8;
> +		reg_val[bank] &= ~bank_mask;
> +		reg_val[bank] |= bitmap_get_value8(bits, offset) & bank_mask;
>  	}
>  
>  	pca953x_write_regs(chip, chip->regs->output, reg_val);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


