Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFD2BB1DE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgKTR7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 12:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgKTR7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 12:59:13 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CBDC0613CF;
        Fri, 20 Nov 2020 09:59:13 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ec16so5110794qvb.0;
        Fri, 20 Nov 2020 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=unYKej8YP+ZRl42nz0CCo6lF2anM/8H77HoEpmDKfy0=;
        b=skW7YyvjYxSbJCJr9G6/vdoYg+vOkc9++HRhR18NcN0vJikz/7tSMWKyeGMm1G3s3m
         D3wxcJbfr0sy0EnoWa2HeouLy5bBPpUbEVe0KDNWEEeG4YHzq+NunKRfuKZIIapPRC+r
         n4NTjtfj50z7ZxSU14sBP7+pnMCR/u201SyW7NkMvfCW9SC0l6usG7qfi/qLTzbK4Yzf
         1CC0TOXlHlSS53d0icvIDiTG2qNo0Ze4901D1CXTMV78yr0x8tijRloz7I58xiveqvp8
         EE4cCCCnXnT1MpvYXo+Be0jJ9VpBPmrI1nK41IQ9PL/ywawAcDgQhpFCob4yJyXiiJMo
         WODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unYKej8YP+ZRl42nz0CCo6lF2anM/8H77HoEpmDKfy0=;
        b=coi1tCKcaX2K8IMwGi/UCJV0vi6jSpxeigbsw6XvWGZp4j4b+/fE+1yoTbYBcTP+Ev
         BMvprSWV0HMgd6rHZ6xEK51152h+nTSp8fdOfzcYSJ/Hs1o52KhHZ4gNo/70KgjYGHXQ
         VyaGgq3QuH5aD+HaHw7DiOdEc1TCmJwAaolB6+E2aCWVaCeXCI/zZGVwoDPw+Et3e0rc
         SC7sL7HGY6U/sgCkZ/7PTyA2mg6qSQsiMKTrtEig4l2YOIUz/lTF8ZyF3TgGhm5mEt5X
         KZGmyC54wVOhOsUDZh1DzqtaZDfXwOOwb6cs374GoGV3AHEvXOF4dMlNaj2GFMSugPFJ
         XLrQ==
X-Gm-Message-State: AOAM533LyTPkQXxnLex+c/AbdCwdsNDmHG1Zo61t9xuDz984kLI7yILw
        YV9i7ok2xRW4DcT4KP4RAsU=
X-Google-Smtp-Source: ABdhPJxI7KR8wOPDMoPtb9JVECgzS2Cvnqm9ghNcpnnR4mGImP8Jr/44xyhNqOMxz5sdGwZRmICBiw==
X-Received: by 2002:a0c:a9d0:: with SMTP id c16mr17462086qvb.5.1605895152592;
        Fri, 20 Nov 2020 09:59:12 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id x25sm2356146qkh.32.2020.11.20.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:59:11 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:59:09 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] bitmap: Modify bitmap_set_value() to check bitmap
 length
Message-ID: <X7gD7Q/63qoUuGpi@shinobu>
References: <cover.1605893641.git.syednwaris@gmail.com>
 <b2011fb2e0438bdfd0b663b9f0456d0aef20f04b.1605893642.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RjWzpKsaDEwQ2xsQ"
Content-Disposition: inline
In-Reply-To: <b2011fb2e0438bdfd0b663b9f0456d0aef20f04b.1605893642.git.syednwaris@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--RjWzpKsaDEwQ2xsQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 11:14:16PM +0530, Syed Nayyar Waris wrote:
> Add explicit check to see if the value being written into the bitmap
> does not fall outside the bitmap.
> The situation that it is falling outside would never be possible in the
> code because the boundaries are required to be correct before the function
> is called. The responsibility is on the caller for ensuring the boundaries
> are correct.
> This is just to suppress the GCC -Wtype-limits warnings.

Hi Syed,

This commit message sounds a bit strange without the context of our
earlier discussion thread. Would you be able to reword the commit
message to explain the motivation for using __builtin_unreachable()?

Thanks,

William Breathitt Gray

>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  include/linux/bitmap.h | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 386d08777342..efb6199ea1e7 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -78,8 +78,9 @@
>   *  bitmap_get_value(map, start, nbits)		Get bit value of size
>   *                                              'nbits' from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at=
 start
