Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374BC1B78EE
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDXPJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbgDXPJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 11:09:42 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE757C09B045;
        Fri, 24 Apr 2020 08:09:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v18so4785340qvx.9;
        Fri, 24 Apr 2020 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0n+CaYOXugl68dwLeUyYpsT/oNtgV3fNrvzz2gAddEw=;
        b=TRS0tzgmIeGix4mr6vJEp34RuRU+aTbpETuTM6VJ+i645gFPC+dQgedTLYvNVGvJNy
         iGNYyPKQjkTwewl918p83EIIMMR1f+DQyOh+nmHDrcsGGmzZHBEupn37EJKT/78D25cc
         15uCwOl4aaHqXY6Z2eWCB26PT/aCQVGH6/fa+ImfurO9ucue/4/1oCjpiR6zGfthpGku
         NSPisVcXjZeE6zObksVDF/FAbSjwu60sb/9luT5D/iO/eYaBZ4FstSFxO6UkiUdXIA3Z
         DoYyf2q6OBPl7MMMv7XStcLRRIDyiJ+mcvD9ig9ScbL+G3x9IDTDB2QY2IG28ygSYfFM
         9a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0n+CaYOXugl68dwLeUyYpsT/oNtgV3fNrvzz2gAddEw=;
        b=Et9FDWRilJuCyOSna2yyT9adLgdehZ4KJWnxtLeAc8dRXAlZQXiscp35rfTTGmuDfw
         mewPESfLwiv3FO3ZCUcmwBkukgk0Im2629XhghhGs+XNtgTyrp1HlIFI/SMGrYAYBaOb
         J7MXBSHL5TW0KZrtBClGr9NnEm5mlvqSn7vP9vXzHJ0yn138OHpZScfJUEcALFmgZtfK
         YPHavlYiwDB5Oacv9M+yGncMdQHqel9VEj983tE9e4jG7IMXjVnvNundEreFqLnNWF71
         XkuhjtRQB4hrgXwSCvZ/MxMQAsGNoV+elYmTk/Z/+R/GgpNcXfoOjutH+mvC+Jq8ZWwA
         PCIg==
X-Gm-Message-State: AGi0PuZM+FLA2Eq1uQhUTqoiyURtGvyQXdz0xIY+2SErn2R9nGa8ZMpy
        qeLB4Mmy9zurJ8NY8wquzCPuGWXdyvFjEQ==
X-Google-Smtp-Source: APiQypKuWfLXARyuCrhIQ5hbeQX5DasIcu/OokAV/XglHzvPUpHJYIiUrUSCaw222yWd62aM8VlHWw==
X-Received: by 2002:a05:6214:3ad:: with SMTP id m13mr9599272qvy.57.1587740980879;
        Fri, 24 Apr 2020 08:09:40 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id b10sm863066qkl.19.2020.04.24.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:09:39 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:09:26 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424150828.GA5034@icarus>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20200424150058.xadjxaga3csh3br6@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 05:00:58PM +0200, Lukas Wunner wrote:
