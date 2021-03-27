Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2FA34B6FA
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhC0MCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhC0MCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Mar 2021 08:02:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7248C0613B1;
        Sat, 27 Mar 2021 05:02:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha17so3825924pjb.2;
        Sat, 27 Mar 2021 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9GuMh3RIjKhQ71SqoJ2mPU1mliL0r43h9jfwFp6j2R0=;
        b=H8wEFCo2mObk+QHo8ir1liiH9/Q00u/3NcyjOra0PFTlmCjYa+2Ru3+1HkAEmSjiQl
         yU+iw3ZlWp/d0zIc+KvZBcY5dBfMxB9JO+8COxbbOl2apNEwLDUUXz+bGuh9c8sq1VtF
         hW3qNxb5uyY6umazNR+bAlWTW1CnADCScNmMqdg4rQIxPwUwoY6UDeNe2JhSQgOtA5Hw
         0o0QKR43VkpC3ic6Y6z2cBYJymHk3bEE1q90JxEeJ6DwVGOUukfrr64/RNDn5WTfZl1R
         35u69B9ULcl+20Hc5IhEkFEZXkOhcNSP9QATy1Oc3MGViCLuQmrXCTOtsTO9i2DqAzNx
         oqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GuMh3RIjKhQ71SqoJ2mPU1mliL0r43h9jfwFp6j2R0=;
        b=UQi70CF9GSQj2rtJp1He4pz0IBcS5rUT2h1lQxsoIBAZaGDYvsqaUywUM+uV+9aCeS
         qgZ0sfH7czFh14WW6eYiI5Do0iok4pmo8rX93ygTT6ODiYbl65ZzJ4AJ+HUsSQw+TJwi
         0pjAGCWOhcHB4aWrPgyqSHocO4NsWbF86w6WSU0D/TDcVjlJHsXunxPU2v+1pPX+Mp0W
         n6e14lRoWEEEnAOuTxO6nz74VK1gi+iOPJSL+JdV6+YJ/VzFUbSmkb6DXxB4jY0IeHSQ
         J+JBxi+6t5sYM0UIvWjO8gEHcMEg0ta0sNVQVFhYpQoy7adbQ5aNpzc7vLoq9T4Wsh+7
         q2xg==
X-Gm-Message-State: AOAM532mgblbDOMBxZhay8aG52bN5X0B5WQo0X0ICULZg89rjdNyOf0g
        3JKI5IKl9U0BUVUQsRIoL4w=
X-Google-Smtp-Source: ABdhPJx+5NWZYn5Vu21FCM+NuSMKIFHdNigHI0luKxsb/htenfL54ztmoteL6KD9GOL+Y9191rSpNA==
X-Received: by 2002:a17:902:be0c:b029:e6:f007:71d with SMTP id r12-20020a170902be0cb02900e6f007071dmr20153245pls.15.1616846533692;
        Sat, 27 Mar 2021 05:02:13 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id a29sm8999811pfg.130.2021.03.27.05.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 05:02:12 -0700 (PDT)
Date:   Sat, 27 Mar 2021 21:02:04 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value
 and _set_value
Message-ID: <YF8evJTkiBYjnDON@shinobu>
References: <cover.1615038553.git.syednwaris@gmail.com>
 <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <CAHp75VfJ5bGaPkai_adsBoT6=7nS2K8ze0ka3gzZkQARkM5evA@mail.gmail.com>
 <CACG_h5pb0pA+cTNPGircAM3UrV5BGmqgk45LF_9phU_J4FaRyw@mail.gmail.com>
 <CAHp75VfDZbJjCOEGdHc=-D6W8_7m2=CinXj-itwn6hvoVqdWYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U8fuNQh2GYN2BerP"
Content-Disposition: inline
In-Reply-To: <CAHp75VfDZbJjCOEGdHc=-D6W8_7m2=CinXj-itwn6hvoVqdWYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--U8fuNQh2GYN2BerP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2021 at 09:29:26AM +0200, Andy Shevchenko wrote:
> On Saturday, March 27, 2021, Syed Nayyar Waris <syednwaris@gmail.com> wro=
te:
>=20
> > On Fri, Mar 26, 2021 at 11:32 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Sat, Mar 6, 2021 at 4:08 PM Syed Nayyar Waris <syednwaris@gmail.co=
m>
> > wrote:
> > >
> > > > +       bitmap_set_value(old, 64, state[0], 32, 0);
> > > > +       bitmap_set_value(old, 64, state[1], 32, 32);
> > >
> > > Isn't it effectively bitnap_from_arr32() ?
> > >
> > > > +       bitmap_set_value(new, 64, state[0], 32, 0);
> > > > +       bitmap_set_value(new, 64, state[1], 32, 32);
> > >
> > > Ditto.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> >
> > Hi Andy,
> >
> > With bitmap_set_value() we are also specifying the offset (or start)
> > position too. so that the remainder of the array remains unaffected. I
> > think it would not be feasible to use bitmap_from/to_arr32()  here.
>=20
>=20
> You have hard coded start and nbits parameters to 32. How is it not the
> same?

Would these four lines become something like this:

	bitmap_from_arr32(old, state, 64);
	...
	bitmap_from_arr32(new, state, 64);

Sincerely,

William Breathitt Gray

--U8fuNQh2GYN2BerP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBfHrMACgkQhvpINdm7
VJIQVg//bgl/dKfym1/4ndQLg+79vTreGgUHlj9VHg6VMMpGBC5c0d/M5WlBKEiC
jMZAd8mW61HunaeUShz7s9pUh8qbdGGSdNk1DvtAv/A4ouJhUxzmChjXRtd7OhS5
EpgNqEykCO5DJIaloltUabGk4ds5S+L+cFfLHwQsFMrrE+gFdADfiPziDanNVExM
1q+dxTml+/rl6g0L6oX3hnN17Et/p1mggRx1MC8Tnn5dQlEz9MIqT1OY0iKhdiuF
ruiOgQqO7zQWYzQzIH+SehA3wSLu5Y/uiQMEWS1wAWH7Ep44cmhMaj5P+f2tx8Wr
Q7CHT0SF01lgS7MKR48J1ClXGeLL9ae4Iw1t3SS9zl1obUYWdvwWHGaKmFmIzapv
+r+KF4sJFaDT42pSolIfQUQN4qBNZwJbVyU2URxwZEPBvuO9lgGbmZ1TFKNlZvPt
+L27a74cmk/iRKKJtTWLsSnEnGcQ2jLBW4L06Luw0aSDC8YlHFHPB8PbME8V0SR7
5MhOFaoupDeyU4j1rQddZHJg/FvEpu0Vm1pL/8ZWuHKnVm6PzSxkzggmW0dAasrq
bfYIlZqYMWzB+QNoIRZcI1D3BMLwDBsoLx+HjZ0S7fwEfYO1Z+l34pXazdXKGkNN
EbF1yuJQD55Si4RSPDDArnJEKJ/FJ1lxALGklpco/80gCLvtJ8M=
=oqqt
-----END PGP SIGNATURE-----

--U8fuNQh2GYN2BerP--
