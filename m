Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641402E36FD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Dec 2020 13:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgL1MLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Dec 2020 07:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgL1MLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Dec 2020 07:11:45 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B3C06179B;
        Mon, 28 Dec 2020 04:10:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p14so8587860qke.6;
        Mon, 28 Dec 2020 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n3AT6TDkcYOgoqXitcYuftfnSMBgPOjVyKdhjDG6q98=;
        b=J1zm2pYkcwwgV3idpyV51/hd6OLd3cUy1dOzgyZLHS+FqU6Zp9Z7IP4KCwC0pyefgF
         +F8Ua+oVw5ubQlnsCWMOUEdVg6txT62/4DgMs0TyjA/sRNmq7risll2xB6UOF5H5/ICW
         eQ37vjgb0rObWr5xKSgO+8j/aH57V6hjKkMOPxfseNLl0yNnD89Iq5esifqFqeTKYTal
         khpreON5T50lGDPsmPqHQ+WhIDjaT36oOqAiGqnQEA+Qer5DzUCHnqUWGdw1NjWjQ1ZA
         2dF4FIP9TPbwmBZIGP/syv560pQsbvZcOgPFPkEPjscLxqMR4cKfldLuZzlRllycsLdH
         XI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n3AT6TDkcYOgoqXitcYuftfnSMBgPOjVyKdhjDG6q98=;
        b=iG5Z2lJZhHEKFknoRJNDzsRGJujLYNMpWn3kbc1Dz07AY3/fR5lmtZJNzV4cLMaUrO
         MGGR3GytTKWeNALrniEhoKMS7n2oGYbhgxOJzIf7vJ6yjLJfT03NcsG1dYGnL9tFuMlu
         NFhmEzVVOJjVUYoIrfFumiR0GWv4BeC+m9J/hHH9Si++fEesUFtImJ5ApMHuzO17ETqA
         4CmWQczPbljcTLZ9WgOhIY7nLHOrMwKIFkXaAfeqXVQ+zjZCN8fy1YowqgygORA5KZ1i
         ateQEZXtZYhstshr0aWU8RAOw1oabjO4FG52CpKG0q/nL7ogMcLmO9whQMfAV2cPU8sZ
         UKLA==
X-Gm-Message-State: AOAM531ivykVyR4Vdcew1PwjgGMiswpOEjtZjdDDt0hVVTSH0NA2vVmi
        /n6B1C0PCUj7rrOoAM4mynw=
X-Google-Smtp-Source: ABdhPJwxg0ALuDYcBPG8okEWFoPmRVsrFJu61+U6tOu14LDoApF+Zy919bFYomUc2jGdbbUFdQA67w==
X-Received: by 2002:a37:73c6:: with SMTP id o189mr44162144qkc.169.1609157458688;
        Mon, 28 Dec 2020 04:10:58 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id z15sm23611656qkz.103.2020.12.28.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 04:10:57 -0800 (PST)
Date:   Mon, 28 Dec 2020 07:10:55 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/5] clump_bits: Introduce the for_each_set_clump macro
Message-ID: <X+nLT8bMsKJb7nug@shinobu>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <bc7bf5556fce464179550c67fbec121626d08e85.1608963095.git.syednwaris@gmail.com>
 <CAK8P3a35N1TvRQsGt+G52XSx0N4FQe_76pU4sf4EiH3Gq=s66A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jvtA3Yi9DvLrtiYs"
