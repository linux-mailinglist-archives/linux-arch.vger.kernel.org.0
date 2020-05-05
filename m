Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DE1C5A1E
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgEEOyL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729065AbgEEOyL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 10:54:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96FC061A0F;
        Tue,  5 May 2020 07:54:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b188so2507369qkd.9;
        Tue, 05 May 2020 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSocksHYb9zl/JGU+koYObwZ4sleYquXCNFXOruiZU0=;
        b=X43eTslCX/HNNmesYL3Fsx5aXrB31f7o5wrAqV4kmD0074bnyV3S/oxOdYGuTkrU0r
         O/fPkW9VYXn6njRBNjHvblOJh1jq/wrCGmnHWcWdlw40qUH+VmtdR+TvwdxF3TcAZB2x
         V2NcTJuHrq/2UvuAg+1vvFCuhzRk9R9fPP9X3lPGeKgUkjI3ePV/JFfZvFaoo9CK6Hgo
         KTwY9YxA1zIb4Bayqff9RZHp2a9O/kyquhucRegxrqCrqXmlfkA4TcwNaIsCH3PHEGP5
         7QWeuCqRHAZJPC8hGH8s2QiNyQ93fqvw0veotMHke9Rtrc2+bf2AiEEMO1h9Jl/z4W61
         ukhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSocksHYb9zl/JGU+koYObwZ4sleYquXCNFXOruiZU0=;
        b=dCmL7DkDFU13DpGE7NqkNNzYFR9OeOqfyxqtpONejaw2cP40Lxtkm1YfHzSs8QzgXT
         59tgbXjW4y2xV2Cq8N4y33Qmdz8Q9C9oHy0nW/iNz0Rps+4hE1bd1IXhD9XO6/WHy7/K
         d44EGQQHQugPaTQQ+567p8WMfmBvAm4EMY7RQJbuVsMYc1jUrj2nFoptiQyBtxyDMOzo
         sO/U5Lzu1aDBo40/8TCGgRVkU3zxAdOGgiQJxKka6RaFjE9Ep4gtNO1NawcFwHYFumQE
         A5wbZV005qULBwN0IDFHLuz7z4VFagQef6f+V4MSqBpOWVXAYIiBxqMl75YpLZu3uYXE
         ra1g==
X-Gm-Message-State: AGi0PuZvFFMztVwveuia4EgOhdWuzQiXxYNuTJJEkZrSFe5frnPWT2BR
        u8hxQeE/9Bk/g3+nk9afj0g=
X-Google-Smtp-Source: APiQypKHZt/tsl7D6ZxkoYpLuHMfDxw0ggzb9p/Ze2te7v0luNbbLGjLb8VqX9Ukk2YwMWDPUKrTog==
X-Received: by 2002:a05:620a:1f1:: with SMTP id x17mr3990168qkn.330.1588690449917;
        Tue, 05 May 2020 07:54:09 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id n124sm2004093qkn.24.2020.05.05.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:54:09 -0700 (PDT)
Date:   Tue, 5 May 2020 10:53:49 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
Message-ID: <20200505145250.GA5979@shinobu>
References: <cover.1588460322.git.syednwaris@gmail.com>
 <20200504114109.GE185537@smile.fi.intel.com>
 <20200504143638.GA4635@shinobu>
 <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 04:51:56PM +0300, Andy Shevchenko wrote:
> On Mon, May 4, 2020 at 5:41 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> > > On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:
>=20
> ...
>=20
> > > Looking into the last patches where we have examples I still do not s=
ee a
> > > benefit of variadic clump sizes. power of 2 sizes would make sense (a=
nd be
> > > optimized accordingly (64-bit, 32-bit).
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> >
> > There is of course benefit in defining for_each_set_clump with clump
> > sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
> > boundary checks that we know will not occur), but at the very least the
> > variable size bitmap_set_value and bitmap_get_value provide significant
> > benefit for the readability of the gpio-xilinx code:
> >
> >         bitmap_set_value(old, state[0], 0, width[0]);
> >         bitmap_set_value(old, state[1], width[0], width[1]);
> >         ...
> >         state[0] =3D bitmap_get_value(new, 0, width[0]);
> >         state[1] =3D bitmap_get_value(new, width[0], width[1]);
> >
> > These lines are simple and clear to read: we know immediately what they
> > do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
> > to use several bitwise operations for each line; the obfuscation of the
> > code would be an obvious hinderance here.
>=20
> Do I understand correctly that width[0] and width[1] may not be power
> of two and it's actually the case?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

I'm under the impression that width[0] and width[1] are arbitrarily
chosen by the user and could be any integer. I have never used this
hardware so I'm hoping one of the gpio-xilinx or GPIO subsystem
maintainers in this thread will respond with some guidance.

If the values of width[0] and width[1] are restricted to powers of 2,
then I agree that there is no need for generic bitmap_set_value and
bitmap_get_value functions and we can instead use more optimized power
of 2 versions.

William Breathitt Gray

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6xff0ACgkQhvpINdm7
VJI65w/8CTBNaBXzqQ6+AtgyAfLROsibTUPDE3wEs7s/eQkI4dlNN0BzmXwJ6sb6
oMCj6NqzTFksNVUoM6OSjyAGqHZVTJaSfFS97TG4+GrUZm4iWrLMmCipkYEh3qjB
b10DXznOSf6l0IFFbB51QRFRaDu2hJEFYbtCM0hDHYssMXQyI3wMyw/9qCtPwPOC
1l0MYPTFb825gGxAnfNCJ8CODpBXFxbahDtK1gvkaNB7Bdq/BFHyaR4FqMP0QbCC
hoxK7bdMqur6ghYjld9dPRw7iFMXZHt1gD90DMzyXZDl3FcOKlzaAsAz9abgCZ4d
sNHU6i8bRUtdTy66niUDTFHuMKOsWzcHe223zeC6SXp9L00kRzWbSJ4RioncRIEP
X1/Vc+7x62yX/PzECkI+jxhLA8G+wwWuizAxN2VxDDx3ei7XJ4UEfSnNYZwBYlyc
DUhyQZ3UyeID5wDu0XiGGBM8/+Y6mQprrYG7pgsPqAMCMYbcuK58W6cC+uM9ilH9
oNFMz74DRUKaRrK6N/L+ujYD5R+uqVIzq4rwXsT9UOeh4N85uNI/Vjxx5jYO6ICG
B4SGVNo2lwkdvH8XhnCfad+no1HV1XWPNflkedffcfALCxAsxhKF5riw4H1cmZ3B
NbCZv5hfWtY/5opWhWKCVrxAdH512xxHdWBThcAdj8l2NGpZaYM=
=lkYR
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
