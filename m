Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C227CE81
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgI2NHw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgI2NHs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 09:07:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D9C061755;
        Tue, 29 Sep 2020 06:07:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so3416846qtp.13;
        Tue, 29 Sep 2020 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vpidMw0HWxX/6cx3RBRN6x4KkgYNc8nMb6h2YX3QMA=;
        b=uEFvEhv19wQsEcRNHH6yVD1084qfg6Pj4nrTxmDW0UfBKThyXC18qxVI0Sr278NBFp
         QhMyZBoNnJN7CcikqikkkmTGVvJu44iJ86pcbmzHUb0zw/d3tE8iwjAxY7iN41XusioE
         Z57maCFo9jO8ZWrtvghGSX7hiF31oVLxYeAbHQ1Dhs+deEqirh3Jc76s+fd2KSP4x/Uv
         5C++V86gALFO/pFhV7lfesfFdDatOdN7S0rs2QTqLkThT71ExAupq6lgjUfn8P1fK3aq
         VasjDadv3sGj9HvjQy322Fqsh3apvisLeqWDA6xlJ2T4iabQJu+ziVeunbzp5/skRIxF
         cqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vpidMw0HWxX/6cx3RBRN6x4KkgYNc8nMb6h2YX3QMA=;
        b=SA9Lax6BETozMKj8Ge0oMAzioWsRVMM0FDhOSULXsJhDUjPZ6q1uE3pAo+tTRmitdo
         GV4JVTpqqZjN9XUjK475Tmr1N02bpeJ73K6Umyr7xsi8LVK4EnID2FUua2FohF4hCni9
         cZVer1eYJA0T4Li4r06DBhGp6aXAzX0a+eWo/MzHSAexFENX/tPZIlqqGoaQ7saQItIt
         A/BVjqhqcndw8Zf9gW82X3VzoHh0gtWaqpFvgi8Z2olOaFh0JcOBbqFx10nfDKcUVYEh
         tDmPHJrbGbPYjExS2/IVZklgS3SCmOdxlajWeqRnkxpZxBbXrafycfR8MXo6FTrK5LxM
         Egqw==
X-Gm-Message-State: AOAM531U/XO4E03yOehS20Nk6raq7YuAxV8FFvWo9ppr5B+xA5Yp8krN
        q4sok2Md6RtBIjA5XefwigI=
X-Google-Smtp-Source: ABdhPJxaE8lTwuOySLwhCQ/9B/ylIcnWpBoFn/x+SwnEU4LMZQcbJzXzO3M60w/YptS92AuCQ3o57w==
X-Received: by 2002:aed:35b2:: with SMTP id c47mr2950755qte.95.1601384866843;
        Tue, 29 Sep 2020 06:07:46 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id w94sm5147990qte.93.2020.09.29.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:07:46 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:07:43 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
Message-ID: <20200929130743.GB4458@shinobu>
References: <cover.1593243079.git.syednwaris@gmail.com>
 <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
 <20200911225417.GA5286@shinobu>
 <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 02:45:18PM +0200, Linus Walleij wrote:
> On Sat, Sep 12, 2020 at 12:54 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Thu, Jul 16, 2020 at 02:49:35PM +0200, Linus Walleij wrote:
> > > Hi Syed,
> > >
> > > sorry for taking so long. I was on vacation and a bit snowed
> > > under by work.
> > >
> > > On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.=
com> wrote:
> > >
> > > > Since this patchset primarily affects GPIO drivers, would you like
> > > > to pick it up through your GPIO tree?
> > >
> > > I have applied the patches to an immutable branch and pushed
> > > to kernelorg for testing (autobuilders will play with it I hope).
> > >
> > > If all works fine I will merge this into my devel branch for v5.9.
> > >
> > > It would be desirable if Andrew gave his explicit ACK on it too.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > Hi Linus,
> >
> > What's the name of the branch with these patches on kernelorg; I'm
> > having trouble finding it?
> >
> > Btw, I'm CCing Andrew as well here because I notice him missing from the
> > CC list earlier for this patchset.
>=20
> IIRC there were complaints from the zeroday build robot so I
> dropped the branch and I am still waiting for a fixed up patch
> series.
>=20
> Yours,
> Linus Walleij

My apologies, I wasn't aware a build error was reported. I'll be happy
to help address the issue with Syed, but I can't seem to find a copy of
the message on <https://lkml.org/lkml/2020/6/27/107> or my email logs.
Do you have a link available to the zeroday build log?

Thanks,

William Breathitt Gray

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl9zMZ8ACgkQhvpINdm7
VJJhJBAAne4+TuZ5ye+zKdwxECRHf9+8DEOtmN37vuRuxtlFqmGEngLWRwKNmzhF
8wwqSulCWUT32f7vjozpkEiT06bcV+zHcmkRu5xb/Bo8KIkc/7F1YQeVH5KxkUn+
u0mmZBnjEWc8oBBjSBArc2XqMRVTnATMlViSbs/Ilax7/d0S6Ywlm3GlioGPJp+E
uj5X8AUEi7Zhtsz3VT2lxNQN20BsyhwY16DnU8n69D4XIeF09vGu7htqsU05a2NW
DtO5MVf9uUH6c637WiTBnwor2SgsR1/5OBZzSdXqu5Gqq43Ol+8s8cUvF1Gr64g/
lKFULCcFfyrj2hSLJrfjkOW6qd1NxsHAWwvSMyGWfM7b7laTaWPV5jHjZuS2Wu7w
lRZdp4N5XibtDSWUxt2Pi6NgnV9C6lgv5Fz4fX/Dd927E/WMcF3q46QutRXT8Mab
z2Z4PEs+RR4A2E5cJv/qRxPID3ZzEINx+LLs1koor9F8av9ve4LH3cy6aQ7k3O7L
jk1cg48c2GSLMH5bDfgJ6xhW7vNvBzjp0SaFlZl6DYiFq7HNISMzIsIXi0t8Yi2t
/FIXL/xih9BzeX3+MDEcgyfJhwh+btrerBF544kHkI61QLaxHLaSvU0Iy/qHmkGg
43o+XzQZeWHrZ/rt4FgDYG+oGL0pJVKVg5C9cQyZUTY+F/ROTeY=
=9zS3
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
