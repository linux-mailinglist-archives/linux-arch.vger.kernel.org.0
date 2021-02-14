Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AF31AF8A
	for <lists+linux-arch@lfdr.de>; Sun, 14 Feb 2021 07:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBNGwe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Feb 2021 01:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNGwe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Feb 2021 01:52:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62AC061574;
        Sat, 13 Feb 2021 22:51:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z68so2436845pgz.0;
        Sat, 13 Feb 2021 22:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X2EJKn2Q5rmq+Yi9UK1APlcp90jXtUQBQHq0JTIDyGY=;
        b=EEvOdBt0QbtV8R/q53cLymQtUHeaiajLDue8tEgMdASxfrbKvdbnTA12gZ1HGDsXcd
         /mcCcI2M4PkkJ8nidENX2iyftZ1d9eNmHKSHGf3ycQVepOghTPYUdPxnvQEuWYd9Y3iO
         2L9kiEuTosBuBLSDSL0U9mFgWO0bILDVajIq5sVxzHSwvy7cd2PZuedsI9tfngy4oVcb
         4GUTbU394aiBmvOhKeMvTLsYv9BuPUzYCKgxJjFacymsuyOHkAgmEXu9DHTqg6QmpOdt
         vSg8soGAZfaTAWOLU5XnAnjz5sYb+XvyU260g9nGESL+q+fogv0luQ1DKvsbt8nxyPHK
         MHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X2EJKn2Q5rmq+Yi9UK1APlcp90jXtUQBQHq0JTIDyGY=;
        b=BWgj+9WrdEX/I0pw3MqQ/J1fmMpfhD0JkhMmxM6sUDCZLZATrRWtXyLCpbEZn3v+vU
         G/XS0Ojm2i7JGzsbT9tgmEeq9deHPEpoXBcrUbT6WtQ8A47Z9sJAVb7CKW3pHQbUwzmB
         ndmTNnoeNIgK/L6zRsYEH0+FZeyF1enGnuSDCSI3uLhcwo9YkhpfAz4OBeQUQ7KulwHi
         A149kPwyV9GDyXK4ktom+3PmxioGy9iZtSvTx3YgZdD6+5LTiLyFb54M88QWTJ3/VLBB
         9CB6wdvrOFLedp7TJaTWgrtTiaGaYtk4YT7rWgabTALcjwOmUeN1diCk6NK3K2MMkk+D
         4xZQ==
X-Gm-Message-State: AOAM5339n2R+xkf+2lXQsVPI7vNfoF0b1Zxoqc6HR9TgzThCpTPXgvGP
        hfIlO8TXq+bcUceU8WGKT7U=
X-Google-Smtp-Source: ABdhPJydcyGXyLoACItzieFkASH7cpQXcenXtosFDDiga3+BJmDb43KItdmpqcS+BBnx1+iWKQf0NQ==
X-Received: by 2002:a05:6a00:1a48:b029:1ce:64d9:70e6 with SMTP id h8-20020a056a001a48b02901ce64d970e6mr10344356pfv.8.1613285512592;
        Sat, 13 Feb 2021 22:51:52 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id fv11sm13261957pjb.18.2021.02.13.22.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 22:51:52 -0800 (PST)
Date:   Sun, 14 Feb 2021 15:51:45 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, yamada.masahiro@socionext.com,
        akpm@linux-foundation.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] gpio: xilinx: Utilize generic bitmap_get_value
 and _set_value
Message-ID: <YCjIgV5FLRI6Is0y@shinobu>
References: <cover.1613134924.git.syednwaris@gmail.com>
 <1b1f706b60e4c571c4f17d53ac640e8bd8384856.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AVko8d8iE+KHQT32"
