Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C93267636
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgIKWzC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKWzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 18:55:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56373C061573;
        Fri, 11 Sep 2020 15:54:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so11488176qkd.9;
        Fri, 11 Sep 2020 15:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWMxrIUTpLgjVNXNaQ7pp9gIhnKeSDmE1V55I6cdtAM=;
        b=crLyzdC/9dwAbWZ3Ic5ykP4m2BId6gf3W293bIfkO1ebX7A5arPZnrIb7qZdw87imQ
         HbW0a1+VNmRG1RMU9wevX+5e1rL0bJK3AEhriOw3lp+lp6ApzB7vy0uL6ijUDKv8++cC
         jP4O3IC1TiJVdK4gIcRCRT/ACnOI+psFUf8/HZ2l8PIWCJEdZ1IutRwZ62sIZnhEwhWw
         sOtT6YxHVN4KLPGnkFJcTc0ezr9wz+GFcjndS1dp72Wju31OFBJSthlDhkl0z7YLsavJ
         qj2ALdnmGz4ggh1Bxdwme/6PHjPwDiGJ2b6ABSKAoe2/M5rvTsfOA5Z514Dv1GKenEDU
         ozQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWMxrIUTpLgjVNXNaQ7pp9gIhnKeSDmE1V55I6cdtAM=;
        b=j4JYAuqfAL28ZAka3jHzPGz3oz0ytszNSJiJ7UvOWR88bVtzJgFUxguGiewoZhwAQm
         vXHCNUCURSKcurQDm4vRQxh6oFv+3ALzd1F9+QWw/nJtzJJOcEqiXVvBuhMqOPmemOsr
         tM2aLuJj5J/RHYG5XmAjrTg3nj0PBRooUtY5PbZkaooXuBWsxZDcDBrWJosZpUDxUNJg
         nWRs3P4P0SJQ3NQJzkz388sQSUpLS5r500b6vVAu9S37Ta1dzldAV/JyI6K6pxDBffo+
         BLgFhMHbtksX9UMg5ikhzwkf+TKAh28rGEx27nIG3WHRZfOdhZRCNwNARK+aRIdjoJnJ
         jKnw==
X-Gm-Message-State: AOAM5324XpbwAA+4hk1NlPI5SztA+MV3RjtDYF7rvpgmrBhbeMlf/6Ib
        PrfliH4w+H1s6+4L3sI3qtI=
X-Google-Smtp-Source: ABdhPJwzg6HPiHcP9mMdu0JIsPsjeyUmQIHyjp01tLStVmTK7xeyl9LYMu/1ZB72u0hesaAniiU9QQ==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr3570706qkk.456.1599864896536;
        Fri, 11 Sep 2020 15:54:56 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id w6sm4257339qti.63.2020.09.11.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:54:55 -0700 (PDT)
Date:   Fri, 11 Sep 2020 18:54:39 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        akpm@linux-foundation.org,
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
Message-ID: <20200911225417.GA5286@shinobu>
References: <cover.1593243079.git.syednwaris@gmail.com>
 <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 02:49:35PM +0200, Linus Walleij wrote:
> Hi Syed,
>=20
> sorry for taking so long. I was on vacation and a bit snowed
> under by work.
>=20
> On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com>=
 wrote:
>=20
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
>=20
> I have applied the patches to an immutable branch and pushed
> to kernelorg for testing (autobuilders will play with it I hope).
>=20
> If all works fine I will merge this into my devel branch for v5.9.
>=20
> It would be desirable if Andrew gave his explicit ACK on it too.
>=20
> Yours,
> Linus Walleij

Hi Linus,

What's the name of the branch with these patches on kernelorg; I'm
having trouble finding it?

Btw, I'm CCing Andrew as well here because I notice him missing from the
CC list earlier for this patchset.

Thanks,

William Breathitt Gray

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl9cAC8ACgkQhvpINdm7
VJJypRAAxs2Ws4cBWHSC+xWIB7YolKoiCZO9NMeBRMncPL8n3mt80XKtlm9XWG1i
8wYgMDcK5GiKsYy/hGtzLJA5OYoEvOGP3no0nTdYQylGdHlZxFGg2eUTijdnTsDH
NJ1+RDdr7rp6i/ZSmTBYQ/59dQxvxHwsxx41snBD1EUqhx9RL+z2iWDmwJnMZn95
yyqbxxAsEGWQmkLA8ATa1kT4iOAY07xA1aggKjxCmOAWtRIopStLbaLgFhzhiwxz
CLEirmVbm5rBt5ZJ8L/48VZL2kqSzuAs2yClCTgLv6rXVNFxhERXUNcjARWxVghx
EYp3E1+62z7XX8mevdDV/JNzZBRQvoWexAVgIeogK94wyoNlB1+tGvpTmwBRxSOD
++hBdEnnPu7y2O9KghN32xDYtB0JyY4UTm0z9o/hZcmVJetJEYbIPXkGVdhYrvWd
H3eQ2ON9tbTaPI2rQU3c9hnCm/lTPDBDRVSN8X6rb3PdSzhZHEp4R1aTm9QiZrdU
jn5NNi+69aR2rDkTZMogvXE1bnaI3jFag8XtBb5x8HIVtPg0r8SHGlw/f2P6Ea3C
SkAW5npBZv8HigRfGHPhOk8JHwJ4/PcX66gi/+tHeTlmrwRqTBViR6/qjv1MYXYR
2Rcvoza6pKv45K/74PheOwz1W8mRrAlZ0t3ZbGBqE2zSOlMw6vk=
=I8Cv
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
