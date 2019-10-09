Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C895D1417
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfJIQeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 12:34:06 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28439 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfJIQeG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 12:34:06 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x99GXhxY009609;
        Thu, 10 Oct 2019 01:33:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x99GXhxY009609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570638824;
        bh=y7V7634zQnspw5C5IJL3KPw/IDKbvhhOq4Dz/8oh3dQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsS3ZQ20/OfPGrsMG5IyzSZauuNMqtsxIcdmU7pNnKcntklAvx/7zJDpvaPX3+PQC
         YDxZTkiLEqLn9oPGmJdCvJECLI8dFyVq2vS0dsGe+NYDKgNjM05Hrg8DIctf99V1F5
         oER2VyTZ4WwhcVy3va2uzGTpz1WEeicEkMdkQRSRR1CYdpYzaIJdRxHLBQqjRgfitH
         MDxgGdTLCElhyNuFu4PnLPyuPqRLr8VU+Ren4+1DmOGOhdSRcE8J1A6VaOTdBJlUBz
         ioBL50QAv0d422bx2Ik9XUFY2jy+nGel9ea8TRaSpK7S9NP5z2/0q9aiEK3cwarHwU
         QYnmyxZVjuxDw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id w195so1912625vsw.11;
        Wed, 09 Oct 2019 09:33:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVxi43/ISGtq51ADyXmhh9eD47DCk3WHkMiUgQ3lgcclp5iBdEZ
        YB6VcYqAVG0DYICVE1ioCxNCCHHVdDHJTOGVzCc=
X-Google-Smtp-Source: APXvYqyVz/TISAP9X9dWqRgp4AQ7poq8KBQqo3Tv8o3GwtVkP0izbYG6Zxk1diURj0JSGqrOxub3fGjbdk2bFZQOcHU=
X-Received: by 2002:a05:6102:97:: with SMTP id t23mr2437001vsp.179.1570638822621;
 Wed, 09 Oct 2019 09:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
In-Reply-To: <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 10 Oct 2019 01:33:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQStJsZ4cYTJyAPvjyngWkKs+5y=yzJb6vz3-cco+2-ug@mail.gmail.com>
Message-ID: <CAK7LNAQStJsZ4cYTJyAPvjyngWkKs+5y=yzJb6vz3-cco+2-ug@mail.gmail.com>
Subject: Re: [PATCH v17 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity. An
> improvement in this case is that banks that are not masked will now be
> skipped.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-uniphier.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 93cdcc41e9fb..3e4b15d0231e 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -15,9 +15,6 @@
>  #include <linux/spinlock.h>
>  #include <dt-bindings/gpio/uniphier-gpio.h>
>
> -#define UNIPHIER_GPIO_BANK_MASK                \
> -                               GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
> -
>  #define UNIPHIER_GPIO_IRQ_MAX_NUM      24
>
>  #define UNIPHIER_GPIO_PORT_DATA                0x0     /* data */
> @@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
>  static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
>                                        unsigned long *mask, unsigned long *bits)
>  {
> -       unsigned int bank, shift, bank_mask, bank_bits;
> -       int i;
> +       unsigned long i;
> +       unsigned long bank_mask;
> +       unsigned long bank;
> +       unsigned long bank_bits;


Please do not split it into multiple lines
unless you need to do so.

Thanks.




> -       for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
> +       for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
>                 bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
> -               shift = i % BITS_PER_LONG;
> -               bank_mask = (mask[BIT_WORD(i)] >> shift) &
> -                                               UNIPHIER_GPIO_BANK_MASK;
> -               bank_bits = bits[BIT_WORD(i)] >> shift;
> +               bank_bits = bitmap_get_value8(bits, i);
>
>                 uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
>                                          bank_mask, bank_bits);
> --
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
