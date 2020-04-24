Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA51B7BDF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXQmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXQmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 12:42:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A225C09B046;
        Fri, 24 Apr 2020 09:42:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so10739953qke.12;
        Fri, 24 Apr 2020 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wf3CVS0VYQwb3ndPDAJj/ZT3uZl8XHETdHh1GRJh/Y=;
        b=S+Ad0MHsGpxbYZqYc24itjDPDngEcvWVqvUdZ1FY9amJF+70j1ebE0WZw8Y9TFXI+Z
         blAfnCYu1QOiol7hJxN4/iNvXsCHG3BXYB2IzmLBA42z/URVpfn8tEiENveKV0wx7hk0
         w5Uep0sZLV6fqCScGGnWDqFMc1blPMLj3BqJClamhxFVXlfCWc2LSmofBmZpC/xgs8Gw
         Uo69sydjS5gQs6it+20uzrtNCKDi/Ys98/QfcUKQKGzesNMH7geKDzWdmLdQmvhgrS+P
         NsLeXzBx+puqhNSOpQPCY65PG0IghUGXmbzwSMNyfr+FSKPWUP0RoPHYaaqbJ3cca6Wk
         WYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wf3CVS0VYQwb3ndPDAJj/ZT3uZl8XHETdHh1GRJh/Y=;
        b=mtfcsIRZU8Eb/uymVydPDZFzaoiP7/gvIGIAoVVzzODbeO8uQfOp8h6nwcz4oMOnR2
         cOtFGk5v2Shn4eb6RtRi68Hlih2L8Xadr9I4ItQZxI0a2BuJAAp5AY97jXEGUSN9kmth
         tOxj48v16vailGeU/ajTWDvy80rnh0wpH8j8iDpP6P5zNmvQ8l9c20IyUqKIItmeUMV/
         F3vAfihmJaT8dB0hwbP3TVNKOW3jCfh+E8ujr2kS7oP4Dy8qDjswm1NdrA8AO/+EJFsK
         ctMb0KLWk1ai8GRU2YaFAXa9yPoQYWizOqSIKKbnu1gNdeR2VhXabkw5Q/hVLhFJ9tWb
         DLtg==
X-Gm-Message-State: AGi0PuYnTt7TQppoNakCnxulTqU6/0s9EAEGfInkCb0LaebDZSNogffb
        Lnj38rlP60XkmhkZJwC6WKD+lI5hthgqUw==
X-Google-Smtp-Source: APiQypKOV8hO1j2rVVAZYGqDuc8jDrPV+GuaYN5HTPNPESA+l0Nr3y0rMLbxwZutxW/qdlqq1wZRaw==
X-Received: by 2002:a37:a841:: with SMTP id r62mr9610271qke.135.1587746534483;
        Fri, 24 Apr 2020 09:42:14 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j9sm3986827qkk.99.2020.04.24.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:42:13 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:42:00 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424163904.GA7742@icarus>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
 <20200424150828.GA5034@icarus>
 <20200424163410.GD185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20200424163410.GD185537@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 07:34:10PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 24, 2020 at 11:09:26AM -0400, William Breathitt Gray wrote:
> > On Fri, Apr 24, 2020 at 05:00:58PM +0200, Lukas Wunner wrote:
> > > On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> > > > On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrot=
e:
> > > > > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
>=20
> ...
>=20
> > > > So, this function preserves the behaviour of earlier
> > > > bitmap_set_value8() function and also adds extra functionality to
> > > > that.
> > >=20
> > > Please leave drivers as is which use exclusively 8-bit accesses,
> > > e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
> > > regression if your new generic variant is used.  They work perfectly
> > > fine the way they are and I don't see any benefit this series may have
> > > for them.
> > >=20
> > > If there are other drivers which benefit from the flexibility of your
> > > generic variant then I'm not opposed to changing those.
>=20
> > We can leave of course bitmap_set_value8 alone, but for 8-bit values the
> > difference in latency I suspect is primarily due to the conditional test
> > for the word boundaries. This latency is surely overshadowed by the I/O
> > latency of the GPIO drivers, so I don't think there's much harm in
> > changing those to use the generic function when the bottleneck will not
> > be due to the bitmap_set_value/bitmap_get_value operations.
>=20
> Okay, how many new (non-8-bit) users this will target?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Within this patchset the only non-8-bit users are gpio-thunderx and
gpio-xilinix. The gpio-xilinx has configurable port widths so in some
instances it can behave like the 8-bit users, but not always.

If you want to keep the existing for_each_set_clump8 and related
functions, ignore [PATCH 3/6] and [PATCH 4/6]. That should allow this
patchset to be just an introduction of the new generic functions without
affecting the existing 8-bit users.

William Breathitt Gray

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6jFtgACgkQhvpINdm7
VJJDLQ//dC8JJyJuTyByjULnK5tnjcifhON861BfrOYqbQu20etmMZFIFYkAnre4
7fBxjh7tSk05AecOKxEG6va+XybbFoDuMEVftcIJ/FGf69Gw4ml6lD2PPP/HFiJJ
jh0BnBIwP1B+gbJYtGnW5aFWZWPYkBRbSmN4QEn5TQ5x06mCCxdlSIAh2jPpnlZD
9P67mVq1m59i8/ZcEG2YD8oNwK6WVYB0wYvbO42ixVAJfAmfjD4o0/V+8Lt2K4Gs
sPEVpwJMfxBbLJDYFaQh+CY+32Acujkfo+CwqorKgMghNciLrrH3jwfGPv1vUvL4
/7v26sjRraruBlHMAakvzeV2o5BCyIaUxEX/zXMm7OgLOes7unLpFtrf1PkDBEP0
H/QUQUWomI5Qq2HTjFzMl2zj2ohVQjFdMpLyFZpssgpbOjdO3DXWuLqDMs5Amzp3
4ATQvbwdNwHRMoZp1fs1aCcE0UGXDKH+lc4+yLH0tmVHX+uC0x91D0Pdl2epR+k6
JD86YfHcN9TAG1x35KiA2V3F/2MaPwydqjaGLi7TaGYxjFEV+kLWcT1qjhUrVlCL
ifgrvaI1TfPpYDi0CgsxQFiD6NXGH8CUIK3Y9fB8vMn/qSwuSCCGQSeDfsVRTk9k
YHS7FpJYHJ81HVj3N3UI7XoM+wCvkgrp5X3bVeePTbykiA8EruQ=
=6E0z
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
