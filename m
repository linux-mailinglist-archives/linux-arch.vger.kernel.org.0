Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92182EBB05
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 09:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbhAFIUR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAFIUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 03:20:16 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B1C06134C;
        Wed,  6 Jan 2021 00:19:36 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i5so1757760pgo.1;
        Wed, 06 Jan 2021 00:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/U5C7cSXXWC3ZHRZnRRNCwYTblI/jKmn2rVA8KcxSJM=;
        b=PAK/LCgT64vP6V1vGj+K9eE8e05GbIdrgGgEZmxtg9N74xdClCsYi4QLfwVO+VAirP
         selgESgzICugrADPg0yKx/auIhK2WDP3gl0eF27I++3+Fh0SYUVDggeHigfolqUefZE9
         lqOr2KqLlzUR2ynVavN9HeiK10rIuYs6kGxJdCwd5xKqTxXJW8oxS9ahnjbtL1ytaOeS
         2JqZAZWM7Yy3yEI92RBU1CMNO8b4zwRWU0ikSJL6Q+TZZTAyUXVJPOL+pr+kbtJn5WrM
         IXsY+S1tPmq4QzOVkgmlx7fk53q4At5W1yNZ2Kn4ivgI7L3r8lCzyi5QSMyE8tGQaZIg
         fCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/U5C7cSXXWC3ZHRZnRRNCwYTblI/jKmn2rVA8KcxSJM=;
        b=oo5CK7h0T1YXLVqyafoQnbjOg9cW+w0ehDsJLTV7QqkyOG4/Io9clDXXreMm1cC4KM
         zAkzvPYArML2FajCRXH6XFfkotgG78ZI93X+MXgBWPnu0BQ8aJH/8U8tkQdhGjtph3Ya
         BCpKH54ecuqyimCb+YXiKZ/GfY/AjlzqxFbupVA6GwkaOvVFSNQ3M8n7x7szHFEbZ0bB
         iyDCPQw5JnXsqH/ZY31KKlg35GyijncWdOFUDOO20JYMDfB1tKd/9pGvLD8TTn+AZmFJ
         UEytBOJBPh5m/urJhbXK6pUbIWGpEim/N0nTl7XRLKu1nsvhMslJxhTnXhVAsOkDlVqN
         /D2g==
X-Gm-Message-State: AOAM530AFiCgJxGmMGB3+VRRnGyJhyHlJkYPgUh8xrwnoCJHc1C09JEa
        DOSnF59hxqHDyONDJ0rmpBA=
X-Google-Smtp-Source: ABdhPJzngzNs2PcZJpclKMgPnTHoksW90J8u4KTkMxsH+ek49+eJ14WA6u41OIhjUkvHrYkH0UG1pQ==
X-Received: by 2002:a63:1863:: with SMTP id 35mr3393995pgy.191.1609921176010;
        Wed, 06 Jan 2021 00:19:36 -0800 (PST)
Received: from shinobu (p97026-ipoefx.ipoe.ocn.ne.jp. [153.246.132.25])
        by smtp.gmail.com with ESMTPSA id i25sm1684029pgb.33.2021.01.06.00.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:19:35 -0800 (PST)
Date:   Wed, 6 Jan 2021 17:19:25 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
Message-ID: <X/VyjQUIbqXAeZpe@shinobu>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
 <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com>
 <20210105143921.GL4077@smile.fi.intel.com>
 <CAMpxmJXX5tPBvHRBkgCBK22vUc_FOo2ENUagqOF-opzakkyjrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ygWp8EN/cCl4AW3c"
Content-Disposition: inline
In-Reply-To: <CAMpxmJXX5tPBvHRBkgCBK22vUc_FOo2ENUagqOF-opzakkyjrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ygWp8EN/cCl4AW3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2021 at 08:27:43AM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 5, 2021 at 3:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Jan 05, 2021 at 03:19:13PM +0100, Bartosz Golaszewski wrote:
> > > On Sun, Dec 27, 2020 at 10:27 PM Linus Walleij <linus.walleij@linaro.=
org> wrote:
> > > >
> > > > On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail=
=2Ecom> wrote:
> > > >
> > > > > Since this patchset primarily affects GPIO drivers, would you like
> > > > > to pick it up through your GPIO tree?
> > > >
> > > > Actually Bartosz is handling the GPIO patches for v5.12.
> > > > I tried to merge the patch series before but failed for
> > > > various reasons.
> >
> > > My info on this is a bit outdated - didn't Linus Torvalds reject these
> > > patches from Andrew Morton's PR? Or am I confusing this series with
> > > something else?
> >
> > Linus T. told that it can be done inside GPIO realm. This version tries
> > (badly in my opinion) to achieve that.
> >
>=20
> I'm seeing William and Arnd have some unaddressed issues with patch 1
> (with using __builtin_unreachable()).
>=20
> Admittedly I didn't follow the previous iterations too much so I may
> miss some history behind it. Why do the first two patches go into lib
> if this is supposed to be gpiolib-only?
>=20
> Bartosz

This patchset originally start out as a replacement for
bitmap_get_value8/bitmap_set_value8/for_each_set_clump8, which are used
outside of the GPIO subsystem. Over the course of the revisions, the
scope of this patchset was reduced down and now it's only affecting GPIO
drivers.

You're right that this shouldn't be going into lib anymore because it's
gpiolib-only now. I expect the next revision of this patchset Syed
submits will address that.

William Breathitt Gray

--ygWp8EN/cCl4AW3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/1cnkACgkQhvpINdm7
VJLMPRAAwJEYL1+57OyJLDo0vHssi6pk3Thk0epTN66eEBfuWpVGeQIpwB3oeKjp
N/h5TcXnHUBk7r52tZwPbkm/YoFPbzGCz+3JIOKxIOhnbq3hRjtgPDQOQmBJEMX3
pIhwSPAtCR+NSzOr5W1yXifWhOazAE5RXhLs1XedN60Gx1Zbopyl5XDr2YbFesgJ
IUwzzncM6VXMAU6Gf6mbuLFiWRBjLTFyCAtHHZaBxVPbU6hrUwdqXIAXBmaL/pl+
PBvCiKMXXFCCxJ+hAtTZ+ODXjxO9tRbzvDnYolERDXNK+iO/o5bXoks+Dm/UDROQ
r+mt2yIIur6IF8SU/pFdC0SYr7PTpv1WtT6D+Q4AlXpwG2yP8g/kXhYE+pJF1M3m
jGqhYRf7Li6hC6K9xp/3C1pjTGRBB8lhYQWCHbmqT8IqHo/vMLf3Moqvmt/+hFB8
cGSS+bR7HGQBxJQ58xlwumPCbI0s79wU/HjEcvhQLNZACr7pgNRvHYv9BdXoGN16
CZZKXSnhOuJxgMOWAplY+unyNBqSItcqNXFQLouoToRGZwqp+tPo04IiOP5NSv6v
kxipYcsXAApQSy1wqtLsX0LBso4OPSl3e4eAOFJYanWPy6HhJpZgx7BXlDFoDkG3
lc9Kn4B0BMp8eVH5Qi6gDrMZMIUvrNmWw2XHs4BuRZ5FSpYR0oY=
=37la
-----END PGP SIGNATURE-----

--ygWp8EN/cCl4AW3c--