> On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> > On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> > > > +static inline void bitmap_set_value(unsigned long *map,
> > > > +                                 unsigned long value,
> > > > +                                 unsigned long start, unsigned lon=
g nbits)
> > > > +{
> > > > +     const size_t index =3D BIT_WORD(start);
> > > > +     const unsigned long offset =3D start % BITS_PER_LONG;
> > > > +     const unsigned long ceiling =3D roundup(start + 1, BITS_PER_L=
ONG);
> > > > +     const unsigned long space =3D ceiling - start;
> > > > +
> > > > +     value &=3D GENMASK(nbits - 1, 0);
> > > > +
> > > > +     if (space >=3D nbits) {
> > > > +             map[index] &=3D ~(GENMASK(nbits + offset - 1, offset)=
);
> > > > +             map[index] |=3D value << offset;
> > > > +     } else {
> > > > +             map[index] &=3D ~BITMAP_FIRST_WORD_MASK(start);
> > > > +             map[index] |=3D value << offset;
> > > > +             map[index + 1] &=3D ~BITMAP_LAST_WORD_MASK(start + nb=
its);
> > > > +             map[index + 1] |=3D (value >> space);
> > > > +     }
> > > > +}
> > >
> > > Sorry but what's the advantage of using this complicated function
> > > as a replacement for the much simpler bitmap_set_value8()?
> > >
> > > The drivers calling bitmap_set_value8() *know* that 8-bit accesses
> > > are possible and take advantage of that knowledge by using a small,
> > > speed-optimized function.  Replacing that with a more complicated
> > > (potentially less performant) function doesn't seem to be a step
> > > forward.
> >=20
> > Actually this generic function can work with n-bits of any size (less
> > than equal to BITS_PER_LONG), while the earlier bitmap_set_value8
> > worked with n-bits having size of 8 bits only.
> >=20
> > In the case when n-bits is 8-bits, this new bitmap_set_value()
> > function would behave very similar to the earlier bitmap_set_value8()
> > function. For example,  in case of n-bits being 8-bits it will always
> > execute the 'if' condition and not the 'else' condition, hence
> > offering the same performance (because of encountering similar code
> > statements) as earlier bitmap_set_value8() function, most probably.
> >=20
> > There is an additional advantage (this can happen when n-bits is not 8
> > bits): during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that
> > word, while the remaining portion is stored in the next higher word.
> >=20
> > So, this function preserves the behaviour of earlier
> > bitmap_set_value8() function and also adds extra functionality to
> > that.
>=20
> Please leave drivers as is which use exclusively 8-bit accesses,
> e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
> regression if your new generic variant is used.  They work perfectly
> fine the way they are and I don't see any benefit this series may have
> for them.
>=20
> If there are other drivers which benefit from the flexibility of your
> generic variant then I'm not opposed to changing those.
>=20
> Thanks,
>=20
> Lukas

We can leave of course bitmap_set_value8 alone, but for 8-bit values the
difference in latency I suspect is primarily due to the conditional test
for the word boundaries. This latency is surely overshadowed by the I/O
latency of the GPIO drivers, so I don't think there's much harm in
changing those to use the generic function when the bottleneck will not
be due to the bitmap_set_value/bitmap_get_value operations.

William Breathitt Gray

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6jASYACgkQhvpINdm7
VJK6Pg/+KKvrnl2mkz+WQRqeUtC2vT7B96V67NjNLkDgAR2WUj35kia4ooNFeGD1
e2tRjz/yAmdX3XhGnNfA2ec6O14y/IjRzN1WKijRKgiAGM8Lxa2XZC02a+IfYak1
QsEk66u6CHN9hDdRf/TQl/slYKn7C2lz5mJZKmR9v+S7T4818xX1FxfB44sUEwzf
x6eFnlA/flrrfH89bF++bVRO8UZqUurcejW4P1jFM8o5NbIna8S9zChxIwBFVPmh
1Ng3VlCXYFihIdsLlXvegY/ZRr28MDr5J/JDSP5ZPVFDkYxnCeQUlAvJeXa8vZ8N
01LX+JkhquzbPJns8mxnUZ1y9FZL5Zzz4yKZzS0zf+QQqiCDsnEl5eyjwXR/2sO9
ahd/69eJaidwMiYtVLOj3z7qxgEvegxjp72mrYmGkfB88j9wjKly4z2P+wQlqXyz
tJuZCBpJJSpBXe0lKNIjD+kNLhRHzoxQpN3bvNHby7N7P5L1OL2P4Js6yQ8N3fv0
T5D/AHr1aC8wlVd2ULc5101dYpAxsqOZYMsZQ6AoIwXELTInyuNWKSkMZqh1uQZw
EE8jzl5k0l37C4nbxlfxO8xrorGavE/R1NxV2iIqD2+4U80HnRgjaKiA/zy3BAZ0
gPCEd/T/tXVx5glx5Hu9xrpQYFSm3kvoySNsZ7tbrFUQPx5z+kM=
=Dh6C
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
