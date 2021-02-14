Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC631AF86
	for <lists+linux-arch@lfdr.de>; Sun, 14 Feb 2021 07:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBNGrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Feb 2021 01:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNGrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Feb 2021 01:47:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91969C061574;
        Sat, 13 Feb 2021 22:46:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z6so2274744pfq.0;
        Sat, 13 Feb 2021 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSknlKAGtVAQZKJexv2SwPUPcsYU9dgMwmRxYZKua5A=;
        b=u3V+OXBr/hDtXGHxKdN5ilavow4B7YndNtx/q3MEVTIAMDSEAhGHcXtYoS3wSY+k0X
         p8qpt4MAnaFAPvY3rpK2wkvZNOF5AU2AoFdtS3IOTfgPnySrXbF0NFmhc7X44e+pKT+D
         dfkWx/U+zGd9iuEe/pIx+KDJdTPSelJeg3wgI/B2EiXFb/AGDm8J1dfjoYCNOC8XFH02
         E/c0KreuW8V6L//V/59amtMmrDB28o+5OHwACPFB27/bgPiQ/x2W23oDLi7ahUGwIfDX
         p7V72PtTDmvecLCPyV3hUXG1W8oL8+uIE0/iEJakeVzAybe/q+LBscFGsKWlvZ3DytQL
         UMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSknlKAGtVAQZKJexv2SwPUPcsYU9dgMwmRxYZKua5A=;
        b=lvyrDZ5vtRhKFWVymJjMusvCYshZi/9FuwuhyvnrwYxemTCO3CS3KoHGgmlnwNFFVI
         CZ5xoijXL3Q+J4xSPhkjhm7gH/W8EVWt9fYYQ0uXMCXt7akPyj8ZJmOy41oTPPBEcT2r
         S2fKEajCE2QSQc/HVFoScPYKlxmLVY52WWjWTI2qkzgfc4KbeNXf9MfqqeajO9N7SNnv
         8BFsbMIgE2nFRmnWiYOGpkg2L5D5kQMluSFNZXbqUVNqBL2Yhk7lTfENEq4JeveyrAtw
         BXerUR4OEvpVfzaspfQ4c1hnGg6Sg96N1cA+XBEVVQe/rx8nrN0Hzo0JqSCBHH5zZBP5
         8l9w==
X-Gm-Message-State: AOAM53388bKq0LAXW/DEFZZPi8eevTnFUN7+lgyscrrgLgRayTjeQCeu
        UNDQYXcAFHcnfEBpepZcq3A=
X-Google-Smtp-Source: ABdhPJx8bOj1wN7D6ynfHAq8AGifhMXi+3jvu1kIVav5rvxZOoPO4BsqC9fT408hyH1mLOSQt1wXBQ==
X-Received: by 2002:a63:63c1:: with SMTP id x184mr6878707pgb.283.1613285182169;
        Sat, 13 Feb 2021 22:46:22 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b20sm13770107pfo.109.2021.02.13.22.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 22:46:21 -0800 (PST)
Date:   Sun, 14 Feb 2021 15:46:14 +0900
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
Subject: Re: [PATCH v2 2/3] gpio: thunderx: Utilize for_each_set_clump macro
Message-ID: <YCjHNgZt8vn1bTAQ@shinobu>
References: <cover.1613134924.git.syednwaris@gmail.com>
 <3fc5bd83322c94eb2a4f48677f6d762bf81d0652.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="se7pS8+DlUJjaBax"
Content-Disposition: inline
In-Reply-To: <3fc5bd83322c94eb2a4f48677f6d762bf81d0652.1613134924.git.syednwaris@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--se7pS8+DlUJjaBax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2021 at 06:51:04PM +0530, Syed Nayyar Waris wrote:
> This patch reimplements the thunderx_gpio_set_multiple function in
> drivers/gpio/gpio-thunderx.c to use the new for_each_set_clump macro.
> Instead of looping for each bank in thunderx_gpio_set_multiple
> function, now we can skip bank which is not set and save cycles.
>=20
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/gpio/gpio-thunderx.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
> index 9f66deab46ea..0398b2d2af4b 100644
> --- a/drivers/gpio/gpio-thunderx.c
> +++ b/drivers/gpio/gpio-thunderx.c
> @@ -16,7 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/spinlock.h>
>  #include <asm-generic/msi.h>
> -
> +#include "gpiolib.h"
> =20
>  #define GPIO_RX_DAT	0x0
>  #define GPIO_TX_SET	0x8
> @@ -275,12 +275,15 @@ static void thunderx_gpio_set_multiple(struct gpio_=
chip *chip,
>  				       unsigned long *bits)
>  {
>  	int bank;
> -	u64 set_bits, clear_bits;
> +	unsigned long set_bits, clear_bits, gpio_mask;
> +	unsigned long offset;
> +
>  	struct thunderx_gpio *txgpio =3D gpiochip_get_data(chip);
> =20
> -	for (bank =3D 0; bank <=3D chip->ngpio / 64; bank++) {
> -		set_bits =3D bits[bank] & mask[bank];
> -		clear_bits =3D ~bits[bank] & mask[bank];
> +	for_each_set_clump(offset, gpio_mask, mask, chip->ngpio, 64) {
> +		bank =3D offset / 64;
> +		set_bits =3D bits[bank] & gpio_mask;
> +		clear_bits =3D ~bits[bank] & gpio_mask;
>  		writeq(set_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO=
_TX_SET);
>  		writeq(clear_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GP=
IO_TX_CLR);
>  	}
> --=20
> 2.29.0
>=20

--se7pS8+DlUJjaBax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAoxzYACgkQhvpINdm7
VJIbiQ/+ICxmJVJ1eLuf5r+9JrFTo+uIbt9EDs9pQpW9l7BEjTsVQa4ALyElS9lH
8WUP2VX2ZeqVNV4UFRw8sW4BtUFaREdoaJMsfdHAHK+OfCJlyuMvNw+Jxa3Sl5AI
OWavxf8pUAaO1u+gGE7VwM/FxscUocTJQy859hx0DXVVNiqvo10a3bzzxHkuX+PT
UDVt1oB9Y7lc6WigV1uI6518Tcoi9VX59c/f10s01NJqfZnMhfOen9c5DTfZjkvC
fvbZRjkbQXdUln7yJrzTYIPzsmeqSRSDqh7y/GAmmy9ETUhS9KfeHHDQzuvy1gr9
XSfleyHM10pqVWo8ePEEPFxkJc8cSg4RpXaDJHQAhAELc354xPr6IEj2vfVVw/YO
Jjr09zLmB3+IsJVZFTml2AA5O6zQBPZxvvUa05Peet+C0mFTkxjqBg1adqJKvvVu
F2phAvkq2a+yKjQC+wHMdQj67grkSheE1x10R7lu+MB3UTDme/E1a8wbEogHwBv2
/iiweVQ6iY4Q+NJ85FH8vzvbovIvQJvR54JDKfiBLdkW+qONDGZ/aTl1kUs/wBXn
e4SgIun/pAIskTc1IiobPPeZYKZk2IpRNNpEeIwEt/oeD0hnZQ7oQIL+ZfDQM2Nh
j3/N2x4+mAptTomv9AacIBjCiwhMbJgenw8C82HltPv6IRAqgPU=
=ms+c
-----END PGP SIGNATURE-----

--se7pS8+DlUJjaBax--