Content-Disposition: inline
In-Reply-To: <CAK8P3a35N1TvRQsGt+G52XSx0N4FQe_76pU4sf4EiH3Gq=s66A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--jvtA3Yi9DvLrtiYs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2020 at 11:03:06PM +0100, Arnd Bergmann wrote:
> On Sat, Dec 26, 2020 at 7:42 AM Syed Nayyar Waris <syednwaris@gmail.com> =
wrote:
> >
> > This macro iterates for each group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to
> > the bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value() and bitmap_set_value() functions are introduced to
> > respectively get and set a value of n-bits in a bitmap memory region.
> > The n-bits can have any size from 1 to BITS_PER_LONG. size less
> > than 1 or more than BITS_PER_LONG causes undefined behaviour.
> > Moreover, during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that word,
> > while the remaining portion is stored in the next higher word. Similar
> > situation occurs while retrieving the value from bitmap.
> >
> > GCC gives warning in bitmap_set_value(): https://godbolt.org/z/rjx34r
> > Add explicit check to see if the value being written into the bitmap
> > does not fall outside the bitmap.
> > The situation that it is falling outside would never be possible in the
> > code because the boundaries are required to be correct before the
> > function is called. The responsibility is on the caller for ensuring the
> > boundaries are correct.
> > The code change is simply to silence the GCC warning messages
> > because GCC is not aware that the boundaries have already been checked.
> > As such, we're better off using __builtin_unreachable() here because we
> > can avoid the latency of the conditional check entirely.
>=20
> Didn't the __builtin_unreachable() end up leading to an objtool
> warning about incorrect stack frames for the code path that leads
> into the undefined behavior? I thought I saw a message from the 0day
> build bot about that and didn't expect to see it again after that.
>=20
> Can you actually measure any performance difference compared
> to BUG_ON() that avoids the undefined behavior? Practically
> all CPUs from the past 20 years have branch predictors that should
> completely hide measurable overhead from this.
>=20
>       Arnd

When I initially recommended using __builtin_unreachable(), I was
anticipating the use of bitmap_set_value() in kernel at large -- so the
possible performance hit from a conditional check was a concern for me.
However, now that we're restricting the scope of bitmap_set_value() to
only the GPIO subsystem, such optimization is no longer a major concern
I feel: gpio-xilinx is the only driver utilizing bitmap_set_value() --
and we know it won't be called in a loop -- so whatever hypothetical
performance hit there might be is inconsequential in the end.

Instead, we should focus on code clarity now. I believe it makes sense
given the new scope of this function to revert back to the earlier
suggestion of passing in and checking the boundary explicitly, and to
remove the __builtin_unreachable() call for now. If bitmap_set_value()
becomes available to the rest of the kernel in the future, we can
reconsider whether or not to use __builtin_unreachable().

William Breathitt Gray

--jvtA3Yi9DvLrtiYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/py08ACgkQhvpINdm7
VJJdtA//cR1YiOviFw5k9cxcAoNFUWhX1LfFPSZzBwGgXnPNVUeQDxCYt9Zo7m48
bEcIumIHZBm0W8tySv4BlQBBSTEiiBFOWKfNHRpLJES2oVBXaYJppe6nMMjHcb0v
5gZKxeFTC+51ZZKw238Csned7xNCUDiYDOjwvFCWuccF0tadOWWKNLqWYpl2LlwX
VcOe64W7/N7Wd2X7zCg/6jwIEu5RNR7I1oSt5DMNCraQjwBBRpKxoTRwb5sT/60x
xWQCJYA7qg3jseisk0n2xyAAh3nA8JWCDx/XF7qnt0+vz37Q7sia3mJKZiL3j2Ad
yTgBDbddWPn2f4qEMpFijgfRRFzJ1jKHwwWG4n086aeC3Ql608QEMU4arJInAzgK
3NxrdoY01mKqNye7dSac9JyvGu1KZLc6QPiZ5//sxdYG91yEnaqf9xpHgft8wobp
5/C2dMFbZjktcFNuepxgLjPNuB+J202lEifiwAMI2sL8h9hCfyWi/U8O9WDuFosY
9KChwHyjV4eG2GMqnIhxAG0bA94xuJNp8avH3+8CAB5mc+05RFw3nwS4fFG4YsbS
a4XY1+wtAkyI2aqpoRa606RlaVvoBRzMWt0LEc2+Fy6Ab/98svG26coD8GcZ/RUN
/ElXNOM7mq1Jl2utzF5v86oTEtK0K1cvz+XDrRqYsYObM1yC+ts=
=uoh3
-----END PGP SIGNATURE-----

--jvtA3Yi9DvLrtiYs--