> - *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nb=
its'
> - *                                              of map at start
> + *  bitmap_set_value(map, nbits, value, value_width, start)
> + *                                              Set bit value of size va=
lue_width
> + *                                              to map at start
>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -610,30 +611,36 @@ static inline void bitmap_set_value8(unsigned long =
*map, unsigned long value,
>  }
> =20
>  /**
> - * bitmap_set_value - set n-bit value within a memory region
> + * bitmap_set_value - set value within a memory region
>   * @map: address to the bitmap memory region
> - * @value: value of nbits
> - * @start: bit offset of the n-bit value
> - * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG in=
clusive).
> + * @nbits: size of map in bits
> + * @value: value of clump
> + * @value_width: size of value in bits (must be between 1 and BITS_PER_L=
ONG inclusive)
> + * @start: bit offset of the value
>   */
> -static inline void bitmap_set_value(unsigned long *map,
> -				    unsigned long value,
> -				    unsigned long start, unsigned long nbits)
> +static inline void bitmap_set_value(unsigned long *map, unsigned long nb=
its,
> +				    unsigned long value, unsigned long value_width,
> +				    unsigned long start)
>  {
> -	const size_t index =3D BIT_WORD(start);
> +	const unsigned long index =3D BIT_WORD(start);
> +	const unsigned long length =3D BIT_WORD(nbits);
>  	const unsigned long offset =3D start % BITS_PER_LONG;
>  	const unsigned long ceiling =3D round_up(start + 1, BITS_PER_LONG);
>  	const unsigned long space =3D ceiling - start;
> =20
> -	value &=3D GENMASK(nbits - 1, 0);
> +	value &=3D GENMASK(value_width - 1, 0);
> =20
> -	if (space >=3D nbits) {
> -		map[index] &=3D ~(GENMASK(nbits - 1, 0) << offset);
> +	if (space >=3D value_width) {
> +		map[index] &=3D ~(GENMASK(value_width - 1, 0) << offset);
>  		map[index] |=3D value << offset;
>  	} else {
>  		map[index + 0] &=3D ~BITMAP_FIRST_WORD_MASK(start);
>  		map[index + 0] |=3D value << offset;
> -		map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nbits);
> +
> +		if (index + 1 >=3D length)
> +			__builtin_unreachable();
> +
> +		map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + value_width);
>  		map[index + 1] |=3D value >> space;
>  	}
>  }
> --=20
> 2.29.0
>=20

--RjWzpKsaDEwQ2xsQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+4A9MACgkQhvpINdm7
VJLOcg//bVHY76KR7Igmki4gD1LNUL909jSCr2HZnnKLRy0/9FVuGSmB4rOAKnDu
f701GsaEg4yuvJ5uVMdxtbkhoSm9SxdPMX9bwun0D5UYPp4QTg/c8gLL4sZfBl7t
TG+aV/Osi+G/NaZ2X43aX/LK812ALIcb1p3gJ7+137HRxSyt/ZVl7X5gRQ6Kz1w+
9hpkdWh+2BGFrIuV3KrtHFCmOFaww27hxfVueVag6/aNu9MtS10e+hMCmoDaX1I1
neR+x+02fFEYV3cOVVWKvEzx2aZrEc11S8en6AgOHijrwaMfHQRFHz/pT+ZInMmU
EWfzhMeTPcJPms4n8E7fveuy6BC+fAvgoioVtxyz2tmhVmrnGPt+yl6E/VwDi7Mo
ssuJWHbETWxDOJmADe0Qo9WX1g2QdHGmWyvkjbZOcXAhTTXhSdOczSQlzTtR8YJx
cJVUbjakNFfEjitaoseYfYt75sKJ0H6YDEuI8DxZvND9UXVGCUeTBQHmtnWdnD0h
dSrV7aE/kbEeWgW93AD/XV0evSYf+FPkUcEjjml7f1sD1eWj7dP1tG0OvnlYs0kQ
PB4ccB4Gn8UAAIaO2iT5KdHTwqa6LY5/gqKwxICQa/ek5xuoEz6ohzLhANlS/vDy
6saVldu/0w12nDKGhaewpEArthFrzz6ayVq4vjmCoSr/uKgI9JU=
=WFzE
-----END PGP SIGNATURE-----

--RjWzpKsaDEwQ2xsQ--
