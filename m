Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2A31AF80
	for <lists+linux-arch@lfdr.de>; Sun, 14 Feb 2021 07:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBNGo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Feb 2021 01:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhBNGo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Feb 2021 01:44:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06336C061756;
        Sat, 13 Feb 2021 22:44:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so1965822plh.12;
        Sat, 13 Feb 2021 22:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ox7P6Ft4Ae/j+8CvGaBiB8+ZHoryy/fndeBtAp254PA=;
        b=qBv+tcbiowvYapz/SeUwnAYB6zvJEsWUvQylhvVUkz5NIVuHV5ZmDy05VOYSdpIWRd
         TSxkZgJSjaiVflDWodvRm+vjYY2HL+TxXCMiNApFomJIZb2J+Dr23uMf/qX7rQWns4O2
         i1hSInATgbKsIs8ZPswsT38u+fnPodt0SpdV2Ueo3/TL66YBZoUU7e9eUZGpYRdWA4W1
         V8Sc6GOqNojMrzdeXccDSYyHbDESMXFekiyku4odyaOAYB6xQHglWfLW1AppHn/m+FMO
         6DMsId8UV0fQEDOa1I+CWwvOlAwa+o12KUgEoOTc6dEqvGkLd6NAJA1x2NdwhAlyHZzy
         Wl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ox7P6Ft4Ae/j+8CvGaBiB8+ZHoryy/fndeBtAp254PA=;
        b=n0mt5tQBkNJeaz8th2CBVav9sbTccBytrTXS466BNU7ypRMEQnjcZWxlnieZacikeI
         /Uasxd9h5LEq9qh0wC4Q5+E4URLqa1lnxBFZAshlSr1IG6H1gB8kuejmuaqm9LfOiLQS
         Yxi7fSOD0xYE7kBBuFpOOx4Jz0SNtgLZo44lqnzAOWrYiw53XpU6weKFv+GdKrWfVAAV
         Nwja2PwSQI04gbu00u4J92Whsj0xWqr1yXcAiDSqaAl8oIL2Z965+qulpltFbZfO8mii
         ooBk+dUdHomW2974BC62S9aCQziEm3/sOiR6lqjigCFhb3m+qDOHnYRTACTPKErPtlWZ
         jQeg==
X-Gm-Message-State: AOAM5336AKIL8pmOELh4DSxklJmvj2kUJyEAwS6VeJfLUreHOM4XzkC4
        xX2aNzySaK9qNyvZuuxx7AQ=
X-Google-Smtp-Source: ABdhPJwQ+jMyex95c511IArWunpnYm+FgNfk2TK5ARZRICuM/+i5aZcHBsAg+yksW8yVR1ZZbn+Gyg==
X-Received: by 2002:a17:903:2306:b029:de:18e9:f439 with SMTP id d6-20020a1709032306b02900de18e9f439mr9759653plh.38.1613285055310;
        Sat, 13 Feb 2021 22:44:15 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b17sm13570674pfb.75.2021.02.13.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 22:44:14 -0800 (PST)
Date:   Sun, 14 Feb 2021 15:44:07 +0900
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
Subject: Re: [PATCH v2 1/3] gpiolib: Introduce the for_each_set_clump macro
Message-ID: <YCjGtyApAV16gpMW@shinobu>
References: <cover.1613134924.git.syednwaris@gmail.com>
 <f203e2d52e550f7700d49b6c4f8603b193f42c5d.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zWgD9gnv5AxmUo7"
Content-Disposition: inline
In-Reply-To: <f203e2d52e550f7700d49b6c4f8603b193f42c5d.1613134924.git.syednwaris@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--2zWgD9gnv5AxmUo7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2021 at 06:50:20PM +0530, Syed Nayyar Waris wrote:
> This macro iterates for each group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to
> the bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value() and bitmap_set_value() functions are introduced to
> respectively get and set a value of n-bits in a bitmap memory region.
> The n-bits can have any size from 1 to BITS_PER_LONG. size less
> than 1 or more than BITS_PER_LONG causes undefined behaviour.
> Moreover, during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that word,
> while the remaining portion is stored in the next higher word. Similar
> situation occurs while retrieving the value from bitmap.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Go=C5=82aszewski <bgolaszewski@baylibre.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

