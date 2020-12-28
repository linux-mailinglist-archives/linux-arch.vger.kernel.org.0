Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC72E36CA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Dec 2020 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgL1L6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Dec 2020 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgL1L6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Dec 2020 06:58:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA4C061794;
        Mon, 28 Dec 2020 03:58:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so6666927qtq.12;
        Mon, 28 Dec 2020 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U8Y4zcff79mAAXHxbU1KUQj6tU5Sz/KA9ZIKQ+FBrS0=;
        b=R80QhhwAtEWUlOyeF1If1yXZDKXFaGqMPnmNpny40ZnjbrG3DwetkpnrbDBh6kRKqy
         YYFKfrdl+NpNYQOhxhS8Vjccmt8MMpSSBDxFSpctTglMi6fI+rrpQa8K8sR9EVTqRUC5
         VaRgB60sQg1ZCp2OkLz9ro0mH/1GTY17dIG4N91dxb5iB8JDwN1/vV38c87pIna5hGex
         x3cjauJwSipdXQRC2+5VBfMPplkZS/hVur0cpNYtHzVmxT0pJ6h4hhoKg3V6fzfNa1cd
         EcgC+d2aLQW788RIoKFF6UfSCnKcvqcaWAiJ+YXFkFN5fBlJyGIKgWqvzqWQ/SC88nNh
         UcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8Y4zcff79mAAXHxbU1KUQj6tU5Sz/KA9ZIKQ+FBrS0=;
        b=Bq2pFtQBWVs3Rmo265gENEsLNUM7oyEX7P297I7j+1WiMRty4GVcQ40ZncaHMcu8WO
         uXpBbcplX5mYIHaKlzDWYr/HePfyiEmnHYg2ChNoSxpEzPkIzAM8tGruye5uSn2ZAytp
         Ka457SGkUSK9UOADrHlHjNUXeG1wjnEUyQbEdNwKUtEvrYZnIolY7mSkDTVpbIGO9nc5
         pDZ4Rh/rpJ8zvSHRMwiwbAiw7/QUzj8TGbWrshvospLgq77+6KlnkW3oaAjEcl6xD4QJ
         +lxPRXQyE7YxYtYpmvlgRVtZBY6q8msnYORxfv0fe5oBj4ntIReqDUsoz7gTCPDaB5me
         NdHg==
X-Gm-Message-State: AOAM530Tj19VnWZXOxYy3tFFEqiJIKbCd7y1NDBbpqxfZzKDIi2Rj8OQ
        tdVn9ONMKtA4Az0aemaracFEY58JFDXwSw==
X-Google-Smtp-Source: ABdhPJw8iEqOCUKzf/9ZHD87vCS6FtjwSGDcYNSThtu35ycaTW2YZotStOfFgcVAt4u/iaw9q1oVSA==
X-Received: by 2002:ac8:6b59:: with SMTP id x25mr43733692qts.301.1609156690714;
        Mon, 28 Dec 2020 03:58:10 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a3sm22982781qtp.63.2020.12.28.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:58:09 -0800 (PST)
Date:   Mon, 28 Dec 2020 06:58:02 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        bgolaszewski@baylibre.com, yamada.masahiro@socionext.com,
        akpm@linux-foundation.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] gpio: xilinx: Add extra check if sum of widths
 exceed 64
Message-ID: <X+nISkkcqyHf2fTE@shinobu>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <fd642c0843d59a0091931fcf9baa19a9dbb6e2e7.1608963095.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z/sB3ZR0Cgnq1Jxg"
Content-Disposition: inline
In-Reply-To: <fd642c0843d59a0091931fcf9baa19a9dbb6e2e7.1608963095.git.syednwaris@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--z/sB3ZR0Cgnq1Jxg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 26, 2020 at 12:15:20PM +0530, Syed Nayyar Waris wrote:
> Add extra check to see if sum of widths does not exceed 64. If it
> exceeds then return -EINVAL alongwith appropriate error message.
>=20
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Hello Syed,

This change is independent from the rest of this patchset so I recommend
dropping this patch and instead resubmitting it separately as an
independent patch submission.

William Breathitt Gray

> ---
>  drivers/gpio/gpio-xilinx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index d565fbf128b7..c9d740ac711b 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -319,6 +319,12 @@ static int xgpio_probe(struct platform_device *pdev)
> =20
>  	chip->gc.base =3D -1;
>  	chip->gc.ngpio =3D chip->gpio_width[0] + chip->gpio_width[1];
> +
> +	if (chip->gc.ngpio > 64) {
> +		dev_err(&pdev->dev, "invalid configuration: number of GPIO is greater =
than 64");
> +			return -EINVAL;
> +	}
> +
>  	chip->gc.parent =3D &pdev->dev;
>  	chip->gc.direction_input =3D xgpio_dir_in;
>  	chip->gc.direction_output =3D xgpio_dir_out;
> --=20
> 2.29.0
>=20

--z/sB3ZR0Cgnq1Jxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/pyEAACgkQhvpINdm7
VJLsGw/8Cv3JQXOVSwstx+cGE1n13j0ohOymx/WpFxbkcaN/HaqAcR3gV2DD56YG
7UPGf1n5YSUr4JTgfBWq0J475/dk6Q+sPZeOdIcm9sRBHPEdR6ag2C0BqIWSIL+x
bs9k7R2Ar+ctEWyegUD35gTYFbsay3Xapoa+4TLv136Q0WS6+ryyTmokZuqThvxz
qp3gzBWDctL+8TUKnglpVg3Vj2JWn3/11Jo7/cR1QohDMIVH3VB2FRCwJ5kcS/9+
i2lCrziMRzFy6317zHwG5ezb6+BgFy5wiRUtfv1WSC9cV+bLhrclX/Ym1VAO+DBF
ucIv5pLzRkQPd9GwHpQTzrU3OV5dr709TAvByotoyfUKjCEByPM1n4mwuO/7wC4L
DjbBr6nYGY56ZucJkg2dumemG79QFlYbYLLL9bquYCHnyJ1uKFt96cqcMsogA2n0
Jpnla4Ve7JblToYf+FTiPvx0oObTZwL0pjs7sVniWxfSDqRcaIS+adMOrHRoWJD+
mPQ1M1k9e5COTw354uALzkmoWD5sz2VZid2BxBtGxu/fuZE9KvdspvdoXXKFSfWB
VvUaolYVp6PQDQgJdJd7JOLxOuOsZMAF0j00iFH8UfymKNUb50THcCc7RlwJCRyr
Z19eyPdogHQ3ugmC24PddWmzz+RuXQJ/SrMTzNI6JUeodiuHZVA=
=WBuc
-----END PGP SIGNATURE-----

--z/sB3ZR0Cgnq1Jxg--