Content-Disposition: inline
In-Reply-To: <1b1f706b60e4c571c4f17d53ac640e8bd8384856.1613134924.git.syednwaris@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--AVko8d8iE+KHQT32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2021 at 06:52:00PM +0530, Syed Nayyar Waris wrote:
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.
>=20
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/gpio/gpio-xilinx.c | 63 +++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index be539381fd82..8445e69cf37b 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
> +#include "gpiolib.h"
> =20
>  /* Register Offset Definitions */
>  #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
> @@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct gpio_chip *gc=
, unsigned long *mask,
>  {
>  	unsigned long flags;
>  	struct xgpio_instance *chip =3D gpiochip_get_data(gc);
> -	int index =3D xgpio_index(chip, 0);
> -	int offset, i;
> -
> -	spin_lock_irqsave(&chip->gpio_lock[index], flags);
> -
> -	/* Write to GPIO signals */
> -	for (i =3D 0; i < gc->ngpio; i++) {
> -		if (*mask =3D=3D 0)
> -			break;
> -		/* Once finished with an index write it out to the register */
> -		if (index !=3D  xgpio_index(chip, i)) {
> -			xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -				       index * XGPIO_CHANNEL_OFFSET,
> -				       chip->gpio_state[index]);
> -			spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> -			index =3D  xgpio_index(chip, i);
> -			spin_lock_irqsave(&chip->gpio_lock[index], flags);
> -		}
> -		if (__test_and_clear_bit(i, mask)) {
> -			offset =3D  xgpio_offset(chip, i);
> -			if (test_bit(i, bits))
> -				chip->gpio_state[index] |=3D BIT(offset);
> -			else
> -				chip->gpio_state[index] &=3D ~BIT(offset);
> -		}
> -	}
> -
> -	xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -		       index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> -
> -	spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> +	u32 *const state =3D chip->gpio_state;
> +	unsigned int *const width =3D chip->gpio_width;
> +
> +	DECLARE_BITMAP(old, 64);
> +	DECLARE_BITMAP(new, 64);
> +	DECLARE_BITMAP(changed, 64);
> +
> +	spin_lock_irqsave(&chip->gpio_lock[0], flags);
> +	spin_lock(&chip->gpio_lock[1]);
> +
> +	bitmap_set_value(old, 64, state[0], width[0], 0);
> +	bitmap_set_value(old, 64, state[1], width[1], width[0]);
> +	bitmap_replace(new, old, bits, mask, gc->ngpio);
> +
> +	bitmap_set_value(old, 64, state[0], 32, 0);
> +	bitmap_set_value(old, 64, state[1], 32, 32);
> +	state[0] =3D bitmap_get_value(new, 0, width[0]);
> +	state[1] =3D bitmap_get_value(new, width[0], width[1]);
> +	bitmap_set_value(new, 64, state[0], 32, 0);
> +	bitmap_set_value(new, 64, state[1], 32, 32);
> +	bitmap_xor(changed, old, new, 64);
> +
> +	if (((u32 *)changed)[0])
> +		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
> +				state[0]);
> +	if (((u32 *)changed)[1])
> +		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> +				XGPIO_CHANNEL_OFFSET, state[1]);
> +
> +	spin_unlock(&chip->gpio_lock[1]);
> +	spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
>  }
> =20
>  /**
> --=20
> 2.29.0
>=20

--AVko8d8iE+KHQT32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAoyIAACgkQhvpINdm7
VJLDwRAAkYbiWj65z4jjrxx7Cxv/DP6zH0wtwqBb+BeZ2zO5gk3GonfpTqtDqvOq
2som9X4hM57nzTZnY1Mom2RqM3csY5YpsyBB0s9QeBe5CcdhdGZ21ZkX9vqZp/5+
8VVjgTg1vO4jwZzKtulztcuJsgBjhHd5lLoPGpBplXHuJobzPQ5mx/ffC1x4wyGi
d59bXrd1Wzed6rxRTWKm/tBIqVITbyYHiXkBbUYJm5cF27xfar5S4tSkhuTs09S8
3rEgmPplulTPm4XyKKmlQfyEH5VANMfSswPQx0wIP6iYtI6rN4RuCM/ZYD4lcGhe
Ez0KtpbnRyF211ieo4BKgjbUcFcp8g5/6QZlU1FYCJxWnxF9OtElnAVcHBlzPOrL
Mp3RLUDaxoytqXAJy+wLEHbf1Z8CcHdiJ1gFYDNl4TpPEyjkJ1j/XLVGb/JOoPKG
1KtzT/fvQRK0G5xKXuB33RsoFoj8G/Olm4+6VxOO7MvOw7LMZRCF1wZbwCmwwVPU
BcSsPr4dlFfzbrHiZhW07ilMi/dWChVolBb1/BjK+x9vEYYIufl+YSinPhO7x8Wp
FgUi1Z/9bzA/T/kE4V4NLXrVanq+PxhWlzqvm5qHNpsIRp9PiwFVHw22nxlWeVBZ
lbvaPOSA156Aac2Y0UVfNQQ10VWV2ieJ3FpNI9xnjICxp6QOydo=
=o/OB
-----END PGP SIGNATURE-----

--AVko8d8iE+KHQT32--