I think it would be good to retire the "clump" nomenclature and instead
call this macro for_each_set_nbits in order to match the existing
convention used by the bitmap functions. But I don't feel strongly
enough to nitpick on that, so this version looks good to me as is.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/gpio/gpiolib.c | 90 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpiolib.h | 28 +++++++++++++
>  2 files changed, 118 insertions(+)
>=20
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b02cc2abd3b6..282ae599c143 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4342,6 +4342,96 @@ static int gpiolib_seq_show(struct seq_file *s, vo=
id *v)
>  	return 0;
>  }
> =20
> +/**
> + * bitmap_get_value - get a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG in=
clusive).
> + *
> + * Returns value of nbits located at the @start bit offset within the @m=
ap
> + * memory region.
> + */
> +unsigned long bitmap_get_value(const unsigned long *map,
> +				unsigned long start,
> +				unsigned long nbits)
> +{
> +	const size_t index =3D BIT_WORD(start);
> +	const unsigned long offset =3D start % BITS_PER_LONG;
> +	const unsigned long ceiling =3D round_up(start + 1, BITS_PER_LONG);
> +	const unsigned long space =3D ceiling - start;
> +	unsigned long value_low, value_high;
> +
> +	if (space >=3D nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> +	else {
> +		value_low =3D map[index] & BITMAP_FIRST_WORD_MASK(start);
> +		value_high =3D map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +		return (value_low >> offset) | (value_high << space);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(bitmap_get_value);
> +
> +/**
> + * bitmap_set_value - set value within a memory region
> + * @map: address to the bitmap memory region
> + * @nbits: size of map in bits
> + * @value: value of clump
> + * @value_width: size of value in bits (must be between 1 and BITS_PER_L=
ONG inclusive)
> + * @start: bit offset of the value
> + */
> +void bitmap_set_value(unsigned long *map, unsigned long nbits,
> +			unsigned long value, unsigned long value_width,
> +			unsigned long start)
> +{
> +	const unsigned long index =3D BIT_WORD(start);
> +	const unsigned long length =3D BIT_WORD(nbits);
> +	const unsigned long offset =3D start % BITS_PER_LONG;
> +	const unsigned long ceiling =3D round_up(start + 1, BITS_PER_LONG);
> +	const unsigned long space =3D ceiling - start;
> +
> +	value &=3D GENMASK(value_width - 1, 0);
> +
> +	if (space >=3D value_width) {
> +		map[index] &=3D ~(GENMASK(value_width - 1, 0) << offset);
> +		map[index] |=3D value << offset;
> +	} else {
> +		map[index + 0] &=3D ~BITMAP_FIRST_WORD_MASK(start);
> +		map[index + 0] |=3D value << offset;
> +
> +		if (index + 1 >=3D length)
> +			return;
> +
> +		map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + value_width);
> +		map[index + 1] |=3D value >> space;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(bitmap_set_value);
> +
> +/**
> + * find_next_clump - find next clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @size: bitmap size in number of bits
> + * @offset: bit offset at which to start searching
> + * @clump_size: clump size in bits
> + *
> + * Returns the bit offset for the next set clump; the found clump value =
is
> + * copied to the location pointed by @clump. If no bits are set, returns=
 @size.
> + */
> +unsigned long find_next_clump(unsigned long *clump, const unsigned long =
*addr,
> +				unsigned long size, unsigned long offset,
> +				unsigned long clump_size)
> +{
> +	offset =3D find_next_bit(addr, size, offset);
> +	if (offset =3D=3D size)
> +		return size;
> +
> +	offset =3D rounddown(offset, clump_size);
> +	*clump =3D bitmap_get_value(addr, offset, clump_size);
> +	return offset;
> +}
> +EXPORT_SYMBOL_GPL(find_next_clump);
> +
>  static const struct seq_operations gpiolib_sops =3D {
>  	.start =3D gpiolib_seq_start,
>  	.next =3D gpiolib_seq_next,
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 30bc3f80f83e..41c6b24d9842 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -141,6 +141,34 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc=
, unsigned int debounce);
>  int gpiod_hog(struct gpio_desc *desc, const char *name,
>  		unsigned long lflags, enum gpiod_flags dflags);
> =20
> +unsigned long bitmap_get_value(const unsigned long *map,
> +				unsigned long start,
> +				unsigned long nbits);
> +
> +void bitmap_set_value(unsigned long *map, unsigned long nbits,
> +			unsigned long value, unsigned long value_width,
> +			unsigned long start);
> +
> +unsigned long find_next_clump(unsigned long *clump, const unsigned long =
*addr,
> +				unsigned long size, unsigned long offset,
> +				unsigned long clump_size);
> +
> +#define find_first_clump(clump, bits, size, clump_size) \
> +	find_next_clump((clump), (bits), (size), 0, (clump_size))
> +
> +/**
> + * for_each_set_clump - iterate over bitmap for each clump with set bits
> + * @start: bit offset to start search and to store the current iteration=
 offset
> + * @clump: location to store copy of current 8-bit clump
> + * @bits: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + * @clump_size: clump size in bits
> + */
> +#define for_each_set_clump(start, clump, bits, size, clump_size) \
> +	for ((start) =3D find_first_clump(&(clump), (bits), (size), (clump_size=
)); \
> +	     (start) < (size); \
> +	     (start) =3D find_next_clump(&(clump), (bits), (size), (start) + (c=
lump_size), (clump_size)))
> +
>  /*
>   * Return the GPIO number of the passed descriptor relative to its chip
>   */
> --=20
> 2.29.0
>=20

--2zWgD9gnv5AxmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAoxqsACgkQhvpINdm7
VJKYxxAArGoTAiMfiMp0c/4bQYLA/idauyYXF7ssxggh9Y65sgKLeqVoZMadHROX
BKtQ7lX9Ul+Xb/mRNlXhUWxGv3X23sN1ORDM1b1rxxmbhyTpZ2SwM6zBdkLcjJYK
4PqARL05Fg7jon9vbBwLXhGTtV8vl/b19gNTUnlOstxMw5eGabBn1p4y1RLnVIH1
u/tua5GDG9KgGbEjaEsT4xrq7TpZxgdLzKQ0BBgyTb+Vm0b/8KJce93HVu+1Ma05
UAK6kecOMSPw13aN6o2WV/lai1l/LAl3gJ2FfygzlT0+lHGOrZQhJh/HgVAASqZY
JuivDcPIeSrbRoxUeJjqk866jc/eV9mKu1Nc2KbXQ5wQZ4y3gO5Wamir8PM7k7uv
lFyTVOQYY3xN9EAvKWIjFubcjreNdnHZVIfsj73W/pDG04GnkG0/y4lLn+ygzjE9
NdlNG5LPdDz8VYYEivI0/ZsELIyJ053rLI1Wb9FpXu9Cr9MDSdcNzSJIZwlmLnDN
qxK+W4dShmW2Ting8gyvsa4sTxgEQu5GI/hroQvwhMl0XlnRDVp7SbUQqYFt6/M0
gscZfGaGB+xO140EGs5Kr9z0P6CNGBc2sXPy+CinPYmczaCL/O+cIHzI85/jat8S
flGNmtjOcRPFqPx78vMnGV4TueNvJwT4FVzulrqyuvhwOdOSmbU=
=XFCt
-----END PGP SIGNATURE-----

--2zWgD9gnv5AxmUo7--
